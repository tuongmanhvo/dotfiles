(setq inhibit-startup-message t)
					; 1 <= 2

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
;(set-fringe-mode 0)         ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar

(setq visible-bell t)       ; Set up the visible bell

(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-face-attribute 'default nil :font "Fira Code" :height 100)

;(load-theme 'wombat)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'Keyboard-escape-quit)


;; Initialize package sources
;(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
 (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package vscode-dark-plus-theme
;  :ensure t
  :config
  (load-theme 'vscode-dark-plus t))


(use-package swiper
;  :ensure t
  )

(use-package ivy
;  :ensure t
  :bind (("C-s" . swiper))
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d ")
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
					;  :init
  :config
  (ivy-rich-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :defer 0
;  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-M-<down>" . 'counsel-switch-buffer)
;         :map minibuffer-local-map
;         ("C-r" . 'counsel-minibuffer-history)
	 )
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (setq ivy-initial-inputs-alist nil)
  (counsel-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general)
;; for frequently used prefix keys, the user can create a custom definer with a
;; default :prefix
;; using a variable is not necessary, but it may be useful if you want to
;; experiment with different prefix keys and aren't using `general-create-definer'
(defconst my-leader "C-c")

(general-create-definer my-leader-def
  :prefix my-leader)
  ;; or without a variable
  ;:prefix "C-c")

;; ** Global Keybindings
(my-leader-def
  "t"  '(:ignore t :which-key "theme/text")
  "tt" '(counsel-load-theme :which-key "choose theme")
  "a" 'org-agenda
  "b" 'counsel-bookmark
  "c" 'org-capture)

(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("<down>" text-scale-increase "in")
  ("<up>" text-scale-decrease "out")
  ("<escape>" nil "finished" :exit t))

(my-leader-def
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package projectile
;  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/projects/code")
    (setq projectile-project-search-path '("~/projects/code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands magit-status
  ;:custom
  ;(magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  )

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
;(use-package forge
;  :after magit)

(use-package rg)
(rg-enable-default-bindings)

(use-package avy)
(global-set-key (kbd "C-c C-j") 'avy-resume)
(global-set-key (kbd "C-c C-.") 'avy-goto-char-timer)

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
;  (setq org-log-into-drawer t)

  (setq org-agenda-files
	'("~/Dropbox/org/task.org"))
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(solarized-theme zenburn-theme labburn-theme avy rg magit counsel-projectile projectile hydra general vscdark-theme helpful ivy-rich which-key rainbow-delimiters counsel swiper ivy use-package))
 '(rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face)
 '(rainbow-identifiers-cie-l*a*b*-color-count 1024)
 '(rainbow-identifiers-cie-l*a*b*-lightness 80)
 '(rainbow-identifiers-cie-l*a*b*-saturation 25)
 '(safe-local-variable-values '((projectile-project-run-cmd . "npm start"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
