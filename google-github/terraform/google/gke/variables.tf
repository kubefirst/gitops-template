variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
}

variable "google_region" {
  description = "Google Region"
  type        = string
}

variable "node_type" {
  description = "Instance type to use on cluster Nodes."
  type        = string

  default = "<NODE_TYPE>"
}

variable "network" {
  description = "The network to use with the cluster."
  type        = string
}

variable "node_count" {
  description = "The node count per zone for the cluster."
  type        = string
  default = "<NODE_COUNT>"
}

variable "project" {
  description = "Google Project ID"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork to use with the cluster."
  type        = string
}
