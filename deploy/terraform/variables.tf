variable "aws_region" {
       description = "The AWS region to create things in."
       default     = "us-east-1"
}

variable "ami_id" {
    description = "AMI for Ubuntu Ec2 instance"
    default     = "ami-08c40ec9ead489470"
}

variable "instance_type" {
    description = "instance type for ec2"
    default     =  "t2.micro"
}

variable "security_group" {
    description = "Name of security group"
    default     = "art-security-group"
}

