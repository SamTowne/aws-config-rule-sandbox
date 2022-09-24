# Terraform bootstrap variables
variable "tfstate_bucket" {
  description = "Name of the S3 bucket used for Terraform state storage"
}

variable "tf_lock_dynamo_table" {
  description = "Name of DynamoDB table used for Terraform locking"
}
