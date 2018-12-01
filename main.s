.data
 rez:.space 4
 n:.word 5
 k:.word 2

.text

main:
 lw $t0,k
 lw $t1,n
 subu $sp,$sp,4
 sw $t0,0($sp) #k
 subu $sp,$sp,4
 sw $t1,0($sp) #n
 jal combinari
 lw $t0,0($sp)
 addi $sp,$sp,4
 sw $t0,rez
 
 #print (rez)
 lw $a0,rez
 li $v0,1
 syscall

li $v0,10
syscall


combinari:
 subu $sp,$sp,8
 sw $ra,4($sp)
 sw $fp,0($sp)
 addi $fp,$sp,0
 
 lw $t0,8($fp) #n
 lw $t1,12($fp) #k
 beq $t0,$t1,return # C(n,n)
 beqz $t1,return # C(n,0)
 	subu $t0,$t0,1
 	subu $sp,$sp,8
 	sw $t0,0($sp)
 	sw $t1,4($sp)
 
 	jal combinari #C(n-1,k)
 
	lw $t0,8($fp) #n
	lw $t1,12($fp) #k
	lw $t2,-4($fp) #valoarea returnata
	sw $t2,12($fp)
	subu $t0,$t0,1
	subu $t1,$t1,1
	subu $sp,$sp,4
	sw $t0,0($sp)
	sw $t1,4($sp)
	
	jal combinari #C(n-1,k-1)
	 
	lw $t0,-4($fp) #valoarea returnata = C(n-1,k-1)
	lw $t1,12($fp) #valoarea returnata anterior = C(n-1,k)
	add $t1,$t1,$t0
	sw $t1,12($fp)
	lw $ra,4($fp)
	lw $fp,0($fp) #restaurarea lui fp
	addi $sp,$sp,16
	jr $ra

return:
 li $t0,1
 sw $t0,12($fp)
 lw $fp,0($fp) #restaurarea lui fp
 addi $sp,$sp,12
 jr $ra
