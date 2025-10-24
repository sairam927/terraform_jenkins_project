terraform {
  backend "s3" {
    bucket = "terraform58" # change this
    region = "us-eat-1"
  }
}