## Rapport TP02, Ilias ASSADKI, Licence Pro Projet web et Mobile

### 1 Secure Shell : SSH
##### 1.1 Exercice : Connection ssh root (reprise fin tp-01)

<!-- Expliquez a l’aide du man sshd_config l’element de la configuration ssh que vous avez du changer les differentes options possibles, les avantages et leurs inconvenients. Dans quel cas faut -->
<!-- t’il utiliser chacunes des options. -->
...

##### 1.2 Exercice : Authentification par clef / Génération de clefs
<!-- Dans le cadre du TP je vous invite à ne pas mettre de passphrase pour simplifier les choses, -->
<!-- vous expliquerez pourquoi c’est une mauvaise idee dans un cas reel. -->

Création de clé d'authentification pour connexion au serveur Linux. Générer une clé privée publique sur sa session Linux sur machine hote

``` shell
1011387@ppti-24-308-02:/users/nfs/Etu7/1011387$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ilias/.ssh/id_rsa): # laisser vide
Enter passphrase (empty for no passphrase): # laisser vide
Enter same passphrase again: # laisser vide
Your identification has been saved in /users/Etu7/1011387/.ssh.ud_rsa
Your public key has been saved in /users/Etu7/1011387/.ssh.ud_rsa.pub
The key fingerprint is:
SHA256:... root@serveur-correction
The key randomart is : 
#### IMAGE GENEREE 
```
genere un cople de clé publique / privée
**`id_rsa`** : fichier qui contient la clé privée
**`id_rsa.pub`** : fichier qui contient la cle publique

###### 1.3 Exercice : Authentification par clef / Connection serveur

``` shell
1011387@ppti-24-308-02: /users/nts/Etu7/1011387$ ssh-copy-id root@10.20.0.26
/usT/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usI/bin/ssh-copy-id: INFO: 1 key(S) remain to be installed - if you are prompted now it is to install the new keys 
root@10.20.0.26 password: # Entrer le mot de passe
Number of key(s) added: 1
Now try logging into the machine, with:
"ssh 'root@10.20.0.26'*"
and check to make sure that only the key(s) you wanted were added.
1011387@ppti-24-308-02: /users/nts/Etu7/1011387$ ssh root@10.20.0.26
## Linux serveur-correction 6.1.0-12-amd64 .....
```
PARLER DE COPY ID

Si toute les étapes sont bien suivies, on peut se connecter sans mot de passe, lorsqu'on tape **``ssh root@10.20.0.26``**. 

###### 1.4 Exercice : Authentification par clef : depuis la machine hote
`ssh -i maclef.pub root@ipserveur`
Cette commande permet de se connecter au serveur depuis la clé publique, depuis sa machine hote

##### 1.5 Exercice : Securisez
Les attaques dites « bruteforce SSH » sont des tentatives de connexions SSH effectuant une succession d'essais pour découvrir un couple utilisateur/mot de passe valide afin de prendre le contrôle de la machine. Il s'agit d'une attaque très répandue et toute machine exposée sur Internet se verra attaquer plusieurs fois par jour. // revoir

who -b
htop

## 2 Processus
##### 2.1 Exercice : Etude des processus UNIX

*1. A l’aide de la commande ps, afficher la liste de tous les processus tournant sur votre machine, avec les informations suivantes*

``` shell
ps aux # afficher la liste de tous les processus tournant sur votre machine
```
- A quoi correspond l’information TIME ?

L'information **TIME** donne le temps total utilisé par le processus.

- Quel est le processus ayant le plus utilise le processeur sur votre machine ?

``` shell
root@serveur-correction:~# top
PHOTO
```
- Quel a ete le premier processus lance apres le demarrage du systeme ?

On lance toujours la commande **`top`**. Le premier processus lancé après le demarrage est celui avec le **PID 1**. 
PHOTO ENCADREE

- A quelle heure votre machine a-t-elle demarree ? Trouvez une autre commande permetant de trouver le temps depuis lequel votre serveur tourne.

``` shell
root^serveur-correction:~# uptime 
PHOTO
```

- Pouvez-vous etablir le nombre approximatif de processus crees depuis le demarrage (“boot”) de votre machine ?

``` shell
root^serveur-correction:~# ps aux | wc -l
ps -eo user,pid,%cpu,%mem,stat,start,time,command | head -n5
ps -eo user,pid,%cpu,%mem,stat,start,time,command --sort=-%cpu | head -n5

PHOTO
```

*2 - Sous UNIX, chaque processus (excepte le premier) est cree par un autre processus, son processus pere. Le processus pere d’un processus est identifie par son PPID (Parent PID).*

– Trouver une option de la commande ps permettant d’afficher le PPID d’un processus.

– Donner la liste ordonnee de tous les processus ancetres de la commande ps en cours d’execution.

*3 - Reprendre la question precedente avec la commande pstree.*

Vous devrez sans doute installer ce package : voir apt update ; apt search ; apt install.


trier avec top 
p cpu
comm reinstaller
securisez, modif fichiers de configuration






