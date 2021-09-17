#lang azelf

(provide (all-defined-out))

; 命令行参数。
(struct option ([working-dir #:mutable]
                [bind-port #:mutable]
                [bind-addr #:mutable])
  #:transparent)

(define default-option
  (let ([working-dir (current-directory)]
        [bind-port 8000]
        [bind-addr "127.0.0.1"])
    (option working-dir
            bind-port
            bind-addr)))
