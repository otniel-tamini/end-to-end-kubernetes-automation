#!/bin/bash
set -e # Arrête le script immédiatement en cas d'erreur
set -o pipefail # Capture les erreurs dans les pipes

# Couleurs pour le logging
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}[INFO] Récupération de la configuration Terraform...${NC}"

# 1. Récupération dynamique du contexte (Plus robuste que le hardcoding)
# On utilise l'output "configure_kubectl" défini dans ton outputs.tf
KUBECONFIG_CMD=$(terraform output -raw configure_kubectl)

if [ -z "$KUBECONFIG_CMD" ]; then
  echo "Erreur: Impossible de récupérer la commande de configuration depuis Terraform."
  exit 1
fi

# 2. Configuration de kubectl
echo -e "${YELLOW}[1/3] Mise à jour du Kubeconfig...${NC}"
echo "Exec: $KUBECONFIG_CMD"
eval $KUBECONFIG_CMD

# 3. Patch du CoreDNS pour Fargate
echo -e "${YELLOW}[2/3] Patching CoreDNS pour support Fargate (Serverless)...${NC}"
kubectl patch deployment coredns \
  -n kube-system \
  --type merge \
  -p '{"spec": {"template": {"metadata": {"annotations": {"eks.amazonaws.com/compute-type": null}}}}}'

# 4. Redémarrage et vérification
echo -e "${YELLOW}[3/3] Redémarrage des pods CoreDNS...${NC}"
kubectl rollout restart deployment coredns -n kube-system

echo -e "${YELLOW}[INFO] Attente du déploiement effectif...${NC}"
# Bloque le script jusqu'à ce que les pods soient Running (évite les faux positifs)
kubectl rollout status deployment/coredns -n kube-system --timeout=180s

echo -e "${GREEN}[SUCCESS] Cluster EKS Fargate prêt et DNS opérationnel.${NC}"