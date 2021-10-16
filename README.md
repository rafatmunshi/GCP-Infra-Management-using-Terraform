# Infrastructure Management using Terraform IAC on Google Cloud Platform to run a Python Flask App using a private MySQL instance database, using GitLab CI/CD pipeline to manage code for different environments

This is a GitLab project which is uploaded here for reference. The link to the gitlab repo is- https://gitlab.com/rafatmunshi/secondassignment2
This project uses the Hashicorp Language (HCL) for managing the infrastructure on GCP represented by the following diagrams-

Network Diagram-
![](https://github.com/rafatmunshi/Infrastructure-Management-using-Terraform/raw/master/1.png)
Network Diagram-
![](https://github.com/rafatmunshi/Infrastructure-Management-using-Terraform/raw/master/2.png)

To run this code-
1. Install Terraform in your system
2. Run terraform init for the Terraform folder. That would create the .terraform folder
3. Run terraform plan to create the terraform plan for GCP project. If the project/account is different, need to create a service account for running apply. To create a service account in GCP- 
- In the Cloud Console, go to the Service Accounts page. (IAM & Admin -> Service Accounts)
- Click Select a project, choose a project, and click Open. 
- Find the row of the service account that you want to create a key for. 
- In that row, click the More three dots button, and then click Create key. 
- Select a Key type and click Create. 
- Clicking Create downloads a service account key file. After you download the key file, you cannot download it again.
- Make sure the key file name is correct in the terraform.tfvars file at gcp_auth_file = "....json"
4. Once plan is successful, a terraform.tfstate file is created. Run terraform apply to run the code and create the required resources.
5. Go to Google cloud console to check all the resources are created correctly.
6. Change the IP addresses in the mysqlconnect.py file to be able to run the file on the VM and connect to the mysql instance correctly for the program to run. Also correct the zone, region, subnet cidr, project name, app name, domain, environment and node count as per your requirement.
7. Check if python flask etc is installed in the VM by doing an SSH to the VM. If the terraform code was run correctly, the SSH facility should work. Once flask, mysql client and flask-mysqldb is correctly installed in the VM, upload the mysqlconnect.py file to the VM and run it.
8. Connect the vm to the mysql instance with the default username, host and password as mentioned in my-sql-instance-variables.tf and to the default database created- todo. Create a table- todo in the database todo, with user and todo columns with varchar 20 and varchar 500 sizes respectively.
9. Use CURL to the public IP of the load balancer with an argument to pass in the todo item to be inserted to the table in the mysql todo database
10. To destroy this infrastructure, run terraform destroy. The mysql instance would not be destroyed as it is made safe from the destroy due to security. You need to manually delete it from the console.
11. The network diagram for the infrastructure created is shown in the networkdiagram.pptx

