FROM node:14.16-alpine

RUN yarn global add nodemon
WORKDIR /src
COPY /userapi/package*.json ./
RUN yarn install
COPY ./userapi .

EXPOSE 9000

CMD [ "npm", "start" ]