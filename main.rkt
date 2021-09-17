#lang azelf

(require "./aipom/server.rkt"
         "./aipom/option.rkt")

(module+ main
  (require racket/cmdline)

  (command-line
   #:program "aipom"
   #:once-each
   [("-p" "--port")
    port
    "开放端口"
    (set-option-bind-port! default-option port)]

   [("-d" "--dir")
    dir
    "静态服务文件目录"
    (let ([dir (->> dir
                    string->path
                    path->complete-path)])
      (set-option-working-dir! default-option dir))]

   [("-i" "--ip")
    ip
    "开放地址"
    (set-option-bind-addr! default-option ip)]

   #:args()
   (displayln default-option)))
