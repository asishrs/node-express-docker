FROM 		ubuntu:latest

# Setting the Node & npm version
ENV 		NODE_VERSION 5.0.0
ENV 		NPM_VERSION 3.4.0
# Setting the working directory
WORKDIR 	/src

# verify gpg and sha256: http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc
RUN 		set -ex \
			&& for key in \
				7937DFD2AB06298B2293C3187D33FF9D0246406D \
				114F43EE0176B71C7BC219DD50A3051F888C628D \
			; do \
				gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
			done

# Install Node.js and other dependencies
RUN 		apt-get update \ 
			&& apt-get -y install curl \
			&& curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
			&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
			&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
			&& npm install -g npm@"$NPM_VERSION" \
			&& npm cache clear


# Copy application source from local (host) machine to container
COPY . /src
# Install app dependencies
RUN cd /src; npm install

EXPOSE 		3000
CMD ["npm", "start"]