OCaml LLVM backend
==================

Building
--------

    make llvm
    make all

Using
-----

    ./run_cmm.native ./test/mlintegr.cmm ./test/mlintegr.ll
    opt -std-link-opts -disable-internalize \
      -internalize -internalize-public-api-list=caml_program \
      ./test/mlintegr.ll | \
      llc ./test/mlintegr.ll

Debugging
---------

To get rid of noise in LLVM IR, run it through `opt -mem2reg`. This will
perform an SSA transformation and remove all of the useless allocas/loads/stores.
