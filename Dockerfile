FROM node:19

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY userapi/package*.json ./

# RUN npm install
# If you are building your code for production
# RUN npm ci --only=production
RUN npm ci

# Bundle app source
COPY userapi .

# Install Redis
RUN apt-get update && apt-get install -y redis-server

# Expose the port the app runs on
EXPOSE 3000

# Start the app
CMD [ "npm", "start" ]
