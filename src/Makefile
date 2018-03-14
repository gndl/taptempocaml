SOURCES = i18n.ml options.ml taptempocaml.ml
RESULT = taptempocaml
LIBS = unix gettext gettext-camomile

all: $(SOURCES)
	ocamlfind ocamlc -package "unix gettext-camomile" -linkpkg -o $(RESULT) $^

clean:
	$(RM) *.cmi *.cmo $(RESULT)
