
(defpackage :with-struct-demo
  (:use :cl :with-struct)
  (:import-from :with-struct :with-struct))

(in-package :with-struct-demo)

;; here is our innocent struct
(defstruct game-entity
  (xpos 0)
  (ypos 0)
  (xinc 0)
  (yinc 0))

;; and here is the magic
(defun move (player)
  (with-struct game-entity player ((px xpos) (py ypos) xinc yinc)
    (incf px xinc)
    (incf py yinc)))


;; where as you'd have to type something like this before

(defun old-move (player)
  (incf (game-entity-xpos player) (game-entity-xinc player))
  (incf (game-entity-ypos player) (game-entity-yinc player)))
