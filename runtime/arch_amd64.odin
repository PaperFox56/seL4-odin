package seL4_runtime

import seL4 ".."

when seL4.CONFIG_FSGSBASE_INST {
    read_fs_base :: asm() -> (out: rawptr) {
        rdfsbase out
    }

    write_fs_base :: asm(ptr: rawptr) [#volatile] {
        wrfsbase ptr
    }

    read_gs_base :: asm() -> (out: rawptr) {
        rdgsbase out
    }

    write_gs_base :: asm(ptr: rawptr) [#volatile] {
        wrgsbase ptr
    }

    get_tls_base :: proc "contextless" () -> rawptr {
        return read_fs_base()
    }

    set_tls_base :: proc "contextless" (tls_base: rawptr) {
        write_fs_base(tls_base)
    }
} else {
    get_tls_base :: asm() -> (tls_base: rawptr) {
        mov [%fs],tls_base
    }

    when seL4.CONFIG_SET_TLS_BASE_SELF {
        set_tls_base :: proc "contextless" (tls_base: rawptr) {
            seL4.SetTLSBase()
        }
    } else {
        #panic("Set TLS for x86_64 w/o FSGSBASE_INST not implemented")
    }
}
