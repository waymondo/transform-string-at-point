### Transform String At Point

 Easily change the string at point between camelcasing, snakecasing, dasherized and more.

Bind `transform-string-at-point-map` to the keybinding of your preference, for example:

``` emacs-lisp
(global-set-key (kbd "s-;") 'transform-string-at-point-map)
```

Works best with [`which-key`](https://github.com/justbur/emacs-which-key).

Each of the transformation commands can be called interactively as well:

* `transform-string-at-point-lower-camel-case`
* `transform-string-at-point-upper-camel-case`
* `transform-string-at-point-snake-case`
* `transform-string-at-point-dashed-words`
* `transform-string-at-point-downcase`
* `transform-string-at-point-upcase`

To customize where the cursor ends up after transformation, set
`transform-string-at-point-cursor-after-transform` to one of the following:

* `string-end` (default)
* `string-start`
* `next-string`

Example installation with `use-package` and `straight.el`:

``` emacs-lisp
(use-package transform-string-at-point
  :straight
  (:host github :repo "waymondo/transform-string-at-point")
  :custom
  (transform-string-at-point-cursor-after-transform 'next-string)
  :bind-keymap
  ("s-;" . transform-string-at-point-map))
```
