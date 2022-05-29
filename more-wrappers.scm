
;;; generalized from microKanren/miniKanren-wrappers.scm reify-1st
(define (reify-var iv s/c)         ;; iv=#(2) 
  (let* ((v (walk* iv (car s/c)))  ;; v=(#(9) #(12) . #(13)) 
	 (tmp (reify-s v '())))    ;; tmp=((#(13) . _.2) (#(12) . _.1) (#(9) . _.0)) 
    (walk* v tmp)))                ;; x=(_.0 _.1 . _.2)

#| trace-var-list takes a format string and a list of microKanren variables
  Since printf is a macro, we can't:

    (apply printf (cons fm xs))

  so instead of absorbing the complexity of turning trace-var inself into
  a macro, we restrict to having only one argument in each format string.
|#
(define trace-var-list
  (lambda (fmt ivs)
    (lambda (s/c)
      (let ((xs (map (lambda (iv) (reify-var iv s/c)) ivs)))
	(printf fmt xs)
	(unit s/c)))))
