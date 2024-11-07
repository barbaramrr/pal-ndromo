	.data
ms:		.asciiz " "
tamanho:	.asciiz "Insira o numero de letras da palavra: "
palavra:	.asciiz "Insira a palavra: "
true_msg: .asciiz " The string is a palindrome!"
false_msg: .asciiz " The string is not a palindrome!"
vetor:   .space 100                                   # espaço para a string

	.text
 main:

###################################################################################
 ########### IMPRIME PEDINDO O NUMERO DE LETRAS E GUARDA ESSE VALOR################
##################################################################################
	addi $v0, $zero, 4         # sys call para imprimir
	la $a0, tamanho            # guarda em $a0 o endereço de "Insira o numero de letras"
	syscall                    # imprime

	addi $v0,$zero, 5          # sys call para ler inteiro
	syscall                    # lê o número de letras
	add $a3, $zero, $v0        # a3 = tamanho 

##################################################################################
 ########### IMPRIME PEDINDO A PALAVRA E GUARDA ESSE VALOR################
##################################################################################
	addi $v0, $zero, 4         # sys call para imprimir
	la $a0, palavra            # guarda em $a0 o endereço de "Insira a palavra"
	syscall                    # imprime

	addi $v0,$zero , 8         # sys call para ler string
	la $a0, vetor              # carrega o endereço de vetor
	li $a1, 100                # tamanho máximo da string
	syscall                    # lê a string

	addi $t0, $zero, 0         # índice da esquerda (i)
	addi $t1, $a3, -1          # índice da direita (j) = tamanho - 1

##########################################################################################
################################# WHILE ##################################################
##########################################################################################
WHILE:
	bge $t0, $t1, FIM_WHILE     # Se i >= j, fim do loop (palíndromo)

	lb $t2, 0($a0)              # Carrega caractere de vetor[i]
	lb $t3, 0($a0)              # Carrega caractere de vetor[j]
	add $t2, $t2, $t0           # Carrega vetor[i]
	add $t3, $t3, $t1           # Carrega vetor[j]

	bne $t2, $t3, FALSO         # Se os caracteres não forem iguais, não é palíndromo

	addi $t0, $t0, 1            # Incrementa i
	addi $t1, $t1, -1           # Decrementa j
	j WHILE

##########################################################################################
################################# FIM WHILE ###############################################
##########################################################################################
FIM_WHILE:
	addi $v0, $zero, 4          # sys call para imprimir
	la $a0, true_msg            # mensagem: "A palavra é palíndromo"
	syscall                     # imprime
	j end

##########################################################################################
################################# FALSO ##################################################
##########################################################################################
FALSO:
	addi $v0, $zero, 4          # sys call para imprimir
	la $a0, false_msg           # mensagem: "A palavra não é palíndromo"
	syscall                     # imprime
	j end

end:
	li $v0, 10                  # sys call para encerrar o programa
	syscall
