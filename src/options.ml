
let createFromArgs args =
  let sampleSize = ref 5 in
  let resetTime = ref 5 in
  let precision = ref 0 in
  let maxPrecision = 5 in

  let usage_msg = I18n.gettext["Usage: taptempo [options]\n";
                               "\n";
                               "Options:\n";
                               "  -h, --help\t\tdisplay this help message\n";
                               "  -p, --precision\tset the decimal precision of the tempo display\n\t\t\tdefault is";
                               Printf.sprintf "%d" !precision;
                               "digits, max is";
                               Printf.sprintf "%d" maxPrecision;
                               "digits\n";
                               "  -r, --reset-time\tset the time in second to reset the computation\n\t\t\tdefault is";
                               Printf.sprintf "%d" !resetTime;
                               "seconds\n";
                               "  -s, --sample-size\tset the number of samples needed to compute the tempo\n\t\t\tdefault is";
                               Printf.sprintf "%d" !sampleSize;
                               "samples\n";
                               "  -v, --version\t\tdisplay the version\n"]
  in
  let speclist = [("-s", Arg.Int(fun s -> sampleSize := s), "Sets maximum sample size");
                  ("-r", Arg.Int(fun r -> resetTime := r), "Sets reset time");
                  ("-p", Arg.Int(fun p -> precision := p), "Sets bpm precision")]
  in
  Arg.parse speclist print_endline usage_msg;

  (!sampleSize, !resetTime, !precision)
