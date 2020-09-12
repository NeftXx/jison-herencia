# Jison atributos heredados

## Gramatica

```
GRAMATICA

S -> L { S.val = L.val; }

L -> B { L'h.val = B.val; } L' { L.val = L's.val; }

L' -> B { L1's.val = L'h.val * 2 + B.val } L' { L's.val = L1's.val; }
    |      {L's.val = L'h.val; }

B -> '0' { B.val = 0; }
   | '1' { B.val = 1; }

```

Recordar que jison traduce algo como esto:

\$$ a this.$. Que hace referencia a la produccion actual

Y $-1, $0, \$1, es para acceder a una posicion a la pila. Por ejemplo algo como esto:

- $1, lo puede traducir como $$[$0]
- $0, lo puede traducir como $$[$0 - 1]
- $-1, lo puede traducir como $$[$0 -2]

En jison \$0 es la longitud de la pila, y al parecer jison calcula la longitud del arreglo y hace la correcta obtencion del valor de la produccion correspondiente. Y como observacion epsilon no se guarda en la pila.

> Nota: Link para visualizar el ejemplo https://neftxx.github.io/jison-herencia/

