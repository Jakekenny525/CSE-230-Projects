###########################################################
# Assignment #: 5
#  Name: Jake Kenny
#  ASU email: Jakenny@asu.edu
#  Course: CSE/EEE230, T/Th 12 - 1:15
#  Description: This program asks a user to enter three integers: an ending index and two comparison integers. Then, the program parses
#               an array from [0] to [ending index] and checks for all values between the two comparison integers. Any of these values
#               will be changed according to the formula num[i] = num[i] * lower_limit + upper_limit
###########################################################

.data

arr_len: .word 11                                      #The length of the array
arr: .word 2, 19, 23, -7, 15, -17, 11, -4, 23, -26, 27 #The original array
endingIndex: .word -1                                  #Ending index, initialized with a placeholder value
lower_limit: .word -1                                  #Lower comparison limit, initialized with a placeholder value
upper_limit: .word -1                                  #Upper comparison limit, initialized with a placeholder value

getEndingIndex: .asciiz "Enter an ending index:\n" 
getInteger: .asciiz "Enter an integer:\n"

showResult: .asciiz "Result Array Content:\n"
newline: .asciiz "\n"

.text
.globl main
main:
    #Set base address of arr
    la $s0, arr 

    #Get ending index and assign it to a register
    li $v0, 4
    la $a0, getEndingIndex
    syscall 
    li $v0, 5
    syscall 
    move $s1 $v0 

    #Get lower and upper limits, regardless of order, and assign them to $s2 and $s3
    li $v0, 4
    la $a0, getInteger
    syscall 
    li $v0, 5
    syscall 
    move $s2, $v0 
    li $v0, 4
    la $a0, getInteger
    syscall 
    li $v0, 5
    syscall 
    move $s3, $v0 

    bgt $s2, $s3, Swap #If lower_limit > upper_limit, swap their values
    j Set_Variables

    #Set lower limit to $s2 and upper limit to $s3
    Swap: 
        add $t0, $s2, $zero #$t0 = upper_limit
        move $s2, $s3       #$s2 = lower_limit
        move $s3, $t0       #$s3 = $t0

    #Sets all variables to their corresponding registers and vice versa 
    Set_Variables:
        sw $s1, endingIndex
        sw $s2, lower_limit
        sw $s3, upper_limit
        lw $s4, arr_len 

    #Iterates through the array and performs the necessary operations if lower_limit < arr[i] < upper_limit
    li $s5, 0                   #i = 0
    Loop:
        slt $t0, $s5, $s1 
        beq $t0, $zero, Exit 
        sll $t1, $s5, 2
        add $t2, $t1, $s0
        lw $t3, 0($t2)          #$t3 = arr[i]
        InRange:
            addi $s5, $s5, 1
            ble $t3, $s2, Loop 
            bge $t3, $s3, Loop 
            mult $t3, $s2
            mflo $t4            #$t4 = arr[i] * lower_limit
            add $t4, $t4, $s3   #$t4 = (arr[i] * lower_limit) + upper_limit
            sw $t4, 0($t2)      #arr[i] = $t4
        j Loop 
    
    #Prints the new array and exits the program
    Exit:
        li $v0, 4
        la $a0, showResult
        syscall 
        li $s6, 0               #i = 0
        PrintLoop:
            slt $t0, $s6, $s4 
            beq $t0, $zero, Terminate 
            sll $t1, $s6, 2
            add $t2, $t1, $s0
            lw $t3, 0($t2)      #$t3 = arr[i]
            li $v0, 1
            move $a0, $t3
            syscall 
            li $v0, 4
            la $a0, newline 
            syscall  
            addi $s6, $s6, 1    #i++
            j PrintLoop 

        Terminate:
            jr $ra  

