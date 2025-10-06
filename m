Return-Path: <stable+bounces-183414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1077EBBD87B
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 11:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A09FE4EA64D
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DEA215F7D;
	Mon,  6 Oct 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2leQsWN5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802522F2D;
	Mon,  6 Oct 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744576; cv=none; b=tWLx2iqkKYSUhDDxevX5X+wVzmwYB6kD+tQXtBmmo92y1MDxFWs+v0V3QNcxZ94+tadt/LoxX2h/oO9nRJCMWEUE8kszRg+HgkiHEicU1aYuNsnb1vymZKk3jrzvn+prJu9JB/FI4zgxId2l9XNJFBLDpvtxyxpk1tFbO8H3REo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744576; c=relaxed/simple;
	bh=vIkgIe26IxUAgcYgLHYqo3xc9nDhBXVeRMoUs72KHIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P0wKGeui6onWkn8967nWknRuR/5F16JNd01bKlg2sDssc7BrR+XVbi34nbQuPGpabbzkvEEHru4mIf4osR8q35d56Dv5cEuTnRyKpP3P4UEMB8SZsVzXMLH9arMdZ0WlfZVFHF0zZv/fSBPOcuOkzeFZbmLEG4oGx2mS8BexEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2leQsWN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55868C113D0;
	Mon,  6 Oct 2025 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759744576;
	bh=vIkgIe26IxUAgcYgLHYqo3xc9nDhBXVeRMoUs72KHIM=;
	h=From:To:Cc:Subject:Date:From;
	b=2leQsWN5tP0VfyWZHrQiFg7XM8+ftuxPGGrzgH+q4rOvY2M8PSas1yuPRuJXDqReJ
	 Ir3esoA2U4Sh3dzaAhAYnluP1PYiDQwrq1x9K6ij7QELAvqPo/Q4FD6kiYyp0ZXYy5
	 ui3FvEvozRVC/a9KE3IRKDAPlSLSE/jtS3GkKzKg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.110
Date: Mon,  6 Oct 2025 11:56:11 +0200
Message-ID: <2025100611-exes-monoxide-33ef@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.110 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 
 drivers/media/pci/b2c2/flexcop-pci.c  |    2 
 drivers/media/rc/imon.c               |   27 +++++++++---
 drivers/media/usb/uvc/uvc_driver.c    |   73 +++++++++++++++++++++-------------
 drivers/media/usb/uvc/uvcvideo.h      |    2 
 drivers/target/target_core_configfs.c |    2 
 include/crypto/sha256_base.h          |    2 
 scripts/gcc-plugins/gcc-common.h      |    7 +++
 sound/soc/qcom/qdsp6/topology.c       |    4 -
 9 files changed, 81 insertions(+), 40 deletions(-)

Breno Leitao (1):
      crypto: sha256 - fix crash at kexec

Duoming Zhou (1):
      media: b2c2: Fix use-after-free causing by irq_check_work in flexcop_pci_remove

Greg Kroah-Hartman (1):
      Linux 6.6.110

Kees Cook (1):
      gcc-plugins: Remove TODO_verify_il for GCC >= 16

Larshin Sergey (1):
      media: rc: fix races with imon_disconnect()

Srinivas Kandagatla (1):
      ASoC: qcom: audioreach: fix potential null pointer dereference

Thadeu Lima de Souza Cascardo (1):
      media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID

Wang Haoran (1):
      scsi: target: target_core_configfs: Add length check to avoid buffer overflow


