FROM node:8
LABEL maintainer Jalal Hejazi <jalal.hejazi@gmail.com>

# USE environment for change management
ENV serverName=""
ENV databaseName=""
ENV databaseUser=""
ENV databaseSecret=""
ENV encryption=""



# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./

RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 2222
CMD ["npm", "run","start" ]