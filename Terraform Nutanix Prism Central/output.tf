output "vms_ip_address" {
  value = {
    #output the ip address of the vm created in the nutanix cluster
    for vm in nutanix_virtual_machine.vm :
    vm.name => vm.nic_list[0].ip_endpoint_list[0].ip
  }
}