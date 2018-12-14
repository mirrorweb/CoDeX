(import (chicken keyword))
(import (srfi 69))
(import (json))

(import codex)

(json-write
  (cdx-all "sample_archive/cdx/neilmunro.herokuapp.com.cdx"))

(print "\n")

(json-write
  (cdx-find
    "sample_archive/cdx/neilmunro.herokuapp.com.cdx"
    (alist->hash-table (map cons '(SURT: DATE:) '("com,herokuapp,neilmunro)/" "20181119155119")))))

(print "\n")

(json-write
  (cdx-latest
    "sample_archive/cdx/neilmunro.herokuapp.com.cdx"
    (alist->hash-table (map cons '(STATUS_CODE:) '("200")))))

; "CDXQL <cdx_source>" - enters a CLI
; "CDXQL <cdx_source> -Q DATE > 2018*"
