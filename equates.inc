; "Tiger DMG" in external ROM
ext_sec_str equ 202fh

; security locations
sec_1       equ 20f0h
sec_2       equ 2580h
sec_3       equ 4000h

; ISR locations
TIM0INT_ISR equ 2039h
EXTINT_ISR  equ 203ch
UARTINT_ISR equ 203fh
LCDCINT_ISR equ 2042h
TIM1INT_ISR equ 2045h
CKINT_ISR   equ 2048h
PIOINT_ISR  equ 204bh
WDTINT_ISR  equ 204eh
NMIINT_ISR  equ 2051h

; external ROM entry point
ext_entry   equ 2054h

; start start location
SP_START    equ 3c0h

; banks
k_bank_1    equ 1 ; 0x2000
k_bank_2    equ 2 ; 0x4000
k_bank_3    equ 3 ; 0x6000
k_bank_4    equ 4 ; 0x8000
k_bank_5    equ 5 ; 0xa000