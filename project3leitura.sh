#!/bin/bash

if [[ -z $1 ]]; then
    echo "Ops, você precisa passar um arquivo como argumento!"
elif [[ -e $1 ]]; then
    numeropalavras=`wc -w $1 | awk '{print $1;}'`
    tempo=$[$numeropalavras / 195]
    echo "Tempo estimado: $tempo minutos"
else
    echo "Ops, arquivo não existe!"
fi

