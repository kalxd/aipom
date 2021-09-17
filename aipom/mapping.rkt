#lang azelf

(require racket/list)

(provide get-file-type)

(define mapping-ext
  (hasheq #".html" #"text/html"
          #".css" #"text/css"
          #".js" #"text/javascript"

          ; 文字
          #".ttf" #"font/ttf"
          #".otf" #"font/otf"
          #".woff" #"font/woff"

          ; 图片
          #".apng" #"image/apng"
          #".bmp" #"image/bmp"
          #".gif" #"image/gif"
          '(#".ico" #".cur") #"image/x-icon"
          '(#".jpg" #".jpeg" #".jfif" #".pjpeg" #".pjp") #"image/jpeg"
          #".png" #"image/png"
          #".svg" #"image/svg"
          '(#".tif" #".tiff") #"image/tiff"
          #".webp" #"image/webp"))

(define/curry (match-ext name x)
  (match-define (cons a b) x)
  (cond
    [(list? a) (member name a)]
    [else (equal? a name)]))

(define/contract (get-file-type ext-name)
  (-> bytes? (Maybe/c bytes?))
  (maybe/do
   (let xs = (hash->list mapping-ext))
   (x <- (findf (match-ext ext-name) xs))
   (! (match-define (cons _ a) x))
   a))
