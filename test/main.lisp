(in-package #:lispkit-test)


(plan 8)

(let* ((jumps (make-hash-table :test #'equal))
       (prefix "g")
       (url    "http://google.com/search?=~a"))
  (defjump jumps prefix url)
  (ok (equal 1 (hash-table-count jumps)))
  (ok (equal url (lookup-jump prefix jumps))))

(let ((browser (make-browser (make-ui-builder) (make-webview))))
  (ok (equal (type-of browser) 'lispkit::browser)))

(let ((top-map (make-keymap))
      (second-map (make-keymap))
      (third-map (make-keymap)))
  (define-key top-map "C-x" second-map)
  (define-key second-map "C-x" third-map)
  (let ((browser (make-browser (make-ui-builder) (make-webview) (list top-map))))
    (handle-key browser "C-x")
    (ok (equal (keymaps browser) (list second-map)))
    (handle-key browser "C-x")
    (ok (equal (keymaps browser) (list third-map)))
    (handle-key browser "oops")
    (ok (equal (keymaps browser) (list top-map)))))

(defparameter pressed? nil)
(defcommand foobar (_)
  "Sets pressed? to t so we can ensure that this function was activated."
  (declare (ignore _))
  (setf pressed? t))

(let* ((top-map (make-keymap))
       (browser (make-browser (make-ui-builder) (make-webview) (list top-map))))
  (is pressed? nil)
  (define-key top-map "C-x" "foobar")
  (handle-key browser "C-x")
  (ok pressed?))

(finalize)
