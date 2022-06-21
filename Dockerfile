FROM node:13 as build
    MAINTAINER Dennis Dollée

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci

COPY . .
# RUN npm run build
RUN bash build.sh prod

FROM nginx:alpine as production
COPY --from=build /usr/src/app/deploy /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
