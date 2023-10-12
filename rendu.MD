## Rapport TP01
<!-- nom machine : **ilias-debian** -->
<!-- domaine : **ufr-info-p6.jussieu.fr** -->
<!-- ufr-info-p6-jusieu.fr:3128 -->
<!-- bookworm - Stable -->
<!-- deb-ilias -->
<!-- user : root -->
<!-- mdp : debilias -->
___
D'abord, executer ces commandes pour lancer la VM
```shell
ls /usr/VirtualBox/LicencePro2023/LicencePro2023-PreInstalled
Vbox LicencePro2023-PreInstalled
ID de la VM : root root
```
keygen

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

Pour pouvoir se connecter en **ssh** a sa machine distante depuis sa machine locale, il faut qu'on ait accès a certaines informations. Il faut donc exécutuer ces commandes dans l'ordre : `ip a` : Pour avoir l'adresse ip de la machine et pouvoir s'y connecter. 
**PHOTO**
`cd /etc/ssh ; nano sshd_config`

Il faut decommenter cette ligne du fichier : 
``` shell
#PermitRootLogin prohibitpassword 
```
Et remplacer **`prohibitpassword`** (interdire la connexion root par mot de passe) par **`yes`** : 
``` shell
PermitRootLogin yes 
```
Il faut ensuite redemarrer le systeme de la VM pour que les modifications soient prise en compte. Donc il faut lancer la commande **`systemctl restart ssh`**

##### 2.2 Connection
Avant de se conneter, il faut lancer la commande ip a, pour voir l'adresse de la machine, et pouvoir ensuite prendre cette adresse pour s'y connecter.
Pour se connecter a sa machine hôte, on lance la commande 
```shell
ssh root@10.20.0.26 
```
`10.20.0.26 (adresse ip de la machine virtuelle)`

##### 2.3 Nombre de paquets
Lancement de la commande 
```shell
root@serveur-correction:/# dpkg -l | wc -l
331
```
Il doit y avoir 320 paquets. Ici, il y'en a **331**

##### 2.4 Space usage
```shell
root@serveur-correction:/# df -h
```
![image commande UNIX](https://iassadki.github.io/rapport/images/df -h.jpg)


##### 2.5 A indiquer dans le rendu et expliquer les commandes et le resultat obtenu

###
- locales : echo $LANG 
``` shell 
root@serveur-correction:/# echo $LANG
fr_FR.UTF-8
```
- aide : commande env + Google ou DuckDuckGo
``` shell 
root@serveur-correction:/# env ...
PHOTO
```

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
root@serveur-correction:/# domain ...
output... DC
```
retour

###
- verification emplacement depots : cat /etc/apt/sources.list | grep 
-v -E ’^#|^$’
``` shell 
root@serveur-correction:/# cat /etc/apt/sources.list | grep -v -E ’^#|^$’
PHOTO
```
retour

###
- passwd/shadow : cat /etc/shadow | grep -vE ’:\*:|:!\*:’
``` shell 
root@serveur-correction:/# cat /etc/shadow | grep -vE ’:\*:|:!\*:’
PHOTO
```
retour


###
- compte utilisateurs : cat /etc/passwd | grep -vE ’nologin|sync’
``` shell 
root@serveur-correction:/# cat /etc/passwd | grep -vE ’nologin|sync’
PHOTO
```
retour

###
- expliquer le retour des commandes : fdisk -l et fdisk -x
``` shell 
root@serveur-correction:/# fdisk -l 
PHOTO
root@serveur-correction:/# fdisk -x
PHOTO
```
retour

###
- expliquer le retour de la commande : df -h
``` shell 
root@serveur-correction:/# df -h
PHOTO
```
retour


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
...



