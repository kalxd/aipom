#lang racket/base

(require web-server/servlet-env
         web-server/http
         net/url-string
         racket/list
         racket/string
         racket/file

         "./flag.rkt")

(provide 启动服务)

(define RESPONSE-TYPE
  #"text/plain; charset=utf-8")

(define (拼接请求路径 目录 req)
  (let* ([url (request-uri req)]
         [path (string-split (url->string url) "/")])
    (apply build-path (cons 目录 path))))

(define (输出请求文件 文件)
  (define body (file->bytes 文件))
  (response/full 200
                 #"OK"
                 (current-seconds)
                 RESPONSE-TYPE
                 empty
                 (list body)))

(define 输出未找到
  (response/full 404
                 #"Not Found"
                 (current-seconds)
                 RESPONSE-TYPE
                 empty
                 empty))

(define (请求处理 目录 req)
  (define 请求文件 (拼接请求路径 目录 req))
  (displayln 请求文件)
  (if (file-exists? 请求文件)
      (输出请求文件 请求文件)
      输出未找到))

(define (启动服务 标识)
  (let ([端口 (命令标识体-端口 标识)]
        [目录 (命令标识体-目录 标识)])
    (serve/servlet (λ (req) (请求处理 目录 req))
                   #:port 端口
                   #:command-line? #t
                   #:launch-browser? #f
                   #:servlet-regexp #rx"")))

(module+ test
  (启动服务 (生成默认标识)))
