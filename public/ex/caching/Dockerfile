FROM node:latest

COPY package.json .

RUN npm install

COPY app.js .

CMD node app.js server -l http://*:8080
