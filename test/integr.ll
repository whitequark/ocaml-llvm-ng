; ModuleID = 'caml'
target datalayout = "e-p:64:64:64-S128-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f16:16:16-f32:32:32-f64:64:64-f128:128:128-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-linux-gnu"

define internal cc16 { i8*, i8*, double } @square(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, double %arg.x) gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %alloca.x = alloca double
  store double %arg.x, double* %alloca.x
  %local.x = load double* %alloca.x
  %local.x1 = load double* %alloca.x
  %local.x2 = load double* %alloca.x
  %mulf = fmul double %local.x1, %local.x2
  %reload.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %0 = insertvalue { i8*, i8*, double } undef, i8* %reload.caml_exception_pointer, 0
  %reload.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %1 = insertvalue { i8*, i8*, double } %0, i8* %reload.caml_young_ptr, 1
  %2 = insertvalue { i8*, i8*, double } %1, double %mulf, 2
  ret { i8*, i8*, double } %2
}

define internal cc16 { i8*, i8*, double } @integr(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %arg.f, double %arg.low, double %arg.high, i64 %arg.n) gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %alloca.f = alloca i8*
  store i8* %arg.f, i8** %alloca.f
  %alloca.low = alloca double
  store double %arg.low, double* %alloca.low
  %alloca.high = alloca double
  store double %arg.high, double* %alloca.high
  %alloca.n = alloca i64
  store i64 %arg.n, i64* %alloca.n
  %local.high = load double* %alloca.high
  %local.high1 = load double* %alloca.high
  %local.low = load double* %alloca.low
  %subf = fsub double %local.high1, %local.low
  %local.high2 = load double* %alloca.high
  %local.high3 = load double* %alloca.high
  %local.low4 = load double* %alloca.low
  %subf5 = fsub double %local.high3, %local.low4
  %local.n = load i64* %alloca.n
  %floatofint = sitofp i64 %local.n to double
  %divf = fdiv double %subf5, %floatofint
  %alloca.h = alloca double
  store double %divf, double* %alloca.h
  %local.low6 = load double* %alloca.low
  %alloca.x = alloca double
  store double %local.low6, double* %alloca.x
  %alloca.s = alloca double
  store double 0.000000e+00, double* %alloca.s
  %local.n7 = load i64* %alloca.n
  %alloca.i = alloca i64
  store i64 %local.n7, i64* %alloca.i
  br label %loop

catch.0.with:                                     ; preds = %if.false
  br label %catch.0.exit

catch.0.exit:                                     ; preds = %catch.0.with
  %local.s15 = load double* %alloca.s
  %local.s16 = load double* %alloca.s
  %local.h17 = load double* %alloca.h
  %mulf = fmul double %local.s16, %local.h17
  %reload.caml_exception_pointer18 = load i8** %alloca.caml_exception_pointer
  %0 = insertvalue { i8*, i8*, double } undef, i8* %reload.caml_exception_pointer18, 0
  %reload.caml_young_ptr19 = load i8** %alloca.caml_young_ptr
  %1 = insertvalue { i8*, i8*, double } %0, i8* %reload.caml_young_ptr19, 1
  %2 = insertvalue { i8*, i8*, double } %1, double %mulf, 2
  ret { i8*, i8*, double } %2

loop:                                             ; preds = %if.exit, %entry
  %local.i13 = load i64* %alloca.i
  %local.i14 = load i64* %alloca.i
  %cmpi = icmp sgt i64 %local.i14, 0
  br i1 %cmpi, label %if.true, label %if.false

if.exit:                                          ; preds = %if.true
  br label %loop

if.true:                                          ; preds = %loop
  %local.s = load double* %alloca.s
  %local.s8 = load double* %alloca.s
  %local.x = load double* %alloca.x
  %local.f = load i8** %alloca.f
  %apply.fn = bitcast i8* %local.f to { i8*, i8*, double } (i8*, i8*, double)*
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %3 = tail call cc16 { i8*, i8*, double } %apply.fn(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, double %local.x)
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, double } %3, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, double } %3, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, double } %3, 2
  %addf = fadd double %local.s8, %apply
  store double %addf, double* %alloca.s
  %local.x9 = load double* %alloca.x
  %local.x10 = load double* %alloca.x
  %local.h = load double* %alloca.h
  %addf11 = fadd double %local.x10, %local.h
  store double %addf11, double* %alloca.x
  %local.i = load i64* %alloca.i
  %local.i12 = load i64* %alloca.i
  %subi = sub i64 %local.i12, 1
  store i64 %subi, i64* %alloca.i
  br label %if.exit

if.false:                                         ; preds = %loop
  br label %catch.0.with
}

define internal cc16 { i8*, i8*, double } @test(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i64 %arg.n) gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %alloca.n = alloca i64
  store i64 %arg.n, i64* %alloca.n
  %local.n = load i64* %alloca.n
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %0 = tail call cc16 { i8*, i8*, double } @integr(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, i8* bitcast ({ i8*, i8*, double } (i8*, i8*, double)* @square to i8*), double 0.000000e+00, double 1.000000e+00, i64 %local.n)
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, double } %0, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, double } %0, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, double } %0, 2
  %reload.caml_exception_pointer1 = load i8** %alloca.caml_exception_pointer
  %1 = insertvalue { i8*, i8*, double } undef, i8* %reload.caml_exception_pointer1, 0
  %reload.caml_young_ptr2 = load i8** %alloca.caml_young_ptr
  %2 = insertvalue { i8*, i8*, double } %1, i8* %reload.caml_young_ptr2, 1
  %3 = insertvalue { i8*, i8*, double } %2, double %apply, 2
  ret { i8*, i8*, double } %3
}
