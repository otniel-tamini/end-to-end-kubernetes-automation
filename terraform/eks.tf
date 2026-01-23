module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true
  enable_irsa = true

  eks_managed_node_groups = {}

  fargate_profiles = {
    ecom_app = {
      name = "ecom-app-profile"
      selectors = [{ namespace = "e-commerce" }]
    }
    kube_system = {
      name = "kube-system-profile"
      selectors = [{ namespace = "kube-system" }]
    }
  }

}
