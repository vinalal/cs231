        section .text
        global  alt_sum

alt_sum:
        push rdi                       ; pointer to mat
        push rdx                       ; number of rows/ columns of the matrix (n)
        push r11

; ; 0-indexing on all matrices
; ; mat1[j][i] = rdi+(r9*j+i)*8
; ; GOAL - Perform matrix alternate summation of elements in matrix and return the sum

; ; TODO - Fill your code here performing the matrix alternate summation in the following order
; ; for(int i = 0; i < n; i++){for(int j = 0; j < n; j++){sum += (-1)^(i+j)*mat[j][i];}}

        mov rax,0
        mov rcx,0

outer_loop:
        cmp rax,rdx
        je end_loop
        mov rbx,0

inner_loop:
        cmp rbx,rdx
        je end_inner_loop

        push rax
        push rbx
        add rbx,rax
        
        cmp rbx,0
        je even
        
        bsf rax,rbx  ; this instruction basically gives the least signifcant bit which is 1...so if my number is odd, rax = 0
        cmp rax,0 
        jne even
        mov r8,-1
        jmp done_power
        
        even:
        mov r8,1
        
        done_power:

        pop rbx
        pop rax

        push rbx
        imul rbx,rdx
        add rbx,rax
        imul rbx,8
        add rbx,rdi
        mov r15,[rbx]
        imul r15,r8
        add rcx,r15
        pop rbx
        add rbx,1
        jmp inner_loop



end_inner_loop:
        add rax,1
        jmp outer_loop

end_loop:
        mov rax,rcx

; ; End of code to be filled
        pop r11
        pop rdx
        pop rdi
        ret
