[![MELPA](http://melpa.org/packages/helm-circe-badge.svg)](http://melpa.org/#/helm-circe) [![MELPA Stable](http://stable.melpa.org/packages/helm-circe-badge.svg)](http://stable.melpa.org/#/helm-circe)
# helm-circe

Helm bindings for managing circe buffers.

Manage circe buffers easily with Helm.

A call to `helm-circe` will show a list of server, channel, and query
buffers currently open. From the list, you can easily switch to any
particular buffer or close that buffer which will then perform the
correct action server side (e.g.; if you close a channel buffer, circe
will /part you from that channel). Also, helm-circe supports helm
selections so you can select multiple buffers of all types and close
them in bulk if desired.

![helm-circe](helm-circe.png)

# Setup

Invoke `helm-circe` and bind it to a keyboard shortcut.  See Commands
for additional commands that you might want to key bind.

```
(require 'helm-circe)
(global-set-key (kbd "C-c c i") 'helm-circe)
; Handy to have a binding to helm-circe-new-activity
(global-set-key (kbd "C-c c n") 'helm-circe-new-activity)
```

# Commands
`helm-circe`
Main command that displays channels, queries, and servers in different
sections of the candidate list.

`helm-circe-new-activity`
Displays a candidate list of channels that have had activity since
last viewed. Mirrors what tracking-mode puts in the mode line... but
in helm so much faster.

`helm-circe-by-server`
Displays a candidate list of channels with each channel in a specific
server section in the candidate list.

`helm-circe-channels`
Displays all channels in a single candidate list regardless of server.

`helm-circe-servers`
Displays all circe server buffers in a candidate list.

`helm-circe-queries`
Displays all circe query buffers in a candidate list.

