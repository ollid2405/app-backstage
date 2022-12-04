FROM node:16-bullseye-slim
USER root
WORKDIR /app

ENV NODE_ENV production

COPY src/main/docker/app ./

CMD ["node", "packages/backend", "--config", "app-config.yaml"]

EXPOSE 3000
