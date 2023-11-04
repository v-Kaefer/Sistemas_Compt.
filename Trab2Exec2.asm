##
Problema 2: A função abaixo implementa o algoritmo Insertion Sort.
 Escreva um programa que implementa esse algoritmo e demonstre seu funcionamento
 com 3 vetores de tamanho diferente. Para cada um dos vetores,
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



//r0 = temp(montador) {at} -> Não preservado
//r5 = temp {sr} -> Não preservado
//r6 = PC = add de retorno {lr} -> "Chamador"
//r7 = Ponteiro de pilha {sp} -> Preservado


//i e j = mantem igual e armazena na pilha como 1 variável

main
    ; int i, j, aux
    ldi r0, vets    ; vetores
    ldi r1, 1       ; i & j
    ldi r3, 0       ; aux

begin
    ldb r2, r0
    stw r2, printint
    
    ldi sr, r1
    slt sr, vet_control
    add r0, 1
    bnz sr, begin


loop_i
    ldb r2, r0
    ldb r3, r2          ; aux = vet[i]
    ; Se i > vet_size, termina loop
	slt sr, r1, vet_control; if (r1(i/j)<vet_size) {sr=1} else {sr=0}
    bez sr, fim_i       ; sr = 0    
    bnz sp, loop_j
fim_i
	; ?
    add r1, r1, 1       ; r1++
    bnz sp, lr

loop_j
    ; while ((j > 0) && (vet[j - 1] > aux)) {
    ; (j > 0) 
    slt sr, r1, 0       ; if (r1(j) < 0) {sr=1} else {sr=0}
    bnz sr, fim_j       ; if (sr(j) < 0) {loopend}

    ; ajuste p/ teste (vet[j - 1] > aux)
    ldi sr, r1          ; sr = r1 (j)
    sub sr, sr, 1       ; sr(j) = [j - 1]
    ldb r4, r0          ; r4 = vet[r1(j)]
    add r0, sr          ; r0 + (j-1)
    ldb r4, r0          ; r4 {vet[0]} = r4 {vet[j-1]}

    ; Pilha (j-1)
    sub sp, 2
    stb sr, sp

    ; teste (vec[j - 1] > aux)
    slt sr, r4, r3      ; if (r4 < r3) {sr = 1} else {sr = 0}
    bnz sr, endloop_j   ; endloop_j

    ; Passou nos testes

    ldi r0, r1          ; r0 = r1(j)
    ldb r4, r0          ; r4 = vet[j]
    ldi sp, sr          ; PILHA[pop] carrega vet[j-1]
    add sp, 2
    stb r4, sr          ; r4 vet[j] = sr vet[j-1]
    sub sr, r1, 1       ; j--
    bnz sp, endloop_j

endloop_j
    ldi r0, sr          ; índice = j
    ldb r2, r0          ; vet[j]
    stb r2, r3          ; vet[j] = aux
    bnz sp, loop_i

vets
    add next_vet, 1
    slt sr, next_vet, 3
    bnz sr, set_vet3
    slt sr, next_vet, 2
    bnz sr, set_vet2
    slt sr, next_vet, 1
    bnz sr, set_vet1

set_vet3
    ldi r0, vet3
    bnz sp, begin
set_vet2
    ldi r0, vet2
    bnz sp, begin
set_vet1
    ldi r0, vet1
    bnz sp, begin
end
    hcf


vet_size 1
next_vet 0
vet1 10 5 3 8 1
vet2 9 6 5 1
vet3 9 10 2
vet_control 5
printint 0xf002