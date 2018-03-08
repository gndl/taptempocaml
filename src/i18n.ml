
module Gettext = Gettext.Program
(
  struct
    let textdomain   = "taptempo"
    let codeset      = None
    let dir          = None
    let dependencies = Gettext.init
  end
)
(GettextCamomile.Map)

let gettext line = line

let gettext lines = List.map gettext lines |> String.concat " "

let print words =
  gettext words |> print_string;
  flush stdout
