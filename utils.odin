package seL4

import "core:c"

when INCLUDE_UTILS {

    @export
    memset :: proc "c" (s: rawptr, ch: c.int, #any_int n: c.size_t) -> rawptr {
        p := cast([^]u8)s
        for i in 0..<n { p[i] = u8(ch) }
        return s
    }

    @export
    memcpy :: proc "c" (#no_alias dest, src: rawptr, #any_int n: c.size_t) -> rawptr {
        dest := cast([^]u8)dest
        src := cast([^]u8)src

        for i in 0..<n {
            dest[i] = src[i]
        }

        return dest
    }

    @export
    memmove :: proc "c" (dest, src: rawptr, #any_int n: c.size_t) -> rawptr {
        dest := cast([^]u8)dest
        src := cast([^]u8)src

        if dest < src {
            for i in 0..<n {
                dest[i] = src[i]
            }
        } else {
            for i := n; i > 0; i -= 1 {
                dest[i-1] = src[i-1]
            }
        }

        return dest
    }

}
