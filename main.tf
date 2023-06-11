// Provider configuration
terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 3.0"
   }
 }
}
 

provider "aws" {
 region = "eu-central-1"
}

variable "MY_IP" {
  type = string
}

resource "aws_security_group" "allow_ssh" {
  name        = "default"
  description = "default VPC security group"
  vpc_id = "vpc-598b4c33"
  tags = {}
  tags_all = {}

  egress = [
	{
              cidr_blocks      = [
                  "0.0.0.0/0",
                ]
              description      = ""
              from_port        = 0
              ipv6_cidr_blocks = []
              prefix_list_ids  = []
              protocol         = "-1"
              security_groups  = []
              self             = false
              to_port          = 0
            },
	]
  ingress                = [
          {
              cidr_blocks      = [
                  var.MY_IP,
                ]
              description      = "Karibu"
              from_port        = 22
              ipv6_cidr_blocks = []
              prefix_list_ids  = []
              protocol         = "tcp"
              security_groups  = []
              self             = false
              to_port          = 22
            },
          ]
}
