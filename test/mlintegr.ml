(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

external ( + ) : int -> int -> int = "%addint"
external ( - ) : int -> int -> int = "%subint"
external ( > ) : 'a -> 'a -> bool = "%greaterthan"

external float_of_int : int -> float = "%floatofint"
external ( +. ) : float -> float -> float = "%addfloat"
external ( -. ) : float -> float -> float = "%subfloat"
external ( *. ) : float -> float -> float = "%mulfloat"
external ( /. ) : float -> float -> float = "%divfloat"

let square x = x *. x

let integr f low high n =
  let h = (high -. low) /. (float_of_int n) in
  let rec iter x s i =
    if i > 0 then iter (s +. (f x)) (x +. h) (i - 1) else s *. h
  in
  iter low 0.0 n

let test n =
  integr square 0.0 1.0 n

let _ =
  test 10
