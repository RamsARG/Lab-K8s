resource "proxmox_vm_qemu" "master" {
  name        = "master01"
  target_node = "pve"
  clone       = "8000"
  desc        = "Master Node"
  #onboot = true
  full_clone = true
  agent      = 1
  cores      = 2
  sockets    = 1
  cpu        = "host"
  memory     = 2048
  scsihw     = "virtio-scsi-pci"
  os_type    = "cloud-init"
  #qemu_os    = "126"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          # size cannot be less than the image template (25G)
          size = 25
        }
      }
    }
  }

  connection {
    type     = "ssh"
    user     = "diegoc"
    password = var.ssh_pass
    host     = self.default_ipv4_address
  }

  # setup network custom information
  provisioner "file" {
    source = "./01-netplan.yaml"
    destination = "/tmp/00-netplan.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "echo diegoc | sudo -S mv /tmp/00-netplan.yaml /etc/netplan/00-netplan.yaml",
      "sudo hostnamectl set-hostname master01",
      "sudo netplan apply && sudo ip addr add dev ens18 ${self.default_ipv4_address}",
      "ip a s"
     ] 
  }
}

resource "proxmox_vm_qemu" "worker01" {
  name        = "worker01"
  target_node = "pve"
  clone       = "8000"
  desc        = "Worker Node 1"
  #onboot = true
  full_clone = true
  agent      = 1
  cores      = 2
  sockets    = 1
  cpu        = "host"
  memory     = 2048
  scsihw     = "virtio-scsi-pci"
  os_type    = "cloud-init"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          # size cannot be less than the image template (25G)
          size = 25
        }
      }
    }
  }

  connection {
    type     = "ssh"
    user     = "diegoc"
    password = var.ssh_pass
    host     = self.default_ipv4_address
  }

  # setup network custom information
  provisioner "file" {
    source = "./02-netplan.yaml"
    destination = "/tmp/00-netplan.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "echo diegoc | sudo -S mv /tmp/00-netplan.yaml /etc/netplan/00-netplan.yaml",
      "sudo hostnamectl set-hostname worker01",
      "sudo netplan apply && sudo ip addr add dev ens18 ${self.default_ipv4_address}",
      "ip a s"
     ] 
  }

}

resource "proxmox_vm_qemu" "worker02" {
  name        = "worker02"
  target_node = "pve"
  clone       = "8000"
  desc        = "Worker Node 2"
  #onboot = true
  full_clone = true
  agent      = 1
  cores      = 2
  sockets    = 1
  cpu        = "host"
  memory     = 2048
  scsihw     = "virtio-scsi-pci"
  os_type    = "cloud-init"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          # size cannot be less than the image template (25G)
          size = 25
        }
      }
    }
  }

  connection {
    type     = "ssh"
    user     = "diegoc"
    password = var.ssh_pass
    host     = self.default_ipv4_address
  }

  # setup network custom information
  provisioner "file" {
    source = "./03-netplan.yaml"
    destination = "/tmp/00-netplan.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "echo diegoc | sudo -S mv /tmp/00-netplan.yaml /etc/netplan/00-netplan.yaml",
      "sudo hostnamectl set-hostname worker02",
      "sudo netplan apply && sudo ip addr add dev ens18 ${self.default_ipv4_address}",
      "ip a s"
     ] 
  }
}