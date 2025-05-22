Return-Path: <stable+bounces-146087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1064EAC0C58
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443B818957E5
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AFB28BAAF;
	Thu, 22 May 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JPlw0D/q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3928BAAE;
	Thu, 22 May 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919506; cv=none; b=BdPCxdVsMAIpvoKi0NT+UBV39EwB+ooVgdE/UssuMqoPh3EfaZdFuXfYlWPORZyHrxXQYAHQMl9M8ASUVlFaK5q3ZwyQsuN/RXHA4uF5k5lTASwIIo2pNaQSmHGes3ZDkQYUj1hugNYATYV+YWNnzy65t2j/RIjht6VwrxPNL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919506; c=relaxed/simple;
	bh=no12LsbbpeCopO+eWn/T2rBv4YyvWByJVuceJdD1EVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RF6lFmji6N9SXq6M9IMVyfxP7sIhI58X+2HKxd27GRMydD01Tz1IGROsdPOuF1CEPY9G8sgNvrdp84jZtPV0S/ov9o5/aveSIl684rriGnftD1bTOX0qVUVOXeRvkVIJWSSolAmITMJs9L3nXGLXzV+gOdHfy0lwTRtlRbPFzQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JPlw0D/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311BEC4CEED;
	Thu, 22 May 2025 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747919505;
	bh=no12LsbbpeCopO+eWn/T2rBv4YyvWByJVuceJdD1EVg=;
	h=From:To:Cc:Subject:Date:From;
	b=JPlw0D/qX/vFQ/0mPR1WskoBx335zWanW2VCs/keyinsb+F6WkeokcOWU8Eseesxa
	 WtjLKDTFa/yoo6thwF4yaC3u0l1PlJ46WjFMjjkLP/EPOWQ89eT+oktvmwHzvirFgi
	 dFCpWYRUv4kyAFMMR+QPnTZix6Mb86gBmnvJyn/8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.140
Date: Thu, 22 May 2025 15:11:36 +0200
Message-ID: <2025052236-spoilage-disparity-71aa@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.140 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/arm64/kernel/fpsimd.c                                  |    6 
 arch/arm64/net/bpf_jit_comp.c                               |   12 
 arch/loongarch/Makefile                                     |    2 
 arch/loongarch/include/asm/ptrace.h                         |    2 
 arch/riscv/include/asm/page.h                               |    1 
 arch/riscv/include/asm/pgtable.h                            |    2 
 arch/riscv/mm/init.c                                        |   17 
 arch/x86/kernel/ftrace.c                                    |    2 
 arch/x86/kernel/kprobes/core.c                              |    1 
 arch/x86/kernel/module.c                                    |    9 
 block/bio.c                                                 |    2 
 drivers/acpi/pptt.c                                         |   11 
 drivers/char/tpm/tpm_tis_core.h                             |    2 
 drivers/clocksource/i8253.c                                 |    4 
 drivers/dma-buf/dma-resv.c                                  |    5 
 drivers/dma/dmatest.c                                       |    6 
 drivers/dma/idxd/init.c                                     |  145 ++++--
 drivers/dma/ti/k3-udma.c                                    |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                         |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                  |   51 +-
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                   |   10 
 drivers/net/ethernet/cadence/macb_main.c                    |   19 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c   |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c           |    4 
 drivers/net/ethernet/qlogic/qede/qede_main.c                |    2 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c    |    7 
 drivers/net/hyperv/hyperv_net.h                             |   13 
 drivers/net/hyperv/netvsc.c                                 |   57 ++
 drivers/net/hyperv/netvsc_drv.c                             |   62 --
 drivers/net/hyperv/rndis_filter.c                           |   24 -
 drivers/net/wireless/mediatek/mt76/dma.c                    |    1 
 drivers/nvme/host/pci.c                                     |    4 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                    |   40 -
 drivers/phy/tegra/xusb.c                                    |    8 
 drivers/platform/x86/amd/pmc.c                              |    8 
 drivers/platform/x86/asus-wmi.c                             |    3 
 drivers/regulator/max20086-regulator.c                      |    7 
 drivers/scsi/sd_zbc.c                                       |    6 
 drivers/scsi/storvsc_drv.c                                  |    1 
 drivers/spi/spi-cadence-quadspi.c                           |    6 
 drivers/spi/spi-loopback-test.c                             |    2 
 drivers/usb/typec/altmodes/displayport.c                    |   18 
 drivers/usb/typec/ucsi/displayport.c                        |   19 
 drivers/usb/typec/ucsi/ucsi.c                               |   34 +
 drivers/usb/typec/ucsi/ucsi.h                               |    3 
 drivers/usb/typec/ucsi/ucsi_ccg.c                           |    5 
 fs/binfmt_elf.c                                             |  285 ++++++------
 fs/binfmt_elf_fdpic.c                                       |    2 
 fs/btrfs/discard.c                                          |   17 
 fs/btrfs/extent-tree.c                                      |   25 -
 fs/exec.c                                                   |    2 
 fs/nfs/nfs4proc.c                                           |    9 
 fs/nfs/pnfs.c                                               |    9 
 fs/smb/client/smb2pdu.c                                     |    2 
 include/linux/bio.h                                         |    1 
 include/linux/hyperv.h                                      |    7 
 include/linux/tpm.h                                         |    2 
 include/net/netfilter/nf_tables.h                           |    3 
 include/net/sch_generic.h                                   |   15 
 include/uapi/linux/elf.h                                    |    2 
 kernel/trace/trace_dynevent.c                               |   16 
 kernel/trace/trace_dynevent.h                               |    1 
 kernel/trace/trace_events_trigger.c                         |    2 
 kernel/trace/trace_functions.c                              |    6 
 kernel/trace/trace_kprobe.c                                 |    2 
 kernel/trace/trace_probe.c                                  |    9 
 kernel/trace/trace_uprobe.c                                 |    2 
 mm/memory_hotplug.c                                         |    6 
 mm/migrate.c                                                |    8 
 net/ipv4/ip_output.c                                        |    3 
 net/ipv4/raw.c                                              |    3 
 net/ipv6/ip6_output.c                                       |    3 
 net/mctp/route.c                                            |    4 
 net/netfilter/nf_tables_api.c                               |   54 +-
 net/netfilter/nft_immediate.c                               |    2 
 net/sched/sch_codel.c                                       |    2 
 net/sched/sch_fq.c                                          |    2 
 net/sched/sch_fq_codel.c                                    |    2 
 net/sched/sch_fq_pie.c                                      |    2 
 net/sched/sch_hhf.c                                         |    2 
 net/sched/sch_pie.c                                         |    2 
 net/sctp/sysctl.c                                           |    4 
 net/tls/tls_strp.c                                          |    3 
 samples/ftrace/sample-trace-array.c                         |    2 
 sound/pci/es1968.c                                          |    6 
 sound/sh/Kconfig                                            |    2 
 sound/usb/quirks.c                                          |    4 
 tools/testing/selftests/exec/Makefile                       |   19 
 tools/testing/selftests/exec/load_address.c                 |   83 ++-
 tools/testing/selftests/vm/compaction_test.c                |   19 
 106 files changed, 938 insertions(+), 533 deletions(-)

Abdun Nihaal (1):
      qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()

Alex Deucher (2):
      Revert "drm/amd: Stop evicting resources on APUs in suspend"
      drm/amdgpu: fix pm notifier handling

Andrei Kuchynski (1):
      usb: typec: ucsi: displayport: Fix deadlock

Andrew Jeffery (1):
      net: mctp: Ensure keys maintain only one ref to corresponding dev

Byungchul Park (1):
      mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index

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

Dan Carpenter (1):
      usb: typec: fix potential array underflow in ucsi_ccg_sync_control()

David Lechner (1):
      iio: chemical: sps30: use aligned_s64 for timestamp

Eric Dumazet (1):
      sctp: add mutual exclusion in proc_sctp_do_udp_port()

Eric W. Biederman (1):
      binfmt_elf: Support segments with 0 filesz and misaligned starts

Fedor Pchelkin (1):
      wifi: mt76: disable napi on driver removal

Feng Tang (1):
      selftests/mm: compaction_test: support platform with huge mount of memory

Filipe Manana (2):
      btrfs: fix discard worker infinite loop after disabling discard
      btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()

Florian Westphal (2):
      netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
      netfilter: nf_tables: do not defer rule destruction via call_rcu

GONG Ruiqi (1):
      usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()

Geert Uytterhoeven (2):
      spi: loopback-test: Do not split 1024-byte hexdumps
      ALSA: sh: SND_AICA should depend on SH_DMA_API

Greg Kroah-Hartman (1):
      Linux 6.1.140

Hans de Goede (1):
      platform/x86: asus-wmi: Fix wlan_ctrl_by_user detection

Henry Martin (1):
      HID: uclogic: Add NULL check in uclogic_input_configured()

Huacai Chen (2):
      LoongArch: Fix MAX_REG_OFFSET calculation
      LoongArch: Explicitly specify code model in Makefile

Hyejeong Choi (1):
      dma-buf: insert memory barrier before updating num_fences

Jeremy Linton (1):
      ACPI: PPTT: Fix processor subtable walk

Jethro Donaldson (1):
      smb: client: fix memory leak during error handling for POSIX mkdir

Jonathan Cameron (2):
      iio: adc: ad7266: Fix potential timestamp alignment issue.
      iio: adc: ad7768-1: Fix insufficient alignment of timestamp.

Kees Cook (8):
      binfmt: Fix whitespace issues
      binfmt_elf: elf_bss no longer used by load_elf_binary()
      binfmt_elf: Leave a gap between .bss and brk
      selftests/exec: Build both static and non-static load_address tests
      binfmt_elf: Calculate total_size earlier
      binfmt_elf: Honor PT_LOAD alignment for static PIE
      binfmt_elf: Move brk for static PIE even if ASLR disabled
      nvme-pci: make nvme_pci_npages_prp() __always_inline

Keith Busch (1):
      nvme-pci: acquire cq_poll_lock in nvme_poll_irqdisable

Li Lingfeng (1):
      nfs: handle failure of nfs_get_lock_context in unlock path

Ma Jun (1):
      drm/amdgpu: Fix the runtime resume failure issue

Ma Ke (1):
      phy: Fix error handling in tegra_xusb_port_init

Ma Wupeng (1):
      hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio

Maciej S. Szmigiero (1):
      platform/x86/amd/pmc: Only disable IRQ1 wakeup where i8042 actually enabled it

Mario Limonciello (2):
      drm/amd: Stop evicting resources on APUs in suspend
      drm/amd: Add Suspend/Hibernate notification callback support

Mark Brown (1):
      arm64/sme: Always exit sme_alloc() early with existing storage

Masami Hiramatsu (Google) (1):
      tracing: probes: Fix a possible race in trace_probe_log APIs

Mathieu Othacehe (1):
      net: cadence: macb: Fix a possible deadlock in macb_halt_tx.

Michael Kelley (5):
      hv_netvsc: Use vmbus_sendpacket_mpb_desc() to send VMBus messages
      hv_netvsc: Preserve contiguous PFN grouping in the page buffer array
      hv_netvsc: Remove rmsg_pgcnt
      Drivers: hv: Allow vmbus_sendpacket_mpb_desc() to create multiple ranges
      Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()

Michal Suchanek (1):
      tpm: tis: Double the timeout B to 4s

Muhammad Usama Anjum (1):
      selftests/exec: load_address: conform test to TAP format output

Nathan Chancellor (1):
      net: qede: Initialize qede_ll_ops with designated initializer

Nathan Lynch (1):
      dmaengine: Revert "dmaengine: dmatest: Fix dmatest waiting less when interrupted"

Nicolas Chauvet (1):
      ALSA: usb-audio: Add sample rate quirk for Microdia JP001 USB Camera

Pablo Neira Ayuso (1):
      netfilter: nf_tables: wait for rcu grace period on net_device removal

Pengtao He (1):
      net/tls: fix kernel panic when alloc_page failed

Peter Collingbourne (1):
      bpf, arm64: Fix address emission with tag-based KASAN enabled

Puranjay Mohan (1):
      bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG

Qasim Ijaz (1):
      HID: thrustmaster: fix memory leak in thrustmaster_interrupts()

RD Babiera (1):
      usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group

Ronald Wahl (1):
      dmaengine: ti: k3-udma: Add missing locking

Sebastian Andrzej Siewior (1):
      clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()

Shigeru Yoshida (2):
      ipv6: Fix potential uninit-value access in __ip6_make_skb()
      ipv4: Fix uninit-value access in __ip_make_skb()

Shravya KN (1):
      bnxt_en: Fix receive ring space parameters when XDP is active

Shuai Xue (8):
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups
      dmaengine: idxd: Add missing cleanup for early error out in idxd_setup_internals
      dmaengine: idxd: Add missing cleanups in cleanup internals
      dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call
      dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
      dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe

Steve Siwinski (1):
      scsi: sd_zbc: block: Respect bio vector limits for REPORT ZONES buffer

Steven Rostedt (1):
      tracing: samples: Initialize trace_array_printk() with the correct function

Subbaraya Sundeep (1):
      octeontx2-pf: macsec: Fix incorrect max transmit size in TX secy

Thomas Gleixner (1):
      x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()

Théo Lebrun (1):
      spi: cadence-qspi: fix pointer reference in runtime PM hooks

Trond Myklebust (1):
      NFSv4/pnfs: Reset the layout state after a layoutreturn

Vladimir Oltean (1):
      net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING

Wayne Lin (2):
      drm/amd/display: Correct the reply value when AUX write incomplete
      drm/amd/display: Avoid flooding unnecessary info messages

Wentao Liang (1):
      ALSA: es1968: Add error handling for snd_pcm_hw_constraint_pow2()

Xu Lu (1):
      riscv: mm: Fix the out of bound issue of vmemmap address

Yemike Abhilash Chandra (1):
      dmaengine: ti: k3-udma: Use cap_mask directly from dma_device structure instead of a local copy

Zhigang Luo (1):
      drm/amdgpu: trigger flr_work if reading pf2vf data failed

Zhu Yanjun (1):
      RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug

pengdonglin (2):
      ftrace: Fix preemption accounting for stacktrace trigger command
      ftrace: Fix preemption accounting for stacktrace filter command


