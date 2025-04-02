FROM jenkins/jenkins:lts

USER root

# Installation de Docker CLI
RUN apt-get update && \
    apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release git && \
    apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get -y install docker-ce-cli

# Définir les permissions du groupe docker pour permettre l'accès au socket
RUN groupadd -g 999 docker_host && \
    usermod -aG docker_host jenkins

USER jenkins
