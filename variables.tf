################################################################################
### SSO GROUP ASSIGNMENT
################################################################################

# SSO INSTANCE
variable "instance_arn" {
  description = "(Optional, Forces new resource) The Amazon Resource Name (ARN) of the SSO Instance. If not set via variable, module uses data lookup for SSO Admin Instance[0]."
  type        = string
  default     = ""
}

# GROUP NAME
variable "group_name" {
  description = "(Required, Forces new resource) The entity type for which the assignment will be created. Valid values Principal ID, uses AWS Identity Store Data Lookup by DisplayName."
  type        = string
}

# PRINCIPAL TYPE (GROUP)
variable "principal_type" {
  description = "(Required, Forces new resource) The entity type for which the assignment will be created. Valid values: USER, GROUP. Defaults to GROUP."
  type        = string
  default     = "GROUP"
}

# TARGET ID (AWS_ACCOUNT_ID)
variable "target_id" {
  description = "(Required, Forces new resource) An AWS account identifier, typically a 10-12 digit string."
  type        = string
}

# TARGET TYPE (AWS_ACCOUNT)
variable "target_type" {
  description = "(Optional, Forces new resource) The entity type for which the assignment will be created. Valid values: AWS_ACCOUNT"
  type        = string
  default     = "AWS_ACCOUNT"
}

# GROUP PERMISSION_SET ASSIGNMENTS
variable "group_assignments" {
  description = "(Required) Map of AWS Account Names and SSO Permission Sets" 
  type        = map(string)
}
