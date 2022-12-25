FROM node:12

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install
RUN npm install redis
RUN npm install express
COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]
