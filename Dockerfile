FROM node:14.16-alpine

RUN yarn global add nodemon
WORKDIR /src
ADD /userapi/package*.json ./
RUN yarn install
COPY ./userapi .

CMD ["node", "index.js"]