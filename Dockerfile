ARG OS_IMAGE=ubuntu
FROM $OS_IMAGE

ARG USERNAME=ansible

RUN [ -f /etc/lsb-release ] \
  # Ubuntu
  && printf "PKGMANAGER='apt'\nUSERGROUP='sudo'\nCLEANUP='clean'" > /tmp/OSvars \
  # Centos
  || printf "PKGMANAGER='yum'\nUSERGROUP='wheel'\nCLEANUP='clean all'" > /tmp/OSvars

RUN bash -c "source /tmp/OSvars \
&& \${PKGMANAGER} update -y && \${PKGMANAGER} install -y \
   python3 \
   openssh-server \
   sudo \
&& \${PKGMANAGER} \${CLEANUP}" \
&& rm -rf /var/lib/apt/lists/* /var/cache/yum

RUN bash -c "source /tmp/OSvars \
&& useradd -m -s /bin/bash -g \${USERGROUP}  \${USERNAME} " \
&& echo "${USERNAME}:${USERNAME}" | chpasswd \
&& sudo -u ${USERNAME} mkdir -p /home/${USERNAME}/.ssh \
&& mkdir -p /var/run/sshd \
&& /usr/bin/ssh-keygen -A

EXPOSE 80 22 443

CMD ["/usr/sbin/sshd", "-D"]