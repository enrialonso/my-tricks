# my-tricks

- #### Log custom script for user-data en AWS EC2:

    **Workin on:**

    - [x] Ubuntu Server 20.04 LTS (HVM)
    - [x] Ubuntu Server 18.04 LTS (HVM)
    - [x] Ubuntu Server 16.04 LTS (HVM)
    - [x] Amazon Linux 2 AMI (HVM)

    ```sh
    #!/bin/bash -ex
    exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
    echo BEGIN
    date '+%Y-%m-%d %H:%M:%S'
    echo END
    ```
    
    ssh-keygen -f key.pem -y
    
#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo BEGIN
apt update -y
apt install python nginx -y
echo "
[general]
state_file = /var/awslogs/state/agent-state
 
[/var/log/nginx/access.log]
file = /var/log/nginx/access.log
log_group_name = nginx-pro-access
log_stream_name = {instance_id}
datetime_format = %b %d %H:%M:%S

[/var/log/nginx/error.log]
file = /var/log/nginx/error.log
log_group_name = nginx-pro-error
log_stream_name = {instance_id}
datetime_format = %b %d %H:%M:%S
" > conf-aws-logs
curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
chmod +x ./awslogs-agent-setup.py
./awslogs-agent-setup.py -n -r eu-west-1 -c conf-aws-logs
echo END

