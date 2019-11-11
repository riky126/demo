FROM nginx

COPY wrapper.sh /

COPY html /usr/share/nginx/html

EXPOSE 8080

CMD ["./wrapper.sh"]
