module "role_with_inline" {
  source           = "../../"
  name             = "RoleWithInlinePolicy"
  role_description = "An example IAM role with an inline policy"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
  role_policy = {
    name = "InlineS3ReadOnly"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Action   = ["s3:GetObject"],
        Effect   = "Allow",
        Resource = "*"
      }]
    })
  }
}

output "iam_role" {
  value = module.role_with_inline
}
