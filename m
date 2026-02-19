Return-Path: <stable+bounces-217453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKgEG6cvl2kcvgIAu9opvQ
	(envelope-from <stable+bounces-217453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:43:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DDD1604C2
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F56330789CF
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C83347BC9;
	Thu, 19 Feb 2026 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z43QPvlN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84601346FA7;
	Thu, 19 Feb 2026 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515668; cv=none; b=pOSIN9YcR9JdXp9qeQzbUBlO287OdEYTrbMmRjLLelVYe3lBPFXAKCt29NiFskasgrEtKPYSik5YhUFnqGKhprOLOcJ5zFcyUoSkoRojZ+cLy0o8eiyloE5NqtIj0tyS+DIsLbLj4F28Q7s3oU6fL2+YsbH7ImFmbOAD90oXRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515668; c=relaxed/simple;
	bh=1gtZOoAeceSYUYOmgOJ/1xCSV564pyh+Rjl8xf7NmAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LgQXE3bkYnUsYoqEbnRPXQAD7qFn0Tu8cYzPSzQ8LPtOqkr1WUS9EJWZ6XjqMRtMYQjMIFSJAlrLIAtWlMJ0e1UqM5LrObmJ0brO1t+SKXJOHNIvT15bGo2tTzf7Zz5NNQ1TVi+PpalZmAMlD36b1PmhDtGTdiuG/OXvaYjcbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z43QPvlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52AFC4CEF7;
	Thu, 19 Feb 2026 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771515668;
	bh=1gtZOoAeceSYUYOmgOJ/1xCSV564pyh+Rjl8xf7NmAE=;
	h=From:To:Cc:Subject:Date:From;
	b=z43QPvlNvuZBU1K3KFd789Wxpbh68yRDkTIq4uebJTcQSwp40Cu2oTy25bJ8kpT1h
	 5vPCcalDkV4/gr7XyCrRvQFFyi8tsb6HWq8Dsyh/BpSGxXl7UnsMrD/fLNnDxQwJjA
	 QlmvIfns+X/hFheVWQHQd8RctMlP4zqonYHD4AMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.127
Date: Thu, 19 Feb 2026 16:40:59 +0100
Message-ID: <2026021900-girdle-tacky-35d7@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217453-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7DDD1604C2
X-Rspamd-Action: no action

I'm announcing the release of the 6.6.127 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                  |    2 
 arch/loongarch/include/asm/addrspace.h    |    4 
 arch/loongarch/include/asm/io.h           |   10 +-
 arch/loongarch/include/asm/kasan.h        |   11 ++
 arch/loongarch/include/asm/loongarch.h    |   10 +-
 arch/loongarch/include/asm/stackframe.h   |   11 ++
 arch/loongarch/kernel/head.S              |   11 --
 arch/loongarch/mm/kasan_init.c            |   76 ++++++++-------
 arch/loongarch/power/suspend_asm.S        |    6 -
 drivers/bus/fsl-mc/fsl-mc-bus.c           |   10 +-
 drivers/firmware/efi/libstub/loongarch.c  |    2 
 drivers/gpio/gpio-sprd.c                  |    8 -
 drivers/gpio/gpiolib-acpi.c               |    1 
 drivers/gpu/drm/tegra/hdmi.c              |    4 
 drivers/gpu/drm/tegra/sor.c               |    4 
 drivers/net/bareudp.c                     |    4 
 drivers/net/geneve.c                      |    4 
 drivers/net/wireguard/device.c            |    1 
 drivers/pci/endpoint/pci-ep-cfs.c         |   16 +--
 drivers/platform/x86/amd/pmc/pmc-quirks.c |    7 +
 drivers/platform/x86/classmate-laptop.c   |   32 ++++++
 drivers/platform/x86/panasonic-laptop.c   |    4 
 drivers/scsi/qla2xxx/qla_bsg.c            |   28 +++--
 drivers/usb/serial/option.c               |    6 +
 drivers/video/fbdev/riva/riva_hw.c        |    3 
 drivers/video/fbdev/smscufx.c             |    8 +
 fs/f2fs/data.c                            |   26 +++--
 fs/f2fs/f2fs.h                            |    1 
 fs/f2fs/gc.c                              |    1 
 fs/f2fs/node.c                            |   14 ++
 fs/f2fs/super.c                           |   27 +++++
 fs/f2fs/sysfs.c                           |   60 ++++++++++--
 fs/romfs/super.c                          |    5 -
 include/asm-generic/tlb.h                 |   77 +++++++++++++++
 include/linux/hugetlb.h                   |   17 ++-
 include/linux/mm_types.h                  |    6 +
 include/net/ip_tunnels.h                  |   13 +-
 kernel/cgroup/cpuset.c                    |    2 
 mm/hugetlb.c                              |  146 +++++++++++++++---------------
 mm/mmu_gather.c                           |   33 ++++++
 mm/rmap.c                                 |   25 +++--
 sound/pci/hda/patch_realtek.c             |    5 +
 sound/soc/amd/yc/acp6x-mach.c             |   14 ++
 sound/soc/codecs/cs35l45.c                |    2 
 sound/soc/codecs/cs42l43-jack.c           |   37 ++++++-
 sound/soc/fsl/fsl_xcvr.c                  |    3 
 sound/soc/intel/boards/sof_es8336.c       |    9 +
 47 files changed, 591 insertions(+), 215 deletions(-)

Alban Bedel (1):
      gpiolib: acpi: Fix gpio count with string references

Anatolii Shirykalov (1):
      ASoC: amd: yc: Add ASUS ExpertBook PM1503CDA to quirks list

Anil Gurumurthy (1):
      scsi: qla2xxx: Fix bsg_done() causing double free

Brahmajit Das (1):
      drm/tegra: hdmi: sor: Fix error: variable ‘j’ set but not used

Chao Yu (2):
      f2fs: fix to avoid UAF in f2fs_write_end_io()
      f2fs: fix to avoid mapping wrong physical block for swapfile

Charles Keepax (1):
      ASoC: cs42l43: Correct handling of 3-pole jack load detection

Chelsy Ratnawat (1):
      bus: fsl-mc: Replace snprintf and sprintf with sysfs_emit in sysfs show functions

Chen Ridong (1):
      cpuset: Fix missing adaptation for cpuset_is_populated

Christophe JAILLET (1):
      PCI: endpoint: Remove unused field in struct pci_epf_group

Daniel Borkmann (1):
      Revert "wireguard: device: enable threaded NAPI"

David Hildenbrand (Red Hat) (3):
      mm/hugetlb: fix hugetlb_pmd_shared()
      mm/hugetlb: fix two comments related to huge_pmd_unshare()
      mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather

Deepanshu Kartikey (1):
      romfs: check sb_set_blocksize() return value

Dirk Su (1):
      ASoC: amd: yc: Add quirk for HP 200 G2a 16

Fabio Porcedda (1):
      USB: serial: option: add Telit FN920C04 RNDIS compositions

Greg Kroah-Hartman (2):
      fbdev: smscufx: properly copy ioctl memory to kernelspace
      Linux 6.6.127

Guangshuo Li (1):
      fbdev: rivafb: fix divide error in nv3_arb()

Gui-Dong Han (1):
      bus: fsl-mc: fix use-after-free in driver_override_show()

Huacai Chen (1):
      LoongArch: Add writecombine support for DMW-based ioremap()

Jane Chu (1):
      mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count

Kanglong Wang (1):
      LoongArch: Add WriteCombine shadow mapping in KASAN

Liu Song (1):
      PCI: endpoint: Avoid creating sub-groups asynchronously

Menglong Dong (1):
      net: tunnel: make skb_vlan_inet_prepare() return drop reasons

Rafael J. Wysocki (2):
      platform/x86: classmate-laptop: Add missing NULL pointer checks
      platform/x86: panasonic-laptop: Fix sysfs group leak in error path

Ricardo Rivera-Matos (1):
      ASoC: cs35l45: Corrects ASP_TX5 DAPM widget channel

Tagir Garaev (1):
      ASoC: Intel: sof_es8336: Add DMI quirk for Huawei BOD-WXX9

Tiezhu Yang (1):
      LoongArch: Rework KASAN initialization for PTW-enabled systems

Tim Guttzeit (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6AR55xU

Wenjie Qi (1):
      f2fs: fix zoned block device information initialization

Xuewen Yan (1):
      gpio: sprd: Change sprd_gpio lock to raw_spin_lock

Yongpeng Yang (2):
      f2fs: fix out-of-bounds access in sysfs attribute read/write
      f2fs: fix IS_CHECKPOINTED flag inconsistency issue caused by concurrent atomic commit and checkpoint writes

Zhang Heng (1):
      ALSA: hda/realtek: Add quirk for Inspur S14-G1

Zhiguo Niu (1):
      f2fs: fix to add gc count stat in f2fs_gc_range

Ziyi Guo (1):
      ASoC: fsl_xcvr: fix missing lock in fsl_xcvr_mode_put()

gongqi (1):
      platform/x86/amd/pmc: Add quirk for MECHREVO Wujie 15X Pro


