$d = Deferred('vault_lookup',["secret/test"])

node medina {
  $d.call
  # notify { "$d.call" :}
}

node toneloc {
  notify { example :
    message => $d
  }
}
