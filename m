Return-Path: <stable+bounces-217457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGFFGEIvl2kcvgIAu9opvQ
	(envelope-from <stable+bounces-217457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:41:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB859160476
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42EE03015852
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB25C29A1;
	Thu, 19 Feb 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QugEEboc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D9347BC9;
	Thu, 19 Feb 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515684; cv=none; b=IkCxxHJ/FBzBh6gvEr7IKlSVAjRmMl5PIDXsRY15E6f9iC1+XENdZUH+N6NsN/TjNfsKbHqC+wg511B5x/FqEamJivEdEu0FHvZTHARBk71pROuEzXd+JhiGSsJJSkEdiBjCjPLixUNiYIyLKT0jqLtcDk5Dv3Tih157KYfaM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515684; c=relaxed/simple;
	bh=jaP2csTEdapq1Uk5ZiVnS9+xDrO0ucXG65Q4GqScVtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P8FdXnNVkdVgaEtVevhk8SOcOCRfghCnFTK8u2xolE+2WrsYPvnhkjxM2XdtP+YASdBr3hduGk/vF+R52VLHiQ9y9BL2plnG/sEMHkEnqgv7nyKJzuaRprGUylbb1aSlU3QwRvG6+O3tdwUiaG5cugot/489VeiSbA7uKwrQ9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QugEEboc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F51C116C6;
	Thu, 19 Feb 2026 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771515684;
	bh=jaP2csTEdapq1Uk5ZiVnS9+xDrO0ucXG65Q4GqScVtk=;
	h=From:To:Cc:Subject:Date:From;
	b=QugEEbocSTkNp3OYrPDS7E9SIHxlusFlmXj/6OlLNX33D2/Bse9RsIZbzCkxeKSHO
	 qFgBxYaXuwEJ1babehT4ZxytExsY/aAhoa2hJvOlzYN+Zsy3EBhLzyvZWQlw5Hlxku
	 wLNGf6O0X+MTlwHDV6oMnhOOh3uR7McJJRBIYmd8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.13
Date: Thu, 19 Feb 2026 16:41:15 +0100
Message-ID: <2026021916-angles-obsessive-0ffe@gregkh>
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
	TAGGED_FROM(0.00)[bounces-217457-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: CB859160476
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.13 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                   |   37 +++
 arch/loongarch/mm/kasan_init.c                             |   78 ++++----
 drivers/gpio/gpio-sprd.c                                   |    8 
 drivers/gpio/gpiolib-acpi-core.c                           |    1 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c     |   30 ++-
 drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |    9 
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |   18 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   16 -
 drivers/gpu/drm/tegra/hdmi.c                               |    4 
 drivers/gpu/drm/tegra/sor.c                                |    4 
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c                 |   14 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                 |   14 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c                      |   24 ++
 drivers/iommu/arm/arm-smmu/arm-smmu.h                      |    5 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                  |    7 
 drivers/platform/x86/classmate-laptop.c                    |   32 +++
 drivers/platform/x86/panasonic-laptop.c                    |    4 
 drivers/scsi/qla2xxx/qla_bsg.c                             |   28 +-
 drivers/usb/serial/option.c                                |    6 
 drivers/video/fbdev/riva/riva_hw.c                         |    3 
 drivers/video/fbdev/smscufx.c                              |    8 
 fs/f2fs/data.c                                             |   51 +++--
 fs/f2fs/f2fs.h                                             |   66 +++++-
 fs/f2fs/gc.c                                               |   24 +-
 fs/f2fs/node.c                                             |   50 +++--
 fs/f2fs/node.h                                             |    8 
 fs/f2fs/recovery.c                                         |    6 
 fs/f2fs/segment.c                                          |   88 ++++-----
 fs/f2fs/segment.h                                          |    9 
 fs/f2fs/super.c                                            |   26 +-
 fs/f2fs/sysfs.c                                            |   62 +++++-
 fs/romfs/super.c                                           |    5 
 include/asm-generic/tlb.h                                  |   77 +++++++-
 include/linux/f2fs_fs.h                                    |   73 ++++---
 include/linux/hugetlb.h                                    |   15 +
 include/linux/mm_types.h                                   |    1 
 include/trace/events/dma.h                                 |   25 ++
 io_uring/fdinfo.c                                          |   11 -
 kernel/cgroup/cpuset.c                                     |    2 
 mm/hugetlb.c                                               |  123 +++++++------
 mm/mmu_gather.c                                            |   33 +++
 mm/rmap.c                                                  |   25 +-
 rust/kernel/device.rs                                      |    6 
 rust/kernel/dma.rs                                         |    5 
 rust/kernel/driver.rs                                      |   12 -
 sound/hda/codecs/realtek/alc269.c                          |   13 +
 sound/soc/amd/yc/acp6x-mach.c                              |   14 +
 sound/soc/codecs/cs35l45.c                                 |    2 
 sound/soc/codecs/cs42l43-jack.c                            |   37 +++
 sound/soc/fsl/fsl_xcvr.c                                   |    3 
 sound/soc/intel/boards/sof_es8336.c                        |    9 
 sound/soc/intel/boards/sof_sdw.c                           |    1 
 54 files changed, 877 insertions(+), 359 deletions(-)

Alban Bedel (1):
      gpiolib: acpi: Fix gpio count with string references

Alice Ryhl (1):
      rust: driver: fix broken intra-doc links to example driver types

Anatolii Shirykalov (1):
      ASoC: amd: yc: Add ASUS ExpertBook PM1503CDA to quirks list

Anil Gurumurthy (1):
      scsi: qla2xxx: Fix bsg_done() causing double free

Brahmajit Das (1):
      drm/tegra: hdmi: sor: Fix error: variable ‘j’ set but not used

Breno Baptista (1):
      ALSA: hda/realtek: Enable headset mic for Acer Nitro 5

Chao Yu (5):
      f2fs: fix to check sysfs filename w/ gc_pin_file_thresh correctly
      f2fs: fix to avoid UAF in f2fs_write_end_io()
      f2fs: fix to avoid mapping wrong physical block for swapfile
      f2fs: fix to do sanity check on node footer in __write_node_folio()
      f2fs: fix to do sanity check on node footer in {read,write}_end_io

Charles Keepax (1):
      ASoC: cs42l43: Correct handling of 3-pole jack load detection

Chen Ridong (1):
      cpuset: Fix missing adaptation for cpuset_is_populated

Daeho Jeong (2):
      f2fs: support non-4KB block size without packed_ssa feature
      f2fs: fix incomplete block usage in compact SSA summaries

Danilo Krummrich (1):
      iommu/arm-smmu-qcom: do not register driver in probe()

David Hildenbrand (Red Hat) (1):
      mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather

Deepanshu Kartikey (2):
      romfs: check sb_set_blocksize() return value
      tracing/dma: Cap dma_map_sg tracepoint arrays to prevent buffer overflow

Dirk Su (1):
      ASoC: amd: yc: Add quirk for HP 200 G2a 16

FUJITA Tomonori (2):
      rust: device: fix broken intra-doc links
      rust: dma: fix broken intra-doc links

Fabio Porcedda (1):
      USB: serial: option: add Telit FN920C04 RNDIS compositions

Greg Kroah-Hartman (2):
      fbdev: smscufx: properly copy ioctl memory to kernelspace
      Linux 6.18.13

Guangshuo Li (1):
      fbdev: rivafb: fix divide error in nv3_arb()

Jens Axboe (1):
      io_uring/fdinfo: be a bit nicer when looping a lot of SQEs/CQEs

Kailang Yang (1):
      ALSA: hda/realtek - fixed speaker no sound

Maciej Strozek (1):
      ASoC: sof_sdw: Add a quirk for Lenovo laptop using sidecar amps with cs42l43

Melissa Wen (2):
      drm/amd/display: extend delta clamping logic to CM3 LUT helper
      drm/amd/display: remove assert around dpp_base replacement

Otto Pflüger (1):
      arm64: dts: mediatek: mt8183: Add missing endpoint IDs to display graph

Rafael J. Wysocki (2):
      platform/x86: classmate-laptop: Add missing NULL pointer checks
      platform/x86: panasonic-laptop: Fix sysfs group leak in error path

Ricardo Rivera-Matos (1):
      ASoC: cs35l45: Corrects ASP_TX5 DAPM widget channel

Tagir Garaev (1):
      ASoC: Intel: sof_es8336: Add DMI quirk for Huawei BOD-WXX9

Tiezhu Yang (1):
      LoongArch: Rework KASAN initialization for PTW-enabled systems

Xuewen Yan (1):
      gpio: sprd: Change sprd_gpio lock to raw_spin_lock

Yeongjin Gil (1):
      f2fs: optimize f2fs_overwrite_io() for f2fs_iomap_begin

Yongpeng Yang (2):
      f2fs: fix IS_CHECKPOINTED flag inconsistency issue caused by concurrent atomic commit and checkpoint writes
      f2fs: fix out-of-bounds access in sysfs attribute read/write

Zhang Heng (1):
      ALSA: hda/realtek: Add quirk for Inspur S14-G1

Zhiguo Niu (1):
      f2fs: fix to add gc count stat in f2fs_gc_range

Ziyi Guo (1):
      ASoC: fsl_xcvr: fix missing lock in fsl_xcvr_mode_put()

gongqi (1):
      platform/x86/amd/pmc: Add quirk for MECHREVO Wujie 15X Pro


