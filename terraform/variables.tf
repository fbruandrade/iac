variable "owner" {
  default = "Personal"
}
variable "user_name" {
  default = "fandrade"
}
variable "project_name" {
  default = "demo-eks"
}
variable "environment" {
  default = "demo"
}
variable "env_short_name" {
  default = "demo"
}
variable "maintainer" {
  default = "Felipe Brunelli de Andrade"
}
variable "region" {
  default = "sa-east-1"
}
variable "network_prefix" {
  default = "10.0"
}
variable "cluster_endpoint_private_access" {
  default = ""
}
variable "cluster_endpoint_public_access" {
  default = ""
}
variable "worker_group_min_size" {
  default = ""
}
variable "worker_group_desired_size" {
  default = ""
}
variable "worker_group_max_size" {
  default = ""
}
variable "eks_instance_type" {
  type    = list(string)
  default = ["t3.medium"]
}
variable "eks_ami_type" {
  default = "AL2_x86_64"
}
variable "eks_node_volume_size" {
  default = "20"
}

variable "cluster_name" {
  default = "eks-demo"
}