;;;; with-struct.asd

(asdf:defsystem #:with-struct
  :description "with-struct macro for simplifying struct access"
  :author "Ivan Kocienski"
  :license "LGPL"
  :serial t
  :components ((:file "src/package")
               (:file "src/with-struct")))

