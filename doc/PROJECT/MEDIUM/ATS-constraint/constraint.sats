(*
** ATS constaint-solving
*)

(* ****** ****** *)

typedef
fprint_type (a:t@ype) = (FILEref, a) -> void

(* ****** ****** *)

abst0ype
stamp_t0ype = int
typedef stamp = stamp_t0ype

(* ****** ****** *)

fun
fprint_stamp: fprint_type (stamp)
overload fprint with fprint_stamp

(* ****** ****** *)

fun stamp_make (int): stamp

(* ****** ****** *)
//
fun
compare_stamp_stamp
  : (stamp, stamp) -<fun0> int
overload compare with compare_stamp_stamp
//
(* ****** ****** *)

abstype symbol_type = ptr
typedef symbol = symbol_type

(* ****** ****** *)

fun fprint_symbol
  : (FILEref, symbol) -> void
overload fprint with fprint_symbol

(* ****** ****** *)

fun symbol_make (string): symbol

(* ****** ****** *)
//
fun
compare_symbol_symbol
  : (symbol, symbol) -<fun0> int
overload compare with compare_symbol_symbol
//
(* ****** ****** *)

abstype location_type = ptr
typedef loc_t = location_type

(* ****** ****** *)

fun fprint_location
  : (FILEref, loc_t) -> void
overload fprint with fprint_location

(* ****** ****** *)

fun location_make (rep: string): loc_t

(* ****** ****** *)

datatype s2rt =
| S2RTint of ()
| S2RTaddr of ()
| S2RTbool of ()
| S2RTfun of ((*void*))
| S2RTtup of ((*void*))
| S2RTerr of ((*void*))

(* ****** ****** *)

abstype s2cst_type = ptr
typedef s2cst = s2cst_type
typedef s2cstlst = List0 (s2cst)
typedef s2cstopt = Option (s2cst)
vtypedef s2cstopt_vt = Option_vt (s2cst)

(* ****** ****** *)

fun
fprint_s2cst: fprint_type (s2cst)
overload fprint with fprint_s2cst

(* ****** ****** *)

fun
compare_s2cst_s2cst (s2cst, s2cst): int
overload compare with compare_s2cst_s2cst

(* ****** ****** *)

fun s2cst_make (symbol, stamp): s2cst

(* ****** ****** *)
//
fun s2cst_get_name (s2cst):<> symbol
fun s2cst_get_stamp (s2cst):<> stamp
//
(* ****** ****** *)

abstype s2var_type = ptr
typedef s2var = s2var_type
typedef s2varlst = List0 (s2var)
typedef s2varopt = Option (s2var)
vtypedef s2varopt_vt = Option_vt (s2var)

(* ****** ****** *)

fun
fprint_s2var: fprint_type (s2var)
overload fprint with fprint_s2var

(* ****** ****** *)

fun
compare_s2var_s2var (s2var, s2var): int
overload compare with compare_s2var_s2var

(* ****** ****** *)

fun s2var_make (symbol, stamp): s2var

(* ****** ****** *)
//
fun s2var_get_name (s2var):<> symbol
fun s2var_get_stamp (s2var):<> stamp
//
(* ****** ****** *)

datatype
s2exp_node =
| S2Ecst of (s2cst)
| S2Evar of (s2var)
| S2Eignored of ((*void*))
// end of [s2exp_node]

where
s2exp = '{
  s2exp_srt= s2rt
, s2exp_node= s2exp_node
} (* end of [s2exp] *)

and s2explst = List0 (s2exp)

(* ****** ****** *)
//
fun fprint_s2exp: fprint_type (s2exp)
fun fprint_s2explst: fprint_type (s2explst)
//
overload fprint with fprint_s2exp
overload fprint with fprint_s2explst
//
(* ****** ****** *)

fun s2exp_make_node
  (s2t: s2rt, node: s2exp_node): s2exp

(* ****** ****** *)

fun s2exp_cst (s2t: s2rt, s2c: s2cst): s2exp
fun s2exp_var (s2t: s2rt, s2v: s2var): s2exp

(* ****** ****** *)

fun s2exp_ignored (s2rt): s2exp // error-handling

(* ****** ****** *)
//
symintr .name
overload .name with s2cst_get_name
overload .name with s2var_get_name
//
symintr .stamp
overload .stamp with s2cst_get_stamp
overload .stamp with s2var_get_stamp
//
(* ****** ****** *)

(* end of [constraint.sats] *)
