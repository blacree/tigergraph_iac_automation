# Vars
variable availability_zone {}
variable size {}
variable volume_tag_name {}
variable volume_tag_value {}


# Ebs volume for first instance
resource "aws_ebs_volume" "ebs_voume_1" {    
    availability_zone = var.availability_zone
    size = var.size

    tags = {
        "${var.volume_tag_name}" =  "${var.volume_tag_value}"
    }
}


# Ebs volume for second instance
# resource "aws_ebs_volume" "ebs_voume_2" {    
#     availability_zone = var.availability_zone
#     size = var.size

#     tags = {
#         "${var.volume_tag_name}" =  "${var.volume_tag_value}"
#     }
# }


# # Ebs volume for third instance
# resource "aws_ebs_volume" "ebs_voume_3" {    
#     availability_zone = var.availability_zone
#     size = var.size

#     tags = {
#         "${var.volume_tag_name}" =  "${var.volume_tag_value}"
#     }
# }


output "ebs_volume_id_1" {
    value = aws_ebs_volume.ebs_voume_1.id
}

output "ebs_snapshot_id_1" {
    value = aws_ebs_volume.ebs_voume_1.snapshot_id
}

# output "ebs_volume_id_2" {
#     value = aws_ebs_volume.ebs_voume_2.id
# }

# output "ebs_snapshot_id_2" {
#     value = aws_ebs_volume.ebs_voume_2.snapshot_id
# }

# output "ebs_volume_id_3" {
#     value = aws_ebs_volume.ebs_volume_id_3.id
# }

# output "ebs_snapshot_id_3" {
#     value = aws_ebs_volume.ebs_volume_id_3.snapshot_id
# }
