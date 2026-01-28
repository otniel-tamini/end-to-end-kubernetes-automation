# =============================================
# IAM ROLES ET POLICIES
# =============================================

# Rôle d'exécution Fargate
resource "aws_iam_role" "fargate_pod_execution_role" {
  name = "eks-fargate-pod-execution-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "eks-fargate-pods.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "fargate_pod_execution_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_pod_execution_role.name
}

# Policy IAM pour l'accès kubectl (à attacher à votre utilisateur/rôle IAM)
resource "aws_iam_policy" "eks_kubectl_access" {
  name        = "EKSKubectlAccessPolicy"
  description = "Policy pour permettre l'accès kubectl au cluster EKS"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:DescribeFargateProfile",
          "eks:ListFargateProfiles",
          "eks:AccessKubernetesApi"
        ]
        Resource = "*"
      }
    ]
  })
}

# Si vous utilisez un utilisateur IAM spécifique, décommentez et ajustez :
# resource "aws_iam_user_policy_attachment" "kubectl_user_access" {
#   user       = "votre-nom-utilisateur"
#   policy_arn = aws_iam_policy.eks_kubectl_access.arn
# }

# Si vous utilisez un rôle IAM, décommentez et ajustez :
# resource "aws_iam_role_policy_attachment" "kubectl_role_access" {
#   role       = "votre-nom-role"
#   policy_arn = aws_iam_policy.eks_kubectl_access.arn
# }