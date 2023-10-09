# variable "re"{
#    region = "us-east-2"
# }

variable "ami" {
  default = ["ami-036f5574583e16426", "ami-0a04068a95e6a1cde"]

}

variable "instance_type" {
  default = "t2.micro"

}


