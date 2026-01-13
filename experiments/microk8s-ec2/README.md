# DeathStarBench – MicroK8s EC2 Experiments

Branch: exp/microk8s-ec2

## Purpose
Run the HotelReservation benchmark on a real MicroK8s cluster
deployed on AWS EC2 (t3.large nodes), with custom Docker images
hosted in a private Docker Hub namespace.

## Scope of changes
- Custom Docker image tags
- Kubernetes manifests adapted for MicroK8s
- Resource tuning for small clusters
- No semantic workload changes unless explicitly stated

## Cluster assumptions
- MicroK8s v1.xx
- containerd runtime
- 1 control + N workers
- NodePort ingress for observability

## Reproducibility
Baseline upstream commit: <fill after first commit>
Docker tag: hr-exp-001

