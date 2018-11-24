terraform {
  backend "s3" {
    region = "us-east-2"
    bucket = "test-remote-tf-state-files"
    key = "state.tfstate"
    encrypt = true    #AES-256 encryption
  }
}