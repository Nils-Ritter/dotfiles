(require 'package)

(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/")
    t)

(package-initialize)

(unless (package-installed-p 'evil)
  (package-refresh-contents)
  (package-install 'evil))

(unless (package-installed-p 'gruber-darker-theme)
  (package-refresh-contents)
  (package-install 'gruber-darker-theme))

(require 'evil)
(evil-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-insert-state-map [escape] 'evil-normal-state)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(load-theme 'gruber-darker)

(set-frame-font "Iosevka 12" nil t)

;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd"
     default))
 '(package-selected-packages '(evil gruber-darker-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
