main
    ldi r0, words           ; endereço temporário das strings
	ldi r1, 48              ; valor ASCII para '0'
    ldi r3, 0               ; pointer: dentro da palavra
    ldi r4, 32              ; valor ASCII para espaço
	ldi lr, loop_string

loop_string
    ldb r2, r0              ; carrega caractere atual no r2
    bez r1, r2, end_string  ; se r2 = r1 ('\0'), registra fim da string OK
    bez r4, r2, inside_word ; se r2 = (' '), vai p/ inside_word /////Possivelmente errado

	//and r2, r4, r1
	//bez r3, r4

	BRANCH IF EQUAL:
	sub r2, r2, r4
	bez r0, r1, inside_word


    ; É um espaço, mas estava dentro de uma palavra anteriormente
    bnz r3, increment_word

    ; Não é espaço e não estava dentro de uma palavra, então segue
    add r0, 1
    bnz r7, loop_string     ; pulo incondicional


end_string
    add r5, 1            ; r5 + 1 -> próxima string
    ldi r1, 10           ; valor ASCII de nova linha | ASCII(10) = '\n'
    stw r1, printchar    ; imprime nova linha
    ldi r1, 48
    bnz r7, words

inside_word
    ; incrementa o pointer(+1 letra) e pula p/ proximo 2° byte
    add r3, r3, r5       ; r3 = r3 + r5 = 1 bit (espaço)
    
    ;increment_word
	sub sp, 2
	stw r3, 2


    add word_counter, word_counter, r5  ; incrementa contador de palavras
    ldi r3, 0               ; reseta pointer
    bnz r7, lr			 ; pulo incondicional


words
    sub r0, r5, 1         ; varholder = str-1
    bez 0, r0, set_str1   ; if (r0 == 0) PC = set_str1
	sub 0, r5, 2
    bez 0, r0, set_str2   ; if (r0 == 0) PC = set_str2
    sub 0, r5, 3
    bez 0, r0, set_str3   ; if (r0 == 0) PC = set_str3
    bez 4, r0, result	  ; começa display da resposta
    bnz r7, lr

set_str1
    stw r0,"Primeira string"
	bnz r7, lr
set_str2
    stw r0,"Segunda string"
	bnz r7, lr
set_str3
    stw r0,"Terceira string"
	bnz r7, lr


result
	start_result



printchar 0xf000
printint 0xf002