variable "assume_role_policy" {
  description = "Policy that grants an entity permission to assume the role"
}

variable "bespoke_policy" {
  type = map(object({
    description = optional(string)
    name        = optional(string)
    name_prefix = optional(string)
    path        = optional(string)
    policy      = string
  }))
  default = {}
  validation {
    condition = alltrue([
      for policy in values(var.bespoke_policy) : policy.name == null || policy.name_prefix == null
    ])
    error_message = "For each policy, only one of name or name_prefix or nothing can be provided."
  }
  description = <<EOF
Bespoke policies to create within module. Use policy names or name_prefix as keys:
```
  policy_name {
    description = optional(string)
    name        = optional(string) # The name of the policy. If omitted, Terraform will assign a random, unique name
    name_prefix = optional(string) # Creates a unique name beginning with the specified prefix. Conflicts with 'name'
    path        = optional(string)
    policy      = string # **Required**  JSON formatted string
```    
EOF
}

variable "existing_policy_arns" {
  description = "Set of ARNs of any existing policies to attach."
  type        = list(string)
  default     = []
}

variable "force_detach_policies" {
  default     = null
  description = "Whether to force detaching any policies the role has before destroying it"
}

variable "iam_role_path" {
  description = "Path to the role"
  default     = null
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours"
  default     = null
}

variable "name" {
  description = "Friendly name of the role. If omitted, Terraform will assign a random, unique name. Conflicts with `name_prefix`"
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique friendly name beginning with the specified prefix. Conflicts with `name`"
  default     = null
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = null
}

variable "role_description" {
  default     = null
  description = "Description of the role"
}

variable "role_policy" {
  description = "Map containing the 'inline' role_policy name and policy"
  type = object({
    name        = optional(string)
    name_prefix = optional(string)
    policy      = string
  })
  default = null
  validation {
    condition     = try(var.role_policy.name == null || var.role_policy.name_prefix == null, true)
    error_message = "Only one of name or name_prefix or nothing can be provided"
  }

}
