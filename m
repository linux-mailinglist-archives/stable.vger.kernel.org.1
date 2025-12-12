Return-Path: <stable+bounces-200929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1650ECB979C
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 18:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82DFA3015389
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36B2F362C;
	Fri, 12 Dec 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nCJb9HM8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039D2F2618;
	Fri, 12 Dec 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765561816; cv=none; b=i2fWltYj7tGAS3PMO64NOofopWDaSZx5cu8eEBDt/EllehUzh5HZjQMqQc79oInl3KAXA2OuTT8dVmXcGP8A6UZTvDHE4TG16k07nviHqccoKxYDmOPNC6eKy+SeJRg45hEEv8I2RGsCYICcv6uq8FZPbn8m9op/D4q7Yuz2DX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765561816; c=relaxed/simple;
	bh=Y3+oWTQjgBqGs3L/WKv2qi7++QXg184qCTrbaQMlwrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5Q1al4+VoZoEkqDYg6aPvnzNrtWpWKN1oQKwlKUs83YhFsICHFmOsBfsMb5EHNOs1rUAVjQXfGlNDPF/PPt0ATJDm0KKsUOrjWI7br8x0UZItGohEFNEPZnpHx5GSxjmNPRZUdB9yR3bUrr8Nq+6J+XCjswSubDgCp0j9uzrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nCJb9HM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E47C4CEF1;
	Fri, 12 Dec 2025 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765561815;
	bh=Y3+oWTQjgBqGs3L/WKv2qi7++QXg184qCTrbaQMlwrY=;
	h=From:To:Cc:Subject:Date:From;
	b=nCJb9HM8qHyWTL0RIMqELzJIVQBCUDx2jTTJMl+KN0uGp+35w4lKsYmLk8CKPKQk7
	 kLYI+fn6BBSD0ddRohvLJtMEzar6jgh26CGYHdfetowiznIUh9aDIRt8tTjg1zYLnR
	 dXwB87SMOCuGXPsi9TNrfvmAuqPfM0kwIAJCWG8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.62
Date: Fri, 12 Dec 2025 18:50:10 +0100
Message-ID: <2025121211-swear-xerox-6418@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.62 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/process/2.Process.rst            |    6 +-
 Makefile                                       |    2 
 arch/loongarch/kernel/machine_kexec.c          |    2 
 arch/x86/include/asm/kvm_host.h                |    9 +++
 arch/x86/kvm/svm/svm.c                         |   24 ++++----
 arch/x86/kvm/x86.c                             |   21 +++++++
 drivers/bluetooth/btrtl.c                      |   24 ++++----
 drivers/bus/mhi/host/pci_generic.c             |   52 ++++++++++++++++++
 drivers/comedi/comedi_fops.c                   |   42 ++++++++++++--
 drivers/comedi/drivers/c6xdigio.c              |   46 ++++++++++++---
 drivers/comedi/drivers/multiq3.c               |    9 +++
 drivers/comedi/drivers/pcl818.c                |    5 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c           |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c     |   12 +---
 drivers/hid/hid-apple.c                        |    1 
 drivers/hid/hid-elecom.c                       |    6 +-
 drivers/hid/hid-ids.h                          |    3 -
 drivers/hid/hid-input.c                        |    5 +
 drivers/hid/hid-quirks.c                       |    3 -
 drivers/net/wireless/realtek/rtl8xxxu/core.c   |    3 +
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c |    2 
 drivers/nvme/host/core.c                       |    3 -
 drivers/pinctrl/qcom/pinctrl-msm.c             |    2 
 drivers/platform/x86/acer-wmi.c                |    4 +
 drivers/platform/x86/amd/pmc/pmc-quirks.c      |   25 ++++++++
 drivers/platform/x86/huawei-wmi.c              |    4 +
 drivers/spi/spi-imx.c                          |   15 +++--
 drivers/spi/spi-xilinx.c                       |    2 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c |   14 ++--
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  |   13 +++-
 drivers/tty/serial/8250/8250_pci.c             |   37 ++++++++++++
 drivers/usb/serial/belkin_sa.c                 |   28 +++++----
 drivers/usb/serial/ftdi_sio.c                  |   72 ++++++++-----------------
 drivers/usb/serial/kobil_sct.c                 |   18 +++---
 drivers/usb/serial/option.c                    |   22 ++++++-
 fs/bfs/inode.c                                 |   19 ++++++
 fs/ext4/inline.c                               |   14 ++++
 fs/jbd2/transaction.c                          |   19 ++++--
 fs/smb/client/fs_context.c                     |    2 
 fs/smb/server/transport_ipc.c                  |    7 +-
 include/net/xfrm.h                             |   13 +---
 kernel/locking/spinlock_debug.c                |    4 -
 kernel/trace/ftrace.c                          |   40 ++++++++++---
 net/ipv4/ipcomp.c                              |    2 
 net/ipv6/ipcomp6.c                             |    2 
 net/ipv6/xfrm6_tunnel.c                        |    2 
 net/key/af_key.c                               |    2 
 net/xfrm/xfrm_ipcomp.c                         |    1 
 net/xfrm/xfrm_state.c                          |   41 +++++---------
 net/xfrm/xfrm_user.c                           |    2 
 samples/vfs/test-statx.c                       |    6 ++
 samples/watch_queue/watch_test.c               |    6 ++
 sound/usb/quirks.c                             |    6 ++
 53 files changed, 520 insertions(+), 206 deletions(-)

Alexander Sverdlin (1):
      locking/spinlock/debug: Fix data-race in do_raw_write_lock

Alexey Nepomnyashih (1):
      ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()

Alvaro Gamez Machado (1):
      spi: xilinx: increase number of retries before declaring stall

Antheas Kapenekakis (2):
      platform/x86/amd: pmc: Add Lenovo Legion Go 2 to pmc quirk list
      platform/x86/amd/pmc: Add spurious_8042 to Xbox Ally

April Grimoire (1):
      HID: apple: Add SONiX AK870 PRO to non_apple_keyboards quirk list

Armin Wolf (1):
      platform/x86: acer-wmi: Ignore backlight event

Bagas Sanjaya (1):
      Documentation: process: Also mention Sasha Levin as stable tree maintainer

Daniele Palmas (2):
      bus: mhi: host: pci_generic: Add Telit FN920C04 modem support
      bus: mhi: host: pci_generic: Add Telit FN990B40 modem support

Deepanshu Kartikey (1):
      ext4: refresh inline data size before write operations

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE910C04 new compositions
      USB: serial: option: move Telit 0x10c7 composition in the right place

Greg Kroah-Hartman (1):
      Linux 6.12.62

Harish Kasiviswanathan (1):
      drm/amdkfd: Fix GPU mappings for APU after prefetch

Huacai Chen (1):
      LoongArch: Mask all interrupts during kexec/kdump

Ian Abbott (1):
      comedi: c6xdigio: Fix invalid PNP driver unregistration

Ian Forbes (1):
      drm/vmwgfx: Use kref in vmw_bo_dirty

Jia Ston (1):
      platform/x86: huawei-wmi: add keys for HONOR models

Johan Hovold (3):
      USB: serial: ftdi_sio: match on interface number for jtag
      USB: serial: belkin_sa: fix TIOCMBIS and TIOCMBIC
      USB: serial: kobil_sct: fix TIOCMBIS and TIOCMBIC

Keith Busch (1):
      nvme: fix admin request_queue lifetime

Linus Torvalds (1):
      samples: work around glibc redefining some of our defines wrong

Lushih Hsieh (1):
      ALSA: usb-audio: Add native DSD quirks for PureAudio DAC series

Magne Bruno (1):
      serial: add support of CPCI cards

Mario Limonciello (AMD) (1):
      HID: hid-input: Extend Elan ignore battery quirk to USB

Max Chou (1):
      Bluetooth: btrtl: Avoid loading the config file on security chips

Naoki Ueki (1):
      HID: elecom: Add support for ELECOM M-XT3URBK (018F)

Navaneeth K (3):
      staging: rtl8723bs: fix out-of-bounds read in rtw_get_ie() parser
      staging: rtl8723bs: fix stack buffer overflow in OnAssocReq IE parsing
      staging: rtl8723bs: fix out-of-bounds read in OnBeacon ESR IE parsing

Nikita Zhandarovich (3):
      comedi: pcl818: fix null-ptr-deref in pcl818_ai_cancel()
      comedi: multiq3: sanitize config options in multiq3_attach()
      comedi: check device's attached status in compat ioctls

Omar Sandoval (1):
      KVM: SVM: Don't skip unrelated instruction if INT3/INTO is replaced

Praveen Talari (1):
      pinctrl: qcom: msm: Fix deadlock in pinmux configuration

Qianchang Zhao (1):
      ksmbd: ipc: fix use-after-free in ipc_msg_send_request

Robin Gong (1):
      spi: imx: keep dma request disabled before dma transfer setup

Sabrina Dubroca (4):
      xfrm: delete x->tunnel as we delete x
      Revert "xfrm: destroy xfrm_state synchronously on net exit path"
      xfrm: also call xfrm_state_delete_tunnel at destroy time for states that were never added
      xfrm: flush all states in xfrm_state_fini

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W760

Song Liu (1):
      ftrace: bpf: Fix IPMODIFY + DIRECT in modify_ftrace_direct()

Tetsuo Handa (1):
      bfs: Reconstruct file type when loading from disk

Ye Bin (1):
      jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted

Yiqi Sun (1):
      smb: fix invalid username check in smb3_fs_context_parse_param()

Zenm Chen (2):
      wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
      wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1


