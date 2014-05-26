# Copyright (C) 2014 Christian Hujer.
# All rights reserved.
# Licensed under LGPLv3.
# See file LICENSE in the root directory of this project.

export PREFIX?=/usr/local/

all clean distclean install:
	$(MAKE) -C src $@
