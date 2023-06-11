# AWS-terraform for creating a jump-host with a static IP address

### Introduction
Imagine a situation in which you get granted access to a VM by IP-whitelisting, however your Internet Service Provider (ISP)
only provides you with a dynamic IP address that rotates every few days. You can either bother the engineers responsible for
IP-whitelisting every now and then, or come up with another solution. I chose the latter by using an AWS server (EC2 instance)
to function as a jump-host. As AWS provides you with the opportunity to fix the IP address of the EC2 instance, the only 
thing I had to do was get the IP of the EC2 instance whitelisted and create a tunnel from my device, via the EC2 instance to the VM.

However, to comply with the security rules, I wanted the EC2 instance to only allow traffic from my own device, and thus I had to
do some IP-whitelisting myself. But then in a nice automated way.

### Prerequisites
1. Spin up an EC2 instance
2. Assign a static IP to the instance (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html)
3. Get the `id` of the Virtual Private Network (`vpc`) in which the instance is running

### Solution

#### Step 1: Get your current IP address
Get the IP address of your device when starting a new terminal session by adding this little script to the `.bashrc` (or similar e.g. `.zshrc`) file
```commandline
export TF_VAR_MY_IP="$(curl -s ifconfig.me)""$(echo "/32")"
```

#### Step 2: Terraform apply
Apply the `main.tf` file, if your IP address has been changed since the last time you logged in the ingress rules for your VPC will be updated. 
The outdated IP address will be updated with your new one and you will be able to connect to the EC2 instance with your device now.

### Step 3: Create an SSH tunnel
If you intend to use the EC2 instance as a jump-host, you can now e.g. open an ssh-tunnel: `ssh -J user@jump-server  user@destination server`
