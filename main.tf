resource "aws_iam_role" "this" {
  name                  = var.name
  name_prefix           = var.name_prefix
  description           = var.role_description
  assume_role_policy    = var.assume_role_policy
  permissions_boundary  = var.permissions_boundary
  force_detach_policies = var.force_detach_policies
  path                  = var.iam_role_path
  max_session_duration  = var.max_session_duration
}

resource "aws_iam_role_policy" "this" {
  count = var.role_policy != null ? 1 : 0

  # Use "name" if provided. If not, use "name_prefix". Else, let Terraform decide.
  name        = try(var.role_policy.name, null)
  name_prefix = try(var.role_policy.name ? null : var.role_policy.name_prefix, null)

  role   = aws_iam_role.this.id
  policy = var.role_policy.policy
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = toset(var.existing_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}

resource "aws_iam_policy" "bespoke" {
  for_each    = var.bespoke_policy
  description = each.value.description

  # Use "name" if provided. If not, use "name_prefix" if provided. Else, let Terraform decide.
  name        = try(each.value.name, null)
  name_prefix = try(each.value.name ? null : each.value.name_prefix, null)

  path   = try(each.value.path, null)
  policy = each.value.policy
}

resource "aws_iam_role_policy_attachment" "bespoke" {
  for_each   = aws_iam_policy.bespoke
  role       = aws_iam_role.this.name
  policy_arn = each.value.arn
}
