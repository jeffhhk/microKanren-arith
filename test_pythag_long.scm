(load "microKanren/microKanren.scm")
(load "microKanren/miniKanren-wrappers.scm")
(load "more-wrappers.scm")
(load "faster-miniKanren/numbers.scm")

(define +o pluso)
(define -o minuso)

;;; find pythagorean triples
(time
 (pretty-print
  (run 3 (A)
       (fresh (a b c a2 b2 c2)
	      (== A (list a b c))
	      (<o (build-num 0) a)     ; zeros don't count
	      (<o (build-num 0) b)
	      ;;(<o (build-num 0) c)   ; do we need to hint that c is an integer?
	      (<o a b)                 ; optional perf hack: break symmetry
	      (<o c (build-num 14))
	      (*o a a a2)
	      (*o b b b2)
	      (*o c c c2)
	      (trace-var-list "considering (a b c)=~a\n" (list a b c))
	      (+o a2 b2 c2)
	      ))))


