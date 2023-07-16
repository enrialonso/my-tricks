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

- ### Build a public key form private key:

    `ssh-keygen -f key.pem -y`

- ### Send logs to AWS CloudWatch form NGINX:

    The EC2 instance need permisions to send logs to cloudwatch first.
        
    ```bash

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
    ./awslogs-agent-setup.py -n -r <REGION> -c conf-aws-logs
    echo END

    ```
### Use playwright-python with sock5 Tor proxy:

first start a docker for Tor:

`docker run -d --name tor-socks-proxy -p 127.0.0.1:9150:9150/tcp peterdavehello/tor-socks-proxy:latest`

Python script for test:

```python
from playwright.sync_api import sync_playwright
from time import sleep


with sync_playwright() as p:
    browser = p.chromium.launch(headless=False, proxy={"server": 'socks5://127.0.0.1:9150'})
    page = browser.new_page()
    page.goto('https://check.torproject.org/')
    sleep(5)
    browser.close()
```
### Install Postman .deb

##### Source
```bash
https://gist.github.com/SanderTheDragon/1331397932abaa1d6fbbf63baed5f043
```
##### Command
```bash
curl https://gist.githubusercontent.com/SanderTheDragon/1331397932abaa1d6fbbf63baed5f043/raw/postman-deb.sh | sh
```

#### Libraries can be necessary for manage multi python version on the same machine:

```bash
sudo apt install \
    build-essential \
    curl \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    make \
    tk-dev \
    wget \
    xz-utils \
    zlib1g-dev
```
