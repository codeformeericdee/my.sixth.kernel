%include "Int16.asm"
AttemptRead: db "Attempting to read sector 2 into 0xbb8.", 255
BadRead: db "The disk read could not connect.", 255

LoadSector2bb8:

    pusha

    mov si, AttemptRead
    call Int16

    mov dl, 0 ; Drive number to get
    mov dh, 0 ; Head number to use

    mov cl, 2 ; Sector to use
    mov ch, 0 ; Track/cylinder number

    mov bx, 0xbb8
    mov es, bx ; Segment to load
    xor bx, bx ; Segment offset to load at

    mov ah, 2 ; Read mnemonic
    mov al, 1 ; Number of sectors to read

    int 16
    jc .haltWithError
    
    popa
    
    ret

.haltWithError:

    mov si, BadRead
    call Int16
    
    cli
    hlt