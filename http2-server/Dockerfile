FROM fedora:33
COPY certs/cert /cert
COPY certs/key /key
COPY install-httpd.sh /install-httpd.sh
COPY run-httpd.sh /run-httpd.sh
RUN /bin/bash /install-httpd.sh
ENTRYPOINT /bin/bash /run-httpd.sh
