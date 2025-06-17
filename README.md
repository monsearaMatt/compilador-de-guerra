# Documentación del Lenguaje de Programación

## Introducción

Este es un lenguaje de programación personalizado que utiliza palabras clave en español inspiradas en electrodomésticos. El lenguaje está diseñado para ser intuitivo y fácil de aprender.

## Instalación y Uso

### Compilación
```bash
flex calc.l
bison -d calc.y
gcc -o calc lex.yy.c calc.tab.c -lfl
```

### Ejecución
```bash
./calc
# Escribir código línea por línea
# Presionar Ctrl+D para ejecutar
```

## Palabras Clave

| Palabra Clave | Función | Equivalente en otros lenguajes |
|---------------|---------|-------------------------------|
| `zapatilla` | Imprimir valores o texto | `print`, `cout`, `printf` |
| `teclado` | Leer entrada del usuario | `input`, `cin`, `scanf` |
| `calefactor` | Bucle while | `while` |
| `refrigerador` | Condicional if | `if` |
| `microondas` | Else | `else` |
| `licuadora` | Else if | `else if` |
| `toromax` | Definir función | `function`, `def` |
| `return` | Retornar valor | `return` |

## Sintaxis Básica

### Variables y Asignación
```
variable = valor;
nombre = teclado;
edad = 25;
```

### Operadores Aritméticos
- `+` : Suma
- `-` : Resta
- `*` : Multiplicación
- `/` : División

### Operadores de Comparación
- `==` : Igual a
- `!=` : Diferente de
- `<` : Menor que
- `>` : Mayor que
- `<=` : Menor o igual que
- `>=` : Mayor o igual que

### Comentarios
El lenguaje actualmente no soporta comentarios.

## Estructuras de Control

### Imprimir (zapatilla)
```
zapatilla valor;
zapatilla "Texto entre comillas";
```

### Entrada de Usuario (teclado)
```
numero = teclado;
```
El usuario puede ingresar:
- Números simples: `5`, `10`, `-3`
- Expresiones matemáticas: `5+3`, `10*2`, `15/3`

### Condicionales (refrigerador/microondas/licuadora)
```
refrigerador condicion {
    # código si verdadero
} microondas {
    # código si falso
}
```

```
refrigerador edad >= 18 {
    zapatilla "Mayor de edad";
} licuadora edad >= 13 {
    zapatilla "Adolescente";
} microondas {
    zapatilla "Niño";
}
```

### Bucles (calefactor)
```
calefactor condicion {
    # código a repetir
}
```

### Funciones (toromax)
```
toromax nombre_funcion(parametro) {
    # código de la función
    return valor;
}
```

## Tipos de Datos

### Números Enteros
```
x = 42;
y = -10;
```

### Cadenas de Texto
```
mensaje = "Hola mundo";
zapatilla "Texto directo";
```

### Variables
```
nombre = valor;
resultado = operacion;
```

## Ejemplos Prácticos

### Ejemplo 1: Calculadora Básica
```
zapatilla "=== CALCULADORA ===";
zapatilla "Primer número:";
a = teclado;
zapatilla "Segundo número:";
b = teclado;
suma = a + b;
zapatilla "La suma es:";
zapatilla suma;
```

### Ejemplo 2: Verificar Edad
```
zapatilla "Ingrese su edad:";
edad = teclado;
refrigerador edad >= 18 {
    zapatilla "Puede votar";
} microondas {
    zapatilla "No puede votar";
}
```

### Ejemplo 3: Contador
```
i = 1;
calefactor i <= 5 {
    zapatilla i;
    i = i + 1;
}
```

### Ejemplo 4: Función Simple
```
toromax cuadrado(numero) {
    resultado = numero * numero;
    return resultado;
}

x = teclado;
y = cuadrado(x);
zapatilla "El cuadrado es:";
zapatilla y;
```

### Ejemplo 5: Tabla de Multiplicar
```
zapatilla "¿Qué tabla quieres?";
tabla = teclado;
i = 1;
calefactor i <= 10 {
    resultado = tabla * i;
    zapatilla tabla;
    zapatilla " x ";
    zapatilla i;
    zapatilla " = ";
    zapatilla resultado;
    i = i + 1;
}
```

## Características Especiales

### Entrada Inteligente
Cuando uses `teclado`, puedes ingresar:
- **Números simples**: `5`, `10`, `-3`
- **Expresiones matemáticas**: `5+3*2`, `(10+5)/3`

### Manejo de Errores
- División por cero retorna 0
- Variables no definidas retornan 0
- Expresiones inválidas muestran mensaje de error

## Limitaciones Actuales

1. **Solo números enteros**: No soporta decimales
2. **Sin arrays**: No hay soporte para listas o vectores
3. **Funciones de un parámetro**: Solo se puede pasar un argumento
4. **Sin comentarios**: No hay sintaxis para comentarios
5. **Sin operadores lógicos**: No hay AND, OR, NOT explícitos

## Flujo de Ejecución

1. Escribir el código línea por línea
2. Presionar `Ctrl+D` para iniciar la ejecución
3. El programa ejecuta secuencialmente
4. Cuando encuentra `teclado`, solicita entrada
5. Cuando encuentra `zapatilla`, imprime resultado

## Mensajes de Error Comunes

- **"Error: syntax error"**: Error de sintaxis en el código
- **"Error al leer entrada"**: Problema con `teclado`
- **"Función no definida"**: Llamada a función inexistente
- **"División por cero"**: Intento de dividir entre 0

## Consejos de Uso

1. **Siempre terminar con punto y coma** (`;`)
2. **Usar llaves** (`{}`) para bloques de código
3. **Declarar funciones antes de usarlas**
4. **Probar expresiones simples primero**
5. **Usar `Ctrl+D` para ejecutar el programa**

## Palabras Reservadas Completas

```
zapatilla, calefactor, toromax, return, teclado, 
refrigerador, microondas, licuadora
```

## Operadores Completos

```
Aritméticos: +, -, *, /
Comparación: ==, !=, <, >, <=, >=
Asignación: =
Agrupación: (, )
Bloques: {, }
Terminador: ;
```

---
