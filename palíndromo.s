	.data
ms:		.asciiz " "
tamanho:	.asciiz "Insira o numero de letras da palavra: "
palavra:	.asciiz "Insira a palavra: "
true_msg: .asciiz "The string is a palindrome!"
false_msg: .asciiz "The string is not a palindrome!"
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
	move $a3, $v0              # armazena o tamanho em $a3 

##################################################################################
 ########### IMPRIME PEDINDO A PALAVRA E GUARDA ESSE VALOR################
##################################################################################
	addi $v0, $zero, 4         # sys call para imprimir
	la $a0, palavra            # guarda em $a0 o endereço de "Insira a palavra"
	syscall                    # imprime

	addi $v0, $zero, 8         # sys call para ler string
	la $a0, vetor              # carrega o endereço base de vetor para armazenar a string
	li $a1, 100                # tamanho máximo da string
	syscall                    # lê a string

	# Inicializa os índices para comparação
	addi $t0, $zero, 0         # índice da esquerda (i)
	add $t1, $zero, $a3        # índice da direita = tamanho
	addi $t1, $t1, -1          # ajusta para (tamanho - 1)

##########################################################################################
################################# WHILE ##################################################
##########################################################################################
WHILE:
	bge $t0, $t1, FIM_WHILE     # Se i >= j, fim do loop (é palíndromo)

	# Carrega o caractere de vetor[i] (esquerda)
	la $a0, vetor               # garante o endereço base de vetor
	add $t2, $a0, $t0           # Endereço de vetor[i]
	lb $t2, 0($t2)              # Carrega o caractere em $t2

	# Carrega o caractere de vetor[j] (direita)
	la $a0, vetor               # garante o endereço base de vetor
	add $t3, $a0, $t1           # Endereço de vetor[j]
	lb $t3, 0($t3)              # Carrega o caractere em $t3

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
