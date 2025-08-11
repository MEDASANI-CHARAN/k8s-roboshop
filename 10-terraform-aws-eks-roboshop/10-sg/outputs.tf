output "bastion_sg_id" {
  value = module.bastion.sg_id
}

output "ingress_alb_sg_id" {
  value = module.ingress_alb.sg_id
}

output "vpn_sg_id" {
  value = module.vpn.sg_id
}

output "eks_node_sg_id" {
  value = module.eks_node.sg_id
}

output "eks_control_plane_sg_id" {
  value = module.eks_control_plane.sg_id
}