# Agent lookups with vault

This repo contains a docker-compose set up that will run a puppetserver, vault
service, and a container with the puppet agent configured to connect to vault
directly.

After you have cloned this repo, update the github submodules by running
`git submodule update --init`.

To start the services, run `./demo-up.sh` from the root of this repo. This will
bring up the services, unseal vault, and run puppet once on the agent container.

Key pieces of the proof of concept are the [Puppet function that calls Vault](https://github.com/puppetlabs/puppet/blob/6e4452cd75f76249bbaa7ad546924833fc1a2b4c/lib/puppet/functions/vault_lookup.rb) and the [Puppet code that fetches a secret from Vault](https://github.com/puppetlabs/puppet-vault-demo/blob/master/code/environments/production/manifests/init.pp)
