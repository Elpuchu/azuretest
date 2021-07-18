# Configuración previa

# Ansible
En ansible/hosts.cfg configurar las ips/dominios de los master, workers y nsf

En ansible/group_vars/all.yaml configurar las ips de master y workers en
ip_master : "192.168.1.14"
ip_worker1: "192.168.1.13"
-- mas workers agregar mas ips

workers_rich_rule: 
 - 'rule family=ipv4 source address=192.168.1.13/32 accept'
 - si se agregan mas workers agregar rules aqui para esas ips
