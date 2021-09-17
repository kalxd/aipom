#lang azelf

(require web-server/servlet-env
         web-server/http
         net/url

         (only-in racket/port
                  copy-port)
         (only-in racket/path
                  path-get-extension)
         (only-in racket/list
                  empty)

         "./util.rkt"
         "./option.rkt"
         "./mapping.rkt"
         "./file.rkt")

(provide run-server)

; 日志输出。
(define (output/log env error?)
  (define req (server-env-req env))
  (define req-url
    (->> (request-uri req)
         url->string))
  (define req-method (request-method req))
  (define code
    (if error? 404 200))
  (define log
    (format "~a ~a - ~a" req-method req-url code))
  (displayln log)
  (flush-output))

; 文件存在，正常输出。
(define (output/file file-path)
  (define mime-type
    (->> (path-get-extension file-path)
         get-file-type
         (maybe-> #"text/html")
         (bytes-append it #"; charset=utf8")))

  (response/output
   (λ (port)
     (call-with-input-file file-path
       (λ (file-port)
         (copy-port file-port port))))
   #:mime-type mime-type))

; 请求处理。
(define (handler env)
  (match (open-file env)
    [(Just file-path)
     (begin
       (output/log env #f)
       (output/file file-path))]
    [(Nothing)
     (begin
       (output/log env #t)
       (response/full 404
                      #"Not Found"
                      (current-seconds)
                      TEXT/HTML-MIME-TYPE
                      empty
                      empty))]))

; 启动服务。
; 服务入口。
(define (run-server option)
  (let ([dir (option-working-dir option)]
        [port (option-bind-port option)]
        [addr (option-bind-addr option)])
    (serve/servlet (<-< handler (server-env it dir))
                   #:port port
                   #:listen-ip addr
                   #:launch-browser? #f
                   #:servlet-regexp #rx"")))

(module+ test
  (run-server default-option))
