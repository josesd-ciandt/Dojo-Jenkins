FROM mhart/alpine-node:4

RUN apk --update add openjdk8-jre openssh git && \
    rm -rf /var/cache/apk/*

USER root
ADD https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz /tmp
RUN tar -xvzf /tmp/docker-latest.tgz && mv docker/* /usr/bin/ && chmod 755 /usr/bin/docker && rm -f /tmp/docker-latest.tgz

RUN delgroup ping

# adduser - Adiciona  Usuario com shell especifico
# altera permissão do usuario pra pasta home/jenkins
# altera a senha do usuario chpasswd
# adiciona no grupo o usuario
# altera o arquivo de group adicionando usuario jenkins

RUN addgroup jenkins && \
    adduser -D jenkins -s /bin/sh -G jenkins && \ 
    chown -R jenkins:jenkins /home/jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    addgroup -g 999 $USER docker && \
    sed -ri 's/(docker:x:999:)/\1jenkins/' /etc/group

RUN ssh-keygen -A

RUN set -x && \
    echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowGroups jenkins" >> /etc/ssh/sshd_config

RUN apk --update add sudo && \
    rm -rf /var/cache/apk/* && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
RUN touch ~/.sudo_as_admin_successful
WORKDIR /home/jenkins

USER root

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
