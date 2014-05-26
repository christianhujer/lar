# Copyright (C) 2014 Christian Hujer.
# All rights reserved.
# Licensed under LGPLv3.
# See file LICENSE in the root directory of this project.


## Specifies the installation prefix (used by install).
# Current value is: $(PREFIX)
PREFIX?=/usr/local/
help: export PREFIX:=$(PREFIX)

CFLAGS:=-std=gnu99 -W -Wall -pedantic -Werror -fdiagnostics-show-option -Wno-unused-parameter -g

.PHONY: all
## Builds the program.
all: lar

.PHONY: clean
## Removes the generated files.
clean:
	$(RM) lar

.PHONY: install
## Installs the program, building it first if not built already.
# The program will be installed by copying it into the bin/ directory at the location specified by the PREFIX variable.
# I.e. if PREFIX is /usr/local/, the program will be installed in /usr/local/bin/.
# PREFIX is $(PREFIX), so the installation would be into $(PREFIX)/bin/
install: all
	cp lar $(PREFIX)/bin/

.PHONY: help
## Prints this help message.
help: makehelp.pl
	perl makehelp.pl $(MAKEFILE_LIST)

makehelp.pl:
	wget -N -q --no-check-certificate https://github.com/christianhujer/makehelp/raw/master/makehelp.pl
