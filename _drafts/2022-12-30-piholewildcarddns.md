---
title: "Pi-Hole Wildcard DNS"
date: 2022-12-30
tags : ["homelab", "k8s"]
---
In order to access Kubernetes applications via my ingress [projectcontour.io](https://projectcontour.io), I'll use a wildcard DNS entry.  

Unfortunately this isn't a simple entry in the web UI for Pi-hole (yet?).  A quick search and [Brandon Rozek](https://brandonrozek.com/blog/wildcarddomainspihole/) had documented the steps to add a wildcard DNS entry in `dnsmasq`.
<!--more-->
First, lets get the External-IP of our envoy LoadBalancer service.  Mine shows as `10.28.28.80`.

```BASH
kubectl get service envoy -n projectcontour

NAME    TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
envoy   LoadBalancer   10.103.158.9   10.28.28.80   80:32032/TCP,443:31610/TCP   43h
```
Next we will need to SSH into our Pi-Hole and create a new config file located at `/etc/dnsmasq.d/03-custom-dns.conf`

```
address=/k8s.home.fullaware.com/10.28.28.80
```
Next let's restart Pi-Hole service to reload the new config.

```BASH
sudo systemctl restart pihole-FTL
```

Now when I `dig` for the `k8s.home.fullaware.com` domain it comes up with the IP address of the `envoy` LoadBalancer.

```BASH
;; QUESTION SECTION:
;k8s.home.fullaware.com.                IN      A

;; ANSWER SECTION:
k8s.home.fullaware.com. 0       IN      A       10.28.28.80
```

This allows me to create an ingress with the name `asteroids.k8s.home.fullaware.com` to point to my hosted app [asteroids](https://github.com/fullaware/asteroids).

```YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: asteroids-app
  namespace: asteroids
spec:
  rules:
  - host: asteroids.k8s.home.fullaware.com
    http:
      paths:
        - pathType: Prefix
          path: "/"
          backend:
            service:
              name: asteroids-app
              port:
                number: 8080
```