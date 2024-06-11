#include <janet.h>
#include <unistd.h>

JANET_FN(cfun_pledge,
         "Usage",
     "Docstring") {
    janet_fixarity(argc, 2);

    const char *promises = janet_optstring(argv, argc, 0, NULL);
    const char *execpromises = janet_optstring(argv, argc, 1, NULL);

    if (pledge(promises, execpromises) == -1) {
        janet_panic("pledge error");
    }

    return janet_wrap_boolean(0);
}

JANET_FN(cfun_unveil,
         "Usage",
     "Docstring") {
    janet_fixarity(argc, 2);

    const char *path = janet_getstring(argv, 0);
    const char *permissions = janet_getstring(argv, 1);
    
    if (unveil(path, permissions) == -1) {
        janet_panic("unveil error");
    }

    return janet_wrap_boolean(0);
}

JANET_MODULE_ENTRY(JanetTable *env) {
    JanetRegExt cfuns[] = {
        JANET_REG("pledge", cfun_pledge),
        JANET_REG("unveil", cfun_unveil),
        JANET_REG_END
    };
    janet_cfuns_ext(env, "openbsd", cfuns);
}
