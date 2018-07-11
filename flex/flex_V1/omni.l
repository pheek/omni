%{
#include <iostream>
using namespace std;

#define YYSTYPE int
extern YYSTYPE yyltype


#define YY_DECL extern "C" int yylex()
#include "omni.tab.h"  // to get the token types that we return

%}
%%
[ \t]           ;
\n              { cout << "Found end of line." << endl ;}
\/\*            { cout << "Found comment start: "            << yytext << endl; }
\/\/            { cout << "Found eol comment: "              << yytext << endl; }
\*\/            { cout << "Found comment end: "              << yytext << endl; }
\.              { cout << "Found delegation/package Dot. " << endl; }
[0-9]+\.[0-9]+  { cout << "Found a floating-point number: "  << yytext << endl;
                  yylval.fval = atoi(yytext);
                  return FLOAT; }

[0-9]+          { cout << "Found an integer: "               << yytext << endl;
                  yylval.ival = atoi(yytext); 
                  return INT;  }

(package)|(import)|(class) {
                  cout << "Found class keyword: " << yytext << endl; 
                  yylval.osym = strdup(yytext);
                  return OMNISYMBOL;}

(for)|(if)|(else)|(while) { 
                  cout << "Found controll-flow keyword: " << yytext << endl;
                  yylval.osym = strdup(yytext);
                  return OMNISYMBOL; }

(Uint8)|(Sint8)|(Uint16)|(Sint16)|(Uint32)|(Sint32)|(Uint64)|(Sint64) {
                  cout << "Found an integer type: "  << yytext << endl;
                  yylval.osym = strdup(yytext);
                  return OMNISYMBOL;}
                  
[A-Z_][_a-zA-Z0-9]*       { cout << "Found a class name : "  << yytext << endl; }
[a-zA-Z_][_a-zA-Z0-9]*    { cout << "Found an identifier: "  << yytext << endl; 
                            yylval.sval = strdup(yytext); 
                            return STRING;}

←                      { cout << "Found assignement operator: "              << yytext << endl; }
:=              { cout << "Found assignement symbol: "              << yytext << endl; }
\;              { cout << "Found statement delimiter: "      << yytext << endl; }
[\*\+\-\/]      { cout << "Found an arithmetical operator: " << yytext << endl; }
[\(\){}\[\]]    { cout << "Found paren: "                    << yytext << endl; }
[<>=≠≤≥]        { cout << "Found comparison operator: "      << yytext << endl; }

%%
/*
main() {
	// lex through the input:
	yylex();
}
  */
