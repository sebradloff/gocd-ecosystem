docker build --tag sebastian-go-server .

docker run --rm -p8153:8153 -p8154:8154 \
  sebastian-go-server



  # -v $(pwd)/cruise-config.xml:/godata/config/  \
