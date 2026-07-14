variable "vpc_db_name" {
  type        = string
  default     = "develop-b"
  description = "VPC network & subnet name"
}
variable "db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name of the VM"
}
variable "vms_resources" {
  description = "Resources for all vms"
  type        = map(map(number))
  default     = {
    vm_web_resources = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    vm_db_resources = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}
variable "common_metadata" {
  description = "metadata for all vms"
  type        = map(string)
  default     = {
    serial-port-enable = "1"
    ssh-keys          = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEtB4gBn4YK3amF4cqpIB6iC1TbCjtg7BnnWka1mskrt asya-10@ubuntu"
  }
}
