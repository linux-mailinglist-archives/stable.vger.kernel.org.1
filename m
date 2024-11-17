Return-Path: <stable+bounces-93693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9B9D044B
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 15:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461811F2177B
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DEC1DB940;
	Sun, 17 Nov 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pIc9ZWHR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992F1DB933;
	Sun, 17 Nov 2024 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853147; cv=none; b=TKvZ7GOYLjQqcI+yTKa7KGk4SRJkXTYRkwNyoCFGJeFh/5IOTCiO4/LHSr0pBV1ai8WOlIsK5YpQrGmp0c6r/KqR+oHGMjQ3IKamXR59EUyo0cPr9CFwx/GPp3B1K3uoU2y87AWCCfG7XI9vr9mFyGqGC/M9hcLdQnLIR1+BkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853147; c=relaxed/simple;
	bh=0ELtMCCohHdMu+rIivsrFyX4Ej2EN7qsETh2vtB4qMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLCUrdKGSnycuI5zUbkgkjH8MuE9Z+kRn257kcRhJKxjnv4ut5OAHieM31TBwmijbGqmEx2ET4elgE/bx5A2obFMTDf2yOHBmPA/LIZ6mbZKRu2qR4+q07PSnEDPWqd8zSSr6R/2yTUWv8i/VlpwsNrkJmu7g2Gtl+64Ti07f1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pIc9ZWHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6546AC4CECD;
	Sun, 17 Nov 2024 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731853146;
	bh=0ELtMCCohHdMu+rIivsrFyX4Ej2EN7qsETh2vtB4qMY=;
	h=From:To:Cc:Subject:Date:From;
	b=pIc9ZWHRRm7PM/Hd3aVjy3UV4XA4hPcK8uT6TO9oYfhPZrSkEjg2/mR6PpB8GG97j
	 atV3wKj9pVoplKiMc5HcQEzobHuUixcj4HB8l6gZfFoJfcSDfgBGrs7euaUPgIur3U
	 iDM87my2KyGQYNEm1RaSQtQ3lrFUzyD6CtQXHQ30=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.62
Date: Sun, 17 Nov 2024 15:18:30 +0100
Message-ID: <2024111731-expend-stray-4ad0@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.62 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/loongarch/include/asm/loongarch.h                  |    2 
 arch/powerpc/platforms/powernv/opal-irqchip.c           |    1 
 arch/riscv/kvm/aia_imsic.c                              |    8 -
 block/elevator.c                                        |    4 
 crypto/algapi.c                                         |    2 
 drivers/crypto/marvell/cesa/hash.c                      |   12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                |    6 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                   |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                    |   26 ++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                     |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                     |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                     |    3 
 drivers/hid/hid-ids.h                                   |    1 
 drivers/hid/hid-lenovo.c                                |    8 +
 drivers/hid/hid-multitouch.c                            |   13 +++
 drivers/infiniband/sw/siw/siw_qp_tx.c                   |    2 
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c              |    4 
 drivers/irqchip/irq-mscc-ocelot.c                       |    4 
 drivers/net/mdio/mdio-bcm-unimac.c                      |    1 
 drivers/net/usb/qmi_wwan.c                              |    1 
 drivers/nvme/host/core.c                                |   52 ++++++------
 drivers/nvme/host/multipath.c                           |   33 +++++++
 drivers/nvme/host/nvme.h                                |    1 
 drivers/nvme/host/tcp.c                                 |    7 -
 drivers/nvme/target/loop.c                              |   13 +++
 drivers/vdpa/ifcvf/ifcvf_base.c                         |    2 
 fs/9p/fid.c                                             |    5 -
 fs/ocfs2/file.c                                         |    9 +-
 fs/smb/client/connect.c                                 |   14 ++-
 include/net/tls.h                                       |   12 ++
 io_uring/io_uring.c                                     |    5 +
 kernel/bpf/syscall.c                                    |   14 ++-
 kernel/bpf/verifier.c                                   |    4 
 mm/filemap.c                                            |    2 
 mm/huge_memory.c                                        |   59 ++++++++------
 mm/hugetlb.c                                            |    1 
 mm/internal.h                                           |   27 ++++++
 mm/memcontrol.c                                         |   29 ++++++
 mm/mempolicy.c                                          |   17 ----
 mm/page_alloc.c                                         |   21 +----
 mm/readahead.c                                          |   11 --
 mm/slab_common.c                                        |    2 
 net/9p/client.c                                         |   12 ++
 net/core/filter.c                                       |    2 
 sound/Kconfig                                           |    2 
 sound/soc/amd/yc/acp6x-mach.c                           |   14 +++
 sound/soc/codecs/rt722-sdca-sdw.c                       |    2 
 sound/soc/fsl/fsl_micfil.c                              |   38 +++++++++
 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c |   67 ++++++++++++++++
 51 files changed, 450 insertions(+), 141 deletions(-)

Alessandro Zanni (1):
      fs: Fix uninitialized value issue in from_kuid and from_kgid

Breno Leitao (1):
      nvme/host: Fix RCU list traversal to use SRCU primitive

Christian Heusel (1):
      ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA

Cyan Yang (1):
      RISCV: KVM: use raw_spinlock for critical section in imsic

Dominique Martinet (1):
      9p: v9fs_fid_find: also lookup by inode if not found dentry

Eduard Zingerman (1):
      selftests/bpf: Verify that sync_linked_regs preserves subreg_def

Greg Joyce (1):
      nvme: disable CC.CRIME (NVME_CC_CRIME)

Greg Kroah-Hartman (1):
      Linux 6.6.62

Hagar Hemdan (1):
      io_uring: fix possible deadlock in io_register_iowq_max_workers()

Hannes Reinecke (1):
      nvme: tcp: avoid race between queue_lock lock and destroy

Hans de Goede (1):
      HID: lenovo: Add support for Thinkpad X1 Tablet Gen 3 keyboard

Herbert Xu (2):
      crypto: api - Fix liveliness check in crypto_alg_tested
      crypto: marvell/cesa - Disable hash algorithms

Hou Tao (1):
      bpf: Check validity of link->type in bpf_link_show_fdinfo()

Hugh Dickins (2):
      mm: add page_rmappable_folio() wrapper
      mm/thp: fix deferred split unqueue naming and locking

Ian Forbes (1):
      drm/vmwgfx: Limit display layout ioctl array size to VMWGFX_NUM_DISPLAY_UNITS

Ilya Dudikov (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS E1404FA

Jack Yu (1):
      ASoC: rt722-sdca: increase clk_stop_timeout to fix clock stop issue

Jiawei Ye (1):
      bpf: Fix mismatched RCU unlock flavour in bpf_out_neigh_v6

Julian Vetter (1):
      sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML

Kefeng Wang (1):
      mm: refactor folio_undo_large_rmappable()

Keith Busch (1):
      nvme-multipath: defer partition scanning

Kenneth Albanowski (1):
      HID: multitouch: Add quirk for Logitech Bolt receiver w/ Casa touchpad

Kuniyuki Iwashima (1):
      smb: client: Fix use-after-free of network namespace.

Linus Torvalds (1):
      9p: fix slab cache name creation for real

Linus Walleij (1):
      net: phy: mdio-bcm-unimac: Add BCM6846 support

Matthew Wilcox (Oracle) (2):
      mm: support order-1 folios in the page cache
      mm: always initialise folio->_deferred_list

Michael Ellerman (1):
      powerpc/powernv: Free name on error in opal_event_init()

Nilay Shroff (2):
      nvme-loop: flush off pending I/O while shutting down loop controller
      nvme: make keep-alive synchronous operation

Pedro Falcato (1):
      9p: Avoid creating multiple slab caches with the same name

Philip Yang (1):
      drm/amdkfd: Accounting pdd vram_usage for svm

Qun-Wei Lin (1):
      mm: krealloc: Fix MTE false alarm in __do_krealloc

Reinhard Speyerer (1):
      net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition

Rik van Riel (1):
      bpf: use kvzmalloc to allocate BPF verifier environment

Robin Murphy (1):
      iommu/arm-smmu: Clarify MMU-500 CPRE workaround

Ryan Roberts (1):
      mm/readahead: do not allow order-1 folio

Sergey Matsievskiy (1):
      irqchip/ocelot: Fix trigger register address

Shengjiu Wang (1):
      ASoC: fsl_micfil: Add sample rate constraint

Showrya M N (1):
      RDMA/siw: Add sendpage_ok() check to disable MSG_SPLICE_PAGES

Stefan Blum (1):
      HID: multitouch: Add support for B2402FVA track point

SurajSonawane2415 (1):
      block: Fix elevator_get_default() checking for NULL q->tag_set

WangYuli (1):
      HID: multitouch: Add quirk for HONOR MagicBook Art 14 touchpad

Yanteng Si (1):
      LoongArch: Use "Exception return address" to comment ERA

Yuan Can (1):
      vDPA/ifcvf: Fix pci_read_config_byte() return code handling

Zijian Zhang (1):
      bpf: Add sk_is_inet and IS_ICSK check in tls_sw_has_ctx_tx/rx


