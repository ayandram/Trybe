#!/bin/bash

echo "Digite sua mensagem:"
read mensagem

if [[ -z $mensagem ]]; then
    echo "Ops, você precisa passar uma mensagem como argumento!"
    exit 1
else 
    echo "Enviando..."
fi

curl -s -X POST -H 'Content-type: application/json' --data "{\"text\":\"$mensagem\"}" https://hooks.slack.com/services/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 > /dev/null
echo -e "Mensagem foi enviada com sucesso."

# <@UPXM1H4UQ> <@UPJTJA2HG>