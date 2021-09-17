#lang azelf

(require racket/string
         net/url
         web-server/http
         "./util.rkt")

(provide open-file)

; 检测文件是否存在，若不存在，尝试读了index.html。
(define/contract (try-file where)
  (-> path? path?)
  (cond
    ; 如果是个目录，则读取目录下的index.html。
    [(directory-exists? where) (build-path where "index.html")]
    [else where]))

; 从url path构建出预想中的请求文件路径。
(define/contract (url-path->path dir req-path)
  (-> path? (listof path/param?) path?)
  (->> req-path
       (map path/param-path it)
       (filter non-empty-string? it)
       (apply build-path (cons dir it))))

; 打开一个文件，文件返回Nothing。
(define/contract (open-file env)
  (-> server-env? (Maybe/c path?))
  (match-define (server-env req dir) env)
  (define req-path
    (->> req
         request-uri
         url-path))
  (define file-path
    (->> (url-path->path dir req-path)
         try-file))

  (maybe/do
   (file-exists? file-path)
   file-path))
