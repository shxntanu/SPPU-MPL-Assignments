section .data
str: db "Enter a string: ", 0xA
len: equ $-str
opmsg: db "Length of string is: "
len2: equ $-opmsg

section .bss
str1: resb 10
leng: resb 2

section .text
global _start

_start:

                      ; "Enter a string: "
mov rax,1
mov rdi, 1
mov rsi, str
mov rdx, len
syscall

                      ; Reading the string
mov rax,0
mov rdi, 0
mov rsi, str1
mov rdx, 20
syscall

dec al                ; Decrement al to compensate for trailing null character
mov  rsi , length
cmp al ,09h
jbe L1

; ADD 07H TO GET ASCII FROM HEX VALUE
; IF CHAR IS BETWEEN A AND F
add al, 07h

; ADDING 30H TO GET ASCII FROM HEX VALUE
; IF CHAR IS BETWEEN 0 AND 9
L1:
add al, 30h
mov byte[leng] ,al

mov rax,1
mov rdi, 1
mov rsi, opmsg
mov rdx, len2
syscall

mov rax,1
mov rdi, 1
mov rsi, leng
mov rdx, 1
syscall

mov rax, 60
mov rdi, 00
syscall
