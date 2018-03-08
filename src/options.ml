let version = "Taptempocaml 1.0"

let createFromArgs args =
  let sampleSize = ref 5 in
  let resetTime = ref 5 in
  let precision = ref 0 in
  let maxPrecision = 5 in
  let printVersionAndExit = ref false in

  let usage_msg = I18n.gettext["Usage: taptempo [options]\n"; "Options:\n"] in

  let sampleSizeDoc = I18n.gettext["\tset the number of samples needed to compute the tempo\n\t\t\tdefault is"; string_of_int !sampleSize; "samples"] in
  let precisionDoc = I18n.gettext["\tset the decimal precision of the tempo display\n\t\t\tdefault is"; string_of_int !precision; "digits, max is"; string_of_int maxPrecision; "digits"] in
  let resetTimeDoc = I18n.gettext["\tset the time in second to reset the computation\n\t\t\tdefault is"; string_of_int !resetTime; "seconds"] in
  let versionDoc = I18n.gettext["\t\tdisplay the version"] in

  let speclist = [("-s", Arg.Int(fun s -> sampleSize := s), sampleSizeDoc);
                  ("-p", Arg.Int(fun p -> precision := p), precisionDoc);
                  ("-r", Arg.Int(fun r -> resetTime := r), resetTimeDoc);
                  ("-v", Arg.Unit(fun() -> printVersionAndExit := true), versionDoc);
                 ] in
  Arg.parse speclist print_endline usage_msg;

  if !printVersionAndExit then (
    print_endline("\n" ^ version);
    exit 0
  );
  (!sampleSize, !resetTime, !precision)
