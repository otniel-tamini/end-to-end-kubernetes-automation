#!/bin/bash

# --- CONFIGURATION ---
DOCKER_USER="otniel217"
TAG="latest"
SERVICES=("config-server" "api-gateway" "user-service" "product-service" "order-service")

# --- LOGIN ---
# Assurez-vous d'être déjà connecté ou décommentez la ligne suivante
# docker login

echo "🚀 Démarrage du processus de build et push pour $DOCKER_USER"

for SERVICE in "${SERVICES[@]}"
do
    echo ""
    echo "-------------------------------------------------------"
    echo "🏗️  Building: $SERVICE"
    echo "-------------------------------------------------------"

    # Construction de l'image
    # IMPORTANT : Le contexte est '.' (la racine) pour inclure la shared-lib
    docker build -t $DOCKER_USER/$SERVICE:$TAG -f $SERVICE/Dockerfile .

    if [ $? -eq 0 ]; then
        echo "✅ Build réussi pour $SERVICE. Envoi vers Docker Hub..."
        
        # Push de l'image
        docker push $DOCKER_USER/$SERVICE:$TAG
        
        if [ $? -eq 0 ]; then
            echo "➡️  $SERVICE a été poussé avec succès."
        else
            echo "❌ Échec du push pour $SERVICE."
        fi
    else
        echo "❌ Échec du build pour $SERVICE. Le push est annulé."
        exit 1
    fi
done

echo ""
echo "-------------------------------------------------------"
echo "🏁 Opération terminée avec succès !"
echo "-------------------------------------------------------"