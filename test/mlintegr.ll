; ModuleID = 'caml'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-linux-gnu"

@0 = private global <{ i64, [24 x i8] }> <{ i64 3072, [24 x i8] zeroinitializer }>
@camlMlintegr = global i8* getelementptr inbounds (<{ i64, [24 x i8] }>* @0, i32 0, i32 1, i32 0)
@1 = private global <{ i64, i8*, i64 }> <{ i64 2295, i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i64)* @camlMlintegr__test_1022 to i8*), i64 3 }>
@camlMlintegr__4 = global i8* bitcast (i8** getelementptr inbounds (<{ i64, i8*, i64 }>* @1, i32 0, i32 1) to i8*)
@2 = private global <{ i64, i8*, i64, i8* }> <{ i64 3319, i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*)* @caml_curry4 to i8*), i64 9, i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i8*, i64)* @camlMlintegr__integr_1012 to i8*) }>
@camlMlintegr__5 = global i8* bitcast (i8** getelementptr inbounds (<{ i64, i8*, i64, i8* }>* @2, i32 0, i32 1) to i8*)
@3 = private global <{ i64, i8*, i64 }> <{ i64 2295, i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*)* @camlMlintegr__square_1010 to i8*), i64 3 }>
@camlMlintegr__6 = global i8* bitcast (i8** getelementptr inbounds (<{ i64, i8*, i64 }>* @3, i32 0, i32 1) to i8*)
@4 = private global <{ i64, double }> <{ i64 1277, double 0.000000e+00 }>
@camlMlintegr__1 = global i8* bitcast (double* getelementptr inbounds (<{ i64, double }>* @4, i32 0, i32 1) to i8*)
@5 = private global <{ i64, double }> <{ i64 1277, double 0.000000e+00 }>
@camlMlintegr__2 = global i8* bitcast (double* getelementptr inbounds (<{ i64, double }>* @5, i32 0, i32 1) to i8*)
@6 = private global <{ i64, double }> <{ i64 1277, double 1.000000e+00 }>
@camlMlintegr__3 = global i8* bitcast (double* getelementptr inbounds (<{ i64, double }>* @6, i32 0, i32 1) to i8*)
@7 = private global <{}> zeroinitializer

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

define cc16 { i8*, i8*, i8* } @camlMlintegr__iter_1018(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.x/1019", i8* %"arg.s/1020", i64 %"arg.i/1021", i8* %"arg.env/1038") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.x/1019" = alloca i8*
  store i8* %"arg.x/1019", i8** %"alloca.x/1019"
  %"alloca.s/1020" = alloca i8*
  store i8* %"arg.s/1020", i8** %"alloca.s/1020"
  %"alloca.i/1021" = alloca i64
  store i64 %"arg.i/1021", i64* %"alloca.i/1021"
  %"alloca.env/1038" = alloca i8*
  store i8* %"arg.env/1038", i8** %"alloca.env/1038"
  %"local.i/102141" = load i64* %"alloca.i/1021"
  %cmpi = icmp sgt i64 %"local.i/102141", 1
  br i1 %cmpi, label %if.true, label %if.false

if.exit:                                          ; preds = %if.false, %if.true
  %if.value = phi i8* [ %apply27, %if.true ], [ %alloc.body40, %if.false ]
  %reload.caml_exception_pointer42 = load i8** %alloca.caml_exception_pointer
  %0 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer42, 0
  %reload.caml_young_ptr43 = load i8** %alloca.caml_young_ptr
  %1 = insertvalue { i8*, i8*, i8* } %0, i8* %reload.caml_young_ptr43, 1
  %2 = insertvalue { i8*, i8*, i8* } %1, i8* %if.value, 2
  ret { i8*, i8*, i8* } %2

if.true:                                          ; preds = %entry
  %"local.s/1020" = load i8** %"alloca.s/1020"
  %load.addr = bitcast i8* %"local.s/1020" to double*
  %load = load double* %load.addr
  %"local.env/1038" = load i8** %"alloca.env/1038"
  %adda = getelementptr inbounds i8* %"local.env/1038", i64 24
  %load.addr1 = bitcast i8* %adda to i8**
  %load2 = load i8** %load.addr1
  %"alloca.fun/1042" = alloca i8*
  store i8* %load2, i8** %"alloca.fun/1042"
  %"local.x/1019" = load i8** %"alloca.x/1019"
  %"local.fun/1042" = load i8** %"alloca.fun/1042"
  %"local.fun/10423" = load i8** %"alloca.fun/1042"
  %load.addr4 = bitcast i8* %"local.fun/10423" to i8**
  %load5 = load i8** %load.addr4
  %apply.fn = bitcast i8* %load5 to { i8*, i8*, i8* } (i8*, i8*, i8*, i8*)*
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %3 = tail call cc16 { i8*, i8*, i8* } %apply.fn(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, i8* %"local.x/1019", i8* %"local.fun/1042")
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, i8* } %3, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, i8* } %3, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, i8* } %3, 2
  %load.addr6 = bitcast i8* %apply to double*
  %load7 = load double* %load.addr6
  %addf = fadd double %load, %load7
  %alloc = call i8* @caml_allocN(i64 16)
  %4 = bitcast i8* %alloc to { i64, double }*
  %field.0 = getelementptr inbounds { i64, double }* %4, i32 0, i32 0
  store i64 1277, i64* %field.0
  %field.1 = getelementptr inbounds { i64, double }* %4, i32 0, i32 1
  store double %addf, double* %field.1
  %5 = getelementptr inbounds { i64, double }* %4, i32 0, i32 1
  %alloc.body = bitcast double* %5 to i8*
  %"local.x/10198" = load i8** %"alloca.x/1019"
  %load.addr9 = bitcast i8* %"local.x/10198" to double*
  %load10 = load double* %load.addr9
  %"local.env/103811" = load i8** %"alloca.env/1038"
  %adda12 = getelementptr inbounds i8* %"local.env/103811", i64 32
  %load.addr13 = bitcast i8* %adda12 to i8**
  %load14 = load i8** %load.addr13
  %load.addr15 = bitcast i8* %load14 to double*
  %load16 = load double* %load.addr15
  %addf17 = fadd double %load10, %load16
  %alloc18 = call i8* @caml_allocN(i64 16)
  %6 = bitcast i8* %alloc18 to { i64, double }*
  %field.019 = getelementptr inbounds { i64, double }* %6, i32 0, i32 0
  store i64 1277, i64* %field.019
  %field.120 = getelementptr inbounds { i64, double }* %6, i32 0, i32 1
  store double %addf17, double* %field.120
  %7 = getelementptr inbounds { i64, double }* %6, i32 0, i32 1
  %alloc.body21 = bitcast double* %7 to i8*
  %"local.i/1021" = load i64* %"alloca.i/1021"
  %addi = add i64 %"local.i/1021", -2
  %"local.env/103822" = load i8** %"alloca.env/1038"
  %pass.caml_exception_pointer23 = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr24 = load i8** %alloca.caml_young_ptr
  %8 = tail call cc16 { i8*, i8*, i8* } @camlMlintegr__iter_1018(i8* %pass.caml_exception_pointer23, i8* %pass.caml_young_ptr24, i8* %alloc.body, i8* %alloc.body21, i64 %addi, i8* %"local.env/103822")
  %reload.caml_exception_pointer25 = extractvalue { i8*, i8*, i8* } %8, 0
  store i8* %reload.caml_exception_pointer25, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr26 = extractvalue { i8*, i8*, i8* } %8, 1
  store i8* %reload.caml_young_ptr26, i8** %alloca.caml_young_ptr
  %apply27 = extractvalue { i8*, i8*, i8* } %8, 2
  br label %if.exit

if.false:                                         ; preds = %entry
  %"local.s/102028" = load i8** %"alloca.s/1020"
  %load.addr29 = bitcast i8* %"local.s/102028" to double*
  %load30 = load double* %load.addr29
  %"local.env/103831" = load i8** %"alloca.env/1038"
  %adda32 = getelementptr inbounds i8* %"local.env/103831", i64 32
  %load.addr33 = bitcast i8* %adda32 to i8**
  %load34 = load i8** %load.addr33
  %load.addr35 = bitcast i8* %load34 to double*
  %load36 = load double* %load.addr35
  %mulf = fmul double %load30, %load36
  %alloc37 = call i8* @caml_allocN(i64 16)
  %9 = bitcast i8* %alloc37 to { i64, double }*
  %field.038 = getelementptr inbounds { i64, double }* %9, i32 0, i32 0
  store i64 1277, i64* %field.038
  %field.139 = getelementptr inbounds { i64, double }* %9, i32 0, i32 1
  store double %mulf, double* %field.139
  %10 = getelementptr inbounds { i64, double }* %9, i32 0, i32 1
  %alloc.body40 = bitcast double* %10 to i8*
  br label %if.exit
}

define cc16 { i8*, i8*, i8* } @camlMlintegr__integr_1012(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.f/1013", i8* %"arg.low/1014", i8* %"arg.high/1015", i64 %"arg.n/1016") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.f/1013" = alloca i8*
  store i8* %"arg.f/1013", i8** %"alloca.f/1013"
  %"alloca.low/1014" = alloca i8*
  store i8* %"arg.low/1014", i8** %"alloca.low/1014"
  %"alloca.high/1015" = alloca i8*
  store i8* %"arg.high/1015", i8** %"alloca.high/1015"
  %"alloca.n/1016" = alloca i64
  store i64 %"arg.n/1016", i64* %"alloca.n/1016"
  %"local.high/1015" = load i8** %"alloca.high/1015"
  %load.addr = bitcast i8* %"local.high/1015" to double*
  %load = load double* %load.addr
  %"local.low/1014" = load i8** %"alloca.low/1014"
  %load.addr1 = bitcast i8* %"local.low/1014" to double*
  %load2 = load double* %load.addr1
  %subf = fsub double %load, %load2
  %"local.n/1016" = load i64* %"alloca.n/1016"
  %asr = ashr i64 %"local.n/1016", 1
  %floatofint = sitofp i64 %asr to double
  %divf = fdiv double %subf, %floatofint
  %"alloca.h/1041" = alloca double
  store double %divf, double* %"alloca.h/1041"
  %"local.h/1041" = load double* %"alloca.h/1041"
  %alloc = call i8* @caml_allocN(i64 16)
  %0 = bitcast i8* %alloc to { i64, double }*
  %field.0 = getelementptr inbounds { i64, double }* %0, i32 0, i32 0
  store i64 1277, i64* %field.0
  %field.1 = getelementptr inbounds { i64, double }* %0, i32 0, i32 1
  store double %"local.h/1041", double* %field.1
  %1 = getelementptr inbounds { i64, double }* %0, i32 0, i32 1
  %alloc.body = bitcast double* %1 to i8*
  %"alloca.h/1017" = alloca i8*
  store i8* %alloc.body, i8** %"alloca.h/1017"
  %"local.h/1017" = load i8** %"alloca.h/1017"
  %"local.f/1013" = load i8** %"alloca.f/1013"
  %alloc3 = call i8* @caml_allocN(i64 48)
  %2 = bitcast i8* %alloc3 to { i64, i8*, i8*, i8*, i64, i8* }*
  %field.04 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %2, i32 0, i32 0
  store i64 5367, i64* %field.04
  %field.15 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %2, i32 0, i32 1
  store i8* %"local.h/1017", i8** %field.15
  %field.2 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %2, i32 0, i32 2
  store i8* %"local.f/1013", i8** %field.2
  %field.3 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %2, i32 0, i32 3
  store i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i64, i8*)* @camlMlintegr__iter_1018 to i8*), i8** %field.3
  %field.4 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %2, i32 0, i32 4
  store i64 7, i64* %field.4
  %field.5 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %2, i32 0, i32 5
  store i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*)* @caml_curry3 to i8*), i8** %field.5
  %3 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %2, i32 0, i32 1
  %alloc.body6 = bitcast i8** %3 to i8*
  %"alloca.clos/1039" = alloca i8*
  store i8* %alloc.body6, i8** %"alloca.clos/1039"
  %"local.low/10147" = load i8** %"alloca.low/1014"
  %"local.n/10168" = load i64* %"alloca.n/1016"
  %"local.clos/1039" = load i8** %"alloca.clos/1039"
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %4 = tail call cc16 { i8*, i8*, i8* } @camlMlintegr__iter_1018(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, i8* %"local.low/10147", i8* bitcast (i8** @camlMlintegr__1 to i8*), i64 %"local.n/10168", i8* %"local.clos/1039")
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, i8* } %4, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, i8* } %4, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, i8* } %4, 2
  %reload.caml_exception_pointer9 = load i8** %alloca.caml_exception_pointer
  %5 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer9, 0
  %reload.caml_young_ptr10 = load i8** %alloca.caml_young_ptr
  %6 = insertvalue { i8*, i8*, i8* } %5, i8* %reload.caml_young_ptr10, 1
  %7 = insertvalue { i8*, i8*, i8* } %6, i8* %apply, 2
  ret { i8*, i8*, i8* } %7
}

define cc16 { i8*, i8*, i8* } @camlMlintegr__test_1022(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i64 %"arg.n/1023") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.n/1023" = alloca i64
  store i64 %"arg.n/1023", i64* %"alloca.n/1023"
  %load = load i8** @camlMlintegr
  %"local.n/1023" = load i64* %"alloca.n/1023"
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %0 = tail call cc16 { i8*, i8*, i8* } @camlMlintegr__integr_1012(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, i8* %load, i8* bitcast (i8** @camlMlintegr__2 to i8*), i8* bitcast (i8** @camlMlintegr__3 to i8*), i64 %"local.n/1023")
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, i8* } %0, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, i8* } %0, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, i8* } %0, 2
  %reload.caml_exception_pointer1 = load i8** %alloca.caml_exception_pointer
  %1 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer1, 0
  %reload.caml_young_ptr2 = load i8** %alloca.caml_young_ptr
  %2 = insertvalue { i8*, i8*, i8* } %1, i8* %reload.caml_young_ptr2, 1
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %apply, 2
  ret { i8*, i8*, i8* } %3
}

define cc16 { i8*, i8*, i8* } @camlMlintegr__entry(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr) gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.square/1010" = alloca i8*
  store i8* bitcast (i8** @camlMlintegr__6 to i8*), i8** %"alloca.square/1010"
  %"local.square/1010" = load i8** %"alloca.square/1010"
  store i8* %"local.square/1010", i8** @camlMlintegr
  %"alloca.integr/1012" = alloca i8*
  store i8* bitcast (i8** @camlMlintegr__5 to i8*), i8** %"alloca.integr/1012"
  %"local.integr/1012" = load i8** %"alloca.integr/1012"
  store i8* %"local.integr/1012", i8** bitcast (i8* getelementptr inbounds (i8* bitcast (i8** @camlMlintegr to i8*), i64 8) to i8**)
  %"alloca.test/1022" = alloca i8*
  store i8* bitcast (i8** @camlMlintegr__4 to i8*), i8** %"alloca.test/1022"
  %"local.test/1022" = load i8** %"alloca.test/1022"
  store i8* %"local.test/1022", i8** bitcast (i8* getelementptr inbounds (i8* bitcast (i8** @camlMlintegr to i8*), i64 16) to i8**)
  %load = load i8** @camlMlintegr
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %0 = tail call cc16 { i8*, i8*, {} } bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i8*, i64)* @camlMlintegr__integr_1012 to { i8*, i8*, {} } (i8*, i8*, i8*, i8*, i8*, i64)*)(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, i8* %load, i8* bitcast (i8** @camlMlintegr__2 to i8*), i8* bitcast (i8** @camlMlintegr__3 to i8*), i64 21)
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, {} } %0, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, {} } %0, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, {} } %0, 2
  %reload.caml_exception_pointer1 = load i8** %alloca.caml_exception_pointer
  %1 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer1, 0
  %reload.caml_young_ptr2 = load i8** %alloca.caml_young_ptr
  %2 = insertvalue { i8*, i8*, i8* } %1, i8* %reload.caml_young_ptr2, 1
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* inttoptr (i64 1 to i8*), 2
  ret { i8*, i8*, i8* } %3
}

define cc16 { i8*, i8*, i64 } @caml_program(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr) gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %0 = tail call cc16 { i8*, i8*, {} } bitcast ({ i8*, i8*, i8* } (i8*, i8*)* @camlMlintegr__entry to { i8*, i8*, {} } (i8*, i8*)*)(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr)
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, {} } %0, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, {} } %0, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, {} } %0, 2
  %reload.caml_exception_pointer1 = load i8** %alloca.caml_exception_pointer
  %1 = insertvalue { i8*, i8*, i64 } undef, i8* %reload.caml_exception_pointer1, 0
  %reload.caml_young_ptr2 = load i8** %alloca.caml_young_ptr
  %2 = insertvalue { i8*, i8*, i64 } %1, i8* %reload.caml_young_ptr2, 1
  %3 = insertvalue { i8*, i8*, i64 } %2, i64 1, 2
  ret { i8*, i8*, i64 } %3
}

define cc16 { i8*, i8*, i8* } @caml_curry4(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.arg/1069", i8* %"arg.clos/1070") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.arg/1069" = alloca i8*
  store i8* %"arg.arg/1069", i8** %"alloca.arg/1069"
  %"alloca.clos/1070" = alloca i8*
  store i8* %"arg.clos/1070", i8** %"alloca.clos/1070"
  %"local.clos/1070" = load i8** %"alloca.clos/1070"
  %"local.arg/1069" = load i8** %"alloca.arg/1069"
  %alloc = call i8* @caml_allocN(i64 48)
  %0 = bitcast i8* %alloc to { i64, i8*, i8*, i8*, i64, i8* }*
  %field.0 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 0
  store i64 5367, i64* %field.0
  %field.1 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 1
  store i8* %"local.clos/1070", i8** %field.1
  %field.2 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 2
  store i8* %"local.arg/1069", i8** %field.2
  %field.3 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 3
  store i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i8*, i8*)* @caml_curry4_1_app to i8*), i8** %field.3
  %field.4 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 4
  store i64 7, i64* %field.4
  %field.5 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 5
  store i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*)* @caml_curry4_1 to i8*), i8** %field.5
  %1 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 1
  %alloc.body = bitcast i8** %1 to i8*
  %reload.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %2 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer, 0
  %reload.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %reload.caml_young_ptr, 1
  %4 = insertvalue { i8*, i8*, i8* } %3, i8* %alloc.body, 2
  ret { i8*, i8*, i8* } %4
}

define cc16 { i8*, i8*, i8* } @caml_curry4_1_app(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.arg2/1071", i8* %"arg.arg3/1072", i8* %"arg.arg4/1073", i8* %"arg.clos/1070") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.arg2/1071" = alloca i8*
  store i8* %"arg.arg2/1071", i8** %"alloca.arg2/1071"
  %"alloca.arg3/1072" = alloca i8*
  store i8* %"arg.arg3/1072", i8** %"alloca.arg3/1072"
  %"alloca.arg4/1073" = alloca i8*
  store i8* %"arg.arg4/1073", i8** %"alloca.arg4/1073"
  %"alloca.clos/1070" = alloca i8*
  store i8* %"arg.clos/1070", i8** %"alloca.clos/1070"
  %"local.clos/1070" = load i8** %"alloca.clos/1070"
  %adda = getelementptr inbounds i8* %"local.clos/1070", i64 32
  %load.addr = bitcast i8* %adda to i8**
  %load = load i8** %load.addr
  %"alloca.clos/1074" = alloca i8*
  store i8* %load, i8** %"alloca.clos/1074"
  %"local.clos/10701" = load i8** %"alloca.clos/1070"
  %adda2 = getelementptr inbounds i8* %"local.clos/10701", i64 24
  %load.addr3 = bitcast i8* %adda2 to i8**
  %load4 = load i8** %load.addr3
  %"local.arg2/1071" = load i8** %"alloca.arg2/1071"
  %"local.arg3/1072" = load i8** %"alloca.arg3/1072"
  %"local.arg4/1073" = load i8** %"alloca.arg4/1073"
  %"local.clos/1074" = load i8** %"alloca.clos/1074"
  %"local.clos/10745" = load i8** %"alloca.clos/1074"
  %adda6 = getelementptr inbounds i8* %"local.clos/10745", i64 16
  %load.addr7 = bitcast i8* %adda6 to i8**
  %load8 = load i8** %load.addr7
  %apply.fn = bitcast i8* %load8 to { i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i8*, i8*, i8*)*
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %0 = tail call cc16 { i8*, i8*, i8* } %apply.fn(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, i8* %load4, i8* %"local.arg2/1071", i8* %"local.arg3/1072", i8* %"local.arg4/1073", i8* %"local.clos/1074")
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, i8* } %0, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, i8* } %0, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, i8* } %0, 2
  %reload.caml_exception_pointer9 = load i8** %alloca.caml_exception_pointer
  %1 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer9, 0
  %reload.caml_young_ptr10 = load i8** %alloca.caml_young_ptr
  %2 = insertvalue { i8*, i8*, i8* } %1, i8* %reload.caml_young_ptr10, 1
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %apply, 2
  ret { i8*, i8*, i8* } %3
}

define cc16 { i8*, i8*, i8* } @caml_curry4_1(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.arg/1075", i8* %"arg.clos/1076") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.arg/1075" = alloca i8*
  store i8* %"arg.arg/1075", i8** %"alloca.arg/1075"
  %"alloca.clos/1076" = alloca i8*
  store i8* %"arg.clos/1076", i8** %"alloca.clos/1076"
  %"local.clos/1076" = load i8** %"alloca.clos/1076"
  %"local.arg/1075" = load i8** %"alloca.arg/1075"
  %alloc = call i8* @caml_allocN(i64 48)
  %0 = bitcast i8* %alloc to { i64, i8*, i8*, i8*, i64, i8* }*
  %field.0 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 0
  store i64 5367, i64* %field.0
  %field.1 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 1
  store i8* %"local.clos/1076", i8** %field.1
  %field.2 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 2
  store i8* %"local.arg/1075", i8** %field.2
  %field.3 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 3
  store i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i8*)* @caml_curry4_2_app to i8*), i8** %field.3
  %field.4 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 4
  store i64 5, i64* %field.4
  %field.5 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 5
  store i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*)* @caml_curry4_2 to i8*), i8** %field.5
  %1 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 1
  %alloc.body = bitcast i8** %1 to i8*
  %reload.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %2 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer, 0
  %reload.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %reload.caml_young_ptr, 1
  %4 = insertvalue { i8*, i8*, i8* } %3, i8* %alloc.body, 2
  ret { i8*, i8*, i8* } %4
}

define cc16 { i8*, i8*, i8* } @caml_curry4_2_app(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.arg3/1077", i8* %"arg.arg4/1078", i8* %"arg.clos/1076") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.arg3/1077" = alloca i8*
  store i8* %"arg.arg3/1077", i8** %"alloca.arg3/1077"
  %"alloca.arg4/1078" = alloca i8*
  store i8* %"arg.arg4/1078", i8** %"alloca.arg4/1078"
  %"alloca.clos/1076" = alloca i8*
  store i8* %"arg.clos/1076", i8** %"alloca.clos/1076"
  %"local.clos/1076" = load i8** %"alloca.clos/1076"
  %adda = getelementptr inbounds i8* %"local.clos/1076", i64 32
  %load.addr = bitcast i8* %adda to i8**
  %load = load i8** %load.addr
  %"alloca.clos/1079" = alloca i8*
  store i8* %load, i8** %"alloca.clos/1079"
  %"local.clos/1079" = load i8** %"alloca.clos/1079"
  %adda1 = getelementptr inbounds i8* %"local.clos/1079", i64 32
  %load.addr2 = bitcast i8* %adda1 to i8**
  %load3 = load i8** %load.addr2
  %"alloca.clos/1080" = alloca i8*
  store i8* %load3, i8** %"alloca.clos/1080"
  %"local.clos/10794" = load i8** %"alloca.clos/1079"
  %adda5 = getelementptr inbounds i8* %"local.clos/10794", i64 24
  %load.addr6 = bitcast i8* %adda5 to i8**
  %load7 = load i8** %load.addr6
  %"local.clos/10768" = load i8** %"alloca.clos/1076"
  %adda9 = getelementptr inbounds i8* %"local.clos/10768", i64 24
  %load.addr10 = bitcast i8* %adda9 to i8**
  %load11 = load i8** %load.addr10
  %"local.arg3/1077" = load i8** %"alloca.arg3/1077"
  %"local.arg4/1078" = load i8** %"alloca.arg4/1078"
  %"local.clos/1080" = load i8** %"alloca.clos/1080"
  %"local.clos/108012" = load i8** %"alloca.clos/1080"
  %adda13 = getelementptr inbounds i8* %"local.clos/108012", i64 16
  %load.addr14 = bitcast i8* %adda13 to i8**
  %load15 = load i8** %load.addr14
  %apply.fn = bitcast i8* %load15 to { i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i8*, i8*, i8*)*
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %0 = tail call cc16 { i8*, i8*, i8* } %apply.fn(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, i8* %load7, i8* %load11, i8* %"local.arg3/1077", i8* %"local.arg4/1078", i8* %"local.clos/1080")
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, i8* } %0, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, i8* } %0, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, i8* } %0, 2
  %reload.caml_exception_pointer16 = load i8** %alloca.caml_exception_pointer
  %1 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer16, 0
  %reload.caml_young_ptr17 = load i8** %alloca.caml_young_ptr
  %2 = insertvalue { i8*, i8*, i8* } %1, i8* %reload.caml_young_ptr17, 1
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %apply, 2
  ret { i8*, i8*, i8* } %3
}

define cc16 { i8*, i8*, i8* } @caml_curry4_2(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.arg/1081", i8* %"arg.clos/1082") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.arg/1081" = alloca i8*
  store i8* %"arg.arg/1081", i8** %"alloca.arg/1081"
  %"alloca.clos/1082" = alloca i8*
  store i8* %"arg.clos/1082", i8** %"alloca.clos/1082"
  %"local.clos/1082" = load i8** %"alloca.clos/1082"
  %"local.arg/1081" = load i8** %"alloca.arg/1081"
  %alloc = call i8* @caml_allocN(i64 40)
  %0 = bitcast i8* %alloc to { i64, i8*, i8*, i64, i8* }*
  %field.0 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 0
  store i64 4343, i64* %field.0
  %field.1 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 1
  store i8* %"local.clos/1082", i8** %field.1
  %field.2 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 2
  store i8* %"local.arg/1081", i8** %field.2
  %field.3 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 3
  store i64 3, i64* %field.3
  %field.4 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 4
  store i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*)* @caml_curry4_3 to i8*), i8** %field.4
  %1 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 1
  %alloc.body = bitcast i8** %1 to i8*
  %reload.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %2 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer, 0
  %reload.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %reload.caml_young_ptr, 1
  %4 = insertvalue { i8*, i8*, i8* } %3, i8* %alloc.body, 2
  ret { i8*, i8*, i8* } %4
}

define cc16 { i8*, i8*, i8* } @caml_curry4_3(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.arg/1083", i8* %"arg.clos/1084") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.arg/1083" = alloca i8*
  store i8* %"arg.arg/1083", i8** %"alloca.arg/1083"
  %"alloca.clos/1084" = alloca i8*
  store i8* %"arg.clos/1084", i8** %"alloca.clos/1084"
  %"local.clos/1084" = load i8** %"alloca.clos/1084"
  %adda = getelementptr inbounds i8* %"local.clos/1084", i64 24
  %load.addr = bitcast i8* %adda to i8**
  %load = load i8** %load.addr
  %"alloca.clos/1085" = alloca i8*
  store i8* %load, i8** %"alloca.clos/1085"
  %"local.clos/1085" = load i8** %"alloca.clos/1085"
  %adda1 = getelementptr inbounds i8* %"local.clos/1085", i64 32
  %load.addr2 = bitcast i8* %adda1 to i8**
  %load3 = load i8** %load.addr2
  %"alloca.clos/1086" = alloca i8*
  store i8* %load3, i8** %"alloca.clos/1086"
  %"local.clos/1086" = load i8** %"alloca.clos/1086"
  %adda4 = getelementptr inbounds i8* %"local.clos/1086", i64 32
  %load.addr5 = bitcast i8* %adda4 to i8**
  %load6 = load i8** %load.addr5
  %"alloca.clos/1087" = alloca i8*
  store i8* %load6, i8** %"alloca.clos/1087"
  %"local.clos/10867" = load i8** %"alloca.clos/1086"
  %adda8 = getelementptr inbounds i8* %"local.clos/10867", i64 24
  %load.addr9 = bitcast i8* %adda8 to i8**
  %load10 = load i8** %load.addr9
  %"local.clos/108511" = load i8** %"alloca.clos/1085"
  %adda12 = getelementptr inbounds i8* %"local.clos/108511", i64 24
  %load.addr13 = bitcast i8* %adda12 to i8**
  %load14 = load i8** %load.addr13
  %"local.clos/108415" = load i8** %"alloca.clos/1084"
  %adda16 = getelementptr inbounds i8* %"local.clos/108415", i64 16
  %load.addr17 = bitcast i8* %adda16 to i8**
  %load18 = load i8** %load.addr17
  %"local.arg/1083" = load i8** %"alloca.arg/1083"
  %"local.clos/1087" = load i8** %"alloca.clos/1087"
  %"local.clos/108719" = load i8** %"alloca.clos/1087"
  %adda20 = getelementptr inbounds i8* %"local.clos/108719", i64 16
  %load.addr21 = bitcast i8* %adda20 to i8**
  %load22 = load i8** %load.addr21
  %apply.fn = bitcast i8* %load22 to { i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i8*, i8*, i8*)*
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %0 = tail call cc16 { i8*, i8*, i8* } %apply.fn(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, i8* %load10, i8* %load14, i8* %load18, i8* %"local.arg/1083", i8* %"local.clos/1087")
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, i8* } %0, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, i8* } %0, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, i8* } %0, 2
  %reload.caml_exception_pointer23 = load i8** %alloca.caml_exception_pointer
  %1 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer23, 0
  %reload.caml_young_ptr24 = load i8** %alloca.caml_young_ptr
  %2 = insertvalue { i8*, i8*, i8* } %1, i8* %reload.caml_young_ptr24, 1
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %apply, 2
  ret { i8*, i8*, i8* } %3
}

define cc16 { i8*, i8*, i8* } @caml_curry3(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.arg/1058", i8* %"arg.clos/1059") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.arg/1058" = alloca i8*
  store i8* %"arg.arg/1058", i8** %"alloca.arg/1058"
  %"alloca.clos/1059" = alloca i8*
  store i8* %"arg.clos/1059", i8** %"alloca.clos/1059"
  %"local.clos/1059" = load i8** %"alloca.clos/1059"
  %"local.arg/1058" = load i8** %"alloca.arg/1058"
  %alloc = call i8* @caml_allocN(i64 48)
  %0 = bitcast i8* %alloc to { i64, i8*, i8*, i8*, i64, i8* }*
  %field.0 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 0
  store i64 5367, i64* %field.0
  %field.1 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 1
  store i8* %"local.clos/1059", i8** %field.1
  %field.2 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 2
  store i8* %"local.arg/1058", i8** %field.2
  %field.3 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 3
  store i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i8*)* @caml_curry3_1_app to i8*), i8** %field.3
  %field.4 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 4
  store i64 5, i64* %field.4
  %field.5 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 5
  store i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*)* @caml_curry3_1 to i8*), i8** %field.5
  %1 = getelementptr inbounds { i64, i8*, i8*, i8*, i64, i8* }* %0, i32 0, i32 1
  %alloc.body = bitcast i8** %1 to i8*
  %reload.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %2 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer, 0
  %reload.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %reload.caml_young_ptr, 1
  %4 = insertvalue { i8*, i8*, i8* } %3, i8* %alloc.body, 2
  ret { i8*, i8*, i8* } %4
}

define cc16 { i8*, i8*, i8* } @caml_curry3_1_app(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.arg2/1060", i8* %"arg.arg3/1061", i8* %"arg.clos/1059") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.arg2/1060" = alloca i8*
  store i8* %"arg.arg2/1060", i8** %"alloca.arg2/1060"
  %"alloca.arg3/1061" = alloca i8*
  store i8* %"arg.arg3/1061", i8** %"alloca.arg3/1061"
  %"alloca.clos/1059" = alloca i8*
  store i8* %"arg.clos/1059", i8** %"alloca.clos/1059"
  %"local.clos/1059" = load i8** %"alloca.clos/1059"
  %adda = getelementptr inbounds i8* %"local.clos/1059", i64 32
  %load.addr = bitcast i8* %adda to i8**
  %load = load i8** %load.addr
  %"alloca.clos/1062" = alloca i8*
  store i8* %load, i8** %"alloca.clos/1062"
  %"local.clos/10591" = load i8** %"alloca.clos/1059"
  %adda2 = getelementptr inbounds i8* %"local.clos/10591", i64 24
  %load.addr3 = bitcast i8* %adda2 to i8**
  %load4 = load i8** %load.addr3
  %"local.arg2/1060" = load i8** %"alloca.arg2/1060"
  %"local.arg3/1061" = load i8** %"alloca.arg3/1061"
  %"local.clos/1062" = load i8** %"alloca.clos/1062"
  %"local.clos/10625" = load i8** %"alloca.clos/1062"
  %adda6 = getelementptr inbounds i8* %"local.clos/10625", i64 16
  %load.addr7 = bitcast i8* %adda6 to i8**
  %load8 = load i8** %load.addr7
  %apply.fn = bitcast i8* %load8 to { i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i8*, i8*)*
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %0 = tail call cc16 { i8*, i8*, i8* } %apply.fn(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, i8* %load4, i8* %"local.arg2/1060", i8* %"local.arg3/1061", i8* %"local.clos/1062")
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, i8* } %0, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, i8* } %0, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, i8* } %0, 2
  %reload.caml_exception_pointer9 = load i8** %alloca.caml_exception_pointer
  %1 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer9, 0
  %reload.caml_young_ptr10 = load i8** %alloca.caml_young_ptr
  %2 = insertvalue { i8*, i8*, i8* } %1, i8* %reload.caml_young_ptr10, 1
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %apply, 2
  ret { i8*, i8*, i8* } %3
}

define cc16 { i8*, i8*, i8* } @caml_curry3_1(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.arg/1063", i8* %"arg.clos/1064") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.arg/1063" = alloca i8*
  store i8* %"arg.arg/1063", i8** %"alloca.arg/1063"
  %"alloca.clos/1064" = alloca i8*
  store i8* %"arg.clos/1064", i8** %"alloca.clos/1064"
  %"local.clos/1064" = load i8** %"alloca.clos/1064"
  %"local.arg/1063" = load i8** %"alloca.arg/1063"
  %alloc = call i8* @caml_allocN(i64 40)
  %0 = bitcast i8* %alloc to { i64, i8*, i8*, i64, i8* }*
  %field.0 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 0
  store i64 4343, i64* %field.0
  %field.1 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 1
  store i8* %"local.clos/1064", i8** %field.1
  %field.2 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 2
  store i8* %"local.arg/1063", i8** %field.2
  %field.3 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 3
  store i64 3, i64* %field.3
  %field.4 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 4
  store i8* bitcast ({ i8*, i8*, i8* } (i8*, i8*, i8*, i8*)* @caml_curry3_2 to i8*), i8** %field.4
  %1 = getelementptr inbounds { i64, i8*, i8*, i64, i8* }* %0, i32 0, i32 1
  %alloc.body = bitcast i8** %1 to i8*
  %reload.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %2 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer, 0
  %reload.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %reload.caml_young_ptr, 1
  %4 = insertvalue { i8*, i8*, i8* } %3, i8* %alloc.body, 2
  ret { i8*, i8*, i8* } %4
}

define cc16 { i8*, i8*, i8* } @caml_curry3_2(i8* %pinned.caml_exception_pointer, i8* %pinned.caml_young_ptr, i8* %"arg.arg/1065", i8* %"arg.clos/1066") gc "ocaml" {
entry:
  %alloca.caml_exception_pointer = alloca i8*
  store i8* %pinned.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %alloca.caml_young_ptr = alloca i8*
  store i8* %pinned.caml_young_ptr, i8** %alloca.caml_young_ptr
  %"alloca.arg/1065" = alloca i8*
  store i8* %"arg.arg/1065", i8** %"alloca.arg/1065"
  %"alloca.clos/1066" = alloca i8*
  store i8* %"arg.clos/1066", i8** %"alloca.clos/1066"
  %"local.clos/1066" = load i8** %"alloca.clos/1066"
  %adda = getelementptr inbounds i8* %"local.clos/1066", i64 24
  %load.addr = bitcast i8* %adda to i8**
  %load = load i8** %load.addr
  %"alloca.clos/1067" = alloca i8*
  store i8* %load, i8** %"alloca.clos/1067"
  %"local.clos/1067" = load i8** %"alloca.clos/1067"
  %adda1 = getelementptr inbounds i8* %"local.clos/1067", i64 32
  %load.addr2 = bitcast i8* %adda1 to i8**
  %load3 = load i8** %load.addr2
  %"alloca.clos/1068" = alloca i8*
  store i8* %load3, i8** %"alloca.clos/1068"
  %"local.clos/10674" = load i8** %"alloca.clos/1067"
  %adda5 = getelementptr inbounds i8* %"local.clos/10674", i64 24
  %load.addr6 = bitcast i8* %adda5 to i8**
  %load7 = load i8** %load.addr6
  %"local.clos/10668" = load i8** %"alloca.clos/1066"
  %adda9 = getelementptr inbounds i8* %"local.clos/10668", i64 16
  %load.addr10 = bitcast i8* %adda9 to i8**
  %load11 = load i8** %load.addr10
  %"local.arg/1065" = load i8** %"alloca.arg/1065"
  %"local.clos/1068" = load i8** %"alloca.clos/1068"
  %"local.clos/106812" = load i8** %"alloca.clos/1068"
  %adda13 = getelementptr inbounds i8* %"local.clos/106812", i64 16
  %load.addr14 = bitcast i8* %adda13 to i8**
  %load15 = load i8** %load.addr14
  %apply.fn = bitcast i8* %load15 to { i8*, i8*, i8* } (i8*, i8*, i8*, i8*, i8*, i8*)*
  %pass.caml_exception_pointer = load i8** %alloca.caml_exception_pointer
  %pass.caml_young_ptr = load i8** %alloca.caml_young_ptr
  %0 = tail call cc16 { i8*, i8*, i8* } %apply.fn(i8* %pass.caml_exception_pointer, i8* %pass.caml_young_ptr, i8* %load7, i8* %load11, i8* %"local.arg/1065", i8* %"local.clos/1068")
  %reload.caml_exception_pointer = extractvalue { i8*, i8*, i8* } %0, 0
  store i8* %reload.caml_exception_pointer, i8** %alloca.caml_exception_pointer
  %reload.caml_young_ptr = extractvalue { i8*, i8*, i8* } %0, 1
  store i8* %reload.caml_young_ptr, i8** %alloca.caml_young_ptr
  %apply = extractvalue { i8*, i8*, i8* } %0, 2
  %reload.caml_exception_pointer16 = load i8** %alloca.caml_exception_pointer
  %1 = insertvalue { i8*, i8*, i8* } undef, i8* %reload.caml_exception_pointer16, 0
  %reload.caml_young_ptr17 = load i8** %alloca.caml_young_ptr
  %2 = insertvalue { i8*, i8*, i8* } %1, i8* %reload.caml_young_ptr17, 1
  %3 = insertvalue { i8*, i8*, i8* } %2, i8* %apply, 2
  ret { i8*, i8*, i8* } %3
}

declare preserve_allcc i8* @caml_allocN(i64)
