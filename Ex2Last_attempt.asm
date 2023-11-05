## Último teste trab 2
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


insertion_sort -> COMEÇA SEMPRE RECEBENDO (int[i] * vec[i], int size)
# Ou seja, função insertion_sort, começa recebendo 'i', vec[i], vet_size.

# r0 = vetores
# r1 = i & j
# r3 = aux
# r6 = precisa ter um retorno p/ loop

main
    ; int i, j, aux
    ldi r0, vets    ; vetores
    ldi r1, 1       ; i & j = mantem igual e armazena na pilha como 1 variável
    ldi r3, 0       ; aux
    bnz r7, insertion_sort


insertion_sort
    ; insertion_sort(int * vec, int size) {RECEBE OS PARAM}
    ldb r2, r0      ; r2 = vets[0]
    ; BRANCH p/ o loop de PRINT
	bnz sp, loop_print

	add r0, 1       ; r0++
	

    add vet_ctrl, 1	; vet_ctrl++
    slt sr, vet_ctrl, vet_size ; sr = vet_ctrl - vet_size
    
    bnz sr, begin_for

begin_for
    ; for (i = 1; i < size; i++) {
    ; Se i > vet_size, termina loop
	slt sr, r1, vet_size; if (i < vet_control) SIM{sr=1} else NÃO{sr=0}
    bez sr, vets        ; if (sr = 0) -> Acabou o vetor atual, próximo vetor
	
	; NÃO acabou o vetor atual, continua
	;sub sp, 2		; Pilha(Push)
	;stw r2, sp		; pilha, preserva r2 -> r2 = vet[i]
    ;ldb r2, r1		; sr = vet[i]

    ldb r3, r1      ; aux = vet[i] ? TESTE se funciona

    bnz sp, begin_while      ; if (sr = 1) -> loop_j

end_for
    ; Falho nos teste [for (i = 1; i < size; i++)]
    slt sp, vet_ctrl, r1 ; if (vet_ctrl < i) {sp = 1} else {sp = 0}
    bnz sp, lr



#####################################
