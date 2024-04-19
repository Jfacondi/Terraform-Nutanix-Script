#User credentials

user     = "User" # User name
password = "Pass" # Password

#Prism Central credentials

cluster_name  = "XXXXX"   #Cluster name
subnet_name = "XXXXXX" #Subnet name
endpoint    = "IP"     #Prism Element IP address

#VM specs

n_vm              = "2"           #Number of VMs to create
main_vm_name      = "ScripTfTest" #Starting name of the VMs
n_vcpus           = "2"           # Number of vCPUs
n_sockets         = "1"           # Number of sockets
ram_memory_size   = "1024"        # RAM size in MB
disk_size         = "50000"       # Disk size in MB
disk_type         = "DISK"        # Disk type (DISK or CDROM)
disk_adapter_type = "SCSI"        # Disk adapter type (SCSI or IDE)
disk_device_index = "1"           # Disk device index
category_name     = ""            # Category name // if not used, set to "" (empty string)
category_value    = ""            # Category value
image_type        = "image"       # Image type (image or iso)
image_uuid        = "UUID"        # Image UUID


