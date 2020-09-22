###########################################################
# Assignment #: 3
#  Name: Jake Kenny
#  ASU email: Jakenny@asu.edu
#  Course: CSE/EEE230, T/Th 12 - 1:15
#  Description: This program takes 4 integers as inputs and performs various mathematical operations with them
###########################################################

.data
num1: .word 0 #placeholder value
num2: .word 0
num3: .word 0
num4: .word 0

ans1: .word 0 #placeholder value
ans2: .word 0
ans3: .word 0
ans4: .word 0
ans5: .word 0
ans6: .word 0

message1: .asciiz "Enter a value: "
message2: .asciiz "num4 + num1 = "
message3: .asciiz "num1 - num2 = "
message4: .asciiz "num4 * num2 = "
message5: .asciiz "num1 / num3 = "
message6: .asciiz "num3 % num1 = "
message7: .asciiz "((((num2 % 4) + num3) * 2) / num4) + num1 = "

newline: .asciiz "\n"

.text
.globl main

main: 

    #Ask user to input values and store values in temporary registers $t0 - $t3
    li $v0, 4
    la $a0, message1
    syscall
    li $v0, 4
    la $a0, newline 
    syscall
    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la $a0, message1
    syscall
    li $v0, 4
    la $a0, newline 
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 4
    la $a0, message1
    syscall
    li $v0, 4
    la $a0, newline 
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    li $v0, 4
    la $a0, message1
    syscall
    li $v0, 4
    la $a0, newline 
    syscall
    li $v0, 5
    syscall
    move $t3, $v0

    #Assign variables to temporary registers
    sw $t0, num1
    sw $t1, num2
    sw $t2, num3 
    sw $t3, num4 

    #Calculate and display sum of num4 and num1
    add $t4, $t3, $t0 
    sw $t4, ans1 
    li $v0, 4
    la $a0, message2 
    syscall 
    li $v0, 1
    la $a0, ans1
    lw $a0, ($a0)
    syscall 
    li $v0, 4
    la $a0, newline
    syscall

    #Calculate and display difference of num1 and num2
    sub $t4, $t0, $t1 
    sw $t4, ans2 
    li $v0, 4
    la $a0, message3 
    syscall 
    li $v0, 1
    la $a0, ans2
    lw $a0, ($a0)
    syscall 
    li $v0, 4
    la $a0, newline
    syscall

    #Calculate and display product of num4 and num2
    mult $t3, $t1 
    mflo $t4 
    sw $t4, ans3 
    li $v0, 4
    la $a0, message4 
    syscall 
    li $v0, 1
    la $a0, ans3
    lw $a0, ($a0)
    syscall 
    li $v0, 4
    la $a0, newline
    syscall

    #Calculate and display quotient of num1 and num3
    div $t0, $t2
    mflo $t4
    sw $t4, ans4 
    li $v0, 4
    la $a0, message5 
    syscall 
    li $v0, 1
    la $a0, ans4
    lw $a0, ($a0)
    syscall 
    li $v0, 4
    la $a0, newline
    syscall

    #Calculate and display remainder of num3 and num1
    div $t2, $t0 
    mfhi $t4 
    sw $t4, ans5 
    li $v0, 4
    la $a0, message6 
    syscall 
    li $v0, 1
    la $a0, ans5
    lw $a0, ($a0)
    syscall 
    li $v0, 4
    la $a0, newline
    syscall

    #Calculate and display ((((num2 % 4) + num3) * 2) / num4) + num1
    #$t5 = num2 % 4
    addi $t6, $zero, 4 
    div $t1, $t6
    mfhi $t5 

    #$t5 = (num2 % 4) + num3
    add $t5, $t5, $t2 

    #$t5 = ((num2 %4) + num3) * 2
    addi $t7, $zero, 2 
    mult $t5, $t7 
    mflo $t5 

    #$t5 = (((num2 % 4) + num3) * 2) / num4
    div $t5, $t3 
    mflo $t5 

    #$t5 = ((((num2 % 4) + num3) * 2) / num4) + num1
    add $t5, $t5, $t0 

    #Store answer from $t5 in a variable to be displayed
    sw $t5, ans6 

    li $v0, 4
    la $a0, message7 
    syscall 
    li $v0, 1
    la $a0, ans6
    lw $a0, ($a0)
    syscall 

    jr $ra