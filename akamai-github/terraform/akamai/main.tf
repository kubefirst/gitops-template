terraform {
  backend "s3" {
    bucket   = "<KUBEFIRST_STATE_STORE_BUCKET>"
    key      = "terraform/civo/terraform.tfstate"
    endpoint = "https://objectstore.<CLOUD_REGION>.civo.com"

    region = "<CLOUD_REGION>"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }
  required_providers {
    linode = {
      source = "linode/linode"
      version = "2.16.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "3.19.0"
    }
  }
}
provider "linode" {}

locals {
  # cluster_name = "<CLUSTER_NAME>"
  cluster_name = "kubefirst-test"
  kube_config_filename = "../../../kubeconfig"
}

resource "linode_lke_cluster" "kubefirst" {
    label       = local.cluster_name
    k8s_version = "1.28"
    region      = "us-central"
    tags        = ["management"]

    pool {
        # NOTE: If count is undefined, the initial node count will
        # equal the minimum autoscaler node count.
        type  = "<NODE_TYPE>" # "g6-standard-2" 4

        autoscaler {
          min = tonumber("<NODE_COUNT>") # tonumber() is used for a string token value
          max = tonumber("<NODE_COUNT>") # tonumber() is used for a string token value
        }
    }
}

resource "local_file" "kubeconfig" {
  content  = linode_lke_cluster.kubefirst.kubeconfig
  filename = local.kube_config_filename
}

