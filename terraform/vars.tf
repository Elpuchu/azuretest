variable "vm_size"{
	type = string
	description = "Tamaño de la máquina virtual"
	default = "Standard_B2s" # 4 GB, 2 CPU
}

variable "envs" {
	type = list(string)
	description = "Entornos"
	default = ["dev", "pre"]
}

variable "vmachines" {
	type = list(string)
	description = "Máquinas Virtuales"
	default = ["nfs", "master", "worker1", "worker2"]
}
