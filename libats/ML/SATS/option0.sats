(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)
//
castfn
option0_of_option
  {a:t@ype} (xs: Option a):<> option0 (a)
castfn
option0_of_option_vt
  {a:t@ype} (xs: Option_vt a):<> option0 (a)
//
(* ****** ****** *)

castfn
g0ofg1_option {a:t@ype} (xs: Option (a)):<> option0 (a)
overload g0ofg1 with g0ofg1_option

castfn
g1ofg0_option {a:t@ype} (xs: option0 (a)):<> Option (a)
overload g1ofg0 with g1ofg0_option

(* ****** ****** *)
//
fun{
} option0_none
  {a:t0p} ((*void*)):<> option0 (a)
//
fun{
a:t0p
} option0_some (x: a):<> option0 (a)
//
(* ****** ****** *)

fun{}
option0_is_none {a:t0p} (x: option0 a):<> bool
overload iseqz with option0_is_none

fun{}
option0_is_some {a:t0p} (x: option0 a):<> bool
overload isneqz with option0_is_some

(* ****** ****** *)

fun{a:t0p}
option0_unsome_exn (opt: option0 (a)):<!exn> a

(* ****** ****** *)

fun{a:t0p}
fprint_option0 (out: FILEref, opt: option0 (a)): void
overload fprint with fprint_option0

(* ****** ****** *)

(* end of [option0.sats] *)
