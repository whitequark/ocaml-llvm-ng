test: all
	./run_cmm.native test/integr.cmm test/integr.ll

all:
	ocamlbuild -j 4 -use-ocamlfind lib_test/run_cmm.native lib_test/run_cmm.byte

clean:
	ocamlbuild -clean
