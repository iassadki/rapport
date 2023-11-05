#!/bin/bash

# Vérification du nombre de paramètres
if [ $# -ne 1 ]; then
    echo "Utilisation : $0 <répertoire>"
    exit 1
fi

directory="$1"

# Vérification de l'existence du répertoire
if [ ! -d "$directory" ]; then
    echo "Le répertoire spécifié n'existe pas."
    exit 1
fi

# Parcours du répertoire
# Pour chaque fichier, on vérifie si c'est un fichier texte, et on demande à l'utilisateur s'il veut le visualiser
for file in "$directory"/*; do
    if [ -f "$file" ] && file -b "$file" | grep -q "text"; then
        read -p "Voulez-vous visualiser le fichier $file ? (O/n) " response
        if [ "$response" = "O" -o "$response" = "o" ]; then
            more "$file"
        fi
    fi
done
