# GoCD in a Box

This project contains a dockerized GoCD server and GoCD agent configuration. If you're not familiar with GoCD concepts, I suggest you start with [their intro documentation](https://docs.gocd.org/current/introduction/concepts_in_go.html).

The purpose of this project is to be able to spin up a local instance of your CI/CD pipeline to test your changes locally before pushing to your "production" CI/CD server.

The idea is to feed your personal ssh key authorized by GitHub and provide the cipher key for your production CI/CD server, to test any changes in pipeline code locally.

## Getting Started
### SSH key connection to GitHub
Make sure that you have an ssh key on your machine [accepted with GitHub](https://help.github.com/articles/connecting-to-github-with-ssh/).

The documentation to check for [ssh keys](https://help.github.com/articles/connecting-to-github-with-ssh/) and [testing whether your ssh key is authenticated with GitHub](https://help.github.com/articles/testing-your-ssh-connection/).

### Production GoCD cipher key

The production GoCD cipher key is necessary for encrypting and decrypting secure variables. The GoCD API on the GoCD server is [used to encrypt variables](https://api.gocd.org/17.12.0/#encrypt-a-plain-text-value). The cipher key is used to decrypt those encrypted values used when in pipeline configuration files.

### Location to your pipeline configuration code

We're utilizing the [yaml config plugin](https://github.com/tomzo/gocd-yaml-config-plugin) to configure pipeline as code.

The `cruise-config.xml` contains the configuration for where to look for pipeline configuration code. We recommend reading the [documentation of pipeline as code with GoCD](https://docs.gocd.org/current/advanced_usage/pipelines_as_code.html) if you do not know about the `cruise-config.xml` file.

We recommend copying the relevant `cruise-config.xml` portion from your production GoCD server and modifying it to work for local use.

We will be utilizing GitHub as the git server, meaning any changes you make to your pipeline as code will have to be in GitHub to be picked up by your local GoCD ecosystem.

The pipeline configuration files should end with the extension `.gocd.yaml` or `.gocd.yml` for the [GoCD server to find them](https://github.com/tomzo/gocd-yaml-config-plugin#file-pattern).

The copy and paste to which we refer to in the next 2 sections, should be copied to the `cruise-config.xml` file located in the root of this project.

#### Master branch pipeline

Copy and paste the `config-repo` xml element for the repository that you want to modify the pipeline code, in between the `cruise` element tags. Then add a `branch` attribute to the `git` element, in which you specify the GitHub branch containing the pipeline code you wish to test.
```
<config-repo pluginId="yaml.config.plugin" id="ec7db9ae-045d-4a3c-be91-76b88f456ef4">
  <git url="git@github.com:slicelife/fake-repo" branch="making-pipeline-code-changes" />
</config-repo>
```
This tells the GoCD server use the git protocol to look for yaml pipeline as code configuration files in the GitHub `slicelife/fake-repo` repository, on the `making-pipeline-code-changes` branch, which control the pipeline of the master branch.

### PR branch pipeline

We utilize [two plugins to poll for PRs and allow PRs to have pipelines](https://github.com/ashwanthkumar/gocd-build-github-pull-requests). Those plugin jars are available on the local GoCD ecosystem.

Copy and paste the `scm` xml element for the repository that you want to modify the PR pipeline code, in between the `scms` element tags. Then add a `property` element in between the `configuration` element tags, in which you specify the GitHub branch containing the pipeline code you wish to test.
```
<scm id="0d8f07a7-74f5-455e-aa4d-3d973aae41dc" name="fake-repo-pr">
  <pluginConfiguration id="github.pr" version="1" />
  <configuration>
    <property>
      <key>url</key>
      <value>git@github.com:slicelife/fake-repo</value>
    </property>
    <property>
      <key>defaultBranch</key>
      <value>making-pipeline-code-changes</value>
    </property>
  </configuration>
</scm>
```
This tells the GoCD server use the git protocol to look for yaml pipeline as code configuration files in the GitHub `slicelife/fake-repo` repository, on the `making-pipeline-code-changes` branch, which control the pipeline for any new PR opened on that GitHub repository.

## How to modify pipeline code and watch it run?

### Starting the local GoCD ecosystem
Simply provide the location on your local to your ssh key connected to GitHub and then the cipher key for your production GoCD server by running the following command.
`$ make run PRIVATE_KEY=~/.ssh/id_rsa CIPHER=XXXXXXX`

Access the GoCD UI at `http://localhost:8153`, it should become visible after 30 or so seconds.

You should see your pipeline groups kick off with builds as soon as the GoCD agents connect to the GoCD server.
