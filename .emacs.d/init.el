;;; init.el --- My Emacs configuration

;;; Commentary:

;;; Code:
(setq user-full-name "Lukas Schreder"
      user-mail-address "lukas@schreder.xyz")

;; package management
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; backups
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-by-copying t)

;; tabs
(progn
  (setq-default indent-tabs-mode nil))
(setq-default tab-width 4)

(setq line-move-visual t)

(setq inhibit-startup-screen 1)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "$HOME/.local/bin")

;; some modes
(electric-pair-mode 1)
(show-paren-mode 1)
(if (version<= "26.0.50" emacs-version)
    (global-display-line-numbers-mode 1)
    (global-linum-mode 1))
(global-visual-line-mode 1)
(blink-cursor-mode 0)
(menu-bar-mode 0)
(toggle-scroll-bar 0)
(tool-bar-mode -1)
(column-number-mode 1)
(size-indication-mode 1)

;; ricing
(when (member "Menlo" (font-family-list)) (set-frame-font "Menlo-14" t t))
(when (member "Fira Code" (font-family-list)) (set-frame-font "Fira Code-14" t t))

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(use-package magit
  :ensure t)

(use-package intero
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))

(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

(use-package diminish
  :ensure t)

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))

(use-package company
  :ensure t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook #'global-company-mode))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package helm
  :ensure t
  :defer 2
  :bind
  ("M-x" . helm-M-x)
  ; ("C-x C-f" . helm-find-files)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  :config
  (require 'helm-config)
  (helm-mode 1))

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(require 'cp2k-mode nil 'noerror)
(add-to-list 'auto-mode-alist '("\\.inp\\'" . cp2k-mode))
(add-to-list 'auto-mode-alist '("\\.F\\'" . f90-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil dockerfile-mode diff-hl magit helm auctex intero flycheck company gruvbox-theme smartparens diminish use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
