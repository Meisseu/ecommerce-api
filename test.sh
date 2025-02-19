#!/bin/bash

#!/bin/bash

echo "🛠️ Test de l'API E-commerce..."

echo "📌 Création d'un client"
curl -X POST -H "Content-Type: application/json" -d "{\"name\":\"John Doe\",\"email\":\"john@example.com\"}" http://localhost:5000/api/customers

echo "📌 Récupération des clients"
curl -X GET http://localhost:5000/api/customers

echo "📌 Création d'un produit"
curl -X POST -H "Content-Type: application/json" -d "{\"name\":\"Laptop\",\"price\":1000,\"stock\":10}" http://localhost:5000/api/products

echo "📌 Récupération des produits"
curl -X GET http://localhost:5000/api/products

echo "📌 Passer une commande pour un client"
curl -X POST -H "Content-Type: application/json" -d "{\"products\":[\"65a42b1fcf6a1c3d9b654321\"]}" http://localhost:5000/api/orders/direct/65b12345cf6a1c3d9b987654

echo "✅ Tests terminés !"
