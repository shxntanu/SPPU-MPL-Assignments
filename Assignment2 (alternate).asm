section .data
str1: db "Enter a string: "
len1 equ $-str1
str2: db "Length of string is: "
len2 equ $-str2

section .bss
sent: resb 100
ans: resb 2

section .text
global _start

_start:

mov rax, 01
mov rdi, 01
mov rsi, str1
mov rdx, len1
syscall

mov rax, 00
mov rdi, 00
mov rsi, sent
mov rdx, 100
syscall

dec al
mov bl, al
mov rsi, ans
mov rcx, 02h

hextoascii:
rol  bl  , 04          
mov  dl  , bl
and  dl  , 0Fh         
cmp  dl  , 09h         
jbe  copydigit
add  dl  , 07h

copydigit:
add  dl  , 30h
mov  [rsi]  ,  dl
inc  rsi
dec  rcx
jnz  hextoascii

mov rax, 01
mov rdi, 01
mov rsi, ans
mov rdx, 02
syscall

mov rax, 60
mov rdx, 00
syscall
