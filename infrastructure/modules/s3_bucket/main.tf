variable "bucket_name" {
  description = "Name of the S3 bucket"
}

variable "github_source_ip" {
  description = "GitHub source IP address for uploads"
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "logs/"
  }

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [
      {
        "Sid"       : "AllowGitHubUploads",
        "Effect"    : "Allow",
        "Principal" : "*",
        "Action"    : "s3:PutObject",
        "Resource"  : "${aws_s3_bucket.bucket.arn}/*",
        "Condition" : {
          "IpAddress" : {
            "aws:SourceIp" : var.github_source_ip
          }
        }
      },
      {
        "Sid"       : "DenyAllOtherAccess",
        "Effect"    : "Deny",
        "Principal" : "*",
        "Action"    : "s3:*",
        "Resource"  : "${aws_s3_bucket.bucket.arn}/*",
        "Condition" : {
          "NotIpAddress" : {
            "aws:SourceIp" : var.github_source_ip
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.bucket_name}-logs"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "${var.bucket_name}-logs"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}
