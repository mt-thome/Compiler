# Manual do Usuário - Analisador Léxico

## Visão Geral

Este projeto implementa um analisador léxico (scanner) para uma linguagem de programação personalizada. O analisador utiliza o gerador de analisadores léxicos **Flex** para reconhecer tokens de uma linguagem que combina elementos de francês e português.

**Para a especificação formal completa da linguagem**, consulte o documento [Linguagem Regular](linguagem_regular.pdf).

## Funcionalidades

O analisador reconhece os seguintes elementos:

### Palavras-chave
- `siu` - equivalente a "if" (se)
- `autre` - equivalente a "else" (senão)
- `sinon siu` - equivalente a "elif" (senão se)
- `changer` - equivalente a "switch" (escolha)
- `cas` - equivalente a "case" (caso)
- `defaut` - equivalente a "default" (padrão)
- `casser` - equivalente a "break" (quebrar)
- `continuer` - equivalente a "continue" (continuar)
- `retour` - equivalente a "return" (retornar)
- `faire` - equivalente a "do" (fazer)
- `while` - laço "enquanto"
- `for` - laço "para"

### Operadores
- `+` - soma
- `-` - subtração
- `X` - multiplicação
- `/` - divisão
- `:` - atribuição
- `Ʌ` - menor que
- `V` - maior que
- `V/` - menor ou igual
- `::` - igualdade
- `ney:` - diferente
- `ney` - negação

### Delimitadores
- `;` - ponto e vírgula
- `,` - vírgula
- `(` e `)` - parênteses
- `{` e `}` - chaves

### Tipos de Dados
- **Identificadores**: começam com letra, podem conter letras, dígitos e underscore
- **Números inteiros**: sequência de dígitos
- **Números decimais**: formato `123.456`

### Comentários
- `//` - comentário de linha única
- `/* */` - comentário de múltiplas linhas

## Instalação

### Pré-requisitos

```bash
# Ubuntu/Debian
sudo apt-get install flex gcc

# Fedora/CentOS
sudo yum install flex gcc

# Arch Linux
sudo pacman -S flex gcc
```

### Compilação

```bash
# Verificar dependências
make check-deps

# Compilar o projeto
make

# Ou compilar do zero
make rebuild
```

## Uso

### Sintaxe Básica

```bash
./analisador <arquivo_de_entrada>
```

### Exemplos

1. **Teste básico:**
```bash
make test
```

2. **Arquivo personalizado:**
```bash
echo 'siu (x : 10) faire' > meu_teste.txt
./analisador meu_teste.txt
```

3. **Programa completo:**
```bash
cat > exemplo.txt << EOF
siu (contador : 0) {
    faire {
        contador : contador + 1;
    } while (contador Ʌ 10);
    retour contador;
}
EOF

./analisador exemplo.txt
```

### Saída Esperada

```
LINHA 1: KEYWORD_IF -> 'siu'
LINHA 1: DELIM_ABRE_PARENTESES -> '('
LINHA 1: IDENTIFICADOR -> 'contador'
LINHA 1: OP_ATRIB -> ':'
LINHA 1: NUMERO_INT -> 0
LINHA 1: DELIM_FECHA_PARENTESES -> ')'
LINHA 1: DELIM_ABRE_CHAVES -> '{'
...
```

## Comandos Make Disponíveis

| Comando | Descrição |
|---------|-----------|
| `make` | Compila o projeto |
| `make test` | Executa teste básico |
| `make test-full` | Executa teste completo (se existir) |
| `make clean` | Remove arquivos gerados |
| `make rebuild` | Recompila do zero |
| `make install` | Instala no sistema (/usr/local/bin) |
| `make check-deps` | Verifica dependências |
| `make info` | Mostra informações do projeto |
| `make help` | Mostra ajuda |

## Estrutura do Projeto

```
C/Compiler/
├── Makefile              # Script de compilação
├── src/
│   ├── analisador.l      # Código fonte do analisador léxico
│   └── lex.yy.c         # Código C gerado pelo flex (gerado automaticamente)
├── tests/
│   ├── teste_completo.txt # Arquivo de teste (se existir)
│   └── exemplo_completo.txt # Exemplo demonstrativo
├── docs/
│   └── MANUAL.md         # Este manual
└── analisador            # Executável (gerado)
```

## Resolução de Problemas

### Erro: "flex: command not found"
```bash
sudo apt-get install flex
```

### Erro: "gcc: command not found"
```bash
sudo apt-get install gcc
```

### Erro: "undefined reference to yywrap"
Certifique-se de usar a flag `-lfl` na compilação:
```bash
gcc lex.yy.c -lfl -o analisador
```

### Warning: "rule cannot be matched"
Alguns warnings são normais devido à ordem das regras. O analisador funciona corretamente mesmo com esses warnings.

## Desenvolvimento

### Modificando o Analisador

1. Edite o arquivo `src/analisador.l`
2. Recompile com `make rebuild`
3. Teste com `make test`

### Adicionando Novos Tokens

Para adicionar um novo token, edite a seção de regras em `src/analisador.l`:

```c
"nova_palavra"  {printf("LINHA %d: NOVO_TOKEN -> '%s'\n", line_count, yytext); }
```

### Testando Alterações

1. Crie um arquivo de teste
2. Execute: `./analisador seu_arquivo.txt`
3. Verifique se a saída está correta

## Limitações Conhecidas

1. Caracteres especiais podem não ser exibidos corretamente em alguns terminais
2. Alguns operadores usam caracteres Unicode que podem causar problemas de codificação
3. A ordem das regras pode gerar warnings no flex (mas não afeta o funcionamento)

## Suporte

Para problemas ou dúvidas:
1. Verifique se todas as dependências estão instaladas (`make check-deps`)
2. Tente recompilar do zero (`make rebuild`)
3. Execute um teste básico (`make test`)

## Licença

Este projeto é desenvolvido para fins educacionais.
