## GoCD in a box

This project contains a dockerized GoCD server, GoCD agent, and a git-daemon to server your pipeline as code setup.

The purpose of this project is to be able to spin up a local instance of your CI/CD pipeline to test your changes locally before pushing to your "production" CI/CD server.

To run this project with one server and one agent you should run the following:
`$ docker-compose up`

If you'd like to scale the number of Go agents you can run the docker-compose scale command:
`$ docker-compose up -d && docker-compose scale go-agent=3`
Here we scale the number of Go agents to 3 but you can replace that number for however many agents you'd like.
