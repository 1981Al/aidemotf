//This Terraform code will create an Azure resource group named "aziademo" in the "North Europe" region.
resource "azurerm_resource_group" "aziademo" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = "demo ia terraform template"
  }
}