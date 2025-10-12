Return-Path: <stable+bounces-184096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07486BD0121
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 13:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07BE3B1A6F
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7455F244675;
	Sun, 12 Oct 2025 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VM7eQeZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563A17A2FB;
	Sun, 12 Oct 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760267981; cv=none; b=anBs3woFurmXeFFjGWvefBXg0MVipXrtHZDXQe0USQsSl0Jz05JnF+T3uU30tkGrlzpk/7cZWLtHeHvo/tTc0p6vCbmKEf+C6IzYukRvy13RzlDufP+c1/tdq8314w5s0jatK0ROsF11fB0NZ2TpDD6HwTDpA7w7BItG7xXa2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760267981; c=relaxed/simple;
	bh=5boiJvjEIgwXig2P2NkVDgNUHvng7jEOiO3J3CEOX0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAd8rLiHiakN83RWrymUv6Nv0HbmdHiOxjfDmLNoexCAGTe/6OXzmtAWqLkVOZ+TBo1fheXNw+77UwPz3ogs6W0S+j6jZXjyEPDCTUxrTeL5hNW+A4funYQkTlDAlGMzPlcOj9X3CV247pqLGY4k29AR+QNdr+bwB1BD2gPRC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VM7eQeZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E533C4CEE7;
	Sun, 12 Oct 2025 11:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760267980;
	bh=5boiJvjEIgwXig2P2NkVDgNUHvng7jEOiO3J3CEOX0w=;
	h=From:To:Cc:Subject:Date:From;
	b=VM7eQeZfgP2scRnAzuqejRaG7E8dKDB0jXVpOIp9C2FQNE3uUOMNCtBof8P54xKWw
	 odkqpYGBgtBng2XJSg6nPKeBTbYnVfMhu1CK6aP+tG0SC4CHsQJER3dx3n+hVfwXEi
	 DUSoxpUfGuqJHTOqHqK5bX4CJVx/9ywYwDSY1mWI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.111
Date: Sun, 12 Oct 2025 13:19:35 +0200
Message-ID: <2025101236-matriarch-glowing-5dd5@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.111 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 arch/arm64/kernel/fpsimd.c                          |    8 +-
 arch/riscv/include/asm/processor.h                  |   33 +--------
 arch/x86/kvm/emulate.c                              |    9 +-
 arch/x86/kvm/kvm_emulate.h                          |    3 
 arch/x86/kvm/x86.c                                  |   15 ++--
 crypto/rng.c                                        |    8 ++
 drivers/hid/hid-mcp2221.c                           |    4 +
 drivers/md/dm-integrity.c                           |    2 
 drivers/media/i2c/tc358743.c                        |    4 -
 drivers/media/tuners/xc5000.c                       |   41 +++++-------
 drivers/net/can/rcar/rcar_canfd.c                   |    7 +-
 drivers/net/can/spi/hi311x.c                        |   33 +++++----
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c |    1 
 drivers/platform/x86/amd/pmc/pmc-quirks.c           |   15 ++++
 drivers/staging/axis-fifo/axis-fifo.c               |   68 +++++++++-----------
 drivers/tty/serial/Kconfig                          |    2 
 drivers/usb/serial/option.c                         |    6 +
 fs/btrfs/ref-verify.c                               |    9 ++
 include/linux/device.h                              |    3 
 net/9p/trans_fd.c                                   |    8 +-
 sound/soc/amd/acp/amd.h                             |    2 
 sound/soc/codecs/rt5682s.c                          |   17 ++---
 sound/usb/midi.c                                    |   10 +-
 tools/lib/subcmd/help.c                             |    3 
 25 files changed, 165 insertions(+), 148 deletions(-)

Arnaud Lecomte (1):
      hid: fix I2C read buffer overflow in raw_event() for mcp2221

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188

Charlie Jenkins (2):
      riscv: mm: Use hint address in mmap if available
      riscv: mm: Do not restrict mmap address based on hint

Chen Yufeng (1):
      can: hi311x: fix null pointer dereference when resuming from sleep before interface was enabled

Christoffer Sandberg (1):
      platform/x86/amd/pmc: Add Stellaris Slim Gen6 AMD to spurious 8042 quirks list

David Sterba (1):
      btrfs: ref-verify: handle damaged extent root tree

Duoming Zhou (2):
      media: tuner: xc5000: Fix use-after-free in xc5000_release
      media: i2c: tc358743: Fix use-after-free bugs caused by orphan timer in probe

Duy Nguyen (1):
      can: rcar_canfd: Fix controller mode setting

Greg Kroah-Hartman (1):
      Linux 6.6.111

Herbert Xu (1):
      crypto: rng - Ensure set_ent is always present

Jack Yu (1):
      ASoC: rt5682s: Adjust SAR ADC button mode to fix noise issue

Jeongjun Park (1):
      ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free

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

Ricardo Ribalda (1):
      media: tunner: xc5000: Refactor firmware load

Sean Christopherson (1):
      KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O

Takashi Iwai (1):
      ALSA: usb-audio: Kill timer properly at removal

Venkata Prasad Potturu (1):
      ASoC: amd: acp: Adjust pdm gain value

Will Deacon (1):
      KVM: arm64: Fix softirq masking in FPSIMD register saving sequence

Xiaowei Li (1):
      USB: serial: option: add SIMCom 8230C compositions

aprilgrimoire (1):
      platform/x86/amd/pmc: Add MECHREVO Yilong15Pro to spurious_8042 list

hupu (1):
      perf subcmd: avoid crash in exclude_cmds when excludes is empty


