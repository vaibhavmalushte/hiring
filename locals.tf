# Environment specific Local variables
locals {
	context_variables = {
		default={
			vpc_name 		= "dev-vpc"	
			instance_class 	= "t2.micro"
			db_instance_class 	= "db.t2.micro"
			db_username				= "ethan_hunt"
			db_password				= "MiSsIoNimPoSsIbLe"
			deletion_protection 	= "FALSE"
			access_logs_bucket_name	="0129-access-logs-bucket"	
			sub_domain				= "dev"
		}
		dev={
			vpc_name = "dev-vpc"		
			instance_class = "t2.micro"
			db_instance_class = "db.t2.micro"
			db_username				= "ethan_hunt"
			db_password				= "MiSsIoNimPoSsIbLe"			
			deletion_protection 	= "FALSE"
			access_logs_bucket_name	="0129-access-logs-bucket"
			sub_domain				= "dev"
		}
		stg = {
			vpc_name = "stg-vpc"
			instance_class = "t2.medium"
			db_instance_class = "db.t2.medium"
			db_username				= "ethan_hunt"
			db_password				= "missIoNimPoSsIbLe"			
			deletion_protection 	= "FALSE"			
			access_logs_bucket_name	="7645-access-logs-bucket-prod"
			sub_domain				= "stg"
		}
		prod = {
			vpc_name = "prod-vpc"
			instance_class = "t2.xlarge"
			db_instance_class = "db.t2.xlarge"
			db_username				= "ethan_hunt"
			db_password				= "missIONIMPoSSIble"			
			deletion_protection 	= "FALSE"
			access_logs_bucket_name	="3343-access-logs-bucket-prod"
			sub_domain				= "www"
		}
	}
}