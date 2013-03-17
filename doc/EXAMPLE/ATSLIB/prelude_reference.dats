(*
** for testing [prelude/reference]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

val () = {
//
typedef T = int
//
val r = ref<T> (0)
val () = !r := !r + 1
val () = assertloc (!r = 1)
val () = !r := 2 * !r
val () = assertloc (!r = 2)
//
} // end of [val]

(* ****** ****** *)

val () = {
//
typedef T = int
//
val r1 = ref<T> (1)
val r2 = ref<T> (2)
val () = assertloc (!r1 = 1)
val () = assertloc (!r2 = 2)
val () = !r1 :=: !r2
val () = assertloc (!r1 = 2)
val () = assertloc (!r2 = 1)
} // end of [val]

(* ****** ****** *)

val () = {
//
typedef T2 = @(int, double)
//
val r = ref<T2> @(1, 1.0)
val () = !r.0 := !r.0 + 1
val () = assertloc (!r.0 = 2)
val () = !r.1 := !r.1 + 1.0
val () = assertloc (!r.1 = 2.0)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_reference.dats] *)
