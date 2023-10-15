FROM node:17.9.0-alpine3.15

WORKDIR /app

COPY /app/morty/package*.json ./
RUN npm install
RUN npm install express

COPY /app/morty/server.js server.js
EXPOSE 8002
CMD node ./server.js
