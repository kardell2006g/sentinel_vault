terraform {
  cloud {
    organization = "gekk0"

    workspaces {
      name = "vault_test5"
    }
  }
}



terraform {
  required_providers {
    vault = "~> 3.10.0"
  }
}


provider "vault" {}


resource "vault_namespace" "parent" {
  path = "parent"
}

