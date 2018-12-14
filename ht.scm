(module ht (hash-tables-equal? hash-table-contains?)
  (import (srfi 69))
  (import scheme)

  (define (hash-tables-equal? h1 h2)
    (cond
      ((not (equal? (length (hash-table-keys h1)) (length (hash-table-keys h2)))) #f) ; Keys length is inequal
      ((member #f (map (lambda (key) (member key (hash-table-keys h1))) (hash-table-keys h2))) #f) ; Keys differ
      ((member #f (map (lambda (key) (equal? (hash-table-ref h1 key) (hash-table-ref h2 key))) (hash-table-keys h1))) #f) ; Values differ
      (else #t))) ; If key length, key members and values same, hash-tables are the same!

  (define (hash-table-contains? h1 h2) ; h1 is the whole hash-table, h2 is the smaller one.
    (let build-hash-table ((keys (hash-table-keys h2)) (new-keys '()) (vals '()))
      (if (not (null? keys))
        (if (member (car keys) (hash-table-keys h1))
          (build-hash-table (cdr keys) (cons (car keys) new-keys) (cons (hash-table-ref h1 (car keys)) vals))
          (build-hash-table (cdr keys) new-keys vals))
        (hash-tables-equal? h2 (alist->hash-table (map cons new-keys vals)))))))
