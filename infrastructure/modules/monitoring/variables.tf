variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "kubeconfig_path" {
  description = "Path to store the generated kubeconfig file"
}
