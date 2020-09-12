/* lexical grammar */
%lex
%%

\s+                     /* skip */
[0-1]                   { return 'DIGIT'; }
<<EOF>>                 { return 'EOF'; }

/lex

%{
    // Nodo auxiliar para iniciar un atributo hermano.
    let nodeAux;
%}

/* 
GRAMATICA

S -> L { S.val = L.val; }

L -> B { L'h.val = B.val; } L' { L.val = L's.val; }

L' -> B { L1's.val = L'h.val * 2 + B.val } L' { L's.val = L1's.val; }
    |      {L's.val = L'h.val; }

B -> '0' { B.val = 0; }
   | '1' { B.val = 1; }

*/
%start s

%% /* language grammar */

/*
    Recordar que jison traduce algo como esto:
    $$ a this.$. Que hace referencia a la produccion actual

    Y $-1, $0, $1, es para acceder a una posicion a la pila.
    Por ejemplo algo como esto:

    $1, lo puede traducir como $$[$0]
    $0, lo puede traducir como $$[$0 - 1]
    $-1, lo puede traducir como $$[$0 -2]

    En jison $0 es la longitud de la pila, y al parecer jison calcula
    la longitud del arreglo y hace la correcta obtencion del valor de la
    produccion correspondiente. Y como observacion epsilon no se guarda en la pila.
*/

s : lista EOF {
    return $lista.conversion();
}
;

lista : binario marker1 lista_apostrefe  {
    $$ = new Node("lista");
    $$.val_s = $lista_apostrefe.val_s;
}
;

// Los markers, son producciones con epsilon,
// que ayudan en este caso a simular los atributos heredados.
marker1 : /* epsilon */ {
    nodeAux = new Node("lista_apostefre");
    // $1 es la produccion binario
    nodeAux.val_h = $1.val_s;
}
;

lista_apostrefe : binario marker2 lista_apostrefe  {
    $$.val_s = $lista_apostrefe.val_s;
}
| /* epsilon */ {
    $$ = nodeAux;
    $$.val_s = $$.val_h;
}
;

marker2 : /* epsilon */ {
    // $1 es la produccion binario
    // y $0 es lista_apostofre, pero padre no hermano
    $0 = nodeAux;
    nodeAux = new Node("lista_apostefre");
    nodeAux.val_h = $0.val_h * 2 + $1.val_s;
}
;

binario : DIGIT {
    $$ = new Node("binario");
    $$.val_s = $$.val_h = Number($1);
}
;
