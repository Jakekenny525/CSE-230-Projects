###########################################################
# Assignment #: 6
#  Name: Jake Kenny
#  ASU email: Jakenny@asu.edu
#  Course: CSE/EEE230, T/Th 12 - 1:15
#  Description: readArray: takes an array of integers as its parameter, asks a user how many numbers will be entered, then reads in 
#                          integers from a user to fill the array. Returns the size of the array
#               printArray: takes an array of integers as its parameter and prints the array
#               changeArrayContent: takes parameters of arrays of integers,  an integer that specify how many integers were entered by a 
#                                   user, a maximum array size, and also asks a user to enter an integer. Then it goes through each
#                                   element of the array, and check if it is divisible by the entered integer, it multiplies it by the 
#                                   entered integer. Then it calls printArray to print out the changed content.
#               main: calls readArray function to populate the array, calls printArray to print out its original content, then it asks a 
#                     user to enter how many times the operation should be repeated, then calls changeArrayContent to change it content.
###########################################################

#Assignments: 
#$s0: The iterator (i) for all loops
#$a1, $a2: parameters for readArray (int arr[], int arraySize)
#$v0: return value for readArray (size of arr[])
#$a1, $a2, $a3: parameters for printArray (int arr[], int arraySize, int length)
#$a1, $a2, $a3: parameters for changeArrayContent (int arr[], int arraySize, int length)

.data
arr: .space 44 #Maximum size of arr is 11 numbers (44 bytes)

length: .word 0

askHowManyNumbersToEnter: .asciiz "Specify how many numbers should be stored in the array (at most 11):\n"
enterInt: .asciiz "Enter an integer:\n"
newline: .asciiz "\n"

.text
.globl main 
main: 
    addi $sp, $sp, -16
    #Set parameters
    la $a1, arr 
    li $v0, 4
    la $a0, askHowManyNumbersToEnter
    syscall 
    li $v0, 5
    syscall 
    move $a2, $v0

    #Set global variable length equal to the size of the array 
    sw $a2, length 

    sw $a1, 0($sp)
    sw $a2, 4($sp)
    sw $ra, 8($sp)
    jal readArray 
    lw $ra, 8($sp)
    lw $a2, 4($sp)
    lw $a1, 0($sp)

    #Set parameters
    la $a1, arr
    la $a2, length 
    lw $a2, 0($a2)
    li $a3, 11

    sw $a1, 0($sp)
    sw $a2, 4($sp)
    sw $a3, 8($sp)
    sw $ra, 12($sp)
    jal printArray
    lw $ra, 12($sp)
    lw $a3, 8($sp)
    lw $a2, 4($sp)
    lw $a1, 0($sp)

    #Set parameters
    la $a1, arr
    la $a2, length 
    lw $a2, 0($a2)
    li $a3, 11 

    sw $a1, 0($sp)
    sw $a2, 4($sp)
    sw $a3, 8($sp)
    sw $ra, 12($sp)
    jal changeArrayContent
    lw $ra, 12($sp)
    lw $a3, 8($sp)
    lw $a2, 4($sp)
    lw $a1, 0($sp)
    addi $sp, $sp, 16

    jr $ra

readArray: 
    #Asks the user to input numbers until they've filled the array to that specified number
    li $s0, 0               #i = 0
    fillArray:
        slt $t0, $s0, $a2   #$t0 = 1 if $s0 < $a2 (i < arrLength); $t0 = 0 otherwise
        beq $t0, $zero, exit 
        sll $t1, $s0, 2
        add $t2, $t1, $a1   #$t2 = base address of arr + (i * 4)
        li $v0, 4
        la $a0, enterInt 
        syscall 
        li $v0, 5
        syscall 
        sw $v0, 0($t2)      #arr[i] = $v0
        addi $s0, $s0, 1    #i++
        j fillArray

printArray:
    li $s0, 0               #i = 0
    printLoop: 
        slt $t0, $s0, $a2   #$t0 = 1 if $s0 < $a2 (i < length); $t0 = 0 otherwise
        slt $t1, $s0, $a3   #$t1 = 1 if $s0 < $a3 (i < max size of array); $t1 = 0 otherwise
        beq $t0, $zero, exit 
        beq $t1, $zero, exit 
        sll $t2, $s0, 2
        add $t3, $t2, $a1
        lw $t4, 0($t3)      #$t4 = arr[i]
        li $v0, 1
        move $a0, $t4
        syscall             #Prints out arr[i]
        li $v0, 4
        la $a0, newline 
        syscall             #Prints out "\n"
        addi $s0, $s0, 1    #i++
        j printLoop
        

changeArrayContent:
    li $s0, 0
    li $v0, 4
    la $a0, enterInt
    syscall 
    li $v0, 5
    syscall 
    move $s1, $v0 
    li $v0, 4 
    la $a0, newline 
    syscall 
    changeArrayLoop: 
        slt $t0, $s0, $a2 
        slt $t1, $s0, $a3 
        beq $t0, $zero, printArray 
        beq $t1, $zero, printArray 
        sll $t2, $s0, 2
        add $t3, $t2, $a1 
        lw $t4, 0($t3)                  #$t4 = arr[i] 
        div $t4, $s1 
        mfhi $t5 
        addi $s0, $s0, 1 
        bne $t5, $zero, changeArrayLoop #Multiplies $t4 by $s1 if $t4 % $s1 = 0; starts the loop with the next element of arr otherwise
        mult $t4, $s1 
        mflo $t5 
        sw $t5, 0($t3)                  #arr[i] = $t5
        j changeArrayLoop
    
    
exit:
    li $v0, 4
    la $a0, newline 
    syscall 
    jr $ra