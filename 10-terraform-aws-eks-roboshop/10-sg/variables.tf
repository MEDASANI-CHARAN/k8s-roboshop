variable "bastion_sg_name" {
  type = string
  default = "bastion"
}
variable "ingress_alb_sg_name" {
  type = string
  default = "frontend_alb"
}

variable "vpn_sg_name" {
  type = string
  default = "vpn"
}

variable "eks_control_plane_sg_name" {
  type = string
  default = "eks_control_plane"
}

variable "eks_node_sg_name" {
  type = string
  default = "eks_node"
}

variable "bastion_sg_description" {
  type = string
  default = "created sg for bastion instance"
}

variable "ingress_alb_sg_description" {
  type = string
  default = "created sg for backend-alb instance"
}

variable "vpn_sg_description" {
  type = string
  default = "created sg for vpn instance"
}

variable "eks_control_plane_sg_description" {
  type = string
  default = "created sg for eks_control_plane instance"
}

variable "eks_node_sg_description" {
  type = string
  default = "created sg for eks_node instance"
}



variable "project" {
  type = string
  default = "roboshop"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "sg_tags" {
  type = map
  default = {}
}



