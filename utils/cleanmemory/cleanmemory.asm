    processor 6502

    seg code
    org $F000 ; define the code origin at $F000

Start:
    sei       ; disable interrupts
    cld       ; disable the bcd decimal math mode
    ldx #$FF  ; loads the x register with #$FF
    txs       ; transfer the x register to the (S)tack pointer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the page zero region ($00 to $FF)
; Meaning the entire RAM and also the entire TIA Registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #0         ; A = 0
    ldx #$FF       ; X = #$FF
    sta $FF        ; make sure $FF is zeroed before the loop starts
MemoryLoop:
    dex            ; X--
    sta $0,X       ; store the value of A inside the memory address $0 + X
    bne MemoryLoop ; branch if not equal to zero to memory loop (Loop until x is equal to zero) (z-flag is set)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC      ; Set the origin to the end of the cartige
    .word Start    ; Reset vector at $FFFC ( where the program starts)
    .word Start    ; Interrupt vector at $FFFE (unused in the VCS)
