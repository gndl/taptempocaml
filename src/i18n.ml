
module Gettext = Gettext.Program
(
  struct
    let textdomain   = "taptempocaml"
    let codeset      = None
    let dir          = None
    let dependencies = Gettext.init
  end
)
(GettextCamomile.Map)
