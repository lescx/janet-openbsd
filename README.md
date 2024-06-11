# Janet OpenBSD syscalls wrapper

Janet wrapper module around OpenBSD specific syscalls. Currently, [`pledge(2)`](https://man.openbsd.org/pledge.2) is implemented and [`unveil(2)`](https://man.openbsd.org/unveil.2) is WIP.

## Future Work:

Implement the following syscalls:

* [`kbind(2)`](https://man.openbsd.org/kbind.2)
* [`pinsyscalls(2)`](https://man.openbsd.org/pinsyscalls.2)
* [`sendsyslog(2)`](https://man.openbsd.org/sendsyslog.2)

## Install

```
# jpm install https://git.sr.ht/~les/janet-openbsd
```

## Usage

```janet
(import openbsd)

(if (= os/which :openbsd)
  (do
    (openbsd/pledge [:stdio :rpath] nil)
    (openbsd/unveil "/usr/src" "rc")))

#(openbsd/pledge [] [])
#(print "This would not be printed")
#(openbsd/pledge nil nil) # Pledge does not do anything here.
```

## Contribute

[Yes.](CONTRIBUTING.md)
