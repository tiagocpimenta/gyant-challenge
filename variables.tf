variable "region" {
  default = "eu-west-2"
}

variable "instanceTenancy" {
    default = "default"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}

variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
