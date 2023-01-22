Questions to answer:
	1. what is K3s?
	2. what is Vagrant?
	3. what is K3d?
	4. what is Argo CD?
	5. what is the difference between K3d and K3s?

Steps:
	step 1: set up 2 machines using the latest stable version of an OS, the machines are advised to have bare minimum of
		resources: 1 CPU, 1024 RAM. The machines should run using Vagrant.


Answers:
	1. k3s is a lightwieght k8s, which gives us the ability to install half size of k8s, it's mostly used for IoT and edge computing.
		we can say that it has two types of node, server and agent, the server is the master node and the agent is the worker node.
		the server node is defined as a host running the k3s server