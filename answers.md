## Prerequisite
* [Install terrafrom] (https://www.terraform.io/intro/getting-started/install.html)
* [Install & Configure AWS CLI] (https://docs.aws.amazon.com/lambda/latest/dg/setup-awscli.html)
* [Create a AWS EC2 AMI that has httpd & datadog agent pre-backed - AMI used in this example don't have datadog agent]
* [Create a S3 bucket for terraform backend and update backend.tf region = "S3_BUCKET_REGION_NAME" bucket = "YOUR_S3_BUCKET_NAME"]

## Run below commands on shell

```shell
$ terraform init
$ terraform workspace new dev
$ terraform apply
```

## Terraform modules used
* [VPC](https://github.com/terraform-aws-modules/terraform-aws-vpc)
* [ELB](https://github.com/terraform-aws-modules/terraform-aws-elb)
* [ELB-S3-LOGS](https://github.com/cloudposse/terraform-aws-lb-s3-bucket.git?ref=tags/0.1.0)
* [EC2](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance)
* [RDS](https://github.com/terraform-aws-modules/terraform-aws-rds)