.data

in_array:  .space 40000
inputstring: .asciiz "Enter the number(n): "
inputstring1: .asciiz "Enter number of queries(q): "
outputspace : .asciiz " " 
newline: .asciiz "\n"
n : .word 0
q : .word 0
i : .word 0

.text

#taking n inputs from the user and storing in in_array
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

#label to find the maximum value among the node, left child and right child
largest_index:
    bge $t3,$t1,leaf                   #means its a leaf
    bge $t4,$t1,only_left_child        #node has only left child
    lw $t6,in_array($t3)               #if node has both left and right child then only it comes here
    lw $t7,in_array($t4)
    lw $t8,in_array($a2)

    bgt $t6,$t7,left_greater_than_right
    bgt $t7,$t8,right_larget
    
    move $t5,$a2
    jr $ra

left_greater_than_right:
    bgt $t6,$t8,left_largest
    move $t5,$a2
    jr $ra

leaf:
    move $t5,$a2
    jr $ra

only_left_child:
    lw $t6,in_array($t3)
    lw $t7,in_array($a2)
    bgt $t6,$t7,left_largest
    move $t5,$a2
    jr $ra

left_largest:
    move $t5,$t3
    jr $ra

right_larget:
    move $t5,$t4
    jr $ra   

#I have used a2 to make this heapify general function
heapify:
    addi $sp, $sp ,-4
    sw $ra, 0($sp)
    
    #t3 denotes index of left child
    #t4 denotes index of right child
    sll $t3,$a2,1
    addi $t3,$t3,1     
    addi $t4,$t3,1

    sll $a2,$a2,2                   #to get the index in mips format
    sll $t1,$t1,2                   #to get the index in mips format
    sll $t3,$t3,2                   #to get the index in mips format
    sll $t4,$t4,2                   #to get the index in mips format

    #we get the index answer in t5
    jal largest_index
    
    beq $t5,$a2,heapify_done 

    #had written a4 previosly..but that doesnt exist!..hence wrote s4
    move $a3,$a2
    move $s4,$t5
    jal swap
    move $a2 ,$t5
    sra $a2,$a2,2                   #to get the index in c++ format
    sra $t1,$t1,2                   #to get the index in C++ format
    
    lw $ra, 0($sp)
    addi $sp, $sp ,4

    j heapify

#swaping two elements of the sorted array
swap:
    lw $a0 , in_array($a3)
    lw $a1 , in_array($s4)
    sw $a0 , in_array($s4)
    sw $a1 , in_array($a3)
    jr $ra


heapify_done:
    lw $ra, 0($sp)
    addi $sp, $sp ,4
    sra $t1,$t1,2
    jr $ra

#building a heap from a binary tree
buildheap:
    beq $t0,$zero,done
    
    addi $t0,$t0,-1

    addi $sp, $sp ,-4
    sw $ra, 0($sp)

    move $a2, $t0
    jal heapify
    
    lw $ra, 0($sp)
    addi $sp, $sp ,4

    j buildheap

#deleting the max and fixing the heap
delete_max:
    addi $sp, $sp ,-4
    sw $ra, 0($sp)

    addi $t1,$t1,-1
    move $a3,$zero 
    move $s4,$t1                       

    sll $s4,$s4,2
    jal swap

    move $a2,$zero
    jal heapify

    lw $ra, 0($sp)
    addi $sp, $sp ,4

    jr $ra
    
#delete loop to delete the largest element in the heap(Root)
del_loop:
    beq $t0,$zero,done
    
    addi $sp, $sp ,-4
    sw $ra, 0($sp)

    #t1 and t0 both have n right now
    move $t1,$t0
    jal delete_max

    lw $ra, 0($sp)
    addi $sp, $sp ,4

    addi $t0,$t0,-1
    j del_loop

#heapsort algorithm
sort:
    addi $sp, $sp ,-4
    sw $ra, 0($sp)

    move $t1,$t0
    jal buildheap

    move $t1,$t0
    jal del_loop
    
    lw $ra, 0($sp)
    addi $sp, $sp ,4

    jr $ra

#label to take q inputs, searching it in the sorted array and printing its respective output
query_loop:
    beq $t2,$zero,done_q

    addi $sp, $sp ,-4
    sw $ra, 0($sp)

    li $v0, 5
    syscall

    move $a0 , $v0

    #intitial bounds for searching
    li $t5,0
    move $t6,$t0

    jal search

    #printing the value returned for the query
    li $v0, 1
    move $a0, $t4
    syscall

    li $v0 ,4
    la $a0 ,newline
    syscall
    
    lw $ra, 0($sp)
    addi $sp, $sp ,4

    addi $t2,$t2,-1
    
    j query_loop

done_q:
    lw $t2,q
    jr $ra

#binary search the query q and if found return its index, otherwise return -1
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


#label to print the in_array if needed
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
    lw $t2,q
    
    jr $ra
    

main:
    #taking input size(n) from the user
    li $v0, 5
    syscall
    sw $v0, n

    lw $t0 ,n
    la $t1, in_array

    #taking n inputs from the user and storing in in_array
    jal input_loop

    #taking number of queries size(q) from the user
    li $v0, 5
    syscall
    sw $v0, q

    lw $t2 ,q

    #using heapsort to sort the in_array
    jal sort

    lw $t2 ,q

    #taking the q inputs and giving the respective output
    jal query_loop

    li $v0, 10
    syscall







