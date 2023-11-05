#!/bin/bash

while true; do
    read -p "Entrez une note (ou 'q' pour quitter) : " note

    if [ "$note" = "q" ]; then
        echo "Programme quitté."
        exit 0
    fi

    if ((note >= 16 && note <= 20)); then
        echo "Très bien"
    elif ((note >= 14 && note < 16)); then
        echo "Bien"
    elif ((note >= 12 && note < 14)); then
        echo "Assez bien"
    elif ((note >= 10 && note < 12)); then
        echo "Moyen"
    elif ((note < 10)); then
        echo "Insuffisant"
    else
        echo "Note invalide. La note doit être entre 0 et 20."
    fi
done
