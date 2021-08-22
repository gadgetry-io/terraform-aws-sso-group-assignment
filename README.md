# terraform-aws-sso-group-assignment

[Gadgetry's](https://gadgetry.io) Terraform AWS SSO Group Assignment Module

This module is designed to be used with Gadgetry's [terraform-aws-sso-permission-set](https://github.com/gadgetry-io/terraform-aws-sso-permission-set) module. If you are using an SSO External Identity Provider (IdP) with SCIM enabled the `group_name` would be the groups you are importing from your IdP into AWS Single Sign-On (SSO).

## Usage

### Administrator

**Provision AWSAdministrator Permission Set**

    module "AWSAdministrator" {
      source = ".github.com/gadgetry-io/aws/sso-permission-set"
      version = "1.0.0"

      name        = "AWSAdministrator"
      description = "AWSAdministrator provides administrator access within an account, but no ability to manage users, roles, or orgs"

      managed_policy_arns = [
        "arn:aws:iam::aws:policy/AdministratorAccess",
      ]
    }

**Provision ExampleAdministrator SSO Group for Dev, Test, and Prod Accounts**

    module "ExampleAdministrator" {
      source = ".github.com/gadgetry-io/aws/sso-group-assignment"
      version = "1.0.0"

      group_name = "ExampleAdministrator"

      group_assignments = {
        "Example_DEV" = module.AWSAdministrator.name
        "Example_TST" = module.AWSAdministrator.name
        "Example_PRD" = module.AWSAdministrator.name
      }
    }

### Developer

**Provision AWSDeveloper Permission Set**

    module "AWSDeveloper" {
      source = ".github.com/gadgetry-io/aws/sso-permission-set"
      version = "1.0.0"

      name        = "AWSDeveloper"
      description = "AWSDeveloper provides PowerUser access to AWS services and resources, but does no allow management of users and groups."

      managed_policy_arns = [
        "arn:aws:iam::aws:policy/PowerUserAccess",
      ]
    }

**Provision AWSSupport Permission Set**

    module "AWSSupport" {
      source = ".github.com/gadgetry-io/aws/sso-permission-set"
      version = "1.0.0"

      name        = "AWSSupport"
      description = "AWSSupport grants permissions to troubleshoot and resolve issues in an AWS account. Also enables permissions to contact AWS support to create and manage cases in addition to read-only access to AWS services and resources."

      managed_policy_arns = [
        "arn:aws:iam::aws:policy/ReadOnlyAccess",
        "arn:aws:iam::aws:policy/job-function/SupportUser",
      ]
    }

**Provision ExampleDeveloper SSO Group for Dev, Test, and Prod Accounts** 

    module "ExampleDeveloper" {
      source = ".github.com/gadgetry-io/aws/sso-group-assignment"
      version = "1.0.0"

      group_name = "ExampleDeveloper"

      group_assignments = {
        "Example_DEV" = module.AWSDeveloper.name
        "Example_TST" = module.AWSSupport.name
        "Example_PRD" = module.AWSSupport.name
      }
    }

