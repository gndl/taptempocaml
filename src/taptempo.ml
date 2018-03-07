let computeBPM currentTime lastTime occurenceCount =
  let occurenceCount = if occurenceCount = 0 then 1. 
    else float_of_int occurenceCount
  in
  60. *. occurenceCount /. (currentTime -. lastTime)


let isResetTimeElapsed currentTime lastTime resetTimeInSecond =
  currentTime -. lastTime > float_of_int resetTimeInSecond


let run sampleSize resetTimeInSecond precision =

  let hitTimePoints = Queue.create() in

  I18n.print["Hit enter key for each beat (q to quit)."];

  let rec loop () =
    match input_char stdin with
    | 'q' -> I18n.print["Bye Bye!"]
    | _ ->
      let currentTime = Unix.gettimeofday() in

      (* Reset if the hit diff is too big. *)
      if not(Queue.is_empty hitTimePoints) &&
         isResetTimeElapsed currentTime (Queue.top hitTimePoints) resetTimeInSecond
      then (Queue.clear hitTimePoints);

      if Queue.is_empty hitTimePoints then
	I18n.print["[Hit enter key one more time to start bpm computation...]"]
      else (
        let occurenceCount = Queue.length hitTimePoints - 1 in
        (* Remove the older time from hitTimePoints with Queue.pop if the sample size is reached.
           Otherwise it is kept in the queue with Queue.top. *)
        let olderTime = Queue.(if occurenceCount < sampleSize then top else pop) hitTimePoints in

        let bpm = computeBPM currentTime olderTime occurenceCount in

        I18n.print["Tempo:"; Printf.sprintf "%.*f" precision bpm; "bpm"];
      );
      Queue.add currentTime hitTimePoints;
      loop()
  in
  loop()


let () =
  let sampleSize, resetTimeInSecond, precision = Options.createFromArgs Sys.argv in
  run sampleSize resetTimeInSecond precision
