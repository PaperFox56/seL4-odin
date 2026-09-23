package seL4

// seL4_MsgLimits
MsgLengthBits   :: 7
MsgExtraCapBits :: 2
MsgMaxLength    :: 120


MsgMaxExtraCaps :: (1 << MsgExtraCapBits) - 1
