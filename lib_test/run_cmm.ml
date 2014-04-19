let () =
  Llvm.enable_pretty_stacktrace ();
  Llvm.install_fatal_error_handler prerr_endline;

  let llmod  = Llvmcomp.transl_unit "caml" in

  let lexbuf = Lexing.from_channel (open_in Sys.argv.(1)) in
  let parse  = fun () -> Parsecmm.phrase Lexcmm.token lexbuf in
  let rec translate rest =
    try
      let phrase = parse () in
      Printcmm.phrase Format.err_formatter phrase;
      Format.pp_print_newline Format.err_formatter ();
      translate ((Llvmcomp.phrase llmod phrase) :: rest)
    with End_of_file ->
      rest
  in
  List.iter (fun f -> ignore (f ())) (translate []);

  let out = open_out Sys.argv.(2) in
  output_string out (Llvm.string_of_llmodule llmod);
  close_out out
