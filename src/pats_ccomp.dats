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
// Start Time: October, 2012
//
(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

extern
fun primdec_make_node
  (loc: location, node: primdec_node): primdec
implement
primdec_make_node
  (loc, node) = '{
  primdec_loc= loc, primdec_node= node
} // end of [primdec_make_node]

(* ****** ****** *)

implement
primdec_vardecs (loc, d2vs) =
  primdec_make_node (loc, PMDvardecs (d2vs))

(* ****** ****** *)

extern
fun primval_make_node
  (loc: location, hse: hisexp, node: primval_node): primval
implement
primval_make_node
  (loc, hse, node) = '{
  primval_loc= loc, primval_type= hse, primval_node= node
} // end of [primval_make_node]

(* ****** ****** *)

implement
primval_int (loc, hse, i) =
  primval_make_node (loc, hse, PMVint (i))
// end of [primval_int]

implement
primval_bool (loc, hse, b) =
  primval_make_node (loc, hse, PMVbool (b))
// end of [primval_bool]

implement
primval_char (loc, hse, c) =
  primval_make_node (loc, hse, PMVchar (c))
// end of [primval_char]

implement
primval_string (loc, hse, str) =
  primval_make_node (loc, hse, PMVstring (str))
// end of [primval_string]

(* ****** ****** *)

extern
fun instr_make_node
  (loc: location, node: instr_node): instr
implement
instr_make_node
  (loc, node) = '{
  instr_loc= loc, instr_node= node
} // end of [instr_make_node]

(* ****** ****** *)

implement
instr_move_val (loc, tmp, pmv) =
  instr_make_node (loc, INSmove_val (tmp, pmv))
// end of [instr_move_val]

implement
instr_move_arg_val (loc, arg, pmv) =
  instr_make_node (loc, INSmove_arg_val (arg, pmv))
// end of [instr_move_arg_val]

(* ****** ****** *)

(* end of [pats_ccomp.dats] *)