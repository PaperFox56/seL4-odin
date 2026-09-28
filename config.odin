package seL4

// mem* and str* functions
INCLUDE_UTILS   :: #config(UTILS, true)

// SeL4 kernel generated configs
CONFIG_ENABLE_SMP_SUPPORT       :: #config(SMP, false)

CONFIG_FSGSBASE_INST	        :: #config(FSGSBASE_INST, true)

CONFIG_DEBUG_BUILD	            :: #config(DEBUG_KERNEL, true)
CONFIG_DANGEROUS_CODE_INJECTION :: #config(DANGEROUS_CODE_INJECTION, false)

CONFIG_KERNEL_MCS               :: #config(KERNEL_MCS, false)

CONFIG_MAX_NUM_BOOTINFO_UNTYPED_CAPS    :: #config(MAX_NUM_BOOTINFO_UNTYPED_CAPS, 230)

CONFIG_SET_TLS_BASE_SELF        :: #config(SET_TLS_BASE_SELF, true)
