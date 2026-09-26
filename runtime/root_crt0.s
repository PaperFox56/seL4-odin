section .text
global _sel4_start

_start:
	leaq rsp,__stack_top
	movq rbp,rsp

	call _seL4_entry
hang:
	jmp  hang

section .bss
__stack_base:
	align 16
	resb 0x1000 ; 4kb stack
__stack_top:
