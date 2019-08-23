provider "aws" {
access_key = "AKIAZTIMJ7JHCYU3MWGO"
secret_key = "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"
region ="eu-west-1"

}

/*resource "aws_instance"  "prpr"{

ami = "ami-00b49e2d0e1fc7fad"
instance_type = "t2.medium"

tags={
  Name = "pr"
}
}*/
resource "aws_instance" "pr2"{

ami = "ami-00b49e2d0e1fc7fad"
instance_type = "t2.medium"
key_name= "${aws_key_pair.mykey.id}"

tags={
  Name = "prt2"
}
vpc_security_group_ids = ["${aws_security_group.prrsecgroup.id}"]
provisioner "local-exec" {
when = "create"
command = "echo $(aws_instance.pr2.public_ip}>sample.txt"
}
}
resource "aws_key_pair" "mykey" {
  key_name = "prrr"
  public_key = "${file("C:\\Users\\s.z.srinivasan\\Desktop\\mykey.pub")}"
}

resource "aws_security_group" "prrsecgroup" {
name = "prgroup"
description = "To allow traffic"

ingress{
from_port = "0"
to_port = "0"
protocol = "-1"
cidr_blocks=["0.0.0.0/0"]
}

egress{

from_port ="0"
to_port = "0"
protocol = "-1"
cidr_blocks=["0.0.0.0/0"]
}
}
output "prr" {
 value ="${aws_instance.pr2.public_ip}"
}
//terraform import "aws_eip.mypr" "eipalloc-0be8ec9ddeb78a9f9"
resource "aws_eip" "pr2" {

tags = {
 Name = "sai"
}
instance = "$(aws_instance.pr2.id}"
}

resource "aws_s3_bucket" "prr" {
   bucket= "pk" 
acl = "private"
force_destroy= "true"
}

terraform {
backend "s3" {
bucket = "pr"
key ="pprr.tfstate"
region = "eu-west-1"
}
}
}
provisioner "chef"   { 
connection {
host = "${self.public_ip}"
type ="ssh"
user = "e2c-user"
private_key = "${file("C:\\Users\\s.z.srinivasan\\Desktop\\mykey.pub")}"
}
client_options = [ "chef_license 'accept'"]
run_list = ["testenv_aws_tf_chef::default"]
recreate_client = true
node_name = "prrr"
server_url = "https://manage.chef.io/login"
user_name = "saiprasanth"
user_key = "${file("C:\\chef-starter\\chef-repo\\.chef\\saiprasanth.pem")}"
ssl_verify_mode = ":verify_none"
}
}
