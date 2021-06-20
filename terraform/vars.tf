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

variable "vms" { #listado de maquinas virtuales a generar
	type = list(string)
	description = "Máquinas Virtuales"
	default = ["master", "worker01", "worker02", "nfs"]
}
