#!/bin/bash

chmod -s \
    /usr/bin/su \
    /usr/sbin/unix_chkpwd \
    /usr/libexec/utempter/utempter \
    /usr/bin/mount \
    /usr/bin/umount \
    /usr/sbin/pam_timestamp_check \
    /usr/bin/write \
    /var/lib/tpm2-tss/system/keystore \
    /run/tpm2-tss/eventlog
authselect create-profile hardening -b sssd --symlink-meta --symlink-pam
authselect select custom/hardening -f
authselect enable-feature with-pwhistory
authselect enable-feature with-faillock
echo "* hard maxlogins 10" >> /etc/security/limits.conf
echo "* hard core 0" >> /etc/security/limits.conf
echo "[Coredump]" >> /etc/systemd/coredump.conf
echo "ProcessSizeMax=0" >> /etc/systemd/coredump.conf
echo "Storage=none" >> /etc/systemd/coredump.conf
sed -i "/session.*optional.*pam_lastlog.so/c\session\trequired\tpam_lastlog.so\tshowfailed" /etc/pam.d/postlogin
sed -i "/difok/c\difok = 8" /etc/security/pwquality.conf
sed -i "/minlen/c\minlen = 15" /etc/security/pwquality.conf
sed -i "/dcredit/c\dcredit = -1" /etc/security/pwquality.conf
sed -i "/ucredit/c\ucredit = -1" /etc/security/pwquality.conf
sed -i "/lcredit/c\lcredit = -1" /etc/security/pwquality.conf
sed -i "/ocredit/c\ocredit = -1" /etc/security/pwquality.conf
sed -i "/minclass/c\minclass = 4" /etc/security/pwquality.conf
sed -i "/maxrepeat/c\maxrepeat = 3" /etc/security/pwquality.conf
sed -i "/maxclassrepeat/c\maxclassrepeat = 4" /etc/security/pwquality.conf
sed -i "/gecoscheck/c\gecoscheck = 0" /etc/security/pwquality.conf
sed -i "/dictcheck/c\dictcheck = 1" /etc/security/pwquality.conf
sed -i "/usercheck/c\usercheck = 1" /etc/security/pwquality.conf
sed -i "/enforcing/c\enforcing = 1" /etc/security/pwquality.conf
sed -i "/retry/c\retry = 3" /etc/security/pwquality.conf
sed -i "/enforce_for_root/c\enforce_for_root" /etc/security/pwquality.conf
sed -i "/remember =/c\remember = 5" /etc/security/pwhistory.conf
sed -i "/CtrlAltDelBurstAction/c\CtrlAltDelBurstAction=none" /etc/systemd/system.conf
sed -i "/auth.*required.*pam_wheel.so.*use_uid/c\auth\trequired\tpam_wheel.so\tuse_uid" /etc/pam.d/su
sed -i "/deny =/c\deny = 3" /etc/security/faillock.conf
sed -i "/fail_interval =/c\fail_interval = 900" /etc/security/faillock.conf
sed -i "/unlock_time =/c\unlock_time = 0" /etc/security/faillock.conf
sed -i "/even_deny_root/c\even_deny_root" /etc/security/faillock.conf
sed -i "/dir =/c\dir = /var/log/faillock" /etc/security/faillock.conf