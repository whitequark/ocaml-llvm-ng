@caml_last_return_address = external global i8*
@caml_bottom_of_stack     = external global i8*
@caml_gc_regs             = external global i8*
@caml_young_ptr           = external global i8*
@caml_young_limit         = external global i8*
@caml_exception_pointer   = external global i8*

declare void @caml_garbage_collection()

define preserve_allcc void @caml_call_gc() {
entry:
  call void @caml_garbage_collection()
  ret void
}

define preserve_allcc void @caml_allocN(i64 %size) {
entry:
  br label %loop
loop:

  call preserve_allcc void @caml_call_gc()
  ret void
}
