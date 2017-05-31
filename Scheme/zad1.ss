(define mymap
	(lambda (fun lista)
		(if (null? lista)
			()
			(cons	(fun (car lista))
				(mymap fun(cdr lista))
			)
		)
	)
)

(mymap (lambda (x) (+ 1 x)) '(0 2 4 6))
