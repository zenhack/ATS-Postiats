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
// Start Time: May, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_lvalres"

(* ****** ****** *)

staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_error.sats"
staload "pats_staexp2_util.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "pats_staexp2_solve.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

local

fun auxmain (
  loc0: location
, pfobj: pfobj
, d3ls: d3lablst
, s2e_new: s2exp
, err: & int
) : void = let
  val+ ~PFOBJ (
    d2v, s2e_ctx, s2e_elt, s2l
  ) = pfobj // end of [val]
  var linrest: int = 0
  val (s2e_old, s2ps) =
    s2exp_get_dlablst_linrest (loc0, s2e_elt, d3ls, linrest)
  // end of [val]
  val s2e_old =
    s2exp_hnfize (s2e_old)
  // end of [val]
  val islin = s2exp_is_lin (s2e_old)
in
//
if islin then let
  val () = list_vt_free (s2ps)
  val () = prerr_error3_loc (loc0)
  val () = prerr ": a linear component of the following type is abandoned: "
  val () = (prerr "["; prerr_s2exp (s2e_old); prerr "].")
  val () = prerr_newline ()
  val () = the_trans3errlst_add (T3E_s2addr_set_type_linold (loc0, s2e_elt, d3ls))
in
  // nothing
end else let
  var context: s2expopt = None ()
  val s2e_sel1 =
    s2exp_get_dlablst_context (loc0, s2e_elt, d3ls, context)
  // end of [val]
in
//
case+ context of
| Some (s2e_elt_ctx) => let
    val () = list_vt_free (s2ps)
    val s2e_elt = let
      val- ~Some_vt (s2e_elt) =
        s2exp_hrepl0 (s2e_elt_ctx, s2e_new) in s2e_elt
    end // end of [val]
    val s2e = let
      val- ~Some_vt (s2e) = s2exp_hrepl0 (s2e_ctx, s2e_elt) in s2e
    end : s2exp // end of [val]
    val () = d2var_set_type (d2v, Some (s2e))
  in
    // nothing
  end // end of [Some]
| None () => let
    val () = trans3_env_add_proplst_vt (loc0, s2ps)
    val err = $SOL.s2exp_tyleq_solve (loc0, s2e_new, s2e_old)
    val () = if err > 0 then let
      val () = prerr_error3_loc (loc0)
      val () = prerr ": mismatch of bef/aft types of call-by-reference: "
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
    in
      the_trans3errlst_add (T3E_s2addr_set_type_oldnew (loc0, s2e_elt, d3ls, s2e_new))
    end // end of [if] // end of [val]
  in
    // nothing
  end // end of [None]
//
end // end of [if]
//
end // end of [auxmain]

in // in of [local]

implement
s2addr_set_type_err (
  loc0, s2l, d3ls, s2e_new, err
) = let
  val opt = pfobj_search_atview (s2l)
in
//
case+ opt of
| ~Some_vt (pfobj) =>
    auxmain (loc0, pfobj, d3ls, s2e_new, err)
| ~None_vt () => ()
//
end // end of [s2addr_set_type_err]

end // end of [local]

(* ****** ****** *)

local

fun auxerr_linold (
  loc0: location
, d3e: d3exp, d3ls: d3lablst, s2e_old: s2exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": a linear component of the following type is abandoned: "
  val () = (prerr "["; prerr_s2exp (s2e_old); prerr "].")
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3lval_set_type_linold (loc0, d3e, d3ls))
end // end of [auxerr_linold]

fun d2var_refval_check (
  loc0: location, d2v: d2var, refval: int
) : void = 
  if refval > 0 then let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the dynamic variable ["
    val () = prerr_d2var (d2v)
    val () = prerr "] is required to be mutable in order to support call-by-reference."
    val () = prerr_newline ()
  in
    the_trans3errlst_add (T3E_d3lval_refval (loc0, d2v))
  end // end of [if]
// end of [d2var_refval_check]

in // in of [local]

implement
d3lval_set_type_err (
  loc0, refval, d3e, s2e_new, err
) = let
(*
val () = (
  print "d3lval_set_type_err: d3e = "; print_d3exp (d3e); print_newline ()
) // end of [val]
*)
in
//
case+
d3e.d3exp_node of
| D3Evar d2v
    when d2var_is_mutabl (d2v) => let
    val- Some (s2l) = d2var_get_addr (d2v)
    val d3ls = list_nil // HX: a special case of sel_var
  in
    s2addr_set_type_err (loc0, s2l, d3ls, s2e_new, err)
  end // end of [D2Evar/mutable]
| D3Evar d2v
    when d2var_is_linear (d2v) => let
    val () =
      d2var_refval_check (loc0, d2v, refval)
    // end of [val]
    val () = d3exp_set_type (d3e, s2e_new)
    val opt = d2var_exch_type (d2v, Some (s2e_new))
  in
    case+ opt of
    | Some (s2e_old) => let
        val islin = s2exp_is_lin (s2e_old)
        val () = if islin then
          auxerr_linold (loc0, d3e, list_nil(*d3ls*), s2e_old)
        // end of [if] // end of [val]
      in
        // nothing
      end // end of [Some]
    | None () => ()
  end // end of [D2Evar/linear]
//
| D3Esel_var (d2v, d3ls)
    when d2var_is_mutabl (d2v) => let
    val- Some (s2l) = d2var_get_addr (d2v)
  in
    s2addr_set_type_err (loc0, s2l, d3ls, s2e_new, err)
  end // end of [D2Evar/mutable]
//
| _ => exitloc (1)
//
end // end of [d3lval_set_type_err]

end // end of [local]

(* ****** ****** *)

local

fn s2exp_fun_is_freeptr
  (s2e: s2exp): bool = (
  case+ s2e.s2exp_node of
  | S2Efun (
      fc, lin, _(*s2fe*), _(*npf*), _(*arg*), _(*res*)
    ) => (
    case+ fc of
    | FUNCLOclo (knd) when knd > 0 => if lin = 0 then true else false
    | _ => false
    ) // end of [S2Efun]
  | _ => false
) // end of [s2exp_fun_is_freeptr]

in // in of [local]

implement
d3lval_arg_set_type
  (refval, d3e0, s2e_new) = let
//
val loc0 = d3e0.d3exp_loc
var err: int = 0
var freeknd: int = 0 // free the expression if it is set to 1
val () = d3lval_set_type_err (loc0, refval, d3e0, s2e_new, err)
val () = (if err > 0 then begin
  case+ 0 of
  | _ when s2exp_is_nonlin (s2e_new) => () // HX: safely discarded!
  | _ when s2exp_fun_is_freeptr s2e_new => (freeknd := 1) // HX: leak
  | _  => let
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the function argument needs to be a left-value."
      val () = prerr_newline ()
    in
      the_trans3errlst_add (T3E_d3lval_funarg (d3e0))
    end // end of [_]
end) : void // end of [val]
//
in
  freeknd // a linear value must be freed (freeknd = 1) if it cannot be returned
end (* end of [d3lval_arg_set_type] *)

end // end of [local]

(* ****** ****** *)

local

fun aux (
  d3es: d3explst
, s2es_arg: s2explst
, wths2es: wths2explst
) : d3explst = let
in
//
case+ wths2es of
| WTHS2EXPLSTcons_invar
    (_, wths2es) => let
    val- list_cons (d3e, d3es) = d3es
    val- list_cons (s2e_arg, s2es_arg) = s2es_arg
    val loc = d3e.d3exp_loc
    val- S2Erefarg (refval, s2e_res) = s2e_arg.s2exp_node
    val freeknd =
      d3lval_arg_set_type (refval, d3e, s2e_res)
    val d3e = d3exp_refarg (loc, s2e_res, refval, freeknd, d3e)
    val d3es = d3explst_arg_restore (d3es, s2es_arg, wths2es)
  in
    list_cons (d3e, d3es)
  end // end of [WTHS2EXPLSTcons_none]
| WTHS2EXPLSTcons_trans (
    refval, s2e_res, wths2es
  ) => let
    val- list_cons (d3e, d3es) = d3es
    val- list_cons (s2e_arg, s2es_arg) = s2es_arg
    val loc = d3e.d3exp_loc
    val s2f_res = s2exp2hnf (s2e_res)
    val s2e_res = s2hnf_opnexi_and_add (loc, s2f_res)
(*
    val () = (
      print "d3explst_arg_restore: aux: d3e = "; print d3e; print_newline ();
      print "d3explst_arg_restore: aux: d3e.type = "; print d3e.d3exp_type; print_newline ();
      print "d3explst_arg_restore: aux: s2e_res = "; print s2e_res; print_newline ();
    ) // end of [val]
*)
    val freeknd =
      d3lval_arg_set_type (refval, d3e, s2e_res)
    val d3e = d3exp_refarg (loc, s2e_res, refval, freeknd, d3e)
    val d3es = d3explst_arg_restore (d3es, s2es_arg, wths2es)
  in
    list_cons (d3e, d3es)
  end // end of [WTHS2EXPLSTcons_some]
| WTHS2EXPLSTcons_none
    (wths2es) => let
    val- list_cons (d3e, d3es) = d3es
    val- list_cons (s2e_arg, s2es_arg) = s2es_arg
    val d3es = d3explst_arg_restore (d3es, s2es_arg, wths2es)
  in
    list_cons (d3e, d3es)
  end // end of [WTHS2EXPLSTcons_none]
| WTHS2EXPLSTnil () => list_nil ()
//
end // end of [d3explst_arg_restore]

in // in of [local]

implement
d3explst_arg_restore
  (d3es, s2es, wths2es) =
  aux (d3es, s2es, wths2es)
// end of [d3explst_arg_restore]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_lvalres.dats] *)