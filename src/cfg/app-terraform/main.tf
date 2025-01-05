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

resource "docker_image" "frontend_image" {
  name         = "nginx"
  keep_locally = true
}

resource "docker_container" "frontend_container" {
  image = docker_image.frontend_image.image_id
  name  = "cyc_frontend_2025"

  ports {
    internal = 80
    external = 8000
  }

  network_mode = "bridge"
}

resource "docker_image" "backend_image" {
  name         = "nginx"
  keep_locally = true
}

resource "docker_container" "backend_container" {
  image = docker_image.backend_image.image_id
  name  = "cyc_backend_2025"

  ports {
    internal = 80
    external = 3001
  }

  network_mode = "bridge"
}
