output "load_balancer_sg_id" {
  value = aws_security_group.load_balancer_sg.id
}

output "app_instance_sg_id" {
  value = aws_security_group.app_instance_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}
