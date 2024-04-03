.data 
    result_msg: .asciiz "The result is: "
.text
    .globl main

main:
    li $a0, 5
    li $a1, 7
    jal addf

    move $t0, $v0

    la $a0, result_msg
    li $v0, 4
    syscall

    li $v0, 10
    syscall

addf:
    add $v0,$a0,$a1
    jr $ra