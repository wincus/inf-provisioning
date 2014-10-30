inf-provisioning
================

Poor mans's kvm cloud controler

launch your vms:
```bash
./vmanage.sh instance < templates/main-template
```
destroy your vms:
```bash
./vmanage.sh destroy < templates/main-template
```
delete your vms:
```bash
./vmanage.sh delete < templates/main-template
```
reboot your vms:
```bash
./vmanage.sh reboot < templates/main-template
```
your vms status:
```bash
./vmanage.sh status < templates/main-template
```
