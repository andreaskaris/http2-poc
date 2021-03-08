FROM fedora:33
COPY certs/cert /cert
COPY certs/key /key
COPY install-haproxy.sh /install-haproxy.sh
COPY run-haproxy.sh /run-haproxy.sh
RUN /bin/bash /install-haproxy.sh
ENTRYPOINT /bin/bash /run-haproxy.sh
