FROM ubuntu:latest

RUN apt-get update
RUN apt-get install curl tar python -y
RUN apt-get install openjdk-8-jdk rsync -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install npm -y

RUN useradd -ms /bin/bash node
USER node
WORKDIR /home/node

SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN source /home/node/.bashrc && nvm install 12.18.1
RUN npm install -g turtle-cli
SHELL ["/bin/bash", "--login", "-c"]

ENTRYPOINT ["bash"]
