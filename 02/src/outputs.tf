output "vm_external_ip_address_develop" {
value = yandex_compute_instance.develop.network_interface[0].nat_ip_address
description = "vm external ip"
}

output "vm_external_ip_address_develop2" {
value = yandex_compute_instance.develop2.network_interface[0].nat_ip_address
description = "vm external ip"
}
