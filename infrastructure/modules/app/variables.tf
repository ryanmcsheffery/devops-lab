variable "instance_type" {
  description = "Instance type for the application instances"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the application instances"
  default     = "ami-xxxxxxxxxxxxx"
}

variable "security_group_name" {
  description = "Security group name for the application instances"
  default     = "app-security-group"
}

variable "key_name" {
  description = "SSH key pair name for the application instances"
  default     = "your-key-pair-name"
}

variable "app_port" {
  description = "Port on which the application listens"
  default     = 80
}

variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-xxxxxxxx"
}

variable "deregistration_delay" {
  description = "Deregistration delay in seconds for the target group"
  default     = 300
}
