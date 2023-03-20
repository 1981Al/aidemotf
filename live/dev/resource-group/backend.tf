terraform {
  backend "azurerm" {
    container_name       = "tfstate"
    key                  = "dev/resource-group/terraform.tfstate"
    resource_group_name  = "RG_tfstate"
    storage_account_name = "demostoragetfsate"
    subscription_id      = "353a6255-27a8-4733-adf0-1c531ba9f4e9"
  }
}