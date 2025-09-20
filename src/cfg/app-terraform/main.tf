data "docker_image" "backend_image" {
  name = "cyc-backend:latest"
}

# For example:
# terraform plan -var="stage=prod"

variable "stage" {
  type        = string
  description = "Deployment stage (dev or prod)"
  default     = "dev"
}

locals {
  service_port = var.stage == "dev" ? 8080 : 9090
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
