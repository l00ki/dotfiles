;;; init.el --- My Emacs configuration
;;; Commentary:

;;; Code:

;; globals
(setq user-full-name    "Lukas Schreder"
      user-mail-address "lukas@schreder.xyz")

;; package management
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; custom scripts
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; backups
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq auto-save-default nil)
(setq backup-by-copying t)
(setq create-lockfiles nil)

;; tabs
(progn (setq-default indent-tabs-mode nil))
(setq-default tab-width 4)

(setq line-move-visual t)

(setq inhibit-startup-screen 0)

(setq frame-title-format nil)

(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "$HOME/.local/bin")

;; default modes
(electric-pair-mode 1)
(show-paren-mode 1)
(blink-cursor-mode 0)
(toggle-scroll-bar 0)
(tool-bar-mode -1)
(column-number-mode 1)
(global-auto-revert-mode 1)
(setq revert-without-query '(".pdf"))
(save-place-mode 1)
(savehist-mode 1)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

(setq sentence-end-double-space nil)

;; ricing
(when (member "Consolas" (font-family-list)) (set-frame-font "Consolas-14" t t)) ; Windows
(when (member "Monaco" (font-family-list)) (set-frame-font "Monaco-14" t t)) ; macOS
(when (member "B612" (font-family-list)) (set-frame-font "B612 Mono-13" t t)) ; custom

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; org-mode
(require 'org)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (python . t)
   (latex . t)))
(setq org-confirm-babel-evaluate nil)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c l") #'org-store-link)
(setq org-hide-emphasis-markers t)
(let* ((variable-tuple
        (cond ((x-list-fonts "B612")         '(:font "B612"))
              ((x-family-fonts "Sans Serif") '(:family "Sans Serif"))
              (nil (warn "no Sans Serif font found."))))
       (base-font-color  (face-foreground 'default nil 'default))
       (headline        `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces
   'user
   '(fixed-pitch ((t (:family "B612 Mono"))))
   '(variable-pitch ((t (:family "B612"))))
   '(org-level-8 ((t (,@headline ,@variable-tuple))))
   '(org-level-7 ((t (,@headline ,@variable-tuple))))
   '(org-level-6 ((t (,@headline ,@variable-tuple))))
   '(org-level-5 ((t (,@headline ,@variable-tuple))))
   '(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
   '(org-level-3 ((t (,@headline ,@variable-tuple :height 1.2))))
   '(org-level-2 ((t (,@headline ,@variable-tuple :height 1.3))))
   '(org-level-1 ((t (,@headline ,@variable-tuple :height 1.4))))
   '(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))

(setq org-capture-templates
      '(
        ("a" "Agenda"
         entry (file+olp+datetree "~/Desktop/org/agenda.org")
         "* %?\n:Created: %U"
         :empty-lines-before 1)
        ("j" "Journal"
         entry (file+olp+datetree "~/Desktop/org/journal.org")
         "* %?"
         :empty-lines-before 1)
        ("n" "Note"
         entry (file+olp+datetree "~/Desktop/org/notes.org")
         "* %?\n:Created: %U\n"
         :empty-lines-before 1)
        ("t" "To Do"
         entry (file+olp+datetree "~/Desktop/org/todo.org")
         "* TODO %?\n:Created: %U DEADLINE: \nSCHEDULED: "
         :empty-lines-before 1)
        ))

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "PROG(p)" "INTR(i)" "WONTDO(w)" "DONE(d)")))

(setq org-agenda-files '("~/Desktop/org/agenda.org"
                         "~/Desktop/org/todo.org"))

(setq calendar-week-start-day 1)

;; custom Latex classes for org-mode
(require 'ox-latex)
(add-to-list 'org-latex-classes
             '("memoir" "\\documentclass{memoir}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))
(add-to-list 'org-latex-classes
             '("revtex" "\\documentclass{revtex4-2}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))
(add-to-list 'org-latex-classes
             '("achemso" "\\documentclass{achemso}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))
(add-to-list 'org-latex-classes
             '("letter" "\\documentclass{letter}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))

;; macOS fix for tramp
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;; text completion
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; vim emulation
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

;; syntax checking
(use-package flycheck
  :ensure t
  :init
  (setq evil-want-C-i-jump nil)
  :config
  (global-flycheck-mode 1))

(use-package flyspell
  :ensure t
  :defer t
  :init
  (progn
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    (add-hook 'text-mode-hook 'flyspell-mode)))

;; frame controls
(use-package frame
  :defer
  :config
  (set-frame-parameter nil 'internal-border-width 0))

;; GPT
(use-package gptel
  :ensure t
  ;(setq gpt-openai-engine "gpt-3.5-turbo")
  ;(global-set-key (kbd "M-C-g") 'gpt-dwim))

;; Gruvbox color scheme
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

;; incremental completions
(use-package helm
  :ensure t
  :defer 2
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (global-set-key (kbd "C-x b") #'helm-mini)
  (helm-mode 1))

;; hide the modeline where it's annoying
(use-package hide-mode-line
  :ensure t
  :config
  (add-hook 'eshell-mode-hook #'hide-mode-line-mode))

(use-package hydra
  :ensure t)

;; Eglot
(use-package eglot
  :ensure t)

(use-package lsp-ui
  :ensure t)

;; Magit
(use-package magit
  :ensure t)

;; minor mode menu
(use-package minions
  :ensure t
  :config
  (minions-mode 1))

;; mix variable and fixed pitch in the same buffer
(use-package mixed-pitch
  :ensure t
  :config
  (add-hook 'text-mode-hook #'mixed-pitch-mode))

;; Nyan cat progress bar
(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode 1))

(use-package org-ref
  :ensure t
  :init
  (setq bibtex-completion-bibliography '("~/Desktop/My Library.bib"))
  (define-key org-mode-map (kbd "C-c [") 'org-ref-insert-ref-link)
  (define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link))

(use-package rust-mode
  :ensure t)

;; cp2k
(require 'cp2k-mode nil 'noerror)
(add-to-list 'auto-mode-alist '("\\.inp\\'" . cp2k-mode))
(add-to-list 'auto-mode-alist '("\\.F\\'" . f90-mode))
(add-to-list 'auto-mode-alist '("\\.com\\'" . fundamental-mode))

;; start the emacs server
(server-force-delete)
(server-start)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-babel-python-command "python3")
 '(package-selected-packages
   '(rust-mode magit org-ref org-bullets nyan-mode mixed-pitch minions lsp-ui hide-mode-line helm gruvbox-theme gptel gpt flycheck evil company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "B612 Mono"))))
 '(org-document-title ((t ((\,@ headline) (\,@ variable-tuple) :height 1.5 :underline nil))))
 '(org-level-1 ((t ((\,@ headline) (\,@ variable-tuple) :height 1.4))))
 '(org-level-2 ((t ((\,@ headline) (\,@ variable-tuple) :height 1.3))))
 '(org-level-3 ((t ((\,@ headline) (\,@ variable-tuple) :height 1.2))))
 '(org-level-4 ((t ((\,@ headline) (\,@ variable-tuple) :height 1.1))))
 '(org-level-5 ((t ((\,@ headline) (\,@ variable-tuple)))))
 '(org-level-6 ((t ((\,@ headline) (\,@ variable-tuple)))))
 '(org-level-7 ((t ((\,@ headline) (\,@ variable-tuple)))))
 '(org-level-8 ((t ((\,@ headline) (\,@ variable-tuple)))))
 '(variable-pitch ((t (:family "B612")))))
