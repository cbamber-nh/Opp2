######################################################################################
# VARIABLES
######################################################################################

# See [env].tfvars file for overrides of default values set here:

variable "env_name" {
  description = "The environment-specific prefix used for all resources."
  type        = string
}

variable "app_name" {
  description = "The application used in resource names: Opp."
  type        = string
  default     = "opp"
}

variable "location" {
  description = "The Azure Region in which all resources should be created."
  type        = string
  default     = "eastus"
}

variable "tags_env" {
  description = "Enviroment specific tags that will be added to all resources created."
  type = map

  validation {
        condition     = can(regex("^TECHOPS-", var.tags_env.AssetTag))
    error_message = "The tags_env variable must have valid AssetTag value, starting with \"TECHOPS-\"."
  }
}

variable "tags_common" {
  description = "Baseline tags to be added to all resources created."
  type        = map
  default     = {
    "ApplicationName"       = "Opp"
    "BusinessUnit"          = "NaviNet"
    "Creator"               = "Colin Bamber, Adrian Finnegan"
    "DR"                    = "NotEnabled"
    "DataClass"             = "Confidential"
    "DeploymentType"        = "Terraform Automation"
    "LossImpact"            = "Low"
    "Owner"                 = "rswarbrick@nanthealth.com"
    "Rebuildable"           = "Yes"
    "RequiresOffsiteBackup" = "No"
  }
}

variable "tags_non_rebuildable_resource" {
  description = "Tag that will be added to non rebuildable resource"
  type        = map
  default     = {
  "Rebuildable"           = "No"
  }
}


variable "subscription_name" {
  description = "Name of the subscription"
  type        = string
}

locals{
  tags_rebuildable_resource = merge(var.tags_common, var.tags_env)
}

locals {
  tags_non_rebuildable_resource = merge(local.tags_rebuildable_resource, var.tags_non_rebuildable_resource)
}
