
let gettext line = line

let gettext lines = List.map gettext lines |> String.concat " "

let print words =
  gettext words |> print_string;
  flush stdout


