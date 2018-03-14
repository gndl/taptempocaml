all:
	mkdir build
	cd src && $(MAKE) all
	cd po  && $(MAKE) all

clean:
	cd po  && $(MAKE) clean
	cd src && $(MAKE) clean
	$(RM) -r build
