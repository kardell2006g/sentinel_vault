terraform {
  cloud {
    organization = "gekk0"

    workspaces {
      name = "vault_test10"
    }
  }
}



terraform {
  required_providers {
    vault = "~> 3.10.0"
  }
}


provider "vault" {}



resource "vault_auth_backend" "aws" {
  type = "aws"
}

resource "vault_aws_auth_backend_role" "example" {
  backend                         = vault_auth_backend.aws.path
  role                            = "test-role"
  auth_type                       = "iam"
  bound_ami_ids                   = ["ami-8c1be5f6"]
  bound_account_ids               = ["123456789012"]
  bound_vpc_ids                   = ["vpc-b61106d4"]
  bound_subnet_ids                = ["vpc-133128f1"]
  bound_iam_role_arns             = ["arn:aws:iam::123456789012:role/MyRole"]
  bound_iam_instance_profile_arns = ["arn:aws:iam::123456789012:instance-profile/MyProfile"]
  inferred_entity_type            = "ec2_instance"
  inferred_aws_region             = "us-east-1"
  token_ttl                       = 60
  token_max_ttl                   = 120
  token_policies                  = ["default", "dev", "prod"]
  bound_iam_principal_arns         = ["*"]
}