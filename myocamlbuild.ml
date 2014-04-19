open Ocamlbuild_plugin

let () = (* :( *)
  Unix.putenv "OCAMLPATH" ("/home/whitequark/.opam/4.01.0/lib/llvm/" ^
                           (try ":" ^ (Unix.getenv "OCAMLPATH") with Not_found -> ""))

let () =
  dispatch begin
    function
    | After_rules ->
      flag ["ocaml"; "compile"] (S[A"-w"; A"@5@8@10@11@12@14@23@24@26@29@40"]);
    | _ -> ()
  end
