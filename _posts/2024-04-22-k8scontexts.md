---
title: "Managing multiple Kubernetes contexts"
date: 2024-04-22
tags : [ "k8s"]
draft: false
layout: post
---

Keep all INDIVIDUAL kubeconfig.yaml files under `.kube/contexts`

```
.kube/contexts
├── k8scluster1.yaml
└── k8scluster2.yaml
```

Then put the following line in your `.bashrc` (Linux) or `.bash_profile` (MacOS)

```
export KUBECONFIG=${HOME}/.kube/config:$(for YAML in $(find ${HOME}/.kube/contexts -name '*.yaml') ; do echo -n ":${YAML}"; done)
```
<!--more-->