#!/bin/bash

echo "Generando archivos con bison..."
bison -d warcode.y

echo "Generando archivos con flex..."
flex warcode.l

echo "Compilando el ejecutable..."
gcc warcode.tab.c lex.yy.c -o warcode.exe -lm

echo "¡Compilación finalizada!"
