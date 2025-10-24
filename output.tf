output "aws_load_balancer_dns"{
    value=aws_instance.web1.public_ip
}