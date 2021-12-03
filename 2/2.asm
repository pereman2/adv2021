;; advent 2
sys_read        equ     0
sys_exit        equ     1
sys_open        equ     2
sys_write       equ     1
stdout          equ     1
letter_d          equ     100
letter_f          equ     102
letter_u          equ     117

;; call convention
;; sys  0     1   2     3   4   5
;; rax, RDI, RSI, RDX, RCX, R8, R9
global    main
extern printf
section   .text
;;  https://cs.lmu.edu/~ray/notes/nasmtutorial/
print:
  ;; rsi -> message
  ;; rdx -> num bytes
  push rbp
  push rdi
  push rax

  mov rax, sys_write             ; system call for write
  mov rdi, stdout                  ; file handle 1 is stdout
  syscall

  pop rax
  pop rdi
  pop rbp
  ret

print_buffer:
  mov rsi, buffer            
  mov rdx, 8                  
  call print
  ret
reset_buffer:
  mov qword[buffer], 0
  ret
read_chr:
  ;; r8 -> fd
  ;; r9 -> buffer
  ;; return rax, number of bytes read (sys_write out)
  push rbp
  push rdi
  push rsi
  push rdx

  mov rax, sys_read
  mov rdi, r8
  mov rsi, r9
  mov rdx, 1
  syscall

  pop rdx
  pop rsi
  pop rdi
  pop rbp
  ret
main:
  
  mov rax, sys_open
  mov rdi, input
  mov rsi, 0
  syscall

  mov r8, rax
  mov r9, buffer
  mov qword[hor], 0
  mov qword[depth], 0
read_line:
  call reset_buffer
  call read_chr
  cmp rax, 0 
  jle exit

  ;; mov rsi, buffer            
  ;; mov rdx, 8                  
  ;; call print

  cmp qword[buffer], letter_u
  je set_u
  cmp qword[buffer], letter_d
  je set_d
  cmp qword[buffer], letter_f
  je set_f
  jmp exit


set_u:  
  mov byte[sum], -1
  mov byte[forward], 0
  jmp wait_n
set_d:  
  mov byte[sum], 1
  mov byte[forward], 0
  jmp wait_n
set_f:  
  mov byte[sum], 1                   ; forward decreases
  mov byte[forward], 1
  jmp wait_n
wait_n: 
  call reset_buffer
  call read_chr
  ;; call print_buffer

  cmp qword[buffer], 10          ; if line jump read_line
  je read_line                  ; if no read then error
  cmp qword[buffer], 32          ; if whitespace then next chr is number
  je read_n

  cmp rax, 0          
  jle error                  

  jmp wait_n
read_n:
  call reset_buffer
  call read_chr
  ;; call print_buffer

  ;;  read and transform to int
  sub qword[buffer], 48
  mov r11, [buffer]

  ;; jump to forward logic
  cmp byte[forward], 1
  je do_forward


  
  cmp byte[sum], 1
  je do_sum
  ;; up
  sub qword[aim], r11
  jmp wait_n
do_sum: 
  ;; down
  add qword[aim], r11
  jmp wait_n
  ;; forward
do_forward:
  add qword[hor], r11
  mov rax, qword[aim]
  mov rdx, r11
  mul rdx
  add qword[depth], rax
  jmp wait_n
  


exit: 
xd: 
  ;; hor * depth
  mov rax, qword[depth]
  mov rdx, qword[hor]
  mul rdx
  ;; print output
  mov rdi, output_msg
  mov rsi, rax
  mov al, 0

  call printf

  mov       rax, 60                 ; system call for exit
  xor       rdi, rdi                ; exit code 0
  syscall                           ; invoke operating system to exit

error:
  mov rsi, error_msg            
  mov rdx, 6                  ; number of bytes
  call print
  jmp exit
  


section   .bss
    buffer:     resb        8   ; store char, i know this should be 1 byte, i don't care
    hor:        resb        8   ; long long horizontal
    depth:      resb        8   ; long long depth
    aim:        resb        8   ; long long aim
    forward:    resb        1   ; identify if we are forwarding
    sum:        resb        1   ; identify if we are adding or subtracting, don't judge me, first time asm
section   .data
    input:          db        "input", 0     
    hello:          db        "hello,", 0     
    world:          db        " world", 10, 0 
    error_msg:      db        " error", 10, 0 
    output_msg:      db        "wassup %lld", 10, 0 
  
