variable "virtual_machines" {
  #   description = "Linux VM and NIC configuration"

  #   type = map(object({

  #     name                = string
  #     computer_name       = string
  #     nic_name            = string
  #     resource_group_name = string
  #     location            = string
  #     size                = string

  #     admin_username = string
  #     admin_password = string

  #     ip_configurations = map(object({

  #       name = string

  #       subnet_name = string

  #       virtual_network_name = string

  #       public_ip_name = optional(string)

  #       private_ip_address_allocation = optional(
  #         string,
  #         "Dynamic"
  #       )
  #     }))

  #     os_disk = object({
  #       name                 = string
  #       caching              = string
  #       storage_account_type = string
  #     })

  #     source_image_reference = object({
  #       publisher = string
  #       offer     = string
  #       sku       = string
  #       version   = string
  #     })

  #     tags = optional(map(string), {})
  #   }))

  #   sensitive = true
}
