################################################################################
# VPC
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "VPC-${local.name}-${var.environment}"
  cidr = "${var.network_prefix}.0.0/16" # 10.0.0.0/8 is reserved for EC2-Classic

  azs             = ["${local.region}a", "${local.region}c"]
  private_subnets = ["${var.network_prefix}.0.0/22", "${var.network_prefix}.4.0/22"]   # 2 private subnets
  public_subnets  = ["${var.network_prefix}.12.0/22", "${var.network_prefix}.16.0/22"] # 2 public subnets

  # cidr = local.vpc_cidr

  # azs             = local.azs
  # private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  # public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  # intra_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 52)]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  # single_nat_gateway = true

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  map_public_ip_on_launch = true

  tags = local.tags
}
