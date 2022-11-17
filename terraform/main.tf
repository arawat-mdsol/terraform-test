terraform {


  backend "s3" {
    // Utilizes partial configuration.
    //
    // Pass configuration in on the command-line so that
    // configuration can be done per environment.
    // Example:
    // terraform init \
    //  -backend-config="bucket=meds-green" \
    //  -backend-config="key=${MEDISTRANO_STAGE}/terraform/medsapibatch" \
    // -backend-config="region=us-east-1"
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      # Need 2.31 or later for extended lambda function security group timeout
      # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
      version = ">= 2.31.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment  = var.environment
      HostStage    = var.host_stage_tag
      OwnerContact = var.owner_contact_tag
      Product      = var.product_tag
      Region       = var.aws_region
      Tenant       = "medidata"
    }
  }
}
