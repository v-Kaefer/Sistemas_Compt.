main
    ; int i, j, aux
    ldi r0, select_vet    ; vetores
    ldi r1, 0       ; i & j = mantem igual e armazena na pilha como 1 variável
    ldi r3, 0       ; aux {vetx[i]}
    bez sp, insertion_sort

insertion_sort
    ldi sr, vet_ctrl
    add sr, 1 ; Contagem dos vetores
    slt sp, vet_control, 4
    bnz sp, end
    ; insertion_sort(int * vec, int size)
    ; for
    ldi r2, r0        ; r2 = vetx[0]
    add r2, r2, r1    ; r2 = vetx[r1(i)]
    ldi r3, r2        ; aux = vet[r1(i)]

    ; r1 = j = i
    bez sp, loop_j    

loop_print
	ldw	r2,r0           ; r2 = r0 (vetor)
	stw	r2,printint     ; printa vet[0]
	ldi	r2,32           ; r2 = ""
	stw	r2,printchar    ; printa ""
	add	vet_ctrl, 1            ; r4++
	add	r0,2            ; r0 + 2 (pula byte)
	sub	sr,vet_size,vet_ctrl ; sr = vet_size - vet_control=0
	bnz	sr,loop_print
	ldi	r2,10           ; r2 = "\n"
	stw	r2,printchar    ; print "\n"
    ldi r2, r0          ; r2 = r0 (vetor)
    sub first_print, 1
	bnz	r7, insertion_sort



loop_i
    ; for (i = 1; i < size; i++) {
    
    ; Se i > vet_size, termina loop
	slt sp, r1, vet_ctrl; if (r1(i/j)<vet_control) {sr=1} else {sr=0}
    bez sp, fim_i       ; if (sr = 0) -> fim_i

    bnz sp, loop_j      ; if (sr = 1) -> loop_j
    
    
fim_i
    add r1, r1, 1       ; r1++
    slt sp, r1, vet_ctrl
    bez sp, insertion_sort
    bnz sp, loop_i

loop_j
    ; while ((j > 0) && (vet[j - 1] > aux)) {
    ; (j > 0) 
    slt sp, r1, 0       ; if (r1(j) < 0) {sr=1} else {sr=0}
    bnz sp, fim_j       ; if (sr(j) < 0) {loopend}

    ; (vet[j - 1] > aux)

    ldi r4, r2          ; r4 = vetx[r1(j)]
    ldi sr, r4
    sub sp, 2           ; Pilha(Push)
    stw r4, sp          ; Push(vetx[r1(j)])
    ldi r4, sr
    sub r4, r4, 1       ; r4[j] = vetx[j - 1]    

    slt sp, r4, r3      ; if (r4(vetx[j - 1 ] < aux )) {sr = 1} else {start_loop_j}
    bnz sp, endloop_j   ; if (sr!=0) {endloop_j}

    ; start_loop_j
    
    ldi r5, r2          ; r5 = vetx[r1(j)]
    add r5, r5, r4      ; r5 = vetx[vetx[j-1]] / posição
    stw r5, r4          ; vetx[j] = vetx[j-1]
    sub r1, r1, 1       ; j-- {Retorna 1 posição no índice}
    bnz sp, endloop_j

endloop_j

    ldi r5, r2          ; r5 = vetx[r1]
    stw r5, r3          ; vetx[r1(j)] = aux
    bnz sp, loop_i

select_vet
    add next_vet, 1
    slt sr, next_vet, 3
    bnz sr, set_vet3
    slt sr, next_vet, 2
    bnz sr, set_vet2
    slt sr, next_vet, 1
    bnz sr, set_vet1

set_vet3
    ldi r0, vet3
set_vet2
    ldi r0, vet2
set_vet1
    ldi r0, vet1
end
    hcf




printint 0xf002
printchar 0xf000
first_print 4
vet_size 5
vet_ctrl 0
next_vet 0
vet1 10 5 3 8 1
vet2 9 6 5 1
vet3 9 10 2

