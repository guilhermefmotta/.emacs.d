

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


; Fetch the list of packages available 
(unless package-archive-contents (package-refresh-contents))

; Install use-package
(setq package-list '(use-package))
(dolist (package package-list)
(unless (package-installed-p package) (package-install package)))

;;packages
(use-package multi-vterm :ensure t)

(use-package vterm
  :ensure t
  :bind (("C-c t" . vterm)))



(use-package which-key
  :ensure t)

(setq ring-bell-function 'ignore)
(setq search-whitespace-regexp ".*")  ; Automatically use regex for whitespace

(use-package helm
  :ensure t
  :config
  (helm-mode 1))


;; Helm-ag setup
(use-package helm-ag
  :ensure t
  :bind (("C-c g" . helm-ag)))


;; Set language environment to UTF-8
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(menu-bar-mode -1)

;; Longer whitespace, otherwise syntax highlighting is limited to default column
(setq whitespace-line-column 1000) 

;; Enable soft-wrap
(global-visual-line-mode 1)

;; Maintain a list of recent files opened
(recentf-mode 1)            
(setq recentf-max-saved-items 50)

;; Automatically add ending brackets and braces
(electric-pair-mode 1)

;; Make sure tab-width is 4 and not 8
(setq-default tab-width 4)

;; Highlight matching brackets and braces
(show-paren-mode 1) 

(defun start-programming-message ()
  "Prints 'LET'S START PROGRAMMING' in the echo area."
  (interactive)
  (message "LET'S START PROGRAMMING"))


;; Use the system clipboard in Emacs (for terminal Emacs)
(setq select-enable-clipboard t)
(setq select-enable-primary t)


(setq select-enable-clipboard t)
(setq select-enable-primary t)
(setq save-interprogram-paste-before-kill t)


;; Copy last kill to clipboard using xsel
(defun copy-last-kill-to-clipboard ()
  "Copy last kill-ring entry to system clipboard using xsel."
  (interactive)
  (let ((text (current-kill 0)))
    (when text
      (with-temp-buffer
        (insert text)
        (call-process-region (point-min) (point-max) "xsel" nil nil nil "-i" "-b"))
      (message "Copied to system clipboard."))))

;; Paste from clipboard using xsel
(defun paste-from-clipboard ()
  "Paste from system clipboard using xsel."
  (interactive)
  (insert (shell-command-to-string "xsel -o -b")))

;; Keybindings
(global-set-key (kbd "C-c y") 'copy-last-kill-to-clipboard)
(global-set-key (kbd "C-c p") 'paste-from-clipboard)

(defun copy-last-kill-to-clipboard ()
  "Copy latest kill-ring entry to system clipboard using xsel."
  (interactive)
  (let ((text (current-kill 0)))
    (when (and text (not (string-empty-p text)))
      (with-temp-buffer
        (insert text)
        (call-process-region (point-min) (point-max) "xsel" nil nil nil "-i" "-b")))))

(defun vterm-copy-mode-done+clipboard (&optional arg)
  "Exit `vterm-copy-mode` and copy selection to clipboard using xsel."
  (interactive "P")
  (vterm-copy-mode-done arg)
  (copy-last-kill-to-clipboard))

(with-eval-after-load 'vterm
  (define-key vterm-copy-mode-map (kbd "RET") #'vterm-copy-mode-done+clipboard))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(osc52 helm-ag helm which-key evil-collection evil vterm multi-vterm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
