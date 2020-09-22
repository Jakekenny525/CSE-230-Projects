###########################################################
# Assignment #: 2
#  Name: Jake Kenny
#  ASU email: Jakenny@asu.edu
#  Course: CSE/EEE230, T/Th 12 - 1:15
#  Description: This program dipslays num1 and num2, their sum, and their difference
###########################################################

.data
num1: .word 91543
num2: .word 0xD8C

sum: .word 0                #Random placeholder value
diff: .word 0               #Random placeholder value

message1: .asciiz "num1 is: "
message2: .asciiz "num2 is: "
message3: .asciiz "num1 + num2 = "
message4: .asciiz "num1 - num2 = "

newline: .asciiz "\n"

.text
.globl main

main: 

    #print "num1 is: 91543\n"
    la $a0, message1        
    li $v0, 4
    syscall
    la $a0, num1
    li $v0, 1
    lw $a0, ($a0)
    syscall 
    la $a0, newline
    li $v0, 4
    syscall 

    #print "num2 is: 3468\n"
    la $a0, message2
    li $v0, 4
    syscall
    la $a0, num2
    li $v0, 1
    lw $a0, ($a0)
    syscall 
    la $a0, newline
    li $v0, 4
    syscall

    lw $t0, num1
    lw $t1, num2
    add $t2, $t1, $t0       #$t2 = num1 + num2
    sw $t2, sum             #sum = $t2

    #print "num1 + num2 = 95011\n"
    la $a0, message3
    li $v0, 4
    syscall
    la $a0, sum
    li $v0, 1
    lw $a0, ($a0)
    syscall 
    la $a0, newline
    li $v0, 4
    syscall 
    

    sub $t2, $t0, $t1       #$t2 = num1 - num2
    sw $t2, diff            #diff = $t2

    #print "num1 - num2 = 88075"
    la $a0, message4
    li $v0, 4
    syscall
    la $a0, diff
    li $v0, 1
    lw $a0, ($a0)
    syscall 

    jr $ra