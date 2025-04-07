Return-Path: <stable+bounces-128476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3993A7D7AB
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB131890537
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4F227E9E;
	Mon,  7 Apr 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ae6jHq1d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21122A1E2;
	Mon,  7 Apr 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014111; cv=none; b=VKjMfx6D1ViflC+IJTKLW56pVWWUnm8lR0eJ9+mfYa9V4tWnvWKkDydEHmunfmvmE+GHbcrHIxZnPD+6u3vmXVHsG7ppsKWvoASUmKheJlTvPNBPyOrORu7wjSDfwmkwEZzywEHOwaezI9M1gGssJKCYDZNX/NekXnf06Ox0gLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014111; c=relaxed/simple;
	bh=QVboTJhFzqwynhbAl3zuXOQlfDXwUU512Pp/hQbenWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/DG/6LDHNeO71U0ji6N4i8lQ7vovep0ON0+Xacu29rWrZshZUkFrOM/qEF9EmeIM93LDQJhUtEGKSzzKUMACxPNwyBsX0k0tZ2Y2TiaE+ypgShy2MsMUMYdclTZrneAQwSKaxSaMCS087NAiKL9JzK7bExlGrZlz5XdOYz2shQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ae6jHq1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAFEC4CEDD;
	Mon,  7 Apr 2025 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744014111;
	bh=QVboTJhFzqwynhbAl3zuXOQlfDXwUU512Pp/hQbenWM=;
	h=From:To:Cc:Subject:Date:From;
	b=ae6jHq1drul/+IR5EPdWi14UtuLYw8Qn666p99avlzCmZtacg5oFhggftzYRJWQhf
	 5Ok44s/fk3pPgWjRbQ/MYUHXcJ1qFW17jwHt1VMMGrNjSUsarbT5Itusakv7FwaC+8
	 jnQ6jXJrApEY2x3yKHnTFEUwNW+vPcESZpCu9mAQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.13.10
Date: Mon,  7 Apr 2025 10:20:14 +0200
Message-ID: <2025040715-antiquity-retired-a642@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.13.10 kernel.

All users of the 6.13 kernel series must upgrade.

The updated 6.13.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.13.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                  |    2 
 drivers/counter/microchip-tcb-capture.c   |   19 +++
 drivers/counter/stm32-lptimer-cnt.c       |   24 +++--
 drivers/hid/hid-plantronics.c             |  144 +++++++++++++-----------------
 drivers/memstick/host/rtsx_usb_ms.c       |    1 
 drivers/net/usb/qmi_wwan.c                |    2 
 drivers/net/usb/usbnet.c                  |   21 +++-
 drivers/tty/serial/8250/8250_dma.c        |    2 
 drivers/tty/serial/8250/8250_pci.c        |   46 +++++++++
 drivers/tty/serial/fsl_lpuart.c           |   17 +++
 drivers/tty/serial/stm32-usart.c          |    4 
 drivers/usb/host/xhci-ring.c              |    4 
 drivers/usb/host/xhci.h                   |   13 ++
 fs/bcachefs/fs-ioctl.c                    |    6 -
 fs/nfsd/nfs4recover.c                     |    1 
 kernel/cgroup/rstat.c                     |   29 ++----
 net/atm/mpc.c                             |    2 
 net/ipv6/netfilter/nf_socket_ipv6.c       |   23 ++++
 sound/pci/hda/patch_realtek.c             |    2 
 sound/usb/mixer_quirks.c                  |   51 ++++++++++
 tools/perf/Documentation/intel-hybrid.txt |   12 +-
 tools/perf/Documentation/perf-list.txt    |    2 
 tools/perf/arch/x86/util/iostat.c         |    2 
 tools/perf/builtin-stat.c                 |    2 
 tools/perf/util/mem-events.c              |    2 
 tools/perf/util/pmu.c                     |    4 
 26 files changed, 307 insertions(+), 130 deletions(-)

Abel Wu (1):
      cgroup/rstat: Fix forceidle time in cpu.stat

Andres Traumann (1):
      ALSA: hda/realtek: Bass speaker fixup for ASUS UM5606KA

Cameron Williams (2):
      tty: serial: 8250: Add some more device IDs
      tty: serial: 8250: Add Brainboxes XC devices

Cheick Traore (1):
      serial: stm32: do not deassert RS485 RTS GPIO prematurely

Dhruv Deshpande (1):
      ALSA: hda/realtek: Support mute LED on HP Laptop 15s-du3xxx

Dominique Martinet (1):
      net: usb: usbnet: restore usb%d name exception for local mac addresses

Fabio Porcedda (2):
      net: usb: qmi_wwan: add Telit Cinterion FN990B composition
      net: usb: qmi_wwan: add Telit Cinterion FE990B composition

Fabrice Gasnier (1):
      counter: stm32-lptimer-cnt: fix error handling when enabling

Greg Kroah-Hartman (2):
      perf tools: Fix up some comments and code to properly use the event_source bus
      Linux 6.13.10

John Keeping (1):
      serial: 8250_dma: terminate correct DMA in tx_dma_flush()

Kent Overstreet (1):
      bcachefs: bch2_ioctl_subvolume_destroy() fixes

Luo Qiu (1):
      memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove

Maxim Mikityanskiy (1):
      netfilter: socket: Lookup orig tuple for IPv6 SNAT

Michal Pecio (2):
      usb: xhci: Don't skip on Stopped - Length Invalid
      usb: xhci: Apply the link chain quirk on NEC isoc endpoints

Minjoong Kim (1):
      atm: Fix NULL pointer dereference

Scott Mayhew (1):
      nfsd: fix legacy client tracking initialization

Sherry Sun (1):
      tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers

Terry Junge (2):
      ALSA: usb-audio: Add quirk for Plantronics headsets to fix control names
      HID: hid-plantronics: Add mic mute mapping and generalize quirks

William Breathitt Gray (1):
      counter: microchip-tcb-capture: Fix undefined counter channel state on probe


