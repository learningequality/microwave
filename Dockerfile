# Setting the base to docker-node-unoconv
FROM telemark/docker-node-unoconv:10.14.0

# Install more fonts
RUN apt-get update && apt-get -t jessie-backports -y install \
    fonts-indic \
    fonts-hosny-amiri \
    fonts-crosextra-caladea \
    fonts-crosextra-carlito \
    fonts-noto \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    fonts-ipafont \
    fonts-ipafont-gothic \
    fonts-unfonts-core \
&& rm -rf /var/lib/apt/lists/*

# Clone the repo
RUN git clone https://github.com/zrrrzzt/tfk-api-unoconv.git unoconvservice

# Change working directory
WORKDIR /unoconvservice

# Install dependencies
RUN npm install --production

# Env variables
ENV SERVER_PORT 3000
ENV PAYLOAD_MAX_SIZE 52428800
ENV TIMEOUT_SERVER 120000
ENV TIMEOUT_SOCKET 140000

# Expose 3000
EXPOSE 3000

# Startup
ENTRYPOINT /usr/bin/unoconv --listener --server=0.0.0.0 --port=2002 & node standalone.js