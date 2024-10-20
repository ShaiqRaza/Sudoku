[org 0x100]

jmp main

mistake: db 'Mistakes: 0/3', 0
timer: db '00:00', 0
score: db 'Score: 1000', 0
numbers: db 1, 2, 3, 4, 5, 6, 7, 0, 9, 1, 2, 3, 0, 5, 6, 7, 8, 9, 1, 0, 3, 4, 5, 6, 7, 8, 9, 1, 2, 0, 4, 5, 6, 7, 8, 0, 1, 0, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 0, 5, 6, 7, 8, 9, 0, 2, 3, 4, 5, 6, 0, 8, 9, 1, 2, 3, 0, 5, 6, 7, 8, 9, 1, 2, 0, 4, 5, 0, 7, 8, 9
numbersLength: dw 81

;clear screen function
clrscr:
    push di
    push es
    push ax
    mov di, 0
    mov ax, 0xb800
    mov es, ax
    nextloc:
        mov word [es:di], 0x0720
        add di, 2
        cmp di, 6000
        jne nextloc
        pop ax
        pop es
        pop di
        ret

c1:
    push bx
    mov word [es: bx+si], 0x60C9
    add si, 2
    mov word [es: bx+si], 0x60CD
    add si, 2
    mov word [es: bx+si], 0x60CD
    add si, 2
    mov word [es: bx+si], 0x60CD
    add si, 2
    mov word [es: bx+si], 0x60D1
    sub si, 8
    add bx, 160
    mov word [es: bx+si], 0x60BA
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 8
    add bx, 160
    mov word [es: bx+si], 0x60BA
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 8
    add bx, 160
    mov word [es: bx+si], 0x60BA
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 8
    add bx, 160
    mov word [es: bx+si], 0x60C7
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C5
    add si, 2
    pop bx
    ret

c2:
    push bx
    mov word [es: bx+si], 0x60CD
    add si, 2
    mov word [es: bx+si], 0x60CD
    add si, 2
    mov word [es: bx+si], 0x60CD
    add si, 2
    mov word [es: bx+si], 0x60D1
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C5
    add si, 2
    pop bx
    ret

c3:
    mov word [es: bx+si], 0x60CD
    add si, 2
    mov word [es: bx+si], 0x60CD
    add si, 2
    mov word [es: bx+si], 0x60CD
    add si, 2
    mov word [es: bx+si], 0x60BB
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60BA
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60BA
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60BA
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60B6
    add bx, 160
    mov si, 0
    ret

c4:
    push bx
    mov word [es: bx+si], 0x60BA
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 8
    add bx, 160
    mov word [es: bx+si], 0x60BA
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 8
    add bx, 160
    mov word [es: bx+si], 0x60BA
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 8
    add bx, 160
    mov word [es: bx+si], 0x60C7
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C5
    pop bx
    add si, 2
    ret

c5:
    push bx
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C5
    pop bx
    add si, 2
    ret

c6:
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60BA
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60BA
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60BA
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60B6
    add bx, 160
    mov si, 0
    ret

c7:
    push bx
    mov word [es: bx+si], 0x60BA
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 8
    add bx, 160
    mov word [es: bx+si], 0x60BA
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 8
    add bx, 160
    mov word [es: bx+si], 0x60BA
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 8
    add bx, 160
    mov word [es: bx+si], 0x60C0
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C1
    pop bx
    add si, 2
    ret

c8:
    push bx
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60B3
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C1
    pop bx
    add si, 2
    ret

c9:
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60BA
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60BA
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x6020
    add si, 2
    mov word [es: bx+si], 0x60BA
    sub si, 6
    add bx, 160
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60C4
    add si, 2
    mov word [es: bx+si], 0x60BD
    mov si, 0
    ret

printBoard:
    push bp
    mov bp, sp
    push es
    push ax
    push bx
    push cx
    push si

    mov ax, 0xb800
    mov es, ax
    mov ch, 9    
    mov ax, 160
    mul byte[bp+6]
    mov bx, ax
    mov ax, 2
    mul byte[bp+4]

printRow:
    cmp ch, 0
    jnz notEnd
        pop si
        pop cx
        pop bx
        pop ax
        pop es
        pop bp
        ret
        notEnd:
            mov cl, 9
            mov si, ax
            printColumn:
                cmp ch, 9
                jz firstRow
                cmp ch, 1
                jz lastRow

                middelRow:
                    cmp cl, 9
                    jz callC4
                    
                    cmp cl, 1
                    jz callC6

                    jmp callC5

                firstRow:
                    cmp cl, 9
                    jz callC1
                    
                    cmp cl, 1
                    jz callC3

                    jmp callC2

                lastRow:
                    cmp cl, 9
                    jz callC7
                    
                    cmp cl, 1
                    jz callC9

                    jmp callC8

                callC1:
                    call c1
                    sub cl, 1
                    jmp printColumn
                callC2:
                    call c2
                    sub cl, 1
                    jmp printColumn
                callC3:
                    call c3
                    sub ch, 1
                    jmp printRow
                callC4:
                    call c4
                    sub cl, 1
                    jmp printColumn
                callC5:
                    call c5
                    sub cl, 1
                    jmp printColumn
                callC6:
                    call c6
                    sub ch, 1
                    jmp printRow
                callC7:
                    call c7
                    sub cl, 1
                    jmp printColumn
                callC8:
                    call c8
                    sub cl, 1
                    jmp printColumn
                callC9:
                    call c9
                    sub ch, 1
                    jmp printRow

printString:
    push bp
    mov bp, sp
    push es
    push ax
    push si
    push di
    
    push ds
    pop es
    mov di, [bp+4]
    mov cx, 0xffff
    xor al, al
    repne scasb
    mov ax, 0xffff
    sub ax, cx
    dec ax
    jz exit

    mov cx, ax
    mov ax, 0xb800
    mov es, ax
    mov al, 80
    mul byte[bp+6]
    add ax, [bp+8]
    shl ax, 1
    mov di, ax
    mov si, [bp+4]
    mov ah, 0x07

    cld

    nextchar:
        lodsb
        stosw
        loop nextchar
    exit:
        pop di
        pop si
        pop ax
        pop es
        pop bp
        ret 6

printNumbers:
    push bp
    mov bp, sp
    push es
    push ax
    push si
    push di
    push bx
    push dx

    mov di, [bp+4]
    mov cx, 0
    mov ax, 160
    mul byte [bp+8]
    add ax, 320
    mov bx, ax
    mov si, [bp+10]
    shl si, 1
    add si, 4
    mov dx, si
    add dx, 72

    mov ax, 0xb800
    mov es, ax
    mov ah, 0x60

    nextCell:
        cmp cx, [bp+6]
        jz endPrinting
        mov al, byte [di]
        cmp al, 0
        jz ignoreDisplay
        add al, 0x30
        mov [es:bx+si], ax
        ignoreDisplay:
            inc cx
            add di, 1
            add si, 8
            cmp dx, si
            jnz nextCell
            sub si, 72
            add bx, 640
            jmp nextCell

    endPrinting:
        pop dx
        pop bx
        pop di
        pop si
        pop ax
        pop es
        pop bp
        ret 8

;for one cell only
placeNotes:
    push bp
    mov bp, sp
    push es
    push bx
    push ax
    push dx
    push di
    push cx

    sub word[bp+6], 160 ; row
    sub word[bp+4], 2 ; col

    mov bx, [bp+6]
    mov di, [bp+4]
    mov ah, 0x67
    mov al, 0x31
    mov dx, 0
    outer:
        mov cx, 3
        inner:
            mov [es:bx+di], ax
            add al, 1
            add di, 2
            dec cx
            cmp cx, 0
            jnz inner
        sub di, 6
        add bx, 160
        add dx, 1
        cmp dx, 3
        jb outer

    pop cx
    pop di
    pop dx
    pop ax
    pop bx
    pop es
    pop bp
    ret 4

printNotes:
    push bp
    mov bp, sp
    push es
    push ax
    push si
    push di
    push bx
    push dx

    mov si, [bp+6]; x
    shl si, 1
    add si, 4
    mov cx, 81; total cells
    mov ax, 160
    mul byte [bp+4]; y
    add ax, 320
    mov bx, ax
    mov ax, 0xb800
    mov es, ax
    mov ah, 0x60
    mov dx, si
    add dx, 72

    nextCellLocation:
        cmp word[es:bx+si], 0x6020
        jnz ignoreNotes
        ; mov word[es:bx+si], 0x0720
        push bx
        push si
        call placeNotes
        ignoreNotes:
            add si, 8
            cmp si, dx
            jnz sameRow
            sub si, 72
            add bx, 640
            sameRow:
                loop nextCellLocation

    pop dx
    pop bx
    pop di
    pop si
    pop ax
    pop es
    pop bp
    ret 4

main:
    call clrscr

    mov cx, 5;x
    push cx
    mov cx, 3;y
    push cx
    push mistake
    call printString

    mov cx, 35;x
    push cx
    mov cx, 3;y
    push cx
    push score
    call printString

    mov cx, 70;x
    push cx
    mov cx, 3;y
    push cx
    push timer
    call printString

    mov cx, 5 ;y-axis
    push cx
    mov cx, 22;x-axis
    push cx
    call printBoard
    
    mov cx, 22
    push cx
    mov cx, 5
    push cx
    push word[numbersLength]
    push numbers
    call printNumbers
    
    mov cx, 22
    push cx
    mov cx, 5
    push cx
    call printNotes

    mov ax, 4c00h
    int 21h
