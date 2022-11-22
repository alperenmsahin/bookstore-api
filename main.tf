data "aws_vpc" "selected" {
  default = true

}

data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

}

data "aws_ami" "amazon-linux-2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "bookstore-server" {
  instance_type   = "t2.micro"
  ami             = data.aws_ami.amazon-linux-2.id
  key_name        = "thomashamilton"
  vpc_security_group_ids = [ aws_security_group.server-sg.id ]
  tags = {
    "Name" = "Web Server of Bookstorer"
  }
  user_data = filebase64("userdata.sh")
}


output "ip-adress" {
  value = aws_instance.bookstore-server.public_ip
}

