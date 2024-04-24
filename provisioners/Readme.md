1. Terraform provisioners - https://jhooq.com/terraform-provisioner/
2. SSH into terrafrom AWS EC2 instance - https://jhooq.com/terraform-ssh-into-...

Terraform provisioners are of three types - 
1. file 
2. local-exec 
3. remote-exec

1.File provisioner - The file provisioner will help you to copy the file securely from the local machine or development machine to the remote Ec2 instance.

2. Local provisioner - The local-exec provisioner invokes a local executable after a resource is created. This invokes a process on the machine running Terraform, not on the resource. It will help you to run the shell command onto your local machine instead of the remote EC2 instance. The local provisioners are  

3. Remote provisioner - The remote-exec provisioner invokes a script on a remote resource after it is created. This can be used to run a configuration management tool, bootstrap into a cluster, etc. It will help you to run the shell command onto the remote Ec2 instance of AWS or virtual machine of Google Cloud

In this lab session, we will go through the following steps - 

1. Create a Virtual ec2 instance on AWS.

2. Write a file provisioner to copy the file from the local development machine to the remote development machine

3. Create a key pair(public and private key) so that we can ssh into the Ec2 machine.

4. Implement a local provisioner to execute a shell command onto the local development machine 

5. Finally implement the remote the provisioner to copy the file as well as the written text into that file
