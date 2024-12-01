[org 0x100]

jmp game

mistake: db 'Mistakes: 0/3', 0
timer: db '00:00', 0
score: db 'Score: 1000', 0

solvedNumbers: db 6, 7, 2, 1, 9, 5, 3, 4, 8, 5, 3, 4, 6, 7, 8, 9, 1, 2, 1, 9, 8, 3, 4, 2, 5, 6, 7, 8, 5, 9, 7, 6, 1, 4, 2, 3, 3, 4, 5, 2, 8, 6, 1, 7, 9, 4, 2, 6, 8, 5, 3, 7, 9, 1, 7, 1, 3, 9, 2, 4, 8, 5, 6, 9, 6, 1, 5, 3, 7, 2, 8, 4, 2, 8, 7, 4, 1, 9, 6, 3, 5
numbers: db 5, 3, 0, 0, 7, 0, 0, 0, 0, 6, 0, 0, 1, 9, 5, 0, 0, 0, 0, 9, 8, 0, 0, 0, 0, 6, 0, 8, 0, 0, 0, 6, 0, 0, 0, 3, 4, 0, 0, 8, 0, 3, 0, 0, 1, 7, 0, 0, 0, 2, 0, 0, 0, 6, 0, 6, 0, 0, 0, 0, 2, 8, 0, 0, 0, 0, 4, 1, 9, 0, 0, 5, 0, 0, 0, 0, 8, 0, 0, 7, 9
numbersLength: dw 81
currentScrollUp: db 0

how1: db 'Scroll up: s',0
how2: db 'Scroll down: w',0
how3: db 'First Number: row',0
how4: db 'Second Number: column',0
how5: db 'Third Number: value',0

scrollup:     
    push bp 
    mov  bp, sp 
    push ax 
    push cx 
    push dx
    push si   
    push di 
    push es 
    push ds 

    mov si, 800             ; Start of scrollable section (row 5, byte offset)
    mov ax, 0xb800
    mov es, ax

    ; Save lines to wrap (rows that will scroll out)
    mov cx, 80              ; CX = number of words to save for wrapping
    storingvalues:
        push word [es:si]   ; Save word to stack
        add si, 2           ; Move to next word (2 bytes per word)
        loop storingvalues

    ; Scroll up rows 6-25 (move memory up)
    mov si, 960
    mov di, 800             ; Destination: row 5 (800 = 5 * 160)
    mov cx, 3120           ; Total bytes in rows 5 to 25 (160 bytes * 20 rows)
    mov ax, 0xb800          ; Video memory segment
    mov es, ax              ; Set ES to video memory
    mov ds, ax              ; Set DS to video memory
    cld                     ; Set auto-increment mode
    rep movsw               ; Move remaining rows up

    ; Restore wrapped lines at the bottom
    mov cx, 80              ; CX = number of words to restore
    mov di, 7198            ; Start of bottom of scrollable section (row 25, byte offset)
    storedPushedlocations:
        pop dx              ; Retrieve saved word
        mov [es:di], dx     ; Write word to new location
        sub di, 2           ; Move backward
        loop storedPushedlocations

    ; Restore registers
    pop ds 
    pop es 
    pop di 
    pop si 
    pop dx
    pop cx 
    pop ax 
    pop bp 
    ret 2

scrolldown: 
    push bp 
    mov  bp, sp 
    push ax 
    push cx 
    push dx
    push si   
    push di 
    push es 
    push ds 

    mov si, 7040             ; Start of scrollable section (row 5, byte offset)
    mov ax, 0xb800
    mov es, ax

    ; Save lines to wrap (rows that will scroll out)
    mov cx, 80              ; CX = number of words to save for wrapping
    storinglastrowvalues:
        push word [es:si]   ; Save word to stack
        add si, 2           ; Move to next word (2 bytes per word)
        loop storinglastrowvalues

    ; Scroll up rows 6-25 (move memory up)
    mov si, 7038
    mov di, 7198             ; Destination: row 5 (800 = 5 * 160)
    mov cx, 3120           ; Total bytes in rows 5 to 25 (160 bytes * 20 rows)
    mov ax, 0xb800          ; Video memory segment
    mov es, ax              ; Set ES to video memory
    mov ds, ax              ; Set DS to video memory
    std                     ; Set auto-decrement mode
    rep movsw               ; Move remaining rows up

    ; Restore wrapped lines at the bottom
    mov cx, 80              ; CX = number of words to restore
    mov di, 958            ; Start of bottom of scrollable section (row 25, byte offset)
    storingPushedlocations:
        pop dx              ; Retrieve saved word
        mov [es:di], dx     ; Write word to new location
        sub di, 2           
        loop storingPushedlocations

    ; Restore registers
    pop ds 
    pop es 
    pop di 
    pop si 
    pop dx
    pop cx 
    pop ax 
    pop bp 
    ret 2

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
        cmp di, 7200
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
            ret 4
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

display:
    push cx

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

    pop cx
    ret

game:

    call display

    start:
        mov ah, 0
        int 0x16
        cmp al, 0x73
        jne skipscrollup
        cmp byte[currentScrollUp], 20
        je start
        call scrollup
        inc byte [currentScrollUp]
        skipscrollup:
        cmp al, 0x77
        jne skipscrolldown
        cmp byte[currentScrollUp], 0
        je start
        call scrolldown
        dec byte [currentScrollUp]
        skipscrolldown:
        cmp al, 0x1B
        je end
    jmp start

    end:
        mov ax, 4c00h
        int 21h
