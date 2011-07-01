(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: June, 2011
//
(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

implement
fprint_d2itm (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  case+ x of
  | D2ITMcon d2cs => begin
      prstr "D2ITMcon("; fprint_d2conlst (out, d2cs); prstr ")"
    end // end of [D2ITMcon]
  | D2ITMcst d2c => begin
      prstr "D2ITMcst("; fprint_d2cst (out, d2c); prstr ")"
    end // end of [D2ITMcst]
  | D2ITMe1xp e1xp => begin
      prstr "D2ITMe1xp("; fprint_e1xp (out, e1xp); prstr ")"
    end // end of [D2ITMe1xp]
  | D2ITMmacdef d2m => begin
      prstr "D2ITMmacdef("; fprint_d2mac (out, d2m); prstr ")"
    end // end of [D2ITMmacdef]
  | D2ITMmacvar d2v => begin
      prstr "D2ITMmacvar("; fprint_d2var (out, d2v); prstr ")"
    end // end of [D2ITMmacvar]
  | D2ITMsymdef d2is => begin
      prstr "D2ITMsymdef("; fprint_d2itmlst (out, d2is); prstr ")";
    end // end of [D2ITMsymdef]
  | D2ITMvar d2v => begin
      prstr "D2ITMvar("; fprint_d2var (out, d2v); prstr ")"
    end // end of [D2ITMvar]
end // end of [fprint_d2item]

implement print_d2itm (x) = fprint_d2itm (stdout_ref, x)
implement prerr_d2itm (x) = fprint_d2itm (stderr_ref, x)

implement
fprint_d2itmlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_d2itm)
// end of [fprint_d2itmlst]

implement print_d2itmlst (xs) = fprint_d2itmlst (stdout_ref, xs)
implement prerr_d2itmlst (xs) = fprint_d2itmlst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_p2at
  (out, x) = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
//
case+ x.p2at_node of
| _ => {
    val () = prstr "P2T...(...)"
  } // end of [_]
//
end // end of [fprint_p2at]

implement
fprint_p2atlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_p2at)
// end of [fprint_p2atlst]

(* ****** ****** *)

(* end of [pats_dynexp2_print.dats] *)
