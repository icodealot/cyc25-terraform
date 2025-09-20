data "docker_image" "backend_image" {
  name = "cyc-backend:latest"
}

resource "docker_container" "backend_container" {
  image = data.docker_image.backend_image.id
  name  = "cyc_backend_2025"

  ports {
    internal = 8000
    external = 8080
  }

  network_mode = "bridge"
}
