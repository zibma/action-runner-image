FROM ghcr.io/actions/actions-runner:2.319.1

# Update - START
RUN sudo apt update -y
# Update - END

# Install Curl - START
RUN sudo apt install curl -y
# Install Curl - END

# Install Git - START
RUN sudo apt install git -y
# Install Git - END

# Install Wget - START
RUN sudo apt install wget -y
# Install Wget - END

# Install Zip - START
RUN sudo apt install zip -y
# Install Zip - END

# Install Unzip - START
RUN sudo apt install unzip -y
# Install Unzip - END

# Install Python - START
RUN sudo apt install python3 -y
RUN sudo apt install python-is-python3 -y
RUN sudo apt-get -y install python3-pip
# Install Python - END

# Installing Docker Engine - START
RUN sudo apt-get install ca-certificates curl gnupg -y
RUN sudo install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN sudo chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN sudo apt-get update -y
# Installing Docker Engine - END

# # Installing Podman - START
# RUN sudo apt-get -y install podman
# # Installing Podman - END

# # Installing Buildah - START
# RUN sudo apt-get -y install buildah
# # Installing Buildah - END

# # Installing Kubectl - START
# RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
# RUN echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
# RUN sudo apt-get update -y
# RUN sudo apt install kubectl -y
# # Installing Kubectl - END


# Uncomment the following line for debugging this image
# ENTRYPOINT ["tail", "-f", "/dev/null"]
