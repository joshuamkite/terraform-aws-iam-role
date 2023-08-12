resource "aws_iam_policy" "example_boundary_policy" {
  name        = "ExampleBoundaryPolicy"
  description = "Example permissions boundary policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = ["s3:ListBucket"],
      Effect   = "Allow",
      Resource = "*"
    }]
  })
}

module "role_all_features" {
  source                = "../../"
  name_prefix           = "AllFeatures-"
  role_description      = "An example IAM role showcasing all module features."
  iam_role_path         = "/example_path/"
  max_session_duration  = 3600 # 1 hour
  force_detach_policies = true
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
  role_policy = {
    name = "InlineDynamoWrite",
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Action   = ["dynamodb:PutItem"],
        Effect   = "Allow",
        Resource = "*"
      }]
    })
  }
  existing_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
  bespoke_policy = {
    CustomS3Policy = {
      name = "CustomS3Policy",
      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
          Action   = ["s3:PutObject"],
          Effect   = "Allow",
          Resource = "arn:aws:s3:::anotherbucket/*"
        }]
      })
    }
  }
  permissions_boundary = aws_iam_policy.example_boundary_policy.arn
}

output "iam_role" {
  value = module.role_all_features
}

output "bespoke_policy_arns" {
  description = "ARNs of bespoke IAM policies created."
  value       = module.role_all_features.bespoke_policy_arns
}
