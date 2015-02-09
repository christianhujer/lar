# Copyright (C) 2014 Christian Hujer.
# All rights reserved.
# Licensed under GPLv3.
# See file LICENSE in the root directory of this project.


## Specifies the installation prefix (used by install).
PREFIX?=/usr/local/

## Specifies the binary installation directory (used by install).
BINDIR?=$(PREFIX)bin/

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
# The program will be installed by copying it into the directory at the location specified by the BINDIR variable.
# I.e. if BINDIR is /usr/local/bin/, the program will be installed in /usr/local/bin/.
# BINDIR is $(BINDIR).
install: all
	install -d $(BINDIR)
	install -t $(BINDIR) $(PROGRAMNAME)

out:
	mkdir $@

.PHONY: test
test: ;

.PHONY test: givenFilenameWithDoubleASuffix_whenLarFilename_thenFileIsLocked
givenFilenameWithDoubleASuffix_whenLarFilename_thenFileIsLocked: $(PROGRAMNAME) | out
	-PATH=. $(PROGRAMNAME) foo.a.a 2>out/$@.stderr >out/$@.stdout
	! grep -q 'Could not determine lock file name, continueing without lock.' out/$@.stderr

control.Description=lar - a wrapper for ar which locks the archive file.
-include makedist/MakeDist.mak

-include makehelp/Help.mak
