;;;; Package Management ;;;;

(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(package-refresh-contents)


(defvar my-packages '(clojure-mode
		      clojure-test-mode
		      cider
		      paredit
		      evil
		      smart-tab))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


(setq explicit-shell-file-name "/usr/bin/fish")

;;;; Clojure Slime Setup ;;;;

(setq byte-compile-warnings '(not nresolved
				  free-vars
				  callargs
				  redefine
				  obsolete
				  noruntime
				  cl-functions
				  interactive-only))
(add-to-list 'load-path "~/.emacs.d/clj-slime")
(require 'slime)
(eval-after-load 'slime '(setq slime-protocol-version 'ignore))
(slime-setup '(slime-repl))

;;;; hehehe ;;;;

(evil-mode)

;; Pulled from http://dnquark.com/blog/2012/02/emacs-evil-ecumenicalism/
(defun evil-undefine ()
  (interactive)
  (let (evil-mode-map-alist)
    (call-interactively (key-binding (this-command-keys)))))

(define-key evil-normal-state-map (kbd "TAB") 'evil-undefine)
(define-key evil-visual-state-map (kbd "TAB") 'indent-region)
(define-key evil-normal-state-map (kbd "q") 'evil-undefine)

;;;; Keyboard Macros ;;;;
(fset 'eval-from-normal-mode
   [?a ?\C-x ?\C-e escape])
(put 'eval-from-normal-mode 'kmacro t)


;;;; Custom Key Bindings ;;;;

(global-set-key (kbd "C-x C-a") 'eval-from-normal-mode)



;;;; FT Specific Hooks ;;;;
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'clojure-mode-hook 'show-paren-mode)
(add-hook 'cider-mode-hook (lambda () ((cider-turn-on-eldoc-mode)
				       (setq cider-repl-tab-command 'cider-repl-indent-and-complete-symbol)
				       (setq cider-popup-stacktraces nil)
				       (setq cider-repl-use-clojure-font-lock t))))


;;;; Visual Appearance ;;;;
(tool-bar-mode -1)
