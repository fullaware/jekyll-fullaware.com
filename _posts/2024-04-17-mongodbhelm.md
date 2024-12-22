---
title: "MongoDB Proper Kubernetes installation with Helm"
date: 2024-04-17T09:59:03-04:00
tags : ["mongodb", "k8s"]
draft: false
layout: post
---
# Overview
In a previous post I created my own MongoDB deployment and installed with Kustomize.  Let's use the "official" Bitnami Helm Chart to install MongoDB.
<!--more-->
This installs MongoDB as a standalone (NO High Availability) node.  For my purpose I'm also making it a statefulset so my backup scripts work the same regardless if the architecture is `standalone` or `replicaset`.

```
helm install mongodb-ce oci://registry-1.docker.io/bitnamicharts/mongodb -n mongodb-ce --create-namespace \
--set architecture=standalone \
--set useStatefulSet=true \
--set service.type=LoadBalancer \
--set auth.rootUser="root" \
--set auth.rootPassword="Candy123"
```

