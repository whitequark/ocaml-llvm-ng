(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*                             Peter Zotov                             *)
(*                                                                     *)
(*  Copyright 2014 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

open Cmm

let llctx = Llvm.global_context ()

let ()         = Llvm_X86.initialize ()
let lltarget   = Llvm_target.Target.by_triple "x86_64-linux-gnu"
let llmachine  = Llvm_target.TargetMachine.create "x86_64-linux-gnu" lltarget
let lldly      = Llvm_target.TargetMachine.data_layout llmachine

(* names of pinned registers. need to correspond to ocamlcc in llvm *)
let llpinned   =
  match Llvm_target.Target.name lltarget with
  | "x86-64" -> ["caml_exception_pointer"; "caml_young_ptr"]
  | _ -> assert false
let llpinnedty = List.map  (fun _   -> Llvm.pointer_type (Llvm.i8_type llctx)) llpinned
let llpinidx   = List.mapi (fun i _ -> i) llpinned

let llicmp_of_comparison pred =
  match pred with
  | Ceq -> Llvm.Icmp.Eq
  | Cne -> Llvm.Icmp.Ne
  | Clt -> Llvm.Icmp.Slt
  | Cle -> Llvm.Icmp.Sle
  | Cgt -> Llvm.Icmp.Sgt
  | Cge -> Llvm.Icmp.Sge

let llfcmp_of_comparison pred =
  match pred with
  | Ceq -> Llvm.Fcmp.Oeq
  | Cne -> Llvm.Fcmp.One
  | Clt -> Llvm.Fcmp.Olt
  | Cle -> Llvm.Fcmp.Ole
  | Cgt -> Llvm.Fcmp.Ogt
  | Cge -> Llvm.Fcmp.Oge

let lltype_of_mcomp comp =
  match comp with
  | Addr  -> Llvm.pointer_type (Llvm.i8_type llctx)
  | Int   -> Llvm_target.DataLayout.intptr_type llctx lldly
  | Float -> Llvm.double_type llctx

let lltype_of_mty ty =
  match ty with
  | [|comp|] -> lltype_of_mcomp comp
  | _        -> Llvm.struct_type llctx (Array.map lltype_of_mcomp ty)

let load_store_params memory_chunk =
  let intptr_size  = Llvm_target.DataLayout.pointer_size lldly in
  let align   llty = llty, Llvm_target.DataLayout.preferred_align llty lldly in
  let integer size = Llvm.integer_type llctx size in
  match memory_chunk with
  | Byte_unsigned | Byte_signed -> align (integer 1)
  | Sixteen_unsigned | Sixteen_signed -> align (integer 2)
  | Thirtytwo_unsigned | Thirtytwo_signed -> align (integer 4)
  | Word -> align (Llvm.pointer_type (integer intptr_size))
  | Single -> align (Llvm.float_type llctx)
  | Double -> align (Llvm.double_type llctx)
  | Double_u -> Llvm.double_type llctx, intptr_size

let infer fun_args expr =
  let env = Hashtbl.create 16 in
  List.iter (fun (id, ty) -> Hashtbl.add env id (lltype_of_mty ty)) fun_args;
  let catches = Hashtbl.create 16 in
  let rec llty_of_expr expr =
    let multi lltys =
      match List.filter ((<>) (Llvm.void_type llctx)) lltys with
      | []          -> Llvm.void_type llctx
      | [llty]      -> llty
      | llty::lltys -> assert (List.for_all ((=) llty) lltys); llty
    in
    match expr with
    | Cop (op, _) ->
      begin match op with
      | Capply(ty, _) -> lltype_of_mty ty
      | Cextcall(s, ty, alloc, _) -> lltype_of_mty ty
      | Cload c ->
        begin match c with
        | Word -> lltype_of_mcomp Addr
        | Single | Double | Double_u -> lltype_of_mcomp Float
        | _ -> lltype_of_mcomp Int
        end
      | Calloc -> lltype_of_mcomp Addr
      | Cstore c -> Llvm.void_type llctx
      | Caddi | Csubi | Cmuli | Cdivi | Cmodi
      | Cand | Cor | Cxor | Clsl | Clsr | Casr
      | Ccmpi _ | Ccmpa _ | Ccmpf _ -> lltype_of_mcomp Int
      | Cadda | Csuba -> lltype_of_mcomp Addr
      | Cnegf | Cabsf | Caddf | Csubf | Cmulf | Cdivf -> lltype_of_mcomp Float
      | Cfloatofint -> lltype_of_mcomp Float
      | Cintoffloat -> lltype_of_mcomp Int
      | Craise _ -> Llvm.void_type llctx
      | Ccheckbound _ -> Llvm.void_type llctx
      end
    | Cconst_int _ -> lltype_of_mcomp Int
    | Cconst_natint _ -> lltype_of_mcomp Int
    | Cconst_float _ -> lltype_of_mcomp Float
    | Cconst_symbol _ -> lltype_of_mcomp Addr
    | Cconst_pointer _ -> lltype_of_mcomp Addr
    | Cconst_natpointer _ -> lltype_of_mcomp Addr
    | Cvar var -> Hashtbl.find env var
    | Clet (var, expr, body) ->
      Hashtbl.add env var (llty_of_expr expr);
      let llty = llty_of_expr body in
      Hashtbl.remove env var;
      llty
    | Cassign (id, expr) ->
      let llty = llty_of_expr expr in
      assert (llty = (Hashtbl.find env id));
      Llvm.void_type llctx
    | Ctuple [] -> Llvm.void_type llctx
    | Ctuple _ -> assert false
    | Csequence (lhs, rhs) ->
      ignore (llty_of_expr lhs);
      llty_of_expr rhs
    | Cifthenelse (pred, iftrue, iffalse) ->
      ignore (llty_of_expr pred);
      multi [llty_of_expr iftrue; llty_of_expr iffalse]
    | Cswitch (pred, _, dests) ->
      ignore (llty_of_expr pred);
      multi (List.map llty_of_expr (Array.to_list dests))
    | Cloop body -> ignore (llty_of_expr body); Llvm.void_type llctx
    | Ccatch (id, vars, body, handler) ->
      let llbodyty = llty_of_expr body in
      List.iter2 (Hashtbl.add env) vars (Hashtbl.find catches id);
      let llty = multi [llbodyty; llty_of_expr handler] in
      List.iter (Hashtbl.remove env) vars;
      llty
    | Cexit (id, vars) ->
      let llvarsty = List.map llty_of_expr vars in
      begin try
        let llvarsty' = Hashtbl.find catches id in
        assert (llvarsty = llvarsty')
      with Not_found ->
        Hashtbl.add catches id llvarsty;
      end;
      Llvm.void_type llctx
    | Ctrywith (body, var, handler) ->
      Hashtbl.add env var (lltype_of_mcomp Addr);
      let llty = multi [llty_of_expr body; llty_of_expr handler] in
      Hashtbl.remove env var;
      llty
  in
  llty_of_expr expr

(* See doc/cmm.md first.

   Note that while let bindings are immutable, we model them as mutable
   cells anyway. This is because the way Cmm represents control flow is
   weird, and compiling them directly to phis would require us to reproduce
   half of an SSA transform. Hence, it is left to LLVM's mem2reg. *)
let rec compile llmod llfun fun_args fun_body =
  let build_trap =
    let llblock = ref None in fun () ->
    match !llblock with
    | None ->
      let llbuilder = Llvm.builder llctx in
      let llblock'  = Llvm.append_block llctx "trap" llfun in
      Llvm.position_at_end llblock' llbuilder;
      let lltrapty  = Llvm.function_type (Llvm.void_type llctx) [||] in
      let lltrap    = Llvm.declare_function "llvm.trap" lltrapty llmod in
      (* Could be skipped for "Release" builds *)
      ignore (Llvm.build_call lltrap [||] "" llbuilder);
      ignore (Llvm.build_unreachable llbuilder);
      llblock := Some llblock';
      llblock'
    | Some llblock' -> llblock'
  in
  let build_phi incoming name llbuilder =
    let incoming' = incoming |> List.filter (fun (llval, _) ->
                      Llvm.classify_type (Llvm.type_of llval) <> Llvm.TypeKind.Void) in
    match incoming' with
    | []         -> Llvm.undef (Llvm.void_type llctx)
    | [llval, _] -> llval
    | incoming'  -> Llvm.build_phi incoming' name llbuilder
  in
  (* create cells for arguments *)
  let env       = ((Hashtbl.create 16) : (string, Llvm.llvalue) Hashtbl.t) in
  let catches   = Hashtbl.create 16 in
  let llbuilder = Llvm.builder llctx in
  Llvm.position_at_end (Llvm.append_block llctx "entry" llfun) llbuilder;
  List.iter2 (fun name llarg ->
      if List.exists ((=) name) llpinned then
        Llvm.set_value_name ("pinned." ^ name) llarg
      else
        Llvm.set_value_name ("arg." ^ name) llarg;
      let llalloca = Llvm.build_alloca (Llvm.type_of llarg) ("alloca." ^ name) llbuilder in
      ignore (Llvm.build_store llarg llalloca llbuilder);
      Hashtbl.add env name llalloca)
    (llpinned @ (List.map (fun (id, _) -> Ident.name id) fun_args))
    (Array.to_list (Llvm.params llfun));
  (* translate body *)
  let rec llvalue_of_expr expr =
    let unop mcomp f name args =
      match args with
      | [arg] ->
        let arg' = Llvm.build_pointercast (llvalue_of_expr arg) (lltype_of_mcomp mcomp) "" llbuilder in
        f arg' name llbuilder
      | _ -> assert false
    in
    let binop mcomp f name args =
      match args with
      | [lhs; rhs] ->
        let lhs' = Llvm.build_pointercast (llvalue_of_expr lhs) (lltype_of_mcomp mcomp) "" llbuilder in
        let rhs' = Llvm.build_pointercast (llvalue_of_expr rhs) (lltype_of_mcomp mcomp) "" llbuilder in
        f lhs' rhs' name llbuilder
      | _ -> assert false
    in
    match expr with
    (* Constants *)
    | Cconst_int const ->
      Llvm.const_int (lltype_of_mcomp Int) const
    | Cconst_natint const ->
      Llvm.const_of_int64 (lltype_of_mcomp Int) (Int64.of_nativeint const) (*signed:*)true
    | Cconst_pointer const ->
      let integer = Llvm.const_int (lltype_of_mcomp Int) const in
      Llvm.build_inttoptr integer (lltype_of_mcomp Addr) "" llbuilder
    | Cconst_natpointer const ->
      let integer = Llvm.const_of_int64 (lltype_of_mcomp Int)
                                        (Int64.of_nativeint const) (*signed:*)true in
      Llvm.build_inttoptr integer (lltype_of_mcomp Addr) "" llbuilder
    | Cconst_float const ->
      Llvm.const_float_of_string (lltype_of_mcomp Float) const
    | Cconst_symbol sym ->
      let global =
        begin match Llvm.lookup_global sym llmod with
        | Some g -> g
        | None   ->
          begin match Llvm.lookup_function sym llmod with
          | Some f -> f
          | None   -> Llvm.declare_global (lltype_of_mcomp Addr) sym llmod
          end
        end
      in
      Llvm.const_pointercast global (lltype_of_mcomp Addr)
    | Ctuple [] ->
      Llvm.const_int (lltype_of_mcomp Int) 1
    | Ctuple _ -> assert false
    (* Integer ops *)
    | Cop (Caddi, args) -> binop Int Llvm.build_add  "addi" args
    | Cop (Csubi, args) -> binop Int Llvm.build_sub  "subi" args
    | Cop (Cmuli, args) -> binop Int Llvm.build_mul  "muli" args
    | Cop (Cdivi, args) -> binop Int Llvm.build_sdiv "divi" args
    | Cop (Cmodi, args) -> binop Int Llvm.build_srem "modi" args
    | Cop (Ccmpi pred, args) -> binop Int (Llvm.build_icmp (llicmp_of_comparison pred)) "cmpi" args
    (* Logical ops *)
    | Cop (Cand,  args) -> binop Int Llvm.build_and  "and" args
    | Cop (Cor,   args) -> binop Int Llvm.build_or   "or"  args
    | Cop (Cxor,  args) -> binop Int Llvm.build_xor  "xor" args
    | Cop (Clsl,  args) -> binop Int Llvm.build_shl  "lsl" args
    | Cop (Clsr,  args) -> binop Int Llvm.build_lshr "lsr" args
    | Cop (Casr,  args) -> binop Int Llvm.build_ashr "asr" args
    (* Floating-point ops *)
    | Cop (Caddf, args) -> binop Float Llvm.build_fadd "addf" args
    | Cop (Csubf, args) -> binop Float Llvm.build_fsub "subf" args
    | Cop (Cmulf, args) -> binop Float Llvm.build_fmul "mulf" args
    | Cop (Cdivf, args) -> binop Float Llvm.build_fdiv "divf" args
    | Cop (Cnegf, args) -> unop  Float Llvm.build_fneg "negf" args
    | Cop (Ccmpf pred, args) -> binop Float (Llvm.build_fcmp (llfcmp_of_comparison pred)) "cmpf" args
    | Cop (Cabsf, [arg]) ->
      let llfabsty = Llvm.function_type (Llvm.double_type llctx) [|Llvm.double_type llctx|] in
      let llfabs   = Llvm.declare_function "llvm.fabs.f64" llfabsty llmod in
      Llvm.build_call llfabs [|llvalue_of_expr arg|] "absf" llbuilder
    | Cop (Cfloatofint, [arg]) ->
      Llvm.build_sitofp (llvalue_of_expr arg) (lltype_of_mcomp Float) "floatofint" llbuilder
    | Cop (Cintoffloat, [arg]) ->
      Llvm.build_fptosi (llvalue_of_expr arg) (lltype_of_mcomp Int) "intoffloat" llbuilder
    | Cop ((Cintoffloat | Cfloatofint | Cabsf), _) -> assert false
    (* Pointer ops *)
    | Cop ((Cadda | Csuba) as op, [base; disp]) ->
      let llvalue = llvalue_of_expr base in
      let lldisp, name =
        match op with
        | Cadda -> llvalue_of_expr disp,                               "adda"
        | Csuba -> Llvm.build_neg (llvalue_of_expr disp) "" llbuilder, "suba"
        | _ -> assert false
      in
      Llvm.build_in_bounds_gep llvalue [|lldisp|] name llbuilder
    | Cop (Ccmpa pred, [lhs; rhs]) ->
      let lhs' = Llvm.build_ptrtoint (llvalue_of_expr lhs) (lltype_of_mcomp Int)
                                     "cmpa.lhs" llbuilder in
      let rhs' = Llvm.build_ptrtoint (llvalue_of_expr rhs) (lltype_of_mcomp Int)
                                     "cmpa.rhs" llbuilder in
      Llvm.build_icmp (llicmp_of_comparison pred) lhs' rhs' "cmpa" llbuilder
    | Cop ((Cadda | Csuba | Ccmpa _), _) -> assert false
    (* Load/store *)
    | Cop (Cload ty, [addr]) ->
      let llty, align = load_store_params ty in
      let lladdr   = llvalue_of_expr addr in
      let lladdr'  = Llvm.build_bitcast lladdr (Llvm.pointer_type llty) "load.addr" llbuilder in
      let llvalue  = Llvm.build_load lladdr' "load" llbuilder in
      begin match ty with
      | Word                       -> llvalue
      | Single | Double | Double_u -> Llvm.build_fpext llvalue (lltype_of_mcomp Float) "" llbuilder
      | _                          -> Llvm.build_sext llvalue (lltype_of_mcomp Int) "" llbuilder
      end
    | Cop (Cstore ty, [addr; value]) ->
      let llty, align = load_store_params ty in
      let llvalue  = llvalue_of_expr value in
      let llvalue' =
        match ty with
        | Word                       -> Llvm.build_bitcast llvalue llty "" llbuilder
        | Single | Double | Double_u -> Llvm.build_fptrunc llvalue llty "" llbuilder
        | _                          -> Llvm.build_trunc llvalue llty "" llbuilder
      in
      let lladdr  = llvalue_of_expr addr in
      let lladdr' = Llvm.build_bitcast lladdr (Llvm.pointer_type llty) "store.addr" llbuilder in
      Llvm.build_store llvalue' lladdr' llbuilder
    | Cop ((Cload _ | Cstore _), _) -> assert false
    (* Bindings *)
    | Cvar id ->
      let name = Ident.name id in
      Llvm.build_load (Hashtbl.find env name) ("local." ^ name) llbuilder
    | Clet (id, expr, body) ->
      let name     = Ident.name id in
      let llvalue  = llvalue_of_expr expr in
      let llalloca = Llvm.build_alloca (Llvm.type_of llvalue)
                                       ("alloca." ^ name) llbuilder in
      ignore (Llvm.build_store llvalue llalloca llbuilder);
      Hashtbl.add env name llalloca;
      let result = llvalue_of_expr body in
      Hashtbl.remove env name;
      result
    | Cassign (id, expr) ->
      let name   = Ident.name id in
      let llexpr = llvalue_of_expr expr in
      Llvm.build_store llexpr (Hashtbl.find env name) llbuilder
    (* Control flow *)
    | Csequence (lhs, rhs) ->
      ignore (llvalue_of_expr lhs);
      llvalue_of_expr rhs
    | Cifthenelse (pred, iftrue, iffalse) ->
      let llentry    = Llvm.insertion_block llbuilder in
      let llexit     = Llvm.append_block llctx "if.exit" llfun in
      (* Compile iftrue *)
      let lliftrue   = Llvm.append_block llctx "if.true" llfun in
      Llvm.position_at_end lliftrue llbuilder;
      let lltrueret  = llvalue_of_expr iftrue in
      let lliftrue'  = Llvm.insertion_block llbuilder in
      if Llvm.block_terminator lliftrue' = None then
        ignore (Llvm.build_br llexit llbuilder);
      (* Compile iffalse *)
      let lliffalse  = Llvm.append_block llctx "if.false" llfun in
      Llvm.position_at_end lliffalse llbuilder;
      let llfalseret = llvalue_of_expr iffalse in
      let lliffalse' = Llvm.insertion_block llbuilder in
      if Llvm.block_terminator lliffalse' = None then
        ignore (Llvm.build_br llexit llbuilder);
      (* Compile entry *)
      Llvm.position_at_end llentry llbuilder;
      let llcond     = llvalue_of_expr pred in
      let llcond'    = Llvm.build_trunc llcond (Llvm.i1_type llctx) "" llbuilder in
      ignore (Llvm.build_cond_br llcond' lliftrue lliffalse llbuilder);
      (* Compile exit *)
      Llvm.position_at_end llexit llbuilder;
      build_phi [lltrueret, lliftrue'; llfalseret, lliffalse'] "if.value" llbuilder
    | Cloop body ->
      let llbody       = Llvm.append_block llctx "loop" llfun in
      ignore (Llvm.build_br llbody llbuilder);
      Llvm.position_at_end llbody llbuilder;
      ignore (llvalue_of_expr body);
      begin match Llvm.block_terminator (Llvm.insertion_block llbuilder) with
      | None   -> Llvm.build_br llbody llbuilder
      | Some i -> i
      end
    | Ccatch (id, vars, body, handler) ->
      let llbody       = Llvm.insertion_block llbuilder in
      let llhandler    = Llvm.append_block llctx (Printf.sprintf "catch.%d.with" id) llfun in
      let llexit       = Llvm.append_block llctx (Printf.sprintf "catch.%d.exit" id) llfun in
      (* Compile handler *)
      Llvm.position_at_end llhandler llbuilder;
      let llphis =
        List.mapi (fun phiid var ->
            let llphi = Llvm.build_phi [] (Printf.sprintf "catch.%d.value.%d" id phiid)
                                       llbuilder in
            Hashtbl.add env (Ident.name var) llphi;
            llphi)
          vars
      in
      Hashtbl.add catches id (llphis, llhandler);
      let llhandlerret = llvalue_of_expr handler in
      let llhandler'   = Llvm.insertion_block llbuilder in
      if Llvm.block_terminator llhandler' = None then
        ignore (Llvm.build_br llexit llbuilder);
      (* Compile body *)
      Llvm.position_at_end llbody llbuilder;
      let llbodyret    = llvalue_of_expr body in
      let llbody'      = Llvm.insertion_block llbuilder in
      if Llvm.block_terminator llbody' = None then
        ignore (Llvm.build_br llexit llbuilder);
      (* Prepare exit *)
      Llvm.position_at_end llexit llbuilder;
      build_phi [llbodyret, llbody'; llhandlerret, llhandler']
                (Printf.sprintf "catch.%d.value" id) llbuilder
    | Cexit (id, vars) ->
      let llphis, llhandler = Hashtbl.find catches id in
      let llblock      = Llvm.insertion_block llbuilder in
      List.iter2 (fun llphi var ->
          Llvm.add_incoming (llvalue_of_expr var, llblock) llphi)
        llphis vars;
      Llvm.build_br llhandler llbuilder
    | Cswitch (pred, cases, dests) ->
      assert ((Array.length cases) = (Array.length dests));
      let llswitch   = Llvm.build_switch (llvalue_of_expr pred) (build_trap ())
                                       (Array.length cases) llbuilder in
      let llexit     = Llvm.append_block llctx "switch.exit" llfun in
      Llvm.position_at_end llexit llbuilder;
      let llexitret  = Llvm.build_phi [] "switch.value" llbuilder in
      List.iter2 (fun case dest ->
          let lldest  = Llvm.append_block llctx (Printf.sprintf "switch.case.%d" case) llfun in
          Llvm.position_at_end lldest llbuilder;
          let llvalue = llvalue_of_expr dest in
          let lldest' = Llvm.insertion_block llbuilder in
          Llvm.add_case llswitch (Llvm.const_int (lltype_of_mcomp Int) case) lldest;
          Llvm.add_incoming (llvalue, lldest') llexitret)
        (Array.to_list cases) (Array.to_list dests);
      llexitret
    (* Function calls *)
    | Cop (Capply (retty, dbg), fn :: args) ->
      let llargs   = List.map llvalue_of_expr args in
      let llretty  = Llvm.struct_type llctx (Array.of_list (llpinnedty @ [lltype_of_mty retty])) in
      let llargsty = llpinnedty @ (List.map Llvm.type_of llargs) in
      let llfunty  = Llvm.function_type llretty (Array.of_list llargsty) in
      let llfun    = Llvm.build_bitcast (llvalue_of_expr fn) (Llvm.pointer_type llfunty)
                                        "apply.fn" llbuilder in
      let llargs'  = (List.map (fun name ->
                          Llvm.build_load (Hashtbl.find env name) ("pass."^name) llbuilder)
                        llpinned) @ llargs in
      let llcall   = Llvm.build_call llfun (Array.of_list llargs') "" llbuilder in
      Llvm.set_instruction_call_conv (*ocamlcc*)16 llcall;
      Llvm.set_tail_call true llcall;
      List.iteri (fun idx name ->
          let llvalue = Llvm.build_extractvalue llcall idx ("reload."^name) llbuilder in
          ignore (Llvm.build_store llvalue (Hashtbl.find env name) llbuilder))
        llpinned;
      Llvm.build_extractvalue llcall (List.length llpinned) "apply" llbuilder
    | Cop (Cextcall (prim, ty, does_alloc, dbg), args) ->
      assert false
    | Cop (Capply _, _) -> assert false
    (* Allocation *)
    | Cop (Calloc, args) ->
      let llallocfn =
        match Llvm.lookup_function "caml_allocN" llmod with
        | Some fn -> fn
        | None ->
          let llallocfnty = Llvm.function_type (lltype_of_mcomp Addr) [|lltype_of_mcomp Int|] in
          let llallocfn   = Llvm.declare_function "caml_allocN" llallocfnty llmod in
          Llvm.set_function_call_conv (*preserve_allcc*)15 llallocfn;
          llallocfn
      in
      let llargs    = List.map llvalue_of_expr args in
      let llallocty = Llvm.struct_type llctx (Array.of_list
                                              (List.map Llvm.type_of llargs)) in
      let llsize    = Llvm_target.DataLayout.store_size llallocty lldly in
      let llsize'   = Llvm.const_of_int64 (lltype_of_mcomp Int) llsize true in
      let llalloc   = Llvm.build_call llallocfn [|llsize'|] "alloc" llbuilder in
      let llalloc'  = Llvm.build_bitcast llalloc (Llvm.pointer_type llallocty) "" llbuilder in
      List.iter2 (fun expr (idx, llvalue) ->
          let llfield  = Llvm.build_struct_gep llalloc' idx
                                               (Printf.sprintf "field.%d" idx) llbuilder in
          ignore (Llvm.build_store llvalue llfield llbuilder))
        args (List.mapi (fun idx llvalue -> idx, llvalue) llargs);
      let llbody    = Llvm.build_struct_gep llalloc' 1 "" llbuilder in
      Llvm.build_bitcast llbody (lltype_of_mcomp Addr) "alloc.body" llbuilder
    (* Exception handling *)
    | Ctrywith (_, _, _) ->
      assert false
    | Cop (Craise dbg, args) ->
      assert false
    | Cop (Ccheckbound dbg, args) ->
      assert false
  in
  let llresult = llvalue_of_expr fun_body in
  let llreturn =
    List.fold_left2 (fun llpack name idx ->
        let llreg = Llvm.build_load (Hashtbl.find env name) ("reload." ^ name) llbuilder in
        Llvm.build_insertvalue llpack llreg idx "" llbuilder)
      (Llvm.undef (Llvm.struct_type llctx (Array.of_list (llpinnedty @ [Llvm.type_of llresult]))))
      llpinned llpinidx
  in
  let llreturn = Llvm.build_insertvalue llreturn llresult (List.length llpinned) "" llbuilder in
  ignore (Llvm.build_ret llreturn llbuilder)

let fundecl llmod {fun_name; fun_args; fun_body} =
  let llargsty  = List.map (fun (id, ty) -> lltype_of_mty ty) fun_args in
  let llargsty' = Array.of_list (llpinnedty @ llargsty) in
  let llretty   = Llvm.struct_type llctx (Array.of_list (llpinnedty @ [infer fun_args fun_body])) in
  let llfunty   = Llvm.function_type llretty llargsty' in
  let llfun     = Llvm.declare_function fun_name llfunty llmod in
  Llvm.set_function_call_conv (*ocamlcc*)16 llfun;
  Llvm.set_gc (Some "ocaml") llfun;
  fun () ->
    compile llmod llfun fun_args fun_body;
    llfun

let lltype_of_data_item item =
  match item with
  | Cdefine_label _ | Cdefine_symbol _ | Cglobal_symbol _ | Calign _ ->
    assert false
  | Cint8  _  -> Llvm.i8_type  llctx
  | Cint16 _  -> Llvm.i16_type llctx
  | Cint32 _  -> Llvm.i32_type llctx
  | Cint   _  -> lltype_of_mcomp Int
  | Csingle _ -> Llvm.float_type llctx
  | Cdouble _ -> Llvm.double_type llctx
  | Csymbol_address _ | Clabel_address _ ->
    lltype_of_mcomp Addr
  | Cstring s -> Llvm.array_type (Llvm.i8_type llctx) (String.length s)
  | Cskip len -> Llvm.array_type (Llvm.i8_type llctx) len

let lltype_of_data items =
  let len, items =
    List.fold_left (fun (len, lltys) item ->
        match item with
        | Cdefine_label _ | Cdefine_symbol _ | Cglobal_symbol _ ->
          len, lltys
        | Calign size ->
          if len mod size = 0 then len, lltys
          else let skip_len = size - len mod size in
               len + skip_len, lltype_of_data_item (Cskip skip_len) :: lltys
        | _ ->
          let llty = lltype_of_data_item item in
          len + (Int64.to_int (Llvm_target.DataLayout.store_size llty lldly)),
            lltype_of_data_item item :: lltys)
      (0, []) items
  in
  Llvm.packed_struct_type llctx (Array.of_list (List.rev items))

let llvalue_of_data llmod items =
  let _, lldata =
    List.fold_left (fun (len, lldata) item ->
        let llitem =
          match item with
          | Cdefine_label _ | Cdefine_symbol _ | Cglobal_symbol _ -> None
          | Calign size ->
            if len mod size = 0 then None
            else let skip_len = size - len mod size in
                 Some (Llvm.const_null (Llvm.array_type (Llvm.i8_type llctx) skip_len))
          | Cint8  c  -> Some (Llvm.const_int (Llvm.i8_type  llctx) c)
          | Cint16 c  -> Some (Llvm.const_int (Llvm.i16_type llctx) c)
          | Cint32 c  -> Some (Llvm.const_of_int64 (lltype_of_mcomp Int) (Int64.of_nativeint c) true)
          | Cint   c  -> Some (Llvm.const_of_int64 (lltype_of_mcomp Int) (Int64.of_nativeint c) true)
          | Csingle c -> Some (Llvm.const_float_of_string (Llvm.float_type llctx)  c)
          | Cdouble c -> Some (Llvm.const_float_of_string (Llvm.double_type llctx) c)
          | Csymbol_address sym ->
            begin match Llvm.lookup_global sym llmod with
            | Some gv -> Some gv
            | None ->
              match Llvm.lookup_function sym llmod with
              | Some fn -> Some (Llvm.const_bitcast fn (lltype_of_mcomp Addr))
              | None    -> assert false
            end
          | Clabel_address label ->
            begin match Llvm.lookup_global (Printf.sprintf "label.%d" label) llmod with
            | Some gv -> Some gv
            | None    -> assert false
            end
          | Cstring s -> Some (Llvm.const_string llctx s)
          | Cskip len -> Some (Llvm.const_null (Llvm.array_type (Llvm.i8_type llctx) len))
        in
        match llitem with
        | Some llitem ->
          let size = Llvm_target.DataLayout.store_size (Llvm.type_of llitem) lldly in
          let len' = len + (Int64.to_int size) in
          len', llitem :: lldata
        | None -> len, lldata)
      (0, []) items
  in
  Llvm.const_packed_struct llctx (Array.of_list (List.rev lldata))

let data llmod decl =
  let llty   = lltype_of_data decl in
  let lldecl = Llvm.declare_global llty "" llmod in
  Llvm.set_linkage Llvm.Linkage.Private lldecl;
  (* pull out interior pointers *)
  ignore (List.fold_left (fun (externals, idx) item ->
      let name =
        match item with
        | Cdefine_label label -> Some (Printf.sprintf "label.%d" label)
        | Cdefine_symbol sym  -> Some sym
        | _ -> None
      in
      match name, item with
      | Some name, _ ->
        let lllabel = Llvm.declare_global (lltype_of_mcomp Addr) name llmod in
        if not (List.exists ((=) name) externals) then
          Llvm.set_linkage Llvm.Linkage.Private lldecl;
        let llidxs  = [|Llvm.const_int (Llvm.i32_type llctx) 0;
                        Llvm.const_int (Llvm.i32_type llctx) idx|] in
        let llptr   = Llvm.const_in_bounds_gep lldecl llidxs in
        let llptr'  = Llvm.const_bitcast llptr (lltype_of_mcomp Addr) in
        Llvm.set_initializer llptr' lllabel;
        externals, idx
      | None, Cglobal_symbol sym -> sym :: externals, idx
      | None, _ -> externals, idx + 1)
    ([], 0) decl);
  fun () ->
    Llvm.set_initializer (llvalue_of_data llmod decl) lldecl;
    lldecl

let transl_unit name =
  let llmod = Llvm.create_module llctx name in
  Llvm.set_data_layout (Llvm_target.DataLayout.as_string lldly) llmod;
  Llvm.set_target_triple (Llvm_target.TargetMachine.triple llmachine) llmod;
  llmod

let phrase llmod phr =
  match phr with
  | Cfunction d -> fundecl llmod d
  | Cdata d     -> data llmod d
