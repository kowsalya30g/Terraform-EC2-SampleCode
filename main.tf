provider "aws" {
    access_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXxxx"
    region = "us-east-2"
  
}

module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = "10.0.0.0/16"
}

module "subnet" {
     source = "./modules/subnet"
     vpc_id = "${module.vpc.vpc_id}"
     cidr_block = "10.0.1.0/24"
     availability_zone = "us-east-2a"

}

module "security-group" {
    source = "./modules/security-group"
    name = "allow web traffic"
    description = "allow tls inbound traffic"
    vpc_id = "${module.vpc.vpc_id}"
  
}

module "ec2" {
    source = "./modules/ec2"
    ami_id = "ami-074cce78125f09d61"
    instance_type = "t2.micro"
    availability_zone = "us-east-2a"
    key_name = "awsec2key1"
  
}
