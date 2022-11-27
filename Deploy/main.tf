# terraform {
#   required_providers {
#       aws = {
#           source = "hashicorp/aws"
#           version = "4.41.0"
#       }
#   }
# }

# Vars

provider "aws" {
    region = "us-east-1"
    # profile = "default"
}


locals {
    # vars for ec2_instances
    subnet_id = "subnet-058f46e3fa57d3517"
    image_id = "ami-08c40ec9ead489470"
    security_group_id = "sg-0d38798cdf31d2df3"
    key_name = "blacree"
    instance_type = "t2.micro"
    instance_tag_name = "Name"
    instance_tag_value = "Testing"


    # vars for ebs_volumes
    size = 14
    availability_zone = "us-east-1b"
    volume_tag_name = "Name"
    volume_tag_value = "Testing"

    # Path to private ssh key used for the instances (locally)
    # ssh_key_file_path = "/home/ubuntu/blacree"
    ssh_key_file_path = "/root/keypair/blacree"

    # Username used by the instance
    instance_username = "ubuntu"

    # Ansible file name
    ansible_main_file = "ansible_tigergraph_config.yaml"

}

module "ebs_create_module"{
    source = "./ebs_create_volume_module"
    size = local.size
    availability_zone = local.availability_zone
    volume_tag_name = local.volume_tag_name
    volume_tag_value = local.volume_tag_value
}


module "ec2_module" {
    source = "./ec2_module"
    subnet_id = local.subnet_id
    image_id = local.image_id
    security_group_id = local.security_group_id
    key_name = local.key_name
    instance_type = local.instance_type
    instance_tag_name = local.instance_tag_name
    instance_tag_value = local.instance_tag_value
    # ebs_snapshot_id_1 = module.ebs_create_module.ebs_snapshot_id_1
    # ebs_snapshot_id_2 = module.ebs_create_module.ebs_snapshot_id_2
    # ebs_snapshot_id_3 = module.ebs_create_module.ebs_snapshot_id_3

    depends_on = [
      module.ebs_create_module
    ]
}

module "ebs_attach_module"{
    source = "./ebs_attach_volume_module"
    instance_1_id = module.ec2_module.instance_1_id
    # instance_2_id = module.ec2_module.instance_2_id
    # instance_3_id = module.ec2_module.instance_3_id
    ebs_volume_id_1 = module.ebs_create_module.ebs_volume_id_1
    # ebs_volume_id_2 = module.ebs_create_module.ebs_volume_id_2
    # ebs_volume_id_3 = module.ebs_create_module.ebs_volume_id_3
}


resource "null_resource" "specific_configuration"{

    # Confirm that ssh is ready on last machine created. It is ready on the first 2 machines if it is ready on the last machine created.
    provisioner "remote-exec" {
    inline = [
        "echo ssh is now available"
    ]

    connection {
        type = "ssh"
        user = local.instance_username
        host = module.ec2_module.private_ip_1
        # host = module.ec2_module.private_ip_3
        private_key = file(local.ssh_key_file_path)
        }
    }

    # Start main config
    # provisioner "local-exec" {
    #     command = "ansible-playbook -i ${module.ec2_module.private_ip_1},${module.ec2_module.private_ip_2},${module.ec2_module.private_ip_3} ${local.ansible_main_file}"
    # }

    depends_on = [
      module.ec2_module
    ]
}

output "instance_1_private_ip"{
    value = "Private IP_1: ${module.ec2_module.private_ip_1}"
}

# output "instance_2_private_ip"{
#     value = "Private IP_2: ${module.ec2_module.private_ip_2}"
# }

# output "instance_3_private_ip"{
#     value = "Private IP_3: ${module.ec2_module.private_ip_3}"
# }

output "ebs_volume_id_1"{
    value = module.ebs_create_module.ebs_volume_id_1
}

# output "ebs_snapshot_id_1"{
#     value = module.ebs_create_module.ebs_snapshot_id_1
# }

# output "ebs_volume_id_2"{
#     value = module.ebs_create_module.ebs_volume_id_2
# }

# output "ebs_snapshot_id_2"{
#     value = module.ebs_create_module.ebs_snapshot_id_2
# }

# output "ebs_volume_id_3"{
#     value = module.ebs_create_module.ebs_volume_id_3
# }

# output "ebs_snapshot_id_3"{
#     value = module.ebs_create_module.ebs_snapshot_id_3
# }