############################################################
# Dockerfile文件目的是将宿主机可以ssh远程直连到Docker容器
# 基于Ubuntu系统。
############################################################
# 设置基础镜像为最新版Ubuntu系统。
FROM ubuntu
# Dockerfile的文件的作者或维护者。
MAINTAINER basedockerfile syy
# 更新仓库源列表。
RUN apt-get update
# 安装openssh程序。
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
# 取消多次登录失败后的账号锁定情况。
RUN sed -ri 's/session required    pam_loginuid.so/#session  required pam_loginuid.so/g' /etc/pam.d/sshd
# 将本机宿主机上的公钥复制到Docker容器中
ADD authorized_keys /root/.ssh/authorized_keys
ADD run.sh /run.sh
# 将run.sh脚本文件权限更改。
RUN chmod 755 /run.sh

# 分配22默认端口作为ssh远程连接端口。
EXPOSE 22
# 运行脚本文件。
CMD ["/run.sh"]  
