terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6.0"
    }
  }
}

data "docker_image" "image" {
  name = var.image_name
}

resource "docker_container" "container" {
  image = data.docker_image.image.id
  name  = var.name

  ports {
    internal = var.internal_port
    external = var.external_port
  }

  network_mode = "bridge"

  lifecycle {
    ignore_changes = [ pid_mode, ulimit ]
  }
}
