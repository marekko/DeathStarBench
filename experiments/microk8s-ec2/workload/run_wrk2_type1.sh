EXP_LUA="experiments/microk8s-ec2/workload/wrk2/hotel-reservation/mixed-workload_type_1.lua"

kubectl -n hotel-res-app create configmap wrk2-scripts \
  --from-file=mixed-workload_type_1.lua="$EXP_LUA" \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl -n hotel-res-app delete job wrk2-type1 --ignore-not-found

env WRK2_IMAGE="$IMG" WRK2_RATE=200 envsubst < .../wrk2-type1.job.yaml | kubectl apply -f -


kubectl -n hotel-res-app wait --for=condition=complete job/wrk2-type1 --timeout=5m
kubectl -n hotel-res-app logs job/wrk2-type1 | head -n 60

