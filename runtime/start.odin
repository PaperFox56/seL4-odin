package seL4_runtime

import "core:mem"
import seL4 ".."


TLS_Header :: struct {
    image   : rawptr,
    base    : rawptr,
    filesz  : uint,
    memsz   : uint,
    align   : uint,
}

TLS_SetupError :: enum {
    BufferTooSmall,
    InvalidImage,
    InvalidBase,
}

Args :: []string

EnvVar :: struct { name: string, value: string }
Env  :: []EnvVar


// An instance of this struct is pushed on the stack of every loaded thread.
// The pointer should be passed as argument to the thread's entry point.
Init :: struct {
    tls         : TLS_Header,
    tls_loaded  : bool, // set to true if the parent thread already allocated and moved the thread's TLS region
    ipc_buffer  : ^seL4.IPCBuffer,
    args        : Args,
    env         : Env,

    pname       : string,
}

// This procedure assumes a rather naive TLS structure
@(require_results)
move_tls :: proc "contextless" (init_tls: TLS_Header, tls: []u8) -> TLS_SetupError {
    if len(tls) < int(init_tls.memsz) {
        return .BufferTooSmall
    }
    if init_tls.image == nil {
        return .InvalidImage
    }
    if init_tls.base == nil {
        return .InvalidBase
    }

    tdata := cast([^]u8)init_tls.image
    copy(tls, tdata[:init_tls.filesz])
    tbss := tdata[init_tls.filesz:init_tls.memsz]
    mem.zero_slice(tls[init_tls.memsz:])

    set_tls_base(init_tls.base)

    return nil
}

