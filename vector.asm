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

        mov r8,rdi
        mov rax, qword[rdi+16]
        mov rdi,rax

        push r8
        call free

        pop r8

        mov qword[r8 + 16],0
        mov qword[r8 + 8],0
        mov qword[r8] , 0


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
        
        mov r8, rdi ; This instruction copies the value from the rdi register directly into the rax register.
                    ;It's a register-to-register move operation.
        mov rcx , qword [rdi + 8] ;  store the current size value of vector

        cmp qword[rdi] , 0
        je null_vector
        
        
        push rbx
        push rcx
        push r8

        mov rdi,qword [r8+16] ; passing the argument of the address of buffer
        mov rsi,rax ; passing the new size 
        xor rax,rax 
        call realloc ; rdi and rsi is used to pass arguments

        pop r8
        pop rcx 
        pop rbx

        mov qword [r8],rbx ; storing the new buffer size
        mov qword[r8+16],rax ; rax has the pointer to the new allocated memory address   so its like 
        mov qword [r8+8],rcx ; size of array remains same
        jmp end

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
        mov qword[r8+16],rax ; rax has the pointer to the new allocated memory address...so r8 + 16 has the value of the ptr which is pointing to the newly allocated memory address
                             ; so its like r8 + 16 -> ptr = rax --> new memory
        mov qword [r8+8],rcx ; size of array remains same

        jmp end


        end:
        
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

        mov rcx,qword [rdi+16]
        add rcx,rax

        mov rax,rcx      
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

        ;calculating the index of the last element + 1
        imul rbx,8

        mov rdx, qword [rdi + 16]
        add rdx ,rbx
        mov qword [rdx],rcx

        add qword [rdi + 8],1
        
        pop rsi
        pop rdi

        jmp end_push

        ; full label when array is full
        full:

        imul rbx,2 ; rbx already contains the size of the array
        add rbx,1 

        mov rcx,rsi ; rcx contains the value to be inserted

        mov rsi,rbx ; moving the arguments in the argument registers rdi and rsi

        push rdi
        push rsi
        push rbx
        push rcx
        call resize_v  
        pop rcx
        pop rbx
        pop rsi
        pop rdi

        mov rbx,qword [rdi + 8] ; calculating the index of the last element + 1
        imul rbx,8

        mov rax,qword[rdi+16]
        add rax,rbx
        mov qword [rax],rcx   
        add qword [rdi + 8],1

        pop rsi
        pop rdi

        jmp end_push

        end_push:
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
        add rax,-1

        imul rax,8
        mov rcx,qword [rdi + 16]  ; going to the last element
        add rcx,rax
        mov rbx,qword[rcx]            ; storing the last element in rbx
        mov qword [rcx],0             ; making last element zero
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
