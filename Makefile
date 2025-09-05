# Makefile para o Analisador Léxico
# Projeto: Compilador com Flex/Lex
# Autor: Desenvolvido em VS Code

# Variáveis
LEX_SOURCE = src/analisador.l
LEX_OUTPUT = src/lex.yy.c
EXECUTABLE = analisador
CC = gcc
CFLAGS = -Wall -Wextra -std=c99
LIBS = -lfl

# Diretórios
SRC_DIR = src
TESTS_DIR = tests
DOCS_DIR = docs

# Arquivos de teste
TEST_FILE = $(TESTS_DIR)/teste_completo.txt
SIMPLE_TEST = teste_simples.txt

# Regra principal (padrão)
all: $(EXECUTABLE)

# Compilação do executável
$(EXECUTABLE): $(LEX_OUTPUT)
	@echo "Compilando o analisador léxico..."
	$(CC) $(CFLAGS) $(LEX_OUTPUT) $(LIBS) -o $(EXECUTABLE)
	@echo "Compilação concluída: $(EXECUTABLE)"

# Geração do código C a partir do arquivo .l
$(LEX_OUTPUT): $(LEX_SOURCE)
	@echo "Gerando código C com flex..."
	flex -o $(LEX_OUTPUT) $(LEX_SOURCE)
	@echo "Arquivo $(LEX_OUTPUT) gerado com sucesso"

# Instalação (copia para /usr/local/bin)
install: $(EXECUTABLE)
	@echo "Instalando $(EXECUTABLE) em /usr/local/bin..."
	sudo cp $(EXECUTABLE) /usr/local/bin/
	@echo "Instalação concluída"

# Teste básico
test: $(EXECUTABLE)
	@echo "Executando teste básico..."
	@echo 'siu (teste : 123) faire' > $(SIMPLE_TEST)
	@echo "Conteúdo do arquivo de teste:"
	@cat $(SIMPLE_TEST)
	@echo "\nSaída do analisador:"
	./$(EXECUTABLE) $(SIMPLE_TEST)
	@rm -f $(SIMPLE_TEST)

# Teste completo (se existir arquivo de teste)
test-full: $(EXECUTABLE)
	@if [ -f $(TEST_FILE) ] && [ -s $(TEST_FILE) ]; then \
		echo "Executando teste completo..."; \
		./$(EXECUTABLE) $(TEST_FILE); \
	else \
		echo "Arquivo de teste $(TEST_FILE) não existe ou está vazio"; \
		echo "Execute 'make test' para um teste básico"; \
	fi

# Limpeza de arquivos gerados
clean:
	@echo "Limpando arquivos gerados..."
	rm -f $(LEX_OUTPUT) $(EXECUTABLE) $(SIMPLE_TEST)
	@echo "Limpeza concluída"

# Limpeza completa (incluindo backups)
distclean: clean
	@echo "Limpeza completa..."
	rm -f *~ $(SRC_DIR)/*~ $(TESTS_DIR)/*~ $(DOCS_DIR)/*~
	@echo "Limpeza completa concluída"

# Reconstrução completa
rebuild: clean all

# Verificar dependências
check-deps:
	@echo "Verificando dependências..."
	@which flex > /dev/null || (echo "ERRO: flex não encontrado. Instale com: sudo apt-get install flex" && exit 1)
	@which gcc > /dev/null || (echo "ERRO: gcc não encontrado. Instale com: sudo apt-get install gcc" && exit 1)
	@echo "Todas as dependências estão instaladas"

# Informações sobre o projeto
info:
	@echo "=== Informações do Projeto ==="
	@echo "Nome: Analisador Léxico"
	@echo "Arquivo fonte: $(LEX_SOURCE)"
	@echo "Executável: $(EXECUTABLE)"
	@echo "Compilador: $(CC)"
	@echo "Flags: $(CFLAGS)"
	@echo "Bibliotecas: $(LIBS)"
	@echo ""
	@echo "Comandos disponíveis:"
	@echo "  make          - Compila o projeto"
	@echo "  make test     - Executa teste básico"
	@echo "  make test-full- Executa teste completo"
	@echo "  make clean    - Remove arquivos gerados"
	@echo "  make rebuild  - Recompila do zero"
	@echo "  make install  - Instala no sistema"
	@echo "  make check-deps - Verifica dependências"

# Debug: mostra variáveis
debug:
	@echo "LEX_SOURCE = $(LEX_SOURCE)"
	@echo "LEX_OUTPUT = $(LEX_OUTPUT)"
	@echo "EXECUTABLE = $(EXECUTABLE)"
	@echo "CC = $(CC)"
	@echo "CFLAGS = $(CFLAGS)"
	@echo "LIBS = $(LIBS)"

# Regras que não são arquivos
.PHONY: all clean distclean rebuild test test-full install check-deps info debug

# Ajuda
help: info
