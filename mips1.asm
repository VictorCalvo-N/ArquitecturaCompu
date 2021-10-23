.text
.globl __start
__start:
        la $s0, lista
        lw $t4, size
reinicio:  
	li $t0, 0
        li $t5, 0
for:   
	add $s1, $s0, $t0 # sl = lista + 0
        lw $s3, ($s1) 
        addi $t1, $t0, 4 # siguiente elemento de la memoria
        add $s2, $s0, $t1 # $s2 = lista + $t1
        lw $s4, ($s2)
        bgt $s4, $s3, swap # Un branch si $s4 > $s3, 
siguiente:   
	addi $t5, $t5, 1 # $t5 ++
        addi $t0, $t0, 4 
        beqz $t4, exit # Evalua si $t4 es 0
        beq $t5, $t4, nummenos # si $t5 == $t4 va a num
        j for
nummenos: 
	subi $t4, $t4, 1 #$t4 -1
        j reinicio
swap:   
	sw $s3, ($s2) # $s3 = $s2
        sw $s4, ($s1) # $s4 = $s1
        j siguiente
exit:   
	li $t0, 0
        li $t1, 0
segundofor:  
	li $v0, 1
        add $t2, $s0, $t1 # $t2 = $s0 + $t1
        lw $a0, ($t2)
        syscall
        li $v0, 4
        la $a0, espacio
        syscall
        addi $t0, $t0, 1 # $t0 ++
        addi $t1, $t1, 4 # siguiente elemento de la memoria
        beq $t0, 10, final
        j segundofor
final:   
	li $v0, 4
        la $a0, end
        syscall
.data
	lista: .word 35, 15, 9, 1, 25, 7, 2, 95, 24, 65
	size: .word 10
	espacio: .asciiz " "
end: .asciiz "The end."