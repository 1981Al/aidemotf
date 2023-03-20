#https://github.com/gruntwork-io/terragrunt/issues/2107
# Generate Azure providers
# live/terragrunt.hcl
generate "providers" {
  path      = "terraform.providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        azurerm = {
          source = "hashicorp/azurerm"
          version = ">=3.10.0"
        }
        azuread = {
            source = "hashicorp/azuread"
            version = ">=2.20.0"
        }
      }
    }
    provider "azurerm" {
        features {}
        client_id            = "${local.client_id}"
        client_secret        = "${local.client_secret}"
        tenant_id            = "${local.tenant_id}"
        subscription_id      = "${local.subscription_id}"
    }
    provider "azuread" {
    }
EOF
}

locals {
  # Parse the file path we're in to read the env name: e.g., env
  # will be "dev" in the dev folder, "stage" in the stage folder,
  # etc.
  parsed = regex(".*/live/(?P<env>.*?)/.*", get_terragrunt_dir())
  env    = local.parsed.env
  client_id = ""
  client_secret = ""
  tenant_id = "93f33571-550f-43cf-b09f-cd331338d086"
  subscription_id   = "353a6255-27a8-4733-adf0-1c531ba9f4e9"
}

# Configure SA as a backend
remote_state {
    backend = "azurerm"
    config = {
        tenant_id       = "93f33571-550f-43cf-b09f-cd331338d086"
        subscription_id = "353a6255-27a8-4733-adf0-1c531ba9f4e9"
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "RG_tfstate"
        storage_account_name = "demostoragetfsate"
        container_name = "tfstate"
    }
    generate = {
        path = "backend.tf"
        if_exists = "overwrite"
    }
}

