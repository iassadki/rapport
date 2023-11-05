#!/bin/bash

# Vérification de l'utilisateur actuel (doit être root)
if [ "$EUID" -ne 0 ]; then
    echo "Ce script doit être exécuté en tant qu'utilisateur root."
    exit 1
fi

fichier="6.user_exists.sh"
source $fichier

# Fonction pour vérifier si un répertoire home existe déjà
check_home_directory() {
    home_dir="/home/$1"
    if [ -d "$home_dir" ]; then
        echo "Le répertoire home $home_dir existe déjà."
        return 1
    else
        return 0
    fi
}

# Demander des informations pour la creation du nouvel utilisateur
read -p "Login : " login
check_user_by_login "$login"  # Vérifier si l'utilisateur existe déjà
read -p "Nom : " nom
read -p "Prénom : " prenom
read -p "UID : " uid
check_user_by_uid "$uid" # Vérifier si l'UID existe déjà
read -p "GID : " gid
read -p "Commentaires : " commentaires

# # Vérifier si l'utilisateur existe déjà
# if check_user_by_login "$login"; then
#     echo "L'utilisateur $login existe déjà. Veuillez choisir un autre login."
#     exit 1
# fi

# Vérifier si le répertoire home existe déjà
if check_home_directory "$login"; then
    # Création du nouvel utilisateur
    useradd -m -c "$commentaires" -d "/home/$login" -u "$uid" -g "$gid" "$login"
    echo "L'utilisateur $login a été créé avec succès."
else
    echo "La création de l'utilisateur a été annulée en raison de la présence d'un répertoire home existant."
fi