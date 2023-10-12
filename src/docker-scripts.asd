(require 'asdf)
(ql:quickload :cl-ppcre)
(ql:quickload :unix-opts)

(defpackage docker-scripts-system 
  (:use :cl :asdf :cl-ppcre :unix-opts))

(asdf:defsystem "docker-scripts"
  :description "A dockerCLI wrapper"
  :version "0.0"
  :author "ARVA"
  :licence "MIT"
  :components (
               ;;;(:module "filename"
               ;;; :serial t
               ;;; :components ((:file "filename" :depends-on ("filename")
               ;;; optional=> :depends-on ("somemodule"))
               ;;; etc...
               ;;; But also directly
               ;;;(:file "filename" :depends-on (somefiles))
               ))
