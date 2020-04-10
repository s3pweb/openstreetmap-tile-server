docker volume rm openstreetmap-data-test
docker volume rm openstreetmap-rendered-tiles-test

docker volume create openstreetmap-data-test
docker volume create openstreetmap-rendered-tiles-test

docker run \
    -e UPDATES=enabled \
    -e DOWNLOAD_PBF=https://download.geofabrik.de/europe/luxembourg-latest.osm.pbf \
    -e DOWNLOAD_POLY=https://download.geofabrik.de/europe/luxembourg.poly \
    -v openstreetmap-data-test:/var/lib/postgresql/12/main \
    -v openstreetmap-rendered-tiles-test:/var/lib/mod_tile \
    overv/openstreetmap-tile-server:latest \
    import

docker run \
    -p 48080:80 \
    -e UPDATES=enabled \
	-e ALLOW_CORS=enabled \
    -v openstreetmap-data:/var/lib/postgresql/12/main \
    -v openstreetmap-rendered-tiles:/var/lib/mod_tile \
    -d overv/openstreetmap-tile-server:latest \
    run

