# Janet OpenBSD syscalls wrapper

A Janet wrapper module around OpenBSD specific syscalls.

## Status

**Implemented:**

* [`pledge(2)`](https://man.openbsd.org/pledge.2)
* [`sendsyslog(2)`](https://man.openbsd.org/sendsyslog.2)
* [`unveil(2)`](https://man.openbsd.org/unveil.2)

**Future work:**

* [`kbind(2)`](https://man.openbsd.org/kbind.2)
* [`pinsyscalls(2)`](https://man.openbsd.org/pinsyscalls.2)
* _and more…_

## Install (from jpm)

[jpm](https://git.sr.ht/~bakpakin/jpm) is not in the ports tree yet. If you haven't installed jpm yet, follow the bootstrap installation instructions in the link provided.

Afterwards, install the package via `jpm`:

```shell-session
$ [doas|sudo] jpm install openbsd
```

To update the package to the newest version:

```shell-session
$ [doas|sudo] jpm update-installed
```

## Usage (from Janet)

If you develop your application for more systems then just OpenBSD, wrap the `(openbsd/)` functions in `(= os/which :openbsd)`.

To read the documentation of a particular function:

```janet
$ janet
repl:1:> (import openbsd)
@{_ @{:value <cycle 0>} openbsd/pledge @{:private true}}
repl:2:> (doc openbsd/pledge)
[…]
```

## Basic Example

```janet
(import openbsd)

(if (= os/which :openbsd)
  (do
    (openbsd/pledge [:stdio :rpath] nil)
    (openbsd/unveil "/usr/src" "rc")))
```

## Contribute

[Yes.](CONTRIBUTING.md)

## License

This package is released under the MIT License. See [LICENSE](./LICENSE) for more information.
