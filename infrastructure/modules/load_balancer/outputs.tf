output "load_balancer_arn" {
  description = "ARN of the application load balancer"
  value       = aws_lb.application_load_balancer.arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.app_target_group.arn
}
