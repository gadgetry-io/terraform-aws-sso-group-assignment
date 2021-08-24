###############################################################################
### SSO ADMIN ACCOUNT ASSIGNMENT
###############################################################################

# LOOKUP AWS ORGANIZATION
data "aws_organizations_organization" "main" {}

# LOOKUP AWS SSO PERMISSION SET ARNS
data "aws_ssoadmin_permission_set" "main" {
  for_each     = var.group_assignments
  instance_arn = var.instance_arn
  name         = each.value
}

# LOOKUP AWS SSO GROUP
data "aws_identitystore_group" "main" {
  identity_store_id = var.instance_arn

  filter {
    attribute_path  = "DisplayName"
    attribute_value = var.group_name
  }
}

# SSO GROUP ASSIGNMENT
# - For a specific SSO group_name, loop through group_assignments map
#   to provision a named Permission_Set for each group to the
#   named AWS Account.
# - Data Lookups are used to find the ids and arns required
resource "aws_ssoadmin_account_assignment" "main" {
  for_each = var.group_assignments

  instance_arn       = var.instance_arn
  permission_set_arn = data.aws_ssoadmin_permission_set.main[each.key].arn

  principal_id   = data.aws_identitystore_group.main.group_id
  principal_type = var.principal_type

  target_id   = [for id, account in data.aws_organizations_organization.main.accounts : account.id if account.name == each.key][0]
  target_type = var.target_type
}

#######################################
# OUTPUTS
#######################################

output "id" {
  description = "The identifier of the SSO Group Assignment i.e. principal_id, principal_type, target_id, target_type, permission_set_arn, instance_arn separated by commas (,)."
  value       = aws_ssoadmin_account_assignment.id
}
