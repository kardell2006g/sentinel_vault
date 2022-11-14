terraform {
  cloud {
    organization = "gekk0"

    workspaces {
      name = "vault_test2"
    }
  }
}



terraform {
  required_providers {
    vault = "~> 3.10.0"
  }
}


provider "vault" {}



resource "vault_mount" "kvv2" {
  path        = "kvv2"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

resource "vault_kv_secret_v2" "secret" {
  mount                      = vault_mount.kvv2.path
  name                       = "secret"
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(
  {
    zip       = "zap",
    foo       = "bar"
  }
  )
}
