FROM alpine:3
COPY ./bin/kube-scheduler /bin/kube-scheduler
ENTRYPOINT ["/bin/kube-scheduler", "--config=/etc/kubernetes/config/kube-scheduler.yaml"]