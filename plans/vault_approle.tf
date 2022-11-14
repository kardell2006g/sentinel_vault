terraform {
  cloud {
    organization = "gekk0"

    workspaces {
      name = "vault_test3"
    }
  }
}



terraform {
  required_providers {
    vault = "~> 3.10.0"
  }
}


provider "vault" {}


resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "example" {
  backend        = vault_auth_backend.approle.path
  role_name      = "test-role"
  secret_id_ttl = "3600"
  token_policies = ["templated_secret_read_only"]
  token_max_ttl = "100000"
}
