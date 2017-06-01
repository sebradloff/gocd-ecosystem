## GoCD in a Box

This project contains a dockerized GoCD server, GoCD agent, and a git-daemon to server your pipeline as code setup.

The purpose of this project is to be able to spin up a local instance of your CI/CD pipeline to test your changes locally before pushing to your "production" CI/CD server.

The docker-compose command takes an environment variable name "PIPELINE_CODE". This variable specifies the location of your pipeline as code repository which is volume mounted into the git-daemon container.

### Demo
To run a demo of this project with one server, three agents, and the pipeline code in the folder 'example-pipelines-config'.
- Add a `credentials.env` file with DOCKER_USERNAME and DOCKER_PASSWORD defined corresponding to your dockerhub account.
- `$ make demo`
- Access it at `http://localhost:8153`, it should become visible after 30 or so seconds.

**It's that simple!**

### Use Your Own Config
To run this project with one server and one agent you should run the following:

`$ PIPELINE_CODE="PATH_TO_PIPELINE_CODE" docker-compose up`

If you'd like to scale the number of Go agents you can run the docker-compose scale command:

`$ PIPELINE_CODE="PATH_TO_PIPELINE_CODE" docker-compose up -d && docker-compose scale go-agent=3`

Here we scale the number of Go agents to 3 but you can replace that number for however many agents you'd like.

There is also a Makefile command `up` that will orchestrate as many Go agents as you like:

`$ PIPELINE_CODE="PATH_TO_PIPELINE_CODE" SCALE=NUMBER_OF_AGENTS make up`

i.e. `PIPELINE_CODE=../my-pipeline-config-repo SCALE=5  make up`

The UI is still accessible at `http://localhost:8153`.
### Collaborators
[Mason Richins](https://github.com/mrichins)
