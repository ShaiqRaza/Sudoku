[org 0x0100]

jmp start

message: db 'Welcome'
length: dw 7

start_game: db 'Start Game',0
load_game: db 'Load Game',0
Delete_game: db 'Delete Game',0

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
    push cx
    push si
    push di


    mov ax,0xb800
    mov es,ax
    mov di,1032

    mov si,[bp+6]
    mov cx,[bp+4]
    mov ah, 23
    

nextchar:
    mov al,[si]
    mov word [es:di],ax
    add di,2
    inc si
    
    loop nextchar


    mov si,start_game
    mov di,1348

start_game_print:
    mov al,[si]
    mov word [es:di],ax
    add di,2
    inc si
    
    cmp byte [si],0
    jne start_game_print
    
    mov si,load_game
    mov di,1508

load_game_print:

    mov al,[si]
    mov word [es:di],ax
    add di,2
    inc si
    
    cmp byte [si],0
    jne load_game_print

    mov si,Delete_game
    mov di,1668

Delete_game_print:

    mov al,[si]
    mov word [es:di],ax
    add di,2
    inc si
    
    cmp byte [si],0
    jne Delete_game_print


    pop di
    pop si
    pop cx
    pop ax
    pop es
    pop bp
    ret 4


start:
    mov ax, message
    push ax

    mov ax,length
    push word [length]

    call clrscr
    call printstr

    mov ax,0x4c00
    int 21h
