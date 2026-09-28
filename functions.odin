package seL4

foreign import lib "libseL4.a"
@(link_prefix="_seL4_", default_calling_convention="c")
foreign lib {
    SetIPCBuffer    :: proc(ptr: ^IPCBuffer) ---
    when CONFIG_SET_TLS_BASE_SELF {
        SetTLSBase  :: proc(tls_base: rawptr) ---
    }
}
