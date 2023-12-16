---
layout: post
title: "Send and Sync"
author: Yiming Zhang
release: true
---

**Send** and **Sync** are the two fundamental traits to Rust's concurrency but to understand
them is kind of hard. Here is a simple summary of the materials related to this topic.

The official definition of these two traits are:

- **Send**: Types that can be transferred across thread boundaries.
- **Synd**: Types for which it is safe to share references between threads.

A more understandable and clear definition might be:

- **Send**: Types with safe _unique access_ between different threads.
- **Sync**: Types with safe _shared access_ between different threads.

The _unique access_ here includes both unique ownership(send by value) as well as the unique
reference(send by `&mut T`).

The reference rules in rust make sure most _primitive types_ are both **Send** and **Sync**
inheriently. Aside from the raw pointers, the _interior mutability_ is the source of the most
of `!Sync` and `!Send`.

To make these two traits work well, there are already some firewalls:
- They are `unsafe` traits: other unsafe code can assume that they are correctly implemented.
Since they're marker traits (they have no associated items like methods), correctly implemented 
simply means that they have the intrinsic properties an implementor should have. Incorrectly 
implementing `Send` or `Sync` can cause Undefined Behavior.
- `Send` and `Sync` are also automatically derived traits. This means that, unlike every other trait, 
if a type is composed entirely of `Send` or `Sync` types, then it is Send or Sync. 

## `!Sync`

A type is `!Sync` when the public non-`unsafe` `&`-based APIs allow to perform mutation **without 
synchronisation mechanisms**, such as `Cell` or `RefCell`.

However, if all the public non-`unsafe` `&`-based APIs that could perform mutation do guard against 
data races through synchronization primitives. In such cases, such as with `AtomicBool`, `AtomicU8`, 
`Atomic`..., as well as `Mutex` or `RwLock`, we get `Sync`-ness back!

Additionally, Since sharing is transitive (if you share a shared reference to something, then you are
ultimately sharing that thing: from a `&&T` one can get a `&T`, and vice versa): `T : Sync ⇔ &'_ T : Sync`.

## `!Send`

When `T: !Sync`, consider type subject to:
- when owned, yield a `&T`(e.g. `&T`, `Arc<T>`, `&Arc<T>` ...);
- be "copyable" or cloneable;

We can share the unsafe(`!Sync`) `&T` across the thread by first _copying or cloning_ the object then
sending them across the threads. Now, we have the original handle, and the sent one, which refer to the
same entity (it is thus _shared_), from across thread boundaries. Thus these type should not be `Send`
to guarantee the safety of the shared access.

## Summary

To summarize up, we have following rules:

- `T`: `Sync` ⇔ `&T`: `Send` (by definition)
- `&mut T`: `Send` ⇔ `T`: `Send`(by definition)
- `&T`/`&mut T`: `Sync` ⇔ `T`: `Sync`(by sharing transitive)

When we lose `Sync` somewhere, we lose _both_ `Sync` and `Send` at the next level of indirection, hence
why we mostly encounter:
- `Send + !Sync` types, which are the "original `!Sync` type" (`Cell` and `RefCell`)
- `!Send + !Sync`, which are the types that manipulate shared handles to `!Sync` types. `Rc<T>` is such an example.

Additionally, raw pointers are neither `Send` nor `Sync` since they have no safety guards.

## Reference

- [Rust docs for `std::marker::Send`](https://doc.rust-lang.org/std/marker/trait.Send.html)
- [Rust docs for `std::marker::Sync`](https://doc.rust-lang.org/std/marker/trait.Sync.html)
- [The Nomicon](https://doc.rust-lang.org/nomicon/send-and-sync.html)
- [Related discussion](https://users.rust-lang.org/t/example-of-a-type-that-is-not-send/59835)

