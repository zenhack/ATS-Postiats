(*
** Copyright (C) 2012 Hongwei Xi, Boston University
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ******)
//
// Author: Hongwei Xi (2012-03)
//
(* ****** ****** *)

staload "doc/EXAMPLE/ARITH/tally.sats"

(* ****** ****** *)

implement
sum1 (pf) = let
//
prfun sum1
  {n:nat}{s:int} .<n>. (
  pf: SUM1 (n, s)
) : [cff1*s==csum1(n)] void =
  sif n > 0 then let
    val SUM1ind (pf1) = pf
    val () = sum1 {n-1} (pf1)
  in
    // nothing
  end else let
    val SUM1bas () = pf in (*nothing*)
  end // end of [sif]
//
in
  sum1 (pf)
end // end of [sum1]

(* ****** ****** *)

implement
sum2 (pf) = let
//
prfun sum2
  {n:nat}{s:int} .<n>. (
  pf: SUM2 (n, s)
) : [cff2*s==csum2(n)] void =
  sif n > 0 then let
    val SUM2ind (pf1) = pf
    val () = sum2 {n-1} (pf1)
  in
    // nothing
  end else let
    val SUM2bas () = pf in (*nothing*)
  end // end of [sif]
//
in
  sum2 (pf)
end // end of [sum2]

(* ****** ****** *)

implement
sum3 (pf) = let
//
prfun sum3
  {n:nat}{s:int} .<n>. (
  pf: SUM3 (n, s)
) : [cff3*s==csum3(n)] void =
  sif n > 0 then let
    val SUM3ind (pf1) = pf
    val () = sum3 {n-1} (pf1)
  in
    // nothing
  end else let
    val SUM3bas () = pf in (*nothing*)
  end // end of [sif]
//
in
  sum3 (pf)
end // end of [sum3]

(* ****** ****** *)

implement
sum4 (pf) = let
//
prfun sum4
  {n:nat}{s:int} .<n>. (
  pf: SUM4 (n, s)
) : [cff4*s==csum4(n)] void =
  sif n > 0 then let
    val SUM4ind (pf1) = pf
    val () = sum4 {n-1} (pf1)
  in
    // nothing
  end else let
    val SUM4bas () = pf in (*nothing*)
  end // end of [sif]
//
in
  sum4 (pf)
end // end of [sum4]

(* ****** ****** *)

implement
sum5 (pf) = let
//
prfun sum5
  {n:nat}{s:int} .<n>. (
  pf: SUM5 (n, s)
) : [cff5*s==csum5(n)] void =
  sif n > 0 then let
    val SUM5ind (pf1) = pf
    val () = sum5 {n-1} (pf1)
  in
    // nothing
  end else let
    val SUM5bas () = pf in (*nothing*)
  end // end of [sif]
//
in
  sum5 (pf)
end // end of [sum5]

(* ****** ****** *)

implement
sum6 (pf) = let
//
prfun sum6
  {n:nat}{s:int} .<n>. (
  pf: SUM6 (n, s)
) : [cff6*s==csum6(n)] void =
  sif n > 0 then let
    val SUM6ind (pf1) = pf
    val () = sum6 {n-1} (pf1)
  in
    // nothing
  end else let
    val SUM6bas () = pf in (*nothing*)
  end // end of [sif]
//
in
  sum6 (pf)
end // end of [sum6]

(* ****** ****** *)

implement
sum7 (pf) = let
//
prfun sum7
  {n:nat}{s:int} .<n>. (
  pf: SUM7 (n, s)
) : [cff7*s==csum7(n)] void =
  sif n > 0 then let
    val SUM7ind (pf1) = pf
    val () = sum7 {n-1} (pf1)
  in
    // nothing
  end else let
    val SUM7bas () = pf in (*nothing*)
  end // end of [sif]
//
in
  sum7 (pf)
end // end of [sum7]

(* ****** ****** *)

implement
sum8 (pf) = let
//
prfun sum8
  {n:nat}{s:int} .<n>. (
  pf: SUM8 (n, s)
) : [cff8*s==csum8(n)] void =
  sif n > 0 then let
    val SUM8ind (pf1) = pf
    val () = sum8 {n-1} (pf1)
  in
    // nothing
  end else let
    val SUM8bas () = pf in (*nothing*)
  end // end of [sif]
//
in
  sum8 (pf)
end // end of [sum8]

(* ****** ****** *)

implement
sum9 (pf) = let
//
prfun sum9
  {n:nat}{s:int} .<n>. (
  pf: SUM9 (n, s)
) : [cff9*s==csum9(n)] void =
  sif n > 0 then let
    val SUM9ind (pf1) = pf
    val () = sum9 {n-1} (pf1)
  in
    // nothing
  end else let
    val SUM9bas () = pf in (*nothing*)
  end // end of [sif]
//
in
  sum9 (pf)
end // end of [sum9]

(* ****** ****** *)

implement
sum10 (pf) = let
//
prfun sum10
  {n:nat}{s:int} .<n>. (
  pf: SUM10 (n, s)
) : [cff10*s==csum10(n)] void =
  sif n > 0 then let
    val SUM10ind (pf1) = pf
    val () = sum10 {n-1} (pf1)
  in
    // nothing
  end else let
    val SUM10bas () = pf in (*nothing*)
  end // end of [sif]
//
in
  sum10 (pf)
end // end of [sum10]

(* ****** ****** *)

(* end of [tally.dats] *)