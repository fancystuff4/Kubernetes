# Terraform Remote State Datasource
data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "../2demo/terraform.tfstate" # path where cluster terraform.tfstate file is present to get credential  to login into cluster to create components.  
   }
}
