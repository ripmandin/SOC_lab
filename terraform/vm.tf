
resource "yandex_compute_instance" "pupil" {
  name = "pupil1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8smb7fj0o91i68s15v"
      size = "50"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.elk.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_compute_instance" "server" {
  name = "server"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8smb7fj0o91i68s15v"
      size = "50"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.elk.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}


output "internal_ip_address_pupil" {
  value = yandex_compute_instance.pupil.network_interface.0.ip_address
}

output "internal_ip_address_server" {
  value = yandex_compute_instance.server.network_interface.0.ip_address
}


output "external_ip_address_pupil" {
  value = yandex_compute_instance.pupil.network_interface.0.nat_ip_address
}

output "external_ip_address_server" {
  value = yandex_compute_instance.server.network_interface.0.nat_ip_address
}
