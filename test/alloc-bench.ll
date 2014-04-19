target datalayout = "e-p:64:64:64-S128-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f16:16:16-f32:32:32-f64:64:64-f128:128:128-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-linux-gnu"

declare cc16 { i8*, i8*, i8* } @camlMlintegr__square_1010(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.x/1011") gc "ocaml"

define i64 @main() {
entry:
  %t  = alloca <{ i64, double }>
  %t1 = getelementptr <{ i64, double }>* %t, i32 0, i32 1
  store double 2.0, double* %t1
  %t2 = bitcast double* %t1 to i8*
  %c = call cc16 { i8*, i8*, i8* }  @camlMlintegr__square_1010(i8* null, i8* null, i8* %t2)
  %d = extractvalue { i8*, i8*, i8* } %c, 2
  %e = bitcast i8* %d to double*
  %f = load double* %e
  %g = fptosi double %f to i64
  ret i64 %g
}
