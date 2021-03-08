FROM fedora:33
COPY certs/cert /cert
COPY certs/key /key
COPY install-client.sh /install-client.sh
RUN /bin/bash /install-client.sh
ENTRYPOINT sleep infinity
