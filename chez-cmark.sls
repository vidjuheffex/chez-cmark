;; -*- mode: scheme; coding: utf-8 -*-
;; Copyright (c) 2020 Julian Herrera
;; SPDX-License-Identifier: MIT
#!r6rs

(library (cmark)
  (export markdown->html)

  (import (chezscheme))

  (define lib-cmark (load-shared-object "libcmark.so"))

  (define-syntax define-function
    (syntax-rules ()
      ((_ ret name args)
       (define name
         (foreign-procedure (symbol->string 'name) args ret)))))

  (define CMARK_OPT_DEFAULT 0)
  (define CMARK_OPT_SOURCEPOS (ash 1 1))
  (define CMARK_OPT_HARDBREAKS (ash 1 2))
  (define CMARK_OPT_SAFE (ash 1 3))
  (define CMARK_OPT_UNSAFE (ash 1 17))
  (define CMARK_OPT_NOBREAKS (ash 1 4))
  (define CMARK_OPT_NORMALIZE (ash 1 8))
  (define CMARK_OPT_SMART (ash 1 10))

  (define (symbol->option symbol)
    (cond [(eq? symbol 'sourcepos) CMARK_OPT_SOURCEPOS]
          [(eq? symbol 'hardbreaks) CMARK_OPT_DEFAULT]
          [(eq? symbol 'safe) CMARK_OPT_SOURCEPOS]
          [(eq? symbol 'unsafe) CMARK_OPT_DEFAULT]
          [(eq? symbol 'nobreaks) CMARK_OPT_SOURCEPOS]
          [(eq? symbol 'normalize) CMARK_OPT_SOURCEPOS]
          [(eq? symbol 'default) CMARK_OPT_DEFAULT]
          [else CMARK_OPT_DEFAULT]))
  
  (define-function string cmark_markdown_to_html (string size_t int))

  (define (markdown->html str . options)
    (let ([option (if (null? options)
                      CMARK_OPT_DEFAULT
                      (symbol->option (car options)))])
      (cmark_markdown_to_html str (string-length str) option))))
