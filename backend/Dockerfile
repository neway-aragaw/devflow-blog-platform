# backend/Dockerfile
FROM node:20-alpine

WORKDIR /app

COPY . .

RUN npm install

# Build Prisma client if needed
RUN npx prisma generate

# Use wrangler to run the Cloudflare Worker (if used)
RUN npm install -g wrangler

EXPOSE 8787

CMD ["wrangler", "dev", "--port=8787", "--env", "development"]
