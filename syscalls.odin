package seL4

foreign import lib "libseL4.a"
@(link_prefix="_seL4_", default_calling_convention="c")
foreign seL4 {
    Send    :: proc(dest: CPtr, msgInfo: MessageInfo_t) ---
    when CONFIG_KERNEL_MCS {
        Recv        :: proc (src: CPtr, sender: ^Word, reply: CPtr) -> MessageInfo_t ---
        ReplyRecv   :: proc (dest: CPtr, msgInfo: MessageInfo_t, sender: ^Word, reply: CPtr) -> MessageInfo_t ---
        NBRecv      :: proc (src: CPtr, sender: ^Word, reply: CPtr) -> MessageInfo_t ---
        NBSendRecv  :: proc (dest: CPtr, msgInfo: MessageInfo_t, src: CPtr, sender: ^Word, reply: CPtr) -> MessageInfo_t ---
        NBSendWait  :: proc (dest: CPtr, msgInfo: MessageInfo_t, src: CPtr, sender: ^Word) -> MessageInfo_t ---
        NBWait      :: proc (src: CPtr, sender: ^Word) ---
    } else {
        Recv        :: proc (src: CPtr, sender: ^Word) -> MessageInfo_t ---
        ReplyRecv   :: proc (dest: CPtr, msgInfo: MessageInfo_t, sender: ^Word) -> MessageInfo_t ---
        NBRecv      :: proc (src: CPtr, sender: ^Word) -> MessageInfo_t ---
        Reply       :: proc (msgInfo: MessageInfo_t) ---
    }
    Call    :: proc(dest: CPtr, msgInfo: MessageInfo_t) -> MessageInfo_t ---
    NBSend  :: proc(dest: CPtr, msgInfo: MessageInfo_t) ---
    Yield   :: proc() ---
    Signal  :: proc(dest: CPtr) ---
    Wait    :: proc(src: CPtr, sender: ^Word) ---
    Poll    :: proc(src: CPtr, sender: ^Word) ---
}
