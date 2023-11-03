# Sistemas_Compt.
Trabalhos da cadeira de Fundamentos de Sistemas Computacionais

Cheatsheet:

Reg | Nome | Apelido| Papel
0   | r0   | at     | Especial
1   | r1   | r1     | Uso geral
2   | r2   | r2     | Uso geral
3   | r3   | r3     | Uso geral
4   | r4   | r4     | Uso geral
5   | r5   | sr     | Uso geral
6   | r6   | lr     | Uso geral
7   | r7   | sp     | Especial

Instrução | Descrição | Opcode
AND | Logical product | 0 0 0 0
OR  | Logical sum     | 0 0 0 1 
XOR | Logical diff    | 0 0 1 0 
SLT | Set if less than| 0 0 1 1 
SLTU| SLT (unsigned)  | 0 1 0 0 
ADD | Add             | 0 1 0 1 
ADC | Add with carry  | 0 1 0 1 
SUB | Subtract        | 0 1 1 0 
SBC | SUB with carry  | 0 1 1 0 
LDR | Load register   | 1 0 0 0 
LDC | Load constant   | 1 0 0 1 
LSR | Logical shift right        | 1 0 1 0 
ASR | Arithmetic shift right     | 1 0 1 0 
ROR | Rotate right through carry | 1 0 1 0 
LDB | Load byte       | 0 0 0 0 
STB | Store byte      | 0 0 0 1 
LDW | Load word       | 0 1 0 0 
STW | Store word      | 0 1 0 1 
BEZ | Branch if equal zero     | 1 1 0 0 
BNZ | Branch if not equal zero |1 1 0 1 


Operação     | Significado
add r3,r1,r2 | r3 = r1 + r2
ldb r3,r0,r2 | r3 = MEM[r2] ***
stw r0,r1,r2 | MEM[r2] = r1 ***
and r2,r3,r4 | r2 = r3 and r4
bez r0,r2,r3 | if (r2 == zero) PC = r3
slt r3,r1,r2 | if (r1 < r2) r3 = 1, else r3 = 0
lsr r5,r3,r0 | r5 = r3 >> 1


Operação    | Significado
add r5,10   | r5 = r5 + 10
or r2,1     | r2 = r2 or 1
xor r5,-1   | r5 = r5 xor -1 = not r5
ldr r3,5    | r3 = 5
ldc r3,10   | r3 = (r3 << 8) or 10
slt r4,10   | if (r4 < 10) r4 = 1, else r4 = 0
bez r4,28   | if (r4 == zero) PC = PC + 28



Papel                   | 16 bits| 32 bits
Código + dados (início) | 0x0000 | 0x00000000
Ponteiro de pilha       | 0xdffe | 0x000ffffc
Saída (caracter)        | 0xf000 | 0xf0000000
Saída (inteiro)         | 0xf002 | 0xf0000004
Entrada (caracter)      | 0xf004 | 0xf0000008
Entrada (inteiro)       | 0xf006 | 0xf000000c