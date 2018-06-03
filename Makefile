.PHONY: help run cleanup

help: ## Show this help
	@echo "Local GoCD"
	@echo "======================"
	@echo
	@echo "Tool used to run your organization's GoCD locally, to test pipeline configuration before you merge."
	@echo
	@fgrep -h " ## " $(MAKEFILE_LIST) | fgrep -v fgrep | sed -Ee 's/([a-z.]*):[^#]*##(.*)/\1##\2/' | column -t -s "##"

check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))

run: ## runs GoCD server and agents
	@:$(call check_defined, PRIVATE_KEY, path to your id_rsa which has access to your GitHub repositories); \
	@:$(call check_defined, CIPHER, cipher needed for secure_vars encryption and decryption); \
	PRIVATE_KEY=`cat $(PRIVATE_KEY)`; \
	CIPHER=$(CIPHER); \
	docker-compose up --build -d --scale go-agent=2; \
	docker-compose logs -f -t

cleanup:
	docker ps -a | awk '{ print $$1, $$2 }' | grep gocd-ecosystem_go-agent | awk '{print $$1}' | xargs -I {} docker rm -f {}
	docker ps -a | awk '{ print $$1, $$2 }' | grep gocd-ecosystem_go-server | awk '{print $$1}' | xargs -I {} docker rm -f {}
