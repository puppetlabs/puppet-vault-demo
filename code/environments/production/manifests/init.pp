$d = Deferred('vault_lookup',["secret/test"])

node default {
  notify { example :
    message => $d
  }
}
