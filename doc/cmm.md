Cmm layer
=========

Cmm (like C--) layer is OCaml's last machine-independent intermediate
representation. In many respects it looks like an SSA IR, e.g. LLVM IR;
indeed, the translation is almost 1:1, save for oddity of some Cmm
constructs.

Aggregates
----------

Cmm has a `type machtype = machtype_component list`, but it appears
that the only values of this type are `[||]`, i.e. `unit`,
and `[|Int|]`, `[|Float|]`, `[|Addr|]`.

Tuple
-----

Cmm has a `Ctuple elems` constructor. The name is a bit deceptive. In
reality, Cmmgen only ever generates values of form `Ctuple []`, which
are equivalent to OCaml's unit value `()`, or `Const_int 1`.

Values of `Ctuple` with non-empty `elems` never directly appear in
Cmm IR. Instead, they're used as constructor arguments for some Mach
constructors; it appears that they're used for grouping arguments
for the intermediate representation corresponding to LEA-like
instructions on i386 and power.

If/then/else
------------

Cmm has a `Cifthenelse` operation. It receives an integer which is either
`0` or `1`.

Load/store
----------

`Cop (Cload _)` and `Cop (Cstore _)` imply that a loaded/stored value
is extended/truncated to fit one of the three basic data types,
`Int`, `Float` and `Addr`.

Exit/catch
----------

Cmm has a peculiar control flow construct, `Cexit`/`Ccatch`. It looks
like exception raising/handling, but in reality it's a direct branch.
Essentially, `Ccatch (id, vars, body, handler)` creates two basic
blocks for `body` and `handler`, and `Cexit (id, vars)` creates a jump
to `handler`. `vars` in `Ccatch` would correspond to a phi node using
all of the `vars` from corresponding `Cexit`s.

For example, consider the following Cmm IR (note that Cmmparse currently
cannot parse it, even though it's valid):

```
(function "foo" (x: int)
 (catch
  (let (xbis
        (if (> x 10) (exit 0 10)
         (if (> x 20) (exit 0 20) x)))
   (app "bar" xbis int))
  with(0 ret) ret))
```

It is roughly equivalent to the following SSA-form LLVM IR:

```
define i32 @foo(i32 %x) {
cmp1:
  %f1 = icmp gt i32 %x, 10
  br i1 %f1, label %catch, label %cmp2
cmp2:
  %f2 = icmp gt i32 %x, 20
  br i1 %f2, label %catch, label %app
app:
  %res = i32 call @bar(i32 %x)
  ret i32 %res
catch:
  %x.phi = phi i32 [i32 10, %cmp1], [i32 20, %cmp2]
  ret i32 %x.phi
}
```

Let/var/assign
--------------

Cmm has three binding constructs: `Clet`, `Cvar` and `Cassign`. It is
wrong to think of them as if they create mutable bindings. Rather, these
constructs are creating SSA phi nodes, for a subset of all possible phi
nodes and all possible control flow.

First, consider an example implementation:

``` ocaml
let compile env expr =
  match expr with
  | Cvar id ->
    Hashtbl.find env id
  | Clet (id, bind, body) ->
    Hashtbl.add env id (compile env bind);
    let result = compile env body in
    Hashtbl.remove env id;
    result
  | Cassign (id, bind) ->
    Hashtbl.replace env (compile env bind)
  | _ -> (* compile everything else *)
```

Consider the Cmm IR with the following structure:

```
(function "foo" ()
 (let (x 0)
  (catch
   (loop
    (if (< x 5)
     (assign x (- x 1))
     (exit 0))
   with (0) [] 0i))))
```

It is roughly equivalent to the following SSA-form LLVM IR:

```
define i32 @foo() {
entry:
  %x.init = i32 0
  br label %loop
loop:
  %x = phi i32 [ %x.init, %entry ], [ %x.sub, %loop.1 ]
  %f = icmp slt i32 %x, 5
  br i1 %f, label %loop.1, label %exit
loop.1:
  %x.sub = sub i32 %x, 1
  br label %loop
exit:
  ret i32 0
}
```
