terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~>0.61.0"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "3.16.1"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.yc_service_accout_key
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = "ru-central1-a"
}

provider "gitlab" {
  token    = var.gitlab_token
  base_url = "https://gitlab.rebrainme.com/api/v4/"
}

module "yandex_compute" {
  source = "./modules/yandex_compute"

  for_each = var.instances

  instance_count          = each.value.instance_count
  instance_cores          = each.value.instance_cores
  instance_memory         = each.value.instance_memory
  instance_disk_size      = each.value.instance_disk_size

  instance_type     = each.key
}

resource "local_file" "inventory" {
  content = templatefile(
    "${path.module}/templates/inventory.tftpl", {
      app_ips = flatten(module.yandex_compute.*.app.external_ip)
      lb_ips = flatten(module.yandex_compute.*.lb.external_ip)
      log_ips = flatten(module.yandex_compute.*.log.external_ip)
      prom_ips = flatten(module.yandex_compute.*.prom.external_ip)
  })
  filename = "${path.module}/../inventory/dev"
}



resource "time_sleep" "wait_for_vms_ready" {
  create_duration = "2m"
  depends_on = [
    local_file.inventory,
  ]
}

resource "null_resource" "AnsiblePlaybook" {
  provisioner "local-exec" {
    command = "ansible-playbook -i '${path.module}/../inventory/dev' '${path.module}/../ansible/do-final.yml' --vault-password-file ~/.keys/vault_password"
  }
  depends_on = [
    local_file.inventory,
    time_sleep.wait_for_vms_ready
  ]
}
