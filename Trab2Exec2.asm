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

A função insertion_sort é um algoritmo de ordenação que tem como finalidade classificar um array (ou vetor) de inteiros em ordem crescente.
Ele segue uma abordagem de "inserção", onde ele insere cada elemento do array na posição correta, garantindo que os elementos anteriores estejam sempre ordenados.
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