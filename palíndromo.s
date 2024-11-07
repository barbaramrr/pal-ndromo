## CÓDIGO ASSEMBLY PARA MIPS 32 
### Palíndromo

	.data
ms:		.asciiz " "
tamanho:	.asciiz "Insira o numero de letras da palavra:  "
palavra:	.asciiz "Insira a palavra: "
true_msg: .asciiz " The string is a palindrome!"
false_msg: .asciiz " The string is not a palindrome!"
vetor:   .space 100                                  

	.text
 main:


###################################################################################
 ########### IMPRIME PEDINDO O NUMERO DE LETRAS E GUARDA ESSE VALOR################
 ##################################################################################
	addi $v0, $zero, 4 	# sys call
	la $a0, tamanho	                # guarda em $a0 oq precisa ser impresso
	syscall		                      # Print "Insira o numero de letras""
	
	addi $v0,$zero, 5               # ler numero inteiro
  syscall		 #
  add $a3, $zero, $v0             # a3 = tamanho 	
    	
 ##################################################################################
 ########### IMPRIME PEDINDO O NUMERO DE LETRAS E GUARDA ESSE VALOR################
 ##################################################################################
 
	addi $v0, $zero, 4          	  # sys call
	la $a0, palavra                 # guarda em $a0 oq precisa ser impresso
	syscall	                      	# Print "Insira a palavra""
 
	addi $v0,$zero , 8	            # ler o valor inserido
  la $a0, vetor
  li $a1, 100                    # Tamanho máximo da string
  syscall		
  
 addi $t0,$zero,0                #usado para ler a palavra da esquerda para direita  (i)
 addi $t1, $a3, -1                 #usado para ler a palavra da direita para a esquerda  (j)
 
##########################################################################################
################################# WHILE ##################################################
##########################################################################################
WHILE:
 bge $t0,$t1, FIM_WHILE
    lb $t2, 0($a0)                 # Carrega caractere da esquerda (vetor[i])
    lb $t3, 0($t1)                 # Carrega caractere da direita (vetor[j])
    bne $t2,$t3, FALSO
    addi $t0,$t0,1                  #incrementa i
    addi $t1, $t1, -1                 # Decrementa j
    j WHILE
    
 ##########################################################################################
################################# FIM WHILE ###############################################
##########################################################################################

 FIM_WHILE:
 	addi $v0, $zero, 4          	  # sys call
	la $a0, true_msg                 # guarda em $a0 oq precisa ser impresso
	syscall	                      	# Print "Insira a palavra""
 j end

     
 ##########################################################################################
#################################   FALSO     ############################################
##########################################################################################
 
FALSO:
 	addi $v0, $zero, 4          	  # sys call
	la $a0, false_msg                 # guarda em $a0 oq precisa ser impresso
	syscall	
  j end

  end:
    li $v0, 10                     # Syscall para encerrar o programa
    syscall
    	
