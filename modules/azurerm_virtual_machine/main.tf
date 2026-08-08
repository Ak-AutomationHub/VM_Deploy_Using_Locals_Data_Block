resource "azurerm_network_interface" "nic" {

  for_each = local.virtual_machines

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {

    for_each = each.value.ip_configurations

    content {

      name = ip_configuration.value.name

      subnet_id = data.azurerm_subnet.data_subnet[each.key
      ].id

      private_ip_address_allocation = (
        ip_configuration.value.private_ip_address_allocation
      )

      public_ip_address_id = data.azurerm_public_ip.data_pip[each.key].id

    }
  }

  tags = each.value.tags
}

resource "azurerm_linux_virtual_machine" "vm" {

  for_each = local.virtual_machines

  name = each.value.name

  computer_name = each.value.computer_name

  resource_group_name = (
    each.value.resource_group_name
  )

  location = each.value.location
  size     = each.value.size

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  # disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    name = each.value.os_disk.name

    caching = (
      each.value.os_disk.caching
    )

    storage_account_type = (
      each.value.os_disk.storage_account_type
    )
  }

  source_image_reference {

    publisher = (
      each.value.source_image_reference.publisher
    )

    offer = (
      each.value.source_image_reference.offer
    )

    sku = (
      each.value.source_image_reference.sku
    )

    version = (
      each.value.source_image_reference.version
    )
  }

  tags = each.value.tags
}
