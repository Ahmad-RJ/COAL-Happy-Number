[org 0x0100]
jmp start
num: dw 0
temp: dw 0
message1: db 'Happy', 0
message2: db 'Unhappy', 0
start:

mov ax, 0xB800
mov es, ax
mov di, 0
hello:
mov word[es:di], 0x0720
add di, 2
cmp di, 4000
jne hello

mov bx, 10
mov cx, 4
inputt:
mov ah, 0
int 0x16
sub al, 0x30
mov ah, 0
add [num], ax
cmp cx, 1
je nexttt
mov ax, [num]
mul bx
mov [num], ax
mov ax, 0
loop inputt

nexttt:
cmp word[num], 1
je printhappy

mov cx, 256
check:
l1:
mov ax, [num]
mov bl, 10
div bl
mov bh, ah
mov dx, 0
mov word[num], dx
mov ah, 0
add word[num], ax
mov al, bh
mul bh
add word[temp], ax
cmp word[num], 0
jne l1

cmp word[temp], 1
je printhappy
mov ax, [temp]
mov word[num], ax
mov dx, 0
mov word[temp], dx
loop check

mov ax, 0xB800
mov es, ax
mov di, 160
mov si, message2
mov ah, 0x07
mov cx, 7
hello2:
mov al, [si]
mov word[es:di], ax
add di, 2
inc si
loop hello2
jmp end

printhappy:
mov ax, 0xB800
mov es, ax
mov di, 160
mov si, message1
mov ah, 0x07
mov cx, 5
hello1:
mov al, [si]
mov word[es:di], ax
add di, 2
inc si
loop hello1

end:
mov ax, 0x4c00
int 0x21