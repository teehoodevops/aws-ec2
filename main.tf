

data "aws_key_pair" "Teehookeypair" {
  key_name           = "Teehookeypair"
  include_public_key = true



}
resource "aws_instance" "teehoo" {
  ami           = var.ami[count.index]
  instance_type = var.instance_type
  key_name      = "Teehookeypair"
  vpc_security_group_ids = [aws_security_group.SG.id]
  count = length(var.ami)
   
  provisioner "remote-exec" {
   inline = [ 
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",

   ]
   connection {
    type = "ssh"
    user = "ec2_user"
    private_key = data.aws_key_pair.Teehookeypair
    host = self.public_ip
   }
  }

  lifecycle {
    # create_before_destroy = true

    # prevent_destroy = true

  }

  tags = {
    Name = "webserver"
  }

}
resource "aws_security_group" "SG" {

  name = "terraform-webserverSG"


  ingress {
    description = "Allow SSH"

    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }



  ingress {
    description = "Allow httpd"

    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }




  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}



# output "instance_ip_addr" {
#   value       = aws_instance.teehoo.private_ip
#   description = "The private IP address of the main server instance."
# }


