;; Jason Hemann and Dan Friedman
;; microKanren, final implementation from paper

(define (var c) (vector c))
(define (var? x) (vector? x))
(define (var=? x1 x2) (= (vector-ref x1 0) (vector-ref x2 0)))

(define (walk u s)
  (let ((pr (and (var? u) (assp (lambda (v) (var=? u v)) s))))
    (if pr (walk (cdr pr) s) u)))

(define (ext-s x v s) `((,x . ,v) . ,s))

(define-syntax lambdag@
  (syntax-rules ()
    ((_ (s) e) (cons 'goal (lambda (s) e)))))

(define-syntax applyg@
  (syntax-rules ()
    ((_ g e) ((cdr g) e))))

(define (== u v)
  (lambdag@ (s/c)
    (let ((s (unify u v (car s/c))))
      (if s (unit `(,s . ,(cdr s/c))) mzero))))

(define (unit s/c) (cons s/c mzero))
(define mzero '())

(define (unify u v s)
  (let ((u (walk u s)) (v (walk v s)))
    (cond
      ((and (var? u) (var? v) (var=? u v)) s)
      ((var? u) (ext-s u v s))
      ((var? v) (ext-s v u s))
      ((and (pair? u) (pair? v))
       (let ((s (unify (car u) (car v) s)))
         (and s (unify (cdr u) (cdr v) s))))
      (else (and (eqv? u v) s)))))

(define (call/fresh f)
  (lambdag@ (s/c)
    (let ((c (cdr s/c)))
      (applyg@ (f (var c)) `(,(car s/c) . ,(+ c 1))))))

(define (disj g1 g2) (lambdag@ (s/c) (mplus (applyg@ g1 s/c) (applyg@ g2 s/c))))
(define (conj g1 g2) (lambdag@ (s/c) (bind (applyg@ g1 s/c) g2)))

(define (mplus $1 $2)
  (cond
    ((null? $1) $2)
    ((procedure? $1) (lambda () (mplus $2 ($1))))
    (else (cons (car $1) (mplus (cdr $1) $2)))))

(define (bind $ g)
  (cond
    ((null? $) mzero)
    ((procedure? $) (lambda () (bind ($) g)))
    (else (mplus (applyg@ g (car $)) (bind (cdr $) g)))))
