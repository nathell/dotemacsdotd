(defun gpd-set-touchpad-enabled (enabled)
  (make-process :name "setprop"
                :command `("xinput" "--set-prop" "9" "Device Enabled"
                           ,(if enabled "1" "0"))))

(defvar gpd-touchpad-enabled t)

(defun gpd-toggle-touchpad ()
  (interactive)
  (setf gpd-touchpad-enabled (not gpd-touchpad-enabled))
  (gpd-set-touchpad-enabled gpd-touchpad-enabled))
