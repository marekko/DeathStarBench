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

# DeathStarBench – MicroK8s EC2 experiment (hotelReservation)

This experiment deploys the DeathStarBench HotelReservation app on MicroK8s (AWS EC2) and runs the wrk2 mixed workload with tracing (Jaeger).

## Deploy
```bash
cd experiments/microk8s-ec2/kustomize
kubectl apply -k .
kubectl -n hotel-res-app get pods



kubectl -n hotel-res-app port-forward svc/jaeger 16686:16686
curl -sS http://127.0.0.1:16686/api/services


# prints the image tag on success
./experiments/microk8s-ec2/tools/wrk2/build_push.sh

# creates/updates ConfigMap + runs Job + prints Job logs
./experiments/microk8s-ec2/workload/run_wrk2_type1.sh

Files

kustomize/ – deployment overlay (namespace, patches, jaeger-agent DS)

tools/wrk2/build_push.sh – build/push wrk2 image

workload/wrk2/hotel-reservation/mixed-workload_type_1.lua – patched in-cluster workload script

workload/jobs/wrk2-type1.job.yaml – job template

workload/run_wrk2_type1.sh – runner


