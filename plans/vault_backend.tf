terraform {
  cloud {
    organization = "gekk0"

    workspaces {
      name = "vault_test"
    }
  }
}



terraform {
  required_providers {
    vault = "~> 3.10.0"
  }
}


provider "vault" {}



resource "vault_auth_backend" "example1" {
  type = "approle"
  path = "aws"

  tune {
    max_lease_ttl      = "90000s"
    listing_visibility = "unauth"
  }
}

resource "vault_auth_backend" "example2" {
  type = "azure"

  tune {
    max_lease_ttl      = "90000s"
    listing_visibility = "unauth"
  }
}

resource "vault_auth_backend" "example3" {
  type = "kubernetes"

  tune {
    max_lease_ttl      = "90000s"
    listing_visibility = "unauth"
  }
}