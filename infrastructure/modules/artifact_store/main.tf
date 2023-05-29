resource "aws_codeartifact_domain" "codeartifact_domain" {
  domain          = var.repository_name
  encryption_key  = aws_kms_key.kms_key.arn
  tags            = { Name = var.repository_name }
}

resource "aws_codeartifact_repository" "codeartifact_repository" {
  repository_name = var.repository_name
  domain          = aws_codeartifact_domain.codeartifact_domain.domain
  domain_owner    = aws_codeartifact_domain.codeartifact_domain.owner

  upstream {
    repository_name = "public"
    domain_owner    = "public"
  }

  permissions_policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": [
        "codeartifact:PackageVersionsRead",
        "codeartifact:PackageVersionsWrite",
        "codeartifact:ReadFromRepository"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_kms_key" "kms_key" {
  description          = "KMS key for AWS CodeArtifact"
  policy               = data.aws_iam_policy_document.kms_policy.json
}