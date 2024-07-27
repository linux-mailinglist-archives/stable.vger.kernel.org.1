Return-Path: <stable+bounces-61956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E7E93DE44
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 11:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAFB1F223CF
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5526259164;
	Sat, 27 Jul 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y+NrMA1S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1462255E4C;
	Sat, 27 Jul 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722073332; cv=none; b=N/WNgYIUHHWSZUPT3P03uVRBfFCfQh8SaGaeXcWCcRTvDnmcxeTdQLDTA5IkRMDkeN57XBZTf+3ZBanRmNRxGAM//pJz3PMbquBLN7shKCfY1s/mu1eM8A1nTioU9ajihBt1yApVnZ17z4NVKoADZqYQKbHaISelWA0+MC2x/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722073332; c=relaxed/simple;
	bh=h1kWIwhbznoOkO5pHYVcQdHYlF8NrWzI9RWuaBtw2Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+kmg7Cy7DzK77ShONhQ48NRU+hAiPuRd67Y1N3MF8e9P9rtA1hurSGhyHU/C3Nsts8u78wzJTmXDx6pHs8ASxVykEf5eAMu7mE/+Cx11jDZ2Te12qY+RXrEGucDJwQ81xOC8UIbQ/L/en9cK32sEmr9CZE04S87hHRoyJgwV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y+NrMA1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186ECC32781;
	Sat, 27 Jul 2024 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722073331;
	bh=h1kWIwhbznoOkO5pHYVcQdHYlF8NrWzI9RWuaBtw2Is=;
	h=From:To:Cc:Subject:Date:From;
	b=y+NrMA1SdhAl9hF7Y1awPMV6JCa4FxHIg2KN0Xa3x3Jcj068DbWp5BiPeLpcCYDwA
	 9iumdvN49OyS6XlSOvAqn+aH3a4BFPqqJsbZk37EdxPrJ31EWwEjyKdfUjeEhFZkoi
	 LPLDIhhT4ZQweouUEkmUOUV+gqzFvj1vXfUm3eDY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.102
Date: Sat, 27 Jul 2024 11:42:06 +0200
Message-ID: <2024072707-overbite-recycler-543c@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.102 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                               |    2 -
 arch/arm64/boot/dts/qcom/ipq6018.dtsi  |    1 
 arch/arm64/boot/dts/qcom/msm8996.dtsi  |    1 
 arch/arm64/boot/dts/qcom/sdm630.dtsi   |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |    2 -
 drivers/net/tap.c                      |    5 +++
 drivers/net/tun.c                      |    3 ++
 fs/btrfs/transaction.c                 |    5 ++-
 fs/f2fs/super.c                        |   15 +++++++++-
 fs/jfs/xattr.c                         |   23 +++++++++++++---
 fs/locks.c                             |    9 ++----
 fs/ntfs3/fslog.c                       |    6 +++-
 fs/ocfs2/dir.c                         |   46 ++++++++++++++++++++-------------
 sound/core/pcm_dmaengine.c             |    6 +++-
 sound/pci/hda/patch_realtek.c          |    2 +
 15 files changed, 94 insertions(+), 33 deletions(-)

Chao Yu (1):
      f2fs: avoid dead loop in f2fs_issue_checkpoint()

Dan Carpenter (1):
      drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap_irq()

Dongli Zhang (1):
      tun: add missing verification for short frame

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Positivo SU C1400

Filipe Manana (1):
      btrfs: do not BUG_ON on failure to get dir index for new snapshot

Greg Kroah-Hartman (1):
      Linux 6.1.102

Jann Horn (1):
      filelock: Fix fcntl/close race recovery compat path

Krishna Kurapati (3):
      arm64: dts: qcom: msm8996: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: ipq6018: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sdm630: Disable SS instance in Parkmode for USB

Seunghun Han (1):
      ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book Pro 360

Shengjiu Wang (1):
      ALSA: pcm_dmaengine: Don't synchronize DMA channel when DMA is paused

Si-Wei Liu (1):
      tap: add missing verification for short frame

lei lu (3):
      ocfs2: add bounds checking to ocfs2_check_dir_entry()
      jfs: don't walk off the end of ealist
      fs/ntfs3: Validate ff offset


