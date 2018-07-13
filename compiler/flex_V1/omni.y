%{
#include <cstdio>
#include <iostream>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union {
	int ival;
	float fval;
	char* sval;
	char* osym; // omny symbol
}

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING
%token <osym> OMNISYMBOL

%%
// this is the actual grammar that bison will parse, but for right now it's just
// something silly to echo to the screen what bison gets from flex.  We'll
// make a real one shortly:
//omni:
//	INT omni          { cout << "bison found an int  : " << $1 << endl; }
//	| FLOAT omni      { cout << "bison found a float : " << $1 << endl; }
//	| STRING omni     { cout << "bison found a string: " << $1 << endl; }
//	| INT             { cout << "bison found an int  : " << $1 << endl; }
//	| FLOAT           { cout << "bison found a float : " << $1 << endl; }
//	| STRING          { cout << "bison found a string: " << $1 << endl; }
//	| OMNISYMBOL omni {cout << "bison found an omny symlol: " << $1 << endl;}
//	;
omni:
	package | imports | statements | class;
package:
	PACKAGESYMBOL packagedeclaration {cout << "bison found a package; " << $1 << endl; }
imports:
  imports | import;
import:
IMPORTSYMBOL importdeclaration {cout << "found import declaration; " << $1 << endl;}
packagedeclaration:
	STRING (DOT STRING)* SEMICOLON   ;

%%

main() {
	// open a file handle to a particular file:
	FILE *myfile = fopen("test.omni", "r");
	// make sure it is valid:
	if (!myfile) {
		cout << "I can't open file test.omni!" << endl;
		return -1;
	}
	// set flex to read from it instead of defaulting to STDIN:
	yyin = myfile;
	
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));
	
}

void yyerror(const char *s) {
	cout << "EEK, parse error!  Message: " << s << endl;
	// might as well halt now:
	//exit(-1);
}

