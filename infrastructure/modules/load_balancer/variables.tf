variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "load_balancer_security_group_id" {
  description = "ID of the security group for the load balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name for the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
}

variable "target_group_health_check_path" {
  description = "Health check path for the target group"
  type        = string
}

variable "target_group_health_check_port" {
  description = "Health check port for the target group"
  type        = number
}

variable "target_group_health_check_interval" {
  description = "Interval for the target group health checks"
  type        = number
}

variable "target_group_health_check_timeout" {
  description = "Timeout for the target group health checks"
  type        = number
}

variable "target_group_health_check_healthy_threshold" {
  description = "Healthy threshold for the target group health checks"
  type        = number
}

variable "target_group_health_check_unhealthy_threshold" {
  description = "Unhealthy threshold for the target group health checks"
  type        = number
}
