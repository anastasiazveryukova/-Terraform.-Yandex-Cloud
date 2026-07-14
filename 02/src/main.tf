resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}
resource "yandex_vpc_subnet" "develop2" {
  name            = var.vpc_name2
  zone            = var.default_zone2
  network_id      = yandex_vpc_network.develop.id
  v4_cidr_blocks  = var.default_cidr2
}
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "develop" {
  name = local.vm_develop_lname
  #name        = var.vm_web_name
  resources {
    cores         = var.vms_resources.vm_web_resources.cores
    #cores         = var.vm_web_cores
    memory        = var.vms_resources.vm_web_resources.memory
    #memory        = var.vm_web_memory
    core_fraction = var.vms_resources.vm_web_resources.core_fraction
    #core_fraction = var.vm_web_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = var.common_metadata
/*
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
*/
}
data "yandex_compute_image" "ubuntu2" {
  family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "develop2" {
  name = local.vm_develop2_lname
  #name        = var.vm_db_name
  resources {
    cores         = var.vms_resources.vm_db_resources.cores
    #cores         = var.vm_db_cores
    memory        = var.vms_resources.vm_db_resources.memory
    #memory        = var.vm_db_memory
    core_fraction = var.vms_resources.vm_db_resources.core_fraction
    #core_fraction = var.vm_db_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = var.common_metadata
/*
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
*/
}
