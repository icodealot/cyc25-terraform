data "docker_image" "backend_image" {
  name = "cyc-backend:latest"
}

locals {
  service_port = 8080
}

resource "docker_container" "backend_container" {
  image = data.docker_image.backend_image.id
  name  = "cyc_backend_2025-dev"

  ports {
    internal = 8000
    external = local.service_port
  }

  network_mode = "bridge"

  lifecycle {
    ignore_changes = [ pid_mode, ulimit ]
  }
}
