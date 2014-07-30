;;;; Package Management ;;;;

(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))


(defvar my-packages '(clojure-mode
		      clojure-test-mode
		      cider
		      paredit
		      evil
		      smart-tab
          multi-web-mode))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


(setq explicit-shell-file-name "/usr/bin/fish")
(setq inhibit-startup-screen t)
(setq-default show-trailing-whitespace t)

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
(define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
(define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line)

;;;; Keyboard Macros ;;;;
(fset 'eval-from-normal-mode
   [?a ?\C-x ?\C-e escape])
(put 'eval-from-normal-mode 'kmacro t)


;;;; Custom Key Bindings ;;;;

(global-set-key (kbd "C-x C-a") 'eval-from-normal-mode)



;;;; FT Specific Hooks ;;;;
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'clojure-mode-hook 'show-paren-mode)
(add-hook 'clojure-mode-hook 'eldoc-mode)
(add-hook 'cider-mode-hook (lambda () (setq cider-repl-tab-command 'cider-repl-indent-and-complete-symbol)
				       (setq cider-popup-stacktraces nil)
				       (setq cider-repl-use-clojure-font-lock t)
				       (setq nrepl-popup-stacktraces nil)
				       (setq nrepl-popup-stacktraces-in-repl t)))

(require 'multi-web-mode)
(setq-default mweb-default-major-mode 'html-mode)
(setq-default mweb-tags
  '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
    (js-mode  "\\(<script>\\|<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>\\)" "</script>")
    (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq-default mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

(add-hook 'java-mode-hook
	  '(lambda ()
	     (setq c-basic-offset 2)
	     (setq indent-tabs-mode nil)))


;;;; C Mode Stuff ;;;;
(require 'cc-mode)

(setq-default c-default-style "k&r"
	      c-basic-offset 4
	      c-tab-always-indent t
	      backward-delete-function nil)

(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;;;; Visual Appearance ;;;;
(tool-bar-mode -1)



;;;; Finally... ;;;;

;; Don't want any garbage cluttering the screen.
(add-hook 'emacs-startup-hook
          (lambda () (delete-other-windows)) t)
