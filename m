Return-Path: <stable+bounces-163301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C7EB09601
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 22:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0845639F7
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D3422541B;
	Thu, 17 Jul 2025 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="OADzX3KD"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200D1A314E
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785612; cv=none; b=uTGao75vDdbreidizGbJego7EoCn80c4GrDMFppe/H4hRWPxl/xRTkI0BUuUyfYJEX4l/Pue0eOMfoJ+s5X3rqPRZZ7rK9NAd6DjkOKckysmbTwXyRxNmFRfAkF2vX6d0cP0+PFjVIfe+0AnXLjcnqr2aeMXFcz40qMs2V/JugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785612; c=relaxed/simple;
	bh=fcjwLTD5M3od7D+hAZId0CFGHQ+qQPRBQOIkJ3+rsBI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ujmKe+hMhbX7sGW3A5eHsn16rxjFoYoZ//omL1eg/BOmEVdscfux3NqlihgipoXtH6PbMHg2Kqzt5AonFlkb2KRIfv4P8A9ZP/VyCZ75Q516oSgBF1dsGCw8YwRv8ow5gAPXj/i5M3nvyaWP5XNZ7Xa3Dp6iUBSlbEKaV+NASo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=OADzX3KD; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ebb468cbb4so1253220fac.2
        for <stable@vger.kernel.org>; Thu, 17 Jul 2025 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1752785609; x=1753390409; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVDvsUNc3IKbn2oJR3yzSTzpvC+r0BsaB5DVXqgOXBY=;
        b=OADzX3KDGs/nvgxphcDq11qWVRLd2IK3fJwlppmoQx/SpA/tnjVVXyAw2d6KA/ojLK
         h8Xe8bkslFfL+KTidUo8wTaUl7ZXZppvId5MyOd+aMptt7NIri1g6XaNhFiZ48zoGlNb
         C0THJeC/AL3xC83IxlSb1KFXtDopS6T5RMX0ToUKeSrvPZpd33bYZlcJ9MHCf5bgUUsF
         rsTFM0CbAe+K5W9Ci0G7OKXH/vo+m18kR2YNl+DVV6/tmzRIlUk8pyoNrRi7DllhdL7M
         mb/4mtuKXsCb3SlhTWFbt/1IaKzkHJY7zQ49TMEJUBpuPskFsw5j1dGhiuPBy7GO4Lee
         /WFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752785609; x=1753390409;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bVDvsUNc3IKbn2oJR3yzSTzpvC+r0BsaB5DVXqgOXBY=;
        b=EW5ZBtaSHu1tBsuyXdIeXuRyEfp/9acVBEqnWGvqijkkVUSTQNe7d0ljFMa4vYWF7B
         SHNrGeHfHMSDk/dhPBseUkZSzXyyfOFI/cglZztfY7ZPe2gpvKlAyYOjya8j2Zzy33G7
         eh4oaY1HYeFjzhL3alw8ROQTToH7Ip9kuOTX8nud4hmIBLURIAloZSRdK5lMG23T1Pkx
         BI4iYOOyJCWjpSegNOr6+lnDzrh7zoxcDQAoQO93ZfF/FDWxwCLkxepU+hnoBRIG+Knw
         aw0FTHBoPtc8RkU87Xj4cIs3z27UJ41EvoCyXjUxXptnrXbhcc4lNtpe4arYoRVPdWbF
         R/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQUzXh5e5uni2W77MaUDZcc2qKNdeBWh0tvJJJqz/Vrvm/oH5zmJ69bZ6PG7/LDW9wV3m4MbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7iePgrZ2zzY5I7tVvEd6bWqlIW6y0mY6nWFYsPHiXYhbNaGKc
	7LAu2ut78pQrrN35OFnCOSCZA0TQf/Nf9eLMuTsFPw7KThJjIaO2SJnruChLjZU/Ix0=
X-Gm-Gg: ASbGnctkLVnaiaLldRFvAopyG0ODR2T5xXXmIJPKdaWfFnjrDpNAib9VQhvzm6sU1+G
	pHigCLehRXUJkyxzGPiUAJOj3QTFUURQT9/51PIdx8uBtmPqPbQAe6+lM0TqgxKnzh5qu998yJZ
	OXkEVSoiBug57wvG323RioaJyoS+4N6eV9LFMfRDBb+t6BRvoCHImnZarUW0Z+9zZssafoVG/Kc
	lFHpDSy1xdHFiIx3POquSxz6BVmbwPp+9LQ+IAneRdGoFkTXT2H2pM8eG21rEhjEvAwcBthiQ8J
	DnKLctmo6yubHazbdHsJMGed7qQkh4GL6+grdZFUF0ELiPpFKVkK3h5dTXnKfKCpIvP124o5QkO
	1HXLO1/G63fDX1FD5wo75Hur9
X-Google-Smtp-Source: AGHT+IGtPFW1FnVtKqSZFc9EifMHvEjQF5yd6GND4EmieSU0EC07VcE3PtkMpIuNxTIcGKpnexxpvw==
X-Received: by 2002:a05:6871:4b12:b0:2e9:fd62:9061 with SMTP id 586e51a60fabf-2ffb24a5203mr6760406fac.32.1752785608573;
        Thu, 17 Jul 2025 13:53:28 -0700 (PDT)
Received: from poutine ([2804:1b3:a701:6ff9:81e1:aa01:e63a:53e3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83b52b1esm74180a34.44.2025.07.17.13.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:53:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [TEST REGRESSION] stable-rc/linux-6.12.y:
 kselftest.breakpoints.breakpoints_step_after_suspend_test on
 stm32mp157a-dhcor-avenger96
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Jul 2025 20:53:26 -0000
Message-ID: <175278560529.3533138.9991813707938719759@poutine>




Hello,

New test failure found on stable-rc/linux-6.12.y:

kselftest.breakpoints.breakpoints_step_after_suspend_test running on stm32mp157a-dhcor-avenger96

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
branch: linux-6.12.y
commit HEAD: d50d16f002928cde05a54e0049ddc203323ae7ac


test id: maestro:687945d32ce2c1874ed4d342
status: FAIL
start time: 
log: https://files.kernelci.org/kselftest-breakpoints-6876a2d634612746bbcec7ff/log.txt.gz

# Test details:
- test path: kselftest.breakpoints.breakpoints_step_after_suspend_test
- platform: stm32mp157a-dhcor-avenger96
- compatibles: arrow,stm32mp157a-avenger96 | dh,stm32mp157a-dhcor-som | st,stm32mp157
- config: multi_v7_defconfig
- architecture: arm
- compiler: gcc-12

Dashboard: https://d.kernelci.org/t/maestro:687945d32ce2c1874ed4d342


Log excerpt:
=====================================================
of an unmet condition check (ConditionPathExists=/sys/kernel/mm/hugepages).
[   28.116033] systemd[1]: dev-mqueue.mount - POSIX Message Queue File System was skipped because of an unmet condition check (ConditionPathExists=/proc/sys/fs/mqueue).
[   28.180697] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
Mounting [0;1;39msys-kernel-debug.…[0m - Kernel Debug File System...
[   28.217714] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
Mounting [0;1;39msys-kernel-tracin…[0m - Kernel Trace File System...
[   28.291406] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
Starting [0;1;39mkmod-static-nodes…ate List of Static Device Nodes...
[   28.331680] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
Starting [0;1;39mmodprobe@configfs…m - Load Kernel Module configfs...
[   28.371165] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
Starting [0;1;39mmodprobe@dm_mod.s…[0m - Load Kernel Module dm_mod...
[   28.408054] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
Starting [0;1;39mmodprobe@drm.service[0m - Load Kernel Module drm...
[   28.449915] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
Starting [0;1;39mmodprobe@efi_psto…- Load Kernel Module efi_pstore...
[   28.487986] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
Starting [0;1;39mmodprobe@fuse.ser…e[0m - Load Kernel Module fuse...
[   28.532255] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
Starting [0;1;39mmodprobe@loop.ser…e[0m - Load Kernel Module loop...
[   28.563256] systemd[1]: systemd-journald.service: unit configures an IP firewall, but the local system does not support BPF/cgroup firewalling.
[   28.574983] systemd[1]: (This warning is only shown for the first unit using IP firewalling.)
[   28.588124] systemd[1]: Starting systemd-journald.service - Journal Service...
Starting [0;1;39msystemd-journald.service[0m - Journal Service...
[   28.682143] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
Starting [0;1;39msystemd-modules-l…rvice[0m - Load Kernel Modules...
[   28.726528] systemd[1]: Starting systemd-network-generator.service - Generate network units from Kernel command line...
Starting [0;1;39msystemd-network-g… units from Kernel command line...
[   28.831292] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
Starting [0;1;39msystemd-remount-f…nt Root and Kernel File Systems...
[   28.868196] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
Starting [0;1;39msystemd-udev-trig…[0m - Coldplug All udev Devices...
[   28.925905] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[[0;32m  OK  [0m] Mounted [0;1;39msys-kernel-debug.m…nt[0m - Kernel Debug File System.
[   28.971980] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[[0;32m  OK  [0m] Mounted [0;1;39msys-kernel-tracing…nt[0m - Kernel Trace File System.
[   29.004249] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[[0;32m  OK  [0m] Finished [0;1;39mkmod-static-nodes…reate List of Static Device Nodes.
[   29.106198] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[   29.121680] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[[0;32m  OK  [0m] Finished [0;1;39mmodprobe@configfs…[0m - Load Kernel Module configfs.
[   29.142952] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[   29.160513] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
[[0;32m  OK  [0m] Finished [0;1;39mmodprobe@dm_mod.s…e[0m - Load Kernel Module dm_mod.
[   29.203027] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   29.209669] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
[[0;32m  OK  [0m] Finished [0;1;39mmodprobe@drm.service[0m - Load Kernel Module drm.
[   29.251945] systemd[1]: Started systemd-journald.service - Journal Service.
[[0;32m  OK  [0m] Started [0;1;39msystemd-journald.service[0m - Journal Service.
[[0;32m  OK  [0m] Finished [0;1;39mmodprobe@efi_psto…m - Load Kernel Module efi_pstore.
[[0;32m  OK  [0m] Finished [0;1;39mmodprobe@fuse.service[0m - Load Kernel Module fuse.
[[0;32m  OK  [0m] Finished [0;1;39mmodprobe@loop.service[0m - Load Kernel Module loop.
[[0;32m  OK  [0m] Finished [0;1;39msystemd-modules-l…service[0m - Load Kernel Modules.
[[0;32m  OK  [0m] Finished [0;1;39msystemd-network-g…rk units from Kernel command line.
[[0;32m  OK  [0m] Finished [0;1;39msystemd-remount-f…ount Root and Kernel File Systems.
[[0;32m  OK  [0m] Reached target [0;1;39mnetwork-pre…get[0m - Preparation for Network.
Mounting [0;1;39msys-kernel-config…ernel Configuration File System...
Starting [0;1;39msystemd-journal-f…h Journal to Persistent Storage...
Starting [0;1;39msystemd-random-se…ice[0m - Load/Save Random Seed...
Starting [0;1;39msystemd-sysctl.se…ce[0m - Apply Kernel Variables...
Starting [0;1;39msystemd-sysusers.…rvice[0m - Create System Users...
[[0;32m  OK  [0m] Mounted [0;1;39msys-kernel-config.… Kernel Configuration File System.
[   29.895899] systemd-journald[191]: Received client request to flush runtime journal.
[[0;32m  OK  [0m] Finished [0;1;39msystemd-random-se…rvice[0m - Load/Save Random Seed.
[[0;32m  OK  [0m] Finished [0;1;39msystemd-sysctl.service[0m - Apply Kernel Variables.
[[0;32m  OK  [0m] Finished [0;1;39msystemd-sysusers.service[0m - Create System Users.
Starting [0;1;39msystemd-tmpfiles-…ate Static Device Nodes in /dev...
[[0;32m  OK  [0m] Finished [0;1;39msystemd-journal-f…ush Journal to Persistent Storage.
[[0;32m  OK  [0m] Finished [0;1;39msystemd-tmpfiles-…reate Static Device Nodes in /dev.
[[0;32m  OK  [0m] Reached target [0;1;39mlocal-fs-pr…reparation for Local File Systems.
[[0;32m  OK  [0m] Reached target [0;1;39mlocal-fs.target[0m - Local File Systems.
Starting [0;1;39msystemd-tmpfiles-…te System Files and Directories...
Starting [0;1;39msystemd-udevd.ser…ger for Device Events and Files...
[[0;32m  OK  [0m] Started [0;1;39msystemd-udevd.serv…nager for Device Events and Files.
[[0;32m  OK  [0m] Finished [0;1;39msystemd-tmpfiles-…eate System Files and Directories.
Starting [0;1;39msystemd-networkd.…ice[0m - Network Configuration...
Starting [0;1;39msystemd-timesyncd… - Network Time Synchronization...
Starting [0;1;39msystemd-update-ut…rd System Boot/Shutdown in UTMP...
[[0;32m  OK  [0m] Finished [0;1;39msystemd-update-ut…cord System Boot/Shutdown in UTMP.
[[0;32m  OK  [0m] Finished [0;1;39msystemd-udev-trig…e[0m - Coldplug All udev Devices.
[[0;32m  OK  [0m] Started [0;1;39msystemd-timesyncd.…0m - Network Time Synchronization.
[[0;32m  OK  [0m] Started [0;1;39msystemd-networkd.service[0m - Network Configuration.
[[0;32m  OK  [0m] Found device [0;1;39mdev-ttySTM0.device[0m - /dev/ttySTM0.
[[0;32m  OK  [0m] Reached target [0;1;39mbluetooth.target[0m - Bluetooth Support.
[[0;32m  OK  [0m] Reached target [0;1;39mnetwork.target[0m - Network.
[[0;32m  OK  [0m] Reached target [0;1;39mtime-set.target[0m - System Time Set.
[[0;32m  OK  [0m] Reached target [0;1;39musb-gadget.…m - Hardware activated USB gadget.
[[0;32m  OK  [0m] Listening on [0;1;39msystemd-rfkil…l Switch Status /dev/rfkill Watch.
Starting [0;1;39mmodprobe@dm_mod.s…[0m - Load Kernel Module dm_mod...
Starting [0;1;39mmodprobe@efi_psto…- Load Kernel Module efi_pstore...
Starting [0;1;39mmodprobe@fuse.ser…e[0m - Load Kernel Module fuse...
Starting [0;1;39mmodprobe@loop.ser…e[0m - Load Kernel Module loop...
[[0;32m  OK  [0m] Finished [0;1;39mmodprobe@dm_mod.s…e[0m - Load Kernel Module dm_mod.
[[0;32m  OK  [0m] Finished [0;1;39mmodprobe@efi_psto…m - Load Kernel Module efi_pstore.
[[0;32m  OK  [0m] Finished [0;1;39mmodprobe@fuse.service[0m - Load Kernel Module fuse.
[[0;32m  OK  [0m] Finished [0;1;39mmodprobe@loop.service[0m - Load Kernel Module loop.
[[0;32m  OK  [0m] Reached target [0;1;39msysinit.target[0m - System Initialization.
[[0;32m  OK  [0m] Started [0;1;39mapt-daily.timer[0m - Daily apt download activities.
[[0;32m  OK  [0m] Started [0;1;39mapt-daily-upgrade.… apt upgrade and clean activities.
[[0;32m  OK  [0m] Started [0;1;39mdpkg-db-backup.tim… Daily dpkg database backup timer.
[[0;32m  OK  [0m] Started [0;1;39me2scrub_all.timer…etadata Check for All Filesystems.
[[0;32m  OK  [0m] Started [0;1;39mfstrim.timer[0m - Discard unused blocks once a week.
[[0;32m  OK  [0m] Started [0;1;39msystemd-tmpfiles-c… Cleanup of Temporary Directories.
[[0;32m  OK  [0m] Reached target [0;1;39mtimers.target[0m - Timer Units.
[[0;32m  OK  [0m] Listening on [0;1;39mdbus.socket[…- D-Bus System Message Bus Socket.
[[0;32m  OK  [0m] Reached target [0;1;39msockets.target[0m - Socket Units.
[[0;32m  OK  [0m] Reached target [0;1;39mbasic.target[0m - Basic System.
Starting [0;1;39malsa-restore.serv…- Save/Restore Sound Card State...
Starting [0;1;39mdbus.service[0m - D-Bus System Message Bus...
Starting [0;1;39me2scrub_reap.serv…e ext4 Metadata Check Snapshots...
Starting [0;1;39msystemd-logind.se…ice[0m - User Login Management...
Starting [0;1;39msystemd-rfkill.se…Load/Save RF Kill Switch Status...
Starting [0;1;39msystemd-user-sess…vice[0m - Permit User Sessions...
[[0;32m  OK  [0m] Finished [0;1;39malsa-restore.serv…m - Save/Restore Sound Card State.
[[0;32m  OK  [0m] Reached target [0;1;39msound.target[0m - Sound Card.
[[0;32m  OK  [0m] Started [0;1;39msystemd-rfkill.ser…- Load/Save RF Kill Switch Status.
[[0;32m  OK  [0m] Finished [0;1;39msystemd-user-sess…ervice[0m - Permit User Sessions.
[[0;32m  OK  [0m] Started [0;1;39mgetty@tty1.service[0m - Getty on tty1.
[[0;32m  OK  [0m] Started [0;1;39mserial-getty@ttyST…ice[0m - Serial Getty on ttySTM0.
[[0;32m  OK  [0m] Reached target [0;1;39mgetty.target[0m - Login Prompts.
[[0;32m  OK  [0m] Started [0;1;39mdbus.service[0m - D-Bus System Message Bus.
Starting [0;1;39msystemd-hostnamed.service[0m - Hostname Service...
[[0;32m  OK  [0m] Started [0;1;39msystemd-logind.service[0m - User Login Management.
[[0;32m  OK  [0m] Finished [0;1;39me2scrub_reap.serv…ine ext4 Metadata Check Snapshots.
[[0;32m  OK  [0m] Reached target [0;1;39mmulti-user.target[0m - Multi-User System.
[[0;32m  OK  [0m] Reached target [0;1;39mgraphical.target[0m - Graphical Interface.
Starting [0;1;39msystemd-update-ut… Record Runlevel Change in UTMP...
[[0;32m  OK  [0m] Finished [0;1;39msystemd-update-ut… - Record Runlevel Change in UTMP.
[[0;32m  OK  [0m] Started [0;1;39msystemd-hostnamed.service[0m - Hostname Service.
Debian GNU/Linux 12 debian-bookworm-armhf ttySTM0
debian-bookworm-armhf login: root (automatic login)
Linux debian-bookworm-armhf 6.12.39-rc2 #1 SMP Tue Jul 15 18:39:20 UTC 2025 armv7l
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.
Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
/ #
/ # export NFS_ROOTFS='/var/lib/lava/dispatcher/tmp/1574985/extract-nfsrootfs-w6q8rnvr'
export NFS_ROOTFS='/var/lib/lava/dispatcher/tmp/1574985/extract-nfsrootfs-w6q8rnvr'
/ # export NFS_SERVER_IP='172.16.0.3'
export NFS_SERVER_IP='172.16.0.3'
/ # #
#
/ # export SHELL=/bin/bash
export SHELL=/bin/bash
/ # . /lava-1574985/environment
. /lava-1574985/environment
/ # /lava-1574985/bin/lava-test-runner /lava-1574985/0
/lava-1574985/bin/lava-test-runner /lava-1574985/0
+ export TESTRUN_ID=0_timesync-off
+ TESTRUN_ID=0_timesync-off
+ cd /lava-1574985/0/tests/0_timesync-off
++ cat uuid
+ UUID=1574985_1.6.2.4.1
+ set +x
<LAVA_SIGNAL_STARTRUN 0_timesync-off 1574985_1.6.2.4.1>
+ systemctl stop systemd-timesyncd
+ set +x
<LAVA_SIGNAL_ENDRUN 0_timesync-off 1574985_1.6.2.4.1>
+ export TESTRUN_ID=1_kselftest-breakpoints
+ TESTRUN_ID=1_kselftest-breakpoints
+ cd /lava-1574985/0/tests/1_kselftest-breakpoints
++ cat uuid
+ UUID=1574985_1.6.2.4.5
+ set +x
<LAVA_SIGNAL_STARTRUN 1_kselftest-breakpoints 1574985_1.6.2.4.5>
+ cd ./automated/linux/kselftest/
+ ./kselftest.sh -c breakpoints -T '' -t kselftest_armhf.tar.gz -s True -u https://files.kernelci.org/kbuild-gcc-12-arm-6876975b34612746bbce6ee9/kselftest.tar.gz -L '' -S /dev/null -b '' -g '' -e '' -p /opt/kselftests/mainline/ -n 1 -i 1 -E ''
INFO: install_deps skipped
--2025-07-17 18:49:22--  https://files.kernelci.org/kbuild-gcc-12-arm-6876975b34612746bbce6ee9/kselftest.tar.gz
Resolving files.kernelci.org (files.kernelci.org)... 20.171.243.82
Connecting to files.kernelci.org (files.kernelci.org)|20.171.243.82|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 9351030 (8.9M) [application/gzip]
Saving to: 'kselftest_armhf.tar.gz'
kselftest_armhf.tar   0%[                    ]       0  --.-KB/s               ?kselftest_armhf.tar   1%[                    ] 103.76K   357KB/s               ?kselftest_armhf.tar   4%[                    ] 439.76K   756KB/s               ?kselftest_armhf.tar  12%[=>                  ]   1.13M  1.45MB/s               ?kselftest_armhf.tar  23%[===>                ]   2.13M  2.17MB/s               ?kselftest_armhf.tar  35%[======>             ]   3.13M  2.64MB/s               ?kselftest_armhf.tar  46%[========>           ]   4.13M  2.98MB/s               ?kselftest_armhf.tar  57%[==========>         ]   5.13M  3.24MB/s               ?kselftest_armhf.tar  68%[============>       ]   6.13M  3.43MB/s               ?kselftest_armhf.tar  79%[==============>     ]   7.13M  3.59MB/s               ?kselftest_armhf.tar  90%[=================>  ]   8.06M  3.57MB/s               ?kselftest_armhf.tar 100%[===================>]   8.92M  3.66MB/s    in 2.4s
2025-07-17 18:49:25 (3.66 MB/s) - 'kselftest_armhf.tar.gz' saved [9351030/9351030]
skiplist:
========================================
========================================
breakpoints:step_after_suspend_test
============== Tests to run ===============
breakpoints:step_after_suspend_test
===========End Tests to run ===============
shardfile-breakpoints pass
[   67.220163] kselftest: Running tests in breakpoints
TAP version 13
1..1
# timeout set to 45
# selftests: breakpoints: step_after_suspend_test
[   67.432985] PM: suspend entry (deep)
[   67.449347] Filesystems sync: 0.014 seconds
[   67.458329] Freezing user space processes
[   67.462606] Freezing user space processes completed (elapsed 0.001 seconds)
[   67.468205] OOM killer disabled.
[   67.471493] Freezing remaining freezable tasks
[   67.477234] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   67.483366] printk: Suspending console(s) (use no_console_suspend to debug)
[   67.611609] stm32-dwmac 5800a000.ethernet end0: Link is Down
[   67.624958] Disabling non-boot CPUs ...
[   67.626403] CPU1 killed.
[   67.628604] Enabling non-boot CPUs ...
[   67.630318] CPU1 is up
[   67.638677] stm32-dwmac 5800a000.ethernet end0: configuring for phy/rgmii link mode
[   67.640262] dwmac4: Master AXI performs any burst length
[   67.640314] stm32-dwmac 5800a000.ethernet end0: No Safety Features support found
[   67.640345] stm32-dwmac 5800a000.ethernet end0: Invalid PTP clock rate
[   67.640361] stm32-dwmac 5800a000.ethernet end0: PTP init failed
[   67.642550] stm32-dwmac 5800a000.ethernet end0: Link is Up - 1Gbps/Full - flow control off
[   67.910193] usb 2-1: reset high-speed USB device number 2 using ehci-platform
[   68.257543] OOM killer enabled.
[   68.260709] Restarting tasks ... done.
[   68.267811] random: crng reseeded on system resumption
[   68.281019] PM: suspend exit
# TAP version 13
# Bail out! Failed to enter Suspend state
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: breakpoints: step_after_suspend_test # exit=1
WARNING: Optional imports not found, TAP 13 output will be
ignored. To parse yaml, see requirements in docs:
https://tappy.readthedocs.io/en/latest/consumers.html#tap-version-13
breakpoints_step_after_suspend_test fail
+ ../../utils/send-to-lava.sh ./output/result.txt
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=shardfile-breakpoints RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=breakpoints_step_after_suspend_test RESULT=fail>
+ set +x
<LAVA_SIGNAL_ENDRUN 1_kselftest-breakpoints 1574985_1.6.2.4.5>
<LAVA_TEST_RUNNER EXIT>
/ #

=====================================================


#kernelci test maestro:687945d32ce2c1874ed4d342

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

