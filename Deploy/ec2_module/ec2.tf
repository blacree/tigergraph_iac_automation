# Vars
variable subnet_id {}
variable image_id {}
variable security_group_id {}
variable key_name {}
variable instance_type {}
variable instance_tag_value {}

# First instance
resource "aws_instance" "instance_1" {
    ami = var.image_id
    subnet_id = var.subnet_id
    security_groups = [var.security_group_id]
    key_name = var.key_name
    instance_type = var.instance_type
    # associate_public_ip_address = true

    tags = {
      "Name" = "${var.instance_tag_value}"
    }
}

# Second instance
resource "aws_instance" "instance_2" {
    ami = var.image_id
    subnet_id = var.subnet_id
    security_groups = [var.security_group_id]
    key_name = var.key_name
    instance_type = var.instance_type
    # associate_public_ip_address = true

    tags = {
      "Name" = "${var.instance_tag_value}"
    }
}

# Third instance
resource "aws_instance" "instance_3" {
    ami = var.image_id
    subnet_id = var.subnet_id
    security_groups = [var.security_group_id]
    key_name = var.key_name
    instance_type = var.instance_type
    # associate_public_ip_address = true

    tags = {
      "Name" = "${var.instance_tag_value}"
    }
}


output "instance_1_id"{
    value = aws_instance.instance_1.id
}

output "private_ip_1"{
    value = aws_instance.instance_1.private_ip
}


output "instance_2_id"{
    value = aws_instance.instance_2.id
}

output "private_ip_2"{
    value = aws_instance.instance_2.private_ip
}



output "instance_3_id"{
    value = aws_instance.instance_3.id
}

output "private_ip_3"{
    value = aws_instance.instance_3.private_ip
}
