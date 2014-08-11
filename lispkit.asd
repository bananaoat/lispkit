;; -*- mode: common-lisp -*-
(defsystem lispkit
  :version "0.0.1"
  :description "Lispy browser"
  :licence "BSD"
  :components ((:file "lispkit" :depends-on ("macros" "packages" "keys"))
               (:file "macros"  :depends-on ("packages"))
               (:file "keys"    :depends-on ("packages" "browser"))
               (:file "browser")
               (:file "packages"))
  :depends-on (:cl-cffi-gtk :cl-webkit))
