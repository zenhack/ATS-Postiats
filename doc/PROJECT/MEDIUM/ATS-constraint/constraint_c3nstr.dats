(*
** ATS constaint-solving
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./constraint.sats"

(* ****** ****** *)

implement
c3nstr_make_node
  (loc, node) = '{
  c3nstr_loc= loc, c3nstr_node= node
} (* end of [c3nstr_make_node] *)

(* ****** ****** *)

implement
c3nstr_prop (loc, s2e) =
  c3nstr_make_node (loc, C3NSTRprop (s2e))
implement
c3nstr_itmlst (loc, s3is) =
  c3nstr_make_node (loc, C3NSTRitmlst (s3is))

(* ****** ****** *)

(* end of [constraint_c3nstr.dats] *)