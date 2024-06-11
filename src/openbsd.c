#include <janet.h>
#include <sys/syslog.h> // sendsyslog(2)
#include <sys/types.h> // sendsyslog(2)
#include <unistd.h> // pledge(2), unveil(2)

JANET_FN(cfun_pledge,
     "(_openbsd/pledge promises execpromises)",
     "Call pledge(2) syscall") {
    janet_fixarity(argc, 2);

    const char *promises = janet_optstring(argv, argc, 0, NULL);
    const char *execpromises = janet_optstring(argv, argc, 1, NULL);

    if (pledge(promises, execpromises) == -1)
        janet_panic("pledge error");

    return janet_wrap_boolean(0);
}

JANET_FN(cfun_unveil,
     "(_openbsd/unveil path permissions)",
     "Call unveil(2) syscall") {
    janet_fixarity(argc, 2);

    const char *path = janet_getstring(argv, 0);
    const char *permissions = janet_getstring(argv, 1);
    
    if (unveil(path, permissions) == -1)
        janet_panic("unveil error");

    return janet_wrap_boolean(0);
}

JANET_FN(cfun_sendsyslog,
    "(_openbsd/sendsyslog msg len flags)",
    "Call sendsyslog(2) syscall") {
    janet_fixarity(argc, 3);

    const char *msg = janet_getstring(argv, 0);
    size_t len = janet_getsize(argv, 1);
    int flags = janet_getboolean(argv, 2);

    // TODO: handle ERRNO
    sendsyslog(msg, len, flags);

    return janet_wrap_boolean(0);
}

JANET_MODULE_ENTRY(JanetTable *env) {
    JanetRegExt cfuns[] = {
        JANET_REG("pledge", cfun_pledge),
        JANET_REG("unveil", cfun_unveil),
        JANET_REG("sendsyslog", cfun_sendsyslog),
        JANET_REG_END
    };
    janet_cfuns_ext(env, "openbsd", cfuns);
}
