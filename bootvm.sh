# this file is used to boot a Windows 10 in qemu with a shared folder
WIN_IMG="WindowsVM.img"
WIN_ISO="Windows10.iso"
virtio="virtio-win.iso"
shared_folder="./shared"
qemu-system-x86_64 \
	-machine q35 \
	-monitor stdio \
    -enable-kvm \
    -m 6144 \
	-vga virtio \
	-nic user,model=virtio,id=nic0,smb=$shared_folder \
	-drive file=$WIN_IMG,format=qcow2,if=virtio \
	-drive file=$WIN_ISO,media=cdrom  \
	-drive file=$virtio,media=cdrom
