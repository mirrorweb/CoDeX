(import (chicken io))
(import (chicken keyword))
(import (chicken string))
(import (srfi 13))
(import (srfi 69))

(define (cdx-reader file)
  (define (process-columns columns)
    ; Return a list of cdx lines as hash-tables
    (define hs '(SURT: DATE: URL: MIMETYPE: RESPONSE_CODE: DIGEST: REDIRECT: META_TAGS: LENGTH: OFFSET: WARC_FILE: ORIG_LENGTH: ORIG_OFFSET: ORIG_WARC_FILE:))
    (let loop ((data '()) (hs hs) (cols columns))
      (if (not (and (null? hs) (null? cols)))
        (loop (cons (cons (car hs) (cons (car cols) '())) data) (cdr hs) (cdr cols))
        (alist->hash-table data))))

  (call-with-input-file
    file
    (lambda (input-port)
      (let loop ((line (read-line input-port)) (objs '()))
        (if (not (eof-object? line))
          (if (equal? (car (string-split line)) "CDX")
            (loop (read-line input-port) objs)
            (loop (read-line input-port) (cons (process-columns (string-split line)) objs)))
          (reverse objs))))))

(for-each
  (lambda (dict) (hash-table-for-each dict (lambda (k v) (print k " " v))))
  (cdx-reader "sample_archive/cdx/MW-miskatonicuniversity-e9b4b8de-2739-4417-98eb-7a3f3f676e68-000-20181119155108-neilmunro.herokuapp.com-00000.cdx"))

(print "")
(hash-table-for-each (alist->hash-table '((SURT: "https://github.com/mirrorweb/CoDeX") (DATE: 20181120235542))) (lambda (k v) (print k " " v)))

(define (cdx-find dict)
  (print dict))

(define (cdx-find-all dict)
  (print dict))

(define (cdx-find-latest dict)
  (print dict))
