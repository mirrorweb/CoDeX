;; CoDeX.scm

(module codex_mod (hello)
    (import base)
    (import (chicken syntax))
    (import (chicken scheme))

    (define (hello name)
      (print "Hello " name)))
