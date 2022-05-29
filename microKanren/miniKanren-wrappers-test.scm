;;; Test programs

(define-syntax test-check
  (syntax-rules ()
    ((_ title tested-expression expected-result)
     (begin
       (printf "Testing ~s\n" title)
       (let* ((expected expected-result)
              (produced tested-expression))
         (or (equal? expected produced)
             (errorf 'test-check
               "Failed: ~a~%Expected: ~a~%Computed: ~a~%"
               'tested-expression expected produced)))))))

(define (appendo l s out)
  (conde
    ((== '() l) (== s out))
    ((fresh (a d res)
       (== `(,a . ,d) l)
       (== `(,a . ,res) out)
       (appendo d s res)))))

(test-check 'run*
  (run* (q) (fresh (x y) (== `(,x ,y) q) (appendo x y '(1 2 3 4 5))))
  '((() (1 2 3 4 5))
    ((1) (2 3 4 5))
    ((1 2) (3 4 5))
    ((1 2 3) (4 5))
    ((1 2 3 4) (5))
    ((1 2 3 4 5) ())))

(test-check 'run*2
  (run* (q x y) (== `(,x ,y) q) (appendo x y '(1 2 3 4 5)))
  '((() (1 2 3 4 5))
    ((1) (2 3 4 5))
    ((1 2) (3 4 5))
    ((1 2 3) (4 5))
    ((1 2 3 4) (5))
    ((1 2 3 4 5) ())))
  
(test-check 'rember*o
  (letrec
      ((rember*o (lambda (tr o)
                   (conde
                     ((== '() tr) (== '() o))
                     ((fresh (a d)
                        (== `(,a . ,d) tr)
                        (conde
                          ((fresh (aa da)
                             (== `(,aa . ,da) a)
                             (fresh (a^ d^)
                               (rember*o a a^)
                               (rember*o d d^)
                               (== `(,a^ . ,d^) o))))
                          ((== a 8) (rember*o d o))
                          ((fresh (d^)
                             (rember*o d d^)
                             (== `(,a . ,d^) o))))))))))
       (run 8 (q) (rember*o q '(1 2 8 3 4 5))))
    '((1 2 8 3 4 5)
      (1 2 8 3 4 5 8)
      (1 2 8 3 4 8 5)
      (1 2 8 3 8 4 5)
      (1 2 8 8 3 4 5)
      (1 2 8 8 3 4 5)
      (1 8 2 8 3 4 5)
      (8 1 2 8 3 4 5)))

(test-check 'rember*o
  (letrec
      ((rember*o (lambda (tr o)
                   (conde
                     ((== '() tr) (== '() o))
                     ((fresh (a d)
                        (== `(,a . ,d) tr)
                        (conde
                          ((fresh (aa da)
                             (== `(,aa . ,da) a)
                             (fresh (a^ d^)
                               (== `(,a^ . ,d^) o)
                               (rember*o d d^)
                               (rember*o a a^))))
                          ((== a 8) (rember*o d o))
                          ((fresh (d^)
                             (== `(,a . ,d^) o)
                             (rember*o d d^))))))))))
       (run 9 (q) (rember*o q '(1 (2 8 3 4) 5))))
    '((1 (2 8 3 4) 5)
      (1 (2 8 3 4) 5 8)
      (1 (2 8 3 4) 5 8 8)
      (1 (2 8 3 4) 8 5)
      (1 8 (2 8 3 4) 5)
      (8 1 (2 8 3 4) 5)
      (1 (2 8 3 4) 5 8 8 8)
      (1 (2 8 3 4) 5 8 8 8 8)
      (1 (2 8 3 4) 5 8 8 8 8 8)))




