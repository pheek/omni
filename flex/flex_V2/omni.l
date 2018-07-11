/** phi@gress.ly 2017                                    **/
/** parser for the didactical omni programming language. **/
%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()
int linenum      = 1;
int commentDepth = 0;

void msg(string val) {
  if(commentDepth > 0) {
   cout << "<<in comment (dept: " << commentDepth << ")>>" << endl;
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
[\n]                              {++linenum; msg("NEWLINE");}
[\/]{2}.*[\n]                     {/*msg("endln comment"  );*/ msg("NEWLINE"); linenum++; }
"/*"                              {/*msg("comment started");*/ commentDepth++; }
"*/"                              {/*msg("comment ended  ");*/ commentDepth--; }

[\t]                              { msg("TAB_INDENT"                   ); }

package|imports|class|AND|OR|NOT  { msg("RESERVED WORD"                ); }

[0-9]+\.[0-9]+([eE][+-]?[0-9]+)?  { msg("floating point"               ); }
[0-9]+                            { msg("integer"                      ); }
\"([^\"]|(\\\"))*\"               { msg("string containing appos"      ); }
[a-zA-Z][a-zA-Z0-9]*              { msg("identifier"                   ); }
:                                 { msg("declaration symbol"           ); }
;                                 { msg("for-statement delimiter"      ); }

"\→"|(=:)                         { msg("assignment-to-right operator" ); }
"\←"|(:=)                         { msg("assignment-to-left operator"  ); }

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
	yylex();
}
