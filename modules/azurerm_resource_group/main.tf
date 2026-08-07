resource "azurerm_resource_group" "rg" {
  for_each = local.resource_groups

  name     = each.value.name
  location = each.value.location
  tags     = each.value.tags
}
