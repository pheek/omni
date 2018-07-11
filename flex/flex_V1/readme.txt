1;4402;0cVorab: bison und flex installieren (apt-get install flex bison)

"flexen" mit
>flex omni.l

kompilieren mit:
>g++ lex.yy.c -lfl -o omni

starten mit
>./omni <test.omni
