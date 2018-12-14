(module codex (cdx-find cdx-latest cdx-all)
  (import (chicken io))
  (import (chicken keyword))
  (import (chicken string))
  (import (srfi 13))
  (import (srfi 69))
  (import (json))
  (import scheme)
  (import ht)

  (define (cdx-reader file)
    (define (process-cdx-record data)
      (alist->hash-table
        (map
          cons
          '(SURT: DATE: URL: MIMETYPE: STATUS_CODE: DIGEST: REDIRECT: META_TAGS: LEN: OFFSET: WARC: ORIG_LEN: ORIG_OFFSET: ORIG_WARC:)
          data)))

    (call-with-input-file
      file
      (lambda (input-port)
        (let loop ((line (read-line input-port)) (objs '()))
          (if (not (eof-object? line))
            (if (equal? (car (string-split line)) "CDX")
              (loop (read-line input-port) objs)
              (loop (read-line input-port) (cons (process-cdx-record (string-split line)) objs)))
            objs)))))

  (define (cdx-find file dict)
    (let loop ((data (cdx-reader file)) (results '()))
      (if (null? data)
        results
        (if (hash-table-contains? (car data) dict)
          (loop (cdr data) (cons (car data) results))
          (loop (cdr data) results)))))

  (define (cdx-latest file dict)
    (let loop ((data (cdx-find file dict)) (result (alist->hash-table (map cons '(DATE:) '("0")))))
      (if (and (null? data) (not (equal? (hash-table-ref result DATE:) 0)))
        result
        (if (> (string->number (hash-table-ref (car data) DATE:)) (string->number (hash-table-ref result DATE:)))
          (loop (cdr data) (car data))
          (loop (cdr data) result)))))

  (define (cdx-all file)
    (cdx-reader file)))
