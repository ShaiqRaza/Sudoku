[org 0x100]

jmp game

mistake1: db 'Mistakes:', 0
mistake2: db '/3', 0
mistakes: dw 0

timer: db '00:00', 0
score: db 'Score: 1000', 0

solvedNumbers: db 6, 7, 2, 1, 9, 5, 3, 4, 8, 5, 3, 4, 6, 7, 8, 9, 1, 2, 1, 9, 8, 3, 4, 2, 5, 6, 7, 8, 5, 9, 7, 6, 1, 4, 2, 3, 3, 4, 5, 2, 8, 6, 1, 7, 9, 4, 2, 6, 8, 5, 3, 7, 9, 1, 7, 1, 3, 9, 2, 4, 8, 5, 6, 9, 6, 1, 5, 3, 7, 2, 8, 4, 2, 8, 7, 4, 1, 9, 6, 3, 5
numbers: db 6, 7, 2, 1, 0, 5, 3, 4, 8, 5, 3, 0, 6, 7, 8, 9, 1, 2, 1, 0, 0, 3, 4, 0, 5, 6, 0, 8, 5, 9, 7, 6, 1, 4, 0, 3, 3, 4, 5, 2, 8, 6, 0, 7, 9, 0, 2, 6, 8, 0, 3, 7, 9, 0, 7, 1, 3, 9, 2, 4, 0, 5, 6, 0, 0, 1, 0, 3, 7, 2, 0, 4, 2, 8, 7, 0, 1, 9, 6, 0, 5
numbersLength: dw 81
currentScrollUp: db 0

how1: db 'Scroll up: s',0
how2: db 'Scroll down: w',0
how3: db 'First Number: row',0
how4: db 'Second Number: column',0
how5: db 'Third Number: value',0

line:db '===========================================',0
m1:db 'Welcome to Sudoku!',0
m2:db 'Get ready to solve the puzzle!',0
m3:db  'For better experience go through the rules:',0
m4:db   '1. Fill the grid as every row, column and 3x3 box contains the digits 1-9.',0
m5:db '2. No number can repeat within any row, column or 3x3 box.',0
m6:db 'Are you ready for the challenge?',0
m7:db 'Press any key to Start',0

cursorIndex: db 1
cursorPosition: dw 1328
oldisr: dw 0, 0

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
    ret 

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
    ret 

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

printnum:
    push bp 
    mov  bp, sp 
    push es 
    push ax 
    push bx 
    push cx 
    push dx 
    push di 
    mov  ax, 0xb800 
    mov  es, ax             ; point es to video base 
    mov  ax, [bp+4]         ; load number in ax 
    mov  bx, 10             ; use base 10 for division 
    mov  cx, 0              ; initialize count of digits 
    nextdigit:    
        mov  dx, 0              ; zero upper half of dividend 
        div  bx                 ; divide by 10 
        add  dl, 0x30           ; convert digit into ascii value 
        push dx                 ; save ascii value on stack 
        inc  cx                 ; increment count of values  
        cmp  ax, 0              ; is the quotient zero 
        jnz  nextdigit          ; if no divide it again 
        mov  di, [bp+8]     ; x axis
        shl di, 1
        mov ax, 160  ; y axis
        mul byte[bp+6]
        add di, ax

    nextpos:
        pop dx
        mov  dh, 0x07           ; use normal attribute 
        mov [es:di], dx         ; print char on screen 
        add  di, 2              ; move to next screen location 
        loop nextpos            ; repeat for all digits on stack
        pop  di 
        pop  dx 
        pop  cx 
        pop  bx 
        pop  ax 
        pop  es 
        pop  bp 
        ret  6

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

printWord:
    push bp
    mov bp, sp
    push ax
    push cx
    push di
    push si
    push es
    mov ax, 0xb800
    mov es, ax
    mov al, 80
    mul byte [bp+8]     
    add ax, word [bp+10]
    shl ax, 1
    mov di, ax
    mov si, word [bp+4]
    mov ah, byte [bp+6]
	PrintWordLoop:
		cmp byte[si],0
		je Done
		mov al,[si]
		inc	si
		stosw                
		jmp PrintWordLoop
		Done:
		pop es
		pop si
		pop di
		pop cx
		pop ax
		pop bp
		ret 8

printCursor:
    push es
    push ax
    push bx

    mov ax, 0xb800
    mov es, ax
    mov bx, [cursorPosition]
    mov word[es:bx], 0xe05f

    pop bx
    pop ax
    pop es
    ret

display:
    push cx

    call clrscr
    mov cx, 5;x
    push cx
    mov cx, 3;y
    push cx
    push mistake1
    call printString

    mov cx, 15;x
    push cx
    mov cx, 3;y
    push cx
    push word [mistakes]
    call printnum

    mov cx, 16;x
    push cx
    mov cx, 3;y
    push cx
    push mistake2
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

    call printCursor

    pop cx
    ret

displayStartScreen:
    push ax
    call clrscr

    push 18
	push 1
	push 0x0F
	push line
    call printWord

    push 30
	push 2
	push 0x0B
	push m1
    call printWord

    push 18
	push 3
	push 0x0F
	push line
    call printWord

    push 5
	push 8
	push 0x0b
	push m3
    call printWord

    push 2
	push 10
	push 0x0A
	push m4
    call printWord

    push 2
	push 11
	push 0x0A
	push m5
    call printWord

    push 23
	push 16
	push 0x0c
	push m6
    call printWord

    push 18
	push 19
	push 0x0F
	push line
	call printWord
	
	push 28
	push 20
	push 0x8d
	push m7
	call printWord
	
	
	push 18
	push 21
	push 0x0F
	push line
	call printWord

    mov ah, 0
    int 0x16

    call display

    pop ax
    ret

int9hisr:
	    push ax                 ; push all regs  
        push bx 
        push cx 
        push dx 
        push si 
        push di 
        push bp 
        push ds 
        push es
         
        push cs 
        pop  ds                 ; point ds to our data segment 

	    in al, 0x60

        cmp al, 0x4B       
        je moveLeft
        cmp al, 0x48       
        je moveUp
        cmp al, 0x50       
        je moveDown
        cmp al, 0x4D       
        je moveRight

        jmp int9hisrextended
        jmp int9hisrextended

        moveUp:
            cmp byte [cursorIndex], 9
            jna exitFromint9h
            sub word[cursorPosition], 160*4
            sub byte [cursorIndex], 9
            call display
            jmp exitFromint9h

        moveDown:
            cmp byte [cursorIndex], 72
            ja exitFromint9h
            add word[cursorPosition], 160*4
            add byte [cursorIndex], 9
            call display
            jmp exitFromint9h
        
        moveLeft:
            mov ah, 0
            mov al, byte [cursorIndex]
            mov dh, 9
            div dh  
            cmp ah, 1
            je exitFromint9h
            sub word[cursorPosition], 8
            sub byte[cursorIndex], 1
            call display
            jmp exitFromint9h

        moveRight:
            mov ah, 0
            mov al, byte [cursorIndex]
            mov dh, 9
            div dh
            cmp ah, 0
            je exitFromint9h
            add word[cursorPosition], 8
            add byte [cursorIndex], 1
            call display
            jmp exitFromint9h

    exitFromint9h:
              pop  es 
              pop  ds 
              pop  bp 
              pop  di 
              pop  si 
              pop  dx 
              pop  cx 
              pop  bx 
              pop  ax 
              jmp far [cs:oldisr] 

    int9hisrextended:
        cmp al, 0x1f
        jne skipscrollup
        cmp byte[currentScrollUp], 20
        je exitFromExtended
        call scrollup
        inc byte [currentScrollUp]
        jmp exitFromExtended
        skipscrollup:
        cmp al, 0x11
        jne skipscrolldown
        cmp byte[currentScrollUp], 0
        je exitFromExtended
        call scrolldown
        dec byte [currentScrollUp]
        jmp exitFromExtended
        skipscrolldown:
        cmp al, 0x02
        jb exitFromExtended ; AL is less than 0x02, not a digit 
        cmp al, 0x0A 
        ja exitFromExtended ; AL is greater than 0x0A, not a digit

        jmp inputValue

        exitFromExtended:
              pop  es 
              pop  ds 
              pop  bp 
              pop  di 
              pop  si 
              pop  dx 
              pop  cx 
              pop  bx 
              pop  ax 
              jmp far [cs:oldisr] 

    inputValue:
        mov bh, 0
        mov bl, byte [cursorIndex]
        sub bl, 1
        cmp byte [numbers + bx], 0
        jne exitFromExtended

        cmp al, 0x02          
        jne digit2
        mov byte [numbers+bx], 1
        jmp exitInputValue
        digit2:
        cmp al, 0x03          
        jne digit3
        mov byte [numbers+bx], 2
        jmp exitInputValue
        digit3:
        cmp al, 0x04          
        jne digit4
        mov byte [numbers+bx], 3
        jmp exitInputValue
        digit4:
        cmp al, 0x05          
        jne digit5
        mov byte [numbers+bx], 4
        jmp exitInputValue
        digit5:
        cmp al, 0x06          
        jne digit6
        mov byte [numbers+bx], 5
        jmp exitInputValue
        digit6:
        cmp al, 0x07          
        jne digit7
        mov byte [numbers+bx], 6
        jmp exitInputValue
        digit7:
        cmp al, 0x08          
        jne digit8
        mov byte [numbers+bx], 7
        jmp exitInputValue
        digit8:
        cmp al, 0x09          
        jne digit9
        mov byte [numbers+bx], 8
        jmp exitInputValue
        digit9:
        cmp al, 0x0A          
        jne exitInputValue
        mov byte [numbers+bx], 9

        exitInputValue:
            mov ah, byte [solvedNumbers+bx]
            cmp ah, byte [numbers+bx]
            je continueExit
            add byte [mistakes], 1
            continueExit:
                call display
                pop  es 
                pop  ds 
                pop  bp 
                pop  di 
                pop  si 
                pop  dx 
                pop  cx 
                pop  bx 
                pop  ax 
                jmp far [cs:oldisr] 

game:

    xor ax, ax
    mov es, ax
    mov ax, [es:9*4]
    mov [oldisr], ax
    mov ax, [es:9*4+2]
    mov [oldisr+2], ax
    cli
    mov word [es:9*4], int9hisr
    mov [es:9*4+2], cs
    sti

    call displayStartScreen

    start:
        cmp byte [mistakes], 3
        jne start
    call clrscr
    
    end:
        mov ax, 4c00h
        int 21h