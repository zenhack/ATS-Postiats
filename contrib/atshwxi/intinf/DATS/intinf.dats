(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2013-02:
// A package for multiple-precision integers
//
(* ****** ****** *)

staload
GMP = "libgmp/SATS/gmp.sats"
stadef mpz = $GMP.mpz_vt0ype

(* ****** ****** *)
//
staload
"atshwxi/intinf/SATS/intinf.sats"
//
(* ****** ****** *)

local

assume
intinf_vtype
  (i: int) = // HX: [i] is a fake
  [l:addr] (mpz @ l, mfree_gc_v (l) | ptr l)
// end of [intinf_vtype]

in (* in of [local] *)

implement{}
intinf_make_int
  (i) = (x) where
{
//
val x = ptr_alloc<mpz> ()
val () = $GMP.mpz_init_set_int (!(x.2), i)
//
} (* end of [intinf_make_int] *)

implement{}
intinf_make_uint
  (i) = (x) where
{
//
val x = ptr_alloc<mpz> ()
val () = $GMP.mpz_init_set_uint (!(x.2), i)
//
} (* end of [intinf_make_uint] *)

implement{}
intinf_make_lint
  (i) = (x) where
{
//
val x = ptr_alloc<mpz> ()
val () = $GMP.mpz_init_set_lint (!(x.2), i)
//
} (* end of [intinf_make_lint] *)

implement{}
intinf_make_ulint
  (i) = (x) where
{
//
val x = ptr_alloc<mpz> ()
val () = $GMP.mpz_init_set_ulint (!(x.2), i)
//
} (* end of [intinf_make_ulint] *)

(* ****** ****** *)

implement{}
intinf_free (x) = let
  val (pfat, pfgc | p) = x
  val () = $GMP.mpz_clear (!p) in ptr_free (pfgc, pfat | p)
end (* end of [intinf_free] *)

(* ****** ****** *)

implement{}
fprint_intinf_base
  (out, x, base) = let
  val nsz = $GMP.mpz_out_str (out, base, !(x.2))
in
//
if (nsz = 0) then
  exit_errmsg (1, "libgmp/gmp: fprint_intinf_base")
// end of [if]
//
end (* fprint_intinf_base *)

(* ****** ****** *)

implement{
} neg_intinf0
  (x) = (x) where
{
//
val () = $GMP.mpz_neg (!(x.2))
//
} (* end of [neg_intinf0] *)

implement{
} neg_intinf1
  (x) = (y) where
{
//
val y = ptr_alloc<mpz> ()
val () = $GMP.mpz_init (!(y.2))
val () = $GMP.mpz_neg (!(y.2), !(x.2))
//
} (* end of [neg_intinf1] *)

(* ****** ****** *)

implement{}
succ_intinf0 (x) = add_intinf0_int (x, 1)
implement{}
succ_intinf1 (x) = add_intinf1_int (x, 1)

(* ****** ****** *)

implement{}
pred_intinf0 (x) = sub_intinf0_int (x, 1)
implement{}
pred_intinf1 (x) = sub_intinf1_int (x, 1)

(* ****** ****** *)

implement{}
add_intinf0_int
  (x, y) = (x) where
{
//
val () = $GMP.mpz_add2_int (!(x.2), y)
//
} (* end of [add_intinf0_int] *)

implement{}
add_intinf1_int
  (x, y) = (z) where
{
//
val z = ptr_alloc<mpz> ()
val () = $GMP.mpz_init (!(z.2))
val () = $GMP.mpz_add3_int (!(z.2), !(x.2), y)
//
} (* end of [add_intinf1_int] *)

(* ****** ****** *)

implement{}
add_int_intinf0 (x, y) = add_intinf0_int (y, x)
implement{}
add_int_intinf1 (x, y) = add_intinf1_int (y, x)

(* ****** ****** *)

implement{}
add_intinf0_intinf1
  (x, y) = (x) where
{
//
val () = $GMP.mpz_add2_mpz (!(x.2), !(y.2))
//
} (* end of [add_intinf0_intinf1] *)

implement{}
add_intinf1_intinf0
  (x, y) = (y) where
{
//
val () = $GMP.mpz_add2_mpz (!(y.2), !(x.2))
//
} (* end of [add_intinf1_intinf0] *)

(* ****** ****** *)

implement{}
add_intinf1_intinf1
  (x, y) = (z) where
{
//
val z = ptr_alloc<mpz> ()
val () = $GMP.mpz_init (!(z.2))
val () = $GMP.mpz_add3_mpz (!(z.2), !(x.2), !(y.2))
//
} (* end of [add_intinf1_intinf1] *)

(* ****** ****** *)

implement{}
sub_intinf0_int
  (x, y) = (x) where
{
//
val () = $GMP.mpz_sub2_int (!(x.2), y)
//
} (* end of [sub_intinf0_int] *)

implement{}
sub_intinf1_int
  (x, y) = (z) where
{
//
val z = ptr_alloc<mpz> ()
val () = $GMP.mpz_init (!(z.2))
val () = $GMP.mpz_sub3_int (!(z.2), !(x.2), y)
//
} (* end of [sub_intinf1_int] *)

(* ****** ****** *)

implement{}
sub_int_intinf0 (x, y) = sub_intinf0_int (y, x)
implement{}
sub_int_intinf1 (x, y) = sub_intinf1_int (y, x)

(* ****** ****** *)

implement{}
sub_intinf1_intinf1
  (x, y) = (z) where
{
//
val z = ptr_alloc<mpz> ()
val () = $GMP.mpz_init (!(z.2))
val () = $GMP.mpz_sub3_mpz (!(z.2), !(x.2), !(y.2))
//
} (* end of [sub_intinf1_intinf1] *)

(* ****** ****** *)

implement{}
mul_intinf0_int
  (x, y) = (x) where
{
//
val () = $GMP.mpz_mul2_int (!(x.2), y)
//
} (* end of [mul_intinf0_int] *)

implement{}
mul_intinf1_int
  (x, y) = (z) where
{
//
val z = ptr_alloc<mpz> ()
val () = $GMP.mpz_init (!(z.2))
val () = $GMP.mpz_mul3_int (!(z.2), !(x.2), y)
//
} (* end of [mul_intinf1_int] *)

(* ****** ****** *)

implement{}
mul_int_intinf0 (x, y) = mul_intinf0_int (y, x)
implement{}
mul_int_intinf1 (x, y) = mul_intinf1_int (y, x)

(* ****** ****** *)

implement{}
mul_intinf0_intinf1
  (x, y) = (x) where
{
//
val () = $GMP.mpz_mul2_mpz (!(x.2), !(y.2))
//
} (* end of [mul_intinf0_intinf1] *)

implement{}
mul_intinf1_intinf0
  (x, y) = (y) where
{
//
val () = $GMP.mpz_mul2_mpz (!(y.2), !(x.2))
//
} (* end of [mul_intinf0_intinf1] *)

(* ****** ****** *)

implement{}
mul_intinf1_intinf1
  (x, y) = (z) where
{
//
val z = ptr_alloc<mpz> ()
val () = $GMP.mpz_init (!(z.2))
val () = $GMP.mpz_mul3_mpz (!(z.2), !(x.2), !(y.2))
//
} (* end of [mul_intinf1_intinf1] *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement{}
print_intinf (x) = fprint_intinf (stdout_ref, x)
implement{}
prerr_intinf (x) = fprint_intinf (stderr_ref, x)
implement{}
fprint_intinf (out, x) = fprint_intinf_base (out, x, 10(*base*))

(* ****** ****** *)

(* end of [intinf.dats] *)
