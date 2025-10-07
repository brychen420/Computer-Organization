.data
msg1:	.asciiz "Enter first number: "
msg2:	.asciiz "Enter second number: "
msg3:	.asciiz "The GCD is: "


.text
.globl main
#------------------------- main -----------------------------
main:
		li      $v0, 4			# prompt 1
		la      $a0, msg1		
		syscall                 	
 
 		li      $v0, 5          	# read input 1 and store it into $a1
  		syscall                 	
  		move    $a1, $v0      		
  		
		li      $v0, 4			# prompt 2 	
		la      $a0, msg2		
		syscall                 	
		
		li      $v0, 5          	# read input 2 and store it into $a0
  		syscall                 	
  		move    $a0, $v0      		

  		jal GCD				# jump to  gcd

		move 	$t0, $v0		# save return value in t0 

		li      $v0, 4			# print "The GCD is: "
		la      $a0, msg3		
		syscall                 	
 
		move 	$a0, $t0		# print the result
		li 	$v0, 1			
		syscall 			
   
		li 	$v0, 10			# exit
  		syscall				

#------------------------- procedure gcd -----------------------------
# load argument a, b in a0 and a1, return value in v0. 
.text
GCD:
		addi 	$sp, $sp, -12		# make space for 3 on stack
    		sw 	$ra, 0($sp) 		
    		sw 	$s0, 4($sp) 		# save into stack
    		sw 	$s1, 8($sp) 		

    		move 	$s0, $a0 		# $s0 = a
    		move 	$s1, $a1 		# $s1 = b 

    		beq 	$s1, $zero, Return	# if b == 0, return

		move 	$a0, $s1 		# make $a0 = b
    		div 	$s0, $s1 		
    		mfhi 	$a1 			# a % b

    		jal 	GCD			# GCD(b, a % b)

Exit:
    		lw 	$ra, 0($sp)  		# read registers from stack
    		lw 	$s0, 4($sp)
    		lw 	$s1, 8($sp)
    		addi 	$sp, $sp , 12 		# bring back stack pointer
    		jr 	$ra
Return:
    		add 	$v0, $zero, $s0 	# return b
    		j 	Exit
