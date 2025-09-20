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

# A moved block can be added for a release and removed later
# to let Terraform know about this refactor for example:
# moved {
#   from = docker_container.backend_container
#   to = module.api_backend.docker_container.container
# }

module "api_backend" {
  source = "./modules/container"

  image_name    = "cyc-backend:latest"
  name          = "cyc_backend_2025-${var.stage}"
  internal_port = 8000
  external_port = local.service_port
}