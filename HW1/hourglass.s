.data
msg1:	.asciiz "Enter the number n = "


.text
.globl main
#------------------------- main -----------------------------
main:
    		la 	$a0, msg1    			# prompt
    		li 	$v0, 4
   		syscall
    		
    		li 	$v0, 5				# input n
    		syscall
		
		move	$s0, $v0			# move n to $s0
		addi	$t0, $s0, 1
		addi	$t1, $zero, 2
		div	$t0, $t1
		mflo	$s1				# temp = (n + 1) / 2
		mfhi	$t0				# (n + 1) % 2
		
		beq	$t0, $zero, temp_minus
FO_init:		 	 	
    		addi	$s2, $zero, 0			# int i = 0
FO_loop:
    		slt	$t0, $s2, $s1			# if i >= temp
    		beq	$t0, $zero, SO_init		# goto next loop
    		
    		addi	$s3, $zero, 0			# int j = 0
FO_space_loop:	
		sgt	$t0, $s3, $s2			# if j > i
    		bne	$t0, $zero, FO_star_init	# goto next loop
		
		li 	$a0, 32				# print " "
		li 	$v0, 11
    		syscall
    		
		addi	$s3, $s3, 1			# j++
		j	FO_space_loop			# loop
		
FO_star_init:
    		addi	$s3, $zero, 0			# int j = 0
FO_star_loop:
		add	$t0, $s2, $s2
		sub	$t1, $s0, $t0
		slt	$t0, $s3, $t1			# if j >= n - i*2
    		beq	$t0, $zero, FO_newline		# goto next loop
		
		li 	$a0, 42				# print "*"
		li 	$v0, 11
    		syscall
    		
		addi	$s3, $s3, 1			# j++
		j	FO_star_loop			# loop

temp_minus:
		addi	$s1, $s1, -1
		j	FO_init
FO_newline:
		li 	$a0, 10        			# print newline
    		li 	$v0, 11
    		syscall
    		
    		addi	$s2, $s2, 1			# i++
		j	FO_loop

SO_init:	
		addi	$t0, $s0, 1	
		addi	$t1, $zero, 2		
		div	$t0, $t1
		mflo	$t0
		addi	$s2, $t0, -1			# int i = (n + 1) / 2 - 1
SO_loop:
    		slt	$t0, $s2, $zero			# if i < 0
    		bne	$t0, $zero, Exit		# goto next loop
    		
    		addi	$s3, $zero, 0			# int j = 0
SO_space_loop:	
		sgt	$t0, $s3, $s2			# if j > i
    		bne	$t0, $zero, SO_star_init	# goto next loop
		
		li 	$a0, 32				# print " "
		li 	$v0, 11
    		syscall
    		
		addi	$s3, $s3, 1			# j++
		j	SO_space_loop			# loop
		
SO_star_init:
    		addi	$s3, $zero, 0			# int j = 0
SO_star_loop:
		add	$t0, $s2, $s2
		sub	$t1, $s0, $t0
		slt	$t0, $s3, $t1			# if j >= n - i*2
    		beq	$t0, $zero, SO_newline		# goto next loop
		
		li 	$a0, 42				# print "*"
		li 	$v0, 11
    		syscall
    		
		addi	$s3, $s3, 1			# j++
		j	SO_star_loop			# loop

SO_newline:
		li 	$a0, 10        			# print newline
    		li 	$v0, 11
    		syscall
    		
    		addi	$s2, $s2, -1			# i--
		j	SO_loop

Exit:
    		li 	$v0, 10
    		syscall