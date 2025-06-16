# compilador de guerra
WARCODE - Lenguaje de Programación Militar
------------------------------------------

Este proyecto consiste en la creación de un lenguaje de programación personalizado llamado WARCODE. Es un lenguaje inspirado en comandos militares, donde se pueden crear pelotones, disparar, ejecutar misiones, usar condicionales y manejar el flujo de un campo de batalla simulado.

Fue desarrollado utilizando dos herramientas principales:
- Flex: para el análisis léxico.
- Bison: para el análisis sintáctico.

También se utiliza gcc para compilar el programa en C.

------------------------------------------------------------
CÓMO SE CREÓ EL COMPILADOR
------------------------------------------------------------

1. Se escribió el archivo 'warcode.l' con las reglas léxicas. Aquí se identifican las palabras clave del lenguaje como "peloton", "disparo", "mision", "si", "entonces", etc., así como también números, operadores y nombres de identificadores.

2. Se escribió el archivo 'warcode.y' con la gramática del lenguaje. Aquí se define cómo deben estar estructuradas las instrucciones y se asociaron acciones a cada regla para que se imprimieran mensajes cuando se reconocen comandos del lenguaje.

3. Para compilar, se usaron los siguientes comandos en terminal:

    flex warcode.l
    bison -d warcode.y
    gcc lex.yy.c warcode.tab.c -o warcode.exe

Esto genera el ejecutable 'warcode.exe' que interpreta el código escrito en WARCODE.

------------------------------------------------------------
CÓMO SE USA EL COMPILADOR
------------------------------------------------------------

Una vez que está compilado, se puede ejecutar de la siguiente forma:

    ./warcode.exe < test.txt

El archivo 'test.txt' debe contener el código escrito en el lenguaje WARCODE.

Cuando se ejecuta, el programa lee el archivo, interpreta las instrucciones y muestra en consola los resultados o mensajes militares correspondientes.

------------------------------------------------------------
CÓMO PROGRAMAR EN WARCODE
------------------------------------------------------------

A continuación se explica cómo escribir código en WARCODE con ejemplos.

------------------------------------------------------------
1. CREAR UN PELOTÓN
------------------------------------------------------------

Sintaxis:

    peloton nombre_peloton {
        disparo objetivo;
    }

Ejemplo:

    peloton alfa {
        disparo enemigo;
    }

Resultado:

    ¡DISPARANDO ORDEN A enemigo!
    ¡SE HA FORMADO EL PELOTON alfa!

------------------------------------------------------------
2. DEFINIR UNA MISIÓN (FUNCIONES)
------------------------------------------------------------

Sintaxis:

    mision nombre(param1, param2) {
        // instrucciones
    }

Ejemplo:

    mision ataque(x, y) {
        si x > y entonces {
            disparo refuerzo;
        } sino {
            disparo retirada;
        }
    }

Resultado al definir:

    ¡SE HA DEFINIDO LA MISION ataque!

------------------------------------------------------------
3. LLAMAR A UNA MISIÓN
------------------------------------------------------------

Sintaxis:

    nombre_mision(valor1, valor2);

Ejemplo:

    ataque(10, 5);

Resultado:

    ¡EJECUTANDO MISION ataque CON PARAMETROS: 10, 5!
    ¡DISPARANDO ORDEN A refuerzo!

------------------------------------------------------------
4. CONDICIONALES
------------------------------------------------------------

Sintaxis:

    si condicion entonces {
        // instrucciones
    } sino {
        // instrucciones
    }

Operadores válidos:
    ==, !=, >, <, >=, <=

Ejemplo dentro de una misión:

    si x == y entonces {
        disparo empate;
    } sino {
        disparo continuar;
    }

------------------------------------------------------------
5. OPERACIONES MATEMÁTICAS
------------------------------------------------------------

Puedes usar +, -, *, / en las expresiones condicionales o dentro de funciones.

Ejemplo:

    si (x + 2) > (y * 3) entonces {
        disparo ganar;
    }

------------------------------------------------------------
EJEMPLO COMPLETO DE UN PROGRAMA EN WARCODE
------------------------------------------------------------

    peloton bravo {
        disparo enemigo;
    }

    mision ataque(x, y) {
        si x > y entonces {
            disparo refuerzo;
        } sino {
            disparo retirada;
        }
    }

    ataque(10, 5);

Salida esperada:

    ¡DISPARANDO ORDEN A enemigo!
    ¡SE HA FORMADO EL PELOTON bravo!
    ¡SE HA DEFINIDO LA MISION ataque!
    ¡EJECUTANDO MISION ataque CON PARAMETROS: 10, 5!
    ¡DISPARANDO ORDEN A refuerzo!

------------------------------------------------------------
ARCHIVOS INCLUIDOS
------------------------------------------------------------

- warcode.l       -> Reglas léxicas
- warcode.y       -> Gramática y acciones semánticas
- test.txt        -> Código de prueba en WARCODE
- warcode.exe     -> Ejecutable del compilador
- README.txt      -> Este documento

------------------------------------------------------------
AUTOR
------------------------------------------------------------

Monserrat Scarletthe Aravena Mattamala  
Juan Javier Contreras Ramirez
Taller de Compiladores - Año 2025  primer semestre
