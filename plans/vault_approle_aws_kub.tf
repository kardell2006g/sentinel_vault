terraform {
  cloud {
    organization = "gekk0"

    workspaces {
      name = "vault_test4"
    }
  }
}



terraform {
  required_providers {
    vault = "~> 3.10.0"
  }
}


provider "vault" {}

resource "vault_aws_secret_backend" "aws" {
  access_key = "V1"
  secret_key = "AK1A"
  default_lease_ttl_seconds = 40000
  max_lease_ttl_seconds = 900000
}

resource "vault_aws_secret_backend_role" "role" {
  backend = vault_aws_secret_backend.aws.path
  name    = "deploy"
  credential_type = "iam_user"

  policy_document = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    }
  ]
}
EOT
}



resource "vault_kubernetes_secret_backend" "config" {
  path                 = "kubernetes"
  description          = "kubernetes secrets engine description"
  kubernetes_host      = "https://127.0.0.1:61233"
  kubernetes_ca_cert   = file("./test.jwt")
  service_account_jwt  = file("./test.jwt")
  disable_local_ca_jwt = false
  default_lease_ttl_seconds = 40000
  max_lease_ttl_seconds = 900000
}

resource "vault_kubernetes_secret_backend_role" "sa-example" {
  backend                       = vault_kubernetes_secret_backend.config.path
  name                          = "service-account-name-role"
  allowed_kubernetes_namespaces = ["*"]
  token_max_ttl                 = 43200
  token_default_ttl             = 21600
  service_account_name          = "test-service-account-with-generated-token"

  extra_labels = {
    id   = "abc123"
    name = "some_name"
  }

  extra_annotations = {
    env      = "development"
    location = "earth"
  }
}
