output "iam_role" {
  description = "use `iam_role.attribute` for specifics"
  value       = aws_iam_role.this
}

output "bespoke_policy_arns" {
  description = "ARNs of any bespoke IAM policies created."
  value       = [for p in aws_iam_policy.bespoke : p.arn]
}
