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

### Diagram
This diagram illustrates the three service types declared in the docker-compose file, how they interact with the host machine, and how they interact with each other.

![Alt text](/gocd-ecosystem.jpeg?raw=true "GoCD Ecosystem Diagram")

The orange arrows represent volume mounts, with the only exception being 'credentials.env'.

The [GoCD server documentation](https://github.com/gocd/docker-gocd-server) mentions specific mount points, but here we explain the two mount points we utilize:
- The 'cruise-config.xml' file contains your basic GoCD server configuration, including the agent registration key, location of the git repository containing pipeline as code, and any other basic pipeline definitions.
- The 'plugins' volume mount represents the jars of any plugins used for GoCD. In this ecosystem,  we are mount the plugins folder with the script-executor and yaml-config plugins.

The [git daemon documentation](https://github.com/bankiru/docker-git-daemon) demonstrates the container options as well as the git repository volume mount, but here we explain our use of that volume mount:
- The 'pipeline-code' volume mount represents the entire gocd-ecosystem repository in the demo instance. This means we are serving up the entire gocd-ecosystem due to how the git daemon works. This is ok for now, because the yaml-config plugin will only pick up files ending in 'gocd.yaml' and ignore the rest.

The [GoCD agent documentation](https://github.com/gocd/docker-gocd-agent-alpine-3.5) mentions specific mount points and configurations, but here we don't actually utilize any of those:
- The 'credentials.env' file is not technically volume mounted but is utilized as an environment file for a person's Dockerhub login. Those variables are interpolated in the pipeline as code file 'movie-surfer.gocd.yaml'.
- The 'docker.sock' is volume mounted from the host machine to allow the go-agent instances to run docker processes. For a container to create sibling containers, the container requires it's own docker client installed (as seen in the Dockerfile) and the docker.sock of the host machine.

The black arrow represents the git protocol utilized by the go-server to poll the repository for pipeline as code.

The green arrows represent the go-agent instances self registering and sustaining a connection with the go-server.

### Collaborators
[Mason Richins](https://github.com/mrichins)
