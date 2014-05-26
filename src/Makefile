# Copyright (C) 2014 Christian Hujer.
# All rights reserved.
# Licensed under LGPLv3.
# See file LICENSE in the root directory of this project.

PREFIX?=/usr/local/
CPPFLAGS:=-I../include -MMD
CFLAGS:=-std=gnu99 -W -Wall -pedantic -Werror -fdiagnostics-show-option -Wno-unused-parameter -g
ARFLAGS:=-crs

.PHONY: all
.PRECIOUS: %.o
all: lar

.PHONY: clean
clean:
	$(RM) *.[aod] lar

.PHONY: install
install:
	cp lar $(PREFIX)bin/

include $(wildcard *.d)
