variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"  # Replace with your desired region
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  # Replace with your desired VPC CIDR block
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"  # Replace with your desired public subnet CIDR block
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"  # Replace with your desired private subnet CIDR block
}

variable "target_group_name" {
  description = "Name for the target group"
  type        = string
  default     = "my-target-group"  # Replace with your desired target group name
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 8080  # Replace with the port number your application is listening on
}

variable "target_group_health_check_path" {
  description = "Health check path for the target group"
  type        = string
  default     = "/health"  # Replace with the health check path for your application
}

variable "target_group_health_check_port" {
  description = "Health check port for the target group"
  type        = number
  default     = 8080  # Replace with the port number your application is listening on
}

variable "target_group_health_check_interval" {
  description = "Interval for the target group health checks"
  type        = number
  default     = 30  # Replace with the desired health check interval in seconds
}

variable "target_group_health_check_timeout" {
  description = "Timeout for the target group health checks"
  type        = number
  default     = 5  # Replace with the desired health check timeout in seconds
}

variable "repository_name" {
  description = "Name for the CodeArtifact repository"
  type        = string
  default     = "ArtifactStore"  # Replace with your desired ECR repository name
}