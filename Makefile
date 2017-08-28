demo:
	PIPELINE_CODE=../go-pipeline-configs/ docker-compose up -d --scale go-agent=5
	PIPELINE_CODE=../go-pipeline-configs/ docker-compose logs -f -t
up:
	PIPELINE_CODE=$(PIPELINE_CODE) docker-compose up -d --scale go-agent=$(SCALE)
	PIPELINE_CODE=$(PIPELINE_CODE) docker-compose logs -f -t
cleanup:
	docker ps -a | awk '{ print $$1, $$2 }' | grep gocdecosystem_go-agent | awk '{print $$1}' | xargs -I {} docker rm -f {}
	docker ps -a | awk '{ print $$1, $$2 }' | grep bankiru | awk '{print $$1}' | xargs -I {} docker rm -f {}
	docker ps -a | awk '{ print $$1, $$2 }' | grep gocd/gocd-server:v17.7.0 | awk '{print $$1}' | xargs -I {} docker rm -f {}
	docker images -a | awk '{print $$1, $$3}' | grep sebradloff/movie-surfer-snap | awk '{print $$2}' | xargs -I {} docker rmi -f {}
