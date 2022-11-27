# VARS
variable instance_1_id {}
# variable instance_2_id {}
# variable instance_3_id {}

variable ebs_volume_id_1 {}
# variable ebs_volume_id_2 {}
# variable ebs_volume_id_3 {}

# Attach instance 1 to volume 1
resource "aws_volume_attachment" "ebs_attachment_1" {
    device_name = "/dev/sdh"
    volume_id = var.ebs_volume_id_1
    instance_id = var.instance_1_id
}


# # Attach instance 2 to volume 2
# resource "aws_volume_attachment" "ebs_attachment_2" {
#     device_name = "/dev/sdh"
#     volume_id = var.ebs_volume_id_2
#     instance_id = var.instance_2_id
# }

# # Attach instance 3 to volume 3
# resource "aws_volume_attachment" "ebs_attachment_3" {
#     device_name = "/dev/sdh"
#     volume_id = var.ebs_volume_id_3
#     instance_id = var.instance_2_id
# }