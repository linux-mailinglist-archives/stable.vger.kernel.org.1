Return-Path: <stable+bounces-106647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F209FF92C
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 13:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A591882C09
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188451B042F;
	Thu,  2 Jan 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbvTrKUZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A81AB6FA;
	Thu,  2 Jan 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819788; cv=none; b=uslXh5oT5Wgdobdwpsu62KvFiO4fvi/0xZepTvr/2Kx5o0Rg+CvMRLJqelEeoBAhp8VhmGqcQBLs+pPkCfuq8emkexwMoMew8XXPX7m5cXZbaBveQ2qZnEDppshqusW3hUgtkcGIvIa0r27DjzKPsPBO6xGA8Cg5GNP86NFEhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819788; c=relaxed/simple;
	bh=2vo/LZkCBio/o3rKqnzx2i87TQLZRTF35NYHESJdK1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iw3wzczrhqf1UDdbjTQBTYS7vGVOQ1hZ4P9SnH0HchOBU8hMMyhj2y5stBb7ed5DrMSzuXv11iKiQ/9MO097p0y/Lx/94emsl6g05uHlDlj/GXxBQ/cjNz0DZByPaLV/Mz2FZe5gahJRomzIYPqmiVHWx9ekRhqKd5fSvOmntOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbvTrKUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AF6C4CED0;
	Thu,  2 Jan 2025 12:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735819788;
	bh=2vo/LZkCBio/o3rKqnzx2i87TQLZRTF35NYHESJdK1E=;
	h=From:To:Cc:Subject:Date:From;
	b=WbvTrKUZc1kxbmEo+fT5MXcT0c2yqrmhkvJZtpUegpjJTdJtvV3NuTLo1Qa4FRLPT
	 0nUzVBS/uBUhtMj2E3Y9bzFqjM1q9bPdTlVgfxPrt0KIqKnx0y12TDrBFvnLGE/1rc
	 iChoVnTT7Husr1YCt343QV/Go53Yq8ApYfxg4ngk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.69
Date: Thu,  2 Jan 2025 13:09:39 +0100
Message-ID: <2025010240-carmaker-wincing-b67a@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.69 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                              |    2 
 arch/loongarch/include/asm/inst.h                     |   12 +
 arch/loongarch/kernel/efi.c                           |    2 
 arch/loongarch/kernel/inst.c                          |    2 
 arch/loongarch/net/bpf_jit.c                          |    6 
 arch/mips/Makefile                                    |    2 
 arch/mips/include/asm/mipsregs.h                      |   13 +
 arch/powerpc/platforms/book3s/vas-api.c               |   36 +++++
 arch/x86/include/asm/intel-family.h                   |   87 ++++++++++++
 arch/x86/include/asm/processor.h                      |   20 ++
 arch/x86/kernel/cpu/intel.c                           |  118 ++++++++---------
 arch/x86/kernel/cpu/match.c                           |    3 
 block/blk-mq.c                                        |  119 +++++++++++++++--
 drivers/base/power/domain.c                           |    1 
 drivers/base/regmap/regmap.c                          |    4 
 drivers/block/virtio_blk.c                            |    7 -
 drivers/dma/apple-admac.c                             |    7 -
 drivers/dma/at_xdmac.c                                |    2 
 drivers/dma/dw/acpi.c                                 |    6 
 drivers/dma/dw/internal.h                             |    8 +
 drivers/dma/dw/pci.c                                  |    4 
 drivers/dma/fsl-edma-common.h                         |    1 
 drivers/dma/fsl-edma-main.c                           |   41 +++++-
 drivers/dma/mv_xor.c                                  |    2 
 drivers/dma/tegra186-gpc-dma.c                        |   10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c            |   22 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h            |    2 
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c                 |   14 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c                 |    9 -
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c                 |    8 -
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                 |   28 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |   15 ++
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c          |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c         |   21 +--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c          |   32 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c       |   63 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              |   43 ++----
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c             |   44 ++----
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h       |   14 --
 drivers/gpu/drm/display/drm_dp_mst_topology.c         |   24 ++-
 drivers/i2c/busses/i2c-imx.c                          |    1 
 drivers/i2c/busses/i2c-microchip-corei2c.c            |  122 +++++++++++++-----
 drivers/media/dvb-frontends/dib3000mb.c               |    2 
 drivers/mtd/nand/raw/arasan-nand-controller.c         |   11 +
 drivers/mtd/nand/raw/atmel/pmecc.c                    |    4 
 drivers/mtd/nand/raw/diskonchip.c                     |    2 
 drivers/pci/msi/irqdomain.c                           |    7 -
 drivers/pci/msi/msi.c                                 |    4 
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c     |    6 
 drivers/phy/phy-core.c                                |   21 +--
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c               |    2 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c    |    2 
 drivers/platform/x86/asus-nb-wmi.c                    |    1 
 drivers/power/supply/gpio-charger.c                   |    8 +
 drivers/scsi/megaraid/megaraid_sas_base.c             |    5 
 drivers/scsi/mpt3sas/mpt3sas_base.c                   |    7 -
 drivers/scsi/qla1280.h                                |   12 -
 drivers/scsi/storvsc_drv.c                            |    7 -
 drivers/spi/spi-intel-pci.c                           |    2 
 drivers/spi/spi-omap2-mcspi.c                         |    6 
 drivers/watchdog/it87_wdt.c                           |   39 +++++
 drivers/watchdog/mtk_wdt.c                            |    6 
 fs/btrfs/inode.c                                      |    2 
 fs/btrfs/sysfs.c                                      |    6 
 fs/ceph/addr.c                                        |    4 
 fs/ceph/file.c                                        |   43 +++---
 fs/ceph/super.h                                       |   14 ++
 fs/nfsd/export.c                                      |   31 ----
 fs/nfsd/export.h                                      |    4 
 fs/nfsd/nfs4callback.c                                |    4 
 fs/smb/server/smb_common.c                            |    4 
 fs/udf/namei.c                                        |    6 
 include/linux/ceph/osd_client.h                       |    7 -
 include/linux/sched.h                                 |    3 
 include/linux/sched/task_stack.h                      |    2 
 include/linux/skmsg.h                                 |   11 +
 include/linux/trace_events.h                          |    2 
 include/linux/vmstat.h                                |    2 
 include/net/sock.h                                    |   10 +
 include/uapi/linux/stddef.h                           |   13 +
 io_uring/sqpoll.c                                     |    6 
 kernel/trace/trace.c                                  |    3 
 kernel/trace/trace_kprobe.c                           |    2 
 net/ceph/osd_client.c                                 |    2 
 net/core/filter.c                                     |   21 ++-
 net/core/skmsg.c                                      |    6 
 net/ipv4/tcp_bpf.c                                    |    6 
 sound/pci/hda/patch_conexant.c                        |   28 ++++
 sound/pci/hda/patch_realtek.c                         |    7 +
 sound/sh/sh_dac_audio.c                               |    5 
 tools/include/uapi/linux/stddef.h                     |   15 +-
 91 files changed, 977 insertions(+), 426 deletions(-)

Aapo Vienamo (1):
      spi: intel: Add Panther Lake SPI controller support

Akhil R (1):
      dmaengine: tegra: Return correct DMA status when paused

Alex Deucher (5):
      drm/amdgpu/hdp4.0: do a posting read when flushing HDP
      drm/amdgpu/hdp5.0: do a posting read when flushing HDP
      drm/amdgpu/hdp6.0: do a posting read when flushing HDP
      drm/amdkfd: reduce stack size in kfd_topology_add_device()
      drm/amdkfd: drop struct kfd_cu_info

Alexander Lobakin (1):
      stddef: make __struct_group() UAPI C++-friendly

Andrew Cooper (1):
      x86/cpu/intel: Drop stray FAM6 check with new Intel CPU model defines

Andy Shevchenko (1):
      dmaengine: dw: Select only supported masters for ACPI devices

Armin Wolf (1):
      platform/x86: asus-nb-wmi: Ignore unknown event 0xCF

Bart Van Assche (1):
      mm/vmstat: fix a W=1 clang compiler warning

Brahmajit Das (1):
      smb: server: Fix building with GCC 15

Carlos Song (1):
      i2c: imx: add imx7d compatible string for applying erratum ERR007805

Cathy Avery (1):
      scsi: storvsc: Do not flag MAINTENANCE_IN return of SRB_STATUS_DATA_OVERRUN as an error

Chen Ridong (2):
      dmaengine: at_xdmac: avoid null_prt_deref in at_xdmac_prep_dma_memset
      freezer, sched: Report frozen tasks as 'D' instead of 'R'

Chris Chiu (1):
      ALSA: hda/realtek: fix micmute LEDs don't work on HP Laptops

Christian Göttsche (1):
      tracing: Constify string literal data member in struct trace_event_call

Chukun Pan (1):
      phy: rockchip: naneng-combphy: fix phy reset

Colin Ian King (1):
      ALSA: hda/realtek: Fix spelling mistake "Firelfy" -> "Firefly"

Cong Wang (2):
      tcp_bpf: Charge receive socket buffer in bpf_tcp_ingress()
      bpf: Check negative offsets in __bpf_skb_min_len()

Conor Dooley (2):
      i2c: microchip-core: actually use repeated sends
      i2c: microchip-core: fix "ghost" detections

Dan Carpenter (1):
      mtd: rawnand: fix double free in atmel_pmecc_create_user()

Dimitri Fedrau (1):
      power: supply: gpio-charger: Fix set charge current limits

Dirk Su (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook X G1i

Filipe Manana (1):
      btrfs: avoid monopolizing a core when activating a swap file

Greg Kroah-Hartman (1):
      Linux 6.6.69

Haren Myneni (1):
      powerpc/pseries/vas: Add close() callback in vas_vm_ops struct

Huacai Chen (1):
      LoongArch: Fix reserving screen info memory for above-4G firmware

Ilya Dryomov (2):
      ceph: fix memory leak in ceph_direct_read_write()
      ceph: allocate sparse_ext map only for sparse reads

Imre Deak (1):
      drm/dp_mst: Ensure mst_primary pointer is valid in drm_dp_mst_handle_up_req()

James Hilliard (1):
      watchdog: it87_wdt: add PWRGD enable quirk for Qotom QCML04

Jan Kara (1):
      udf: Skip parent dir link count update if corrupted

Javier Carrasco (1):
      dmaengine: mv_xor: fix child node refcount handling in early exit

Jesse.zhang@amd.com (1):
      drm/amdkfd: pause autosuspend when creating pdd

Jiaxun Yang (2):
      MIPS: Probe toolchain support of -msym32
      MIPS: mipsregs: Set proper ISA level for virt extensions

Joe Hattori (1):
      dmaengine: fsl-edma: implement the cleanup path of fsl_edma3_attach_pd()

Justin Chen (1):
      phy: usb: Toggle the PHY power during init

Krishna Kurapati (1):
      phy: qcom-qmp: Fix register name in RX Lane config of SC8280XP

Len Brown (1):
      x86/cpu: Add Lunar Lake to list of CPUs with a broken MONITOR implementation

Lijo Lazar (1):
      drm/amdkfd: Use device based logging for errors

Lizhi Xu (1):
      tracing: Prevent bad count for tracing_cpumask_write

Maciej Andrzejewski (2):
      mtd: rawnand: arasan: Fix double assertion of chip-select
      mtd: rawnand: arasan: Fix missing de-registration of NAND

Magnus Lindholm (1):
      scsi: qla1280: Fix hw revision numbering for ISP1020/1040

Mark Brown (1):
      regmap: Use correct format specifier for logging range errors

Masami Hiramatsu (Google) (1):
      tracing/kprobe: Make trace_kprobe's module callback called after jump_label update

Ming Lei (4):
      virtio-blk: don't keep queue frozen during system suspend
      blk-mq: register cpuhp callback after hctx is added to xarray table
      blk-mq: move cpuhp callback registering out of q->sysfs_lock
      block: avoid to reuse `hctx` not removed from cpuhp callback list

NeilBrown (1):
      nfsd: restore callback functionality for NFSv4.0

Nikita Zhandarovich (1):
      media: dvb-frontends: dib3000mb: fix uninit-value in dib3000_write_reg

Pavel Begunkov (1):
      io_uring/sqpoll: fix sqpoll error handling races

Purushothama Siddaiah (1):
      spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()

Qu Wenruo (1):
      btrfs: sysfs: fix direct super block member reads

Qun-Wei Lin (1):
      sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers

Ranjan Kumar (1):
      scsi: mpt3sas: Diag-Reset when Doorbell-In-Use bit is set during driver load time

Sasha Finkelstein (1):
      dmaengine: apple-admac: Avoid accessing registers in probe

Takashi Iwai (2):
      ALSA: sh: Use standard helper for buffer accesses
      ALSA: sh: Fix wrong argument order for copy_from_iter()

Thomas Gleixner (1):
      PCI/MSI: Handle lack of irqdomain gracefully

Tiezhu Yang (1):
      LoongArch: BPF: Adjust the parameter of emit_jirl()

Tomas Henzl (1):
      scsi: megaraid_sas: Fix for a potential deadlock

Tony Luck (5):
      x86/cpu: Add model number for Intel Clearwater Forest processor
      x86/cpu: Add model number for another Intel Arrow Lake mobile processor
      x86/cpu/vfm: Add/initialize x86_vfm field to struct cpuinfo_x86
      x86/cpu/vfm: Update arch/x86/include/asm/intel-family.h
      x86/cpu/intel: Switch to new Intel CPU model defines

Ulf Hansson (1):
      pmdomain: core: Add missing put_device()

Victor Zhao (1):
      drm/amd/amdgpu: allow use kiq to do hdp flush under sriov

Xiubo Li (1):
      ceph: try to allocate a smaller extent map for sparse read

Yang Erkun (1):
      nfsd: Revert "nfsd: release svc_expkey/svc_export with rcu_work"

Yassine Oudjana (1):
      watchdog: mediatek: Add support for MT6735 TOPRGU/WDT

Zichen Xie (1):
      mtd: diskonchip: Cast an operand to prevent potential overflow

Zijian Zhang (1):
      tcp_bpf: Add sk_rmem_alloc related logic for tcp_bpf ingress redirection

Zijun Hu (5):
      phy: core: Fix an OF node refcount leakage in _of_phy_get()
      phy: core: Fix an OF node refcount leakage in of_phy_provider_lookup()
      phy: core: Fix that API devm_phy_put() fails to release the phy
      phy: core: Fix that API devm_of_phy_provider_unregister() fails to unregister the phy provider
      phy: core: Fix that API devm_phy_destroy() fails to destroy the phy

bo liu (1):
      ALSA: hda/conexant: fix Z60MR100 startup pop issue


