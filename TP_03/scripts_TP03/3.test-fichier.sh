#!/bin/bash
# Vérification du nombre de paramètres.
if [ "$#" -ne 1 ]; then
    echo "Vous devez entrer exactement 1 paramètre."
    exit 1
fi

fichier="$1"
type=$(file -b "$fichier")
droits=$(stat -c "%A" "$fichier")

echo "Le fichier $fichier est un $type, accessible par $USER en $droits"

