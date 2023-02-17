data "vault_identity_group" "admins" {
  group_name = "admins"
}

resource "vault_identity_group_member_entity_ids" "admin_membership" {
  member_entity_ids = [
    module.kbot.vault_identity_entity_id
#    , module.admin_one.vault_identity_entity_id      
  ]

  group_id = data.vault_identity_group.admins.group_id
}

variable "initial_password" {
  type    = string
  default = ""
}

module "kbot" {
  # kbot is your automation user for all automation
  # on the platform that needs a bot account
  source = "./modules/user/gitlab"

  acl_policies      = ["admin"]
  email             = "<EMAIL_ADDRESS>"
  first_name        = "Kubefirst"
  fullname          = "Kubefirst Bot"
  group_id          = data.vault_identity_group.admins.group_id
  last_name         = "Bot"
  initial_password  = var.initial_password
  username          = "kbot"
  user_disabled     = false
  userpass_accessor = data.vault_auth_backend.userpass.accessor
}

# # note: when you uncomment and change admin_one below 
# # to your admin's firstname_lastname, you must also uncomment 
# # and change the "admin_membership" list above to match your
# # individual's firstname_lastname. create as many admin modules
# # as you have admin personnel.
  
# module "admin_one" {
#   source = "./modules/user/gitlab"

#   acl_policies            = ["admin"]
#   email                   = "admin@your-company-io.com"
#   first_name              = "Admin"
#   fullname                = "Admin One"
#   group_id                = data.vault_identity_group.admins.group_id
#   last_name               = "One"
#   username                = "aone"
#   user_disabled           = false
#   userpass_accessor       = data.vault_auth_backend.userpass.accessor
# }
