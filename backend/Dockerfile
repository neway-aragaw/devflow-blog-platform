FROM node:18-alpine

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 8787

CMD ["npm", "run", "dev"]