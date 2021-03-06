;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Source our local config, if available
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if (file-exists-p "~/.emacs.local")
    (load "~/.emacs.local"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; We want packages
;; Give us packages
;; Yes! to packages
;; Hooray 4packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list
  'package-archives
  '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("a800120841da457aa2f86b98fb9fd8df8ba682cebde033d7dbf8077c1b7d677a" default)))
 '(fill-column 80)
 '(global-auto-revert-mode t)
 '(global-linum-mode t)
 '(global-whitespace-mode t)
 '(haskell-interactive-popup-errors nil)
 '(help-window-select t)
 '(ido-mode (quote both) nil (ido))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(package-selected-packages
   (quote
    (fill-column-indicator powerline-evil monokai-theme exec-path-from-shell magit haskell-mode evil-leader evil)))
 '(whitespace-style (quote (face trailing tabs lines-tail empty)))
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-line ((t (:background "red" :foreground "yellow")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Paul's configuration section!!!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use evil-leader
(global-evil-leader-mode)

;; Set our leader key to Spacebar
(evil-leader/set-leader "<SPC>")

;; Enable evil-mode (MUHAHAHAHAA)
(evil-mode 1)

;; Fancy evil-mode bindings
(eval-after-load "evil"
  '(progn

     ;; Easy window movement
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

     ;; Make C-u scroll up half a page, like in vim
     (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

     ;; Open emacs help with <leader> h
     (evil-leader/set-key "h" 'help-command)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Haskell stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Be interactive and indent well when we use haskell
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;; Use C-c C-b for switching back and forth between REPL and editor in Haskell
(add-hook 'haskell-interactive-mode-hook (lambda () (local-set-key (kbd "C-c C-b") #'haskell-interactive-switch-back)))

;; Don't use vim bindings when in a Haskell REPL or error dialogue
(add-to-list 'evil-emacs-state-modes 'haskell-interactive-mode)
(add-to-list 'evil-emacs-state-modes 'haskell-error-mode)
(add-to-list 'evil-emacs-state-modes 'term-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make '_' and '-' part of words in python
(add-hook 'python-mode-hook (lambda () (modify-syntax-entry ?_ "w")
                              (modify-syntax-entry ?- "w")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Aesthetics
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set font on Mac OS X
(if (string= "darwin" system-type)
    ((set-face-attribute 'default nil :font "Menlo-14" )
     (set-frame-font "Menlo-14" nil t)))

;; Use powerline; show modecolors
(powerline-evil-vim-color-theme)

;; Visually indicate where 80 columns is
(add-hook 'after-change-major-mode-hook #'fci-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Stupid hacks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make the emacs built-in shell have all our environment variables
(exec-path-from-shell-initialize)

;; Don't show that cryptic warning from magit
(setq magit-last-seen-setup-instructions "1.4.0")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://unix.stackexchange.com/questions/19874/prevent-unwanted-buffers-from-opening
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)

;; No more typing the whole yes or no. Just y or n will do.
(fset 'yes-or-no-p 'y-or-n-p)
