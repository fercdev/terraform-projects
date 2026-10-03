terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_container" "nginx_container" {
  name  = "nginx_terraform_container"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 9080
  }
}