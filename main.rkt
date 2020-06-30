#lang racket/base

(struct cmd-flag [dir port]
  #:transparent)

(define (start-server flag)
  (displayln flag))

(module+ main
  (require racket/cmdline)

  (let ([dir (make-parameter (current-directory))]
        [port (make-parameter 8000)])
    (command-line
     #:program "Aipom"
     #:once-each
     [("-p" "--port") port_ "开放端口" (port port_)]
     [("-d" "--dir") dir_ "静态服务文件目录" (dir dir_)]
     #:args()
     (start-server (cmd-flag (dir) (port))))))
