# =============================================
# MODULE EKS
# =============================================

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  
  cluster_name    = var.cluster_name
  cluster_version = "1.31"
  
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  
  cluster_endpoint_public_access = true
  enable_irsa = true
  
  # Configuration d'accès au cluster
  # Cette option crée automatiquement une entrée d'accès admin pour le créateur du cluster
  enable_cluster_creator_admin_permissions = true
  
  # Pas besoin d'access_entries supplémentaires car enable_cluster_creator_admin_permissions
  # donne déjà les droits admin à l'utilisateur/rôle qui crée le cluster
  
  # Node groups vides (utilisation de Fargate)
  eks_managed_node_groups = {}
  
  # Profils Fargate
  fargate_profiles = {
    ecom_app = {
      name = "ecom-app-profile"
      selectors = [{ namespace = "e-commerce" }]
      
      # Utilisation du rôle Fargate créé
      iam_role_arn = aws_iam_role.fargate_pod_execution_role.arn
    }
    kube_system = {
      name = "kube-system-profile"
      selectors = [
        { namespace = "kube-system" },
        { namespace = "kube-system", labels = { k8s-app = "kube-dns" } }
      ]
      
      iam_role_arn = aws_iam_role.fargate_pod_execution_role.arn
    }
  }
  
  # Tags
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}
