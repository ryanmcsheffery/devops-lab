resource "aws_security_group" "load_balancer_sg" {
  vpc_id = var.app_vpc_id

  # Ingress rules for load balancer
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules for load balancer
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Additional security group configuration for load balancer
  # ...
}

resource "aws_security_group" "app_instance_sg" {
  vpc_id = var.app_vpc_id

  # Ingress rules for app instance
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }

  # Egress rules for app instance
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Additional security group configuration for app instance
  # ...
}

resource "aws_security_group" "private_sg" {
  vpc_id = var.private_vpc_id

  # Ingress rules for private instances
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.app_instance_sg.id]
  }

  # Egress rules for private instances
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Additional security group configuration for private instances
  # ...
}
