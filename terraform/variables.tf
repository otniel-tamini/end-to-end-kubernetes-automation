# =============================================
# VARIABLES
# =============================================

variable "aws_region" {
  description = "Région AWS pour le déploiement"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Nom du cluster EKS"
  type        = string
  default     = "ecom-cluster"
}

variable "vpc_cidr" {
  description = "Plage IP du VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Nom de l'environnement (dev, prod, etc.)"
  type        = string
  default     = "production"
}
