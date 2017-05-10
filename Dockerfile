FROM gocd/gocd-server:v17.4.0

# # Go configuration
# COPY cruise-config.xml /godata/config/
# RUN chown -R 1000 /godata/config/cruise-config.xml

# add plugins
RUN mkdir -p /godata/plugins/external/
COPY plugins/external/*.jar /godata/plugins/external/
RUN chown -R 1000 /godata/plugins/external
