# AKS-Custom-Scheduler
This repo demonstrates how to create a custom scheduler on a managed Kubernetes cluster where the control plane is not directly accessible. This is accomplished by creating an [additional scheduler](https://kubernetes.io/docs/tasks/extend-kubernetes/configure-multiple-schedulers/) rather than replace the existing default scheduler.

In this scenario the scheduler runs as a workload in the kube-system namespace. Workloads can target this scheduler specifically by specifying the schedulerName property within the podSpec.

In this example I create a scheduler with the nodeResourcesFit set to MostAllocated. This enables [bin packing](https://kubernetes.io/docs/concepts/scheduling-eviction/resource-bin-packing/) scheduling scenarios.

### What's in this repo?
* I wasn't able to find an existing official image for the vanilla kube-scheduler. So I built my own (ghcr.io/markjgardner/kube-scheduler). This is just a vanilla build of the current kube-scheduler binary from [kubernetes upstream](https://github.com/kubernetes/kubernetes).
* [pack-scheduler.yaml](pack-scheduler.yaml) is created as a simple replica set within the kube-system namespace. It is important that the priority class for the pod be set to ```system-cluster-critical```.
* [test-deployment.yaml](test-deployment.yaml) is meant to show the different scheduling strategies in action. With pack-scheduler the pods will all be allocated to a single node (assuming enough resource capacity). Compare this behavior to the default scheduler which will spread the pods across multiple nodes.
