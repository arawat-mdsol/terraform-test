resource "aws_instance" "web" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t3.micro"
  
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled" 
        }

  tags = {
    Name = "test"
  }
}
