(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: July, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"

(* ****** ****** *)

staload "pats_typerase.sats"

(* ****** ****** *)

implement
s2exp_tyer_deep
  (loc0, s2e0) = s2exp_tyer (loc0, 1(*flag*), s2e0)
// end of [s2exp_tyer_deep]

implement
s2exp_tyer_shallow
  (loc0, s2e0) = s2exp_tyer (loc0, 0(*flag*), s2e0)
// end of [s2exp_tyer_shallow]

(* ****** ****** *)

extern
fun s2hnf_tyer
  (loc: location, flag: int, s2f: s2hnf): hisexp
// end of [s2hnf_tyer]

(* ****** ****** *)

extern
fun s2cst_tyer
  (loc: location, flag: int, s2c: s2cst): hisexp
// end of [s2cst_tyer]

(* ****** ****** *)

extern
fun s2exp_tyer_app (
  loc: location, flag: int, s2t: s2rt, _fun: s2exp, _arg: s2explst
) : hisexp // end of [s2exp_tyer_app]
extern
fun s2exp_tyer_app2 (
  loc: location, flag: int, s2t: s2rt, _fun: s2exp, _arg: s2explst
) : hisexp // end of [s2exp_tyer_app2]
extern
fun s2exp_tyer_appcst (
  loc: location, flag: int, s2t: s2rt, _fun: s2cst, _arg: s2explst
) : hisexp // end of [s2exp_tyer_appcst]

(* ****** ****** *)

extern
fun s2exp_tyer_fun
  (loc: location, flag: int, s2e: s2exp): hisexp
// end of [s2exp_tyer_fun]

(* ****** ****** *)

extern
fun s2exp_tyer_tyarr
  (loc: location, flag: int, s2e: s2exp): hisexp
// end of [s2exp_tyer_tyarr]

extern
fun s2exp_tyer_tyrec
  (loc: location, flag: int, s2e: s2exp): hisexp
// end of [s2exp_tyer_tyrec]

(* ****** ****** *)

extern
fun s2explst_tyer
  (loc: location, s2es: s2explst): hisexplst
extern
fun s2explst_npf_tyer
  (loc: location, npf: int, s2es: s2explst): hisexplst

extern
fun labs2explst_tyer
 (loc: location, ls2es: labs2explst): labhisexplst
// end of [labs2explst_tyer]

extern
fun labs2explst_npf_tyer
  (loc: location, npf: int, ls2es: labs2explst): labhisexplst
// end of [labs2explst_npf_tyer]

(* ****** ****** *)

implement
s2exp_tyer
  (loc0, flag, s2e0) = let
  val s2f0 = s2exp2hnf (s2e0) in s2hnf_tyer (loc0, flag, s2f0)
end // end of [s2hnf_tyer]

(* ****** ****** *)

implement
s2hnf_tyer
  (loc0, flag, s2f0) = let
  val s2e0 = s2hnf2exp (s2f0)
in
//
case+
  s2e0.s2exp_node of
| S2Ecst (s2c) =>
    s2cst_tyer (loc0, flag, s2c)
| S2Evar (s2v) => hisexp_tyvar (s2v)
//
| S2Edatconptr _ => hisexp_typtr_con
| S2Edatcontyp
    (d2c, s2es) => let
    val npf = d2con_get_npf (d2c)
    val hses = s2explst_npf_tyer (loc0, npf, s2es)
  in
    hisexp_tysum (d2c, hses)
  end // end of [S2Edatcontyp]
//
| S2Eapp (
    s2e_fun, s2es_arg
  ) => let
    val s2t0 = s2e0.s2exp_srt
  in
    s2exp_tyer_app (loc0, flag, s2t0, s2e_fun, s2es_arg)
  end // end of [S2Eapp]
| S2Elam (_, s2e_body) => s2exp_tyer (loc0, flag, s2e_body)
//
| S2Efun _ => s2exp_tyer_fun (loc0, flag, s2e0)
| S2Emetfun (_, _, s2e_body) => s2exp_tyer (loc0, flag, s2e_body)
//
| S2Etop (_, s2e) => s2exp_tyer (loc0, flag, s2e)
| S2Ewithout (s2e) => s2exp_tyer (loc0, flag, s2e)
//
| S2Etyarr _ => s2exp_tyer_tyarr (loc0, flag, s2e0)
| S2Etyrec _ => s2exp_tyer_tyrec (loc0, flag, s2e0)
//
| S2Eexi (_, _, s2e) => s2exp_tyer (loc0, flag, s2e)
| S2Euni (_, _, s2e) => s2exp_tyer (loc0, flag, s2e)
//
| S2Erefarg
    (knd, s2e) => let
    val hse = s2exp_tyer_shallow (loc0, s2e)
  in
    hisexp_refarg (knd, hse)
  end // end of [S2Erefarg]
//
| S2Evararg (s2e) => hisexp_vararg (s2e)
| S2Ewth (s2e, _(*ws2es*)) => s2exp_tyer (loc0, flag, s2e)
//
| _ => hisexp_s2exp (s2e0)
//
end // end of [s2hnf_tyer]

(* ****** ****** *)

implement
s2cst_tyer
  (loc0, flag, s2c) = let
//
val opt = s2cst_get_isabs (s2c)
//
in
//
case+ opt of
| Some (opt2) => (
  case+ opt2 of
  | Some (s2e) =>
      s2exp_tyer (loc0, flag, s2e)
  | None () => let
      val s2t = s2cst_get_srt (s2c) in hisexp_make_srt (s2t)
    end // end of [None]
  ) // end of [Some]
| None () => let
    val s2t = s2cst_get_srt (s2c) in hisexp_make_srt (s2t)
  end // end of [None]
//
end // end of [s2cst_tyer]

(* ****** ****** *)

implement
s2exp_tyer_app (
  loc0, flag, s2t0, s2e_fun, s2es_arg
) = let
  val s2f_fun = s2exp2hnf (s2e_fun)
  val s2e_fun = s2hnf2exp (s2f_fun)
in
//
case+ s2e_fun.s2exp_node of
| S2Ecst (s2c) =>
    s2exp_tyer_appcst (loc0, flag, s2t0, s2c, s2es_arg)
| _ => hisexp_make_srt (s2t0)
//
end // end of [s2exp_tyer_app]

implement
s2exp_tyer_app2 (
  loc0, flag, s2t0, s2e_fun, s2es_arg
) = let
in
//
case+
  s2e_fun.s2exp_node of
| S2Elam (
    s2vs_arg, s2e_body
  ) => let
    var sub = stasub_make_nil ()
    val _(*err*) = stasub_addlst (sub, s2vs_arg, s2es_arg)
    val s2e_body = s2exp_subst (sub, s2e_body)
    val () = stasub_free (sub)
  in
    s2exp_tyer (loc0, flag, s2e_body)  
  end // end of [

// end of [stasub_addlst]

| _ => hisexp_make_srt (s2t0)
//
end // end of [s2exp_tyer_app2]

implement
s2exp_tyer_appcst (
  loc0, flag, s2t0, s2c, s2es_arg
) = let
  val opt = s2cst_get_isabs (s2c)
in
//
case+ opt of
| Some (opt2) => (
  case+ opt2 of
  | Some (s2e_fun) =>
      s2exp_tyer_app2 (loc0, flag, s2t0, s2e_fun, s2es_arg)
  | None () => hisexp_make_srt (s2t0)
  )
| None () => hisexp_make_srt (s2t0)
//
end // end of [s2exp_tyer_appcst]

(* ****** ****** *)

implement
s2exp_tyer_fun
  (loc0, flag, s2e0) = let
  val- S2Efun (
    fc, lin, s2fe, npf, s2es_arg, s2e_res
  ) = s2e0.s2exp_node // end of [val]
in
//
if flag > 0 then let
  val hses_arg =
    s2explst_npf_tyer (loc0, npf, s2es_arg)
  val hse_res = s2exp_tyer_shallow (loc0, s2e_res)
  val hse_res = hisexp_varetize (hse_res)
in
  hisexp_fun (fc, hses_arg, hse_res)
end else (
  case+ fc of
  | FUNCLOfun () => hisexp_typtr_fun
  | FUNCLOclo (knd) =>
      if knd = 0 then hisexp_tyclo else hisexp_typtr_clo
    // end of [FUNCLOclo]
) (* end of [if] *)
//
end // end of [s2exp_tyer_fun]

(* ****** ****** *)

implement
s2exp_tyer_tyarr
  (loc0, flag, s2e0) = let
  val- S2Etyarr
    (s2e_elt, dim) = s2e0.s2exp_node
  val hse_elt = s2exp_tyer (loc0, flag, s2e_elt)
in
  hisexp_tyarr (hse_elt, dim)
end // end of [s2exp_tyer_tyarr]

implement
s2exp_tyer_tyrec
  (loc0, flag, s2e0) = let
  val- S2Etyrec
    (knd, npf, ls2es) = s2e0.s2exp_node
  val lhses =
    labs2explst_npf_tyer (loc0, npf, ls2es)
  // end of [val]
in
//
case knd of
| TYRECKINDbox () => (
    if flag > 0 then
      hisexp_tyrec (knd, lhses) else hisexp_typtr
  ) // end of [TYRECKINDbox]
| TYRECKINDflt_ext _ => hisexp_tyrec (knd, lhses)
| _ (*TYRECKINDflt0/1*) => let
  in
    case+ lhses of
    | list_cons (
        lhse, list_nil ()
      ) => hisexp_tyrecsin (lhse)
    | _ => hisexp_tyrec (knd, lhses)
  end // end of [TYRECKINDflt0/1]
//
end // end of [s2exp_tyer_tyrec]

(* ****** ****** *)

implement
s2explst_tyer
  (loc0, s2es) = let
in
//
case+ s2es of
| list_cons
    (s2e, s2es) => let
    val isprf = s2exp_is_prf (s2e)
  in
    if isprf then
      s2explst_tyer (loc0, s2es)
    else let
      val hse =
        s2exp_tyer_shallow (loc0, s2e)
      // end of [val]
      val hses = s2explst_tyer (loc0, s2es)
    in
      list_cons (hse, hses)
    end // end of [if]
  end
| list_nil () => list_nil ()
//
end // end of [s2explst_tyer]

(* ****** ****** *)

implement
s2explst_npf_tyer
  (loc0, npf, s2es) = let
in
//
if npf > 0 then let
  val- list_cons (_, s2es) = s2es in s2explst_npf_tyer (loc0, npf-1, s2es)
end else
  s2explst_tyer (loc0, s2es)
// end of [if]
//
end // end of [s2explst_npf_tyer]

(* ****** ****** *)

implement
labs2explst_tyer
  (loc0, ls2es) = let
in
//
case+ ls2es of
| list_cons
    (ls2e, ls2es) => let
    val SLABELED (l, name, s2e) = ls2e
    val isprf = s2exp_is_prf (s2e)
  in
    if isprf then
      labs2explst_tyer (loc0, ls2es)
    else let
      val hse = s2exp_tyer_shallow (loc0, s2e)
      val lhse = HSLABELED (l, name, hse)
      val lhses = labs2explst_tyer (loc0, ls2es)
    in
      list_cons (lhse, lhses)
    end (* end of [if] *)
  end
| list_nil () => list_nil ()
//
end // end of [labs2explst_tyer]

(* ****** ****** *)

implement
labs2explst_npf_tyer
  (loc0, npf, ls2es) = let
in
//
if npf > 0 then let
  val- list_cons (_, ls2es) = ls2es in labs2explst_npf_tyer (loc0, npf-1, ls2es)
end else
  labs2explst_tyer (loc0, ls2es)
// end of [if]
//
end // end of [labs2explst_npf_tyer]

(* ****** ****** *)

(* end of [pats_typerase_staexp.dats] *)