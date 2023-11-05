#!/bin/bash

# Vérifie si le nombre de paramètres est différent de 2
if [ "$#" -ne 2 ]; then
    echo "Vous devez entrer exactement 2 paramètres."
    exit 1
fi

# Concatène les deux mots et stocke le résultat dans la variable CONCAT
CONCAT="$1$2"

# Affiche le résultat de la concaténation
echo "Résultat de la concaténation : $CONCAT"

