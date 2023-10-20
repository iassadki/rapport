## Rapport TP01, Ilias ASSADKI, Licence Pro Projet web et Mobile
sources : debian-facile.org, lecrabeinfo.net, wikipedia, developpement-informatique.com, tutos.eu, developpez.net, unix.stackexchange.com, learning.lpi.org
___
D'abord, executer ces commandes pour lancer la VM
```shell
ls /usr/VirtualBox/LicencePro2023/LicencePro2023-PreInstalled
Vbox LicencePro2023-PreInstalled
ID de la VM : root root
```

---
#### 2 Post-Installation
##### 2.1 Configuration ssh

D'abord, on lance d'abord la commande **`apt update`**, avant d'installer SSH en executant **`apt install ssh`**. Ensuite, il faut accéder au fichier de configuration du serveur. On le fait avec la commande **`cat sshd_config | grep PermitRoot`**. 

**Problèmes rencontrés :** 
Je n'arrivais pas a installer les paquets que je souhaitais parce que le proxy n'était pas configuré. Pour cela, j'ai lancé la commande 
```shell
cd /etc/apt/ ; touch apt.conf ; echo "Aqcuire::http:proxy "http://proxy.ufr-info-p6.jussieu.fr:3128/" >> apt.conf
```  
Cette commande ci-dessus permet de metre en place le proxy mis en place par l'université

Pour pouvoir se connecter en **ssh** a sa machine distante depuis sa machine locale, il faut qu'on ait accès a certaines informations. Il faut donc exécutuer ces commandes dans l'ordre : `ip a` : Pour avoir l'adresse ip de la machine et pouvoir s'y connecter, ensuite `cd /etc/ssh ; nano sshd_config`, fichier de configuration de **ssh**.

Il faut décommenter cette ligne du fichier : 
``` shell
#PermitRootLogin prohibitpassword 
```
Et remplacer **`prohibitpassword`** (interdire la connexion root par mot de passe) par **`yes`** : 
``` shell
PermitRootLogin yes 
```
Il faut ensuite redemarrer le systeme de la VM pour que les modifications soient prise en compte. Donc il faut lancer la commande **`systemctl restart ssh`**

##### 2.2 Connection
Avant de se connecter, il faut lancer la commande **`ip a`**, pour voir l'adresse de la machine, et pouvoir ensuite prendre cette adresse pour s'y connecter.
![image commande UNIX](https://iassadki.github.io/rapport/images/ipa.jpg)
L'adresse IP de la machine est a la ligne `inet 10.20.0.26`

Pour se connecter a sa machine hôte, on lance la commande 
```shell
ssh root@10.20.0.26 
```
`10.20.0.26 (adresse ip de la machine virtuelle)`
`

##### 2.3 Nombre de paquets
Lancement de la commande 
```shell
root@serveur-correction:/# dpkg -l | wc -l
331
```
Il doit y avoir 320 paquets. Ici, il y'en a **331**
`

##### 2.4 Space usage
```shell
root@serveur-correction:/# df -h
```
![image commande UNIX](https://iassadki.github.io/rapport/images/df-h.jpg)
`

##### 2.5 A indiquer dans le rendu et expliquer les commandes et le resultat obtenu

- locales : echo $LANG 
``` shell 
root@serveur-correction:/# echo $LANG
fr_FR.UTF-8
```
La commande ci dessus retourne la variable d'environnement LANG, qui définit la langue et la configuration de la langue. Ici, on utilisé une configuration en français avec l'encodage UTF-8.
- aide : commande env + Google ou DuckDuckGo
``` shell 
root@serveur-correction:/# env 
```
![image commande UNIX](https://iassadki.github.io/rapport/images/env.jpg)
La commande env retourne toutes les variables d'environnement du système, sous forme de  :
NOM_VARIABLE=VALEUR_VARIABLE

###
- nom machine : hostname
``` shell 
root@serveur-correction:/# hostname
serveur-connexion
```
Le nom de la machine est : serveur-correction

###
- domaine : a l’aide du man de la commande hostname trouver comment afficher votre domain
``` shell 
root@serveur-correction:/# hostname -f
serveur-correction
```
Cette commande retourne le nom de domaine de la machine

###
- verification emplacement depots : cat /etc/apt/sources.list | grep 
-v -E ’^#|^$’
``` shell 
root@serveur-correction:/# cat /etc/apt/sources.list | grep -v -E ’^#|^$’
```
![image commande UNIX](https://iassadki.github.io/rapport/images/sourceslist.png)
Cette commande retourne le fichier qui référence toutes les sources utilisées par l'utilitaire APT pour telecharger des paquets. Ici, on va retourner la liste des sources de paquets actifs du fichier, donc les lignes non commentées


###
- passwd/shadow : cat /etc/shadow | grep -vE ’:\*:|:!\*:’
``` shell 
root@serveur-correction:/# cat /etc/shadow | grep -vE ’:\*:|:!\*:’
```
![image commande UNIX](https://iassadki.github.io/rapport/images/etc.shadow.png)
Cette commande retourne la liste de mots de passes actifs dans ma machine. Ici, on a le mot de passe haché de **root**. Ici, le mot de passe est haché et salé.


###
- compte utilisateurs : cat /etc/passwd | grep -vE ’nologin|sync’ 
``` shell 
root@serveur-correction:/# cat /etc/passwd | grep -vE ’nologin|sync’
```
![image commande UNIX](https://iassadki.github.io/rapport/images/etc.passwd.jpg)
Cette commande retourne les utilisateurs n'ayant pas l'attibut de compte nologin ou sync. Ces derniers sont des comptes de service, qui sont crées et utilisés par des applications, des services ou des opérations bas-niveau, pour interagir avec le système d'exploitation. Ce sont des comptes sur lesquels on ne peut pas se connecter.  

###
- expliquer le retour des commandes : fdisk -l et fdisk -x
``` shell 
root@serveur-correction:/# fdisk -l 
```
![image commande UNIX](https://iassadki.github.io/rapport/images/fdisk-ll.jpg)
Cette commande retourne les partitions du disque dur du système.

``` shell
root@serveur-correction:/# fdisk -x
```
![image commande UNIX](https://iassadki.github.io/rapport/images/fdisk-x.jpg)

Cette commande retourne les partitions du système, d'une façon plus détaillée, aevc des informations sur le disque principal, son type d'etiquette,  un tableau donnant le périphériques, les secteurs, des ID unique ainsi que des id unique des types des partitions. 

###
- expliquer le retour de la commande : df -h
``` shell 
root@serveur-correction:/# df -h
```
Cette commande retourne l'intégralité des disques et partitions présents sur la machine.  


---

#### 3 Aller plus loin
##### 3.1 Installation automatique
**preseed** :  fichier texte utilisé en meme temps que la mini.iso charge. Le fichier preseed c'est la reponse a toute les questions. Possible de modifier les reponses du **preseed** pour que ça reponse à toutes les questions, sans qu'on ait besoin de le faire nous même, lors d'une installation. 
En utilisant un fichier preseed, l'installation peut se dérouler sans interaction humaine. Cette technique est utile pour des istallations a grand echelle

##### 3.2 Rescue mode
comment changer son password
``/etc/passwd/shadow | grep root`` : MDP haché de root

```shell
root@serveur-correction:/# passwd
Nouveau mot de passe
Retapez votre mot de passe
passwd : mot de passe mis à jour avec succès
```
Le mot de passe à bien été changé


##### 3.3 Redimentionnement partition
Voici comment redimensionner sa partition racine sans avoir a tout reinstaller : 
Ordre à respecter
```shell
root@serveur-correction:/# df -h
root@serveur-correction:/# fdisk -l /dev/sda # affichage des détails de la partition
root@serveur-correction:/# umount / # démontage de la partition 
root@serveur-correction:/# fdisk -l /dev/sda 
Commande (m pour l'aide) : p
Disque /dev/sda : 8 GiB, ... octets, ... secteurs
Unités : secteur de 1 × ... = ... octets
Taille de secteur (logique / physique) : ... octets / ... octets
taille d E/S (minimale / optimale) : ... octets / ... octets
Type d'étiquette de disque : dos
Identifiant de disque : 0xid_du_disque
Device     Boot    Start      End  Sectors  Size Id Type
/dev/sda1           2048 14682111 14680064    6G 83 Linux

root@serveur-correction:/# fdisk /dev/sda 
Commande (m pour l'aide) : d # pour detruire la partition en question
Numéro de partition (1,2, 2 par défaut) : 1
Commande (m pour l'aide) : n
Type de partition
   p   primaire (0 primaire, 0 étendue, 4 libre)
   e   étendue (conteneur pour partitions logiques)
Sélectionnez (p par défaut) : p
Numéro de partition (1-4, 1 par défaut) : 1
Premier secteur (2048-16777215, 2048 par défaut) : 2048
Dernier secteur, +secteurs ou +taille{K,M,G,T,P} (2048-16777215, 16777215 par défaut) : +7G
 
Une nouvelle partition 1 de type « Linux » et de taille 7 GiB a été créée.

Commande (m pour l'aide) : w
La table de partitions a été altérée.
Appel d'ioctl() pour relire la table de partitions.
Échec de relecture de la table de partitions.: Périphérique ou ressource occupé

## Le systeme doit etre redemarré pour que le noyau relise  
# et applique la nouvelle table de partition. Il faut ensuite faire un un fsck sur la prochaine réinitialisation, qui rendra la partition saine avant son montage.

touch /forcefsck
init 6
resize2fs /dev/sda1

# enfin, lancer la commande 
df -h # pour verifier ses disques

```

Ilias ASSADKI



