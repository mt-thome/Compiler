%{
    #include <stdio.h>
    #include <stdlib.h>

    int line_count=1;
%}

DIGITO [0-9]
PRIMEIRA_LETRA [a-zA-UWY-Z]
LETRA [a-zA-Z]
ID {PRIMEIRA_LETRA}({LETRA}|{DIGITO}|_)*
INT {DIGITO}+
FLOAT {DIGITO}+"."{DIGITO}+

%%

"siu"           {printf("LINHA %d: KEYWORD_IF -> '%s'\n", line_count, yytext); }
"autre"         {printf("LINHA %d: KEYWORD_ELSE -> '%s'\n", line_count, yytext); }
"sinon siu"     {printf("LINHA %d: KEYWORD_ELIF -> '%s'\n", line_count, yytext); }
"changer"       {printf("LINHA %d: KEYWORD_SWITCH -> '%s'\n", line_count, yytext); }
"cas"           {printf("LINHA %d: KEYWORD_CASE -> '%s'\n", line_count, yytext); }
"defaut"        {printf("LINHA %d: KEYWORD_DEFAULT -> '%s'\n", line_count, yytext); }
"casser"        {printf("LINHA %d: KEYWORD_BREAK -> '%s'\n", line_count, yytext); }
"continuer"     {printf("LINHA %d: KEYWORD_CONTINUE -> '%s'\n", line_count, yytext); }
"retour"        {printf("LINHA %d: KEYWORD_RETURN -> '%s'\n", line_count, yytext); }
"faire"         {printf("LINHA %d: KEYWORD_DO -> '%s'\n", line_count, yytext); }
"while"         {printf("LINHA %d: KEYWORD_WHILE -> '%s'\n", line_count, yytext); }
"for"           {printf("LINHA %d: KEYWORD_FOR -> '%s'\n", line_count, yytext); }

{ID}    {printf("LINHA %d: IDENTIFICADOR -> '%s'\n", line_count, yytext); }

{FLOAT} {printf("LINHA %d: NUMERO_FLOAT -> %s\n", line_count, yytext); }
{INT}   {printf("LINHA %d: NUMERO_INT -> %s\n", line_count, yytext); }

"+"     {printf("LINHA %d: OP_SOMA -> '%s'\n", line_count, yytext); }
"-"     {printf("LINHA %d: OP_SUB -> '%s'\n", line_count, yytext); }
"X"     {printf("LINHA %d: OP_MULT -> '%s'\n", line_count, yytext); }
"/"     {printf("LINHA %d: OP_DIV -> '%s'\n", line_count, yytext); }
":"     {printf("LINHA %d: OP_ATRIB -> '%s'\n", line_count, yytext); }
"Ʌ"     {printf("LINHA %d: OP_MENOR -> '%s'\n", line_count, yytext); }
"V"     {printf("LINHA %d: OP_MAIOR -> '%s'\n", line_count, yytext); }
"V/"    {printf("LINHA %d: OP_MENOR_IGUAL -> '%s'\n", line_count, yytext); }
"::"    {printf("LINHA %d: OP_IGUAL -> '%s'\n", line_count, yytext); }
"ney:"  {printf("LINHA %d: OP_DIFERENTE -> '%s'\n", line_count, yytext); }
"ney"   {printf("LINHA %d: NEGAÇÂO -> '%s'\n", line_count, yytext); }

";"             { printf("LINHA %d: DELIM_PONTO_VIRGULA -> '%s'\n", line_count, yytext); }
","             { printf("LINHA %d: DELIM_VIRGULA -> '%s'\n", line_count, yytext); }
"("             { printf("LINHA %d: DELIM_ABRE_PARENTESES -> '%s'\n", line_count, yytext); }
")"             { printf("LINHA %d: DELIM_FECHA_PARENTESES -> '%s'\n", line_count, yytext); }
"{"             { printf("LINHA %d: DELIM_ABRE_CHAVES -> '%s'\n", line_count, yytext); }
"}"             { printf("LINHA %d: DELIM_FECHA_CHAVES -> '%s'\n", line_count, yytext); }

"//".* { /* Ignora comentário de linha única */ }
"/*"([^*]|\*+[^*/])*\*+"*/" { /* Ignora comentário de múltiplas linhas */ }

[ \t\r]+        { /* Ignora espaços, tabs e carriage return */ }
\n              { line_count++; /* Incrementa o contador de linha */ }

.               { printf("LINHA %d: ERRO LÉXICO! Caractere desconhecido: '%s'\n", line_count, yytext); }

%%

int main(int argc, char *argv[]){
    if(argc < 2){
        printf("Uso: %s <arquivo de entrada>\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if(input_file == NULL){
        perror("Erro ao abrir o arquivo");
        return 1;
    }

    yyin = input_file;

    yylex();

    fclose(input_file);

    return 0;
}

int yywrap(){
    return 1;
}