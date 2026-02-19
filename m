Return-Path: <stable+bounces-217460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OP4FmIvl2kcvgIAu9opvQ
	(envelope-from <stable+bounces-217460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:42:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD61604A3
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB02330451DA
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7734251F;
	Thu, 19 Feb 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pGqGzSzq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523A344D85;
	Thu, 19 Feb 2026 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515697; cv=none; b=a0pAGUygbQWlsAR3CgTVD5FaJkEoWPlzCRBzZSwbVPEoTRxPyiL8xUDcH2x1akp2WE41lIFg7JTGqGNfIRG8aLa/m3RKl686BT/Ha6y8zIbKXgaiCnwJD2W/NWTA91AhWjCV1Xel0uX4/n2D22ic4vPrTu3rR/JYYMR8YL14jSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515697; c=relaxed/simple;
	bh=aXIe55+2yPoH3GRcGmifqWVVr8C5rTjMjGoSPqfEtrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X2gAreAHFu4x1gIq/GvA2L7SpefWpFh9XW1nn6V/ayTwx5/QH4g6ekxs6nEnwreUjMC5IY/7Y1Ysavq2pNnXzzYQ3u03ikNj4avBMyaAovb+jyCRKfelFztFAuYv8xIpT2SAYjP9krevzB4kKriSoz3acpLbiCjCh69IPHWhKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pGqGzSzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2404BC116C6;
	Thu, 19 Feb 2026 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771515696;
	bh=aXIe55+2yPoH3GRcGmifqWVVr8C5rTjMjGoSPqfEtrE=;
	h=From:To:Cc:Subject:Date:From;
	b=pGqGzSzqApbJXqAJh+1haddKfV3z3RTFyRzHLguwfXNpcsCu7SKkwuPvrqiq4kVbm
	 AIuVuPh6GEcYIjPeOlJ9vUXQM89Fua7LDSQSZePpP4Lw6JuNszSQmcCS2wgQQYNd3J
	 THhqER0lPvf7rM8hkhDe3E91uSGBdlRuX+Rq/i6M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.19.3
Date: Thu, 19 Feb 2026 16:41:21 +0100
Message-ID: <2026021922-possibly-smartness-217f@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217460-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CDDD61604A3
X-Rspamd-Action: no action

I'm announcing the release of the 6.19.3 kernel.

All users of the 6.19 kernel series must upgrade.

The updated 6.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                   |    2 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi   |   37 ++++++++++--
 arch/loongarch/mm/kasan_init.c             |   78 +++++++++++++------------
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c |   14 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |   14 +++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      |   24 +++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |    5 +
 drivers/scsi/qla2xxx/qla_bsg.c             |   28 +++++----
 drivers/usb/serial/option.c                |    6 +
 drivers/video/fbdev/riva/riva_hw.c         |    3 
 drivers/video/fbdev/smscufx.c              |    8 +-
 fs/f2fs/data.c                             |   53 ++++++++++++-----
 fs/f2fs/f2fs.h                             |   69 ++++++++++++++++------
 fs/f2fs/gc.c                               |   24 ++++---
 fs/f2fs/node.c                             |   50 ++++++++++------
 fs/f2fs/node.h                             |    8 --
 fs/f2fs/recovery.c                         |    6 -
 fs/f2fs/segment.c                          |   88 +++++++++++++++--------------
 fs/f2fs/segment.h                          |    9 +-
 fs/f2fs/super.c                            |   64 ++++++---------------
 fs/f2fs/sysfs.c                            |   62 +++++++++++++++++---
 include/linux/f2fs_fs.h                    |   73 ++++++++++++++----------
 22 files changed, 460 insertions(+), 265 deletions(-)

Anil Gurumurthy (1):
      scsi: qla2xxx: Fix bsg_done() causing double free

Chao Yu (6):
      f2fs: fix to check sysfs filename w/ gc_pin_file_thresh correctly
      f2fs: fix to avoid UAF in f2fs_write_end_io()
      f2fs: fix to avoid mapping wrong physical block for swapfile
      Revert "f2fs: block cache/dio write during f2fs_enable_checkpoint()"
      f2fs: fix to do sanity check on node footer in __write_node_folio()
      f2fs: fix to do sanity check on node footer in {read,write}_end_io

Daeho Jeong (2):
      f2fs: support non-4KB block size without packed_ssa feature
      f2fs: fix incomplete block usage in compact SSA summaries

Danilo Krummrich (1):
      iommu/arm-smmu-qcom: do not register driver in probe()

Fabio Porcedda (1):
      USB: serial: option: add Telit FN920C04 RNDIS compositions

Greg Kroah-Hartman (2):
      fbdev: smscufx: properly copy ioctl memory to kernelspace
      Linux 6.19.3

Guangshuo Li (1):
      fbdev: rivafb: fix divide error in nv3_arb()

Otto Pflüger (1):
      arm64: dts: mediatek: mt8183: Add missing endpoint IDs to display graph

Tiezhu Yang (1):
      LoongArch: Rework KASAN initialization for PTW-enabled systems

Yeongjin Gil (1):
      f2fs: optimize f2fs_overwrite_io() for f2fs_iomap_begin

Yongpeng Yang (2):
      f2fs: fix IS_CHECKPOINTED flag inconsistency issue caused by concurrent atomic commit and checkpoint writes
      f2fs: fix out-of-bounds access in sysfs attribute read/write

Zhiguo Niu (1):
      f2fs: fix to add gc count stat in f2fs_gc_range


