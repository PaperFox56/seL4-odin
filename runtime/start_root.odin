package seL4_runtime

import seL4 ".."

// is the program compiled as a root task
NO_TLS   :: #config(NO_TLS, true)


when NO_TLS {
    @private
    LinkSymbol :: struct {}
    foreign {
        // Those symbols should be generated at link time if the proper linking script is used
        _tdata_start    : LinkSymbol
        _tdata_end      : LinkSymbol
        _tbss_start     : LinkSymbol
        _tbss_end       : LinkSymbol
    }

    make_init_tls :: proc "contextless" () -> TLS_Header { 
        tdata_start := &_tdata_start
        tdata_end   := &_tdata_end
        tbss_start  := &_tbss_start
        tbss_end    := &_tbss_end

        if tdata_start == nil {
            tdata_start = tbss_start;
            tdata_end   = tbss_start;
        }
        tdata_size := uintptr(tdata_end) - uintptr(tdata_start)
        total_size := uintptr(tbss_end) - uintptr(tdata_start)
        base := rawptr(uintptr(tdata_start) + total_size)
        
        return {
            image   = tdata_start,
            base    = base,
            align   = size_of(seL4.Word),
            filesz  = uint(tdata_size),
            memsz   = uint(total_size),
        }
    }
}
