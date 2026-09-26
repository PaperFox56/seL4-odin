section .text
global _start

_start:
    xor rbp,rbp
	call _seL4_entry
hang:
	jmp hang
