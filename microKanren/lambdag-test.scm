(load "microKanren.scm")
(load "miniKanren-wrappers.scm")

(lambdag@ (s/c)
	  (unit s/c))

(call/goal
 (lambdag@ (s/c)
	   (unit s/c)))

(expand
 '(take 5
	(call/goal
	 (lambdag@ (s/c)
		   (unit s/c)))))
(take 5
      (call/goal
       (lambdag@ (s/c)
		 (unit s/c))))

(expand
 '(call/goal
   (fresh (q)
	  (lambdag@ (s/c)
		    (unit s/c)))))

(call/goal
 (fresh (q)
	(lambdag@ (s/c)
		  (unit s/c))))



(map
 reify-1st
 (take 5
       (call/goal
	(lambdag@ (s/c)
		  (unit s/c)))))

(expand
 '(run 5 (q)
     (lambdag@ (s/c)
	       (unit s/c))))
#|(#2%map
  reify-1st
  (take
    5
    (call/goal
      (call/fresh
        (lambda (#{q dd0bdng6ohnfmagibum0x42-21})
          (#2%cons
            'oops
            (lambda (#{s/c dd0bdng6ohnfmagibum0x42-22})
              (lambda ()
                ((#2%cdr
                   (#2%cons
                     'oops
                     (lambda (#{s/c dd0bdng6ohnfmagibum0x42-23})
                       (unit #{s/c dd0bdng6ohnfmagibum0x42-23}))))
                  #{s/c dd0bdng6ohnfmagibum0x42-22})))))))))|#

(run 5 (q)
     (lambdag@ (s/c)
	       (unit s/c)))

(applyg@
 (lambdag@ (s/c)
	   (unit s/c))
 empty-state)

(run 5 (q)
 (lambdag@ (s/c)
	   (unit s/c)))

(run 5 (q)
     (== q 5))

(applyg@
 (lambdag@ (q) (== q 5))
 empty-state)
;; (oops . #<procedure>)

(applyg@
 (fresh (q) (lambdag@ (s/c) (unit s/c)))
 empty-state)


(applyg@ (call/fresh (lambda (q) (== q 5))) empty-state)

(call/goal
 (fresh (q) (== q 3)))

(take 5
      (call/goal
       (fresh (q) (== q 3))))


(take 5
      (call/goal
       (fresh (q) (disj (== q 3) (== q 7)))))




(run 5 (A)
      (fresh (a b)
             (== A (list a b))
             (conde ((== a 'c-1-l) (== b 'c-1-r))
                    ((== a 'c-2-l) (== b 'c-2-r))
                    (else (== b 'c-3-r)))))
