# iam_role_with_all_features

Role combining 'inline' role_policy, attachment of existing policies, bespoke policies, Permission Boundary Policy Creation.

## Requirements

No requirements.

## Providers

| Name                                              | Version |
| ------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.12.0  |

## Modules

| Name                                                                                        | Source | Version |
| ------------------------------------------------------------------------------------------- | ------ | ------- |
| <a name="module_role_all_features"></a> [role\_all\_features](#module\_role\_all\_features) | ../../ | n/a     |

## Resources

| Name                                                                                                                             | Type     |
| -------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_iam_policy.example_boundary_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

No inputs.

## Outputs

| Name                                                                                              | Description                           |
| ------------------------------------------------------------------------------------------------- | ------------------------------------- |
| <a name="output_bespoke_policy_arns"></a> [bespoke\_policy\_arns](#output\_bespoke\_policy\_arns) | ARNs of bespoke IAM policies created. |
| <a name="output_iam_role"></a> [iam\_role](#output\_iam\_role)                                    | n/a                                   |
