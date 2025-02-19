# E-commerce API  

Une API RESTful permettant de gérer des produits, des clients et des commandes.  
Le projet utilise Node.js, Express, MongoDB et Docker.  

---

## Prérequis  

Avant d’utiliser cette application, assure-toi d’avoir installé :  

1. **Git**  
   ```sh
   git --version
   ```
   
2. **Node.js** (version 18+)  
   ```sh
   node -v
   npm -v
   ```
   
3. **Docker Desktop**  
   ```sh
   docker --version
   ```

---

## 1. Cloner le projet  
```sh
git clone https://github.com/Meisseu/ecommerce-api.git
cd ecommerce-api
```

---

## 2. Lancer l’API avec Docker  

### Méthode 1 : Exécuter `run.sh` sous Windows  
Si Git Bash est installé, exécute :  
```sh
bash run.sh
```

Si Git Bash n’est pas installé, utilise la méthode manuelle :  

### Méthode 2 : Lancer les commandes Docker manuellement  
```sh
docker network create backend-test-network
docker run -d --name db-container --network backend-test-network --network-alias db-container mongo:4.4
docker build -t express-project .
docker run -d --name express-app --network backend-test-network -p 5000:5000 express-project
```

Vérifier si l’API fonctionne :  
```sh
docker ps
```
Tu devrais voir deux conteneurs actifs :  
- `express-app` (API)  
- `db-container` (MongoDB)  

---

## 3. Tester automatiquement l’API avec `test.sh`

Un script **`test.sh`** est fourni pour exécuter une série de tests automatiques afin de vérifier le bon fonctionnement de l'API.

### Vérifier la présence du fichier `test.sh`
Assure-toi que le fichier `test.sh` est bien présent dans ton projet :
```sh
ls
```
Si `test.sh` apparaît dans la liste des fichiers, tu peux le lancer.

### Donner les permissions d'exécution (si nécessaire)
Si tu es sous **Git Bash**, Linux ou macOS, rends le script exécutable :
```sh
chmod +x test.sh
```

### Exécuter `test.sh`
#### **Sous Git Bash ou Linux/macOS**
```sh
./test.sh
```

#### **Sous Windows CMD ou PowerShell**
```sh
bash test.sh
```

---

### 🔹 **Contenu du script `test.sh`**
Le script exécute les étapes suivantes :  

1️⃣ **Création d'un client**
```sh
curl -X POST -H "Content-Type: application/json" -d "{\"name\":\"John Doe\",\"email\":\"john@example.com\"}" http://localhost:5000/api/customers
```

2️⃣ **Récupération des clients**
```sh
curl -X GET http://localhost:5000/api/customers
```

3️⃣ **Création d'un produit**
```sh
curl -X POST -H "Content-Type: application/json" -d "{\"name\":\"Laptop\",\"price\":1000,\"stock\":10}" http://localhost:5000/api/products
```

4️⃣ **Récupération des produits**
```sh
curl -X GET http://localhost:5000/api/products
```

5️⃣ **Passer une commande pour un client**
```sh
curl -X POST -H "Content-Type: application/json" -d "{\"products\":[\"65a42b1fcf6a1c3d9b654321\"]}" http://localhost:5000/api/orders/direct/65b12345cf6a1c3d9b987654
```

6️⃣ **Affichage du message de fin**
```sh
echo "✅ Tests terminés !"
```

---

### 🔹 **Réponse attendue après exécution**
Si tout fonctionne correctement, tu devrais voir des réponses JSON similaires à celles-ci :

#### **Création du client**
```json
{
    "_id": "65b12345cf6a1c3d9b987654",
    "name": "John Doe",
    "email": "john@example.com"
}
```

#### **Liste des clients**
```json
[
    {
        "_id": "65b12345cf6a1c3d9b987654",
        "name": "John Doe",
        "email": "john@example.com"
    }
]
```

#### **Création du produit**
```json
{
    "_id": "65a42b1fcf6a1c3d9b654321",
    "name": "Laptop",
    "price": 1000,
    "stock": 10
}
```

#### **Liste des produits**
```json
[
    {
        "_id": "65a42b1fcf6a1c3d9b654321",
        "name": "Laptop",
        "price": 1000,
        "stock": 10
    }
]
```

#### **Commande passée avec succès**
```json
{
    "message": "Order created successfully",
    "order": {
        "_id": "65b99999cf6a1c3d9b123456",
        "customer": "65b12345cf6a1c3d9b987654",
        "products": ["65a42b1fcf6a1c3d9b654321"]
    }
}
```

Si une erreur apparaît comme :
```json
{"error":"Customer not found"}
```
Cela signifie que le client ou le produit utilisé pour la commande n’existe pas encore. Assure-toi que les ID sont corrects.

---

## 4. Endpoints de l'API  

### Produits  
| Méthode  | URL | Description |
|----------|-----|-------------|
| `POST`   | `/api/products` | Ajouter un produit |
| `GET`    | `/api/products` | Récupérer tous les produits |
| `GET`    | `/api/products/:id` | Voir un produit |
| `PUT`    | `/api/products/:id` | Modifier un produit |
| `DELETE` | `/api/products/:id` | Supprimer un produit |

### Clients  
| Méthode  | URL | Description |
|----------|-----|-------------|
| `POST`   | `/api/customers` | Ajouter un client |
| `GET`    | `/api/customers` | Voir la liste des clients |

### Commandes  
| Méthode  | URL | Description |
|----------|-----|-------------|
| `POST`   | `/api/orders` | Créer une commande |
| `GET`    | `/api/orders/:id` | Voir une commande |
| `PUT`    | `/api/orders/:id` | Modifier une commande |
| `DELETE` | `/api/orders/:id` | Supprimer une commande |

### Commande Directe  
| Méthode  | URL | Description |
|----------|-----|-------------|
| `POST`   | `/api/orders/direct/:customerId` | Passer une commande pour un client existant |

---

## 5. Arrêter et nettoyer Docker  

### Arrêter les conteneurs  
```sh
docker stop express-app db-container
```

### Supprimer les conteneurs et le réseau  
```sh
docker rm express-app db-container
docker network rm backend-test-network
```

