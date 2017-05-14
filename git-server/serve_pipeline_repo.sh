#!/bin/bash
# I learned that I technically don't need a git daemon.
# A volume mount might be enough but I'm not sure
# Worth trying
REPOS_BASE=/var/go/repos
PIPELINE_REPO=pipelines

cd ${REPOS_BASE}/${PIPELINE_REPO}
git init
git add .
git -c user.name='go' -c user.email='sradloff23@gmail.org' commit -m "some commit"
cd ..
git clone --bare ${PIPELINE_REPO} "${PIPELINE_REPO}.git"

# chown -R go:go ${REPOS_BASE}
# cd ${REPOS_BASE}
# add --detach back
# git daemon --detach --base-path=${REPOS_BASE} --export-all \
  # --enable=receive-pack --reuseaddr --informative-errors --verbose


# REPOS_BASE=/var/go/repos
# PIPELINE_REPO=gocd-pipelines.git
#
# mkdir -p ${REPOS_BASE}/empty
# cd ${REPOS_BASE}/empty
# git init
#
# cd ${REPOS_BASE}
#
# git clone --bare ./empty ${PIPELINE_REPO}
# # cd ${PIPELINE_REPO}
# # touch git-daemon-export-ok
#
# chown -R go:go ${REPOS_BASE}
# cd ${REPOS_BASE}
# # add --detach back
# git daemon --detach --base-path=${REPOS_BASE} --export-all \
#   --enable=receive-pack --reuseaddr --informative-errors --verbose
