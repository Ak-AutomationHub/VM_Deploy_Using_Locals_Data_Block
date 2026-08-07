resource "azurerm_public_ip" "pip" {
  for_each = local.public_ips

  name = each.value.name

  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
  tags                = each.value.tags
}
