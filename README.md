# Analisador Léxico - Compilador

Um analisador léxico implementado em Flex/Lex para uma linguagem de programação personalizada.

## 🚀 Quick Start

```bash
# Verificar dependências
make check-deps

# Compilar
make

# Testar
make test
```

## 📁 Estrutura do Projeto

```
.
├── Makefile              # Sistema de build
├── README.md            # Este arquivo
├── src/
│   ├── analisador.l     # Código fonte do analisador léxico
│   └── lex.yy.c         # Código C gerado pelo flex (gerado automaticamente)
├── docs/
│   ├── MANUAL.md        # Manual completo do usuário
│   └── linguagem_regular.md
├── tests/
│   ├── teste_completo.txt
│   └── exemplo_completo.txt
└── analisador           # Executável (gerado após compilação)
```

## 🔧 Comandos Principais

| Comando | Descrição |
|---------|-----------|
| `make` | Compila o projeto |
| `make test` | Executa teste básico |
| `make clean` | Limpa arquivos gerados |
| `make help` | Mostra todos os comandos |

## 📖 Documentação

Para instruções detalhadas, consulte o [Manual do Usuário](docs/MANUAL.md).

## 🛠️ Dependências

- `flex` - Gerador de analisadores léxicos
- `gcc` - Compilador C

```bash
# Ubuntu/Debian
sudo apt-get install flex gcc
```

## 🎯 Exemplo de Uso

```bash
echo 'siu (x : 42) faire' > teste.txt
./analisador teste.txt
```

**Saída:**
```
LINHA 1: KEYWORD_IF -> 'siu'
LINHA 1: DELIM_ABRE_PARENTESES -> '('
LINHA 1: IDENTIFICADOR -> 'x'
LINHA 1: OP_ATRIB -> ':'
LINHA 1: NUMERO_INT -> 42
LINHA 1: DELIM_FECHA_PARENTESES -> ')'
LINHA 1: KEYWORD_DO -> 'faire'
```

## 🎓 Sobre

Este projeto implementa um analisador léxico para uma linguagem que combina elementos de francês e português, desenvolvido como parte de estudos em compiladores.
