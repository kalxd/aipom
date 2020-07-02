#lang racket/base

(require web-server/servlet-env
         web-server/http
         net/url-string
         racket/list
         racket/string
         racket/file
         racket/path
         racket/match

         "./flag.rkt")

(provide 启动服务)

;;; 匹配MIME类型。
(define (匹配MINE 文件扩展)
  (define t (match 文件扩展
              [#".html" #"text/html"]
              [#".css" #"text/css"]
              [#".js" #"text/javascript"]
              [else #"text/plain"]))
  (bytes-append t #"; charset=utf-8"))

;;; 检测文件是否存在，
;;; 不存在则尝试读取index.html。
(define (检测文件 文件)
  (if (file-exists? 文件)
      文件
      (let ([索引文件 (build-path 文件 'same "index.html")])
        (and (file-exists? 索引文件) 索引文件))))

(define (拼接请求路径 目录 req)
  (let* ([uri (request-uri req)]
         [path (url-path uri)]
         [path (map path/param-path path)]
         [path (filter non-empty-string? path)])
    (apply build-path (cons 目录 path))))

(define (正常请求日志 req)
  (let ([method (request-method req)]
        [url (url->string (request-uri req))])
    (printf "~a ~a - 200\n" method url)
    (flush-output)))

(define (输出请求文件 文件)
  (let ([mine (匹配MINE (path-get-extension 文件))]
        [body (file->bytes 文件)])
    (response/full 200
                   #"OK"
                   (current-seconds)
                   mine
                   empty
                   (list body))))

(define (未找到日志 req)
  (let ([method (request-method req)]
        [url (url->string (request-uri req))])
    (printf "~a ~a - 404\n" method url)
    (flush-output)))

(define 输出未找到
  (response/full 404
                 #"Not Found"
                 (current-seconds)
                 #"text/html; charset=utf-8"
                 empty
                 empty))

(define (请求处理 目录 req)
  (let* ([请求文件 (拼接请求路径 目录 req)]
         [文件 (检测文件 请求文件)])
    (if (file-exists? 文件)
        (begin
          (正常请求日志 req)
          (输出请求文件 文件))
        (begin
          (未找到日志 req)
          输出未找到))))

(define (启动服务 标识)
  (let ([端口 (命令标识体-端口 标识)]
        [目录 (命令标识体-目录 标识)])
    (serve/servlet (λ (req) (请求处理 目录 req))
                   #:port 端口
                   ; #:command-line? #t
                   #:launch-browser? #f
                   #:servlet-regexp #rx"")))

(module+ test
  (启动服务 (生成默认标识)))
