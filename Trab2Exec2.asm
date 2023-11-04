inicio:
    ; Vetor 1
    ldi r0, endereco_vetor1   ; Endereço do vetor
    ldi r1, tamanho_vetor1    ; Tamanho do vetor
    call print_vetor          ; Imprime vetor antes da ordenação
    call insertion_sort       ; Chama a função de ordenação
    call print_vetor          ; Imprime vetor após ordenação

    ; Vetor 2 e 3 - Seriam repetições semelhantes ao que foi feito para o vetor 1
    ; Finaliza programa
insertion_sort:
    ldi r2, 1                 ; Inicializa i = 1
loop_i:
    blt r2, r1, fim_i         ; Se i >= size, termina loop

    ld r3, [r0 + r2]          ; aux = vec[i]
    ldi r4, r2                ; j = i
loop_j:
    ldi r5, 0                 ; Se j <= 0, termina loop
    ble r4, r5, fim_j

    ld r6, [r0 + r4 - 1]      ; vec[j-1]
    blt r3, r6, fim_j         ; Se vec[j-1] <= aux, termina loop

    st [r0 + r4], r6          ; vec[j] = vec[j-1]
    sub r4, r4, 1             ; j--
    bnz r4, loop_j            ; Loop de j
fim_j:
    st [r0 + r4], r3          ; vec[j] = aux

    add r2, r2, 1             ; i++
    bnz r2, loop_i            ; Loop de i
fim_i:
    ret                       ; Retorna da função

print_vetor:
    ; Imprime o vetor no terminal
    ldi r9, 0                 ; Inicializa índice
loop_print:
    blt r9, r1, end_print     ; Se índice é maior que tamanho, termina

    ld r10, [r0 + r9]         ; Carrega valor do vetor
    stw r10, 0xf002           ; Imprime no terminal

    add r9, r9, 1             ; Incrementa índice
    bnz r9, loop_print        ; Repete

end_print:
    ret

endereco_vetor1: .word valores_vetor1
tamanho_vetor1:  .word 5
valores_vetor1:  .word 5, 1, 3, 4, 2












main
    ldi r0, set_vet         ; endereço temporário das strings
	ldi r1, vet_control     ; r1 = 0
    ldi r3, 0               ; pointer: dentro do array
	ldi lr, loop_vet


insertion_sort:
    ldi x, 1                 ; Inicializa i = 1
loop_i:
    ;vet_size
    blt x, vet_size, fim_i         ; Se i >= size, termina loop

    ldi y, [r2 + x]          ; aux = vec[i]
    ldi r0, x                ; j = i
    bnz sp, loop_j
loop_j:
    ;loop_sort
    ldi z, 0                 ; Se j <= 0, termina loop
    ble r0, z, fim_j

    ldi r6, [r2 + r0 - 1]      ; vec[j-1]
    blt y, r6, fim_j         ; Se vec[j-1] <= aux, termina loop

    st [r2 + r0], r6          ; vec[j] = vec[j-1]
    sub r0, r0, 1             ; j--
    bnz r0, loop_j            ; Loop de j
fim_j:
    st [r0 + r4], r3          ; vec[j] = aux

    add r2, r2, 1             ; i++
    bnz r2, loop_i            ; Loop de i
fim_i:
    ret                       ; Retorna da função




loop_vet
    ; loop para próx vetores
    ldb r2, r0

    
vet_size
    ; verifica o tamanho do vetor
    Pilha
    Pilha
    
    slt x, x, x             ; se x2 < x3, x1 = 1 else x1 = 0
    bez 1, x1, loop_sort    ; desvio condicional (próx. vet)
    bnz sp, lr              ; volta incondicional  


set_vet
    sub sp, 2			; Pilha(push)
	stw r0, sp			; push(r0)

    add r1, r1, 1       ; vetores

    sub r0, r1, 1       ; r0 = r1-1
    bez r1, vet1     ; if (r1 == 0) PC = vet1

    sub r0, r1, 2       ; r0 = r1-2
    bez r1, vet2     ; if (r1 == 0) PC = vet2

    sub r0, r1, 3       ; r0 = r1-3
    bez r1, vet3     ; if (r1 == 0) PC = vet3


    //bez 4, r0, result	; começa display da resposta

    bnz r7, lr


loop_sort
    ; loop para organizar em ordem crescente
    bez r4, r2, loop_vet    ; se r2 = r4, próximo vetor






print
    ; loop para imprimir vetores antes e depois
    sub sp, 2           ;push
    stw r6, sp
    ldb r6, r2          ; r6 = r2
    
    sub sp, 2
    stw r2, sp

    
    stw r6, printint
    add r2, 1
    ble r2, r1, print   ; Loop do print

    ldw r6, sp          ;pop
    add sp, 2

    bnz sp, lr





vet1 10 5 3 8 1
vet2 9 6 5 1
vet3 9 10 2
vet_control 5
printchar 0xf000
printint 0xf002

######


1° - Definir os vetores
2° - Printar os vetores
3° - Executar o Insertion Sort
4° - Organizar os vetores
5° - Printar os vetores
6° - Próximo array

#######











##EXEMPLO
; o programa calcula os 10 primeiros multiplos de 3 e os coloca em um vetor
;
;	i = 0; j = 0;
;	while (i < 10){
;		j = j + 3;
;		v[i] = j;
;		i++;
;	}
;

main
	ldi r1,0			; r1 = 0 (i)
	ldi r2,0			; r2 = 0 (j)
	ldw r3,max			; r3 = 10
repete
	slt r4,r1,r3		; se i < max, r4 = true, senao r4 = false
	bez r4,fim			; se r4 == false, vai para fim
	
	add r2,3			; j = j + 3
	
	ldi r5,v			; r5 = &v[0]
	add r5,r5,r1		; r5 = &v[0] + i
	add r5,r5,r1		; r5 = &v[0] + i * 2 	(&v[i])
	stw r2,r5			; v[i] = j 				(*r5 = r2)
	
	add r1,1			; i++
	
	bnz r7,repete		; vai para repete
fim
	hcf					; PARA!

max	10
v	0 0 0 0 0 0 0 0 0 0




##  VERIFICAR SE UM NÚMERO É MAIOR QUE O OUTRO, DENTRO DE UM VETOR

;	i = 0; maior = -32768;
;	while (i < max) {
;		if (v[i] > maior)
;			maior = v[i];
;		i++;
;	}

main
	ldi r1,0
	ldw r2,maior
	ldw r3,max
repete
	slt r4,r1,r3
	bez r4,fim
	
	ldi r5,v
	add r5,r5,r1
	add r5,r5,r1
	ldw r5,r5
	
	slt r4,r5,r2
	bnz r4,pula
	and r2,r5,r5
pula
	add r1,1
	bnz r7,repete
fim
	stw r2,maior
	stw r2,0xf002
	hcf

max	10
v	653 -12415 254 3 338 -35 5335 32 -990 735
maior	-32768


##
Problema 2: A função abaixo implementa o algoritmo Insertion Sort.
 Escreva um programa que implementa esse algoritmo e demonstre seu funcionamento
 com 3 vetores de tamanho diferente. Para cada um dos vetores,
 apresente no terminal seus elementos antes e depois da ordenação.

insertion_sort(int * vec, int size) {
    int i, j, aux;
    for (i = 1; i < size; i++) {
        aux = vec[i];
        j = i;
        while ((j > 0) && (vec[j - 1] > aux)) {
            vec[j] = vec[j - 1];
            j--;
            }
        vec[j] = aux;
    }
}


i e j = mantem igual e armazena na pilha como 1 variável

main
    ; int i, j, aux
    ldi r0, vets    ; vetores
    ldi r1, 1       ; i & j
    ldi r3, 0       ; aux

loop_i
    
    ; Se i > vet_size, termina loop
	slt r5, r1, vet_size    ; if (r1<vet_size) {r5=1} else {r5=0}
	bez r5, fim_i       ; desvio condicional (r5)


fim_i
	; ?
    add r1, r1, 1       ; r1++
    bnz sp, lr





vet_size 1







A função insertion_sort é um algoritmo de ordenação que tem como finalidade classificar um array (ou vetor) de inteiros em ordem crescente.
Ele segue uma abordagem de "inserção", onde ele insere cada elemento do array na posição correta,
 garantindo que os elementos anteriores estejam sempre ordenados.
É um algoritmo eficiente para pequenas quantidades de dados ou arrays quase classificados.

Aqui está uma breve descrição do que a função faz:

1° Ela recebe um array de inteiros vec e o tamanho desse array size como argumentos.




2° Um loop for começa a partir do segundo elemento do array (índice 1) e percorre até o último elemento (índice size - 1).

3° Dentro do loop, o valor do elemento atual (vec[i]) é armazenado em aux, para evitar que seja substituído prematuramente.

4° A variável j é inicializada com o índice i.

5° Um loop while é usado para comparar o elemento atual (aux) com os elementos à esquerda dele.
 Ele move os elementos maiores para a direita para abrir espaço para o aux na posição correta.

6° O loop while continua até que j atinja o início do array (índice 0) ou até que não haja mais elementos à esquerda maiores que aux.

7° Finalmente, o valor em aux é inserido na posição correta (vec[j]).

8° Esse processo é repetido para todos os elementos no array, resultando em um array totalmente ordenado em ordem crescente após a execução da função.

O algoritmo de ordenação por inserção é simples e eficaz para pequenos conjuntos de dados,
 mas pode não ser a melhor opção para grandes conjuntos de dados, onde algoritmos mais eficientes, como o QuickSort ou o MergeSort, são preferidos.