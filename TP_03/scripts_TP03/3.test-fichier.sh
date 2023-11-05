#!/bin/bash
# Vérification du nombre de paramètres.
if [ "$#" -ne 1 ]; then
    echo "Vous devez entrer exactement 1 paramètre."
    exit 1
fi

# Initialisation des variable
fichier="$1"

# type contient le type du fichier (répertoire, fichier ordinaire, ...)
type=$(file -b "$fichier")
# droits contient les droits d'accès du fichier pour l'utilisateur
droits=$(stat -c "%A" "$fichier")

echo "Le fichier $fichier est un $type, accessible par $USER en $droits"


# Manipuler ces outputs (repertoire - accessibilité - vide ou pas vide)
# Le fichier /etc est un repertoire
# "/etc" est accessible par root en lecture ecriture execution
# Le fichier /etc/smb.conf est un fichier ordinaire qui n’est pas vide
# "/etc/smb.conf" est accessible par jean en lecture.