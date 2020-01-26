OTS_VERSION = 1.3.5

.PHONY: build push test

build:
	docker build -t s3pweb/ots:$(OTS_VERSION) .

push: build
	docker push s3pweb/ots:$(OTS_VERSION)

test: build
	docker volume create openstreetmap-data
	docker run -v openstreetmap-data:/var/lib/postgresql/10/main overv/openstreetmap-tile-server import
	docker run -v openstreetmap-data:/var/lib/postgresql/10/main -p 80:80 -d overv/openstreetmap-tile-server run