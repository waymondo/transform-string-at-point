### Transform String At Point

 Easily change the string at point between camelcasing, snakecasing, dasherized and more.

Bind `transform-string-at-point` to the keybinding of your preference, for example:

``` emacs-lisp
(global-set-key (kbd "s-;") 'transform-string-at-point)
```

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
