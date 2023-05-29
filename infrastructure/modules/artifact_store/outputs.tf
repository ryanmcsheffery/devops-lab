output "repository_name" {
  value = aws_codeartifact_repository.codeartifact_repository.repository_name
}

output "repository_arn" {
  value = aws_codeartifact_repository.codeartifact_repository.arn
}

output "repository_endpoint" {
  value = aws_codeartifact_repository.codeartifact_repository.repository_endpoint
}
