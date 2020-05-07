;;;; dct.asd

(asdf:defsystem #:dct
  :description "Implementation of Discrete Cosine Transform (DCT) and Inverse Discrete Cosine Transform."
  :author "S. Karthik kumar <karthikkumar.s@protonmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :depends-on (#:iterate #:alexandria)
  :serial t
  :components ((:module src
                :serial t
                :components ((:file "package")
                             (:file "dct")))))
