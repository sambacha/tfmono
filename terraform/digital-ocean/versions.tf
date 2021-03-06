
terraform {
  required_version = ">= 0.13"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "= 2.5.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "= 2.10.1"
    }
    ansible = {
      source  = "nbering/ansible"
      version = " = 1.0.4"
    }
  }
}
