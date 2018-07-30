# Agent lookups with vault

This repo contains a docker-compose set up that will run a puppetserver, vault
service, and a container with the puppet agent configured to connect to vault
directly.

If you are running on osx, you will need to configure Docker to use at least
3 GB of memory so that the puppetserver starts correctly.

After you have cloned this repo, update the github submodules by running
`git submodule update --init`.

To start the services, run `./demo-up.sh` from the root of this repo. This will
bring up the services, unseal vault, and run puppet once on the agent container.
