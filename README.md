# ToroLang

ToroLang es un lenguaje interpretado minimalista implementado con Flex y Bison. Incluye soporte para variables, expresiones aritméticas, funciones definidas por el usuario, estructuras de control como bucles `while` (denominados `calefactor`), y salida por consola mediante `zapatilla`.

## Características del lenguaje

- Variables con nombres de una sola letra (`a`, `b`, etc.)
- Operaciones aritméticas: `+`, `-`, `*`, `/`
- Comparación `>` utilizada en bucles
- Salida de valores con `zapatilla`
- Declaración de funciones con `toromax`
- Retorno de valores con `return`
- Llamadas a funciones con un único parámetro

## Ejemplo de código

```c
toromax cuadrado(x) {
  return x * x;
}

a = 3;
zapatilla cuadrado(a);
Salida esperada:


9
Compilación
Se requiere flex, bison y un compilador C (como gcc).


bison -d calc.y
flex calc.l
gcc calc.tab.c lex.yy.c -o calc
Uso
El programa se ejecuta redireccionando un archivo de entrada que contenga código en ToroLang:


./calc < archivo.txt
Palabras clave
Palabra clave	Significado
zapatilla	Imprime el valor de una variable
calefactor	Bucle while
toromax	Declaración de función
return	Retorna un valor desde una función

Gramática soportada (simplificada)

programa       → instrucciones
instrucciones  → instruccion | instrucciones instruccion
instruccion    → ID = expresion ;
               | zapatilla ID ;
               | calefactor condicion { instrucciones }
               | toromax ID ( ID ) { instrucciones }
               | return expresion ;
               | ID ( expresion ) ;

expresion      → NUM | ID | expresion op expresion | ID ( expresion )
condicion      → expresion > expresion
Limitaciones
Solo se permiten variables de una sola letra

No hay manejo de errores semánticos complejos

Solo se admite un parámetro por función

Las condiciones de los bucles están limitadas a >

No se maneja división por cero de forma detallada

Archivos del proyecto
calc.l: Archivo de definición del lexer (Flex)

calc.y: Archivo de gramática y semántica (Bison)

test.txt: Archivo de pruebas con ejemplos en ToroLang

README.md: Documento actual


toromax factorial(n) {
  calefactor n > 1 {
    n = n * factorial(n - 1);
    return n;
  }
  return 1;
}

zapatilla factorial(5);
Salida esperada:


120
Autor
Monserratt Scarletthe Avena Mattamala
Juan Javier Contreras Ramirez
Desarrollado como un proyecto de lenguaje interpretado basado en Flex y Bison.Taller de Compiladores - Año 2025  primer semestre
