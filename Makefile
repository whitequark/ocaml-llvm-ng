all:
	ocamlbuild -use-ocamlfind lib_test/run_test.byte

clean:
	ocamlbuild -clean
