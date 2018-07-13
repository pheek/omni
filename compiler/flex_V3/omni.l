/** phi@gress.ly 2017                                    **/
/** parser for the didactical omni programming language. **/
%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()

string yylval;

enum yytokentype {
	NEWLINE_TOKEN  = 258,
	INDENT_TAB     = 259,
	RESERVED_WORD  = 260,
	NUMBER_REAL    = 261,
	NUMBER_INT     = 262,
	IDENTIFIER     = 263,
	STRING         = 264,
	DECLARE_SYMBOL = 265,
	FOR_DELIMITER  = 266,
	ASSIGN_LTR     = 267,
	ASSIGN_RTL     = 268
};


int linenum      = 1;
int commentDepth = 0;

int msg(string val, int tokentype) {
  yylval = yytext; // numbers and identifiers are only text here
  if(commentDepth > 0) {
   cout << "<<in comment (dept: " << commentDepth << ")>>" << endl;
   return tokentype;
  } 
  if(commentDepth < 0) {
   cout << linenum << ". " << " ERROR CLOSING COMMENT OUTSIDE A COMMENT! " << endl;
   return tokentype;
}
  if(0==strcmp("newline++", val.c_str())) {
cout << (linenum-1) << ". Found " << val << ": (Tokentype:"<< tokentype<<")" << yytext << endl;
} else {
cout << (linenum) << ". Found " << val << ": (Tokentype:"<< tokentype<<")" << yytext << endl;
}
  return tokentype;
}

int msg(string val) {
  return msg(val, 0);
}

%}
%%
[\n]                              {++linenum; return msg("newline++", NEWLINE_TOKEN);}
[\/]{2}.*[\n]                     {/*msg("endln comment"  );*/ msg("newline comment", NEWLINE_TOKEN); linenum++; return NEWLINE_TOKEN;}
"/*"                              {/*msg("comment started");*/ commentDepth++; }
"*/"                              {/*msg("comment ended  ");*/ commentDepth--; }

[\t]                              { return msg("TAB_INDENT"                  , INDENT_TAB    ); }

[0-9]+\.[0-9]+([eE][+-]?[0-9]+)?  { return msg("floating point"              , NUMBER_REAL   ); }
[0-9]+                            { return msg("integer"                     , NUMBER_INT    ); }
\"([^\"]|(\\\"))*\"               { return msg("string containing appos"     , STRING        ); }
[a-zA-Z][a-zA-Z0-9]*              { return msg("identifier"                  , IDENTIFIER    ); }
:                                 { return msg("declaration symbol"          , DECLARE_SYMBOL); }
;                                 { return msg("for-statement delimiter"     , FOR_DELIMITER ); }

"\→"|(=:)                         { return msg("assignment-to-right operator", ASSIGN_LTR    ); }
"\←"|(:=)                         { return msg("assignment-to-left operator" , ASSIGN_RTL    ); }

≤|<=                              { msg("less/equal then comparator"   ); }
≥|>=                              { msg("greater/equal comparator"     ); }
\<                                { msg("less-than comparator"         ); }
\>                                { msg("greater-than comparator "     ); }
=                                 { msg("equals comparator"            ); }
≠|!=                              { msg("not-equal comparator"         ); }

[](){}]                           { msg("parantheses: "                ); }
\+\+                              { msg("Plusplus Statement"           ); } 
--                                { msg("MinusMinus Statement"         ); } 
[+\-*/]                           { msg("aritmetic operator"           ); }
\&                                { msg("ampersand string concatenator"); }
[|!\&]                            { msg("logical operator"             ); }
[@#%\^?\\]                        { msg("reserved symbol"              ); }
%%
main() {
	// lex through the input:
  //yylex();
int tok;

  while(tok = yylex()) {
    printf("(token:%d)", tok);
    if(tok == IDENTIFIER || tok == NUMBER_INT || tok == NUMBER_REAL) printf(" = %s\n", yylval.c_str());
    else printf("\n");
  }
}
