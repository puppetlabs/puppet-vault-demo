# Agent lookups with vault

This repo contains a docker-compose set up that will run a puppetserver, vault
service, and a container with the puppet agent configured to connect to vault
directly.

If you are running on osx, you will need to configure Docker to use at least
3 GB of memory so that the puppetserver starts correctly.

After you have cloned this repo, update the github submodules by running
`git submodule sync`.

To start the services, run `docker-compose up` from the root of this repo. After
the puppetserver has started, run the `unseal.sh` shell script with docker to
configure the vault service with the CA cert from puppetserver.

```
docker exec -i puppet-vault-demo_vault_1 /bin/sh < unseal.sh
```

At this point, you can run the agent on the agent container and see the agent
connect to the vault service directly.

```
docker exec -i puppet-vault-demo_agent_1 puppet agent -t
```
