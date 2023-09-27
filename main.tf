## Infrastructure destroyed 9/27/2023

# #################
# ### Bootstrap ###
# #################

# # Build an S3 bucket and DynamoDB for Terraform state and locking
# module "bootstrap" {
#   source               = "./modules/bootstrap"
#   tfstate_bucket       = "aws-config-rule-sandbox-272773485930-terraform-tfstate"
#   tf_lock_dynamo_table = "aws-config-rule-sandbox-272773485930-dynamodb-terraform-locking"
# }

# # Build the IAM needed for github actions CICD
# # **IMPORTANT** Configuring this part incorrectly can compromise your AWS account, don't touch this unless you are comfortable with OIDC and federation concepts.
# module "github-actions-iam" {
#   source           = "./modules/github-actions-iam"
#   project_prefix   = "aws-config-rule-sandbox-272773485930"
#   github_workspace = "SamTowne"
#   github_repo      = "aws-config-rule-sandbox"
# }

# # module "config" {
# #   source = "./modules/config"
# # }

# ############################
# ### Terraform S3 Backend ###
# ############################
# # This should be commented out for the first terraform apply so that the tfstate bucket and locking table can be built. After the initial apply, uncomment the s3 backend code and run another apply.
# terraform {
#   backend "s3" {
#     bucket         = "aws-config-rule-sandbox-272773485930-terraform-tfstate"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "aws-config-rule-sandbox-272773485930-dynamodb-terraform-locking"
#     encrypt        = true
#   }
# }

# #################
# ### Providers ###
# #################

# # Credentials are exported or retrieve from an external store like Hashicorp Vault

# provider "aws" {
#   region = "us-east-1"

#   default_tags {
#     tags = {
#       Terraform = "true"
#       Owner     = "aws-config-rule-sandbox"
#       Project   = "aws-config-rule-sandbox"
#     }
#   }
# }