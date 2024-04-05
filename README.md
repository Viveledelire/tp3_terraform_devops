# tp3_terraform_devops

Prototype Terraform permettant de déployer des ressources dans Azure (un groupe de ressource, un compte de stockage, une VM linux ubuntu 22 LTS accessible en SSH)

## Création du serveur Terraform

### Création d'une instance Azure

Dans un premier temps, vous aurez besoin de créer une instance Azure. Cette instance servira de serveur Terraform.

Connectez-vous en SSH à l'instance Azure que vous venez de créer. Ensuite, clonez ce repository github en utilisant cette commande : 

```
$ git clone 
```

Cela vous permettra d'avoir accès à tous les fichiers de configuration directement.

Une fois le repository cloné, vous pouvez installer Azure CLI en suivant les étapes de cette documentation : <br />
https://learn.microsoft.com/fr-fr/cli/azure/install-azure-cli-linux?pivots=apt

Puis, installer Terraform en suivant les étapes de cette documentation : <br />
https://developer.hashicorp.com/terraform/install?product_intent=terraform

Et enfin, vous aurez besoin de générer une clé SSH, en laissant le chemin par défaut, avec la commande : 

```
ssh-keygen -t rsa
```

Une fois toutes ces étapes franchies, vous n'avez plus qu'à configurer votre serveur.

### Configuration du serveur

Pour configurer votre serveur, dans un premier temps, vous aurez besoin de vous connecter à Azure en utilisant cette commande : 

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
Un "Service principal" est une entité de sécurité dans Azure utilisée par une application, un service ou un objet de sécurité pour s'authentifier auprès de Microsoft Entra ID 
et accéder à des ressources. <br />
C'est ce "Service principal" qui va permettre à votre instance d'intéragir avec votre tenant.

Voilà, votre serveur Terraform est configuré.

## Déploiement du projet

Le projet étant déjà intégralement configuré, vous pouvez vous contenter d'exécuter les commandes suivantes pour créer l'intégralité des éléments mentionnés au début de ce Readme : 

```
$ terraform init
$ az login
$ terraform plan
$ terraform apply
```

Vous pourrez ensuite vous rendre dans Azure pour vérifier que tous les éléments se sont bien créés et en profiter pour récupérer l'IP publique de la nouvelle instance. <br />
Pour finaliser ce projet, vous n'aurez plus qu'à tenter la connexion SSH en utilisant cette commande : 

```
ssh adminuser@<IPpublique>
```
