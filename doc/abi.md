ABI of OCaml code
=================

OCaml has a custom ABI, including an unique calling convention incompatible
with the C calling convention. Unfortunately, none of this is documented.
In this note, I'm describing the parts I have figured out.

When linking to OCaml's assembly in `libasmrun`, I use the ARM support
code as an example, because i386 is too arcane to serve as a generic
example, and amd64 assembly is nearly incomprehensible.

Common
------

In general, OCaml's calling conventions on different architectures have
two common properties:

  * All registers are caller-save.
  * Several registers are pinned to certain global values.

The implications of this are subtle and extremely important.

### Caller-save registers

First, having all registers defined as caller-save enables OCaml to use
its exception handling mechanism for control flow without a performance
hit.

While OCaml's exceptions cannot cause arbitrary code to execute in
intermediate stack frames (like with C++'s RAII), simply modelling
them with setjmp/longjmp would not be wise. Indeed, traditional
setjmp/longjmp [implementation][sjlj] would be required to restore
caller-save registers on every raise and, more importantly, save
them on every enter of a try block. This is unacceptable.

However, if there are no caller-save registers, a longjmp is just
a long jump and restoration of a stack pointer. Conversely, a setjmp
only requires to push the address of the frame (and its address
is the saved stack pointer value); see the [implementation][sjljcaml].

[sjlj]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/x86_64/__longjmp.S;h=fbac0d91524698b3612526bbf5a3df8e1ed81393;hb=HEAD
[sjljcaml]: https://github.com/ocaml/ocaml/blob/trunk/asmrun/arm.S#L283

Second, OCaml has a precise GC. That is, the compiler outputs the map
of the stack frame for every possible return address, indicating where
the live pointers reside on stack. When the GC is called, it traverses
the stack, and for every saved return address adds the corresponding
pointers from the stack frame to the live set.

If OCaml's calling convention included any callee-saved registers, how
would the callee know whether the value in the register is live or not?
But the caller is, by definition, aware of that.

### Pinned registers

To reduce memory accesses as much as possible, OCaml pins some of its
most commonly useful variables to registers. The set of pinned variables
differs from architecture to architecture due to different amount
of registers and register pressure.

Obviously, the C code OCaml calls would neither preserve nor allow to
access these registers in a portable way. As such, it is necessary to
write-back the values in registers back to the C-accessible global
variables they're pinned to.

Tail call elimination
---------------------

A fascinating tidbit is that OCaml is unable to make a call tail call
if the call requires passing some parameters on the stack (the callee
wouldn't know how much to pop from the stack). As such, every architecture
has a specific limit on how much arguments one can pass while retaining
TCO. Presently calls with at least 8 arguments are always TCO'd.

Garbage collector
-----------------

OCaml's ABI necessitates some very intricate code to interact with the
garbage collector. The glue code resides in five functions,
`caml_alloc1`, `caml_alloc2`, `caml_alloc3`, `caml_allocN` and
`caml_call_gc`.

All of the `caml_alloc*` functions are very similar (see the
[implementation][camlalloc]). First, they check whether there is enough
space in the young generation for the object they need to allocate.
This is a simple bump-pointer allocator, and as such, the check is
a single integer comparison. Second, if the young generation space is
exhausted, they call the GC and try again.

I'm not entirely sure why are there four of these functions, given
they differ by a single constant, but my theory is that on architectures
with very few registers, i.e. i386, this helps reduce the pressure
on register allocator.

Note that, unlike with regular OCaml or C function calls, the `caml_alloc*`
functions do **not** require the caller to save any registers. Indeed,
the common case (a single pointer bump) can be implemented so that it
clobbers only a single register, which is also used for the return
value.

Based on the previous paragraph, you may guess that the `caml_call_gc`
would need to save all registers. This is correct; [implementation][camlgc].
In addition, this means that while there are no roots in register
*across procedure calls*, there can be roots in registers *across calls
to allocator*. Indeed, OCaml's code generator will emit a map indicating whether
there are any live values in registers, and the GC will [consume][gcreg]
it.

[camlalloc]: https://github.com/ocaml/ocaml/blob/trunk/asmrun/arm.S#L126
[camlgc]: https://github.com/ocaml/ocaml/blob/trunk/asmrun/arm.S#L92
[gcreg]: https://github.com/ocaml/ocaml/blob/trunk/asmrun/roots.c#L197

AMD64
-----

Pinned registers:

r14
: caml_exception_pointer

r15
: caml_young_ptr

Maximum number of arguments for TCO: 10.

ARM
---

Pinned registers:

r8
: caml_exception_pointer

r10
: caml_young_ptr

r11
: caml_young_limit

Maximum number of arguments for TCO: 8.

i386
----

No pinned registers.

Maximum number of arguments for TCO: 22. (6 of them are passed in registers.
The rest are stuffed into a `caml_extra_params` global.)

POWER
-----

Pinned registers:

r29
: caml_exception_pointer

r30
: caml_young_limit

r31
: caml_young_ptr

Maximum number of arguments for TCO: 8.

SPARC
-----

Pinned registers:

%l5
: caml_exception_pointer

%l6
: caml_young_limit

%l7
: caml_young_ptr

Maximum number of arguments for TCO: 10.
