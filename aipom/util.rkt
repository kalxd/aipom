#lang racket/base

(provide (all-defined-out))

(define 扩展映射
  (make-immutable-hash
   '(; 前端三剑客
     (#".html" . #"text/html")
     (#".css" . #"text/css")
     (#".js" . #"text/javascript")
     ; 文字
     (#".ttf" . #"font/ttf")
     (#".otf" . #"font/otf")
     (#".woff" . #"font/woff")
     ; 图片
     (#".apng" . #"image/apng")
     (#".bmp" . #"image/bmp")
     (#".gif" . #"image/gif")
     (#".ico" . #"image/x-icon")
     (#".cur" . #"image/x-icon")
     (#".jpg" . #"image/jpeg")
     (#".jpeg" . #"image/jpeg")
     (#".jfif" . #"image/jpeg")
     (#".pjpeg" . #"image/jpeg")
     (#".pjp" . #"image/jpeg")
     (#".png" . #"image/png")
     (#".svg" . #"image/svg+xml")
     (#".tif" . #"image/tiff")
     (#".tiff" . #"image/tiff")
     (#".webp" . #"image/webp"))))

(define (记录日志/正常 日志信息)
  (printf "I: ~a\n" 日志信息)
  (flush-output))

(define (记录日志/错误 日志信息)
  (printf "E: ~a\n" 日志信息)
  (flush-output))

(define (string->绝对路径 用户输入)
  (let ([路径 (string->path 用户输入)])
    (if (absolute-path? 路径)
        路径
        (build-path (current-directory) 路径))))
