terraform {
  required_version = ">= 1.10"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

data "docker_image" "frontend_image" {
  name = "nginx"
}

resource "docker_container" "frontend_container" {
  image = data.docker_image.frontend_image.id
  name  = "cyc_frontend_2025"

  ports {
    internal = 80
    external = 3001
  }

  network_mode = "bridge"
}

data "docker_image" "backend_image" {
  name = "cyc-backend:latest"
}

resource "docker_container" "backend_container" {
  image = data.docker_image.backend_image.id
  name  = "cyc_backend_2025"

  ports {
    internal = 8000
    external = 8000
  }

  network_mode = "bridge"
}
