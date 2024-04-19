terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.2.0"
    }
  }
}

data "nutanix_cluster" "cluster" {
  name = var.cluster_name
}
data "nutanix_subnet" "subnet" {
  subnet_name = var.subnet_name
}

provider "nutanix" {
  username     = var.user
  password     = var.password
  endpoint     = var.endpoint
  insecure     = true
  wait_timeout = 60
}


resource "nutanix_virtual_machine" "vm" {
  count                = var.n_vm
  name                 = "${var.main_vm_name}-${count.index + 1}"
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = var.n_vcpus
  num_sockets          = var.n_sockets
  memory_size_mib      = var.ram_memory_size
  guest_customization_cloud_init_user_data = "${base64encode("${file("cloud.conf")}")}" # cloud-init file

  dynamic "categories" {
    for_each = var.category_name != "" ? [1] : []
    content {
      name  = var.category_name
      value = var.category_value
    }
  }
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
  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }
}