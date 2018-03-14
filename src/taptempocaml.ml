open I18n.Gettext

let run sampleSize resetTime precision =

  let hitTimePoints = Queue.create() in

  Printf.printf(f_"Hit enter key for each beat (q to quit).%!");

  while input_char stdin <> 'q' do
    let currentTime = Unix.gettimeofday() in

    if Queue.is_empty hitTimePoints
    || currentTime -. Queue.top hitTimePoints > resetTime
    then (
      Queue.clear hitTimePoints; (* Reset if the hit diff is too big. *)
      Printf.printf(f_"[Hit enter key one more time to start bpm computation...]%!")
    )
    else (
      let occurenceCount = Queue.length hitTimePoints in

      (* Remove the older time from hitTimePoints with Queue.pop if the sample size is reached.
            Otherwise it is kept in the queue with Queue.top. *)
      let olderTime = Queue.(if occurenceCount < sampleSize then top else pop) hitTimePoints in

      let bpm = 60. *. float_of_int occurenceCount /. (currentTime -. olderTime) in

      Printf.printf(f_"Tempo: %.*f bpm%!") precision bpm;
    );
    Queue.add currentTime hitTimePoints;
  done;
  print_string(s_"Bye Bye!\n")


let () =
  let sampleSize, resetTime, precision = Options.createFromArgs Sys.argv
  in
  run sampleSize resetTime precision
