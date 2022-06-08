data "yandex_compute_image" "app-1" {
  family = "lemp"
}

resource "yandex_compute_instance" "app-1" {
  name = "app-1"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.app-1.id
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/yc.pub")}"
  }
}

data "yandex_compute_image" "app2" {
  family = "lamp"
}

resource "yandex_compute_instance" "app-2" {
  name = "app-2"
  zone = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.app2.id
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-b
    subnet_id = yandex_vpc_subnet.subnet-b.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/yc.pub")}"
  }
}