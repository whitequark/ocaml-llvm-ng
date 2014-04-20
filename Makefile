JOBS = 4

test: all
	for i in integr alloc; do \
		./run_cmm.native test/$$i.cmm test/$$i.ll; \
	done

all:
	ocamlbuild -j $(JOBS) -use-ocamlfind lib_test/run_cmm.native

clean:
	ocamlbuild -clean

llvm:
	git submodule update --init
	(cd llvm && \
	 ./configure --enable-targets=x86_64 --enable-bindings=ocaml --disable-optimized && \
	 make -j$(JOBS))

env:
	@echo "export PATH=$$(pwd)/llvm/Debug+Asserts/bin:$$PATH"
	@echo "export OCAMLPATH=$$(pwd)/llvm/Debug+Asserts/lib/ocaml:$$OCAMLPATH"
