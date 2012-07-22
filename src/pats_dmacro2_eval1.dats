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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: July, 2012
//
(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_dmacro2_eval0"

(* ****** ****** *)

staload LOC = "pats_location.sats"
overload print with $LOC.print_location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

staload "pats_dmacro2.sats"

(* ****** ****** *)

extern
fun d2var_rename
  (loc0: location, d2v: d2var): d2var
implement
d2var_rename (loc0, d2v) = d2v // HX: is this okay?

(* ****** ****** *)

extern fun eval1_p2atlst
  (loc0: location, env: &alphenv, p2ts: p2atlst): p2atlst
extern fun eval1_labp2at
  (loc0: location, env: &alphenv, lp2t: labp2at): labp2at
extern fun eval1_labp2atlst
  (loc0: location, env: &alphenv, lp2ts: labp2atlst): labp2atlst

(* ****** ****** *)

implement
eval1_p2at 
  (loc0, env, p2t0) = let
  val () = println! ("eval1_p2at: p2t0 = ", p2t0)
in
//
case+
  p2t0.p2at_node of
//
| P2Tany _ => p2at_any (loc0)
//
| P2Tvar (d2v) => let
    val d2v_new =
      d2var_rename (loc0, d2v)
    val () =
      alphenv_dadd (env, d2v, d2v_new)
    // end of [val]
  in
    p2at_var (loc0, d2v_new)
  end // end of [P2Tvar]
//
| P2Trec (knd, npf, lp2ts) => let
    val lp2ts =
      eval1_labp2atlst (loc0, env, lp2ts)
  in
    p2at_rec (loc0, knd, npf, lp2ts)
  end // end of [P2Trec]
| P2Tlst (lin, p2ts) => let
    val p2ts = eval1_p2atlst (loc0, env, p2ts)
  in
    p2at_lst (loc0, lin, p2ts)
  end // end of [P2Tlst]
//
| P2Tann (p2t, s2e) => let
    val p2t = eval1_p2at (loc0, env, p2t)
  in
    p2at_ann (loc0, p2t, s2e)
  end // end of [P2Tann]
//
| _ => let
    val () = println! ("eval1_p2at: not implemented yet")
  in
    exitloc (1)
  end // end of [_]
//
end // end of [eval1_p2at]

(* ****** ****** *)

implement
eval1_p2atlst
  (loc0, env, p2ts) = let
in
//
case+ p2ts of
| list_cons (p2t, p2ts) => let
    val p2t = eval1_p2at (loc0, env, p2t)
    val p2ts = eval1_p2atlst (loc0, env, p2ts)
  in
    list_cons (p2t, p2ts)
  end
| list_nil () => list_nil ()
//
end // end of [eval1_p2atlst]

(* ****** ****** *)

implement
eval1_labp2at
  (loc0, env, lp2t) = let
in
//
case+ lp2t of
| LABP2ATnorm (l, p2t) =>
    LABP2ATnorm (l, eval1_p2at (loc0, env, p2t))
| LABP2ATomit _ => LABP2ATomit (loc0)
//
end // end of [eval1_labp2at]

implement
eval1_labp2atlst
  (loc0, env, lp2ts) = let
in
//
case+ lp2ts of
| list_cons (lp2t, lp2ts) => let
    val lp2t = eval1_labp2at (loc0, env, lp2t)
    val lp2ts = eval1_labp2atlst (loc0, env, lp2ts)
  in
    list_cons (lp2t, lp2ts)
  end
| list_nil () => list_nil ()
//
end // end of [eval1_labp2atlst]

(* ****** ****** *)

typedef
eval1_type (a:type) =
  (location(*loc0*), !evalctx, &alphenv, a) -> a
// end of [eval1_type]

(* ****** ****** *)

extern fun eval1_s2exp : eval1_type (s2exp)
extern fun eval1_s2explst : eval1_type (s2explst)
extern fun eval1_s2exparg : eval1_type (s2exparg)
extern fun eval1_s2exparglst : eval1_type (s2exparglst)

(* ****** ****** *)

implement
eval1_s2exp
  (loc0, ctx, env, s2e) = s2e // HX: dummy for now
// end of [eval1_s2exp]

implement
eval1_s2explst (
  loc0, ctx, env, s2es
) = let
in
//
case+ s2es of
| list_cons
    (s2e, s2es) => let
    val s2e = eval1_s2exp (loc0, ctx, env, s2e)
    val s2es = eval1_s2explst (loc0, ctx, env, s2es)
  in
    list_cons (s2e, s2es)
  end // end of [list_cons]
| list_nil () => list_nil()
//
end // end of [eval1_s2explst]

(* ****** ****** *)

implement
eval1_s2exparg (
  loc0, ctx, env, s2a
) = let
  val s2an = s2a.s2exparg_node
in
//
case+ s2an of
| S2EXPARGone () => s2exparg_one (loc0)
| S2EXPARGall () => s2exparg_all (loc0)
| S2EXPARGseq (s2es) =>
    s2exparg_seq (loc0, eval1_s2explst (loc0, ctx, env, s2es))
  // end of [S2EXPARGseq]
//
end // end of [eval1_s2exparg]

implement
eval1_s2exparglst (
  loc0, ctx, env, s2as
) = let
in
//
case+ s2as of
| list_cons
    (s2a, s2as) => let
    val s2a = eval1_s2exparg (loc0, ctx, env, s2a)
    val s2as = eval1_s2exparglst (loc0, ctx, env, s2as)
  in
    list_cons (s2a, s2as)
  end // end of [list_cons]
| list_nil () => list_nil()
//
end // end of [eval1_s2exparglst]

(* ****** ****** *)

extern fun eval1_d2var : eval1_type (d2var)
extern fun eval1_d2explst : eval1_type (d2explst)
extern fun eval1_d2expopt : eval1_type (d2expopt)
extern fun eval1_d2exparg : eval1_type (d2exparg)
extern fun eval1_d2exparglst : eval1_type (d2exparglst)

(* ****** ****** *)

extern fun eval1_d2exp_applst : eval1_type (d2exp)
extern fun eval1_d2exp_macsyn : eval1_type (d2exp)

(* ****** ****** *)

implement
eval1_d2var
  (loc0, ctx, env, d2v) = let
  val opt = alphenv_dfind (env, d2v)
in
  case+ opt of
  | ~Some_vt (d2v) => d2v | ~None_vt () => d2v
end // end of [eval1_d2var]

(* ****** ****** *)

implement
eval1_d2explst (
  loc0, ctx, env, d2es
) = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
    val d2e = eval1_d2exp (loc0, ctx, env, d2e)
    val d2es = eval1_d2explst (loc0, ctx, env, d2es)
  in
    list_cons (d2e, d2es)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [eval1_d2explst]

(* ****** ****** *)

implement
eval1_d2expopt
  (loc0, ctx, env, opt) = (
  case+ opt of
  | Some (d2e) => Some (eval1_d2exp (loc0, ctx, env, d2e))
  | None () => None ()
) // end of [eval1_d2expopt]

(* ****** ****** *)
  
implement
eval1_d2exparg
  (loc0, ctx, env, d2a) = let
in
//
case+ d2a of
| D2EXPARGsta
    (locarg, s2as) => D2EXPARGsta (locarg, s2as)
| D2EXPARGdyn
    (npf, locarg, d2es) => let
    val d2es = eval1_d2explst (loc0, ctx, env, d2es)
  in
    D2EXPARGdyn (npf, locarg, d2es)
  end // end of [D2EXPARGdyn]
//
end // end of [eval1_d2exparg]

implement
eval1_d2exparglst
  (loc0, ctx, env, d2as) = let
in
//
case+ d2as of
| list_cons
    (d2a, d2as) => let
    val d2a = eval1_d2exparg (loc0, ctx, env, d2a)
    val d2as = eval1_d2exparglst (loc0, ctx, env, d2as)
  in
    list_cons (d2a, d2as)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [eval1_d2exparglst]

(* ****** ****** *)

implement
eval1_d2exp_applst (
  loc0, ctx, env, d2e0
) = let
//
val- D2Eapplst
  (d2e, d2as) = d2e0.d2exp_node
val loc = d2e.d2exp_loc
//
fun auxerr (
  loc0: location, d2e0: d2exp, d2m: d2mac
) : void = let
  val () = prerr_errmac_loc (loc0)
  val () = prerr ": the dynamic symbol ["
  val () = prerr_d2mac (d2m)
  val () = prerr "] at (";
  val () = $LOC.prerr_location (d2e0.d2exp_loc)
  val () = prerr ") refers to a macrodef (to be called inside ,(...))."
  val () = prerr_newline ();
in
  the_trans3errlst_add (T3E_dmacro_eval1_d2exp (loc0, d2e0))
end // end of [auxerr]
//
val d2e = eval1_d2exp (loc0, ctx, env, d2e)
val d2as = eval1_d2exparglst (loc0, ctx, env, d2as)
//
in
//
case+
  d2e.d2exp_node of
| D2Emac (d2m) => let
    val knd = d2mac_get_kind (d2m)
  in
    if knd = 0 then ( // [d2m] is of short form
      eval0_app_mac_short (loc0, d2m, ctx, env, d2as)
    ) else let
      val () =
        auxerr (loc0, d2e0, d2m) in d2exp_err (loc0)
      // end of [val]
    end // end of [if]
  end // end of [D2Emac]
| D2Eapplst
    (d2e1, d2as1) => (
    d2exp_applst (loc0, d2e1, list_append (d2as1, d2as))
  ) // end of [D2Eapplst]
//
| _ => d2exp_applst (loc0, d2e, d2as)
//
end // end of [eval1_d2exp_applst]

(* ****** ****** *)

implement
eval1_d2exp_macsyn (
  loc0, ctx, env, d2e0
) = let
  val- D2Emacsyn (knd, d2e) = d2e0.d2exp_node
in
//
case+ knd of
| $SYN.MSKdecode () => let
    val m2v = eval0_d2exp (loc0, ctx, env, d2e)
  in
    case+ m2v of
    | M2Vdcode (d2e_new) => d2e_new
    | _ => let
        val () = prerr_errmac_loc (loc0)
        val () = prerr ": the expansion of the dynamic expression at (";
        val () = $LOC.prerr_location (d2e.d2exp_loc)
        val ()= prerr ") is expected to return code (AST) but it does not.";
(*
        val () = prerr "expanded exp: d2e = "; prerr_d2exp (d2e); prerr_newline ();
        val () = prerr "returned val: m2v = "; prerr_m2val (m2v); prerr_newline ();
*)
        val () = prerr_newline ()
      in
        d2exp_err (loc0)
      end // end of [_]
  end // end of [MSKdecode]
| $SYN.MSKxstage () => let
    val m2v = eval0_d2exp (loc0, ctx, env, d2e)
  in
    liftval2dexp (loc0, m2v)
  end // end of [MSKxstage]
| _ => let
    val () =
      prerr_errmac_loc (loc0)
    val () = prerr ": macro syntax is used incorrectly: "
    val () = prerr_d2exp (d2e0)
    val () = prerr_newline ()
  in
    d2exp_err (loc0)
  end // end of [_]
//
end // end of [eval1_d2exp_macsyn]

(* ****** ****** *)

implement
eval1_d2exp
  (loc0, ctx, env, d2e0) = let
//
val () = (
  println! ("eval1_d2exp: loc0 = ", loc0);
  println! ("eval1_d2exp: d2e0 = ", d2e0);
) (* end of [val] *)
//
val d2en0 = d2e0.d2exp_node
//
macdef reloc () = d2exp_make_node (loc0, d2en0)
//
macdef eval1sexp (x) = eval1_s2exp (loc0, ctx, env, ,(x))
macdef eval1sexplst (x) = eval1_s2explst (loc0, ctx, env, ,(x))
//
macdef eval1sexparg (x) = eval1_s2exparg (loc0, ctx, env, ,(x))
macdef eval1sexparglst (x) = eval1_s2exparglst (loc0, ctx, env, ,(x))
//
macdef eval1dvar (x) = eval1_d2var (loc0, ctx, env, ,(x))
//
macdef eval1dexp (x) = eval1_d2exp (loc0, ctx, env, ,(x))
macdef eval1dexplst (x) = eval1_d2explst (loc0, ctx, env, ,(x))
macdef eval1dexpopt (x) = eval1_d2expopt (loc0, ctx, env, ,(x))
//
in
//
case+ d2en0 of
//
| D2Evar (d2v) =>
    d2exp_var (loc0, eval1dvar (d2v))
  // end of [D2Evar]
//
| D2Eint _ => reloc ()
| D2Eintrep _ => reloc ()
| D2Echar _ => reloc ()
| D2Estring _ => reloc ()
| D2Efloat _ => reloc ()
//
| D2Ei0nt _ => reloc ()
| D2Ec0har _ => reloc ()
| D2Es0tring _ => reloc ()
| D2Ef0loat _ => reloc ()
//
| D2Econ (
    d2c, locfun, s2as, npf, locarg, d2es
  ) => let
    val s2as =
      eval1sexparglst (s2as)
    // end of [val]
    val d2es = eval1dexplst (d2es)
  in
    d2exp_con (loc0, d2c, locfun, s2as, npf, locarg, d2es)
  end // end of [D2Econ]
//
| D2Ecst _ => reloc ()
| D2Ecstsp _ => reloc ()
| D2Esym _ => reloc ()
//
| D2Eextval (s2e, rep) =>
    d2exp_extval (loc0, eval1sexp (s2e), rep)
  // end of [D2Eextval]
//
| D2Eapplst _ =>
    eval1_d2exp_applst (loc0, ctx, env, d2e0)
  // end of [D2Eapplst]
| D2Emacsyn _ =>
    eval1_d2exp_macsyn (loc0, ctx, env, d2e0)
  // end of [D2Emacsyn]
//
| D2Eptrof (d2e) =>
    d2exp_ptrof (loc0, eval1dexp (d2e))
| D2Eviewat (d2e) =>
    d2exp_viewat (loc0, eval1dexp (d2e))
//
| D2Ederef (d2e) =>
    d2exp_deref (loc0, eval1dexp (d2e))
| D2Eassgn (_l, _r) =>
    d2exp_assgn (loc0, eval1dexp (_l), eval1dexp (_r))
| D2Exchng (_l, _r) =>
    d2exp_xchng (loc0, eval1dexp (_l), eval1dexp (_r))
//
| D2Eraise (d2e) => d2exp_raise (loc0, eval1dexp (d2e))
//
| D2Eexist (s2a, d2e) =>
    d2exp_exist (loc0, eval1sexparg (s2a), eval1dexp (d2e))
  // end of [D2Eexist]
//
| D2Edelay (d2e) => d2exp_delay (loc0, eval1dexp (d2e))
| D2Eldelay (_eval, _free) =>
    d2exp_ldelay (loc0, eval1dexp (_eval), eval1dexpopt (_free))
  // end of [D2Eldelay]
//
| _ => d2exp_err (loc0)
//
end // end of [eval1_d2exp]

(* ****** ****** *)

(* end of [pats_dmacro2_eval1.dats] *)