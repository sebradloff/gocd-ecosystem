FROM gocd/gocd-server:v17.4.0

# Git server
RUN mkdir -p /var/go/repos/pipelines
COPY pipelines/*.gocd.yaml /var/go/repos/pipelines
COPY git-server/serve_pipeline_repo.sh /var/go/

RUN sh /var/go/serve_pipeline_repo.sh
