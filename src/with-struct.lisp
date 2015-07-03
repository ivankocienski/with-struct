
(in-package :with-struct)

(defun join-and-intern (&rest args)
  "(private) given any list of words, return an internalized symbol"
  (let ((string-args (mapcar (lambda (w) (string w)) args)))
    (intern
     (string-upcase
      (apply
       'concatenate (cons 'string string-args))))))

(defun do-code-substitution (strname objname names code)
  "(private) internal function core of with-struct macro"
  (labels ((make-lut (names)
	     (if names
		 (let*
		     ((thing (car names))
		      
		      (rest (cdr names))
		      
		      (var-name
		       (if (listp thing)
			   (car thing)
			   thing))
		      
		      (struct-name
		       (if (listp thing)
			   (cadr thing)
			   thing))

		      (entry
		       (cons
			var-name
			(list (join-and-intern strname "-" struct-name) objname)))
		      )

		   (cons entry (make-lut rest)))))
	   
	   (deep-substitution (in-list sub-table)
	     (if in-list
		 (let*
		     ((lookup (car in-list))
		      (node (if (listp lookup)
				(deep-substitution lookup sub-table)
				(or (cdr (assoc lookup sub-table)) lookup)))
		      (rest (deep-substitution (cdr in-list) sub-table)))

		   (cons node rest)))))

    (deep-substitution code (make-lut names))))


(defmacro with-struct (struct-name object-name names &body body)
  "replace short names with proper struct function call forms"
  `(progn
     ,@(do-code-substitution struct-name object-name names body)))






