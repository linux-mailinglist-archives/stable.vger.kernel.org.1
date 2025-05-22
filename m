Return-Path: <stable+bounces-146091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A075AC0C63
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 15:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD571681C8
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3BB28C2B1;
	Thu, 22 May 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZbOut0n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F128C015;
	Thu, 22 May 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919528; cv=none; b=boRCFm5Cvbxt5eHBiaE300xF6EqxK83eD31mSI0MFvYZeAQ8wLHBHvCQaUGF0wAdIX/zqEEkD156nnBmL3ay6AD+P9BLkOMHyAswQK8E7yJe+sAsxcwQT6vXkS8liGiUk5T1/2/F9TheKAcWIZ7brybV06hq8TiGpVtArPFDaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919528; c=relaxed/simple;
	bh=4bre8hQ18c1hc5Q1OvsMab2/ojyrmCwo5GOTYo4KRzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2BIp8BOX/+kXlYpqxrKVaq3T5/loU1fApJQ6WLdcomCB/0VHk95UgU+nRssJdZOO1hZyK0ii++6VuS2ULGQmSjSNsLuLzJ8J7wgJZgpeunyUXahhNpWO1ozL2G4PBYxLM2Ta4l+wB2D5XPpTn7NSj4XiljkZlZx5YoLfR9IvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZbOut0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C276AC4CEED;
	Thu, 22 May 2025 13:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747919528;
	bh=4bre8hQ18c1hc5Q1OvsMab2/ojyrmCwo5GOTYo4KRzk=;
	h=From:To:Cc:Subject:Date:From;
	b=RZbOut0nIEJzBX2KaLv6vCHD3AF3ko8fI4SnA1cd4FbC9coJUO9UcbRMVmjTrSBz4
	 tCiYX15HUu5jHh8QJiHbqDpKLe7/Y4H3mTGg1erIqBAh9KJnhKayc/RMwhnSBI8z7J
	 MiJ2Nkby3RQlAv3KxYi6pZ9KNrxoHDoYSfafgXlo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.92
Date: Thu, 22 May 2025 15:11:51 +0200
Message-ID: <2025052252-unsure-commotion-9de5@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.92 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/arm64/net/bpf_jit_comp.c                               |   12 
 arch/loongarch/Makefile                                     |    2 
 arch/loongarch/include/asm/ptrace.h                         |    2 
 arch/loongarch/include/asm/uprobes.h                        |    1 
 arch/loongarch/kernel/kfpu.c                                |   22 
 arch/loongarch/kernel/time.c                                |    2 
 arch/loongarch/kernel/uprobes.c                             |   11 
 arch/loongarch/power/hibernate.c                            |    3 
 arch/x86/kernel/alternative.c                               |   17 
 arch/x86/kvm/smm.c                                          |    1 
 arch/x86/kvm/svm/svm.c                                      |   19 
 block/bio.c                                                 |    2 
 drivers/acpi/pptt.c                                         |   11 
 drivers/bluetooth/btnxpuart.c                               |    6 
 drivers/char/tpm/tpm_tis_core.h                             |    2 
 drivers/dma-buf/dma-resv.c                                  |    5 
 drivers/dma/dmatest.c                                       |    6 
 drivers/dma/idxd/init.c                                     |  159 ++++--
 drivers/dma/ti/k3-udma.c                                    |   10 
 drivers/firmware/arm_scmi/Kconfig                           |   14 
 drivers/firmware/arm_scmi/common.h                          |   35 +
 drivers/firmware/arm_scmi/driver.c                          |   89 +++
 drivers/firmware/arm_scmi/mailbox.c                         |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                         |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                  |   51 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                     |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                    |   29 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h                    |    3 
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c                       |    2 
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c                       |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |   16 
 drivers/hid/hid-thrustmaster.c                              |    1 
 drivers/hid/hid-uclogic-core.c                              |    7 
 drivers/hv/channel.c                                        |   65 --
 drivers/iio/adc/ad7266.c                                    |    2 
 drivers/iio/adc/ad7768-1.c                                  |    2 
 drivers/iio/chemical/sps30.c                                |    2 
 drivers/infiniband/sw/rxe/rxe_cq.c                          |    5 
 drivers/net/dsa/sja1105/sja1105_main.c                      |    6 
 drivers/net/ethernet/cadence/macb_main.c                    |   19 
 drivers/net/ethernet/engleder/tsnep_hw.h                    |    2 
 drivers/net/ethernet/engleder/tsnep_main.c                  |  131 ++++-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c             |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c   |    3 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                 |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c           |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c       |    3 
 drivers/net/ethernet/qlogic/qede/qede_main.c                |    2 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c    |    7 
 drivers/net/hyperv/hyperv_net.h                             |   13 
 drivers/net/hyperv/netvsc.c                                 |   57 ++
 drivers/net/hyperv/netvsc_drv.c                             |   62 --
 drivers/net/hyperv/rndis_filter.c                           |   24 -
 drivers/net/wireless/mediatek/mt76/dma.c                    |    1 
 drivers/nvme/host/pci.c                                     |    4 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                    |   40 -
 drivers/phy/tegra/xusb-tegra186.c                           |   46 +-
 drivers/phy/tegra/xusb.c                                    |    8 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                   |    7 
 drivers/platform/x86/asus-wmi.c                             |    3 
 drivers/regulator/max20086-regulator.c                      |    7 
 drivers/scsi/sd_zbc.c                                       |    6 
 drivers/scsi/storvsc_drv.c                                  |    1 
 drivers/spi/spi-loopback-test.c                             |    2 
 drivers/spi/spi-tegra114.c                                  |    6 
 drivers/usb/gadget/function/f_midi2.c                       |    2 
 drivers/usb/typec/ucsi/displayport.c                        |   19 
 drivers/usb/typec/ucsi/ucsi.c                               |   34 +
 drivers/usb/typec/ucsi/ucsi.h                               |    2 
 fs/binfmt_elf.c                                             |  273 ++++++------
 fs/btrfs/extent-tree.c                                      |   25 -
 fs/nfs/nfs4proc.c                                           |    9 
 fs/nfs/pnfs.c                                               |    9 
 fs/smb/client/smb2pdu.c                                     |    2 
 fs/udf/truncate.c                                           |    2 
 fs/xattr.c                                                  |   24 +
 include/linux/bio.h                                         |    1 
 include/linux/hyperv.h                                      |    7 
 include/linux/tpm.h                                         |    2 
 include/net/sch_generic.h                                   |   15 
 include/sound/ump_msg.h                                     |    4 
 kernel/cgroup/cpuset.c                                      |    6 
 kernel/trace/trace_dynevent.c                               |   16 
 kernel/trace/trace_dynevent.h                               |    1 
 kernel/trace/trace_events_trigger.c                         |    2 
 kernel/trace/trace_functions.c                              |    6 
 kernel/trace/trace_kprobe.c                                 |    2 
 kernel/trace/trace_probe.c                                  |    9 
 kernel/trace/trace_uprobe.c                                 |    2 
 mm/memblock.c                                               |    9 
 mm/memory_hotplug.c                                         |    6 
 mm/migrate.c                                                |   16 
 mm/page_alloc.c                                             |   27 -
 net/bluetooth/mgmt.c                                        |    9 
 net/mac80211/main.c                                         |    6 
 net/mctp/device.c                                           |   65 +-
 net/mctp/route.c                                            |    4 
 net/sched/sch_codel.c                                       |    2 
 net/sched/sch_fq.c                                          |    2 
 net/sched/sch_fq_codel.c                                    |    2 
 net/sched/sch_fq_pie.c                                      |    2 
 net/sched/sch_hhf.c                                         |    2 
 net/sched/sch_pie.c                                         |    2 
 net/sctp/sysctl.c                                           |    4 
 net/tls/tls_strp.c                                          |    3 
 samples/ftrace/sample-trace-array.c                         |    2 
 sound/core/seq/seq_clientmgr.c                              |   52 +-
 sound/core/seq/seq_ump_convert.c                            |   18 
 sound/core/seq/seq_ump_convert.h                            |    1 
 sound/pci/es1968.c                                          |    6 
 sound/sh/Kconfig                                            |    2 
 sound/usb/quirks.c                                          |    4 
 tools/net/ynl/ethtool.py                                    |   29 +
 tools/testing/selftests/exec/Makefile                       |   19 
 tools/testing/selftests/exec/load_address.c                 |   83 ++-
 tools/testing/selftests/mm/compaction_test.c                |   19 
 118 files changed, 1290 insertions(+), 689 deletions(-)

Aaron Kling (1):
      spi: tegra114: Use value to check for invalid delays

Abdun Nihaal (1):
      qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()

Alex Deucher (2):
      Revert "drm/amd: Stop evicting resources on APUs in suspend"
      drm/amdgpu: fix pm notifier handling

Andrei Kuchynski (1):
      usb: typec: ucsi: displayport: Fix deadlock

Andrew Jeffery (1):
      net: mctp: Ensure keys maintain only one ref to corresponding dev

Bo-Cun Chen (1):
      net: ethernet: mtk_eth_soc: fix typo for declaration MT7988 ESW capability

Carolina Jubran (1):
      net/mlx5e: Disable MACsec offload for uplink representor profile

Christian Heusel (1):
      ALSA: usb-audio: Add sample rate quirk for Audioengine D1

Claudiu Beznea (2):
      phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
      phy: renesas: rcar-gen3-usb2: Set timing registers only once

Cong Wang (1):
      net_sched: Flush gso_skb list too during ->change()

Cosmin Tanislav (1):
      regulator: max20086: fix invalid memory access

Cristian Marussi (3):
      firmware: arm_scmi: Add helper to trace bad messages
      firmware: arm_scmi: Add message dump traces for bad and unexpected replies
      firmware: arm_scmi: Fix timeout checks on polling path

Dan Carpenter (1):
      phy: tegra: xusb: remove a stray unlock

David Lechner (1):
      iio: chemical: sps30: use aligned_s64 for timestamp

Eric Dumazet (2):
      mctp: no longer rely on net->dev_index_head[]
      sctp: add mutual exclusion in proc_sctp_do_udp_port()

Eric W. Biederman (1):
      binfmt_elf: Support segments with 0 filesz and misaligned starts

Fedor Pchelkin (1):
      wifi: mt76: disable napi on driver removal

Feng Tang (1):
      selftests/mm: compaction_test: support platform with huge mount of memory

Filipe Manana (1):
      btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()

Geert Uytterhoeven (2):
      spi: loopback-test: Do not split 1024-byte hexdumps
      ALSA: sh: SND_AICA should depend on SH_DMA_API

Gerhard Engleder (2):
      tsnep: Inline small fragments within TX descriptor
      tsnep: fix timestamping with a stacked DSA driver

Greg Kroah-Hartman (1):
      Linux 6.6.92

Hangbin Liu (1):
      tools/net/ynl: ethtool: fix crash when Hardware Clock info is missing

Hans de Goede (1):
      platform/x86: asus-wmi: Fix wlan_ctrl_by_user detection

Hariprasad Kelam (1):
      octeontx2-af: Fix CGX Receive counters

Henry Martin (1):
      HID: uclogic: Add NULL check in uclogic_input_configured()

Huacai Chen (3):
      LoongArch: Save and restore CSR.CNTC for hibernation
      LoongArch: Fix MAX_REG_OFFSET calculation
      LoongArch: Explicitly specify code model in Makefile

Hyejeong Choi (1):
      dma-buf: insert memory barrier before updating num_fences

Ido Schimmel (1):
      mlxsw: spectrum_router: Fix use-after-free when deleting GRE net devices

Jan Kara (1):
      udf: Make sure i_lenExtents is uptodate on inode eviction

Jeremy Linton (1):
      ACPI: PPTT: Fix processor subtable walk

Jethro Donaldson (1):
      smb: client: fix memory leak during error handling for POSIX mkdir

Jonathan Cameron (2):
      iio: adc: ad7266: Fix potential timestamp alignment issue.
      iio: adc: ad7768-1: Fix insufficient alignment of timestamp.

Kees Cook (8):
      binfmt_elf: elf_bss no longer used by load_elf_binary()
      binfmt_elf: Leave a gap between .bss and brk
      selftests/exec: Build both static and non-static load_address tests
      binfmt_elf: Calculate total_size earlier
      binfmt_elf: Honor PT_LOAD alignment for static PIE
      binfmt_elf: Move brk for static PIE even if ASLR disabled
      nvme-pci: make nvme_pci_npages_prp() __always_inline
      wifi: mac80211: Set n_channels after allocating struct cfg80211_scan_request

Keith Busch (1):
      nvme-pci: acquire cq_poll_lock in nvme_poll_irqdisable

Kirill A. Shutemov (1):
      mm/page_alloc: fix race condition in unaccepted memory handling

Li Lingfeng (1):
      nfs: handle failure of nfs_get_lock_context in unlock path

Luiz Augusto von Dentz (1):
      Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags

Luke Parkin (2):
      firmware: arm_scmi: Add support for debug metrics at the interface
      firmware: arm_scmi: Track basic SCMI communication debug metrics

Ma Jun (1):
      drm/amdgpu: Fix the runtime resume failure issue

Ma Ke (1):
      phy: Fix error handling in tegra_xusb_port_init

Ma Wupeng (1):
      hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio

Mario Limonciello (2):
      drm/amd: Stop evicting resources on APUs in suspend
      drm/amd: Add Suspend/Hibernate notification callback support

Masami Hiramatsu (Google) (1):
      tracing: probes: Fix a possible race in trace_probe_log APIs

Mathieu Othacehe (1):
      net: cadence: macb: Fix a possible deadlock in macb_halt_tx.

Matt Johnston (1):
      net: mctp: Don't access ifa_index when missing

Michael Kelley (5):
      hv_netvsc: Use vmbus_sendpacket_mpb_desc() to send VMBus messages
      hv_netvsc: Preserve contiguous PFN grouping in the page buffer array
      hv_netvsc: Remove rmsg_pgcnt
      Drivers: hv: Allow vmbus_sendpacket_mpb_desc() to create multiple ranges
      Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()

Michal Suchanek (1):
      tpm: tis: Double the timeout B to 4s

Mikhail Lobanov (1):
      KVM: SVM: Forcibly leave SMM mode on SHUTDOWN interception

Muhammad Usama Anjum (1):
      selftests/exec: load_address: conform test to TAP format output

Nathan Chancellor (1):
      net: qede: Initialize qede_ll_ops with designated initializer

Nathan Lynch (1):
      dmaengine: Revert "dmaengine: dmatest: Fix dmatest waiting less when interrupted"

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix kernel panic during FW release

Nicolas Chauvet (1):
      ALSA: usb-audio: Add sample rate quirk for Microdia JP001 USB Camera

Pawan Gupta (1):
      x86/its: Fix build error for its_static_thunk()

Pengtao He (1):
      net/tls: fix kernel panic when alloc_page failed

Peter Collingbourne (1):
      bpf, arm64: Fix address emission with tag-based KASAN enabled

Peter Gonda (1):
      KVM: SVM: Update SEV-ES shutdown intercepts with more metadata

Puranjay Mohan (1):
      bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG

Qasim Ijaz (1):
      HID: thrustmaster: fix memory leak in thrustmaster_interrupts()

Rahul Rameshbabu (1):
      tools: ynl: ethtool.py: Output timestamping statistics from tsinfo-get operation

Ronald Wahl (1):
      dmaengine: ti: k3-udma: Add missing locking

Runhua He (1):
      platform/x86/amd/pmc: Declare quirk_spurious_8042 for MECHREVO Wujie 14XA (GX4HRXL)

Shuai Xue (9):
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups
      dmaengine: idxd: Add missing cleanup for early error out in idxd_setup_internals
      dmaengine: idxd: Add missing cleanups in cleanup internals
      dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call
      dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
      dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe
      dmaengine: idxd: Refactor remove call with idxd_cleanup() helper

Stephen Smalley (1):
      fs/xattr.c: fix simple_xattr_list to always include security.* xattrs

Steve Siwinski (1):
      scsi: sd_zbc: block: Respect bio vector limits for REPORT ZONES buffer

Steven Rostedt (1):
      tracing: samples: Initialize trace_array_printk() with the correct function

Subbaraya Sundeep (1):
      octeontx2-pf: macsec: Fix incorrect max transmit size in TX secy

Takashi Iwai (2):
      ALSA: seq: Fix delivery of UMP events to group ports
      ALSA: ump: Fix a typo of snd_ump_stream_msg_device_info

Tianyang Zhang (1):
      LoongArch: Prevent cond_resched() occurring within kernel-fpu

Tiezhu Yang (2):
      LoongArch: uprobes: Remove user_{en,dis}able_single_step()
      LoongArch: uprobes: Remove redundant code about resume_era

Tom Lendacky (1):
      memblock: Accept allocated memory before use in memblock_double_array()

Trond Myklebust (1):
      NFSv4/pnfs: Reset the layout state after a layoutreturn

Vladimir Oltean (1):
      net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING

Waiman Long (1):
      cgroup/cpuset: Extend kthread_is_per_cpu() check to all PF_NO_SETAFFINITY tasks

Wayne Chang (1):
      phy: tegra: xusb: Use a bitmask for UTMI pad power state tracking

Wayne Lin (2):
      drm/amd/display: Correct the reply value when AUX write incomplete
      drm/amd/display: Avoid flooding unnecessary info messages

Wentao Liang (1):
      ALSA: es1968: Add error handling for snd_pcm_hw_constraint_pow2()

Yemike Abhilash Chandra (1):
      dmaengine: ti: k3-udma: Use cap_mask directly from dma_device structure instead of a local copy

Zhigang Luo (1):
      drm/amdgpu: trigger flr_work if reading pf2vf data failed

Zhu Yanjun (1):
      RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug

Zi Yan (1):
      mm/migrate: correct nr_failed in migrate_pages_sync()

pengdonglin (2):
      ftrace: Fix preemption accounting for stacktrace trigger command
      ftrace: Fix preemption accounting for stacktrace filter command


