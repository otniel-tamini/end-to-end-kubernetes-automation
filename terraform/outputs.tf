# =============================================
# OUTPUTS
# =============================================

output "cluster_name" {
  description = "Nom du cluster EKS"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Point d'accès de l'API Kubernetes"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "ID du groupe de sécurité du cluster"
  value       = module.eks.cluster_primary_security_group_id
}

output "vpc_id" {
  description = "ID du VPC créé"
  value       = module.vpc.vpc_id
}

output "configure_kubectl" {
  description = "Commande pour configurer kubectl localement"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

output "eks_kubectl_policy_arn" {
  description = "ARN de la policy IAM pour accès kubectl"
  value       = aws_iam_policy.eks_kubectl_access.arn
}

output "current_user_arn" {
  description = "ARN de l'utilisateur/rôle actuel"
  value       = data.aws_caller_identity.current.arn
}