# Stage 1: Build the application
FROM node:20-alpine3.17 AS builder

WORKDIR /app

COPY medusa-store/package.json medusa-store/package-lock.json ./

RUN npm ci

COPY medusa-store/. .

RUN npm run build

# Stage 2: Create the production image
FROM node:20-alpine3.17

WORKDIR /app

COPY --from=builder /app .

EXPOSE 5000

CMD ["npm", "start"]