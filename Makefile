# Copyright (C) 2014 Christian Hujer.
# All rights reserved.
# Licensed under GPLv3.
# See file LICENSE in the root directory of this project.


## Specifies the installation prefix (used by install).
# Current value is: $(PREFIX)
PREFIX?=/usr/local/
help: export PREFIX:=$(PREFIX)

CPPFLAGS:=-MMD
CFLAGS:=-std=gnu99 -W -Wall -pedantic -Werror -fdiagnostics-show-option -Wno-unused-parameter -g

PROGRAMNAME:=lar

.PHONY: all
## Builds the program.
all: $(PROGRAMNAME)

.PHONY: clean
## Removes the generated files.
clean:
	$(RM) $(PROGRAMNAME) *.[ado]

.PHONY: tags
## Creates a tags file.
tags: $(wildcard *.[ch])
	ctags $^

.PHONY: indent
## Indents the source code.
indent:
	indent -npro -kr -nut -l1000 -c1 $(wildcard *.c)

.PHONY: install
## Installs the program, building it first if not built already.
# The program will be installed by copying it into the bin/ directory at the location specified by the PREFIX variable.
# I.e. if PREFIX is /usr/local/, the program will be installed in /usr/local/bin/.
# PREFIX is $(PREFIX), so the installation would be into $(PREFIX)/bin/
install: all
	cp $(PROGRAMNAME) $(PREFIX)/bin/

out:
	mkdir $@

.PHONY: test
test: ;

.PHONY test: givenFilenameWithDoubleASuffix_whenLarFilename_thenFileIsLocked
givenFilenameWithDoubleASuffix_whenLarFilename_thenFileIsLocked: $(PROGRAMNAME) | out
	-PATH=. $(PROGRAMNAME) foo.a.a 2>out/$@.stderr >out/$@.stdout
	! grep -q 'Could not determine lock file name, continueing without lock.' out/$@.stderr

-include Help.mak
