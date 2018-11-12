

%{
#include<stdio.h>
int com=0;
int bracket=0;
%}

%%

\*\*.* ;
(.*\s)*\{	;{printf("multiline 1");bracket++;}
\}		;	{printf("multiline 2"); bracket--;}
\{{1}(.*\s)*.*\}{1} {com++;}
(.+\s)		{if(bracket==1)printf("shouldnt");}
%%

main()
{

	yylex();
	printf("%i", bracket);
	return 0;
}

