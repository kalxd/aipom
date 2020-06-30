#lang racket/base

(require "./aipom/flag.rkt"
         "./aipom/server.rkt")

(module+ main
  (require racket/cmdline)

  (define 命令标识 (生成默认标识))
  (command-line
   #:program "Aipom"
   #:once-each
   [("-p" "--port") 端口 "开放端口" (set-命令标识体-端口! 命令标识 端口)]
   [("-d" "--dir") 目录 "静态服务文件目录" (set-命令标识体-目录! 命令标识 目录)]
   #:args()
   (启动服务 命令标识)))
