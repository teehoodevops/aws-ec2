

data "aws_key_pair" "Teehookeypair" {
  key_name           = "Teehookeypair"
  include_public_key = true



}
resource "aws_instance" "teehoo" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name  = "Teehookeypair"
  # vpc_security_group_ids = [aws_security_group.SG.id]


  tags = {
    Name = "webserver"
  }

}

# resource "aws_security_group_rule" "allow_ssh" {
#   type        = "ingress"
#   from_port   = 22
#   to_port     = 22
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#   # security_group_id = aws_security_group.SG.id
# }

output "instance_ip_addr" {
  value       = aws_instance.teehoo.private_ip
  description = "The private IP address of the main server instance."
}
