demo:
	PIPELINE_CODE=../go-pipeline-configs/ docker-compose up -d --scale go-agent=3
	PIPELINE_CODE=../go-pipeline-configs/ docker-compose logs -f -t
up:
	PIPELINE_CODE=$(PIPELINE_CODE) docker-compose up -d --scale go-agent=$(SCALE)
	PIPELINE_CODE=$(PIPELINE_CODE) docker-compose logs -f -t
