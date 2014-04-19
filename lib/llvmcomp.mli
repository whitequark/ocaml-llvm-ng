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

val transl_unit : string -> Llvm.llmodule
val phrase      : Llvm.llmodule -> Cmm.phrase -> (unit -> Llvm.llvalue)
