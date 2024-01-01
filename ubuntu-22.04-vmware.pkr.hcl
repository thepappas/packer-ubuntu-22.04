packer {
  required_version = ">= 1.7.0"
  required_plugins {
    vmware = {
      version = ">= 1.0.7"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "ubuntu" {
  iso_url = "https://releases.ubuntu.com/22.04/ubuntu-22.04.3-live-server-amd64.iso"
  iso_checksum = "a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
  ssh_username = "packer"
  ssh_password = "packer" 
  http_directory = "http"
  disk_type_id = "0"
  cdrom_adapter_type = "sata"
  usb = true
  disk_adapter_type = "nvme"
  boot_command = [
        "e<wait>",
        "<down><down><down>",
        "<end><bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
      ]
  shutdown_command = "shutdown -P now"
}

build {
  sources = ["sources.vmware-iso.ubuntu"]
}
