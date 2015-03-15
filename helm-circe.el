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
;; Version: 0.0
;; Package-Requires: ((emacs "24") (helm "0.0") (circe "0.0") (cl-lib "0.5"))
;; Keywords: helm circe

;;; Commentary:

;; Jump to Circe buffers easily with Helm

;; A call to `helm-circe` will show a list of circe channel and server
;; buffers allowing you to switch easily.

;; Largely based on helm-mt by Didier Deshommes
;; https://github.com/dfdeshom/helm-mt


;;; Code:
(require 'cl-lib)
(require 'helm)
(require 'circe)

(defun helm-circe/irc-buffers ()
  "Filter for buffers that are circe servers and channels"
  (cl-loop for buf in (buffer-list)
		   if (or (eq 'circe-server-mode (buffer-local-value 'major-mode buf))
				  (eq 'circe-channel-mode (buffer-local-value 'major-mode buf)))
		   collect (buffer-name buf)))

(defvar helm-circe/circe-buffer-source
  '((name . "Circe Channels and Servers")
	(candidates . (lambda ()
					(or (helm-circe/irc-buffers)
						(list ""))))
	(action . (("Switch to channel" . (lambda (candidate)
									   (switch-to-buffer candidate)))))))

;;;###autoload
(defun helm-circe ()
  "Custom helm buffer for circe channel and server buffers only."
  (interactive)
  (let ((sources
        '(helm-circe/circe-buffer-source)))
    (helm :sources sources
          :buffer "*helm-circe*")))

(provide 'helm-circe)

;;; helm-circe.el ends here
