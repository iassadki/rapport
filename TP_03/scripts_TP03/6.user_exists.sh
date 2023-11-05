#!/bin/sh

check_user_by_login() {
    login="$1"
    uid=$(id -u "$login" 2>/dev/null)
    if [ -n "$uid" ]; then
        echo "L'utilisateur existe avec UID : $uid"
        exit 1
    fi
}

check_user_by_uid() {
    uid="$1"
    login=$(getent passwd "$uid" | cut -d: -f1)
    if [ -n "$login" ]; then
        echo "L'utilisateur existe avec UID : $uid"
        exit 1
    fi
}

if [ "$#" -ne 2 ]; then
    echo "Utilisation : $0 [login|UID] [valeur]"
    exit 1
fi

check_type="$1"
value="$2"

if [ "$check_type" = "login" ]; then
    check_user_by_login "$value"
elif [ "$check_type" = "UID" ]; then
    check_user_by_uid "$value"
else
    echo "Type de vérification invalide. Utilisez 'login' ou 'UID'."
    exit 1
fi
