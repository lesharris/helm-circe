# helm-circe
Helm bindings for managing circe buffers

Manage circe buffers easily with Helm

A call to `helm-circe` will show a list of circe server and
channel buffers allowing for easy switching and managing.

# Setup
Invoke `helm-circe` and bind it to a keyboard shortcut

```
(require 'helm-circe)
(global-set-key (kbd "C-c c i") 'helm-circe)
```
