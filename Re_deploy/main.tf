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
    subnet_id = ""
    image_id = ""
    security_group_id = ""
    key_name = ""
    instance_type = ""
    instance_tag_value = ""

    private_ip_1 = ""
    # private_ip_2 = ""
    # private_ip_3 = ""


    # vars for ebs_volumes
    ebs_volume_id_1 = ""
    # ebs_volume_id_2 = ""
    # ebs_volume_id_3 = ""

    # Path to private ssh key used for the instances (locally)
    ssh_key_file_path = ""

    # Username used by the instance
    instance_username = ""

    # Ansible file name
    ansible_main_file = "ansible_tigergraph_config.yaml"

}


module "ec2_module" {
    source = "./ec2_module"
    subnet_id = local.subnet_id
    image_id = local.image_id
    security_group_id = local.security_group_id
    key_name = local.key_name
    instance_type = local.instance_type
    instance_tag_value = local.instance_tag_value

    private_ip_1 = local.private_ip_1
    # private_ip_2 = local.private_ip_2
    # private_ip_3 = local.private_ip_3
}



module "ebs_module"{
    source = "./ebs_module"
    instance_1_id = module.ec2_module.instance_1_id
    # instance_2_id = module.ec2_module.instance_2_id
    # instance_3_id = module.ec2_module.instance_3_id
    volume_1_id = local.ebs_volume_id_1
    # volume_2_id = local.ebs_volume_id_2
    # volume_3_id = local.ebs_volume_id_3
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
        host = local.private_ip_1
        # host = module.ec2_module.private_ip_3
        private_key = file(local.ssh_key_file_path)
        }
    }

    # Start main config
    provisioner "local-exec" {
        # command = "ansible-playbook -i ${local.private_ip_1},${local.private_ip_2},${local.private_ip_3} ${local.ansible_main_file}"
        command = "ansible-playbook -i ${local.private_ip_1}, ${local.ansible_main_file}"
    }

    depends_on = [
      module.ec2_module
    ]
}

output "instance_1_private_ip"{
    value = "Private IP_1: ${local.private_ip_1}"
}

output "ebs_volume_id"{
    value = "Volume Id: ${local.ebs_volume_id_1}"
}

# output "instance_2_private_ip"{
#     value = "Private IP_2: ${local.private_ip_2}"
# }

# output "instance_3_private_ip"{
#     value = "Private IP_3: ${local.private_ip_3}"
# }
