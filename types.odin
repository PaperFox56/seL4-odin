package seL4

Uint8 :: u8

Int32 :: i32
Uint32 :: u32

Int64 :: i64
Uint64 :: u64

CPtr :: Word

NodeId, PAddr, Domain   :: Word, Word, Word

CNode           :: CPtr
IRQHandler      :: CPtr
IRQControl      :: CPtr
TCB             :: CPtr
Untyped         :: CPtr
DomainSet       :: CPtr
SchedContext    :: CPtr
SchedControl    :: CPtr

Time    :: Uint64

SlotPos :: Word
SlotRegion :: struct { start, end  : SlotPos }

UntypedDesc :: struct {
    paddr       : Word,
    sizeBits    : Uint8,
    isDevice    : Uint8,
    padding     : [size_of(Word) - 2 * size_of(Uint8)]Uint8,
}


BootInfo :: BootInfoMCS when CONFIG_KERNEL_MCS else struct {
	extraLen                : Word,
	nodeID                  : NodeId,
	numNodes                : Word,
	numIOPTLevels           : Word,
	ipcBuffer               : ^IPCBuffer,
	empty                   : SlotRegion,
	sharedFrames            : SlotRegion,
	userImageFrames         : SlotRegion,
	userImagePaging         : SlotRegion,
	ioSpaceCaps             : SlotRegion,
	extraBIPages            : SlotRegion,
	initThreadCNodeSizeBits : Word,
	initThreadDomain        : Domain,

	untyped                 : SlotRegion,
	untypedList             : [CONFIG_MAX_NUM_BOOTINFO_UNTYPED_CAPS]UntypedDesc,
}

BootInfoID :: enum i32 {
	SEL4_BOOTINFO_HEADER_PADDING         = 0,
	SEL4_BOOTINFO_HEADER_X86_VBE         = 1,
	SEL4_BOOTINFO_HEADER_X86_MBMMAP      = 2,
	SEL4_BOOTINFO_HEADER_X86_ACPI_RSDP   = 3,
	SEL4_BOOTINFO_HEADER_X86_FRAMEBUFFER = 4,
	SEL4_BOOTINFO_HEADER_X86_TSC_FREQ    = 5,
	SEL4_BOOTINFO_HEADER_FDT             = 6,
	SEL4_BOOTINFO_HEADER_NUM,
}

BootInfoHeader :: struct {
    id, len : Word,
}

RootCNodeCapSlots :: enum {
    CapNull,
    CapInitThreadTCB,
    CapInitThreadCNode,
    CapInitThreadVSpace,
    CapIRQControl,
    CapASIDControl,
    CapInitThreadASIDPool,
    CapIOPortControl,
    CapIOSpace,
    CapBootInfoFrame,
    CapInitThreadIPCBuffer,
    CapDomain,
    CapSMMUSIDControl,
    CapSMMUCBControl,
    CapInitThreadSC,
    CapSMC,
    NumInitialCaps,
}

MessageInfo_t :: struct {
    words   : [1]Uint64,
}

@(private="file")
_IPCBuffer :: struct {
	tag              : MessageInfo_t,
	msg              : [MsgMaxLength]Word,
	userData         : Word,
	caps_or_badges   : [MsgMaxExtraCaps]Word,
	receiveCNode     : CPtr,
	receiveIndex     : CPtr,
	receiveDepth     : Word,
}
IPCBuffer :: struct #align(size_of(_IPCBuffer)) {
    using inner : _IPCBuffer,
}

// MCS specific types
//=============================
