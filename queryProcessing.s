.data

in_array:  .space 4000
q_array:   .space 4000
inputstring: .asciiz "Enter the number(n): "
inputstring1: .asciiz "Enter number of queries(q): "
outputstring: .asciiz "Output: "
outputspace : .asciiz " " 
newline: .asciiz "\n"
n : .word 0
q : .word 0
i : .word 0

.text

input_loop:
    beq $t0,$zero,done

    li $v0, 5
    syscall

    sw $v0, 0($t1)
    addi $t0,$t0,-1
    addi $t1,$t1,4
    j input_loop

done:
    la $t1,in_array
    lw $t0,n
    jr $ra

input_query_loop:
    beq $t2,$zero,done_q

    li $v0, 5
    syscall

    sw $v0, 0($t3)
    addi $t2,$t2,-1
    addi $t3,$t3,4
    j input_query_loop

done_q:
    la $t3,q_array
    lw $t2,q
    jr $ra

sort:
    addi $sp, $sp ,-4
    sw $ra, 0($sp)

    addi $t0 , $t0 , -1

    #flag for swapped
    li $t2 , 0
    jal outer_loop

    lw $ra, 0($sp)
    addi $sp, $sp ,4

    jr $ra
    
outer_loop:
    #checking if the loop is over
    beq $t0, $zero, sorted

    li $t2 , 0

    addi $sp, $sp ,-4
    sw $ra, 0($sp)

    #counter for inner loop
    move $t3, $t0
    
    jal inner_loop

    lw $ra, 0($sp)
    addi $sp, $sp ,4

    beq $t2 , 0 , sorted

    addi $t0, $t0, -1

    j outer_loop

inner_loop:
    beq $t3, $zero, in_done
    
    lw $a0, 0($t1)
    addi $t1 , $t1 , 4
    lw $a1, 0($t1)

    bgt $a0,$a1,swap

    addi $t3,$t3,-1
    j inner_loop

swap:
    li $t2,1
    sw $a0,0($t1)
    addi $t1,$t1,-4
    sw $a1,0($t1)
    addi $t1,$t1,4

    addi $t3,$t3,-1
    j inner_loop

in_done:
    la $t1,in_array
    jr $ra

sorted:
    la $t1,in_array
    lw $t0,n
    jr $ra

loop_search:
    beq $t2,$zero,done_search
    
    addi $sp,$sp,-4
    sw $ra , 0($sp)

    #intitial bounds for searching
    li $t5,0
    move $t6,$t0
    
    #query to search
    lw $a0, 0($t3)

    jal search

    #printing the value returned for the query
    li $v0, 1
    move $a0, $t4
    syscall

    li $v0 ,4
    la $a0 ,newline
    syscall

    addi $t3,$t3,4
    addi $t2,$t2,-1

    lw $ra, 0($sp)
    addi $sp, $sp ,4

    j loop_search

done_search:
    la $t3,q_array
    lw $t2,q
    jr $ra

search:
    bgt $t5,$t6,not_found

    #calculating middle index
    add $t7,$t5,$t6
    sra $t7,$t7,1
    sll $t7,$t7,2

    #accessing the middle index
    lw $t8,in_array($t7)
    sra $t7,$t7,2

    beq $t8,$a0,found

    bgt $t8,$a0,fix_right

    blt $t8,$a0,fix_left

not_found:
    li $t4, -1
    lw $t0,n
    jr $ra

found:
    move $t4, $t7
    lw $t0,n
    jr $ra

fix_left:
    addi $t5,$t7,1
    j search

fix_right:
    addi $t6,$t7,-1
    j search



print_loop:
    beq $t0,$zero,done_print

    lw $t2, 0($t1)

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0 ,4
    la $a0 ,outputspace
    syscall

    addi $t1,$t1,4
    addi $t0,$t0,-1
    j print_loop

done_print:
    la $t1,in_array
    lw $t0,n
    la $t3,q_array
    lw $t2,q

    jr $ra

q_array_print:
    beq $t2,$zero,done_print

    lw $t4, 0($t3)

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0 ,4
    la $a0 ,outputspace
    syscall

    addi $t3,$t3,4
    addi $t2,$t2,-1
    j q_array_print
    

main:
    #Prompt to take input
    li $v0 ,4
    la $a0 ,inputstring
    syscall

    li $v0, 5
    syscall
    sw $v0, n

    lw $t0 ,n
    la $t1, in_array

    jal input_loop

    li $v0 ,4
    la $a0 ,inputstring1
    syscall

    li $v0, 5
    syscall
    sw $v0, q

    lw $t2 ,q
    la $t3, q_array

    jal input_query_loop
    
    li $v0 ,4
    la $a0 ,outputstring
    syscall
    
    li $v0 ,4
    la $a0 ,newline
    syscall

    jal sort

    #jal print_loop

    li $v0 ,4
    la $a0 ,newline
    syscall

    #we are doing this again since some of these have been used after taking the queries
    lw $t2 ,q
    la $t3, q_array

    #jal q_array_print

    addi $t0,$t0,-1
    jal loop_search

    li $v0, 10
    syscall






