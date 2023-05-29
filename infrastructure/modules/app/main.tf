provider "aws" {
  region = var.aws_region
}

module "networking" {
  source              = "../networking"
  vpc_cidr_block      = var.app_vpc_cidr_block
  public_subnet_cidrs = var.app_public_subnet_cidrs
  private_subnet_cidrs = var.app_private_subnet_cidrs
}

module "load_balancer" {
  source              = "../load_balancer"
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


resource "aws_instance" "app_instance" {
  ami                    = module.packer.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.networking.app_security_group_id]
  subnet_id              = module.networking.private_subnet_id

  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.public_ip}, ${path.module}/streamlit.yml}"
    working_dir = "../ansible"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }

  # Other instance configuration...
}


module "security_group" {
  source                = "../security_group"
  app_vpc_id          = module.networking.vpc_id
  private_vpc_id      = module.networking.private_vpc_id
}

