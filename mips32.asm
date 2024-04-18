.data 
    somestring: .asciiz "fancywordsmith"
    matrix1: .word 7, 2, 7 
             .word 3, 5, 2
             .word 3, 5, 6
    matrix2: .word 1, 3, 5
             .word 2, 1, 2
             .word 3, 5, 4
    result:  .space 36    # Space for the result (3x3 matrix)
    node: .word 0 #data field
          .word 0 #pointer to next node
    head: .word 0 #pointer to the head of the linked list
.text
    .globl main

main:
    # la $a0, somestring 
    # jal reverse_string

    # li $a0, 6 #factorial number
    # jal factorial

    li $a0, 3
    la $a1, matrix1
    la $a2, matrix2
    jal matrix_mult

    li $a0, 3 #matrix size
    la $a1, result
    jal print_matrix
    
j exit
insert:
    move $t0, $a0 #getting node data from arg
    li $v0, 9 # instruction to allocate memory (sbrk)
    li $a0, 8 #arg for how many bytes to allocate (4 data, 4 pointer)
    syscall
    move $t1, $v0 #v0 is returned the address of the new node, now in t1

    sw $t0, 0($t1) #store t0 data in node
    
matrix_mult:
    #alternative to this is $sp, allocate with addi sp sp -4x, and access with 4x(sp)
    la $t2, result
    move $t3, $a0 #matrix size
    li $t4, 0 #row
    li $t5, 0 #col
    li $t7, 0 #inner-inner loop counter
    li $t8, 0 #for universal / all matrixes sizes lookup
    li $s0, 0 #total accumulation store
    li $s1, 0 #matrix1 store
    li $s2, 0 #matrix2 store
    li $s3, 0 #multiplication store

    j matrix_inner_loop

    matrix_outer_loop:
        addi $t4, $t4, 1 #source, destination, amount -- increment outer loop
        beq $t4, $t3, matrix_end #end when outer hits matrix size
        li $t5, 0 #reset inner loop

    matrix_inner_loop:
        #Run loop code here
        li $t7, 0 #inner inner loop's counter
        li $s0, 0 #reset mult stored value
        inner_inner_loop:
            #MATRIX2 - use col, incrmeent row
            move $t0, $t7
            move $t1, $t5 
            mul $t8, $t3, 4 #is the multiplier for the row
            mul $t0, $t0, $t8 #mult8 by 8 for 2x2, 12 for 3x3
            sll $t1, $t1, 2 #shift left by 2 bits, aka mult by 4

            add $t0, $t0, $t1 #combine row.col values, stored in t0
            add $t0, $t0, $a2 #add offset to the matrix2 mem addr

            lw $s2, ($t0) #getting the value at the position of the matrix 

            #MATRIX1 - use row, increment col
            move $t0, $t4
            move $t1, $t7 
            mul $t8, $t3, 4 #is the multiplier for the row
            mul $t0, $t0, $t8 #mult8 by 8 for 2x2, 12 for 3x3
            sll $t1, $t1, 2 #shift left by 2 bits, aka mult by 4

            add $t0, $t0, $t1 #combine row.col values, stored in t0
            add $t0, $t0, $a1 #add offset to the matrix1 mem addr

            lw $s1, ($t0) #getting the value at the position of the matrix 

            #-=- -=-

            mul $s3, $s1, $s2 #multiply the 2 values from matrix1 and 2 together

            add $s0, $s0, $s3 #combining values from both matrices

            addi $t7, $t7, 1
            beq $t7, $t3, matrix_inner_jump #we dont want to just.. restart the loop when we're done

            j inner_inner_loop

        matrix_inner_jump:
        move $t0, $t4
        move $t1, $t5
        mul $t8, $t3, 4 #is the multiplier for the row
        mul $t0, $t0, $t8 #mult8 by 8 for 2x2, 12 for 3x3
        sll $t1, $t1, 2 #shift left by 2 bits, aka mult by 4

        add $t0, $t0, $t1 #combine row.col values, stored in t0
        add $t0, $t0, $t2 #add offset to the matrix mem addr

        sw $s0, ($t0)
        #-=-=-
        addi $t5, $t5, 1
        beq $t5, $t3, matrix_outer_loop #inner (col) hits size(2,3,etc), increment outer (row)
        
        j matrix_inner_loop

    matrix_end:
    jr $ra

print_matrix:
    move $t8, $ra #;p
    move $t1, $a0 #stored matrix size
    li $t2, 0 #row
    li $t3, 0 #col
    move $t0, $a1 #address of matrix to t0
    li $t6, 0

    j pm_inner_loop

    pm_outer_loop:
        addi $t2, $t2, 1 #source, destination, amount -- increment outer loop
        beq $t2, $t1, pm_end #end when outer hits 2
        li $t3, 0 #reset inner loop

    pm_inner_loop:
        jal pw #looping the print functionality on every index
        
        #-=-=-
        addi $t3, $t3, 1
        beq $t3, $t1, pm_outer_loop #inner hits 2, increment outer
        
        j pm_inner_loop
    
    pw:
        move $t7, $ra
        #making copies
        move $t4, $t2
        move $t5, $t3

        mul $t9, $t1, 4 #is the multiplier for the row
        mul $t4, $t4, $t9 #mult8 by 8 for 2x2, 12 for 3x3

        sll $t5, $t5, 2 #shift left by 2 bits, aka mult by 4

        add $t4, $t4, $t5 #combine row+col values, stored in t4
        add $t4, $t4, $t0 #add offset to the matrix mem addr

        li $v0, 1
        lw $a0, ($t4) #a0 reg to print, loaded from matrix
        syscall

        li $v0, 11 #print character
        li $a0, 44 #comma
        syscall
        
        subi $t6, $t1, 1
        beq $t3, $t6, newline #if our current col counter is printing the last row(col==size), print newline

        jr $t7

    pm_end:
        jr $t8

    newline:
        li $v0, 11
        li $a0, '\n'
        syscall
        jr $t7

reverse_string:
    
    move $t0, $a0 #first pointer
    move $t1, $a0 #second pointer

    find_end:
        lb $t2, ($t1) #load character at pointer in register
        beqz $t2, end_found #if character == zero, we hit end of string. jump to end_found
        addi $t1, $t1, 1 #increment pointer by 1
        j find_end #recursive; load, search, increment again

    end_found:
        subi $t1, $t1, 1 #we go past when finding zero (end), so go back 1 index
        j reverse_loop #just consistency

    reverse_loop:
        bge $t0, $t1, end_reverse #if pointers have collided/gone past, we're done 
        #Memory - > Register
        lb $t2, ($t0) # Load actual character at start pointer to register
        lb $t3, ($t1) # Load actual character at end pointer to register
        #Register - > Memory
        sb $t3, ($t0) # Store character in t0 register at start pointer [would be address w/o lb first]
        sb $t2, ($t1) # Store character in t1 register at end pointer
        #Step pointers
        addi $t0, $t0, 1 #source,destination,amount - increment first pointer by 1
        subi $t1, $t1, 1 #decrement first pointer by 1

        j reverse_loop #not done, call again (recursive)

    end_reverse:
        li $v0, 4
        syscall 
        jr $ra

factorial:
    move $t0, $a0 #first value, and accumulated factorial
    move $t1, $t0 #decrement counter

    loop:
        sub $t1, $t1, 1  #decrement counter
        beqz $t1, factorized #if at 0, stop. 
        mul $t0, $t0, $t1 #multiply counter by accumulated value
        j loop #loop, next number

    factorized:
        move $a0, $t0 #print statements
        li $v0, 1
        syscall 
        jr $ra

exit:
    #End Program
    li $v0, 10
    syscall