(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: November, 2013
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_jsonize.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans3_env.sats"
staload "./pats_constraint3.sats"

(* ****** ****** *)

#define nil list_nil
#define :: list_cons
#define cons list_cons

(* ****** ****** *)

macdef
jsonize_loc (x) = jsonize_location (,(x))

(* ****** ****** *)

(*
datatype
c3nstrkind =
  | C3NSTRKINDmain of () // generic
//
  | C3NSTRKINDcase_exhaustiveness of
      (caskind (*case/case+*), p2atcstlst) // no [case-]
//
  | C3NSTRKINDtermet_isnat of () // term. metric welfounded
  | C3NSTRKINDtermet_isdec of () // term. metric decreasing
//
  | C3NSTRKINDsome_fin of (d2var, s2exp(*fin*), s2exp)
  | C3NSTRKINDsome_lvar of (d2var, s2exp(*lvar*), s2exp)
  | C3NSTRKINDsome_vbox of (d2var, s2exp(*vbox*), s2exp)
//
  | C3NSTRKINDlstate of () // lstate merge
  | C3NSTRKINDlstate_var of (d2var) // lstate merge for d2var
//
  | C3NSTRKINDloop of (int) // HX: ~1/0/1: enter/break/continue
// end of [c3nstrkind]
*)
extern
fun jsonize_c3nstrkind: jsonize_type (c3nstrkind)

(* ****** ****** *)

implement
jsonize_c3nstrkind
  (knd) = let
//
fun aux0
(
  name: string
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (list_nil)
in
//
jsonval_labval2
  ("c3nstrkind_name", name, "c3nstrkind_arglst", arglst)
//
end // end of [aux0]
//
fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
//
jsonval_labval2
  ("c3nstrkind_name", name, "c3nstrkind_arglst", arglst)
//
end // end of [aux1]
//
fun aux2
(
  name: string
, arg1: jsonval, arg2: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_pair (arg1, arg2)
in
//
jsonval_labval2
  ("c3nstrkind_name", name, "c3nstrkind_arglst", arglst)
//
end // end of [aux2]

fun aux3
(
  name: string
, arg1: jsonval, arg2: jsonval, arg3: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (arg1 :: arg2 :: arg3 :: nil())
in
//
jsonval_labval2
  ("c3nstrkind_name", name, "c3nstrkind_arglst", arglst)
//
end // end of [aux3]
//
in
//
case+ knd of
//
| C3NSTRKINDmain () => aux0 ("C3NSTRKINDmain")
//
| C3NSTRKINDcase_exhaustiveness
    (knd, p2tcss) => let
    val knd = jsonize_caskind (knd)
    val p2tcss = jsonize_ignored (p2tcss)
  in
    aux2 ("C3NSTRKINDcase_exhaustiveness", knd, p2tcss)
  end // end of [C3NSTRKINDcase_exhaustiveness]
//
| C3NSTRKINDtermet_isnat () => aux0 ("C3NSTRKINDtermet_isnat")
| C3NSTRKINDtermet_isdec () => aux0 ("C3NSTRKINDtermet_isdec")
//
| C3NSTRKINDsome_fin
    (d2v, s2e1, s2e2) => let
    val d2v = jsonize_d2var (d2v)
    val s2e1 = jsonize_s2exp (s2e1)
    val s2e2 = jsonize_s2exp (s2e2)
  in
    aux3 ("C3NSTRKINDsome_fin", d2v, s2e1, s2e2)
  end // end of [C3NSTRKINDsome_fin]
| C3NSTRKINDsome_lvar
    (d2v, s2e1, s2e2) => let
    val d2v = jsonize_d2var (d2v)
    val s2e1 = jsonize_s2exp (s2e1)
    val s2e2 = jsonize_s2exp (s2e2)
  in
    aux3 ("C3NSTRKINDsome_lvar", d2v, s2e1, s2e2)
  end // end of [C3NSTRKINDsome_lvar]
| C3NSTRKINDsome_vbox
    (d2v, s2e1, s2e2) => let
    val d2v = jsonize_d2var (d2v)
    val s2e1 = jsonize_s2exp (s2e1)
    val s2e2 = jsonize_s2exp (s2e2)
  in
    aux3 ("C3NSTRKINDsome_vbox", d2v, s2e1, s2e2)
  end // end of [C3NSTRKINDsome_vbox]
//
| C3NSTRKINDlstate () => aux0 ("C3NSTRKINDlstate")
| C3NSTRKINDlstate_var (d2v) => let
    val d2v = jsonize_d2var (d2v) in aux1 ("C3NSTRKINDlstate_var", d2v)
  end // end of [C3NSTRKINDlstate_var]
//
| C3NSTRKINDloop (knd) =>
    aux1 ("C3NSTRKINDlloop", jsonval_int (knd))
//
end // end of [jsonize_c3nstrkind]

(* ****** ****** *)

(*
datatype s3itm =
  | S3ITMsvar of s2var
  | S3ITMhypo of h3ypo
  | S3ITMsVar of s2Var
  | S3ITMcnstr of c3nstr
  | S3ITMcnstr_ref of c3nstroptref // HX: for handling state types
  | S3ITMdisj of s3itmlstlst
// end of [s3item]
*)
extern
fun jsonize_s3itm: jsonize_type (s3itm)
extern
fun jsonize_s3itmlst: jsonize_type (s3itmlst)
extern
fun jsonize_s3itmlstlst: jsonize_type (s3itmlstlst)

(* ****** ****** *)

extern fun jsonize_h3ypo: jsonize_type (h3ypo)
extern fun jsonize_c3nstropt: jsonize_type (c3nstropt)

(* ****** ****** *)

implement
jsonize_s3itm (s3i) = let
//
fun aux0
(
  name: string
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_list (list_nil)
in
//
jsonval_labval2
  ("s3itm_name", name, "s3itm_arglst", arglst)
//
end // end of [aux0]
//
fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
//
jsonval_labval2
  ("s3itm_name", name, "s3itm_arglst", arglst)
//
end // end of [aux1]
//
fun aux2
(
  name: string
, arg1: jsonval, arg2: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_pair (arg1, arg2)
in
//
jsonval_labval2
  ("s3itm_name", name, "s3itm_arglst", arglst)
//
end // end of [aux2]
//
in
//
case+ s3i of
//
| S3ITMsvar (s2v) =>
    aux1 ("S3ITMsvar", jsonize_s2var (s2v))
//
| S3ITMhypo (h3p) =>
    aux1 ("S3ITMsvar", jsonize_h3ypo (h3p))
//
| S3ITMsVar (s2V) =>
    aux1 ("S3ITMsvar", jsonize_s2Var (s2V))
//
| S3ITMcnstr (c3t) =>
    aux1 ("S3ITMcnstr", jsonize_c3nstr (c3t))
//
| S3ITMcnstr_ref (c3tr) => let
    val loc = c3tr.c3nstroptref_loc
    val ref = c3tr.c3nstroptref_ref
    val loc = jsonize_location (loc)
    val opt = jsonize_c3nstropt (!ref)
  in
    aux2 ("S3ITMcnstr_ref", loc, opt)
  end // end of [S3ITMcnstr_ref]
//
| S3ITMdisj (s3iss) =>
    aux1 ("S3ITMdisj", jsonize_s3itmlstlst (s3iss))
//
end // end of [jsonize_s3itm]

(* ****** ****** *)
//
implement
jsonize_s3itmlst
  (s3is) = jsonize_list_fun (s3is, jsonize_s3itm)
implement
jsonize_s3itmlstlst
  (s3iss) = jsonize_list_fun (s3iss, jsonize_s3itmlst)
//
(* ****** ****** *)

local

fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
//
jsonval_labval2 ("h3ypo_name", name, "h3ypo_arglst", arglst)
//
end // end of [aux1]
//
fun aux2
(
  name: string
, arg1: jsonval, arg2: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_pair (arg1, arg2)
in
//
jsonval_labval2 ("h3ypo_name", name, "h3ypo_arglst", arglst)
//
end // end of [aux2]

in (* in of [local] *)

implement
jsonize_h3ypo
  (h3p0) = let
//
fun auxmain
  (h3p0: h3ypo): jsonval = let
in
//
case+
h3p0.h3ypo_node of
//
| H3YPOprop (s2e) =>
    aux1 ("H3YPOprop", jsonize_s2exp (s2e))
| H3YPObind (s2v1, s2e2) => let
(*
    val () = println! ("jsonize_h3ypo: H3YPObind: s2v1 = ", s2v1)
    val () = println! ("jsonize_h3ypo: H3YPObind: s2e2 = ", s2e2)
*)
  in
    aux2 ("H3YPObind", jsonize_s2var (s2v1), jsonize_s2exp (s2e2))
  end // end of [H3YPObind]
| H3YPOeqeq (s2e1, s2e2) => let
(*
    val () = println! ("jsonize_h3ypo: H3YPObind: s2e1 = ", s2e1)
    val () = println! ("jsonize_h3ypo: H3YPObind: s2e2 = ", s2e2)
*)
  in
    aux2 ("H3YPOeqeq", jsonize_s2exp (s2e1), jsonize_s2exp (s2e2))
  end // end of [H3YPOeqeq]
//
end // end of [auxmain]
//
val loc0 = h3p0.h3ypo_loc
val loc0 = jsonize_loc (loc0)
val h3p0 = auxmain (h3p0)
//
in
  jsonval_labval2 ("h3ypo_loc", loc0, "h3ypo_node", h3p0)
end // end of [jsonize_h3ypo]

end // end of [local]

(* ****** ****** *)

local

fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
  jsonval_labval2 ("c3nstr_name", name, "c3nstr_arglst", arglst)
end // end of [aux1]

in (* in of [local] *)

implement
jsonize_c3nstr
  (c3t0) = let
//
fun auxmain
  (c3t0: c3nstr): jsonval = let
in
//
case+
c3t0.c3nstr_node of
//
| C3NSTRprop (s2e) => let
(*
    val () = println! (
      "jsonize_c3nstr: C3NSTRprop: s2e = ", s2e
    ) (* end of [val] *)
*)
  in
    aux1 ("C3NSTRprop", jsonize_s2exp (s2e))
  end // end of [C3NSTRprop]
//
| C3NSTRitmlst (s3is) =>
    aux1 ("C3NSTRitmlst", jsonize_s3itmlst (s3is))
//
end // end of [auxmain]
//
val loc0 = c3t0.c3nstr_loc
val loc0 = jsonize_loc (loc0)
val c3t0 = auxmain (c3t0)
//
in
  jsonval_labval2 ("c3nstr_loc", loc0, "c3nstr_node", c3t0)
end // end of [jsonize_c3nstr]

end // end of [local]

(* ****** ****** *)

implement
jsonize_c3nstropt
  (opt) = let
in
//
case+ opt of
| None () => jsonval_none ()
| Some (c3t) => jsonval_some (jsonize_c3nstr (c3t))
//
end // end of [jsonize_c3nstropt]

(* ****** ****** *)

implement
c3nstr_export
  (out, c3t0) = let
//
val jsv0 = jsonize_c3nstr (c3t0)
//
val ((*void*)) = fprint_jsonval (out, jsv0)
val ((*void*)) = fprint_newline (out)
in
  // nothing
end // end of [c3nstr_export]

(* ****** ****** *)

(* end of [pats_constraint3_jsonize.dats] *)