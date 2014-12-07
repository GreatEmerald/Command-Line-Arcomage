# Common prefix for installation directories.
# NOTE: This directory must exist when you start the install.
prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
includedir = $(prefix)/include
datarootdir = $(prefix)/share
mandir = $(datarootdir)/man
man6dir = $(mandir)/man6
man6ext = .6

DMD = dmd
DMD_LDFLAGS = -L-larcomage
LIBARCOMAGE_INCLUDE_DIR = $(includedir)/dlang/arcomage
LUAD_INCLUDE_DIR = $(includedir)/dlang
PHOBOS_TYPE = libphobos2.so


all: clarcomage

clarcomage: clarcomage.d
	$(DMD) $(DFLAGS) -I$(LIBARCOMAGE_INCLUDE_DIR) -I$(LUAD_INCLUDE_DIR) -defaultlib=$(PHOBOS_TYPE) $(DMD_LDFLAGS) -of$@ clarcomage.d

clean:
	-rm clarcomage
	-rm clarcomage.o

install: installdirs
	cp clarcomage $(DESTDIR)$(bindir)
	cp ../util/clarcomage.6 $(DESTDIR)$(man6dir)/clarcomage$(man6ext)

installdirs:
	-mkdir -p $(DESTDIR)$(bindir)
	-mkdir -p $(DESTDIR)$(man6dir)
