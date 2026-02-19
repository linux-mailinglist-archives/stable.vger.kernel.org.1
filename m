Return-Path: <stable+bounces-217446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEj0DPktl2kcvgIAu9opvQ
	(envelope-from <stable+bounces-217446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:36:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9716037E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC6863066420
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7CB345CDA;
	Thu, 19 Feb 2026 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZesnFlSE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59943451A7;
	Thu, 19 Feb 2026 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515314; cv=none; b=GPICN8WhgmHCphnw0LY9NN0cm/NG1VKr3WbKRadrWAfJkMJ7NPEduUESDzrQKUGBwws5AWfFiwLeeWns1F3wdIHpcWCCZg1WKRHAb1tc23BHQtevDTiFlRout7LsWz5tQY1VyqQjBzwjHOhJ7jubn46icq9FEPMoES05YzHVLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515314; c=relaxed/simple;
	bh=Hf0U+C649i9iCUY5wtLwe7rbkbnVxbBOjSaldmKsJfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XvvmvkkQJyFn43jfUjTn56E3KlTnB/E/ZnoHEBTDox8Ad6Ejy8EzjVg46G+GvuZcvxU5DcxC9LQmPgVYW/5a9Oy4pCIznporvVOD/MoIbIf+JgG7PvoPeV5zxNLBW3+wtzTMF4Cz9h8dkTtrv0PEAHv5/ZVpSv6mSunWZ3mXuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZesnFlSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4322C116D0;
	Thu, 19 Feb 2026 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771515314;
	bh=Hf0U+C649i9iCUY5wtLwe7rbkbnVxbBOjSaldmKsJfM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZesnFlSEbVTg8SgkvnghYCxbLD/+YhhvPGXKLOQQkCYrGQ/yELV9Gazwts+F1Sv3e
	 HiiLWv05jqSk8lVgEnKhuLFMyDX2jO3ANY1DJnxANos3LYY4Ma3Mp8EeYnXJ6KYmKe
	 lO9YlVdUxwjs3aIkKobvz227nM8YGXRVLmbz6CLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.251
Date: Thu, 19 Feb 2026 16:35:09 +0100
Message-ID: <2026021909-heap-underpay-325a@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217446-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DD9716037E
X-Rspamd-Action: no action

I'm announcing the release of the 5.10.251 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c |    2 
 drivers/crypto/omap-crypto.c                      |    2 
 drivers/crypto/virtio/virtio_crypto_algs.c        |    2 
 drivers/crypto/virtio/virtio_crypto_core.c        |    5 +
 drivers/gpio/gpio-omap.c                          |   22 ++++++--
 drivers/gpio/gpio-sprd.c                          |    8 +--
 drivers/gpio/gpiolib-acpi.c                       |    1 
 drivers/gpu/drm/tegra/hdmi.c                      |    4 -
 drivers/gpu/drm/tegra/sor.c                       |    4 -
 drivers/platform/x86/classmate-laptop.c           |   32 ++++++++++++
 drivers/scsi/qla2xxx/qla_bsg.c                    |    5 +
 drivers/scsi/qla2xxx/qla_gs.c                     |   36 +++++++------
 drivers/scsi/qla2xxx/qla_init.c                   |   19 ++++++-
 drivers/scsi/qla2xxx/qla_isr.c                    |   19 ++++++-
 drivers/scsi/qla2xxx/qla_os.c                     |    3 -
 drivers/usb/serial/option.c                       |    6 ++
 drivers/video/fbdev/riva/riva_hw.c                |    3 +
 drivers/video/fbdev/smscufx.c                     |    8 ++-
 fs/dlm/lock.c                                     |    2 
 fs/f2fs/data.c                                    |   12 +++-
 fs/f2fs/sysfs.c                                   |   58 +++++++++++++++++++---
 fs/nilfs2/sufile.c                                |    4 +
 fs/romfs/super.c                                  |    5 +
 sound/pci/hda/patch_realtek.c                     |    4 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |    2 
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |   11 ++++
 27 files changed, 225 insertions(+), 56 deletions(-)

Alban Bedel (1):
      gpiolib: acpi: Fix gpio count with string references

Alexander Aring (1):
      fs: dlm: fix invalid derefence of sb_lvbptr

Anil Gurumurthy (5):
      scsi: qla2xxx: Delay module unload while fabric scan in progress
      scsi: qla2xxx: Query FW again before proceeding with login
      scsi: qla2xxx: Validate sp before freeing associated memory
      scsi: qla2xxx: Free sp in error path to fix system crash
      scsi: qla2xxx: Fix bsg_done() causing double free

Bibo Mao (2):
      crypto: virtio - Add spinlock protection with virtqueue notification
      crypto: virtio - Remove duplicated virtqueue_kick in virtio_crypto_skcipher_crypt_req

Brahmajit Das (1):
      drm/tegra: hdmi: sor: Fix error: variable ‘j’ set but not used

Chao Yu (1):
      f2fs: fix to avoid UAF in f2fs_write_end_io()

Danilo Krummrich (1):
      gpio: omap: do not register driver in probe()

Deepanshu Kartikey (1):
      romfs: check sb_set_blocksize() return value

Edward Adam Davis (1):
      nilfs2: Fix potential block overflow that cause system hang

Fabio Porcedda (1):
      USB: serial: option: add Telit FN920C04 RNDIS compositions

Greg Kroah-Hartman (2):
      fbdev: smscufx: properly copy ioctl memory to kernelspace
      Linux 5.10.251

Guangshuo Li (1):
      fbdev: rivafb: fix divide error in nv3_arb()

Kees Cook (1):
      crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatterlists correctly

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: pm: ensure unknown flags are ignored

Rafael J. Wysocki (1):
      platform/x86: classmate-laptop: Add missing NULL pointer checks

Thorsten Blum (1):
      crypto: octeontx - Fix length check to avoid truncation in ucode_load_store

Tim Guttzeit (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6AR55xU

Xuewen Yan (1):
      gpio: sprd: Change sprd_gpio lock to raw_spin_lock

Yongpeng Yang (1):
      f2fs: fix out-of-bounds access in sysfs attribute read/write


