FROM node:8.1.4-alpine

RUN apk add --update --no-cache curl

ENV APP_DIR=/srv/demo-app
ENV NODE_ENV=production

# NPM package cache
COPY package.json /tmp/package.json
RUN \
    cd /tmp && \
    npm install --production && \
    npm cache verify

RUN \
  mkdir -p ${APP_DIR} && \
  mkdir ${APP_DIR}/log && \
  cp -a /tmp/node_modules/ ${APP_DIR}

# Application setup
COPY bin ${APP_DIR}/bin
COPY public ${APP_DIR}/public
COPY routes ${APP_DIR}/routes
COPY views ${APP_DIR}/views
COPY app.js ${APP_DIR}/app.js
COPY package.json ${APP_DIR}/package.json

RUN addgroup www-data
RUN adduser -G www-data -D -H www-data
RUN chown -R www-data:www-data ${APP_DIR}

USER www-data

WORKDIR ${APP_DIR}

EXPOSE 3000

CMD ["npm", "start"]
