## Build images 
### Ubuntu
 docker build --build-arg=OS_IMAGE=ubuntu . -t ubuntu_ansible_pipeline
### Centos
 docker build --build-arg=OS_IMAGE=centos:7 . -t centos_ansible_pipeline 
### Centos + Ubuntu
 for img in centos:7 ubuntu ; do docker build --build-arg=OS_IMAGE=$img . -t ${img%%:*}_ansible_pipeline ; done
 
## Default variables:
 User name: ansible
 
 Password: ansible
 
 User ansible has sudo permitions.
 
 If you want to update user name(password) add additional build arg eg: --build-arg=USERNAME=some-username

## Key authentication 
 docker run --rm -d -p 22122:22 -v ~/.ssh/id_rsa.pub:/home/ansible/.ssh/authorized_keys ubuntu_ansible_pipeline
 
 docker run --rm -d -p 22123:22 -v ~/.ssh/id_rsa.pub:/home/ansible/.ssh/authorized_keys centos_ansible_pipeline
