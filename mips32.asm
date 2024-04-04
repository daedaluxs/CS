.data 
    somestring: .asciiz "fancywordsmith"
.text
    .globl main

main:
    la $a0, somestring #load somestring for reverse_string

    jal reverse_string

    # move $a0, $v0

    li $v0, 4
    syscall 

    #End Program
    li $v0, 10
    syscall



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
        jr $ra