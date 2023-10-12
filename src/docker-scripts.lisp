;;;(in-package :docker-scripts-system)
;;; What we want is to be able to interactively
;;; list docker images, remove them, run them
;;; list docker containers, start them, kill them, remove them
(ql:quickload 'trivial-raw-io)
(require 'trivial-raw-io)

(defvar *wdyw* "What do you want to do ?")
(defvar *dk* "docker")
(defvar *cmds*
  '("build" ;;; 0
    "image ls" ;;; 1
    "image rm" ;;; ...
    "run"
    "ps -a"
    "ps" "start"
    "kill"
    "container rm"))

(defclass state ()
  ((mode
    :initform '0-mode 
    :accessor mode)
   (targets
    :initform '()
    :accessor trgs)
   (target
    :initform nil
    :accessor trg)
   (flags
    :initform '()
    :accessor flgs)))

(defmethod call-mode ((s state) i)
  (funcall (mode s) i))

(defun make-state ()
  (make-instance 'state))

(defun printf (str)
  (format t "~A~%" str)
  (force-output))

(defun s=s (s1 s2)
    (string= s1 s2))
(defun s+s (&rest s)
  (apply #'concatenate 'string s))
(defun S<s (s)
  (read-from-string s))

(defun fn<< (n &optional a)
  (S<s (s+s n (or a ""))))

(defmacro def-ls (name)
  `(defun ,(fn<< name "-list") (&optional a)
     (let ((cmd (s+s "docker " ,name " ls " (or a ""))))
      (sb-ext:run-program "/bin/bash"
                          (list "-c" cmd)
                          :output t)
    ;;;(printf cmd)
    (force-output)
       )))


(defmacro def-mode (name comp)
  `(defun ,(fn<< name "-mode") (i)
     (cond
       ,@(mapcar (lambda (c)
                   `((s=s i ,(car c)) ,@(cdr c))) comp))))

(def-ls "image")
(def-ls "container")
(def-mode "0" (("q" (exit))
               ("i" (image-list))
               ("c" (container-list))
               ("a" (container-list "-a"))))
(def-mode "image" (("q" (exit))
                   ("i" (image-list))
                   ("c" (container-list))
                   ("a" (container-list "-a"))))

(defun main ()
  (let ((st (make-state)))
    (loop
      (printf *wdyw*)
      (let ((input (trivial-raw-io:read-char
                    )))
        (call-mode st input)))))


(main)

