# For example:
# terraform plan -var="stage=prod"

variable "stage" {
  type        = string
  description = "Deployment stage (dev or prod)"
  default     = "dev"
}

# Refactoring to a module means we need to tell Terraform how to
# handle the existing container. Otherwise Terraform will destroy
# the old container and create a new one. Once the move is applied
# the "moved" block can be removed in a future release.
moved {
  from = docker_container.backend_container
  to = module.dev_backend[0].docker_container.container
}

module "dev_backend" {
  count = var.stage == "dev" ? 1 : 0
  source = "./modules/container"

  image_name    = "cyc-backend:latest"
  name          = "cyc_backend_2025-${var.stage}"
  internal_port = 8000
  external_port = 8080
}

# Note, "prod" doesn't actually work in the context of trying to run
# production with this demo configuration. This is just here as an
# arbitrary example of some conditional resource. If it did work
# though, you would enable this resource by doing something like:
#     $ terraform plan -var="stage=prod"
module "prod_backend" {
  count = var.stage == "prod" ? 1 : 0
  source = "./modules/container"

  image_name    = "cyc-backend:1.0.0"
  name          = "cyc_backend_2025-${var.stage}"
  internal_port = 8000
  external_port = 8443
}
