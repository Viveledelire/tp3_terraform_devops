# tp3_terraform_devops

Prototype Terraform permettant de déployer des ressources dans Azure (un groupe de ressource, un compte de stockage, une VM linux ubuntu 22 LTS accessible en SSH)

## Création du serveur Terraform

### Création d'une instance Azure

Dans un premier temps, vous aurez besoin de créer une instance Azure. Cette instance servira de serveur Terraform.

Connectez-vous en SSH à l'instance Azure que vous venez de créer. Ensuite, clonez ce repository github en utilisant cette commande : 

```
$ git clone https://github.com/Viveledelire/tp3_terraform_devops.git
```

Cela vous permettra d'avoir accès à tous les fichiers de configuration directement.

Une fois le repository cloné, vous pouvez installer Azure CLI en suivant les étapes de cette documentation : <br />
https://learn.microsoft.com/fr-fr/cli/azure/install-azure-cli-linux?pivots=apt

Puis, installer Terraform : 

```
```

Et enfin, vous aurez besoin de générer une clé SSH, en laissant le chemin par défaut, avec la commande : 

```
ssh-keygen -t rsa
```

Une fois toutes ces étapes franchies, vous n'avez plus qu'à configurer votre serveur.

### Configuration du serveur

Pour configurer votre serveur, dans un premier temps, vous aurez besoin de vous authentifier auprès d'Azure en utilisant cette commande : 

```
$ az login
```

Vous aurez ensuite besoin d'utiliser ces commandes : 

```
$ az account list --query "[].{name:name, subscriptionId:id}"
$ az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<YourSubscriptionId>"
# Vous devez remplacer l'élément <YourSubscriptionId> par l'ID qui va vous être retourné par la première commande.
```
La première commande vous permet de récupérer l'ID de votre abonnement Azure. <br />
La seconde commande vous permet de créer un "Service Principal" qui accorde le rôle `Contributor` à votre instance dans les limites de votre abonnement Azure. <br />
Un "Service principal" est une entité de sécurité dans Azure utilisée par une application, un service ou un objet de sécurité pour s'authentifier auprès de Microsoft Entra ID <br />
et accéder à des ressources. <br />
C'est ce "Service principal" qui va permettre à votre instance d'intéragir avec votre tenant.

Voilà, votre serveur Terraform est configuré.

## Déploiement du projet

### Sans modifier les fichiers fournis

Le projet étant déjà intégralement configuré, vous pouvez vous contenter d'exécuter les commandes suivantes pour créer l'intégralité des éléments mentionnés au début de ce Readme : 

```
$ terraform init
$ terraform plan
$ terraform apply
```

Vous pourrez ensuite vous rendre dans Azure pour vérifier que tous les éléments se sont bien créés et en profiter pour récupérer l'IP publique de la nouvelle instance. <br />
Pour finaliser ce projet, vous n'aurez plus qu'à tenter la connexion SSH en utilisant cette commande : 

```
ssh adminuser@<IPpublique>
```
### En modifiant les fichier fournis

Vous pouvez bien évidement vouloir personnaliser les noms des éléments qui vont se créer. Voici donc où trouver chacun des éléments : 

- le nom du groupe de ressource est définit dans `main.tf`
- le nom du compte de stockage est définit dans `sa.tf`
  - le nom du compte de stockage devant être unique dans le monde entier, je vous déconseille fortement de modifier cette partie  
- tous les autres éléments sont définit dans `vm.tf`

Une fois que vous êtes satisfait avec vos noms d'éléments, vous pouvez lancer les commandes suivantes : 

```
$ terraform init
$ terraform plan
$ terraform apply
```

Vous pourrez ensuite vous rendre dans Azure pour vérifier que tous les éléments se sont bien créés et en profiter pour récupérer l'IP publique de la nouvelle instance. <br />
Pour finaliser ce projet, vous n'aurez plus qu'à tenter la connexion SSH en utilisant cette commande : 

```
ssh <nom_user>@<IPpublique>
```
