/* 
Variables used in the main.tf file
provided by the user in the terraform.tfvars file
especified in order to be used in the main.tf file otherwise the code will not work
*/

variable "cluster_id" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "password" {
  type = string
}
variable "endpoint" {
  type = string
}
variable "user" {
  type = string
}
variable "n_vm" {
  type = string
}
variable "n_vcpus" {
  type = string
}
variable "main_vm_name" {
  type = string
}
variable "n_sockets" {
  type = string
}
variable "ram_memory_size" {
  type = string
}
variable "disk_size" {
  type = string
}
variable "disk_type" {
  type = string
}
variable "disk_adapter_type" {
  type = string
}
variable "disk_device_index" {
  type = string
}
variable "category_name" {
  type = string
}
variable "category_value" {
  type = string
}
variable "image_type" {
  type = string
}
variable "image_uuid" {
  type = string
}
