;;; Package Management
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

(setq native-comp-async-report-warnings-errors 'silent)

(add-to-list 'default-frame-alist '(font . "Iosevka-12"))

(define-key minibuffer-local-map (kbd "<escape>") #'abort-recursive-edit)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;; General Settings
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq default-tab-width 4)
(recentf-mode 1)

;;; Theme
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

;;; Evil Mode (Vim Keybinds)
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (declare-function evil-collection-magit-add-rebase-messages "evil-collection-magit")
  (declare-function git-rebase-mode-show-keybindings "git-rebase")
  (evil-collection-init)
  (with-eval-after-load 'dired
    (evil-collection-define-key 'normal 'dired-mode-map
      "gg" 'evil-goto-first-line
      "G"  'evil-goto-line)))
;;; Which-Key
(use-package which-key
  :init
  (which-key-mode 1)
  :config
  (setq which-key-idle-delay 0.3))

;;; Leader Key (SPC) via general
(use-package general
  :config
  (general-create-definer my/leader
    :states '(normal visual motion)
    :keymaps 'override
    :prefix "SPC")
  (my/leader
    ;; File / buffer
    "f f" '(find-file :wk "find file")
    "f r" '(recentf-open-files :wk "recent files")
    "b b" '(switch-to-buffer :wk "switch buffer")
    "b k" '(kill-current-buffer :wk "kill buffer")
    ;; Git
    "g g" '(magit-status :wk "magit status")
    ;; LSP / navigation
    "l d" '(xref-find-definitions :wk "jump to definition")
    "l r" '(xref-find-references :wk "find references")
    "l D" '(xref-find-declarations :wk "jump to declaration")
    "l i" '(xref-find-implementations :wk "find implementations")
    "l t" '(xref-go-back :wk "jump back")
    "l T" '(xref-go-forward :wk "jump forward")
    "l a" '(eglot-code-actions :wk "code actions")
    "l q" '(eglot-code-action-quickfix :wk "quickfix")
    "l R" '(eglot-rename :wk "rename symbol")
    "l h" '(eldoc :wk "show documentation")
    "l f" '(eglot-format :wk "format buffer")
    "l s" '(eglot-shutdown-all :wk "shutdown all LSP servers")
    "l e" '(flycheck-list-errors :wk "list errors")
    ;; Diagnostics toggle
    "t d" '(my/toggle-flycheck :wk "toggle diagnostics")))

;;; Autocomplete (Company - Manual Trigger Only)
(use-package company
  :init
  (global-company-mode 1)
  :config
  (setq company-idle-delay nil)
  (setq company-minimum-prefix-length 1)
  (global-set-key (kbd "M-/") #'company-complete))

;;; LSP & Inline Diagnostics
(use-package flycheck
  :init
  (global-flycheck-mode 1)
  :config
  (global-flycheck-annotate-mode 1)
  (global-flycheck-eglot-mode 1))

(defun my/toggle-flycheck ()
  "Globally toggle Flycheck diagnostics display."
  (interactive)
  (if global-flycheck-mode
      (global-flycheck-mode -1)
    (global-flycheck-mode 1)))

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs
               '(csharp-mode . ("csharp-ls")))
  :hook
  (rust-mode . eglot-ensure)
  (csharp-mode . eglot-ensure)
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure))

;;; Magit
(use-package magit
  :bind ("C-x g" . magit-status))

;;; Language Support
(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode . eglot-ensure)
  :config
  (setq rust-format-on-save t))

(use-package csharp-mode
  :mode "\\.cs\\'")

(use-package cc-mode
  :ensure nil
  :mode (("\\.c\\'" . c-mode)
         ("\\.h\\'" . c-mode)
         ("\\.cpp\\'" . c++-mode)
         ("\\.hpp\\'" . c++-mode)))

;;; Provide
(provide 'init)
;;; init.el ends here
