FROM nginx

COPY wrapper.sh /

COPY html /usr/share/nginx/html

EXPOSE 8000
CMD ["./wrapper.sh"]
