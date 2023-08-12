module "role_with_bespoke" {
  source           = "../../"
  name_prefix      = "WithBespoke-"
  role_description = "An example IAM role with bespoke policies created within the module"
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
  bespoke_policy = {
    CustomS3Policy = {
      name = "CustomS3Policy",
      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
          Action   = ["s3:PutObject"],
          Effect   = "Allow",
          Resource = "arn:aws:s3:::mybucket/*"
        }]
      })
    },
    CustomDynamoPolicy = {
      name_prefix = "DynamoPolicy-",
      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
          Action   = ["dynamodb:Scan"],
          Effect   = "Allow",
          Resource = "*"
        }]
      })
    }
  }
}


output "iam_role" {
  value = module.role_with_bespoke.iam_role
}

output "bespoke_policy_arns" {
  description = "ARNs of bespoke IAM policies created."
  value       = module.role_with_bespoke.bespoke_policy_arns
}
