test: all
	for i in integr alloc; do \
		./run_cmm.native test/$$i.cmm test/$$i.ll; \
	done

all:
	ocamlbuild -j 4 -use-ocamlfind lib_test/run_cmm.native lib_test/run_cmm.byte

clean:
	ocamlbuild -clean
