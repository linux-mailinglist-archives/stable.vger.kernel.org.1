Return-Path: <stable+bounces-146085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED7FAC0C51
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 15:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AA617ADAF
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175528BA83;
	Thu, 22 May 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ej3ICy1Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C22F85B;
	Thu, 22 May 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919494; cv=none; b=n/4eTYTImFM6dSZ/A02Z4Olwzze2I2r6rIS1sRExE8ikAUL9++GIrC5n4xmqiTYfud3qTIAOQYBj2kqtJei5UGIKZ8LUCgvXvlie+nj5WLRbdelaSISRf7tPDDjHnPduUiE+tkRhixoYxQmtqWouCFHZMpaDmQ0M1ZhNcdocUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919494; c=relaxed/simple;
	bh=WAd9Kz2Wmt4mjs/6Ae0aDihj/U+7ckr4z/zUPa/jrX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qM1umUISuQVl1BFv4AoCdKP/7fBlB61hTMezPfUz89mg8fe6PKkPw3Czq7e2jyzEP0oi8YmqxqKeVeCJf2k5/clL611zNnYH89SZvWx1QLdTQrpXsp69orJx6JaAzFzpEaGnDZckQS/udsKeyAZZNWB7IchhzNeFDnDwTzy5gpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ej3ICy1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692CDC4CEEB;
	Thu, 22 May 2025 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747919493;
	bh=WAd9Kz2Wmt4mjs/6Ae0aDihj/U+7ckr4z/zUPa/jrX8=;
	h=From:To:Cc:Subject:Date:From;
	b=ej3ICy1ZicR/LFi0ZWR6xFwgs5UHNDggIOIciHH45hYsdXObS6nOaCi1l+/qeWmgM
	 1FgZ6+gg7ixTZHAqyBNj0j4EK/1ZHYf8/U3zAtEbZeeF0/FMXBitNh4p1JXVf1kXXF
	 L+ic3dzcPD3/FHKnzpQJNs6yY3SAW9A3R+UMMXfo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.184
Date: Thu, 22 May 2025 15:11:28 +0200
Message-ID: <2025052229-xbox-frosty-b221@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.184 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu              |    1 
 Documentation/admin-guide/hw-vuln/index.rst                     |    1 
 Documentation/admin-guide/hw-vuln/indirect-target-selection.rst |  156 ++++++
 Documentation/admin-guide/kernel-parameters.txt                 |   15 
 Makefile                                                        |    2 
 arch/x86/Kconfig                                                |   11 
 arch/x86/entry/entry_64.S                                       |   20 
 arch/x86/include/asm/alternative.h                              |   32 +
 arch/x86/include/asm/cpufeatures.h                              |    3 
 arch/x86/include/asm/msr-index.h                                |    8 
 arch/x86/include/asm/nospec-branch.h                            |   57 +-
 arch/x86/kernel/alternative.c                                   |  243 +++++++++-
 arch/x86/kernel/cpu/bugs.c                                      |  139 +++++
 arch/x86/kernel/cpu/common.c                                    |   63 ++
 arch/x86/kernel/ftrace.c                                        |    4 
 arch/x86/kernel/kprobes/core.c                                  |    1 
 arch/x86/kernel/module.c                                        |   15 
 arch/x86/kernel/static_call.c                                   |    2 
 arch/x86/kernel/vmlinux.lds.S                                   |   10 
 arch/x86/kvm/x86.c                                              |    4 
 arch/x86/lib/retpoline.S                                        |   39 +
 arch/x86/net/bpf_jit_comp.c                                     |    8 
 block/fops.c                                                    |    5 
 drivers/acpi/pptt.c                                             |   11 
 drivers/base/cpu.c                                              |    8 
 drivers/clocksource/i8253.c                                     |    6 
 drivers/dma/dmatest.c                                           |    6 
 drivers/dma/idxd/init.c                                         |    8 
 drivers/dma/ti/k3-udma.c                                        |   10 
 drivers/iio/adc/ad7768-1.c                                      |    2 
 drivers/iio/chemical/sps30.c                                    |    2 
 drivers/infiniband/sw/rxe/rxe_cq.c                              |    5 
 drivers/net/dsa/sja1105/sja1105_main.c                          |    6 
 drivers/net/ethernet/cadence/macb_main.c                        |   19 
 drivers/net/ethernet/intel/ice/ice_arfs.c                       |    9 
 drivers/net/ethernet/intel/ice/ice_lib.c                        |    5 
 drivers/net/ethernet/intel/ice/ice_main.c                       |   20 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c        |    7 
 drivers/net/wireless/mediatek/mt76/dma.c                        |    1 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                        |    7 
 drivers/phy/tegra/xusb.c                                        |    8 
 drivers/platform/x86/asus-wmi.c                                 |    3 
 drivers/spi/spi-loopback-test.c                                 |    2 
 drivers/usb/typec/altmodes/displayport.c                        |   18 
 drivers/usb/typec/ucsi/displayport.c                            |   19 
 drivers/usb/typec/ucsi/ucsi.c                                   |   34 +
 drivers/usb/typec/ucsi/ucsi.h                                   |    3 
 drivers/usb/typec/ucsi/ucsi_ccg.c                               |    5 
 fs/btrfs/discard.c                                              |   17 
 fs/btrfs/extent-tree.c                                          |   25 -
 fs/btrfs/extent_io.c                                            |   15 
 fs/nfs/nfs4proc.c                                               |    9 
 fs/nfs/pnfs.c                                                   |    9 
 include/linux/cpu.h                                             |    2 
 include/linux/module.h                                          |    5 
 include/net/netfilter/nf_tables.h                               |    2 
 include/net/sch_generic.h                                       |   15 
 kernel/trace/trace_dynevent.c                                   |   16 
 kernel/trace/trace_dynevent.h                                   |    1 
 kernel/trace/trace_events_trigger.c                             |    2 
 kernel/trace/trace_functions.c                                  |    6 
 kernel/trace/trace_kprobe.c                                     |    2 
 kernel/trace/trace_probe.c                                      |    9 
 kernel/trace/trace_uprobe.c                                     |    2 
 net/netfilter/nf_tables_api.c                                   |   54 +-
 net/netfilter/nft_immediate.c                                   |    2 
 net/sched/sch_codel.c                                           |    2 
 net/sched/sch_fq.c                                              |    2 
 net/sched/sch_fq_codel.c                                        |    2 
 net/sched/sch_fq_pie.c                                          |    2 
 net/sched/sch_hhf.c                                             |    2 
 net/sched/sch_pie.c                                             |    2 
 net/sctp/sysctl.c                                               |    4 
 samples/ftrace/sample-trace-array.c                             |    2 
 sound/pci/es1968.c                                              |    6 
 sound/sh/Kconfig                                                |    2 
 sound/usb/quirks.c                                              |    4 
 tools/testing/selftests/vm/compaction_test.c                    |   19 
 78 files changed, 1115 insertions(+), 190 deletions(-)

Abdun Nihaal (1):
      qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()

Alexander Lobakin (1):
      ice: arfs: fix use-after-free when freeing @rx_cpu_rmap

Andrei Kuchynski (1):
      usb: typec: ucsi: displayport: Fix deadlock

Borislav Petkov (AMD) (1):
      x86/alternative: Optimize returns patching

Christian Heusel (1):
      ALSA: usb-audio: Add sample rate quirk for Audioengine D1

Claudiu Beznea (1):
      phy: renesas: rcar-gen3-usb2: Set timing registers only once

Cong Wang (1):
      net_sched: Flush gso_skb list too during ->change()

Dan Carpenter (1):
      usb: typec: fix potential array underflow in ucsi_ccg_sync_control()

David Lechner (1):
      iio: chemical: sps30: use aligned_s64 for timestamp

Eric Biggers (1):
      x86/its: Fix build errors when CONFIG_MODULES=n

Eric Dumazet (1):
      sctp: add mutual exclusion in proc_sctp_do_udp_port()

Fedor Pchelkin (1):
      wifi: mt76: disable napi on driver removal

Feng Tang (1):
      selftests/mm: compaction_test: support platform with huge mount of memory

Fengnan Chang (1):
      block: fix direct io NOWAIT flag not work

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
      Linux 5.15.184

Hans de Goede (1):
      platform/x86: asus-wmi: Fix wlan_ctrl_by_user detection

Jeremy Linton (1):
      ACPI: PPTT: Fix processor subtable walk

Jonathan Cameron (1):
      iio: adc: ad7768-1: Fix insufficient alignment of timestamp.

Josef Bacik (1):
      btrfs: do not clean up repair bio if submit fails

Josh Poimboeuf (1):
      x86/alternatives: Remove faulty optimization

Li Lingfeng (1):
      nfs: handle failure of nfs_get_lock_context in unlock path

Ma Ke (1):
      phy: Fix error handling in tegra_xusb_port_init

Masami Hiramatsu (Google) (1):
      tracing: probes: Fix a possible race in trace_probe_log APIs

Mathieu Othacehe (1):
      net: cadence: macb: Fix a possible deadlock in macb_halt_tx.

Nathan Lynch (1):
      dmaengine: Revert "dmaengine: dmatest: Fix dmatest waiting less when interrupted"

Nicolas Chauvet (1):
      ALSA: usb-audio: Add sample rate quirk for Microdia JP001 USB Camera

Pablo Neira Ayuso (1):
      netfilter: nf_tables: wait for rcu grace period on net_device removal

Pawan Gupta (10):
      x86/speculation: Simplify and make CALL_NOSPEC consistent
      x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
      x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
      Documentation: x86/bugs/its: Add ITS documentation
      x86/its: Enumerate Indirect Target Selection (ITS) bug
      x86/its: Add support for ITS-safe indirect thunk
      x86/its: Add support for ITS-safe return thunk
      x86/its: Enable Indirect Target Selection mitigation
      x86/its: Add "vmexit" option to skip mitigation on some CPUs
      x86/its: Align RETs in BHB clear sequence to avoid thunking

Peter Zijlstra (3):
      x86,nospec: Simplify {JMP,CALL}_NOSPEC
      x86/its: Use dynamic thunks for indirect branches
      x86/its: FineIBT-paranoid vs ITS

RD Babiera (1):
      usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group

Ronald Wahl (1):
      dmaengine: ti: k3-udma: Add missing locking

Sebastian Andrzej Siewior (1):
      clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()

Shuai Xue (2):
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups

Steven Rostedt (1):
      tracing: samples: Initialize trace_array_printk() with the correct function

Thomas Gleixner (1):
      x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()

Trond Myklebust (1):
      NFSv4/pnfs: Reset the layout state after a layoutreturn

Vladimir Oltean (1):
      net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING

Wentao Liang (1):
      ALSA: es1968: Add error handling for snd_pcm_hw_constraint_pow2()

Yemike Abhilash Chandra (1):
      dmaengine: ti: k3-udma: Use cap_mask directly from dma_device structure instead of a local copy

Zhu Yanjun (1):
      RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug

pengdonglin (2):
      ftrace: Fix preemption accounting for stacktrace trigger command
      ftrace: Fix preemption accounting for stacktrace filter command


