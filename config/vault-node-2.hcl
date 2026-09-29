storage "consul" {
  # Apunta al nombre del servicio del agente cliente en la red de Docker
  address = "vault-consul-client:8501"
  path    = "vault/"
  scheme  = "https"
  
  # Token de ACL de Consul con permisos en el path "vault/"
  token   = "<consul token>"

  # Habilita la coordinación de Alta Disponibilidad (HA) mediante Consul
  ha_enabled = "true"

  # Certificados para confiar en el agente local (mTLS)
  tls_ca_file   = "/vault/config/certs/consul-agent-ca.pem"
  tls_cert_file = "/vault/config/certs/client.pem"
  tls_key_file  = "/vault/config/certs/client-key.pem"
  tls_skip_verify = "false"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

seal "transit" {
  address         = "http://vault-transit:8200"
  disable_renewal = "false"
  key_name        = "autounseal-key"
  mount_path      = "transit"
  token           = "<transit token>"
}


# Ajusta el nombre de host según el nodo (vault-node1, vault-node2, etc.)
api_addr     = "http://vault-node-2:8200"
cluster_addr = "https://vault-node-2:8201"
ui           = true