As operações são separadas em quatro classes distintas:

1. Computação (AND, OR, XOR, SLT, SLTU, ADD, ADC, SUB, SBC, LDR, LDC)
2. Deslocamento e rotação (LSR, ASR, ROR)
3. Carga e armazenamento (LDB, STB, LDW, STW)
4. Desvios condicionais (BEZ, BNZ)

## 1. 1. Registradores
Assim como outros processadores RISC, o processador Viking é definido como uma arquitetura
baseada em operações de carga e armazenamento (load/store) para acesso à memória de dados.

# (GPRs) Registradores de Propósito Geral .

Reg | Nome | Apelido| Papel
0   | r0   | at     | Especial  [r0 = Temp(montador) = at] => Não preservado!
1   | r1   | r1     | Uso geral
2   | r2   | r2     | Uso geral
3   | r3   | r3     | Uso geral
4   | r4   | r4     | Uso geral
5   | r5   | sr     | Uso geral [r5 = Temp(sr)] => Não preservado!
6   | r6   | lr     | Uso geral [r6 = PC = address de retorno] => "Chamador"
7   | r7   | sp     | Especial  [Ponteiro de Pilha = sp] => Preservado


O temporário é usado por pseudo operações (apresentadas na Seção 2) e o ponteiro de pilha para armazenamento de dados e chamadas de função.
Outro papel desse registrador é a implementação de desvios incondicionais, uma vez que é seguro assumir que seu valor nunca será zero durante a execução normal de um programa.


## 1. 2. Formatos de instrução
Existem apenas dois formatos de instrução definidos na arquitetura Viking (tipos R e I). Em instruções do tipo R, um registrador é definido como destino (Rst) e dois registradores são definidos como fontes (RsA e RsB).
Em instruções do tipo I, um registrador é definido como fonte e destino da operação (Rst), e o segundo valor usado como fonte é obtido a partir do campo Immediate codificado diretamente na instrução. Os índices utilizados para indexar o banco de registradores são codificados na instrução em 3 bits cada, o suficiente para referenciar 8 registradores por operando ou destino para escrita do resultado.

# 1.2.1 Instruções tipo R
Em instruções do tipo R os campos Opcode (4 bits) e Op2 (2 bits) definem a operação específica.
Nesse tipo de instrução três registradores são referenciados, e o papel desses registradores depende 4 da classe à qual a instrução está associada. As instruções do tipo R possuem o campo Imm com o valor fixo em 0.

I<15:12> I<11> I<10:8> I<7:5> I<4:2> I<1:0>
Opcode Imm Rst RsA RsB Op2
x x x x 0 r r r r r r r r r x x

A função dos campos adicionais em instruções do tipo R é definida como:
 Rst - registrador destino (alvo) da operação;
 RsA - registrador Fonte 1 (Operando A);
 RsB - registrador Fonte 2 (Operando B ou base);
- Operando B em operações da classe computação
- Endereço base para instruções de carga e armazenamento e desvios;
Para instruções de deslocamento, o registrador Fonte 2 deve ser sempre r0. O motivo para isso é que não é necessário codificar a quantidade a ser deslocada, uma vez que a arquitetura pode deslocar apenas 1 bit por instrução. Em instruções de carga, o registrador Fonte 1 deve ser
sempre r0 e em instruções de armazenamento e desvios condicionais, o registrador alvo é sempre r0. Abaixo são apresentados alguns exemplos de instruções do tipo R, utilizando a sintaxe da linguagem de montagem apresentada no Capítulo 4. Importante observar que em instruções de
armazenamento e desvios condicionais Rst deve ser r0, em instruções de carga RsA deve ser r0 e em deslocamentos RsB deve ser r0 3.

Operação     | Significado
add r3,r1,r2 | r3 = r1 + r2
ldb r3,r0,r2 | r3 = MEM[r2]
stw r0,r1,r2 | MEM[r2] = r1
and r2,r3,r4 | r2 = r3 and r4
bez r0,r2,r3 | if (r2 == zero) PC = r3
slt r3,r1,r2 | if (r1 < r2) r3 = 1, else r3 = 0
lsr r5,r3,r0 | r5 = r3 >> 1


## 1.2.2 Instruções tipo I
Em instruções do tipo I o campo Opcode (4 bits) define a operação específica. Nesse tipo de instrução um registrador é referenciado, e o papel desse registrador depende da classe à qual a instrução está associada. As instruções do tipo I possuem o campo Imm com o valor fixo em 1.

I<15:12> | I<11> | I<10:8> | I<7:0>
Opcode   |  Imm  |   Rst   | Immediate
x x x x  |   1   |  r r r  | i i i i i i i i

A função dos campos adicionais em instruções do tipo I é definida como:
O motivo para tais convenções é fixar no formato de instruções o papel dos registradores Rst, RsA e RsB, evitando a utilização de multiplexadores adicionais. No tipo R, o primeiro registrador sempre é escrito, e os dois
últimos sempre lidos. No tipo I, o primeiro é sempre lido e escrito.

- Rst - registrador Fonte 1 e destino;
- Immediate - campo com valor imediato;
- Fonte 2 em instruções da classe computação;
- Endereço relativo ao contador de programa em desvios;

Para desvios condicionais, endereço efetivo é calculado somando-se o valor atual do contador de programa (PC) ao campo Immediate (extendido em sinal4 e representado em complemento de 2). Dessa forma, é possível realizar desvios relativos ao PC de 128 bytes5, o suficiente para lidar com a maior parte dos casos que envolvem saltos de tamanho reduzido, como em comandos
de seleção e laços curtos. Abaixo são apresentados alguns exemplos de instruções do tipo I, utilizando a sintaxe da linguagem de montagem.


Operação    | Significado
add r5,10   | r5 = r5 + 10
or r2,1     | r2 = r2 or 1
xor r5,-1   | r5 = r5 xor -1 = not r5
ldr r3,5    | r3 = 5
ldc r3,10   | r3 = (r3 << 8) or 10
slt r4,10   | if (r4 < 10) r4 = 1, else r4 = 0
bez r4,28   | if (r4 == zero) PC = PC + 28


## 1.3 Modos de endereçamento
Apenas três modos de endereçamento são utilizados na arquitetura, sendo esses:
1. Registrador
2. Imediato
3. Relativo ao PC
O primeiro modo (registrador) é utilizado por instruções do tipo R apenas. Instruções que
fazem uso desse modo pertencem às classes computação, deslocamento, carga e armazenamento
e desvios condicionais. O segundo modo (imediato) é utilizado por instruções do tipo I apenas,
classe computação. O último modo (relativo ao PC) é utilizado por instruções do tipo I, classe desvios condicionais.


## 1.4.1 Computação
AND - bitwise logical product
Realiza o produto lógico de dois valores e armazena o resultado em um registrador.
- AND Rst, RsA, RsB
GPR[Rst]   GPR[RsA] and GPR[RsB]
I<15:12> I<11> I<10:8> I<7:5> I<4:2> I<1:0>
Opcode Imm Rst RsA RsB Op2
0 0 0 0 0 r r r r r r r r r 0 0

- AND Rst, Immediate
GPR[Rst]   GPR[Rst] and ZEXT(Immediate)
I<15:12> I<11> I<10:8> I<7:0>
Opcode Imm Rst Immediate
0 0 0 0 1 r r r i i i i i i i i

- OR - bitwise logical sum
Realiza a soma lógica de dois valores e armazena o resultado em um registrador.
 OR Rst, RsA, RsB
GPR[Rst]   GPR[RsA] or GPR[RsB]
I<15:12> I<11> I<10:8> I<7:5> I<4:2> I<1:0>
Opcode Imm Rst RsA RsB Op2
0 0 0 1 0 r r r r r r r r r 0 0

- OR Rst, Immediate
GPR[Rst]   GPR[Rst] or ZEXT(Immediate)
I<15:12> I<11> I<10:8> I<7:0>
Opcode Imm Rst Immediate
0 0 0 1 1 r r r i i i i i i i i

- XOR - bitwise logical difference
Realiza a diferença lógica de dois valores e armazena o resultado em um registrador. No tipo I,
o segundo valor possui extensão de sinal.

- XOR Rst, RsA, RsB
GPR[Rst]   GPR[RsA] xor GPR[RsB]
I<15:12> I<11> I<10:8> I<7:5> I<4:2> I<1:0>
Opcode Imm Rst RsA RsB Op2
0 0 1 0 0 r r r r r r r r r 0 0

-  XOR Rst, Immediate
GPR[Rst]   GPR[Rst] xor SEXT(Immediate)
I<15:12> I<11> I<10:8> I<7:0>
Opcode Imm Rst Immediate
0 0 1 0 1 r r r i i i i i i i i

- SLT - set if less than
Compara dois valores (com sinal, em complemento de 2). Se o primeiro for menor que o segundo, armazena 1 (verdadeiro) em um registrador. Senão, armazena 0 (falso). No tipo I, o segundo valor possui extensão de sinal. O cálculo do valor dessa instrução é definido por SLT = N xor
V, resultante de uma subtração realizada internamente e avaliação da diferença lógica dos qualificadores negative e overflow, também internos a ULA. O valor da condição SLT é armazenado no bit menos significativo do registrador destino, sendo os outros zerados.

- SLT Rst, RsA, RsB
if (GPR[RsA] < GPR[RsB]) GPR[Rst]   1
else GPR[Rst]   0
I<15:12> I<11> I<10:8> I<7:5> I<4:2> I<1:0>
Opcode Imm Rst RsA RsB Op2
0 0 1 1 0 r r r r r r r r r 0 0

- SLT Rst, Immediate
if (GPR[RsA] < SEXT(Immediate) GPR[Rst]   1
else GPR[Rst]   0
I<15:12> I<11> I<10:8> I<7:0>
Opcode Imm Rst Immediate
0 0 1 1 1 r r r i i i i i i i i

- SLTU - set if less than (unsigned)
Compara dois valores (sem sinal). Se o primeiro for menor que o segundo, armazena 1 (verdadeiro) em um registrador. Senão, armazena 0 (falso). No tipo I, o segundo valor possui extensão de sinal. O cálculo dessa instrução é definido por SLTU = C, resultante de uma subtração realizada internamente e avaliação do qualificador carry interno a ULA. O valor da condição SLTU é
armazenado no bit menos significativo do registrador destino, sendo os outros zerados.

- SLTU Rst, RsA, RsB
if (GPR[RsA] < GPR[RsB]) GPR[Rst]   1
else GPR[Rst]   0
I<15:12> I<11> I<10:8> I<7:5> I<4:2> I<1:0>
Opcode Imm Rst RsA RsB Op2
0 1 0 0 0 r r r r r r r r r 0 0

- SLTU Rst, Immediate
if (GPR[RsA] < SEXT(Immediate) GPR[Rst]   1
else GPR[Rst]   0
I<15:12> I<11> I<10:8> I<7:0>
Opcode Imm Rst Immediate
0 1 0 0 1 r r r i i i i i i i i

- ADD - add
Soma dois valores e armazena o resultado em um registrador. No tipo I, o segundo valor possui extensão de sinal.

- ADD Rst, RsA, RsB
GPR[Rst]   GPR[RsA] + GPR[RsB]
I<15:12> I<11> I<10:8> I<7:5> I<4:2> I<1:0>
Opcode Imm Rst RsA RsB Op2
0 1 0 1 0 r r r r r r r r r 0 0

- ADD Rst, Immediate
GPR[Rst]   GPR[Rst] + SEXT(Immediate)
I<15:12> I<11> I<10:8> I<7:0>
Opcode Imm Rst Immediate
0 1 0 1 1 r r r i i i i i i i i

- ADC - add with carry
Soma dois valores e armazena o resultado em um registrador. A soma inclui o carry gerado pela última instrução.

- ADC Rst, RsA, RsB
GPR[Rst]   GPR[RsA] + GPR[RsB] + Carry
I<15:12> I<11> I<10:8> I<7:5> I<4:2> I<1:0>
Opcode Imm Rst RsA RsB Op2
0 1 0 1 0 r r r r r r r r r 0 1

- SUB - subtract
Subtrai dois valores e armazena o resultado em um registrador. No tipo I, o segundo valor possui extensão de sinal.

- SUB Rst, RsA, RsB
GPR[Rst]   GPR[RsA] - GPR[RsB]
I<15:12> I<11> I<10:8> I<7:5> I<4:2> I<1:0>
Opcode Imm Rst RsA RsB Op2
0 1 1 0 0 r r r r r r r r r 0 0

- SUB Rst, Immediate
GPR[Rst]   GPR[Rst] - SEXT(Immediate)
I<15:12> I<11> I<10:8> I<7:0>
Opcode Imm Rst Immediate
0 1 1 0 1 r r r i i i i i i i i

- SBC - subtract with carry
Subtrai dois valores e armazena o resultado em um registrador. A subtração inclui o carry gerado pela última instrução.

- SBC Rst, RsA, RsB
GPR[Rst]   GPR[RsA] - GPR[RsB] - Carry
I<15:12> I<11> I<10:8> I<7:5> I<4:2> I<1:0>
Opcode Imm Rst RsA RsB Op2
0 1 1 0 0 r r r r r r r r r 0 1

- LDR - load register
Carrega uma constante de 8 bits em um registrador. O valor carregado possui extensão de sinal, o que facilita a carga de constantes de pequeno valor (128, em complemento de dois) com apenas uma instrução.

- LDR Rst, Immediate
GPR[Rst]   SEXT(Immediate)
I<15:12> I<11> I<10:8> I<7:0>
Opcode Imm Rst Immediate
1 0 0 0 1 r r r i i i i i i i i

- LDC - load constant
Carrega uma constante em um registrador. O valor carregado não possui extensão de sinal. Antes de carregar o valor nos 8 bits menos significativos de um registrador, o mesmo tem seu conteúdo deslocado à esquerda por 8 bits, o que permite a carga de constantes de valores maiores que 128 com múltiplas instruções.

- LDC Rst, Immediate
GPR[Rst]   GPR[Rst]<7=24:0> & ZEXT(Immediate)
I<15:12> I<11> I<10:8> I<7:0>
Opcode Imm Rst Immediate
1 0 0 1 1 r r r i i i i i i i i






