
###########################################################
# Assignment #: 1
#  Name: Jake Kenny
#  ASU email: Jakenny@asu.edu
#  Course: CSE/EEE230, T/Th 12 - 1:15
#  Description: This is my first assembly language program.
#                         It prints "Hello world", "Goodbye World", 
#                         and "This is my first MIPS program"
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
                            .data  
message1:         .asciiz "Hello World.\n" #create a string containing "Hello world.\n"
message2:	  .asciiz "Goodbye World.\n" #create a string containing "Goodbye World.\n"
message3:	  .asciiz "This is my first MIPS program.\n" #create a string containing "This is my first MIPS program.\n"

#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

# the program begins execution at main()
main:
            la          $a0, message1      # $a0 = address of message1
            li           $v0, 4            # $v0 = 4  --- this is to call print_string()
            syscall                        # call print_string()
	        la		$t0, message2          # $t0 = address of message2
	        move	$a0, $t0               # overwrites message1 in $a0
	        li		$v0, 4
	        syscall
	        la		$t0, message3          # overwrites message2 in $t0
	        move 	$a0, $t0               # overwrites message2 in $a0
	        li		$v0, 4
	        syscall
            jr          $ra                # return
