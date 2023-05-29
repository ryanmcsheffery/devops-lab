variable "ami_name" {
  description = "Name of the custom AMI"
}

variable "ami_description" {
  description = "Description of the custom AMI"
}

variable "source_ami_id" {
  description = "ID of the source AMI"
}

variable "subnet_id" {
  description = "ID of the subnet for the Packer instance"
}

variable "security_group_id" {
  description = "ID of the security group for the Packer instance"
}

variable "aws_region" {
  description = "AWS region"
}

variable "log_group" {
  description = "Name of the CloudWatch Logs log group"
}

variable "log_stream" {
  description = "Name of the log stream"
}
