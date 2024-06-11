(import _openbsd)

(def- promises [
  :stdio :rpath :wpath :cpath :dpath :tmppath :inet :mcast :fattr :chown :flock :unix :dns :getpw :sendfd :recvfd :tape :tty :proc :exec :prot_exec :settime :ps :vminfo :id :pf :route :wroute :audio :video :bpf :unveil :error])

(defn- validate-keywords [arr]
  (def indexes @[])
  (each kw arr
    (array/push indexes (find-index |(= kw $) promises nil)))
  (all truthy? indexes))

(defn- validate-and-stringify [arr]
  (if-not (nil? arr)
    (if-not (validate-keywords arr)
      (os/exit 1)
      (string/join arr " "))))

(defn pledge
  ``
  "(openbsd/pledge [& promises] [& execpromises])",
  Call the pledge(2) system call to whitelist certain operations.
  Passing an empty array to promises or execpromises restricts the process to the _exit(2) system call. This 
  can be used for pure computation operating on memory shared with another process.
  Passing nil to promises or execpromises specifies not to change the current value.
  Please read the [manual page](https://man.openbsd.org/pledge.2) for the specific system calls a promise allows.
  Promises can be:
  * :stdio - allow standard input/output operations
  * :rpath - allow read-only access to paths in the file system
  * :wpath - allow read-write access to paths in the file system
  * :cpath - allow creating, deleting, renaming of files and directories
  * :dpath - allow creating special files like sockets and fifos
  * :tmppath - allow read, write and creation of files in the /tmp directory
  * :inet - allow network communication in the AF_INET and AF_INET6 domains
  * :mcast - allow additional functionalities to :inet for operating on multicast sockets
  * :fattr - allow modifying file attributes
  * :chown - allow changing file ownership
  * :flock - allow locking and unlocking files
  * :unix - allow network communication in the AF_UNIX domain
  * :dns - allow DNS network resolution
  * :getpw - allow read-only access to /etc files for user and group lookups
  * :sendfd - allow sending file descriptors over sockets
  * :recvfd - allow receiving file descriptors over sockets
  * :tape - allow ioctl operations for tape drives
  * :tty - allow read-write access to /dev/tty and some ioctl operations for tty devices
  * :proc - allow process management operations like fork, kill etc
  * :exec - allow process execution using execve(2)
  * :prot_exec - allow using PROT_EXEC with mmap(2) and mprotect(2)
  * :settime - allow setting system time
  * :ps - allow enough access to inspect processes using tools like ps
  * :vminfo - allow enough access to inspect virtual memory using tools like top and vmstat
  * :id - allow changing process rights like setting user/group id
  * :pf - allow a limited set of ioctl operations on the pf device
  * :route - allow inspecting the routing table
  * :wroute - allow modifying the routing table
  * :audio - allow a limited set of ioctl operations on audio devices
  * :video - allow a limited set of ioctl operations on video devices
  * :bpf - allow getting statistics from bpf devices
  * :unveil - allow the unveil system call
  * :error - indicate an error with ENOSYS instead of terminating the process
  ``
  [promises execpromises]
  (_openbsd/pledge (validate-and-stringify promises) (validate-and-stringify execpromises)))
