all:
	mkdir build
	cd src && $(MAKE) all
	cd po  && $(MAKE) all

install:
	cp build/share/locale/fr/LC_MESSAGES/taptempocaml.mo /usr/share/locale/fr/LC_MESSAGES/
	cp src/taptempocaml /usr/local/bin

uninstall:
	rm /usr/share/locale/fr/LC_MESSAGES/taptempocaml.mo
	rm /usr/local/bin/taptempocaml

clean:
	cd po  && $(MAKE) clean
	cd src && $(MAKE) clean
	$(RM) -r build
