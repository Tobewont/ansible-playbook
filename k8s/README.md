通过ansible-playbook，以Kubeadm方式部署K8S集群（一主多从）。


> 不建议在生产环境部署

部署完成，

```bash
# kubectl命令补全生效
source ~/.bash_profile

# 修改mode为ipvs
kubectl edit cm kube-proxy -n kube-system

# 重启kube-proxy
kubectl delete pod -n kube-system `kubectl get pod -n kube-system |grep 'kube-proxy' | awk '{print $1}'`
```
