resource "aws_lb" "application_load_balancer" {
  name               = "my-application-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids

  security_groups = [var.load_balancer_security_group_id]

  tags = {
    Name = "my-application-lb"
  }
}

resource "aws_lb_target_group" "app_target_group" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path                = var.target_group_health_check_path
    port                = var.target_group_health_check_port
    interval            = var.target_group_health_check_interval
    timeout             = var.target_group_health_check_timeout
    healthy_threshold   = var.target_group_health_check_healthy_threshold
    unhealthy_threshold = var.target_group_health_check_unhealthy_threshold
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}
