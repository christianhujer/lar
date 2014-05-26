lar
===

Locking ar, an ar which wraps ar with a lock in order to allow the implicit rules of make for archive members work even in case of concurrent execution with -j.

lar scans the command line for the archive file (suffix.a).
For the first archive file found, it attempts to create a a file with the archive file and suffix .lock appended.
It then locks the file in blocking mode.
This means, if another program (probably another instance of lar) attempts to lock the file again, it will automatically wait until the previous lock is released.

Alternatives are:
* Usage of lar
```Makefile
AR:=lar
```

* Usage of flock, which in a Makefile can be done conventiently using
```Makefile
AR.saved:=$(AR)
AR=flock /var/lock/$*.lock $(AR.saved)
```

* Usage of sflock, which has less features but for this case does exactly the same as flock.
  sflock is http://github.com/christianhujer/projects/sflock
```Makefile
AR.saved:=$(AR)
AR=sflock /var/lock/$*.lock $(AR.saved)
```
