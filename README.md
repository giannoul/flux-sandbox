# flux-sandbox
This is a sandbox project in order to play with flux


flux manifests
https://github.com/fluxcd/flux2/tree/v0.27.3

Flux quirks
```
root@serpent:/# flux get kustomizations -A
NAMESPACE       NAME    READY   MESSAGE                                                                                         REVISION        SUSPENDED 
default         nginx   False   Pod/nginx namespace not specified, error: the server could not find the requested resource                      False   
```

Solution
```
Add namespace to the pod.yaml (even if it is the `default` namespace)
```