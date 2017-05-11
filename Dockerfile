FROM gocd/gocd-server:v17.4.0

# add plugins
RUN mkdir -p /godata/plugins/external/
COPY plugins/*.jar /godata/plugins/external/
RUN chown -R go:go /godata/plugins/external/
