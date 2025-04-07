Return-Path: <stable+bounces-128472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7A9A7D79D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B097A6471
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC074225A48;
	Mon,  7 Apr 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JSBYtLV+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEB225791;
	Mon,  7 Apr 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014093; cv=none; b=PinvxddtZ88v1zoL5NJgpJdlItVsCzoBzGCkKEJC4qPDmJhKDbF5BYMp+y3eKFjMZdvLDRXlwa8KxXEsJ3nS8NnCxJnA6zR1MqudTX+EC0kDB+nvuNlc/MCE/4u8NvybXEUxTbm+TmzDLWJtlB9K5ReT3/ThY/j8eaIt0xP1cQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014093; c=relaxed/simple;
	bh=gRxjh7ym/gfIPig4QH/J/0zRhHE/qVlownz2/1eF934=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQl7n0TxoPNFmGTakE190rC/phjqzsMhzKJIkEwfe2tFx78pow43D2iY3gJEHOPa7I/joxq2S93sPiXI9jBFocnv4bCqOu5JD6C/Fq/e2EOK5qbrTpIQdgTFXtd77F/V+R8D5m1eu5x2E6EK/BtfMfcMqi2+PSGiDR02idGMB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JSBYtLV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883F6C4CEE9;
	Mon,  7 Apr 2025 08:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744014092;
	bh=gRxjh7ym/gfIPig4QH/J/0zRhHE/qVlownz2/1eF934=;
	h=From:To:Cc:Subject:Date:From;
	b=JSBYtLV+OZO/DeGdXfsReJnsot4pusku9hBNhuOFhEzy0oZzULYDf8+BCe8g4ihe7
	 Vz5HAtzmFmEc2E2LGLIQ51L539AFDzaLOue4oWEZ+C50SVcZ/xJviiGvcNhuKhs0vv
	 XnF8cx4c4pCzGMomW/gJ17hm0DGtUmkk7WXJLJoA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.86
Date: Mon,  7 Apr 2025 10:19:58 +0200
Message-ID: <2025040759-ambush-strode-2570@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.86 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/arm/mm/fault.c                                     |    8 
 drivers/counter/microchip-tcb-capture.c                 |   19 ++
 drivers/counter/stm32-lptimer-cnt.c                     |   24 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       |   16 -
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c |    2 
 drivers/gpu/drm/display/drm_dp_mst_topology.c           |   36 +++-
 drivers/hid/hid-plantronics.c                           |  144 +++++++---------
 drivers/memstick/host/rtsx_usb_ms.c                     |    1 
 drivers/net/usb/qmi_wwan.c                              |    2 
 drivers/net/usb/usbnet.c                                |   21 +-
 drivers/reset/starfive/reset-starfive-jh71x0.c          |    3 
 drivers/tty/serial/8250/8250_dma.c                      |    2 
 drivers/tty/serial/8250/8250_pci.c                      |   46 +++++
 drivers/tty/serial/fsl_lpuart.c                         |   17 +
 drivers/ufs/host/ufs-qcom.c                             |    4 
 drivers/usb/gadget/function/uvc_v4l2.c                  |   12 +
 include/drm/display/drm_dp_mst_helper.h                 |    2 
 mm/page_alloc.c                                         |   14 +
 net/atm/mpc.c                                           |    2 
 net/ipv6/netfilter/nf_socket_ipv6.c                     |   23 ++
 sound/pci/hda/patch_realtek.c                           |    1 
 sound/usb/mixer_quirks.c                                |   51 +++++
 23 files changed, 339 insertions(+), 113 deletions(-)

Abhishek Tamboli (1):
      usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c

Alex Hung (1):
      drm/amd/display: Check denominator crb_pipes before used

Cameron Williams (2):
      tty: serial: 8250: Add some more device IDs
      tty: serial: 8250: Add Brainboxes XC devices

Changhuang Liang (1):
      reset: starfive: jh71x0: Fix accessing the empty member on JH7110 SoC

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
      Linux 6.6.86

Imre Deak (2):
      drm/dp_mst: Factor out function to queue a topology probe work
      drm/dp_mst: Add a helper to queue a topology probe

John Keeping (1):
      serial: 8250_dma: terminate correct DMA in tx_dma_flush()

Kees Cook (2):
      ARM: 9350/1: fault: Implement copy_from_kernel_nofault_allowed()
      ARM: 9351/1: fault: Add "cut here" line for prefetch aborts

Kirill A. Shutemov (1):
      mm/page_alloc: fix memory accept before watermarks gets initialized

Luo Qiu (1):
      memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove

Manivannan Sadhasivam (1):
      scsi: ufs: qcom: Only free platform MSIs when ESI is enabled

Maxim Mikityanskiy (1):
      netfilter: socket: Lookup orig tuple for IPv6 SNAT

Minjoong Kim (1):
      atm: Fix NULL pointer dereference

Sherry Sun (1):
      tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers

Terry Junge (2):
      ALSA: usb-audio: Add quirk for Plantronics headsets to fix control names
      HID: hid-plantronics: Add mic mute mapping and generalize quirks

Wayne Lin (1):
      drm/amd/display: Don't write DP_MSTM_CTRL after LT

William Breathitt Gray (1):
      counter: microchip-tcb-capture: Fix undefined counter channel state on probe

Yanjun Yang (1):
      ARM: Remove address checking for MMUless devices


