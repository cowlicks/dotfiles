;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; Set the dir where files are for the org-agenda
(setq org-agenda-files (list "~/org/personal.org"))

;; Make stuff indent in org-mode
(setq org-startup-indented t)
;; Add timestamp when marking done
(setq org-log-done 'time)

;; Install evil mode
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("5dbdb4a71a0e834318ae868143bb4329be492dd04bdf8b398fb103ba1b8c681a" "9271c0ad73ef29af016032376d36e8aed4e89eff17908c0b578c33e54dfa1da1" default)))
 '(package-selected-packages (quote (solarized-theme evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'evil)
(evil-mode 1)

(defvar backup-location (expand-file-name "~/.emacs.d/backups")
  "Base directory for backup files.")

;; Default and per-save backups go here:
;; N.B. backtick and comma allow evaluation of expression
;; when forming list
(setq backup-directory-alist
      `(("" . ,(expand-file-name "per-save" backup-location))))

;; internal links from
;; https://emacs.stackexchange.com/questions/19598/org-mode-link-to-heading-in-other-org-file
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)
