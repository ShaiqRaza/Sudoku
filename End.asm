[org 0x0100]

jmp start

message: db 'END GAME!!!',0

clrscr:
    push es
    push ax
    push di

    mov ax,0xb800
    mov es,ax
    mov di,0

nextloc:
    
    mov word [es:di],0x0720
    add di,2

    cmp di,4000
    jne nextloc

    pop di
    pop ax
    pop es
    ret


printstr:
    push bp
    mov bp,sp
    push es
    push ax
    push si
    push di
    

    mov ax,0xb800
    mov es,ax
    mov di,1032

    mov si,[bp+4]
    mov ah, 135
    

nextchar:
    mov al,[si]
    mov word [es:di],ax
    add di,2
    inc si
    
    cmp byte [si],0
    jne nextchar
    



    
    pop di
    pop si
    pop ax
    pop es
    pop bp
    ret 2


start:
    mov ax, message
    push ax

    call clrscr
    call printstr

    mov ax,0x4c00
    int 21h
