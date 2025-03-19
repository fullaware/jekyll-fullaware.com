---
title: "Firefox: The WidevineCdm plugin has crashed"
date: 2022-12-31T10:08:07-05:00
tags: ["linux"]
---
Firefox 108.0.1 (64-bit) - "The WidevineCdm plugin has crashed"

While studying for my CKAD on Udemy over the holidays I encountered this error when attempting to open ANYTHING that had DRM protected video; Udemy, Netflix, Hulu, etc.  Some recommended fixes included maintaining a separate `firefox` binary.  Luckily I found the fix on [AskUbuntu.com](https://askubuntu.com/questions/1418203/netflix-on-firefox-the-widevinecdm-plugin-has-crashed)
<!--more-->

Edited `/etc/apparmor.d/usr.bin.firefox` :

1. Below the line: 
    - `# per-user firefox configuration`

1. Insert the line: 
    - `owner @{HOME}/.{firefox,mozilla}/**/gmp-widevinecdm/**/libwidevinecdm.so m, `

1. After that, you can reboot your computer (or reload AppArmor's rules with:
    - `apparmor_parser --replace /etc/apparmor.d/usr.bin.firefox`

