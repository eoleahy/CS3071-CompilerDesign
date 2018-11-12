%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex();
int yyparse();
void yyerror();
void numToRoman(int num);

%}

/* delcare tokens */
%token I IV V IX X XL L XC C CD D CM M 
%token ADD SUB MUL DIV 
%token OP CP
%token EOL

%%

calclist: /*none*/
 | calclist exp EOL { numToRoman($2); }

exp: factor 
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: term 
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;
term: NUMBER
 | OP exp CP { $$ = $2; }
 ;
 
NUMBER: thousand;

thousand: M { $$ = 1000; }
 | CM { $$ = $1 + 900; }
 | CM fifty { $$ = $2 + $1 + 900; }
 | M thousand { $$ = $2 + 1000; }
 | fivehundred;
 ;
 
fivehundred: D { $$ = 500; }
 | CD { $$ = $1 + 400; }
 | CD fifty { $$ = $2 + $1 + 400; }
 | D hundred { $$ = $2 + 500; }
 | hundred;
 ;
	
hundred: C { $$ = 100; }
 | XC { $$ = $1 + 90; }
 | C hundred { $$ = $2 + 100; }
 | fifty;
 ;
	
fifty: L { $$ = 50; }
 | XL { $$ = $1 + 40; }
 | XL five { $$ = $2 + $1 + 40; }
 | XC ten { $$ = $2 + $1 + 90; }
 | L ten { $$ = $2 + 50; }
 | ten;
 ;	 
 
ten: X { $$ = 10; }
 | IX { $$ = $1 + 9; }
 | X ten { $$ = $2 + 10; }
 | five;
 ;
 
five: V { $$ = 5; }
 | IV { $$ = $1 + 4; }
 | V one { $$ = $2 + 5; }
 | one;
 ;
 
one: I  { $$ = 1; }
 | I one { $$ = $2 + 1; }	
 ;
;
%%

void yyerror()
{
	printf("syntax error\n");
	exit(0);
}

/*
	Takes in an integer in decimal notations and prints
	a string of the Roman numeral represenation.
*/
void numToRoman(int number){
	
	char roman[256];
	memset(roman,0,sizeof(roman));
	
	if(number == 0)
		strcat(roman,"Z");
	
	if(number < 0){
		strcat(roman,"-");
		number *= -1;
	}
	
	while(number > 0)
	{
		if((number / 1000) > 0 ){ strcat(roman, "M"); number -=1000; }
		
		else if((number / 900) > 0){ strcat(roman, "CM"); number -=900; }
		
		else if((number / 500) > 0){ strcat(roman, "D"); number -=500; }
		
		else if((number / 400) > 0){ strcat(roman, "CD"); number -=400; }
		
		else if((number / 100) > 0){ strcat(roman, "C"); number -=100; }
		
		else if((number / 90) > 0){ strcat(roman, "XC"); number -=90; }
		
		else if((number / 50) > 0){ strcat(roman, "L"); number -=50; }
		
		else if((number / 40) > 0){ strcat(roman, "XL"); number -=40; }
		
		else if((number/ 10) > 0){ strcat(roman, "X"); number -=10; }
		
		else if((number / 9) > 0){ strcat(roman, "IX"); number -=9; }
		
		else if((number / 5) > 0){ strcat(roman, "V"); number -=5; }
		
		else if((number / 4) > 0){ strcat(roman, "IV"); number -=4; }
		
		else{ strcat(roman, "I"); number -=1; }
	}
	
	printf("%s\n",roman);
	memset(roman,0,sizeof(roman));
}


int main()
{
  yyparse();
  return 0;
}
