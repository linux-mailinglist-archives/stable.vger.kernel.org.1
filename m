Return-Path: <stable+bounces-184100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB0BD0169
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 13:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8C11895030
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3037275AF3;
	Sun, 12 Oct 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="axvEEb1t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47B275AF0;
	Sun, 12 Oct 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760268266; cv=none; b=MWdcXnA0jcNswznCmV0gtZcsM7YTFil7kzkgjsOdv1sW5u+1j4DnkeWQtbYHfStzC1kenOrTttgG8ROVF6tzcN5t/FAlKOF54XI/w+tW3ThDMwqoCat3fnxPGb48KFhWcLd0e3hESL4UfKU+TpwJRMfRg0Kztn1jhTF2dXVzNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760268266; c=relaxed/simple;
	bh=pTvoup6kJhszJSu6u8heO488OTgB3t1keYoo0rW8Z+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhAjzagKXEeZF0Kb7T+QXg+tX+4dvuuI/sCSWP00ed2yS9363FUDoDUpigXEjJXhJF2cC9wFlvw/TmiSX8Ku1Wo/drzxYFmPkKkmcZeKussQXmk2VPN/QE2Gjb0unshY2hnMgbetC0ryjl6IclWnQSF1yMUSyXHxKn5jintwLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=axvEEb1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3061C4CEE7;
	Sun, 12 Oct 2025 11:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760268266;
	bh=pTvoup6kJhszJSu6u8heO488OTgB3t1keYoo0rW8Z+s=;
	h=From:To:Cc:Subject:Date:From;
	b=axvEEb1tkUdFzMY4y3xnBNb9qKDMX0SK1HujwEsQs0WRpm4Xo28+2i6rVOuAYb+iV
	 bAmOq+9+/o17wySLUVBGzArHXF8h+4spyBZghrFvf5JI27t3e8ouE4JeKyI0hLkBLL
	 Sdk4nBtTgDZk0jbQ6Z5pZ+VsY+8tmygOG07kRGJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.12
Date: Sun, 12 Oct 2025 13:24:21 +0200
Message-ID: <2025101235-eliminate-dexterity-d7f9@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note, this is the LAST 6.16.y kernel release, this branch is now
end-of-life.  Please move to the 6.17.y branch at this point in time.

-----------------------

I'm announcing the release of the 6.16.12 kernel.

All users of the 6.16 kernel series must upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
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
 drivers/base/faux.c                                 |    1 
 drivers/bluetooth/btusb.c                           |    2 
 drivers/gpio/gpiolib-acpi-quirks.c                  |   12 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c              |   15 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c              |    6 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c              |    5 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h       |    3 
 drivers/gpu/drm/amd/include/mes_v12_api_def.h       |    3 
 drivers/hid/hid-mcp2221.c                           |    4 +
 drivers/iommu/iommufd/device.c                      |    3 
 drivers/iommu/iommufd/iommufd_private.h             |    3 
 drivers/iommu/iommufd/main.c                        |    4 +
 drivers/md/dm-integrity.c                           |    2 
 drivers/misc/amd-sbi/Kconfig                        |    1 
 drivers/net/can/rcar/rcar_canfd.c                   |    7 +-
 drivers/net/can/spi/hi311x.c                        |   33 +++++----
 drivers/net/wireless/realtek/rtl8xxxu/core.c        |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c |    1 
 drivers/net/wireless/realtek/rtw89/chan.c           |   35 ++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h           |    2 
 drivers/net/wireless/realtek/rtw89/core.c           |   32 +++++++--
 drivers/net/wireless/realtek/rtw89/core.h           |   37 ++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c            |    3 
 drivers/net/wireless/realtek/rtw89/ser.c            |    2 
 drivers/nvmem/layouts.c                             |   13 +++
 drivers/platform/x86/amd/pmc/pmc-quirks.c           |   15 ++++
 drivers/platform/x86/amd/pmf/core.c                 |    1 
 drivers/platform/x86/oxpec.c                        |    7 ++
 drivers/staging/axis-fifo/axis-fifo.c               |   68 +++++++++-----------
 drivers/tty/serial/Kconfig                          |    2 
 drivers/usb/serial/option.c                         |    6 +
 fs/btrfs/ref-verify.c                               |    9 ++
 fs/netfs/buffered_write.c                           |    2 
 include/linux/device.h                              |    3 
 kernel/trace/ring_buffer.c                          |    2 
 net/9p/trans_fd.c                                   |    8 +-
 rust/kernel/block/mq/gen_disk.rs                    |    2 
 rust/kernel/drm/device.rs                           |    2 
 rust/kernel/drm/driver.rs                           |    2 
 rust/kernel/drm/file.rs                             |    2 
 rust/kernel/drm/gem/mod.rs                          |    2 
 rust/kernel/drm/ioctl.rs                            |    2 
 rust/kernel/pci.rs                                  |    4 -
 sound/pci/hda/tas2781_hda.c                         |   25 +++++--
 sound/soc/amd/acp/amd.h                             |    2 
 sound/soc/codecs/rt5682s.c                          |   17 ++---
 sound/soc/codecs/rt712-sdca.c                       |    6 -
 tools/lib/subcmd/help.c                             |    3 
 54 files changed, 338 insertions(+), 123 deletions(-)

Ankit Khushwaha (1):
      ring buffer: Propagate __rb_map_vma return value to caller

Antheas Kapenekakis (2):
      gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
      platform/x86: oxpec: Add support for OneXPlayer X1Pro EVA-02

Arnaud Lecomte (1):
      hid: fix I2C read buffer overflow in raw_event() for mcp2221

Bitterblue Smith (2):
      wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188
      wifi: rtl8xxxu: Don't claim USB ID 07b8:8188

Carlos Llamas (1):
      binder: fix double-free in dbitmap

Chen Yufeng (1):
      can: hi311x: fix null pointer dereference when resuming from sleep before interface was enabled

Chih-Kang Chang (1):
      wifi: rtw89: mcc: stop TX during MCC prepare

Christoffer Sandberg (1):
      platform/x86/amd/pmc: Add Stellaris Slim Gen6 AMD to spurious 8042 quirks list

David Sterba (1):
      btrfs: ref-verify: handle damaged extent root tree

Duy Nguyen (1):
      can: rcar_canfd: Fix controller mode setting

Fedor Pchelkin (1):
      wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()

Greg Kroah-Hartman (1):
      Linux 6.16.12

Herbert Xu (1):
      crypto: rng - Ensure set_ent is always present

Jack Yu (1):
      ASoC: rt5682s: Adjust SAR ADC button mode to fix noise issue

Jason Gunthorpe (1):
      iommufd: WARN if an object is aborted with an elevated refcount

Lizhi Xu (1):
      netfs: Prevent duplicate unlocking

Mario Limonciello (1):
      drm/amdgpu: Enable MES lr_compute_wa by default

Max Kellermann (1):
      drivers/misc/amd-sbi/Kconfig: select REGMAP_I2C

Michael Walle (1):
      nvmem: layouts: fix automatic module loading

Miguel Ojeda (2):
      rust: drm: fix `srctree/` links
      rust: block: fix `srctree/` links

Mikulas Patocka (1):
      dm-integrity: limit MAX_TAG_SIZE to 255

Nalivayko Sergey (1):
      net/9p: fix double req put in p9_fd_cancelled

Ovidiu Panait (3):
      staging: axis-fifo: fix maximum TX packet length check
      staging: axis-fifo: fix TX handling on copy_from_user() failure
      staging: axis-fifo: flush RX FIFO on read errors

Rafael J. Wysocki (2):
      driver core: faux: Set power.no_pm for faux devices
      driver core/PM: Set power.no_callbacks along with power.no_pm

Rahul Rameshbabu (1):
      rust: pci: fix incorrect platform reference in PCI driver probe doc comment

Raphael Gallais-Pou (1):
      serial: stm32: allow selecting console when the driver is module

Sean Christopherson (1):
      KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O

Shenghao Ding (1):
      ALSA: hda/tas2781: Fix the order of TAS2781 calibrated-data

Shuming Fan (1):
      ASoC: rt712: avoid skipping the blind write

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Support new ACPI ID AMDI0108

Srinivasan Shanmugam (1):
      drm/amdgpu/gfx11: Add Cleaner Shader Support for GFX11.0.1/11.0.4 GPUs

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


