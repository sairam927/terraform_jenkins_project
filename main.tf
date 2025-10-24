resource "aws_vpc" "project_vpc" {
    cidr_block = var.aws_cidr
}
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = var.sub1
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true  
}
resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = var.sub2
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
  
}
resource "aws_internet_gateway" "ig1" {
    vpc_id = aws_vpc.project_vpc.id
  
}
resource "aws_route_table" "route1" {
    vpc_id = aws_vpc.project_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig1.id
    }

}
resource "aws_route_table_association" "rta1"{
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.route1.id
    }
resource "aws_route_table_association" "rta2"{
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.route1.id
    }
resource "aws_security_group" "mysg" {
    vpc_id = aws_vpc.project_vpc.id
    ingress{
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    ingress{
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }


  
}
resource "aws_s3_bucket" "bucket1"{
    bucket = "terraformsairam9908701714"
}
resource "aws_instance" "web1" {
    ami="ami-052064a798f08f0d3"
    instance_type="t2.micro"
    vpc_security_group_ids=[aws_security_group.mysg.id]
    subnet_id=aws_subnet.subnet1.id
    user_data= (file("${path.module}/userdata.sh"))
}
