data "azurerm_subnet" "data_subnet" {
  for_each = local.virtual_machines

  name                 = each.value.ip_configurations.primary.subnet_name
  virtual_network_name = each.value.ip_configurations.primary.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "data_pip" {
  for_each = local.virtual_machines

  name                = each.value.ip_configurations.primary.public_ip_name
  resource_group_name = each.value.resource_group_name
}
