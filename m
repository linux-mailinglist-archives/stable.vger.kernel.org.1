Return-Path: <stable+bounces-184098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D59ABD012D
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 13:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADB13BC6D5
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7F263C9F;
	Sun, 12 Oct 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GbUyo87M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61C23F40D;
	Sun, 12 Oct 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760267999; cv=none; b=FYLic1eDtWIlIi+3JFG+3VNfWAJtxUKUMVNpLODFKkS6xeG9rFITX0Z13qIrmC2jWDd8BLmNscwky/mWXwPw+Q+VhwlI3ZkyfgOr5gTpCBKL6gb6tqzmTIGGC7bJp8rm8QbV3v+bXC/SHXS5RB/Z0Trxu476QFey/eEg2m7IRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760267999; c=relaxed/simple;
	bh=0gvSZlorb/tvMlqwtrBfEW+UqHWd9wwR50x4pko1QYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaDcE0mlKhZ4ZCg8G6+3NtocqGPoFMoXF0wcmhiv+uJB13V9VIrgxBwXTXJCu8pTq48G6FdTgrxkyKJd+BbPPYv9dtL48+hxMYmMtYp8i/qk9eqmln1/kKwOaBStmpcEjXlvg7J517awBtZ2znKzyUP/89Gm0QPLZg+I4rxCPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GbUyo87M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58585C4CEE7;
	Sun, 12 Oct 2025 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760267998;
	bh=0gvSZlorb/tvMlqwtrBfEW+UqHWd9wwR50x4pko1QYI=;
	h=From:To:Cc:Subject:Date:From;
	b=GbUyo87MM3DSlO2IcZw0M+t124JXH37EaMFQ/BE+ePkWCSjArm5CrVwM4xtgsBx8J
	 FxYGtZ58U430K1Fu5lhm9BipvFxcqThFek1LIC77EzhpvY5GiJrHTVLCkdEylxjr2E
	 c9YBVUmIHoqHrCkUme7/7PVEk+qLiQYiYYlMbIzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.52
Date: Sun, 12 Oct 2025 13:19:44 +0200
Message-ID: <2025101245-friction-starring-6238@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.52 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 arch/x86/kvm/emulate.c                              |    9 +-
 arch/x86/kvm/kvm_emulate.h                          |    3 
 arch/x86/kvm/x86.c                                  |   15 ++--
 crypto/rng.c                                        |    8 ++
 drivers/android/dbitmap.h                           |    1 
 drivers/bluetooth/btusb.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c              |    6 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c              |    5 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h       |   47 ++++++++++++
 drivers/gpu/drm/amd/include/mes_v12_api_def.h       |   74 +++++++++++++++++++-
 drivers/hid/hid-mcp2221.c                           |    4 +
 drivers/md/dm-integrity.c                           |    2 
 drivers/media/i2c/tc358743.c                        |    4 -
 drivers/net/can/rcar/rcar_canfd.c                   |    7 +
 drivers/net/can/spi/hi311x.c                        |   33 ++++----
 drivers/net/wireless/realtek/rtl8xxxu/core.c        |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c |    1 
 drivers/net/wireless/realtek/rtw89/core.c           |   31 ++++++--
 drivers/net/wireless/realtek/rtw89/core.h           |   35 ++++++++-
 drivers/net/wireless/realtek/rtw89/pci.c            |    3 
 drivers/net/wireless/realtek/rtw89/ser.c            |    3 
 drivers/nvmem/layouts.c                             |   13 +++
 drivers/platform/x86/amd/pmc/pmc-quirks.c           |   15 ++++
 drivers/platform/x86/amd/pmf/core.c                 |    1 
 drivers/staging/axis-fifo/axis-fifo.c               |   68 ++++++++----------
 drivers/tty/serial/Kconfig                          |    2 
 drivers/usb/serial/option.c                         |    6 +
 fs/btrfs/ref-verify.c                               |    9 ++
 fs/netfs/buffered_write.c                           |    2 
 include/linux/device.h                              |    3 
 net/9p/trans_fd.c                                   |    8 +-
 rust/kernel/block/mq/gen_disk.rs                    |    2 
 sound/soc/amd/acp/amd.h                             |    2 
 sound/soc/codecs/rt5682s.c                          |   17 ++--
 sound/usb/midi.c                                    |   10 +-
 tools/lib/subcmd/help.c                             |    3 
 37 files changed, 346 insertions(+), 112 deletions(-)

Arnaud Lecomte (1):
      hid: fix I2C read buffer overflow in raw_event() for mcp2221

Bitterblue Smith (2):
      wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188
      wifi: rtl8xxxu: Don't claim USB ID 07b8:8188

Carlos Llamas (1):
      binder: fix double-free in dbitmap

Chen Yufeng (1):
      can: hi311x: fix null pointer dereference when resuming from sleep before interface was enabled

Christoffer Sandberg (1):
      platform/x86/amd/pmc: Add Stellaris Slim Gen6 AMD to spurious 8042 quirks list

David Sterba (1):
      btrfs: ref-verify: handle damaged extent root tree

Duoming Zhou (1):
      media: i2c: tc358743: Fix use-after-free bugs caused by orphan timer in probe

Duy Nguyen (1):
      can: rcar_canfd: Fix controller mode setting

Fedor Pchelkin (1):
      wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()

Greg Kroah-Hartman (1):
      Linux 6.12.52

Herbert Xu (1):
      crypto: rng - Ensure set_ent is always present

Jack Yu (1):
      ASoC: rt5682s: Adjust SAR ADC button mode to fix noise issue

Jeongjun Park (1):
      ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free

Lizhi Xu (1):
      netfs: Prevent duplicate unlocking

Mario Limonciello (1):
      drm/amdgpu: Enable MES lr_compute_wa by default

Michael Walle (1):
      nvmem: layouts: fix automatic module loading

Miguel Ojeda (1):
      rust: block: fix `srctree/` links

Mikulas Patocka (1):
      dm-integrity: limit MAX_TAG_SIZE to 255

Nalivayko Sergey (1):
      net/9p: fix double req put in p9_fd_cancelled

Ovidiu Panait (3):
      staging: axis-fifo: fix maximum TX packet length check
      staging: axis-fifo: fix TX handling on copy_from_user() failure
      staging: axis-fifo: flush RX FIFO on read errors

Rafael J. Wysocki (1):
      driver core/PM: Set power.no_callbacks along with power.no_pm

Raphael Gallais-Pou (1):
      serial: stm32: allow selecting console when the driver is module

Sean Christopherson (1):
      KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O

Shaoyun Liu (3):
      drm/amd : Update MES API header file for v11 & v12
      drm/amd/include : MES v11 and v12 API header update
      drm/amd/include : Update MES v12 API for fence update

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Support new ACPI ID AMDI0108

Takashi Iwai (1):
      ALSA: usb-audio: Kill timer properly at removal

Venkata Prasad Potturu (1):
      ASoC: amd: acp: Adjust pdm gain value

Xiaowei Li (1):
      USB: serial: option: add SIMCom 8230C compositions

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1

aprilgrimoire (1):
      platform/x86/amd/pmc: Add MECHREVO Yilong15Pro to spurious_8042 list

hupu (1):
      perf subcmd: avoid crash in exclude_cmds when excludes is empty


