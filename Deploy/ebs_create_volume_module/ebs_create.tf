# Vars
variable availability_zone {}
variable size {}
variable volume_tag_name {}
variable volume_tag_value {}


# Ebs volume for first instance
resource "aws_ebs_volume" "ebs_volume_1" {    
    availability_zone = var.availability_zone
    size = var.size

    tags = {
        "${var.volume_tag_name}" =  "${var.volume_tag_value}"
    }
}

# Create snapshot for volume 1
# resource "aws_ebs_snapshot" "snapshot_for_ebs_1"{
#     volume_id = aws_ebs_volume.ebs_volume_1.id
# }


# Ebs volume for second instance
# resource "aws_ebs_volume" "ebs_volume_2" {    
#     availability_zone = var.availability_zone
#     size = var.size

#     tags = {
#         "${var.volume_tag_name}" =  "${var.volume_tag_value}"
#     }
# }

# Create snapshot for volume 2
# resource "aws_ebs_snapshot" "snapshot_for_ebs_2"{
#     volume_id = aws_ebs_volume.ebs_volume_2.id
# }

# # Ebs volume for third instance
# resource "aws_ebs_volume" "ebs_volume_3" {    
#     availability_zone = var.availability_zone
#     size = var.size

#     tags = {
#         "${var.volume_tag_name}" =  "${var.volume_tag_value}"
#     }
# }

# Create snapshot for volume 3
# resource "aws_ebs_snapshot" "snapshot_for_ebs_3"{
#     volume_id = aws_ebs_volume.ebs_volume_3.id
# }

output "ebs_volume_id_1" {
    value = aws_ebs_volume.ebs_volume_1.id
}

output "ebs_snapshot_id_1" {
    value = aws_ebs_snapshot.snapshot_for_ebs_1.id
}

# output "ebs_volume_id_2" {
#     value = aws_ebs_volume.ebs_volume_2.id
# }

# output "ebs_snapshot_id_2" {
#     value = aws_ebs_snapshot.snapshot_for_ebs_2.id
# }

# output "ebs_volume_id_3" {
#     value = aws_ebs_volume.ebs_volume_id_3.id
# }

# output "ebs_snapshot_id_3" {
#     value = aws_ebs_snapshot.snapshot_for_ebs_3.id
# }
