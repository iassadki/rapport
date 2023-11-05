## Rapport TP03, Ilias ASSADKI, Licence Pro Projet web et Mobile

##### Exercice 1 : Paramètres
Ecrivez un script analyse.sh qui affiche :
Bonjour, vous avez rentre nombre de parametres parametres.
Le nom du script est nom du script
Le 3eme parametre est 3eme parametre
Voici la liste des parametres : liste des parametres
```shell
#!/bin/bash
# On initialise les variables pour prendre en compte les paramètres
param_count=$#
script_name=$0
param_3=$3
param_list=("$@")

echo "Bonjour, vous avez rentré $param_count paramètres."
echo "Le nom du script est $script_name."
echo "Le 3ème paramètre est $param_3."
echo "Voici la liste des paramètres : ${param_list[@]}"
```   

##### Exercice 2 : Vérification du nombre de paramètres
Ecrivez un script concat.sh qui prend en parametre 2 mots et fait ce qui suit.
- si l’utilisateur rentre autre chose que 2 parametres, indique a l’utilisateur qu’il doit rentrer
exactement 2 parametres, et quitte en renvoyant une erreur.
- sinon le script calcule dans une variable CONCAT la concatenation des 2 mots rentres puis
affiche le resultat
Pour tous les exercices suivants vous verifirez systematiquement le nombre de parametres.

```shell
#!/bin/bash
# Vérification du nombre de paramètres. Si c'est différent de 2, on quitte le script.
if [ "$#" -ne 2 ]; then
    echo "Vous devez entrer exactement 2 paramètres."
    exit 1
fi

# Concaténation les deux mots dans la variable $CONCAT
CONCAT="$1$2"

# Affichage du resultat de la concaténation
echo "Résultat de la concaténation : $CONCAT"
```   

##### Exercice 3 : Arguments, types et droits
Creer un script test-fichier, qui precisera le type du fichier passe en parametre, ses permissions d’acces pour l’utilisateur, ou s’il n’existe pas.
Exemple de resultats :
Le fichier /etc est un repertoire
"/etc" est accessible par root en lecture ecriture execution
Le fichier /etc/smb.conf est un fichier ordinaire qui n’est pas vide
"/etc/smb.conf" est accessible par jean en lecture.

```shell
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

# manipuler l'output et remplacer l'output directory par repertoire
# sed -i 's/directory/répertoire/g' test-fichier.sh

```   


##### Exercice 4 : Afficher le contenu d'un repertoire
Ecrire un script bash listedir.sh permettant d’afficher le contenu d’un repertoire en separant 
les fichiers et les (sous) repertoires.
Exemple d’utilisation :
# $ ./listdir.sh /boot
% affichera :
% ####### fichier dans /boot/
% /boot/config-3.16.0-4-amd64
% /boot/initrd.img-3.16.0-4-amd64
% /boot/System.map-3.16.0-4-amd64
% /boot/vmlinuz-3.16.0-4-amd64
% ####### repertoires dans /boot/
% /boot/grub
```shell
#!/bin/bash

# Verification du nombre de paramètres
if [ $# -ne 1 ]; then
  echo "Usage: $0 <répertoire>"
  exit 1
fi

directory="$1"

# Verification de l'existence du répertoire
if [ ! -d "$directory" ]; then
  echo "Le répertoire spécifié n'existe pas."
  exit 1
fi

# Parcours du répertoire et affichage des fichiers et répertoires
echo "####### fichiers dans $directory/"
for file in "$directory"/*; do
  if [ -f "$file" ]; then
    echo "$file"
  fi
done

# Parcours du répertoire et affichage des répertoires
echo "####### répertoires dans $directory/"
for subdir in "$directory"/*; do
  if [ -d "$subdir" ]; then
    echo "$subdir"
  fi
done
```   

##### Exercice 4 : Lister les utilisateurs
Ecrire un script bash affichant la liste des noms de login des utilisateurs définis dans /etc/passwd
ayant un UID superieur a 100.
Indication : for user in $(cat /etc/passwd); do echo $user; done permet preque de
parcourir les lignes du dit fichier. Cependant, quel est le probleme ? 
- **Le probleme est que la commande cat affiche tout le contenu du fichier.** 

Resoudre ce probleme en utilisant cut (avec les bons arguments) au lieu de cat. Faites la meme chose avec la commande awk.

```shell
#!/bin/bash

# Utilisation de cut pour extraire le nom d'utilisateur (champ 1) et l'UID (champ 3)
for user in $(cut -d: -f1,3 /etc/passwd); do
    # Utilisation de awk pour séparer le nom d'utilisateur et l'UID
    login=$(echo "$user" | awk -F: '{print $1}')
    uid=$(echo "$user" | awk -F: '{print $2}')
    # Vérification si l'UID est supérieur à 100
    if [ "$uid" -gt 100 ]; then
        echo "L'utilisateur $login a un UID supérieur à 100 : $uid"
    fi
done

```

##### Exercice 5 : Mon utilisateur existe t'il 
Ecrire un script qui verifie si un utilisateur existe deja.
- en fonction d’un login passe en parametres
- en fonction d’un UID passe en parametres
Si l’utilisateur existe renvoyer son UID `a l’affichage.
Sinon ne rien renvoyer.

```shell
#!/bin/bash

# Verifie si un utilisateur existe deja, par son login
check_user_by_login() {
    login="$1"
    uid=$(id -u "$login" 2>/dev/null)
    if [ -n "$uid" ]; then
        echo "L'utilisateur existe avec UID : $uid"
    fi
}

# Verifie si un utilisateur existe deja, par son UID
check_user_by_uid() {
    uid="$1"
    login=$(getent passwd "$uid" | cut -d: -f1)
    if [ -n "$login" ]; then
        echo "L'utilisateur existe avec UID : $uid"
    fi
}

# Vérification du nombre de paramètres
if [ "$#" -ne 2 ]; then
    echo "Utilisation : $0 [login|UID] [valeur]"
    exit 1
fi

# Affectation des paramètres
check_type="$1"
value="$2"

# Vérification du type de vérification
if [ "$check_type" = "login" ]; then
    check_user_by_login "$value"
elif [ "$check_type" = "UID" ]; then
    check_user_by_uid "$value"
else
    echo "Type de vérification invalide. Utilisez 'login' ou 'UID'."
    exit 1
fi
```   

##### Exercice 6 : Création d'utilisateur
Ecrire un script pour creer un compte utilisateur voir : man useradd
Utilisez votre script de verification d’existance d’utilisateur avant de creer.
Il faudra verifier que l’utilisateur en cours d’execution est bien root voir echo $USER
Il faudra creer son home dans /home apres avoir verifier qu’il n’y a pas deja un repertoire
portant le meme nom.
Il faudra repondre a une suite de question : voir man read
- login
- Nom
- Prenom
- UID
- GID
- Commentaires

```shell
#!/bin/bash

# Appel de la fonction du script de vérification d'utilisateur
check_user_by_login 

# Vérification de l'utilisateur actuel (doit être root)
if [ "$EUID" -ne 0 ]; then
    echo "Ce script doit être exécuté en tant qu'utilisateur root."
    exit 1
fi

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

# Demander des informations pour créer un nouvel utilisateur
read -p "Login : " login
read -p "Nom : " nom
read -p "Prénom : " prenom
read -p "UID : " uid
read -p "GID : " gid
read -p "Commentaires : " commentaires

# Vérifier si l'utilisateur existe déjà
if check_user_by_login "$login"; then
    echo "L'utilisateur $login existe déjà. Veuillez choisir un autre login."
    exit 1
fi

# Vérifier si le répertoire home existe déjà
if check_home_directory "$login"; then
    # Création du nouvel utilisateur
    useradd -m -c "$commentaires" -d "/home/$login" -u "$uid" -g "$gid" "$login"
    echo "L'utilisateur $login a été créé avec succès."
else
    echo "La création de l'utilisateur a été annulée en raison de la présence d'un répertoire home existant."
fi

```   

##### Exercice 7 : Lecture au clavier
La commande bash read permet de lire une chaıne au clavier et de l’affecter a une variable.
Essayer les commandes suivante :
echo -n "Entrer votre nom: "
read nom
echo "Votre nom est $nom"
La commande file affiche des informations sur le contenu d’un fichier (elle applique des regles
basees sur l’examen rapide du contenu du fichier).
Les fichiers de texte peuvent etre affiche page par page avec la commande more (ou less, qui
est legerement plus sophistiquee, car less is more...).
- Question Tester les trois commandes : read, file, more.
 comment quitter more ?
 comment avancer d’une ligne ?
 comment avancer d’une page ?
 comment remonter d’une page ?
 comment chercher une chaıne de caracteres ? Passer a l’occurence suivante ?

- Réponses au questions
 Pour quitter more, il faut appuyer sur la touche q.
 Pour avancer d'une ligne, il faut appuyer sur la touche Entrée.
 Pour avancer d'une page, il faut appuyer sur la touche espace.
 Pour remonter d'une page, il faut appuyer sur la touche b.
 Pour chercher une chaîne de caractères, il faut appuyer sur la touche /, puis entrer la chaîne de caractères à rechercher, puis appuyer sur Entrée. Pour passer à l'occurence suivante, il faut appuyer sur la touche n.

Ecrire un script qui propose a l’utilisateur de visualiser page par page chaque fichier texte du  
repertoire specifiqe en argument. Le script affichera pour chaque fichier texte (et seulement ceux
la, utiliser la commande file) la question “voulez vous visualiser le fichier machintruc ?”. En
cas de reponse positive, il lancera more, avant de passer a l’examen du fichier suivant.

```shell
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

```   

##### Exercice 8 : Appréciation
Creer un script qui demande a l’utilisateur de saisir une note et qui affiche un message en
fonction de cette note :
- “tres bien” si la note est entre 16 et 20 ;
- “bien” lorsqu’elle est entre 14 et 16 ;
- “assez bien” si la note est entre 12 et 14 ;
- “moyen” si la note est entre 10 et 12 ;
- “insuffisant” si la note est inferieur  a 10.
Pour quitter le programme l’utiliateur devra appuyer sur q.

```shell
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
```   
