module "s3_bucket" {
  source    		= "git::https://github.com/cloudposse/terraform-aws-lb-s3-bucket.git?ref=tags/0.1.0"
  namespace 		= "${var.namespace}"
  stage     		= "${terraform.workspace}"
  name      		= "${lookup(local.context_variables[terraform.workspace], "access_logs_bucket_name")}" 
  region    		= "${var.region}"
  force_destroy 	= "${terraform.workspace == "dev" ? "true" : "false"}"
}