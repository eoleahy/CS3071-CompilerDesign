%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyparse();
void yyerror();

%}

/* delcare tokens */
%token I IV V IX X XL L XC C CD D CM M 
%token EOL

%%	

	exp: num ;//EOL { $$ = $1; printf("%d\n", $$); }
	|  exp num ;//EOL { $$ = $1; printf("%d\n", $$); }
	;

	
num: thousand EOL { $$ = $1; printf("%d\n", $$); }

	one: I  { $$ = 1; }
	| I one { $$ = $2 + 1; }	
	;

	five: V { $$ = 5; }
	| IV { $$ = $1 + 4; }
	| V one { $$ = $2 + 5; }
	| one;
	;
	
	ten: X { $$ = 10; }
	| IX { $$ = $1 + 9; }
	| X ten { $$ = $2 + 10; }
	| five;
	;
	
	fifty: L { $$ = 50; }
	| XL { $$ = $1 + 40; }
    | XL five { $$ = $2 + $1 + 40; }
    | XC ten { $$ = $2 + $1 + 90; }
	| L ten { $$ = $2 + 50; }
	| ten;
	;
	
	hundred: C { $$ = 100; }
	| XC { $$ = $1 + 90; }
	| C hundred { $$ = $2 + 100; }
	| fifty;
	;
	
	fivehundred: D { $$ = 500; }
	| CD { $$ = $1 + 400; }
	| CD fifty { $$ = $2 + $1 + 400; }
	| D hundred { $$ = $2 + 500; }
	| hundred;
	;
	
	thousand: M { $$ = 1000; }
	| CM { $$ = $1 + 900; }
	| CM fifty { $$ = $2 + $1 + 900; }
	| M thousand { $$ = $2 + 1000; }
	| fivehundred;
	;

	;
%%

void yyerror()
{
	printf("syntax error\n");
	exit(0);
}

int main()
{
  yyparse();
  return 0;
}
