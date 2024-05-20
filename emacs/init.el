(setq use-package-always-demand t)

(use-package envrc
  :hook (emacs-startup . envrc-global-mode))

(use-package general)

(use-package +core
  :no-require t

  :custom
  (auto-save-no-message t)
  (auto-save-visited-interval 3)
  (auto-save-visited-mode t)
  (column-number-mode t)
  (global-auto-revert-mode t)
  (indent-tabs-mode nil)
  (inhibit-startup-echo-area-message t)
  (inhibit-startup-message t)
  (inhibit-startup-screen t)
  (left-fringe-width 16)
  (make-backup-files nil)
  (right-fringe-width 16)
  (ring-bell-function 'ignore)

  :custom-face
  (default ((t (:background "#000000"))))
  (mode-line ((t (:background "#101010"))))

  :general
  (:states '(normal visual)
   "SPC"   nil)
  (:states '(normal visual)
   :prefix "SPC"
   "SPC"   '(execute-extended-command :wk "M-x"))
  (:states 'normal
   "s-j"   'next-buffer
   "s-k"   'previous-buffer
   "s"     'evil-avy-goto-char-timer)
  (:states 'normal
   :prefix "SPC"
   "0"     '(delete-window           :wk "close this window")
   "1"     '(delete-other-windows    :wk "keep this window")
   "Q"     '(save-buffers-kill-emacs :wk "quit")
   "s"     '(project-eshell          :wk "shell"))

  :init
  (recentf-mode 1))

(use-package +help
  :no-require t

  :general
  (:states 'normal
   :prefix "SPC"
   "h"  '(nil              :wk "help")
   "hf" '(helpful-callable :wk "callable")
   "hk" '(helpful-key      :wk "key")
   "hi" '(consult-info     :wk "info")
   "hm" '(consult-man      :wk "man")
   "hv" '(helpful-variable :wk "variable")))

(use-package +vc
  :no-require t

  :general
  (:states 'normal
   :prefix "SPC"
   "v"     '(nil   :wk "vc")
   "vv"    '(magit :wk "magit")))

(use-package centered-cursor-mode
  :init (global-centered-cursor-mode))

(use-package consult
  :general
  (:states 'normal
   :prefix "SPC"
   "b"     '(consult-buffer         :wk "buffer")
   "f"     '(consult-project-buffer :wk "find in project")
   "F"     '(consult-buffer         :wk "find"))

  :init
  (setq +consult-source-project-files
        `(:category file
          :name "Project File"
          :items ,(lambda ()
                    (let ((in (project-files (project-current)))
                          (dir (project-root (project-current)))
                          out)
                      (dolist (f in (reverse out))
                        (setq out (cons (file-relative-name f dir) out)))))))

  (add-to-list 'consult-project-buffer-sources '+consult-source-project-files))

(use-package corfu
  :custom
  (corfu-auto t)

  :init
  (global-corfu-mode 1))

(use-package diff-hl
  :custom
  (diff-hl-show-staged-changes nil)

  :general
  (:states 'normal
   :prefix "SPC"
   "vs"    '(diff-hl-stage-dwim :wk "stage hunk(s)"))

  :init
  (global-diff-hl-mode))

(use-package embark
  :custom
  (embark-indicators '(embark-minimal-indicator embark-highlight-indicator))

  :general
  (:states 'normal 
   ";" 'embark-act))

(use-package embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

  :custom

(use-package evil
  :preface
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)

  :custom
  (evil-shift-width 2)
  (evil-undo-system 'undo-fu)
  (evil-want-minibuffer t)

  :init
  (evil-mode 1))

(use-package evil-collection
  :custom
  (evil-collection-setup-minibuffer t)

  :config
  (evil-collection-init))

(use-package evil-goggles
  :init
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

(use-package evil-indent-plus
  :config
  (evil-indent-plus-default-bindings))

(use-package evil-matchit
  :config
  (evilmi-load-plugin-rules '(ruby-ts-mode) '(simple ruby))

  :hook (evil-mode . global-evil-matchit-mode))

(use-package evil-surround
  :hook (evil-mode . global-evil-surround-mode))

(use-package lsp-mode
  :custom
  (lsp-warn-no-matched-clients nil)

  :hook (prog-mode . lsp-deferred))

(use-package marginalia
  :init (marginalia-mode 1))

(use-package nix-ts-mode
  :mode "\\.nix\\'")

(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

(use-package prog-mode
  :hook
  (prog-mode . electric-pair-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package undo-fu-session
  :init (undo-fu-session-global-mode 1))

(use-package vertico
  :init (vertico-mode 1))

(use-package web-mode
  :custom
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-markup-indent-offset 2)

  :mode "\\.html\\.erb\\'")

(use-package which-key
  :init (which-key-mode 1))
