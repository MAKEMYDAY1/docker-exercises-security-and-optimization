FROM docker:25.0.5-git

WORKDIR /usr/local/bin
COPY builder.sh /usr/local/bin/builder.sh
RUN chmod +x /usr/local/bin/builder.sh

ENTRYPOINT ["/usr/local/bin/builder.sh"]
