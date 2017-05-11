docker build --tag sebastian-go-server .

docker run --rm -p8153:8153 \
  -v $(pwd)/cruise-config.xml:/godata/config/cruise-config.xml \
  sebastian-go-server
