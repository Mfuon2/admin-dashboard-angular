# Stage 1
FROM node:14.15.0-alpine as node

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install yarn

COPY . .
RUN yarn install
RUN yarn build

# Stage 2
FROM nginx:1.13.12-alpine

COPY --from=node /usr/src/app/dist/admin-dashboard /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
