terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~>0.61.0"
    }
  }
}

data "yandex_compute_image" "yc_image" {
  family    = var.image_family
  folder_id = var.image_folder_id
}

data "yandex_vpc_subnet" "yc_subnet" {
  name = var.yc_subnet
}

resource "yandex_compute_instance" "yc_instance" {
  count       = var.instance_count

  name        = "${var.prefix}-${var.instance_type}-${count.index + 1}"
  platform_id = var.platform_id
  zone        = var.instance_zone
  allow_stopping_for_update = var.allow_stopping

  resources {
    cores  = var.instance_cores
    memory = var.instance_memory
    core_fraction = var.instance_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.yc_image.id
      size = var.instance_disk_size
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.yc_subnet.id
    nat = var.allow_nat
  }

  labels = {
    task_name = var.task_name
    user_email = var.user_email
  }

  metadata = {
    ssh-keys = "${var.ssh_username}:${file("${var.ssh_pubkey}")}"
  }
}
