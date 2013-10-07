(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: September, 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "{$CAIRO}/SATS/cairo.sats"
//
(* ****** ****** *)
//
staload "./../SATS/mydraw.sats"
staload _(*anon*) = "./../DATS/mydraw.dats"
//
(* ****** ****** *)

staload "./test02.dats"

(* ****** ****** *)
//
staload "./../SATS/mydraw_cairo.sats"
staload _(*anon*) = "./../DATS/mydraw_cairo.dats"
//
(* ****** ****** *)

implement
main0 () = () where {
//
val M = 8 and N = 8
val W = 400 and H = 400
//
// create a sf for drawing
//
val sf =
  cairo_image_surface_create (CAIRO_FORMAT_ARGB32, W, H)
val cr = cairo_create (sf)
val p_cr = cairo_ref2ptr (cr)
//
val WH = min (W, H)
val WH = g0int2float_int_double (WH)
val WH2 = WH / 2
//
val p0 =
point_make ((W-WH)/2, (W-WH)/2)
//
val (pf0 | ()) = cairo_save (cr)
//
val () = cairo_scale (cr, 1.0*W/N, 1.0*H/M)
//
implement
mydraw_get0_cairo<> () = let
extern
castfn __cast {l:addr} (ptr (l)): vttakeout (void, cairo_ref(l))
in
  __cast (p_cr)
end // end of [mydraw_get0_cairo]
//
val c1 = color_make (1.0, 1.0, 1.0)
val c2 = color_make (0.0, 0.0, 0.0)
//
val () = draw_mrow (p0, c1, c2, M, N)
//
val () = cairo_restore (pf0 | cr)
//
val status =
  cairo_surface_write_to_png (sf, "test02.png")
val () = cairo_surface_destroy (sf) // a type error if omitted
val () = cairo_destroy (cr) // a type error if omitted
//
// in case of a failure ...
//
val () = assertloc (status = CAIRO_STATUS_SUCCESS)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)