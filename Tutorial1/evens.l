%{
int evens;
%}

%%

[0-9]+	{ if(atoi(yytext)%2==0) evens++;}


%%

int main()
{
  yylex();
  printf("%d\n", evens);
  return 0;
}
