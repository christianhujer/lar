# Copyright (C) 2014 Christian Hujer.
# All rights reserved.
# Licensed under LGPLv3.
# See file LICENSE in the root directory of this project.

PREFIX?=/usr/local/
CFLAGS:=-std=gnu99 -W -Wall -pedantic -Werror -fdiagnostics-show-option -Wno-unused-parameter -g

.PHONY: all
all: lar

.PHONY: clean
clean:
	$(RM) lar

.PHONY: install
install: all
	cp lar $(PREFIX)bin/
