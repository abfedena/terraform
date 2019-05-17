provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIO0RsmZsC+h1ftzYMlJaylhwOppyZpSIMKyQPwrkejrZImfLBvEXjKB7xvlitwKTwUqqrJrt8H0885Cus6U4ACwLeD9OkWrqZ6i3mcujg9wIKKkMyVvEbno5kiOBCCeGS/i9xDySW6LeRLCvbOzDkU2h7HEiQuYKUtVZ+D+hi/nL/GAiAM9tIY2i4ClQTIvlBwjOw0C75XokBYO0/OS6ElNfnhkC46J+afN2LV1V+c8KEINIm7K05Pn4rX6YQGoqzz2kLbdnK1MNXfRJSFxHOJa3RdyRQI/pXchg4VWqNmdiIZQH/cYV068sjWiMNk3Q/fePSrhgqyK5M9rOVfcaz root@astics-pc123"
}

resource "aws_security_group" "examplesg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0565af6e282977273"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.examplesg.id}"]
  key_name               = "${aws_key_pair.example.id}"

  tags {
    Name = "first-ec2-instance"
  }
}
