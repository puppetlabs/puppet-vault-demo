$d = Deferred('vault_lookup',["secret/test", 'http://vault.docker:8200', {':raise_exceptions' => false }])

node default {
  notify { example :
    message => $d
  }
}
