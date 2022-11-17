terraform {
  cloud {
    organization = "gekk0"

    workspaces {
      name = "vault_test8"
    }
  }
}



terraform {
  required_providers {
    vault = "~> 3.10.0"
  }
}


provider "vault" {}

resource "vault_jwt_auth_backend" "oidc" {
  path = "oidc"
  default_role = "test-role"
  jwks_url    = "https://adamwashere.com"
  bound_issuer          = "https://adamwashere.com/"
}

resource "vault_jwt_auth_backend_role" "example" {
  backend         = vault_jwt_auth_backend.oidc.path
  role_name       = "test-role"
  token_policies  = ["default", "dev", "prod"]

  user_claim            = "https://vault/user"
  role_type             = "oidc"
  allowed_redirect_uris = ["http://localhost:8200/ui/vault/auth/oidc/oidc/callback"]
  #bound_claims = {
   # color = "red,green,blue"
    #}
  #bound_subject = "red"
  }