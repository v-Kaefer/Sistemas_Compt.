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