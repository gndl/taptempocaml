open Printf
open I18n.Gettext

let version = "1.0"
  
let getVersion() =
    sprintf(f_"Tap Tempo %s\n") version ^
    sprintf(f_"License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>\nThis is free software: you are free to change and redistribute it.\nThere is NO WARRANTY, to the extent permitted by law.\n")


let printVersionAndExit() =
    getVersion() |> print_endline;
    exit 0


let createFromArgs args =
  let sampleSize = ref 5 in
  let resetTime = ref 5. in
  let precision = ref 0 in
  let maxPrecision = 5 in

  let setSampleSize s = if s > 0 then sampleSize := s in
  let setResetTime r = if r > 0. then resetTime := r in
  let setPrecision p = if p > maxPrecision then precision := maxPrecision else if p > 0 then precision := p in
  
  let usage_msg = getVersion() ^ "\n" ^ s_"Usage: taptempo [options]\n" ^ "\n" ^ s_"Options:\n" in

  let sampleSizeDoc = sprintf(f_"\tset the number of samples needed to compute the tempo\n\t\t\tdefault is %i samples\n") !sampleSize in
  let precisionDoc = sprintf(f_"\tset the decimal precision of the tempo display\n\t\t\tdefault is %i digits, max is %i digits\n") !precision maxPrecision in
  let resetTimeDoc = sprintf(f_"\tset the time in second to reset the computation\n\t\t\tdefault is %f seconds\n") !resetTime in
  let versionDoc = sprintf(f_"\t\tdisplay the version") in

  let speclist = [("-s", Arg.Int setSampleSize, sampleSizeDoc);
                  ("-r", Arg.Float setResetTime, resetTimeDoc);
                  ("-p", Arg.Int setPrecision, precisionDoc);
                  ("-v", Arg.Unit printVersionAndExit, versionDoc);
                 ]
  in
  Arg.parse speclist print_endline usage_msg;

  (!sampleSize, !resetTime, !precision)
