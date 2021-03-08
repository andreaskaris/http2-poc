.PHONY: http2-server http2-client http2-haproxy

REGISTRY ?= localhost

certs:
	bash gen-cert.sh
	cp -a certs http2-server/
	cp -a certs http2-client/
	cp -a certs http2-haproxy/

build-http2-server: certs
	cd http2-server && buildah bud -t $(REGISTRY)/http2-server .

build-http2-client: certs
	cd http2-client && buildah bud -t $(REGISTRY)/http2-client .

build-http2-haproxy: certs
	cd http2-haproxy && buildah bud -t $(REGISTRY)/http2-haproxy .

run-http2-server:
	REGISTRY=$(REGISTRY) /bin/bash -x start-http2-server-container.sh

stop-http2-server:
	podman stop http2-server

remove-http2-server: stop-http2-server
	podman rm http2-server

run-http2-haproxy:
	REGISTRY=$(REGISTRY) /bin/bash -x start-http2-haproxy-container.sh

stop-http2-haproxy:
	podman stop http2-haproxy

remove-http2-haproxy: stop-http2-haproxy
	podman rm http2-haproxy
