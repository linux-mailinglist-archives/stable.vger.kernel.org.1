Return-Path: <stable+bounces-184102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23101BD0175
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 13:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6C23BCB45
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE80273D8A;
	Sun, 12 Oct 2025 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lqQkzExH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AE273D6C;
	Sun, 12 Oct 2025 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760268276; cv=none; b=Oj2fe6vy12Kg1Od0eF9ZkxQCD57J1dmFTyo5JFIUfxFOrcihsMiu9bdBnxmWFMkzWCd2LviOSe/WkAZYCvKLOZ2MZhkSAqlJ+WxJph/5apzBZmbaLmaXxBCy6EvM3cWO+kUJK/wi0pbkz34OtrYB1dL1Zmd0amRPf92gGmRCWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760268276; c=relaxed/simple;
	bh=bfx46x7pmVa+9048jfO4sVEH8O4VYYgVQ2A8fZfWZBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atqef6FLwjo3W14SqCz5rw5TelEIUH69tjoQjHlAQRqhdWhEk24LuqgqWgpgIgoLDN2wmC5CbaRGcq09el/4YXMGvz8vzJlARPIRIK35puNK1ZZ8HH01W6DrKRT1KesncgFk/+BEBHDt73oNNmovUeHH6tIHhG70vBBMsc1BU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lqQkzExH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2E4C4CEF1;
	Sun, 12 Oct 2025 11:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760268275;
	bh=bfx46x7pmVa+9048jfO4sVEH8O4VYYgVQ2A8fZfWZBA=;
	h=From:To:Cc:Subject:Date:From;
	b=lqQkzExHjRZ64Bwk9Tx9aK2TTD+BkL4jV14ySBbrWj/IPI6Xz8JIIgFqXrIjKtNpr
	 1DDDbiXpii966028/MJdYrd6IQMclJBnXiPQzI5jCZsYuuCzyDJTlWVLVSRWqX47Ai
	 MHWWM4tqp+dUJRYTkn3q4VNtMYx6GHL6X6lyA7hI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.2
Date: Sun, 12 Oct 2025 13:24:28 +0200
Message-ID: <2025101229-hypnotism-thimble-b140@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.2 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 arch/x86/kvm/emulate.c                              |    9 -
 arch/x86/kvm/kvm_emulate.h                          |    3 
 arch/x86/kvm/x86.c                                  |   15 -
 crypto/rng.c                                        |    8 
 crypto/testmgr.c                                    |    5 
 crypto/zstd.c                                       |    2 
 drivers/android/dbitmap.h                           |    1 
 drivers/base/faux.c                                 |    1 
 drivers/bluetooth/btusb.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c              |    6 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c              |    5 
 drivers/gpu/drm/amd/include/mes_v11_api_def.h       |    3 
 drivers/gpu/drm/amd/include/mes_v12_api_def.h       |    3 
 drivers/misc/amd-sbi/Kconfig                        |    1 
 drivers/net/wireless/realtek/rtl8xxxu/core.c        |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c |    1 
 drivers/nvmem/layouts.c                             |   13 +
 drivers/staging/axis-fifo/axis-fifo.c               |   68 +++----
 drivers/tty/serial/Kconfig                          |    2 
 drivers/tty/serial/qcom_geni_serial.c               |  176 +-------------------
 drivers/usb/serial/option.c                         |    6 
 fs/f2fs/f2fs.h                                      |    4 
 fs/f2fs/gc.c                                        |    4 
 fs/f2fs/node.c                                      |   58 ++++--
 fs/f2fs/node.h                                      |    1 
 fs/f2fs/recovery.c                                  |    2 
 include/linux/device.h                              |    3 
 kernel/trace/ring_buffer.c                          |    2 
 net/9p/trans_fd.c                                   |    8 
 rust/kernel/block/mq/gen_disk.rs                    |    2 
 rust/kernel/drm/device.rs                           |    2 
 rust/kernel/drm/driver.rs                           |    2 
 rust/kernel/drm/file.rs                             |    2 
 rust/kernel/drm/gem/mod.rs                          |    2 
 rust/kernel/drm/ioctl.rs                            |    2 
 rust/kernel/pci.rs                                  |    6 
 37 files changed, 178 insertions(+), 256 deletions(-)

Ankit Khushwaha (1):
      ring buffer: Propagate __rb_map_vma return value to caller

Bitterblue Smith (2):
      wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188
      wifi: rtl8xxxu: Don't claim USB ID 07b8:8188

Carlos Llamas (1):
      binder: fix double-free in dbitmap

Chao Yu (1):
      f2fs: fix to do sanity check on node footer for non inode dnode

Greg Kroah-Hartman (1):
      Linux 6.17.2

Herbert Xu (3):
      Revert "crypto: testmgr - desupport SHA-1 for FIPS 140"
      crypto: zstd - Fix compression bug caused by truncation
      crypto: rng - Ensure set_ent is always present

Krzysztof Kozlowski (1):
      serial: qcom-geni: Fix blocked task

Mario Limonciello (1):
      drm/amdgpu: Enable MES lr_compute_wa by default

Max Kellermann (1):
      drivers/misc/amd-sbi/Kconfig: select REGMAP_I2C

Michael Walle (1):
      nvmem: layouts: fix automatic module loading

Miguel Ojeda (2):
      rust: drm: fix `srctree/` links
      rust: block: fix `srctree/` links

Nalivayko Sergey (1):
      net/9p: fix double req put in p9_fd_cancelled

Ovidiu Panait (3):
      staging: axis-fifo: fix maximum TX packet length check
      staging: axis-fifo: fix TX handling on copy_from_user() failure
      staging: axis-fifo: flush RX FIFO on read errors

Rafael J. Wysocki (2):
      driver core: faux: Set power.no_pm for faux devices
      driver core/PM: Set power.no_callbacks along with power.no_pm

Rahul Rameshbabu (2):
      rust: pci: fix incorrect platform reference in PCI driver probe doc comment
      rust: pci: fix incorrect platform reference in PCI driver unbind doc comment

Raphael Gallais-Pou (1):
      serial: stm32: allow selecting console when the driver is module

Sean Christopherson (1):
      KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O

Xiaowei Li (1):
      USB: serial: option: add SIMCom 8230C compositions

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1


