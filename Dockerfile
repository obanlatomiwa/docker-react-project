# building production files
FROM node:alpine as builder
WORKDIR '/usr/app'
COPY package*.json ./
RUN npm install -g npm@7.5.0
RUN npm install
COPY ./ ./
RUN npm run build

# using nginx web server for production
FROM nginx
EXPOSE 80
COPY --from=0 /usr/app/build /usr/share/nginx/html