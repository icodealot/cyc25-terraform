terraform {
  required_version = ">= 1.10"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6.0"
    }
  }
}

variable "docker_host" {
  type = string
  description = "Docker host to use for container operations"
  default = "npipe:////.//pipe//docker_engine"
}

provider "docker" {
  host = var.docker_host
}

