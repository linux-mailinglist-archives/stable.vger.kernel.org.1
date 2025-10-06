Return-Path: <stable+bounces-183420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C03BBD8AA
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 11:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6681F3BB247
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F6A216E24;
	Mon,  6 Oct 2025 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NE12Uoxz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A721ADCB;
	Mon,  6 Oct 2025 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744599; cv=none; b=Q7e+GSfoDaePKSSfqfwJxVXrxvLOuobC20TDC9dX8UVWsc4E9Uf7TsNJCwBi4uWy10/C+ms4+Hsk7MIZPv3bYVmR8+ftoIsxZLGc+I118a9+6/VyZGv+57CJju9b240jxvCUNV23eTnCfaLU8vX3IHoFqzqAqCFotl3Bgol1w10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744599; c=relaxed/simple;
	bh=WNyFumfV9LU64bx2ItEmdxpsrtbdcEJwehrBgxToCcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKvdSLhHnH+AI1IBNf+/XRl/fnuf9N7oIfi2IjhhPXmVoZF9QLmuqomhuHXQ/F8YwGqHi5MXoOChv6B9bWc2lFxKrhukehOSBwQU5IKQ3mBQZSPgKAIILzCCAK3ZwFFlpGbU1gO6AOX3o4MvSEw7fcEhZowELyewypHlk8XpT5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NE12Uoxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FC4C4CEF7;
	Mon,  6 Oct 2025 09:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759744599;
	bh=WNyFumfV9LU64bx2ItEmdxpsrtbdcEJwehrBgxToCcM=;
	h=From:To:Cc:Subject:Date:From;
	b=NE12Uoxzaaz2TxZMyHCtKD6xG3P2674E/pA72lIFTAO3Nj3BmIm14o9MyyznD2jxT
	 nxLH5xjN6wza3ZYsQF5a4rc7NFKhu34Bl3WUXrZEsWjzq5oBcBg+jmSZMlgaodbYgL
	 2/N/Xi6tyDcFOck1Y1i7DdQwS1APwM9w21ex3M+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.1
Date: Mon,  6 Oct 2025 11:56:32 +0200
Message-ID: <2025100633-update-gown-60c0@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.1 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
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
 drivers/net/wireless/realtek/rtw89/core.c      |   30 ++++++++--
 drivers/net/wireless/realtek/rtw89/core.h      |   35 +++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c       |    3 -
 drivers/net/wireless/realtek/rtw89/ser.c       |    2 
 drivers/target/target_core_configfs.c          |    2 
 mm/swapfile.c                                  |    3 +
 scripts/gcc-plugins/gcc-common.h               |    7 ++
 sound/soc/qcom/qdsp6/topology.c                |    4 -
 sound/usb/midi.c                               |    9 +--
 20 files changed, 165 insertions(+), 59 deletions(-)

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

Fedor Pchelkin (1):
      wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()

Greg Kroah-Hartman (1):
      Linux 6.17.1

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


