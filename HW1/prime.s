.data
msg1:	.asciiz "Enter the number n = "
msg2:	.asciiz " is a prime"
msg3:	.asciiz " is not a prime, the nearest prime is "

.text
.globl main
#------------------------- main -----------------------------
main:
		li      $v0, 4			# prompt
		la      $a0, msg1		
		syscall                 	
 
 		li      $v0, 5          	# read input num
  		syscall
  		     	
  		add    	$a0, $zero, $v0      	# store input num in $a0
  		add	$s0, $zero, $v0		# store num in $s0 for later use
  		add	$s2, $zero, $zero	# set flag = 0
  		
		jal	Is_prime		# prime test
		
		add	$t0, $zero, $v0		# is_prime in $t0
		
		add	$a0, $zero, $s0
		li	$v0, 1			# print num
		syscall

		beq	$t0, $zero, Not_prime	# is_prime == 0, not a prime
	
		li      $v0, 4			# print string " is a prime"
		la      $a0, msg2		
		syscall                 	

		j	Exit	

# input: $a0, num
# output: $v0, 1 if prime, 0 if not
Is_prime:
		slti	$t0, $a0, 2			# check if num == 1
		beq	$t0, $zero, Init
	
		add	$v0, $zero, $zero		# 1 is not a prime
		jr	$ra				# return 0

Init:
		addi	$t0, $zero, 2			# int i = 2
	
Test:
		mul	$t1, $t0, $t0				
		sgt	$t2, $t1, $a0			# if (i*i <= num) 
		beq	$t2, $zero, Loop		# loop
								
		addi	$v0, $zero, 1			# It's a prime
		jr	$ra				# return 1

Loop:							
		div	$a0, $t0			
		mfhi	$t3				# rem = (num % i)
		slti	$t4, $t3, 1				
		beq	$t4, $zero, Continue		# if (rem == 0)
		add	$v0, $zero, $zero		# its not a prime
		jr	$ra				# return 0

Continue:		
		addi 	$t0, $t0, 1			# i++
		j	Test				# continue 
# if not prime
Not_prime:
		li      $v0, 4				# call system call: print string
		la      $a0, msg3		
		syscall            
		     
NP_init:
		addi	$s1, $zero, 1			# int i = 1
		
NP_minus:
		sub	$a0, $s0, $s1			
		jal 	Is_prime
		
		slti	$t0, $v0, 1			# if (num - i) is prime 
		beq	$t0, $zero, NP_set_flag_minus	# goto set_flag_minus
		
NP_plus:		
		add	$a0, $s0, $s1
		jal 	Is_prime
		
		slti	$t0, $v0, 1			# if (num + i) is prime 
		beq	$t0, $zero, NP_set_flag_plus	# goto set_flag_plus
NP_flag:		
		slti	$t0, $s2, 1			# if (flag == 1)
		beq	$t0, $zero, Exit		# Exit
				
		addi 	$s1, $s1, 1			# i++
		j	NP_minus			# continue 
		
NP_set_flag_minus:
		sub	$a0, $s0, $s1			# print n - i
		li	$v0, 1				
		syscall
		
		li	$a0, 32				# print space
		li	$v0, 11
		syscall
		
		addi	$s2, $zero, 1			# flag = 1
		j	NP_plus
		
NP_set_flag_plus:
		add	$a0, $s0, $s1
		li	$v0, 1				# print n + i
		syscall
		
		addi	$s2, $zero, 1			# flag = 1
		j	NP_flag
Exit:
		li	$v0, 10			# exit the program
		syscall	
	
