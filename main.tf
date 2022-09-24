#################
### Bootstrap ###
#################

# Build an S3 bucket and DynamoDB for Terraform state and locking
module "bootstrap" {
  source                  = "./modules/bootstrap"
  tfstate_bucket          = "aws-config-rule-sandbox-272773485930-terraform-tfstate"
  tf_lock_dynamo_table    = "aws-config-rule-sandbox-272773485930-dynamodb-terraform-locking"
}

############################
### Terraform S3 Backend ###
############################
# This should be commented out for the first terraform apply so that the tfstate bucket and locking table can be built. After the initial apply, uncomment the s3 backend code and run another apply.
terraform {
  backend "s3" {
    bucket         = "aws-config-rule-sandbox-272773485930-terraform-tfstate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-config-rule-sandbox-272773485930-dynamodb-terraform-locking"
    encrypt        = true
  }
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
     Owner       = "aws-config-rule-sandbox"
     Project     = "aws-config-rule-sandbox"
   }
 }
}