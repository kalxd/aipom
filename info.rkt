#lang info
(define collection "aipom")
(define deps '(["base" #:version "8.1"]
               "azelf"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))

(define scribblings '(("scribblings/main.scrbl" ())))

(define racket-launcher-names
  '("aipom"))
(define racket-launcher-libraries
  '("main.rkt"))

(define pkg-desc "静态服务。")
(define version "0.1.0")
(define pkg-authors '(XGLey))
