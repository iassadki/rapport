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
Les attaques dites « bruteforce SSH » sont des tentatives de connexions SSH effectuant une succession d'essais pour découvrir un couple utilisateur/mot de passe valide afin de prendre le contrôle de la machine. Il s'agit d'une attaque très répandue et toute machine exposée sur Internet se verra attaquer plusieurs fois par jour. 

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
```
- Quel a ete le premier processus lance apres le demarrage du systeme ?

On lance toujours la commande **`ps -o`**. Le premier processus lancé après le demarrage est celui avec le **PID 1**. 

- A quelle heure votre machine a-t-elle demarree ? Trouvez une autre commande permetant de trouver le temps depuis lequel votre serveur tourne.

``` shell
root^serveur-correction:~# who -b
``` 
``` shell
root^serveur-correction:~# uptime 
```

- Pouvez-vous etablir le nombre approximatif de processus crees depuis le demarrage (“boot”) de votre machine ?

``` shell
root^serveur-correction:~# ps aux | wc -l
PHOTO
```
// ps -eo user,pid,%cpu,%mem,stat,start,time,command | head -n5
// ps -eo user,pid,%cpu,%mem,stat,start,time,command --sort=-%cpu | head -n5

*2 - Sous UNIX, chaque processus (excepte le premier) est cree par un autre processus, son processus pere. Le processus pere d’un processus est identifie par son PPID (Parent PID).*

– Trouver une option de la commande ps permettant d’afficher le PPID d’un processus.
```shell 
root^serveur-correction:~# ps -o ppid
```

– Donner la liste ordonnee de tous les processus ancetres de la commande ps en cours d’execution.
```shell 
root^serveur-correction:~# ps -o ppid
```

*3 - Reprendre la question precedente avec la commande pstree.*

Vous devrez sans doute installer ce package : 
voir apt update ; apt search ; apt install.

```shell 
root^serveur-correction:~# pstree
PHOTO ARBRE
```

4 - Essayez la commande top, qui affiche les memes informations que ps mais en raffraichissant periodiquement l’affichage.
- La touche ? permet d’afficher un resume de l’aide de top. Afficher dans top la liste de processus
triee par occupation memoire (“resident memory”) decroissante.

- Quel est le processus le plus gourmand sur votre machine ? A quoi correspond-il ? (rappel : vous pouvez utiliser man truc pour decouvrir ce que fait truc...).

```shell
root^serveur-correction:~# ps -eo user,pid,%cpu,%mem,stat,start,time,command --sort=-%cpu | head -n5
```

- Trouvez les commandes interactives permettant de : passer l’affichage en couleur, mettre en avant le colonne de trie, changer la colonne de trie.

```shell
root^serveur-correction:~# ls -G # coloration
root^serveur-correction:~# ls -X # mettre en avant la colonne de tri
root^serveur-correction:~# ls -S # changer la colonne de tri 
```

- Essayez la commande htop. Expliquez les avantages et/ou inconvenients a son utilisation par rapport a top.
htop est une commande qui affiche une liste de processus en cours d'exécution sur votre système, triée par utilisation de la CPU ou de la mémoire.
Avantages de htop : interface conviviale et facile à utiliser. 
Inconvénients de htop : il n'est pas installé par défaut sur la plupart des distributions Linux.

#### Exercice 2 : Arret d’un processus
Ecrivez deux script shell contenant des boucles affichant la date 

*fichier date.sh*
```shell
#!/bin/sh
while true; do sleep 1; echo -n ’date ’; date +%T; done
```
*fichier date-toto.sh*
```shell
#!/bin/sh
while true; do sleep 1; echo -n ’toto ’; date --date ’5 hour ago’ +%T; done
```
- Lancer le 1er scripts. Le mettre en arriere plan (CTRL-Z).
- Lancer le 2eme scripts. Le mettre en arriere plan (CTRL-Z).
- A l’aide des commandes jobs fg et CTRL-C, arreter les 2 horloges.
comment arreter les deux horloges avec jobs fg et CTRL-C ?
il faut utiliser la commande **`jobs`** pour afficher les taches en cours d'execution, **`fg`** pour mettre en avant plan le processus qu'on veut arreter, et  **`CTRL-C`** pour arreter le processus.
- Meme question en utilisant les commandes ps et kill (avec un PID).
arreter les deuxcommandes du dessus avec ps et kill (retrouver le pid de la commande avant de la kill)
Pour se faire, il faut utiliser la commande **`ps -aux`| grep nom_du_script.sh** pour afficher les processus en cours d'execution, recuperer le PID de la commande et executer **`kill -9 PID`** dans la ligne de commande pour arreter le processus. 
- Expliquer les scripts a l’aide du man.

#### Exercice 3 : les tubes
**Quelle est la difference entre tee et cat ?**
La commande `cat` affiche le contenu d'un fichier `cat fichier.txt`
La commande `tee` affiche le contenu de la commande et renvoie le contenu du fichier : `commande | tee fichier`

Que font les commandes suivantes :
**`$ ls | cat`** : Affichage du contenu d'une commande sous forme de fichier texte, directement en output sur le terminal

**`$ ls -l | cat > liste`** : Affichage du contenu d'une commande sous forme de fichier texte, et copie de cet affichage dans le fichier listew

**`$ ls -l | tee liste`** : Affichage du contenu de la commande (ici du dossier courant)
 
**`$ ls -l | tee liste | wc -l`** : Affiche le nombre de fichiers et de dossiers dans le répertoire ou l'on est et le stocke dans le fichier liste.
 
#### 5 Journal systeme rsyslog
- Le service rsyslog est-il lanc´e sur votre systeme ? Quel est le PID du demon ?
Le service rsyslog est lancé sur le système. On le sait avec la commande `systemctl show --property MainPID rsyslog` 

- Le principal fichier de configuration de rsyslog est /etc/rsyslog.conf. Dans quel fichier
rsyslog ´ecrit-il les messages issus des services standards ? Et la plupart des autres messages ?
V´erifier le contenu de ces fichiers.

- A quoi sert le service cron ?
Le cron permet de planifier des taches qui permet d'executer des commandes à des moments que l'on praramètres dans la journée, ou a des intervales régulières. C'est possile de le faire pour des taches de sauvagardes de données, ou autre. 

- Que fait la commande tail -f ? A l’aide de cette commande, placer en bas de votre écran
Cette commande sert à afficher les dernières lignes d'un fichier. L'option -f permet de suivre les modifications du fichier en temps réel.
un fenˆetre qui permette de visualiser en “temps r´eel” le contenu du fichier /var/log/messages.

- Que voyez-vous si vous redémarrez le service cron depuis un autre shell ?
Si vous redémarrez le service cron depuis un autre shell, vous verrez les messages de démarrage et d'arrêt du service dans le fichier /var/log/syslog. Vous pouvez utiliser la commande tail -f /var/log/syslog pour afficher les messages en temps réel.

- Expliquer à quoi sert le fichier /etc/logrotate.conf.
Le fichier /etc/logrotate.conf est le fichier de configuration principal de logrotate. logrotate, c'est un outil qui permet de faire tourner les fichiers de log. Il est très utile pour les administrateurs système qui souhaitent automatiser la rotation des fichiers de log.
Il contient des informations sur les fichiers à faire tourner, comment les faire tourner et où les stocker. Il contient aussi des informations sur les fichiers de configuration supplémentaires à inclure. Le fichier /etc/logrotate.conf est lu par logrotate au démarrage et à chaque fois que la commande logrotate est exécutée. 

- Examiner la sortie de la commande dmesg. Quel modele de processeur linux detecte-il sur
votre machine ? Quels modèles de cartes réseaux detecte-il ? 








