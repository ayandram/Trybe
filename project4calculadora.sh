#!/bin/bash

# Este projeto tem a pretensão de improvisar as funções de uma calculadora.
# Ao copiar e colar todas essas funções no arquivo .bashrc, elas ficam disponíveis para serem chamadas, com um ou dois argumentos.
# Desconsideramos o comando bc, pois a intenção era justamente brincar apenas com as operações fundamentais (adição, subtração, multiplicação e divisão euclidiana).
# Para tal, utilizamos alguns artifícios descritos a seguir.

# Soma dois inteiros:
adicao(){
    resultado=$[$1 + $2]
    echo $resultado
}
# Exemplo: adicao 1 -4
# Output: -3
# Valor correto: -3


# Subtrai o segundo argumento do primeiro:
subtracao(){
    resultado=$[$1 - $2]
    echo $resultado
}
# Exemplo: subtracao 4 -6
# Output: -2
# Valor correto: -2


# Multiplica dois inteiros:
multiplicacao(){
    resultado=$[$1 * $2]
    echo $resultado
}
# Exemplo: multiplicacao -3 7
# Output: -21
# Valor correto: -21


# Divide o primeiro argumento pelo segundo.
# Como o Bash não possui suporte nativo para operações com ponto flutuante e estamos evitando o comando externo bc, a estratégia aqui (e em outras funções envolvendo divisão) é multiplicar o numerador por 1000000, a fim de que haja maior precisão no resultado.
divisao(){
    resultado=$[($1 * 1000000) / $2]
    echo "$resultado x 10^(-6)"
}
# Exemplo: divisao 2 3
# Output: 666666 x 10^(-6)
# Valor correto: 0,667


# Faz a exponenciação de qualquer número inteiro como base e qualquer número inteiro como expoente:
exponenciacao(){
    exp=1

    if [[ $2 -ge 0 ]]; then
        j=$2
    else
        j=$[0 - $2]
    fi

    for (( i=1; i<=$j; i++))
    do
        exp=$[$exp * $1]
    done

    if [[ $2 -ge 0 ]]; then
        resultado=$exp
        echo $resultado
    else
        resultado=$[1000000 / $exp]
        echo "$resultado x 10^(-6)"
    fi
}
# Exemplo: exponenciacao -2 -5
# Output: -31250 x 10^(-6)
# Valor correto: -0,3125


# Calcula o fatorial de um número:
fatorial(){
    resultado=1

    for (( i=1; i<=$1; i++ ))
    do
        resultado=$[$resultado * $i]
    done

    echo $resultado
}
# Exemplo: fatorial 5
# Output: 120
# Valor correto: 120


# Calcula a exponencial que tem como base o número de Euler e, e como expoente qualquer número inteiro passado como argumento da função.
# Usamos a Série de Taylor da função exponencial para aproximar o resultado, com 50 iterações.
# É interessante notar que chamamos as funções exponenciacao e fatorial dentro dessa função exponencialdeEuler.
exponencialdeEuler(){
    resultado=0

    for (( i=0; i<=50; i++ ))
    do
        resultado=$[$resultado + ((`exponenciacao $1 $i`) * 1000000)/(`fatorial $i`)]
    done

    echo "$resultado x 10^(-6)"
}
# Exemplo: exponencialdeEuler -3
# Output: 49684 x 10^(-6)
# Valor correto: 0,049787


# Também usamos a Série de Taylor para aproximar a função seno com argumento inteiro (em radianos):
seno(){
    resultado=0

    for (( i=0; i<=30; i++ ))
    do
        var1=`exponenciacao -1 $i`
        var2=$[2 * $i + 1]
        var3=`exponenciacao $1 $var2`
        resultado=$[$resultado + ($var1 * $var3 * 1000000)/(`fatorial $var2`)]
    done

    echo "$resultado x 10^(-6)"
}
# Exemplo: seno -5
# Output: 958788 x 10^(-6)
# Valor correto: 0,958924

# Analogamente para a função cosseno:
cosseno(){
    resultado=0

    for (( i=0; i<=30; i++ ))
    do
        var1=`exponenciacao -1 $i`
        var2=$[2 * $i]
        var3=`exponenciacao $1 $var2`
        resultado=$[$resultado + ($var1 * $var3 * 1000000)/(`fatorial $var2`)]
    done

    echo "$resultado x 10^(-6)"
}
# Exemplo: cosseno 2
# Output: -416161 x 10^(-6)
# Valor correto: -0,416147



# Valendo-se apenas das operações fundamentais e entre números inteiros, o código se mostra bastante eficiente para realizar aproximações de funções mais complexas.
# Foi divertido colocar o conhecimento de Matemática na prática da programação, mesmo em uma linguagem tão básica como o Shell Script!