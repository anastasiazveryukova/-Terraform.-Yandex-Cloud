###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  default="b1gf4f6v9m0eqa07ndth"
}
variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  default="b1g770v52l91f3dka8dp"
}
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "vpc_name2" {
  type        = string
  default     = "develop2"
  description = "VPC network & subnet name"
}
variable "default_zone2" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr2" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

###ssh vars

variable "vms_ssh_root_key" { 
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEtB4gBn4YK3amF4cqpIB6iC1TbCjtg7BnnWka1mskrt asya-10@ubuntu"
  description = "ssh-keygen -t ed25519"
}
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name of the VM"
}
variable "vm_web_core_fraction" {
  type        = number
  default     = 5
  description = "Core fraction for the VM"
}
variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "Number of cores for the VM"
}
variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Memory size (in GB) for the VM"
}

