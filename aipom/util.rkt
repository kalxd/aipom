; 中间细小工具类、函数。
#lang azelf

(provide (all-defined-out))

; 一个请求携带的全部环境。
(struct server-env [req dir]
  #:transparent)
