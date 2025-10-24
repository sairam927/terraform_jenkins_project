variable "aws_cidr" {
    description = "this is the cidr_block for vpc"
    type = string
    default = "10.0.0.0/16"
  
}
variable "sub1" {
    type = string
    default = "10.0.1.0/24"
  
}
variable "sub2" {
    type=string 
    default = "10.0.2.0/24"
  
}