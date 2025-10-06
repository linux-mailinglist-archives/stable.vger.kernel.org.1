Return-Path: <stable+bounces-183418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE273BBD89F
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 11:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D17A3BAB9C
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05621CC44;
	Mon,  6 Oct 2025 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1dY791VT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B921885A;
	Mon,  6 Oct 2025 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744592; cv=none; b=SL1BbDavLMLQJA0eJS/ut6gHFNaKNQ2QRlzJx3Aw2nOXHW1+UWQBJXKiR22s38fZbzKg6g2oggtILDXrpZKJ9zpT84pN8WBnGRfiDZvx2U7Rr+ah8NlUqfNU8DSIcheIxDO1L9iBlQDz1JJQjD8nWFg8aKa8uT0deN5DOVKn3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744592; c=relaxed/simple;
	bh=Bg0ikKgpq84ZIJuYQNvXK6dKn9zUhPsb86ROszH2jlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WlC/YFBy1Z374M3bAHo8AHVO925d1z4npHnGjozUUxwdcou7EqbfFbFbE2nNnRrN9WMrFlFKW5DMRQbSbpbTcs0C+Hp5eZpJi8rLrPDL5Wdr7ogWb9qciT4495+R5yTHDfM0DL7Zala0PLwYyKJJ8OhyI/E5FhS1xnXKjlVucSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1dY791VT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1488CC4CEF5;
	Mon,  6 Oct 2025 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759744592;
	bh=Bg0ikKgpq84ZIJuYQNvXK6dKn9zUhPsb86ROszH2jlg=;
	h=From:To:Cc:Subject:Date:From;
	b=1dY791VT/2NHe9NA9Twt9PSeMuVKzwfnxYpyRkuGe5ql2ocVohION5wQ4I6VZflB3
	 zxPNGDfe5gfKwmuGt+O0G/a/VaTaj4owvbiGqNhR1YqymAAS45JIryVa9aiLWjTErd
	 BJyZ+63UMcgiGW5C50FFajgSyHgDtOlPs4jwO2IM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.11
Date: Mon,  6 Oct 2025 11:56:25 +0200
Message-ID: <2025100626-semantic-curtsy-72b0@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.16.11 kernel.

All users of the 6.16 kernel series must upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                       |    2 
 block/blk-mq-tag.c                             |    1 
 drivers/media/i2c/tc358743.c                   |    4 -
 drivers/media/pci/b2c2/flexcop-pci.c           |    2 
 drivers/media/platform/qcom/iris/iris_buffer.c |   10 +++
 drivers/media/platform/st/stm32/stm32-csi.c    |    4 -
 drivers/media/rc/imon.c                        |   27 ++++++---
 drivers/media/tuners/xc5000.c                  |    2 
 drivers/media/usb/uvc/uvc_driver.c             |   73 +++++++++++++++----------
 drivers/media/usb/uvc/uvcvideo.h               |    2 
 drivers/net/wireless/ath/ath11k/qmi.c          |    2 
 drivers/target/target_core_configfs.c          |    2 
 mm/swapfile.c                                  |    3 +
 scripts/gcc-plugins/gcc-common.h               |    7 ++
 sound/soc/qcom/qdsp6/topology.c                |    4 -
 sound/usb/midi.c                               |    9 +--
 16 files changed, 104 insertions(+), 50 deletions(-)

Chandra Mohan Sundar (1):
      media: stm32-csi: Fix dereference before NULL check

Charan Teja Kalla (1):
      mm: swap: check for stable address space before operating on the VMA

Dikshita Agarwal (1):
      media: iris: Fix memory leak by freeing untracked persist buffer

Duoming Zhou (3):
      media: b2c2: Fix use-after-free causing by irq_check_work in flexcop_pci_remove
      media: i2c: tc358743: Fix use-after-free bugs caused by orphan timer in probe
      media: tuner: xc5000: Fix use-after-free in xc5000_release

Greg Kroah-Hartman (1):
      Linux 6.16.11

Jeongjun Park (1):
      ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free

Kees Cook (1):
      gcc-plugins: Remove TODO_verify_il for GCC >= 16

Larshin Sergey (1):
      media: rc: fix races with imon_disconnect()

Matvey Kovalev (1):
      wifi: ath11k: fix NULL dereference in ath11k_qmi_m3_load()

Srinivas Kandagatla (1):
      ASoC: qcom: audioreach: fix potential null pointer dereference

Thadeu Lima de Souza Cascardo (1):
      media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID

Wang Haoran (1):
      scsi: target: target_core_configfs: Add length check to avoid buffer overflow

Yu Kuai (1):
      blk-mq: fix blk_mq_tags double free while nr_requests grown


