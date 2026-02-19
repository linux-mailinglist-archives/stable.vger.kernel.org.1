Return-Path: <stable+bounces-217455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FnZH9Ivl2kcvgIAu9opvQ
	(envelope-from <stable+bounces-217455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:44:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1871A160502
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C59B6307B230
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0DE3491C9;
	Thu, 19 Feb 2026 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gf+C9Gyz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADE344D85;
	Thu, 19 Feb 2026 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515676; cv=none; b=Ka8VyEiaZOxR0uK8yVRrrEFsxDSZQd5a+znMAZJyuRG3upj2T/96Tm2iZ0Ll5/j4Vy6z3Yppk4Su8PHggAKbreFZ0lzbIFGG4YEva8HfMGG3SEQO1s/RiEOQ6XiHvc3kmkMjmkf0zC50HRN67vy32OxiVyYnbDeXTocsYerB5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515676; c=relaxed/simple;
	bh=VrySjztjc9edAL/MAa43t3nEa3Vj8r17g7GAnRsuvDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RdgPLLpcyBy8VPamsLvt/rt3YYo2Ktg/0t8109sAjwJd53fOL/qSwLmLm7ccrEdsO6e2317ehn8kL8VXzgeTCA3SSty4De7abcs8KcKojd16gKdfvtGSPeXwJmMOYus0ypiIidFeSfVssztB4qtU66OSnpQDy2fsZH6yIMHNcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gf+C9Gyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E40C4CEF7;
	Thu, 19 Feb 2026 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771515676;
	bh=VrySjztjc9edAL/MAa43t3nEa3Vj8r17g7GAnRsuvDU=;
	h=From:To:Cc:Subject:Date:From;
	b=gf+C9GyzeKqhmzP7d+nG0uRRLLCl18Gx8nPRgT08eyt6WOSoKKuix7N+YIa4S0gOC
	 ukShkRYOV4jn1TS3oxG0a8NOKdweoWbT7FvslDwvgB37U1x9DDADVuoiaSd01nwPdS
	 DyEkhe43LRoJPyP5R9AtZSdHbb567oDFmtGzBb1A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.74
Date: Thu, 19 Feb 2026 16:41:07 +0100
Message-ID: <2026021908-turtle-reverence-60d7@gregkh>
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
	TAGGED_FROM(0.00)[bounces-217455-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1871A160502
X-Rspamd-Action: no action

I'm announcing the release of the 6.12.74 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/loongarch/mm/kasan_init.c                             |   77 +++---
 drivers/bus/fsl-mc/fsl-mc-bus.c                            |   10 
 drivers/gpio/gpio-sprd.c                                   |    8 
 drivers/gpio/gpiolib-acpi-core.c                           |    1 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c     |   30 ++
 drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |    9 
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |   18 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   16 -
 drivers/gpu/drm/tegra/hdmi.c                               |    4 
 drivers/gpu/drm/tegra/sor.c                                |    4 
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c                 |   14 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                 |   14 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c                      |   24 ++
 drivers/iommu/arm/arm-smmu/arm-smmu.h                      |    5 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                  |   13 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h             |    2 
 drivers/net/wireguard/device.c                             |    1 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                  |    7 
 drivers/platform/x86/classmate-laptop.c                    |   32 ++
 drivers/platform/x86/panasonic-laptop.c                    |    4 
 drivers/scsi/qla2xxx/qla_bsg.c                             |   28 +-
 drivers/usb/serial/option.c                                |    6 
 drivers/video/fbdev/riva/riva_hw.c                         |    3 
 drivers/video/fbdev/smscufx.c                              |    8 
 fs/f2fs/data.c                                             |   26 +-
 fs/f2fs/gc.c                                               |    1 
 fs/f2fs/node.c                                             |   14 -
 fs/f2fs/sysfs.c                                            |   62 ++++-
 fs/romfs/super.c                                           |    5 
 include/asm-generic/tlb.h                                  |   77 ++++++
 include/linux/hugetlb.h                                    |   17 -
 include/linux/mm_types.h                                   |    6 
 include/trace/events/dma.h                                 |   25 +-
 kernel/cgroup/cpuset.c                                     |    2 
 mm/hugetlb.c                                               |  146 ++++++-------
 mm/mmu_gather.c                                            |   33 ++
 mm/rmap.c                                                  |   25 +-
 sound/pci/hda/patch_realtek.c                              |   17 +
 sound/soc/amd/yc/acp6x-mach.c                              |   14 +
 sound/soc/codecs/cs35l45.c                                 |    2 
 sound/soc/codecs/cs42l43-jack.c                            |   37 ++-
 sound/soc/fsl/fsl_xcvr.c                                   |    3 
 sound/soc/intel/boards/sof_es8336.c                        |    9 
 45 files changed, 640 insertions(+), 223 deletions(-)

Alban Bedel (1):
      gpiolib: acpi: Fix gpio count with string references

Anatolii Shirykalov (1):
      ASoC: amd: yc: Add ASUS ExpertBook PM1503CDA to quirks list

Anil Gurumurthy (1):
      scsi: qla2xxx: Fix bsg_done() causing double free

Arnd Bergmann (1):
      bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code

Brahmajit Das (1):
      drm/tegra: hdmi: sor: Fix error: variable ‘j’ set but not used

Breno Baptista (1):
      ALSA: hda/realtek: Enable headset mic for Acer Nitro 5

Chao Yu (3):
      f2fs: fix to check sysfs filename w/ gc_pin_file_thresh correctly
      f2fs: fix to avoid mapping wrong physical block for swapfile
      f2fs: fix to avoid UAF in f2fs_write_end_io()

Charles Keepax (1):
      ASoC: cs42l43: Correct handling of 3-pole jack load detection

Chelsy Ratnawat (1):
      bus: fsl-mc: Replace snprintf and sprintf with sysfs_emit in sysfs show functions

Chen Ridong (1):
      cpuset: Fix missing adaptation for cpuset_is_populated

Daniel Borkmann (1):
      Revert "wireguard: device: enable threaded NAPI"

Danilo Krummrich (1):
      iommu/arm-smmu-qcom: do not register driver in probe()

David Hildenbrand (Red Hat) (3):
      mm/hugetlb: fix hugetlb_pmd_shared()
      mm/hugetlb: fix two comments related to huge_pmd_unshare()
      mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather

Deepanshu Kartikey (2):
      romfs: check sb_set_blocksize() return value
      tracing/dma: Cap dma_map_sg tracepoint arrays to prevent buffer overflow

Dirk Su (1):
      ASoC: amd: yc: Add quirk for HP 200 G2a 16

Fabio Porcedda (1):
      USB: serial: option: add Telit FN920C04 RNDIS compositions

Greg Kroah-Hartman (2):
      fbdev: smscufx: properly copy ioctl memory to kernelspace
      Linux 6.12.74

Guangshuo Li (1):
      fbdev: rivafb: fix divide error in nv3_arb()

Gui-Dong Han (1):
      bus: fsl-mc: fix use-after-free in driver_override_show()

Jane Chu (1):
      mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count

Kailang Yang (1):
      ALSA: hda/realtek - fixed speaker no sound

Melissa Wen (2):
      drm/amd/display: extend delta clamping logic to CM3 LUT helper
      drm/amd/display: remove assert around dpp_base replacement

Michael Chan (1):
      bnxt_en: Change FW message timeout warning

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


