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
(* Start time: December, 2012 *)

(* ****** ****** *)

absviewtype
mynode_viewtype
  (key: t@ype, itm:viewt@ype+, l:addr)
stadef mynode = mynode_viewtype
viewtypedef
mynode (key:t0p, itm:vt0p) = [l:addr] mynode (key, itm, l)
viewtypedef
mynode0 (key:t0p, itm:vt0p) = [l:addr | l >= null] mynode (key, itm, l)
viewtypedef
mynode1 (key:t0p, itm:vt0p) = [l:addr | l >  null] mynode (key, itm, l)

(* ****** ****** *)

fun{
key:t0p;itm:t0p
} linmap_search_ngc
  (map: !map (key, INV(itm)), k0: key): Ptr0
// end of [linmap_search_ngc]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} linmap_insert_ngc (
  map: &map (key, INV(itm)) >> _, nx: mynode1 (key, itm)
) : mynode0 (key, itm) // endfun

fun{
key:t0p;itm:vt0p
} linmap_insert_any_ngc (
  map: &map (key, INV(itm)) >> _, nx: mynode1 (key, itm)
) : void // end of [linmap_insert_any_ngc]

(* ****** ****** *)

fun{
key:t0p;itm:vt0p
} linmap_takeout_ngc
  (map: &map (key, INV(itm)) >> _, k0: key): mynode0 (key, itm)
// end of [linmap_takeout_ngc]

(* ****** ****** *)

(* end of [linmap_node.hats] *)
