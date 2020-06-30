#lang racket/base

(provide (all-defined-out))

(struct 命令标识体 ([目录 #:mutable]
                  [端口 #:mutable])
  #:transparent)

(define (生成默认标识)
  (let ([默认目录 (current-directory)]
        [默认端口 8000])
    (命令标识体 默认目录 默认端口)))
