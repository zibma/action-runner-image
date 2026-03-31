FROM ghcr.io/actions/actions-runner:2.332.0

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

# Install Skopeo - START
RUN sudo apt-get install -y skopeo
# Install Skopeo - END

# Install Python - START
RUN sudo apt install python3 -y
RUN sudo apt install python-is-python3 -y
RUN sudo apt-get -y install python3-pip
ENV PIP_BREAK_SYSTEM_PACKAGES=1
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

# Pre-cache .NET base images as tarballs - START
RUN sudo mkdir -p /docker-image-cache && \
    sudo skopeo copy docker://mcr.microsoft.com/dotnet/aspnet:10.0 \
      docker-archive:/docker-image-cache/dotnet-aspnet-10.tar:mcr.microsoft.com/dotnet/aspnet:10.0 && \
    sudo skopeo copy docker://mcr.microsoft.com/dotnet/sdk:10.0 \
      docker-archive:/docker-image-cache/dotnet-sdk-10.tar:mcr.microsoft.com/dotnet/sdk:10.0 && \
    sudo skopeo copy docker://mcr.microsoft.com/dotnet/aspnet:8.0 \
      docker-archive:/docker-image-cache/dotnet-aspnet-8.tar:mcr.microsoft.com/dotnet/aspnet:8.0 && \
    sudo skopeo copy docker://mcr.microsoft.com/dotnet/sdk:8.0 \
      docker-archive:/docker-image-cache/dotnet-sdk-8.tar:mcr.microsoft.com/dotnet/sdk:8.0 && \
    sudo skopeo copy docker://node:20-alpine \
      docker-archive:/docker-image-cache/node-20-alpine.tar:node:20-alpine && \
    sudo skopeo copy docker://nginx:stable-alpine \
      docker-archive:/docker-image-cache/nginx-stable-alpine.tar:nginx:stable-alpine
# Pre-cache .NET base images as tarballs - END

# Custom entrypoint for pre-loading cached images - START
COPY entrypoint.sh /docker-init.sh
RUN sudo chmod +x /docker-init.sh
ENTRYPOINT ["/docker-init.sh"]
# Custom entrypoint for pre-loading cached images - END

# Uncomment the following line for debugging this image
# ENTRYPOINT ["tail", "-f", "/dev/null"]
