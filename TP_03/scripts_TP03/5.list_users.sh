#!/bin/bash

echo "Liste des utilisateurs avec un UID supérieur à 100 :"
# Utilisation de cut pour extraire le nom d'utilisateur (champ 1) et l'UID (champ 3)
for user in $(cut -d: -f1,3 /etc/passwd); do
    # Utilisation de awk pour séparer le nom d'utilisateur et l'UID
    login=$(echo "$user" | awk -F: '{print $1}')
    uid=$(echo "$user" | awk -F: '{print $2}')
    # Vérification si l'UID est supérieur à 100
    if [ "$uid" -gt 100 ]; then
        echo "$login : $uid"
    fi
done