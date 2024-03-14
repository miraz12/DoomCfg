;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Anton Christoffersson"
      user-mail-address "anton_christoffersson@hotmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)
(setq doom-font (font-spec :family "Iosevka" :size 16))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Evaluate sym links
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory (file-truename "~/Nextcloud/notes"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Org-roam
(setq org-roam-directory (file-truename "~/Nextcloud/notes/roam"))
;; (org-roam-db-autosync-mode)
(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer)))
(set-email-account!
 "hotmail"
 '((mu4e-sent-folder       . "/[Hotmail]/Sent")
   (mu4e-trash-folder      . "/[Hotmail]/Junk")
   (mu4e-refile-folder      . "/[Hotmail]/Inbox")
   (mu4e-drafts-folder      . "/[Hotmail]/Drafts")
   (smtpmail-smtp-user     . "anton_christoffersson@hotmail.com"))
 t)

;; (setq mu4e-get-mail-command "mbsync -c ~/.config/mu4e/mbsyncrc gmail hotmail"
;;       ;; get emails and index every 5 minutes
;;       mu4e-update-interval 300
;;       ;; send emails with format=flowed
;;       mu4e-compose-format-flowed t
;;       ;; no need to run cleanup after indexing for gmail
;;       mu4e-index-cleanup nil
;;       mu4e-index-lazy-check t
;;       ;; more sensible date format
;;       mu4e-headers-date-format "%d.%m.%y")

;; (defun my-open-calendar ()
;;   (interactive)
;;   (cfw:open-calendar-buffer
;;    :contents-sources
;;    (list
;;     (cfw:org-create-source "Green")  ; org-agenda source
;;     ;; (cfw:cal-create-source "Orange") ; diary source
;;     (cfw:ical-create-source "JessicaAnton" "~/.dotfiles/jessicaanton-2022-10-20.ics" "Purple")  ; ICS source1
;;     (cfw:ical-create-source "Anton" "~/.dotfiles/anton-christoffersson-1-2022-10-20.ics" "Blue")  ; ICS source1
;;     )))

(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))

(setq fancy-splash-image (concat doom-private-dir "splash.png"))


(add-hook 'v-mode-hook #'lsp)
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(v-mode . "v"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "/home/shaggy/Git/vls/bin/vls")
                    :activation-fn (lsp-activate-on "v")
                    :server-id 'v-ls)))

(setq shell-file-name "/run/current-system/sw/bin/bash")
