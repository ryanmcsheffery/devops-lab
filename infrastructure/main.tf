# Configure the AWS provider
provider "aws" {
  region = var.aws_region
}

# Modules
module "networking" {
  source  = "./modules/networking"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "app" {
  source         = "./modules/app"
}

module "load_balancer" {
  source              = "./modules/load_balancer"
  vpc_id              = module.networking.vpc_id
  public_subnet_ids   = module.networking.public_subnet_ids
  target_group_name   = var.target_group_name
  target_group_port   = var.target_group_port
  target_group_health_check_path = var.target_group_health_check_path
  target_group_health_check_port = var.target_group_health_check_port
  target_group_health_check_interval = var.target_group_health_check_interval
  target_group_health_check_timeout  = var.target_group_health_check_timeout
  target_group_health_check_healthy_threshold = var.target_group_health_check_healthy_threshold
  target_group_health_check_unhealthy_threshold = var.target_group_health_check_unhealthy_threshold
  load_balancer_security_group_id = var.load_balancer_security_group_id
}
module "monitoring" {
  source               = "./modules/monitoring"
  eks_cluster_name     = module.eks_cluster.cluster_name
  private_subnet_ids   = module.networking.private_subnet_ids
  kubeconfig_path      = module.eks_cluster.kubeconfig_path
  vpc_id               = module.networking.vpc_id 
}

module "cloudwatch_logs" {
  source            = "./modules/cloudwatch_logs"
  log_group_name    = var.log_group_name
}

module "artifact_store" {
  source       = "./modules/artifact_store"
  repository_name = var.repository_name
}

module "packer" {
  source              = "./modules/packer"
  ami_name            = var.app_ami_name
  ami_description     = var.app_ami_description
  source_ami_id       = var.app_source_ami_id
  security_group_id   = module.security_group.app_instance_sg_id
  aws_region          = var.aws_region
  log_group           = module.cloudwatch_logs.log_group_name
  log_stream          = module.cloudwatch_logs.log_stream_name
  subnet_id           = module.networking.private_subnet_ids
}

module "security_group" {
  source              = "./modules/security_group"
  app_vpc_id          = module.networking.vpc_id
  private_vpc_id      = module.networking.private_vpc_id
}
