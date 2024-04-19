#terraform first call
terraform {
  required_providers {
    #nutanix provider // library
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.2.0"
    }
  }
}
#data getters
data "nutanix_cluster" "cluster" {
  cluster_id = var.cluster_id
}
data "nutanix_subnet" "subnet" {
  subnet_name = var.subnet_name
}
#conections
provider "nutanix" {
  #user credentials
  username     = var.user
  password     = var.password
  endpoint     = var.endpoint
  insecure     = true
  wait_timeout = 60
}

#vm creation with variables from terraform.tfvars
resource "nutanix_virtual_machine" "vm" {
  count = var.n_vm
  #name depends on the number of vms
  name = var.n_vm != 1 ? "${var.main_vm_name}-${count.index + 1}" : var.main_vm_name
  #vms properties
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = var.n_vcpus
  num_sockets          = var.n_sockets
  memory_size_mib      = var.ram_memory_size
  guest_customization_cloud_init_user_data = "${base64encode("${file("cloud.conf")}")}" # cloud-init file reference

  #OS configuration
  disk_list {
    data_source_reference = {
      kind = var.image_type
      uuid = var.image_uuid
    }
  }
  #dynamic category used as a conditional to create or not a category
  dynamic "categories" {
    for_each = var.category_name != "" ? [1] : []
    content {
      name  = var.category_name
      value = var.category_value
    }
  }
  #disk configuration
  disk_list {
    disk_size_mib = var.disk_size
    device_properties {
      device_type = var.disk_type
      disk_address = {
        "adapter_type" = var.disk_adapter_type
        "device_index" = var.disk_device_index
      }
    }
  }
  #network configuration
  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }
}
