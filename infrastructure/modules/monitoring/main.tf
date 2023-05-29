resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.21"

  vpc_config {
    subnet_id = var.private_subnet_id
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "monitoring-ng"
  instance_types  = ["t3.medium"]
  desired_size    = 1
  min_size        = 1
  max_size        = 3
  ami_type        = "AL2_x86_64"
  remote_access {
    ec2_ssh_key     = aws_key_pair.eks_key_pair.key_name
    source_security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
}

resource "aws_eks_cluster_auth" "eks_cluster_auth" {
  name            = aws_eks_cluster.eks_cluster.name
  cluster_name    = aws_eks_cluster.eks_cluster.name
  kubeconfig_path = var.kubeconfig_path
}

resource "aws_security_group" "eks_cluster_sg" {
  vpc_id = var.vpc_id

  # Ingress rules for EKS cluster
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules for EKS cluster
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Additional security group configuration for EKS cluster
  # ...
}