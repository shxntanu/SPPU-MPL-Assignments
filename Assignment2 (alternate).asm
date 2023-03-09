; ------------------------------------------------
section .data
str1: db "Enter a string: "
len1 equ $-str1
str2: db "Length of string is: "
len2 equ $-str2
; ------------------------------------------------
section .bss
sent: resb 100
ans: resb 2
; ------------------------------------------------
section .text
global _start

_start:

mov rax, 01         ; Print entry statement
mov rdi, 01
mov rsi, str1
mov rdx, len1
syscall

mov rax, 00         ; Read string
mov rdi, 00
mov rsi, sent
mov rdx, 100
syscall

dec al              ; Compensate for trailing null character
mov bl, al          ; Store accumulator value in bl register
mov rsi, ans        ; Store pointer to base address of answer in rsi
mov rcx, 02h        ; Reset counter to 0x02

hextoascii:
rol  bl  , 04       ; Swap nibbles          
mov  dl  , bl       ; Store rotated nibble in dl register
and  dl  , 0Fh      ; AND with 0F (Binary: 0000 1111) to get the last nibble
cmp  dl  , 09h      ; Check if it is a digit
jbe  copydigit      ; If it is a digit, jump to copy the digit
add  dl  , 07h      ; If it is a character, add 07h and 30h --> 37h

copydigit:
add  dl  , 30h      
mov  [rsi]  ,  dl   ; Store the nibble in the corresponding address of rsi
inc  rsi            ; Increment rsi to next address
dec  rcx            ; Decrement Counter
jnz  hextoascii

mov rax, 01         ; Print length of string in HEX
mov rdi, 01
mov rsi, ans
mov rdx, 02
syscall

mov rax, 60         ; Exit system call
mov rdx, 00
syscall
