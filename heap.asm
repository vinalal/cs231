extern init_v
extern pop_v
extern push_v
extern size_v
extern get_element_v
extern resize_v
extern delete_v

section .text
global init_h
global delete_h
global size_h
global insert_h
global get_max
global pop_max
global heapify
global heapsort

init_h:
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
        call init_v
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

delete_h:
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
        call delete_v  
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


size_h:
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
        call size_v


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


insert_h:
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


        push rdi
        call push_v
        pop rdi
        push rdi
        call size_h
        pop rdi
        add rax,-1
        jmp while_loop

        while_loop:
        cmp rax,0
        je end_insert_heap
        mov rbx, rax
        add rbx,-1
        shr rbx,1  ; rbx = parent(rax = i)
        push rax
        mov rsi, rax 
        call get_element_v ; get_element_v takes care of storing the values of the registers
        mov rcx,rax ; rcx has the pointer to  arr[i]
        pop rax
        push rax
        mov rsi,rbx
        call get_element_v
        mov rdx,rax ; rdx has the pointer to arr[parent(i)]
        pop rax
        mov r8,qword[rdx]
        mov r9,qword[rcx]
        cmp r8,r9
        jae end_insert_heap
        mov qword[rdx],r9
        mov qword[rcx],r8
        mov rax,rbx
        jmp while_loop

        end_insert_heap:

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

get_max:
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
        mov rsi,0
        call get_element_v     
        mov rbx,qword[rax]    
        mov rax,rbx

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

pop_max:
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
        

        mov rbx,qword[rdi + 8]
        add rbx,-1

        mov rsi,0
        call get_element_v
        mov rcx,rax

        mov rsi,rbx
        call get_element_v
        mov rdx,rax

        mov r8,qword[rcx]
        mov r9,qword[rdx]
        mov qword[rcx],r9
        mov qword[rdx],r8

        call pop_v
        mov r10,rax
        
        mov rdx,0

        heapify_0:
        mov rbx,rdx ; rdx will be our counter..= i
        shl rbx,1 
        add rbx,1 ; rbx has 2*i+1

        mov rcx,rbx
        add rcx,1 ; rcx has 2*i+2

        mov rax,qword[rdi+8]
        cmp rbx,rax
        jae only_i
        cmp rcx,rax
        jae only_i_left_i

        ; code will reach here if it has both left(i) and right(i)
        mov rsi,rbx
        call get_element_v
        mov r8,rax  ; r8 has the pointer to arr[left(i)]

        mov rsi,rcx
        call get_element_v
        mov r9,rax  ; r9 has the pointer to arr[right(i)]

        mov rsi,rdx
        call get_element_v
        mov r11,rax ; r11 has the pointer to arr[i]

        mov r12,qword[r8] ; r12 has value of arr[left]
        mov r13,qword[r9] ; r13 has value of arr[right]
        mov r14,qword[r11] ; r14 has value of arr[i]

        cmp r14,r12
        jae i_greater_left
        cmp r13,r12
        jae right_largest
        
        ;reached here means left is the largest
        mov qword[r11],r12
        mov qword[r8],r14
        mov rdx,rbx
        jmp heapify_0



        right_largest:
        mov qword[r11],r13
        mov qword[r9],r14
        mov rdx,rcx
        jmp heapify_0



        i_greater_left:
        cmp r14,r13 ; i had the largest index
        jae end_heapify_0
        mov qword[r9],r14 ; reaching here means arr[right(i)] was the largest
        mov qword[r11],r13
        mov rdx,rcx
        jmp heapify_0
        

        only_i:
        jmp end_heapify_0

        only_i_left_i:
        mov rsi,rbx
        call get_element_v
        mov r11,rax     ; r11 has pointer to arr[left(i)]

        mov rsi,rdx
        call get_element_v
        mov r12,rax     ; r12 has arr[i]

        mov r13,qword[r11]
        mov r14,qword[r12]
        cmp r14,r13
        jae end_heapify_0
        mov qword[r11],r14
        mov qword[r12],r13
        
        mov rdx,rbx
        jmp heapify_0 
        
        end_heapify_0:
        mov rax,r10
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

heapify:
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

heapsort:
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
