(declare-project
  :name "openbsd"
  :description "Janet bindings for OpenBSD specific syscalls."
  :author "Luca Etienne Schulz <luca@les.cx>"
  :license "MIT"
  :url "https://git.sr.ht/~les/janet-openbsd"
  :repo "https://git.sr.ht/~les/janet-openbsd"
  :version "0.3.0")

(declare-source
  :name "openbsd"
  :prefix "openbsd/"
  :source ["janet-openbsd/init.janet"])

(declare-native
  :name "_openbsd"
  :source ["src/openbsd.c"])
