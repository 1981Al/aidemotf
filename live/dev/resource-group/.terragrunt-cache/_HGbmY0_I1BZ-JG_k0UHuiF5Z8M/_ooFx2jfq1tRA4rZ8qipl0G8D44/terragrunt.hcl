include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/resource-group"
}

inputs = {
  location = "West Europe"
  resource_group_name = "rg_iademo-dev"
}