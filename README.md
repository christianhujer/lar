lar
===

Locking `ar`, an ar which wraps `ar` with a lock in order to allow the implicit rules of make for archive members work even in case of concurrent execution with `-j`.

`lar` scans the command line for the archive file (suffix `.a`).
For the first archive file found, it attempts to create a a file with the archive file and suffix `.lock` appended.
It then locks the file in blocking mode.
This means, if another program (probably another instance of `lar`) attempts to lock the file again, it will automatically wait until the previous lock is released.

Alternatives are:
* Usage of `lar`
```Makefile
AR:=lar
```

* Usage of `flock`, which in a `Makefile` can be done conventiently using
```Makefile
AR.saved:=$(AR)
AR=flock /var/lock/$*.lock $(AR.saved)
```

* Usage of `sflock`, which has less features but for this case does exactly the same as flock.
  sflock is http://github.com/christianhujer/projects/sflock
```Makefile
AR.saved:=$(AR)
AR=sflock /var/lock/$*.lock $(AR.saved)
```

For getting help on building, run `make help`.

When to use lar instead of flock or slock?
------------------------------------------
You may wonder, is there need for `lar` besides `flock` and `sflock`?
The simple answer is, in sane environments: no :)

There are two aspects of some development environments that make them insane.

1. Microsoft Windows
2. Other tools

People shouldn't force developers to use Microsoft Windows for software development, at least not if the target platform isn't Microsoft Windows.
However, in our industry there is so much (unintentional) sadism that this happens frequently enough.
You can't simply run a shell script as a program on Microsoft Windows.
You can, but you can't simply.
You need to fiddle around with run.exe and bash.exe stuff and it gets complicated quickly.

Some tools allow for only calling 1 other program.
Which on UNIX is not a problem, you simply use a shell script.

If those two things come together, you may need a solution for file locking which is built-in in the command.
It might be the case that `lar` doesn't fit your problem, because it is specific to `ar`.
In that case, you have the source, go ahead and modify it :)
