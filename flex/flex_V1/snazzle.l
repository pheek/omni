/** phi@gress.ly 2017                     **/
/** parser for omni programming language. **/
%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()
int linenum      = 0;
int commentDepth = 0;

void msg(string val) {
  if(commentDept0 > 0) {
    cout << linenum << ". " << "in comment " << endl;
    return;
  } 
  if(commentDepth < 0) {
   cout << linenum << ". " << " ERROR CLOSING COMMENT OUTSIDE A COMMENT! " << endl;
   return;
  }
  cout << linenum << ". Found " << val << ": " << yytext << endl; 
}

%}

%%
[\n]           {++linenum;}

"/*"                              {commentDepth++; cout << "comment start " << yytext << commentDepth << endl; }
"*/"                              {commentDepth--; cout << "comment end "   << yytext << commentDepth << endl; }
[ \t]           ;
[0-9]+\.[0-9]+([eE][+-]?[0-9]+)?  { msg("floating point"); }
\"([^\"]|(\\\"))*\"               { msg("string containing appos"); }
[0-9]+                            { mgs("integer");}
[a-zA-Z][a-zA-Z0-9]*              { mgs("identifier");}
"\→"|(=:)                         { msg("assignment-to-right operator"); }
"\←"|(:=)                         { cout << linenum << ". Found assignment-to-left operator: " << yytext <<endl; }
≤|<=                              { cout << linenum << ". Found less/equal then comparator: " << yytext << endl; }
≥|>=                              { cout << linenum << ". Found greater/equal comparator" << yytext << endl; }
\<                                { cout << linenum << ". Found less-than: " << yytext << endl; }
\>                                { cout << linenum << ". Found greater-than: " << yytext << endl; }
=                                 { cout << linenum << ". Found equals comparator: " << yytext << endl; }
≠|!=                              { cout << linenum << ". Found not-equal symbol: " << yytext << endl;}
\;                                { cout << linenum << ". Found statement delimiter: " << yytext <<endl; }
[](){}]                           { cout << linenum << ". Found parantheses: " << yytext << endl; }
[+\-*/]                           { cout << linenum << ". Found aritmetic operator: " << yytext << endl; }               
[|!\&]                            { cout << linenum << ". Found logical operator: " << yytext << endl; }
[@#%^?\\]                         { cout << linenum << ". Found reserved symbol: " << yytext << endl;}
%%
main() {
	// lex through the input:
	yylex();
}
