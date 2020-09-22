###########################################################
# Assignment #: 4
#  Name: Jake Kenny
#  ASU email: Jakenny@asu.edu
#  Course: CSE/EEE230, T/Th 12 - 1:15
#  Description: This program computes a customer's electricity bill by subtracting their current meter reading from last month's reading
###########################################################

.data

newMeter: .word -1 #Placeholder values
oldMeter: .word -1
month: .word -1
bill: .word 0
KWH_total: .word -1

lowUsageLimit: .word 250 #The maximum KWH a customer can have before their bill exceeds $25
summerLow: .word 6       #The start of the summer (June)
summerHigh: .word 9      #The end of the summer (September)
summerDivisor: .word 18  #The number used to calculate the bill during the summer 
regularDivisor: .word 20 #The number used to calculate the bill during the rest of the year

getCurrentMeter: .asciiz "Please enter the new electricity meter reading:\n"
getPreviousMeter: .asciiz "Please enter the old electricity meter reading:\n"
getMonth: .asciiz "Please enter a month to compute the electricity bill,\nuse an integer between 1 and 12 (1 for January, etc):\n"
noCharge: .asciiz "No bill to pay this month.\n"
billIntro: .asciiz "Your total bill for this month: "
billMid: .asciiz " dollars for "
KWH: .asciiz " KWH.\n"


.text
.globl main

main: 
    #Get the current meter reading
    li $v0, 4
    la $a0, getCurrentMeter
    syscall 
    li $v0, 5
    syscall 
    move $s0, $v0 

    #Get the previous month's reading
    li $v0, 4
    la $a0, getPreviousMeter
    syscall 
    li $v0, 5
    syscall 
    move $s1, $v0

    #Get the month
    li $v0, 4
    la $a0, getMonth
    syscall 
    li $v0, 5
    syscall 
    move $s2, $v0 

    #Calculate KWH usage this month and assign it a variable 
    sub $t0, $s0, $s1
    sw $t0, KWH_total 

    #Set remaining variables to registers
    lw $t1, bill            #$t1 = 0
    lw $t2, lowUsageLimit   #$t2 = 250
    lw $t3, summerLow       #$t3 = 6
    lw $t4, summerHigh      #$t4 = 9
    lw $t5, summerDivisor   #$t5 = 18
    lw $t6, regularDivisor  #$t6 = 20

    #Calculate charge based on KWH or month 
    beq $t0, $zero, IfZero
    ble $t0, $t2, LowUsage
    bge $s2, $t3, SummerCharge 

#Calculates payment for every season except summer and KWH is greater than 250 (bill = (KWH - 250)/20 + 25) 
RegularPrice: 
    sub $t1, $t0, $t2 #KWH - 250
    div $t1, $t6      #(KWH - 250) / 20
    mflo $t1 
    addi $t1, $t1, 25 #(KWH - 250) / 20 + 25
    sw $t1, bill 
    j Exit 
    
#Calculates payment if KWH is 0 and prints out "No bill to pay this month.\n"
IfZero: 
    li $v0, 4
    la $a0, noCharge
    syscall 
    jr $ra

#Calculates payment if KWH is between 0 and 250 
LowUsage: 
    addi $t1, $t1, 25
    sw $t1, bill #bill = $25
    j Exit 
 
#Calculates payment if it's summer (bill = (KWH - 250)/18 + 25)
SummerCharge: 
    bgt $s2, $t4, RegularPrice
    sub $t1, $t0, $t2 
    div $t1, $t5 
    mflo $t1 
    addi $t1, $t1, 25
    sw $t1, bill 
    j Exit 

#Prints out message stating the bill and KWH
Exit: 
    li $v0, 4
    la $a0, billIntro
    syscall 
    li $v0, 1
    la $a0, bill 
    lw $a0, 0($a0)
    syscall 
    li $v0, 4
    la $a0, billMid
    syscall 
    li $v0, 1
    la $a0, KWH_total 
    lw $a0, 0($a0) 
    syscall 
    li $v0, 4
    la $a0, KWH
    syscall 
    jr $ra 