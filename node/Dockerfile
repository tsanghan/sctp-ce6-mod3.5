FROM node:20.16-alpine3.20 AS build-env
COPY . /app
WORKDIR /app

RUN npm ci --omit=dev

FROM gcr.io/distroless/nodejs20-debian11
COPY --from=build-env /app /app
WORKDIR /app
# EXPOSE 8080
CMD ["index.js"]