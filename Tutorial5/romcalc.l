%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "romcalc.tab.h"
  
  void yyerror();
  int yylex();
%}

%%
"I" { return I; }
"IV"  { return IV; }
"V"  { return V; }
"IX" { return IX; }
"X" { return X; }
"XL"  { return XL; }
"L" { return L; }
"XC" { return XC; }
"C" { return C; }
"CD" { return CD; }
"D" { return D; }
"CM" { return CM; }
"M" { return M; }
"\n" { return EOL; }

"+"	{ return ADD; }
"-"	{ return SUB; }
"/" { return DIV; }
"*"	{ return MUL; }

"{"	{ return OP; }
"}" { return CP; }
[	\s\r\t ]*	;

.	{ yyerror(); }

%%


