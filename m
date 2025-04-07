Return-Path: <stable+bounces-128470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A194DA7D79A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0007188CF06
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D99B224AFA;
	Mon,  7 Apr 2025 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gARsCiXP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F354642D;
	Mon,  7 Apr 2025 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014083; cv=none; b=MBHJ2ShtQpc/PiPzPjGA0uZwlOrCheSHedQ8MkBa2pvVBgWiNfq+fuEWys4rUV+1Zz6RBgZdcR/PBG58RiQOlmD3GqtSNv2WKnWTqgvYVVsJA3I56zqe7ZBwYIFcVmQcrtUUY/lbsPemLSetiG+2m8hNBvnL12kVNqk9L/UD5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014083; c=relaxed/simple;
	bh=Q2HXv1p2k9GopR7Nnu80ljo8HLyFdhs0NFrLGx/o/Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a1yrxQ2L8U74HjVIOhkHQMNpbvN2Rt0iCtPcLDqNlc9okJWUqig5J9dTmPfcjgbuFXNPVI+itCatQumkErgbaGLJTchdoEK9BUBvA2EYJsP04mQ6+witTg+gxxZhNCEsMjeSpW2XXx6zk+sxtiEu2l7FRMjrQjkCTeMjpRMbafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gARsCiXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE055C4CEDD;
	Mon,  7 Apr 2025 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744014083;
	bh=Q2HXv1p2k9GopR7Nnu80ljo8HLyFdhs0NFrLGx/o/Oo=;
	h=From:To:Cc:Subject:Date:From;
	b=gARsCiXPnifCXTql9P6l1rXRWU1W6jJNxTFI8yzqW451j51kJEOsNVYc9aYKnEO4I
	 8W5K/WbKVjq4exZP8aavbjwElBgrs2LjfYl+6mhFfdBgfzXQX27T4U/JlbNcbLVJRd
	 nU4PcS4wCvWCek0LYMjq5ArCUERo/y+da1XWE/rQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.133
Date: Mon,  7 Apr 2025 10:19:51 +0200
Message-ID: <2025040752-army-degrease-7703@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.133 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/arm/boot/dts/imx6qdl-apalis.dtsi                   |   10 -
 arch/arm/mm/fault.c                                     |    8 
 drivers/counter/microchip-tcb-capture.c                 |   19 ++
 drivers/counter/stm32-lptimer-cnt.c                     |   24 +-
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c |    2 
 drivers/hid/hid-plantronics.c                           |  144 +++++++---------
 drivers/media/i2c/et8ek8/et8ek8_driver.c                |    4 
 drivers/memstick/host/rtsx_usb_ms.c                     |    1 
 drivers/net/usb/qmi_wwan.c                              |    2 
 drivers/net/usb/usbnet.c                                |   21 +-
 drivers/tty/serial/8250/8250_dma.c                      |    2 
 drivers/tty/serial/8250/8250_pci.c                      |   46 +++++
 drivers/usb/gadget/function/uvc_v4l2.c                  |   12 +
 drivers/usb/typec/ucsi/ucsi.c                           |   13 -
 net/atm/mpc.c                                           |    2 
 net/ipv6/netfilter/nf_socket_ipv6.c                     |   23 ++
 sound/pci/hda/patch_realtek.c                           |    1 
 sound/usb/mixer_quirks.c                                |   51 +++++
 19 files changed, 278 insertions(+), 109 deletions(-)

Abhishek Tamboli (1):
      usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c

Alex Hung (1):
      drm/amd/display: Check denominator crb_pipes before used

Andrei Kuchynski (1):
      usb: typec: ucsi: Fix NULL pointer access

Cameron Williams (2):
      tty: serial: 8250: Add some more device IDs
      tty: serial: 8250: Add Brainboxes XC devices

Dhruv Deshpande (1):
      ALSA: hda/realtek: Support mute LED on HP Laptop 15s-du3xxx

Dominique Martinet (1):
      net: usb: usbnet: restore usb%d name exception for local mac addresses

Fabio Porcedda (2):
      net: usb: qmi_wwan: add Telit Cinterion FN990B composition
      net: usb: qmi_wwan: add Telit Cinterion FE990B composition

Fabrice Gasnier (1):
      counter: stm32-lptimer-cnt: fix error handling when enabling

Greg Kroah-Hartman (1):
      Linux 6.1.133

John Keeping (1):
      serial: 8250_dma: terminate correct DMA in tx_dma_flush()

Kees Cook (2):
      ARM: 9350/1: fault: Implement copy_from_kernel_nofault_allowed()
      ARM: 9351/1: fault: Add "cut here" line for prefetch aborts

Luo Qiu (1):
      memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove

Maxim Mikityanskiy (1):
      netfilter: socket: Lookup orig tuple for IPv6 SNAT

Minjoong Kim (1):
      atm: Fix NULL pointer dereference

Stefan Eichenberger (1):
      ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6

Terry Junge (2):
      ALSA: usb-audio: Add quirk for Plantronics headsets to fix control names
      HID: hid-plantronics: Add mic mute mapping and generalize quirks

Uwe Kleine-König (1):
      media: i2c: et8ek8: Don't strip remove function when driver is builtin

William Breathitt Gray (1):
      counter: microchip-tcb-capture: Fix undefined counter channel state on probe

Yanjun Yang (1):
      ARM: Remove address checking for MMUless devices


