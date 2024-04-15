.data 
    somestring: .asciiz "fancywordsmith"
    matrix1: .word 7, 2   
             .word 3, 5
    matrix2: .word 1, 3   
             .word 2, 1
    result:  .space 16    # Space for the result (2x2 matrix)
.text
    .globl main

main:
    # la $a0, somestring 
    # jal reverse_string

    # li $a0, 6 #factorial number
    # jal factorial

    # li $a0, 2 #matrix size
    # la $a1, matrix2
    # jal print_matrix

    li $a0, 2
    jal matrix_mult

    
j exit
matrix_mult:
    la $t0, matrix1
    la $t1, matrix2
    la $t2, result
    move $t3, $a0 #matrix size
    li $t4, 0 #row
    li $t5, 0 #col

    j matrix_inner_loop

    matrix_outer_loop:
        addi $t4, $t4, 1 #source, destination, amount -- increment outer loop
        beq $t4, $t3, matrix_end #end when outer hits 2
        li $t5, 0 #reset inner loop

    matrix_inner_loop:
        #Run loop code here
        
        #-=-=-
        addi $t5, $t5, 1
        beq $t5, $t3, matrix_outer_loop #inner hits 2, increment outer
        
        j matrix_inner_loop

    matrix_end:
        jr $ra

print_matrix:
    move $t8, $ra #;p
    move $t1, $a0 #stored matrix size
    li $t2, 0 #row
    li $t3, 0 #col
    move $t0, $a1 #address of matrix to t0

    j pm_inner_loop

    pm_outer_loop:
        addi $t2, $t2, 1 #source, destination, amount -- increment outer loop
        beq $t2, $t1, pm_end #end when outer hits 2
        li $t3, 0 #reset inner loop

    pm_inner_loop:
        #Run loop code here

        jal pw
        
        #-=-=-
        addi $t3, $t3, 1
        beq $t3, $t1, pm_outer_loop #inner hits 2, increment outer
        
        j pm_inner_loop
    
    pw:
        move $t7, $ra
        #making copies
        move $t4, $t2
        move $t5, $t3
        sll $t4, $t4, 3 #shift left by 3 bits, aka mult by 8
        sll $t5, $t5, 2 #shift left by 2 bits, aka mult by 4

        add $t4, $t4, $t5 #combine row.col values, stored in t4
        add $t4, $t4, $t0 #add offset to the matrix mem addr
        li $v0, 1

        lw $a0, ($t4)
        syscall

        li $v0, 11 #print character
        li $a0, 44 #comma
        syscall
        
        subi $t6, $t1, 1
        beq $t3, $t6, newline

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