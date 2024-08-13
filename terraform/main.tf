locals {
  name   = "eks"
  region = "sa-east-1"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
  tags = {
    Owner               = var.owner
    Environment         = var.environment
    Maintainer          = var.maintainer
    Account_ID          = data.aws_caller_identity.current.account_id
  }
}

provider "aws" {
  region = local.region
}

data "aws_eks_cluster" "eks" {
  name = var.cluster_name
  depends_on = [module.eks.cluster_name]
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}


data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}


