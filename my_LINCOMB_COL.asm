        section .text
        global lin_comb

lin_comb:
        push rdi                       ; pointer to mat1
        push rsi                       ; scaler 1
        push rdx                       ; pointer to mat2
        push rcx                       ; scaler 2
        push r8                        ; pointer to mat3
        push r9                        ; number of rows/ columns of the matrix (n)
        push r11


; ; 0-indexing on all matrices
; ; mat1[j][i] = rdi+(r9*j+i)*8
; ; GOAL - Perform matrix linear combination of mat1, mat2 and save result in mat3
; ; Note : mat1, mat2 and mat3 here are not the same as one given in problem statement.
; ; They are just placeholders for any three matrices using this functionality.

; ; TODO - Fill your code here performing the matrix linear combination in the following order
; ; for(int i = 0; i < n; i++){for(int j = 0; j < n; j++){mat3[j][i] = s1*mat1[j][i] + s2*mat2[j][i];}}

mov rax,0

outer_loop:
        cmp rax,r9
        je end_loop
        mov rbx,0
inner_loop:
        cmp rbx,r9
        je end_inner_loop
        push rbx

        imul rbx,r9
        add rbx,rax
        imul rbx,8
        mov r13,rbx
        mov r14,rbx

        add rbx,rdi
        mov r15,[rbx]
        mov rbx,r15   ; rbx contains the value of mat1[j][i]

        add r13,rdx
        mov r15,[r13]
        mov r13,r15   ; r13 contains the value of mat2[j][i]

        add r14,r8  ; r14 contains the address of mat3[j][i]

        imul rbx,rsi
        imul r13,rcx

        add rbx,r13

        mov [r14],rbx

        pop rbx
        
        add rbx,1
        jmp inner_loop



end_inner_loop:
        add rax,1
        jmp outer_loop

end_loop:

; ; End of code to be filled
        pop r11
        pop r9
        pop r8
        pop rcx
        pop rdx
        pop rsi
        pop rdi
        ret
