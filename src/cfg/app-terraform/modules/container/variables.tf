variable "external_port" {
  type = number
  description = "External port exposed to the network"
  default = 8080
}

variable "image_name" {
  type        = string
  description = "Docker image name such as some-image:latest"
  nullable    = false
}

variable "internal_port" {
  type = number
  description = "Internal port exposed by the container"
  default = 8000
}

variable "name" {
  type        = string
  description = "Docker container name such as my_container_name"
  nullable    = false
}
