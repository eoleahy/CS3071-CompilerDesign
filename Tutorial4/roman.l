%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "roman.tab.h"
  
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

[	\s\r\t ]*	;

.	{ yyerror(); }

%%


