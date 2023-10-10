extern realloc
extern malloc
extern free

section .text
global init_v
global delete_v
global resize_v
global get_element_v
global push_v
global pop_v
global size_v

init_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15

        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov qword [rdi] , 0
        mov qword [rdi+8] , 0
        mov qword [rdi+16] , 0

        ;my code ends here
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

delete_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        push rdi ;callee saved

        lea rax,[rdi + 16] ;  rdi + 16 contains the value which is the address of the buffer...this statement transdfer the value of the register..or the address to rax
        call free           ; so rax basically becomes a pointer

        mov qword [rdi + 16] , 0
        mov qword [rdi + 8], 0    
        mov qword [rdi] ,0

        pop rdi ;callee saved

        ;my code ends here
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

resize_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15

        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE

        mov rax,rsi 
        mov rbx,rsi
        imul rax,rax,8  
        
        mov r8, rdi
        mov rdx , qword[rdi+16] ; store the current buffer address for copying the values
        mov rcx , qword [rdi + 8] ;  store the current size value of vector for copying the values

        cmp qword[rdi] , 0
        je null_vector
        mov rdi,rdx
        mov rsi,rax
        xor rax,rax
        call realloc ; rdi and rsi is used to pass arguments

        mov qword [rdi],rsi
        mov qword [rdi+16],rax ; rax has the pointer to the new allocated memory address
        mov qword [rdi+8],rcx ; size of array remains same


        ;my code ends here
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

null_vector:
        push rbx
        push rcx
        push r8
        mov rdi, rax  ; rax number of bytes
        call malloc

        pop r8
        pop rcx
        pop rbx


        mov qword [r8],rbx
        mov qword [r8+16],rax ; rax has the pointer to the new allocated memory address
        mov qword [r8+8],rcx ; size of array remains same


        ;my code ends here
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

get_element_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE

        push rdi
        push rsi

        mov rax,rsi
        imul rax,8

        mov rcx,[rdi+16]
        add rcx,rax

        mov rax, rcx
        
        pop rsi
        pop rdi
        ; my code ends here
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

push_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE

        push rdi
        push rsi

        mov rax, qword [rdi]
        mov rbx, qword [rdi + 8]

        cmp rax,rbx
        je full

        mov rcx,rsi ; rcx contains the value to be inserted

        mov rbx,[rdi + 8] ; calculating the index of the last element + 1
        add rbx,1
        imul rbx,8

        lea rdx, [rdi + 16]
        add rdx ,rbx
        mov qword [rdx],rcx

        add qword [rdi + 8],1
        
        pop rsi
        pop rdi
        ; my code ends here

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret
full:
        mov rax,qword [rdi + 8]
        mov rbx , rax
        imul rax,2
        add rax,1

        mov rcx,rsi ; rcx contains the value to be inserted

        mov rsi,rax ; moving the arguments in the argument registers rdi and rsi
        call resize_v

        mov rbx,[rdi + 8] ; calculating the index of the last element + 1
        add rbx,1
        imul rbx,8

        mov qword [rbx],rcx
        add qword [rdi + 8],1

        pop rsi
        pop rdi

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret



pop_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE

        push rdi
        mov rax,[rdi+8];

        imul rax,8
        mov rcx,qword [rdi + 16]  ; going to the last element
        add rax,rcx
        mov rbx,qword[rax]            ; storing the last element in rbx
        mov qword [rax],0             ; making last element zero
        add qword [rdi + 8],-1              ; decreasing the size of the array by one

        mov rax,rbx   ; to return the deleted value
        
        pop rdi
        ; my code ends here
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

size_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov rax , qword [rdi+8]


        ; my code ends here
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret
