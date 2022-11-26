# Vars

# instance attributes for attachment
variable instance_1_id {}
# variable instance_2_id {}
# variable instance_3_id {}

# Volume attributes for attachement
variable "volume_1_id" {}
variable "volume_2_id" {}
variable "volume_3_id" {}


# Attach instance 1 to volume 1
resource "aws_volume_attachment" "ebs_attachment_1" {
    device_name = "/dev/sdh"
    volume_id = var.volume_1_id
    instance_id = var.instance_1_id
}



# # Attach instance 2 to volume 2
# resource "aws_volume_attachment" "ebs_attachment_2" {
#     device_name = "/dev/sdh"
#     volume_id = var.volume_2_id
#     instance_id = var.instance_2_id
# }



# # Attach instance 3 to volume 3
# resource "aws_volume_attachment" "ebs_attachment_3" {
#     device_name = "/dev/sdh"
#     volume_id = var.volume_3_id
#     instance_id = var.instance_3_id
# }