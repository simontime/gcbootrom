	title   Game.com Boot
	type    8521
	org     1000h
	
	include equates.inc
	
	program

	; interrupt vector table
IVT:
	defw    DMAINT,   TIM0INT,  RESERVED, EXTINT
	defw    UARTINT,  RESERVED, RESERVED, LCDCINT
	defw    RESERVED, TIM1INT,  RESERVED, CKINT
	defw    RESERVED, PIOINT,   WDTINT,   NMIINT
	
	; code entry
entry:
	nop
	nop
	nop
	; disable interrupts
	di
	; clear ps0 (and set kernel RP), ie0, ie1 and p0c
	mov     ps0,#00000000b
	clr     ie0
	clr     ie1
	clr     p0c
	; 16-bit stack, external memory enable
	mov     sys,#1000110b
	; stack pointer is at 0x3c0
	movw    sp,#SP_START
	; set up mmu banks
	mov     mmu1,#k_bank_2
	mov     mmu2,#k_bank_4
	mov     mmu4,#k_bank_3
	; security - ensure "Tiger DMG" is in external ROM at correct offset
	movw    rr2,#sec_str
	movw    rr4,#ext_sec_str
	mov     r1,#sec_str_end-sec_str
str_cmp_loop:
	; compare string
	mov     r0,(rr2)+
	cmp     r0,(rr4)+
	br      ne,stall
	dbnz    r1,str_cmp_loop
	; security - ensure these three offsets add up to 0
	mov     r0,sec_1
	add     r0,sec_2
	add     r0,sec_3
	br      nz,stall
	; jump to external ROM entry point
	jmp     ext_entry
stall:
	; disable interrupts and stall infinitely
	di
inf_loop:
	jmp     inf_loop
	
	; security string
sec_str:
	defm    "Tiger DMG"
sec_str_end:

	; jump to "real" ISR in external ROM
TIM0INT:
	jmp     TIM0INT_ISR
EXTINT:
	jmp     EXTINT_ISR
UARTINT:
	jmp     UARTINT_ISR
LCDCINT:
	jmp     LCDCINT_ISR
TIM1INT:
	jmp     TIM1INT_ISR
CKINT:
	jmp     CKINT_ISR
PIOINT:
	jmp     PIOINT_ISR
WDTINT:
	jmp     WDTINT_ISR
NMIINT:
	jmp     NMIINT_ISR
	; DMA interrupt is stubbed
DMAINT:
RESERVED:
	iret
	
	end