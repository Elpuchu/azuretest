# Configuración previa

# Ansible
En ansible/hosts.cfg configurar las ips/dominios de los master, workers y nsf

1. En ansible/group_vars/all.yaml configurar las ips de master y workers en
ip_master : "192.168.1.14"
ip_worker1: "192.168.1.13"
-- mas workers agregar mas ips

2. workers_rich_rule: 
 - 'rule family=ipv4 source address=192.168.1.13/32 accept'
 - si se agregan mas workers agregar rules aqui para esas ips

3. En ansible/roles/nfs_configuration/templates/exports.j2,agregar tantos workers como se agregaron en paso (1)

/srv/nfs	{{ ip_master }}(rw,sync)

/srv/nfs	{{ ip_worker1 }}(rw,sync)

/srv/nfs    {{ ip_worker2 }}(rw,sync)


# En las VMs
* Habilitar autenticacion ssh con password
sudo nano /etc/ssh/sshd_config

PasswordAuthentication yes

ChallengeResponseAuthentication no

* y reiniciamos
sudo systemctl restart sshd
