FROM peaceiris/hugo:latest AS builder
WORKDIR /src
COPY . .
RUN hugo --minify

FROM nginx:alpine-slim
LABEL org.opencontainers.image.source="https://github.com/EoinHealy0/static-site"

RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /src/public /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
