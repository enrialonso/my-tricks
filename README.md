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