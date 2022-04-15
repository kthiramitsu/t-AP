/*認証基盤*/
variable "subscription_id" {
    default = "5724b903-4538-4a5e-a901-8800185b5788"
}

variable "tenant_id" {
    default = "67acf48f-1398-464d-9961-1b3238bd11a2"
}


/*リソースグループ*/
variable "rg" {
    default = "AP-kthiramitsu"
}

variable "location" {
    default = "Japanwest"
}

/*Vnet*/
variable "vnet" {
    default = "AP-vnet"
}

/*ExpressRoute Gateway*/
variable "ERGW" {
    default = "AP-ERGW"
}

/*仮想マシン*/
variable "vm-dev" {
    default = "AP-server-dev"
}

/*マネージドディスク*/
variable "disk_dev" {
    default = "Managed_Disk_dev"
}