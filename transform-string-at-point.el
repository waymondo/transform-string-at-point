;;; transform-string-at-point.el --- Transforming your strings  -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Justin Talbott

;; Author: Justin Talbott
;; URL: https://github.com/waymondo/transform-string-at-point
;; Version: 0.0.1
;; Package-Requires: ((emacs "24") (s "1.12.0") (which-key "3.5.1"))
;; License: GNU General Public License version 3, or (at your option) any later version
;; Keywords: convenience, tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Easily change the string at point between camelcasing, snakecasing, dasherized and more.

;; Bind `transform-string-at-point-map' to the keybinding of your preference, for example:

;; (global-set-key (kbd "s-;") 'transform-string-at-point-map)

;; Each of the transformation commands can be called interactively as well:

;; * `transform-string-at-point-lower-camel-case'
;; * `transform-string-at-point-upper-camel-case'
;; * `transform-string-at-point-snake-case'
;; * `transform-string-at-point-dashed-words'
;; * `transform-string-at-point-downcase'
;; * `transform-string-at-point-upcase'

;; To customize where the cursor ends up after transformation,
;; set `transform-string-at-point-cursor-after-transform' to one of the following:

;; * `string-end' (default)
;; * `string-start'
;; * `next-string'

;;; Code:

(require 's)
(require 'which-key)

(defgroup transform-string-at-point nil
  "Transforming the string at point customizations"
  :group 'convenience
  :prefix "transform-string-at-point-")

(defcustom transform-string-at-point-cursor-after-transform 'string-end
  "Determines where the cursor should be after a successful transformation"
  :type '(choice
          (const :tag "String End" string-end)
          (const :tag "String Start" string-start)
          (const :tag "Next String" next-string)))

(defun transform-string-at-point--internal (fn)
  "Transform the string at point with `fn'."
  (let ((symbol (thing-at-point 'symbol t))
        (bounds (bounds-of-thing-at-point 'symbol)))
    (delete-region (car bounds) (cdr bounds))
    (insert (funcall fn symbol))
    (cond ((eq transform-string-at-point-cursor-after-transform 'string-start)
           (goto-char (car bounds)))
          ((eq transform-string-at-point-cursor-after-transform 'next-string)
           (forward-thing 'symbol)
           (beginning-of-thing 'symbol)))))

;;;###autoload
(defun transform-string-at-point-lower-camel-case ()
  (interactive)
  (transform-string-at-point--internal #'s-lower-camel-case))

;;;###autoload
(defun transform-string-at-point-upper-camel-case ()
  (interactive)
  (transform-string-at-point--internal #'s-upper-camel-case))

;;;###autoload
(defun transform-string-at-point-snake-case ()
  (interactive)
  (transform-string-at-point--internal #'s-snake-case))

;;;###autoload
(defun transform-string-at-point-dashed-words ()
  (interactive)
  (transform-string-at-point--internal #'s-dashed-words))

;;;###autoload
(defun transform-string-at-point-downcase ()
  (interactive)
  (transform-string-at-point--internal #'s-downcase))

;;;###autoload
(defun transform-string-at-point-upcase ()
  (interactive)
  (transform-string-at-point--internal #'s-upcase))

(defvar transform-string-at-point-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "c") 'transform-string-at-point-lower-camel-case)
    (define-key map (kbd "C") 'transform-string-at-point-upper-camel-case)
    (define-key map (kbd "_") 'transform-string-at-point-snake-case)
    (define-key map (kbd "-") 'transform-string-at-point-dashed-words)
    (define-key map (kbd "d") 'transform-string-at-point-downcase)
    (define-key map (kbd "u") 'transform-string-at-point-upcase)
    map)
  "Keymap for `transform-string-at-point'.")

(fset 'transform-string-at-point-map transform-string-at-point-map)

(which-key-add-keymap-based-replacements transform-string-at-point-map
  "c" '("lower camelcase" . transform-string-at-point-lower-camel-case)
  "C" '("upper camelcase" . transform-string-at-point-upper-camel-case)
  "_" '("snakecase" . transform-string-at-point-snake-case)
  "-" '("dasherize" . transform-string-at-point-dashed-words)
  "d" '("downcase" . transform-string-at-point-downcase)
  "u" '("upcase" . transform-string-at-point-upcase))

(provide 'transform-string-at-point)
;;; transform-string-at-point.el ends here
