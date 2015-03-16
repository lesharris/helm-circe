;;; helm-circe.el --- helm circe buffer management. -*- lexical-binding: t -*-

;; Copyright (C) 2015 Les Harris <les@lesharris.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Author: Les Harris <les@lesharris.com>
;; URL: https://github.com/lesharris/helm-circe
;; Version: 0.1
;; Package-Requires: ((emacs "24") (helm "0.0") (circe "0.0") (cl-lib "0.5"))
;; Keywords: helm circe

;;; Commentary:

;; Jump to Circe buffers easily with Helm

;; A call to `helm-circe` will show a list of circe channel and server
;; buffers allowing you to switch channels easily as well as remove
;; circe buffers.

;; Largely based on helm-mt by Didier Deshommes
;; https://github.com/dfdeshom/helm-mt


;;; Code:
(require 'cl-lib)
(require 'helm)
(require 'circe)

(defvar helm-marked-buffer-name)

(defun helm-circe/circe-channel-buffers ()
  "Filter for circe channel buffers"
  (cl-loop for buf in (buffer-list)
           if (eq 'circe-channel-mode (buffer-local-value 'major-mode buf))
           collect (buffer-name buf)))

(defun helm-circe/circe-server-buffers ()
  "Filter for circe server buffers"
  (cl-loop for buf in (buffer-list)
           if (eq 'circe-server-mode (buffer-local-value 'major-mode buf))
           collect (buffer-name buf)))

(defun helm-circe/circe-query-buffers ()
  "Filter for circe query buffers"
  (cl-loop for buf in (buffer-list)
           if (eq 'circe-query-mode (buffer-local-value 'major-mode buf))
           collect (buffer-name buf)))

(defun helm-circe/close-marked-buffers (ignored)
  "Delete marked circe buffers. The IGNORED argument is not used."
  (let* ((buffers (helm-marked-candidates :with-wildcard t))
         (len (length buffers)))
    (with-helm-display-marked-candidates
      helm-marked-buffer-name
      (cl-dolist (b buffers)
        (kill-buffer b))
      (message "%s circe buffers closed" len))))

(defvar helm-circe/circe-channel-buffer-source
  '((name . "Channels")
    (candidates . (lambda ()
                    (or (helm-circe/circe-channel-buffers)
                        (list ""))))
    (action . (("Switch to channel" . (lambda (candidate)
                                        (switch-to-buffer candidate)))
               ("Part from channel" . (lambda (candidate)
                                        (kill-buffer candidate)))
               ("Close marked items" 'helm-circe/close-marked-buffers)))))

(defvar helm-circe/circe-query-buffer-source
  '((name . "Queries")
    (candidates . (lambda ()
                    (or (helm-circe/circe-query-buffers)
                        (list ""))))
    (action . (("Switch to query" . (lambda (candidate)
                                      (switch-to-buffer candidate)))
               ("Close query" . (lambda (candidate)
                                  (kill-buffer candidate)))
               ("Close marked items" 'helm-circe/close-marked-buffers)))))

(defvar helm-circe/circe-server-buffer-source
  '((name . "Servers")
    (candidates . (lambda ()
                    (or (helm-circe/circe-server-buffers)
                        (list ""))))
    (action . (("Switch to server buffer" . (lambda (candidate)
                                              (switch-to-buffer candidate)))
               ("Disconnect from Server" . (lambda (candidate)
                                             (kill-buffer candidate)))
               ("Close marked items" 'helm-circe/close-marked-buffers)))))

;;;###autoload
(defun helm-circe ()
  "Custom helm buffer for circe channel and server buffers only."
  (interactive)
  (let ((sources
         '(helm-circe/circe-channel-buffer-source
           helm-circe/circe-query-buffer-source
           helm-circe/circe-server-buffer-source)))
    (helm :sources sources
          :buffer "*helm-circe*")))

(provide 'helm-circe)

;;; helm-circe.el ends here
