# terraform-aws-iam-role 

Create an AWS IAM role with modern recommended practices, balancing simplicity against options without feature sprawl.

Features:

- Zero or more attachments for existing policies - policies may be AWS or customer managed
- Zero or more Bespoke Policies: Define and attach bespoke IAM policies within the module (avoids dependency difficulty).
- Zero or one Permissions Boundary
- Zero or one role_policy ('successor' to inline policy)
- Optional features:
  -  role description
  -  name/name_prefix/nothing (auto-create name for role)
  -  force_detach_policies
  -  custom IAM role path
  -  session duration

## Examples

### iam_role_basic_with_no_policies
Create a basic IAM role without any attached policies.

### iam_role_with_all_features
A comprehensive IAM role demonstrating all module features. This includes 'inline' role_policy, attachment of existing policies, bespoke policies, permission boundary policy creation, , and various role settings.

### iam_role_with_bespoke_policies
Create an IAM role and also create bespoke policies within the module and attach them to the role.

### iam_role_with_existing_policies
Create an IAM role and attach existing (managed and/or customer-managed) policies to it.

### iam_role_with_role_policy
Create an IAM role with a role_policy ('successor' to inline policy)

## Requirements

| Name                                                                      | Version   |
| ------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0  |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 3.30.0 |

## Providers

| Name                                              | Version   |
| ------------------------------------------------- | --------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.30.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                             | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [aws_iam_policy.bespoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                 | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                        | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)                          | resource |
| [aws_iam_role_policy_attachment.bespoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)    | resource |

## Inputs

| Name                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Type                                                                                                                                                                                                                 | Default | Required |
| ----------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy)          | Policy that grants an entity permission to assume the role                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `any`                                                                                                                                                                                                                | n/a     |   yes    |
| <a name="input_bespoke_policy"></a> [bespoke\_policy](#input\_bespoke\_policy)                        | Bespoke policies to create within module. Use policy names or name\_prefix as keys:<pre>policy_name {<br>    description = optional(string)<br>    name        = optional(string) # The name of the policy. If omitted, Terraform will assign a random, unique name<br>    name_prefix = optional(string) # Creates a unique name beginning with the specified prefix. Conflicts with 'name'<br>    path        = optional(string)<br>    policy      = string # **Required**  JSON formatted string</pre> | <pre>map(object({<br>    description = optional(string)<br>    name        = optional(string)<br>    name_prefix = optional(string)<br>    path        = optional(string)<br>    policy      = string<br>  }))</pre> | `{}`    |    no    |
| <a name="input_existing_policy_arns"></a> [existing\_policy\_arns](#input\_existing\_policy\_arns)    | Set of ARNs of any existing policies to attach.                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `list(string)`                                                                                                                                                                                                       | `[]`    |    no    |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether to force detaching any policies the role has before destroying it                                                                                                                                                                                                                                                                                                                                                                                                                                  | `any`                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path)                         | Path to the role                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `any`                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration)    | Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours                                                                                                                                                                                                                                                                       | `any`                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_name"></a> [name](#input\_name)                                                        | Friendly name of the role. If omitted, Terraform will assign a random, unique name. Conflicts with `name_prefix`                                                                                                                                                                                                                                                                                                                                                                                           | `any`                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix)                                 | Creates a unique friendly name beginning with the specified prefix. Conflicts with `name`                                                                                                                                                                                                                                                                                                                                                                                                                  | `any`                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary)      | The ARN of the policy that is used to set the permissions boundary for the role.                                                                                                                                                                                                                                                                                                                                                                                                                           | `string`                                                                                                                                                                                                             | `null`  |    no    |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description)                  | Description of the role                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `any`                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_role_policy"></a> [role\_policy](#input\_role\_policy)                                 | Map containing the 'inline' role\_policy name and policy                                                                                                                                                                                                                                                                                                                                                                                                                                                   | <pre>object({<br>    name        = optional(string)<br>    name_prefix = optional(string)<br>    policy      = string<br>  })</pre>                                                                                  | `null`  |    no    |

## Outputs

| Name                                                                                              | Description                               |
| ------------------------------------------------------------------------------------------------- | ----------------------------------------- |
| <a name="output_bespoke_policy_arns"></a> [bespoke\_policy\_arns](#output\_bespoke\_policy\_arns) | ARNs of any bespoke IAM policies created. |
| <a name="output_iam_role"></a> [iam\_role](#output\_iam\_role)                                    | use `iam_role.attribute` for specifics    |
