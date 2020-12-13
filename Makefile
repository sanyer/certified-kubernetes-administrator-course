# https://makefiletutorial.com/
# https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html

all: all_up all_destroy clean up destroy
.PHONY: all

all_up:
	make -j3 kubemaster_up kubenode01_up kubenode02_up

kubemaster_up:
	vagrant up kubemaster

kubenode01_up:
	vagrant up kubenode01

kubenode02_up:
	vagrant up kubenode02

all_destroy:
	make -j3 kubemaster_destroy kubenode01_destroy kubenode02_destroy

kubemaster_destroy:
	vagrant destroy kubemaster --force

kubenode01_destroy:
	vagrant destroy kubenode01 --force

kubenode02_destroy:
	vagrant destroy kubenode02 --force

clean: all_destroy
	- VBoxManage hostonlyif remove vboxnet0
	rm -vrf /Users/mural/VirtualBox\ VMs
	rm -vrf ./vagrant
	rm -vrf *.log

up:
	vagrant up

destroy:
	vagrant destroy