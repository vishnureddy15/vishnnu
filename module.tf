module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = var.vpc_name
  cidr            = var.vpc_cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = var.vpc_tags
}

module "ec2-vishnu" {
  source            = "terraform-aws-modules/ec2-instance/aws"
  instance_type     = var.instance_type
  region            = var.region
  availability_zone = var.availability_zone
  ami               = var.ami
  # subnet_id         = "subnet-eddcdzz4"
  subnet_id         = module.vpc.public_subnets[0]  # ✅ Link EC2 to first public subnet
  associate_public_ip_address = true
  tags = {
    Name        = "vishnu-instance"
    Environment = "dev"
  }
}

