# Sistemas_Compt.
Trabalhos da cadeira de Fundamentos de Sistemas Computacionais


Problema 2: A função abaixo implementa o algoritmo Insertion Sort.
 Escreva um programa que implementa esse algoritmo e demonstre seu funcionamento  com 3 vetores de tamanho diferente. Para cada um dos vetores,
 apresente no terminal seus elementos antes e depois da ordenação.

insertion_sort(int * vec, int size) {
    int i, j, aux; main
    for (i = 1; i < size; i++) { loop_i
        aux = vec[i]    ; aux = vetor [1(2)] => aux = 2
        j = i           ; j = 1  
        while ((j > 0) && (vec[j - 1] > aux)) { ; loop_j
            vec[j] = vec[j - 1]; vetor [1(2)] = vetor[0(3)]
            j--; j = 1 - 1
            ;1° [3,2,1] -> [0,3,1] 
            ; 
        }
        vec[j] = aux; [0,3,1] -> [2,3,1]
    }
}













Papel                   | 16 bits| 32 bits
Código + dados (início) | 0x0000 | 0x00000000
Ponteiro de pilha       | 0xdffe | 0x000ffffc
Saída (caracter)        | 0xf000 | 0xf0000000
Saída (inteiro)         | 0xf002 | 0xf0000004
Entrada (caracter)      | 0xf004 | 0xf0000008
Entrada (inteiro)       | 0xf006 | 0xf000000c










