let () =
  let lexbuf = Lexing.from_channel stdin in
  let parse  = fun () -> Parsecmm.phrase Lexcmm.token lexbuf in
  let rec parse_all () =
    try
      let phrase = parse () in
      let format = Format.formatter_of_out_channel stdout in
      Printcmm.phrase format phrase;
      parse_all ()
    with End_of_file ->
      ()
  in
  parse_all ()
