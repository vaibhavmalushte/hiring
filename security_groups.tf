resource "aws_security_group" "elb_sg" {
  name        			= "elb_sg"
  description 			= "Allow inbound traffic to port 80"
    vpc_id      		= "${module.vpc.vpc_id}"
	
  ingress {
    from_port   		= 80
    to_port     		= 80
    protocol    		= "tcp"
    cidr_blocks 		= ["0.0.0.0/0"]
  }
egress {
    from_port       	= 0
    to_port         	= 0
    protocol        	= "-1"
    cidr_blocks     	= ["0.0.0.0/0"]
  }
  tags {
    Name = "elb_sg"
  }
}

resource "aws_security_group" "my_web_server_sg" {
  name        			= "my_web_server_sg"
  description 			= "Allow inbound traffic to port 80 from elb_sg"
    vpc_id      		= "${module.vpc.vpc_id}"
	ingress {
		from_port 		= 80
		to_port   		= 80
		protocol  		= "tcp"
		security_groups = ["${aws_security_group.elb_sg.id}"]
	}
	
  egress {
    from_port       	= 0
    to_port         	= 0
    protocol        	= "-1"
    cidr_blocks     	= ["0.0.0.0/0"]
  }
  
  tags {
    Name 				= "${var.elb_name}_${var.environment}_sg"
  }
}

resource "aws_security_group" "my_db_server_sg" {
  name        			= "my_db_server_sg"
  description 			= "Allow inbound traffic to port 3306 from my_web_server_sg"
    vpc_id      		= "${module.vpc.vpc_id}"
	ingress {
		from_port 		= 3306
		to_port   		= 3306
		protocol  		= "tcp"
		security_groups = ["${aws_security_group.my_web_server_sg.id}"]
	}
  egress {
    from_port       	= 0
    to_port         	= 0
    protocol        	= "-1"
    cidr_blocks     	= ["0.0.0.0/0"]
  }	
  tags {
    Name 				= "my_db_server_${var.environment}_sg"
  }
}

