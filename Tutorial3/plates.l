%{
	#include <string.h>
	const char *delim = "-";
	int currentYear = 18;
	int age;
	int lineInvalid = 0;
%}
NUMBER [0-9]{1,6}
COUNTY C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WH|WX|WW
YEAR [0-9]{2}
%%
[	\s\t ]*		{/* ignore whitespace */}
{YEAR}[12]?"-"{COUNTY}"-"{NUMBER}[	\s\t ]*"\n"	{/*printf("%s", yytext)*/; int year = atoi(yytext);
 										if((year>currentYear) && (year<100)) year = year-100;
 										if(year>100) year=year/10; age = currentYear-year; printf("%i\n", age);}	
\n		{lineInvalid = 0;}
.	  {lineInvalid++; if (lineInvalid == 1)printf("INVALID\n");}
%%

int main()
{
yylex();
return 0;
}

