up:
	PIPELINE_CODE=$(PIPELINE_CODE) docker-compose up -d --scale go-agent=3
	PIPELINE_CODE=$(PIPELINE_CODE) docker-compose logs -f -t
