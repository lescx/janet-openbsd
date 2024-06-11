# Janet OpenBSD syscalls wrapper

A Janet wrapper module around OpenBSD specific syscalls.

## Status

Currently, [`pledge(2)`](https://man.openbsd.org/pledge.2) is implemented and [`unveil(2)`](https://man.openbsd.org/unveil.2) is WIP.

Future work includes implementation of the following syscalls:

* [`kbind(2)`](https://man.openbsd.org/kbind.2)
* [`pinsyscalls(2)`](https://man.openbsd.org/pinsyscalls.2)
* [`sendsyslog(2)`](https://man.openbsd.org/sendsyslog.2)
* _and more…_

## Install (from jpm)

[`jpm`](https://git.sr.ht/~bakpakin/jpm) is not in the ports tree yet. If you haven't installed `jpm` yet, follow the bootstrap installation instructions in the link provided.

Afterwards you can install the package is ususal:

```shell-session
$ [doas|sudo] install https://git.sr.ht/~les/janet-openbsd
```

To update the package to the newest version:

```shell-session
$ [doas|sudo] jpm update-installed
```

## Usage

```janet
(import openbsd)

(if (= os/which :openbsd)
  (do
    (openbsd/pledge [:stdio :rpath] nil)
    (openbsd/unveil "/usr/src" "rc")))
```

To read the documentation of a particular function:

```janet
$ janet
repl:1:> (import openbsd)
@{_ @{:value <cycle 0>} openbsd/pledge @{:private true}}
repl:2:> (doc openbsd/pledge)
[…]
```

## Contribute

[Yes.](CONTRIBUTING.md)

## License

This package is licensed under the MIT license. See [LICENSE](./LICENSE) for further information.
