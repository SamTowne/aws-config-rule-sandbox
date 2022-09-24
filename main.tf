locals {
  project_name = "aws-config-rule-sandbox"
  account_id = data.aws_caller_identity.current.account_id
}

#################
### Bootstrap ###
#################

# Build an S3 bucket and DynamoDB for Terraform state and locking
module "bootstrap" {
  source                  = "./modules/bootstrap"
  tfstate_bucket          = "${local.project_name}-${local.account_id}-terraform-tfstate"
  tf_lock_dynamo_table    = "${local.project_name}-${local.account_id}-dynamodb-terraform-locking"
}

############################
### Terraform S3 Backend ###
############################
# This should be commented out for the first terraform apply so that the tfstate bucket and locking table can be built. After the initial apply, uncomment the s3 backend code and run another apply.
terraform {
#   backend "s3" {
#     bucket         = "${local.project_name}-${local.account_id}-terraform-tfstate"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "${local.project_name}-${local.account_id}-dynamodb-terraform-locking"
#     encrypt        = true
#   }
}

#################
### Providers ###
#################

# Credentials are exported or retrieve from an external store like Hashicorp Vault

provider "aws" {
  region  = "us-east-1"

  default_tags {
   tags = {
     Terraform   = "true"
     Owner       = "${local.project_name}"
     Project     = "${local.project_name}"
   }
 }
}