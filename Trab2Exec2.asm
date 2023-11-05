main
    ; int i, j, aux
    ldi r0, vets    ; vetores
    ldi r1, 1       ; i & j = mantem igual e armazena na pilha como 1 variável
    ldi r3, 0       ; aux
    bnz r7, insertion_sort

insertion_sort
    bnz first_print, loop_print
    ; insertion_sort(int * vec, int size)

    ldb r2, r0          ; r2 = vets -> r2 = vet[r1]
    stw r2, printint
    
    ldi sr, r1
    slt sr, vet_control
    add r0, 1
    bnz sr, begin

loop_print
	ldw	r2,r0           ; r2 = r0 (vetor)
	stw	r2,printint     ; printa vet[0]
	ldi	r2,32           ; r2 = ""
	stw	r2,printchar    ; printa ""
	add	vet_control, 1            ; r4++
	add	r0,2            ; r0 + 2 (pula byte)
	sub	sr,vet_size,vet_control ; sr = vet_size - vet_control=0
	bnz	sr,loop_print
	ldi	r2,10           ; r2 = "\n"
	stw	r2,printchar    ; print "\n"
    ldi r2, r0          ; r2 = r0 (vetor)
    sub first_print, 1
	bnz	r7, insertion_sort



loop_i
    ; for (i = 1; i < size; i++) {
    
    ; Se i > vet_size, termina loop
	slt sr, r1, vet_control; if (r1(i/j)<vet_control) {sr=1} else {sr=0}
    bez sr, fim_i       ; if (sr = 0) -> fim_i

    ldb r2, r0
    ldb r3, r2          ; aux = vet[i]



    bnz sp, loop_j      ; if (sr = 1) -> loop_j
    
    
fim_i
	; ?
    add r1, r1, 1       ; r1++
    slt sp, vet_control, r1
    bnz sp, lr

loop_j
    ; while ((j > 0) && (vet[j - 1] > aux)) {
    ; (j > 0) 
    slt sr, r1, 0       ; if (r1(j) < 0) {sr=1} else {sr=0}
    bez sr, fim_j       ; if (sr(j) < 0) {loopend}

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
    bnz sp, lr
set_vet2
    ldi r0, vet2
    bnz sp, lr
set_vet1
    ldi r0, vet1
    bnz sp, lr
end
    hcf

first_print 4
vet_size 5
vet_control 0
next_vet 0
vet1 10 5 3 8 1
vet2 9 6 5 1
vet3 9 10 2
printint 0xf002
printchar 0xf000