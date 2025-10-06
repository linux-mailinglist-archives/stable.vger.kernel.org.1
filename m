Return-Path: <stable+bounces-183416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8457BBD884
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 11:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB81189266E
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A2218EA2;
	Mon,  6 Oct 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ro9ABI3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92D21638D;
	Mon,  6 Oct 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744585; cv=none; b=jkHCD7sjXW/9dnOauCZquHJPjpo364qhdSdTHtR+g0gv4tkWaw9sBPi6VB7VHHcoprLWaHjBsqTjcT3lBcleaooMqKC0ZBiUNCFIjfkg8j9T3hW8vryGzzKnRZQ9j7k2vqja/J0zt0urctI/vJ5XUG/pxh0T95jTs6T/otf6EEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744585; c=relaxed/simple;
	bh=gy9Qha3RTHhac0gJatkP7CGUThK4hqe0jUTBS584OxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGX9QYr2Ps8UDfNDoz61U1qQrG2PcFQp9XyCnofx7RfVWaEG0DtTPuO4/EEJvbnPFzplFm9igjoc1HNAfvU+YEYPctcxJWTNC9x5Jmmi9GkhiwQIbhTSHQvmxiBQiNvYEV5MZD+YzTNI8voRMhMx99/5q481EmGRCAVWT1TLWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ro9ABI3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2655C4CEF5;
	Mon,  6 Oct 2025 09:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759744585;
	bh=gy9Qha3RTHhac0gJatkP7CGUThK4hqe0jUTBS584OxU=;
	h=From:To:Cc:Subject:Date:From;
	b=ro9ABI3WlFRyqPtrE7yoctiD4JoIp/iIksYD2udHBfShjAsGVMTUKIhZbLNuLmWIr
	 8/MIQL+Du98GKmjRLnUTUF938jaa1skSGori8IMXHo93iWm2C4S4Lx3yU8lMOCZARx
	 iwJXOUEOE/6WwWqU8lwVkvwdSKE0sqLUeh7u5XB4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.51
Date: Mon,  6 Oct 2025 11:56:17 +0200
Message-ID: <2025100618-chili-criteria-8b18@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.51 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 
 drivers/media/pci/b2c2/flexcop-pci.c  |    2 
 drivers/media/rc/imon.c               |   27 +++++++++---
 drivers/media/tuners/xc5000.c         |    2 
 drivers/media/usb/uvc/uvc_driver.c    |   73 +++++++++++++++++++++-------------
 drivers/media/usb/uvc/uvcvideo.h      |    2 
 drivers/net/wireless/ath/ath11k/qmi.c |    2 
 drivers/target/target_core_configfs.c |    2 
 include/crypto/sha256_base.h          |    2 
 mm/swapfile.c                         |    3 +
 scripts/gcc-plugins/gcc-common.h      |    7 +++
 sound/soc/qcom/qdsp6/topology.c       |    4 -
 12 files changed, 86 insertions(+), 42 deletions(-)

Breno Leitao (1):
      crypto: sha256 - fix crash at kexec

Charan Teja Kalla (1):
      mm: swap: check for stable address space before operating on the VMA

Duoming Zhou (2):
      media: b2c2: Fix use-after-free causing by irq_check_work in flexcop_pci_remove
      media: tuner: xc5000: Fix use-after-free in xc5000_release

Greg Kroah-Hartman (1):
      Linux 6.12.51

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


