###########################################################
# Assignment #: 7
#  Name: Jake Kenny
#  ASU email: Jakenny@asu.edu
#  Course: CSE/EEE230, T/Th 12 - 1:15
#  Description: Function1(n) = 5n + 14 when n <= 3, = Function1(n-1)/n + nFunction1(n-3) + 4n otherwise
###########################################################

#Assignments
#$a1: parameter of Function1
#$v1: return value 

.data
enterInt: .asciiz "Enter an integer:\n"
solutionText: .asciiz "The solution is: "
answer: .word 0 #Placeholder value

newline: .asciiz "\n"

.text
.globl main
main: 
    #Set $a0 via user input 
    li $v0, 4
    la $a0, enterInt 
    syscall 
    li $v0, 5
    syscall 
    move $a1, $v0 

    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal Function1 
    lw $ra, 0($sp)
    addi $sp, $sp, 4

    sw $v1, answer 

    #Prints "The solution is: [answer]"
    li $v0, 4
    la $a0, solutionText
    syscall 
    li $v0, 1
    la $a0, answer 
    lw $a0, 0($a0)
    syscall 

    jr $ra 

Function1: 
    
    sle $t0, $a1, 3
    beq $t0, $zero, Recursive 

    li $t9, 5

    mul $v1, $a1, 5
    addi $v1, $v1, 14 
    jr $ra 

Recursive:
    addi $sp, $sp, -12 
    sw $ra, 0($sp) 
    sw $a1, 4($sp) 

    #Function1(n - 1)
    sub $a1, $a1, 1 
    jal Function1 
    sw $v1, 8($sp) 
    lw $a1, 4($sp) 

    #Function1(n - 3)
    sub $a1, $a1, 3
    jal Function1 

    lw $ra, 0($sp) 
    lw $a1, 4($sp)
    lw $t1, 8($sp)

    #Function1(n - 1)/n
    div $t1, $a1 
    mflo $t1 

    #nFunction1(n - 3)
    mul $t2, $a1, $v1 

    #4n 
    li $t3, 4
    mult $t3, $a1 
    mflo $t3 

    add $s0, $t1, $t2
    add $s0, $s0, $t3 
    move $v1, $s0 

    lw $ra, 0($sp)
    lw $a1, 4($sp)
    addi $sp, $sp, 12
    jr $ra 