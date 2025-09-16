# Analisador Léxico - Compilador

Um analisador léxico implementado em Flex/Lex para uma linguagem de programação personalizada.

## Quick Start

```bash
# Verificar dependências
make check-deps

# Compilar
make

# Testar
make test
```

## Estrutura do Projeto

```
.
├── Makefile              # Sistema de build
├── README.md            # Este arquivo
├── src/
│   ├── analisador.l     # Código fonte do analisador léxico
│   └── lex.yy.c         # Código C gerado pelo flex (gerado automaticamente)
├── docs/
│   ├── MANUAL.pdf        # Manual completo do usuário
│   └── linguagem_regular.pdf # Especificação formal da linguagem
├── tests/
│   └── arquivo_fonte.txt # Arquivo de demonstração completo
└── analisador           # Executável (gerado após compilação)
```

## Comandos Principais

| Comando | Descrição |
|---------|-----------|
| `make` | Compila o projeto |
| `make test` | Executa teste básico |
| `make test-full` | Executa teste completo com arquivo_fonte.txt |
| `make clean` | Limpa arquivos gerados |
| `make help` | Mostra todos os comandos |

## Documentação

- **[Manual do Usuário](docs/MANUAL.md)** - Guia completo de instalação, uso e exemplos
- **[Especificação da Linguagem Regular](docs/linguagem_regular.md)** - Definição formal da linguagem e tokens

## Dependências

- `flex` - Gerador de analisadores léxicos
- `gcc` - Compilador C

```bash
# Ubuntu/Debian
sudo apt-get install flex gcc
```

## Exemplo de Uso

### Teste Rápido
```bash
echo 'mbappe (i : 0; i Ʌ 5; i : i + 1) { resultado : i X 2; }' > teste.txt
./analisador teste.txt
```

**Saída:**
```
LINHA 1: KEYWORD_FOR -> 'mbappe'
LINHA 1: DELIM_ABRE_PARENTESES -> '('
LINHA 1: IDENTIFICADOR -> 'i'
LINHA 1: OP_ATRIB -> ':'
LINHA 1: NUMERO_INT -> 0
LINHA 1: DELIM_PONTO_VIRGULA -> ';'
LINHA 1: IDENTIFICADOR -> 'i'
LINHA 1: OP_MENOR -> 'Ʌ'
LINHA 1: NUMERO_INT -> 5
...
```

### Demonstração Completa
O projeto inclui um arquivo de demonstração que mostra todas as funcionalidades:

```bash
# Analisar o arquivo completo de demonstração
./analisador tests/arquivo_fonte.txt

# Ver apenas os primeiros 20 tokens
./analisador tests/arquivo_fonte.txt | head -20

# Ver apenas os erros léxicos detectados
./analisador tests/arquivo_fonte.txt | grep "ERRO"
```

**O arquivo `tests/arquivo_fonte.txt` contém:**
- ✅ Todas as palavras-chave (`siu`, `autre`, `mbappe`, `dembele`, etc.)
- ✅ Todos os operadores (`+`, `-`, `X`, `/`, `Ʌ`, `V`, `::`, `ney:`, etc.)
- ✅ Números inteiros e decimais (`42`, `3.14159`)
- ✅ Strings (`"texto"`, `"nome completo"`)
- ✅ Identificadores válidos (`variavel`, `camelCase`, `snake_case`)
- ✅ Comentários de linha e bloco
- ✅ Estruturas de controle completas
- ⚠️ Caracteres inválidos para demonstrar detecção de erros

## Testando Diferentes Cenários

```bash
# Teste básico automático
make test

# Teste com arquivo completo
make test-full

# Teste personalizado
echo 'siu (nome :: "João") { retour verdadeiro; }' | ./analisador /dev/stdin

# Teste de erro
echo 'variavel @ erro #' | ./analisador /dev/stdin
```

## Funcionalidades Principais

- **Reconhecimento de 12 palavras-chave** (siu, autre, mbappe, dembele, etc.)
- **11 operadores diferentes** (aritméticos, relacionais, lógicos)
- **Suporte a números** (inteiros e decimais)
- **Strings literais** com aspas duplas
- **Identificadores** (excluindo V e X como caracteres iniciais)
- **Comentários** de linha (`//`) e bloco (`/* */`)
- **Detecção de erros** léxicos com localização por linha
- **Contagem precisa de linhas**

## Sobre

Este projeto implementa um analisador léxico para uma linguagem que combina elementos de francês e português, desenvolvido como parte de estudos em compiladores. A linguagem inclui construções modernas e uma sintaxe única para demonstrar os conceitos de análise léxica.
