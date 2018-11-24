resource "aws_route53_zone" "domain" {
  name 						= "${var.main_domain}"
  tags 						= {
								Terraform 	= "true"
								Environment	= "${var.namespace}-${terraform.workspace}"
							}
}

resource "aws_route53_record" "www" {
  zone_id 					= "${aws_route53_zone.domain.zone_id}"
  name    					= "${lookup(local.context_variables[terraform.workspace], "sub_domain")}"
  type    					= "A"

  alias {
    name        			= "${module.elb_http.this_elb_dns_name}"
    zone_id     			= "${module.elb_http.this_elb_zone_id}"
    evaluate_target_health 	= true
  }
}