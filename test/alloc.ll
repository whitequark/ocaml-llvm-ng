; ModuleID = 'caml'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-linux-gnu"

@0 = private global <{ i64, [24 x i8] }> <{ i64 3072, [24 x i8] zeroinitializer }>
@camlMlintegr = global i8* getelementptr inbounds (<{ i64, [24 x i8] }>* @0, i32 0, i32 1, i32 0)

define cc16 { i8*, i8*, i8* } @camlMlintegr__square_1010(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.x/1011") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.x/1011" = alloca i8*
  store i8* %"arg.x/1011", i8** %"alloca.x/1011"
  %"local.x/1011" = load i8** %"alloca.x/1011"
  %load.addr = bitcast i8* %"local.x/1011" to double*
  %load = load double* %load.addr
  %"local.x/10111" = load i8** %"alloca.x/1011"
  %load.addr2 = bitcast i8* %"local.x/10111" to double*
  %load3 = load double* %load.addr2
  %mulf = fmul double %load, %load3
  %alloc = call i8* @caml_allocN(i64 16)
  %0 = bitcast i8* %alloc to { i64, double }*
  %field.0 = getelementptr inbounds { i64, double }* %0, i32 0, i32 0
  store i64 1277, i64* %field.0
  %field.1 = getelementptr inbounds { i64, double }* %0, i32 0, i32 1
  store double %mulf, double* %field.1
  %1 = getelementptr inbounds { i64, double }* %0, i32 0, i32 1
  %alloc.body = bitcast double* %1 to i8*
  %reload.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %2 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer, 0
  %reload.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %reload.caml_young_ptr, 1
  %4 = insertvalue { i8*, i8*, i8* } %3, i8* %alloc.body, 2
  ret { i8*, i8*, i8* } %4
}

declare preserve_allcc i8* @caml_allocN(i64)
