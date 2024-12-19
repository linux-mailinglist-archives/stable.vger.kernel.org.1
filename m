Return-Path: <stable+bounces-105338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF59F825C
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E907189025E
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0E1A2860;
	Thu, 19 Dec 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vV9pqzFp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92D1ABEC9;
	Thu, 19 Dec 2024 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629908; cv=none; b=YR7sv7AONZ7d6/axiX5rszh0kQEFmzRSVMZx2/qrWPyoOVeDOL2ID8Y7MHzCH3SA2oVu3fDwwtaOhhS6ez3Tf8qaqMvMgDNTQeOWQKBFyCq+SXPAYhrsWlfYkpRedNjym6wt2Kp9X00npAFUXv9Do3HNusxm988+J051k/wgCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629908; c=relaxed/simple;
	bh=Tl1UOnluXf19cAu2vsUl8J28G2yNlFd9Ap/yu5Bf9xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V4+FizV3AijtGDUWN08MVu3KxoT60TSsGKtTKDkadwCK+0X+UATHckAFMm+YyFb7Dr+R9tJnV6MoLBTtUPjO08xdmHd8QmZ1a8SkjKt3L5kqlpms9pT81nNO71Nt0LJOJByBuX0ZQ6cUxHIuKSSr+HSkIkNooRAKyymCCPCjpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vV9pqzFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B34C4CECE;
	Thu, 19 Dec 2024 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734629908;
	bh=Tl1UOnluXf19cAu2vsUl8J28G2yNlFd9Ap/yu5Bf9xE=;
	h=From:To:Cc:Subject:Date:From;
	b=vV9pqzFpNOTbEBTPPOZfK0uImfzG5hjkQIJzVnpRpVoFsFFzEzoZX1l7Nppaj6Fgx
	 xx4JTdwYv2yOCjM4UxS2erPcu9pv+Pwwxn8Grz0xihALwoOl2G5qeR/WTHRx/HpJKb
	 bPY5WJqzrvZm5dnw2clvmnsjkGCAg0kOYQ8Xww4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.67
Date: Thu, 19 Dec 2024 18:38:16 +0100
Message-ID: <2024121916-overdrawn-storewide-420f@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.67 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/power/runtime_pm.rst                           |    4 
 Makefile                                                     |    2 
 arch/arm64/kvm/sys_regs.c                                    |   52 +
 arch/riscv/include/asm/kfence.h                              |    4 
 arch/riscv/kernel/setup.c                                    |    2 
 arch/x86/events/intel/ds.c                                   |    2 
 arch/x86/include/asm/processor.h                             |    2 
 arch/x86/include/asm/static_call.h                           |   15 
 arch/x86/include/asm/sync_core.h                             |    6 
 arch/x86/include/asm/xen/hypercall.h                         |   36 -
 arch/x86/kernel/callthunks.c                                 |    5 
 arch/x86/kernel/cpu/common.c                                 |   38 -
 arch/x86/kernel/static_call.c                                |    9 
 arch/x86/xen/enlighten.c                                     |   65 +
 arch/x86/xen/enlighten_hvm.c                                 |   13 
 arch/x86/xen/enlighten_pv.c                                  |    4 
 arch/x86/xen/enlighten_pvh.c                                 |    7 
 arch/x86/xen/xen-asm.S                                       |   50 +
 arch/x86/xen/xen-head.S                                      |  106 ++-
 arch/x86/xen/xen-ops.h                                       |    9 
 block/blk-cgroup.c                                           |    6 
 block/blk-iocost.c                                           |    9 
 drivers/acpi/acpica/evxfregn.c                               |    2 
 drivers/acpi/nfit/core.c                                     |    7 
 drivers/acpi/resource.c                                      |    6 
 drivers/ata/sata_highbank.c                                  |    1 
 drivers/bluetooth/btmtk.c                                    |   20 
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                        |    2 
 drivers/gpu/drm/i915/i915_gpu_error.c                        |   18 
 drivers/gpu/drm/i915/i915_scheduler.c                        |    2 
 drivers/net/bonding/bond_main.c                              |    1 
 drivers/net/dsa/microchip/ksz_common.c                       |   42 -
 drivers/net/dsa/ocelot/felix_vsc9959.c                       |   17 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h                   |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c              |    2 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                   |    5 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c |    4 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c          |   11 
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c          |    2 
 drivers/net/ethernet/mscc/ocelot_ptp.c                       |  209 +++---
 drivers/net/ethernet/qualcomm/qca_spi.c                      |   26 
 drivers/net/ethernet/qualcomm/qca_spi.h                      |    1 
 drivers/net/ethernet/renesas/rswitch.c                       |  373 ++++++-----
 drivers/net/ethernet/renesas/rswitch.h                       |   48 -
 drivers/net/team/team.c                                      |    3 
 drivers/net/xen-netfront.c                                   |    5 
 drivers/ptp/ptp_kvm_x86.c                                    |    6 
 drivers/spi/spi-aspeed-smc.c                                 |   10 
 drivers/ufs/core/ufshcd.c                                    |    1 
 drivers/usb/dwc2/hcd.c                                       |   19 
 drivers/usb/dwc3/dwc3-xilinx.c                               |    5 
 drivers/usb/gadget/function/f_midi2.c                        |    6 
 drivers/usb/gadget/function/u_serial.c                       |    9 
 drivers/usb/host/ehci-sh.c                                   |    9 
 drivers/usb/host/max3421-hcd.c                               |   16 
 drivers/usb/typec/anx7411.c                                  |   66 +
 fs/smb/server/auth.c                                         |    2 
 fs/smb/server/mgmt/user_session.c                            |    6 
 fs/smb/server/server.c                                       |    4 
 fs/smb/server/smb2pdu.c                                      |   27 
 fs/xfs/libxfs/xfs_btree.c                                    |   29 
 fs/xfs/libxfs/xfs_symlink_remote.c                           |    4 
 fs/xfs/scrub/trace.h                                         |    2 
 fs/xfs/xfs_file.c                                            |    8 
 fs/xfs/xfs_trans.c                                           |   16 
 include/linux/bpf.h                                          |   13 
 include/linux/compiler.h                                     |   37 -
 include/linux/dsa/ocelot.h                                   |    1 
 include/linux/static_call.h                                  |    6 
 include/net/bluetooth/bluetooth.h                            |    1 
 include/net/bluetooth/hci_core.h                             |   24 
 include/net/lapb.h                                           |    2 
 include/net/net_namespace.h                                  |    1 
 include/net/netfilter/nf_tables.h                            |    4 
 include/soc/mscc/ocelot.h                                    |    2 
 kernel/bpf/btf.c                                             |    6 
 kernel/bpf/verifier.c                                        |    5 
 kernel/static_call_inline.c                                  |    2 
 kernel/trace/bpf_trace.c                                     |   11 
 kernel/trace/trace_kprobe.c                                  |    2 
 kernel/trace/trace_uprobe.c                                  |    6 
 net/batman-adv/translation-table.c                           |   58 +
 net/bluetooth/hci_conn.c                                     |   32 
 net/bluetooth/hci_event.c                                    |   33 
 net/bluetooth/iso.c                                          |   87 ++
 net/bluetooth/sco.c                                          |   29 
 net/core/net_namespace.c                                     |   20 
 net/core/sock_map.c                                          |    6 
 net/ipv4/tcp_output.c                                        |    6 
 net/mac80211/cfg.c                                           |   11 
 net/netfilter/nf_tables_api.c                                |   32 
 net/netfilter/xt_IDLETIMER.c                                 |   52 -
 net/sched/sch_netem.c                                        |   22 
 net/tipc/udp_media.c                                         |    7 
 net/unix/af_unix.c                                           |    1 
 net/wireless/nl80211.c                                       |    2 
 net/wireless/sme.c                                           |    1 
 sound/core/control_led.c                                     |   14 
 sound/soc/amd/yc/acp6x-mach.c                                |   13 
 sound/usb/quirks.c                                           |   44 -
 tools/objtool/check.c                                        |    9 
 tools/testing/selftests/arm64/abi/syscall-abi-asm.S          |   32 
 tools/testing/selftests/bpf/Makefile                         |   19 
 tools/testing/selftests/bpf/netlink_helpers.c                |  358 ++++++++++
 tools/testing/selftests/bpf/netlink_helpers.h                |   46 +
 tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c  |    4 
 tools/testing/selftests/bpf/progs/verifier_d_path.c          |    4 
 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c      |   16 
 tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh    |   55 +
 tools/tracing/rtla/src/timerlat_hist.c                       |   12 
 110 files changed, 1909 insertions(+), 739 deletions(-)

Alexandre Ghiti (2):
      riscv: Fix wrong usage of __pa() on a fixmap address
      riscv: Fix IPIs usage in kfence_protect_page()

Anumula Murali Mohan Reddy (1):
      cxgb4: use port number to set mac addr

Benjamin Lin (1):
      wifi: mac80211: fix station NSS capability initialization order

Christophe JAILLET (1):
      spi: aspeed: Fix an error handling path in aspeed_spi_[read|write]_user()

Dan Carpenter (2):
      net/mlx5: DR, prevent potential error pointer dereference
      ALSA: usb-audio: Fix a DMA to stack memory bug

Daniel Borkmann (3):
      bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
      team: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
      selftests/bpf: Add netlink helper library

Daniel Machon (2):
      net: sparx5: fix FDMA performance issue
      net: sparx5: fix the maximum frame length register

Danielle Ratson (3):
      selftests: mlxsw: sharedbuffer: Remove h1 ingress test case
      selftests: mlxsw: sharedbuffer: Remove duplicate test cases
      selftests: mlxsw: sharedbuffer: Ensure no extra packets are counted

Daniil Tatianin (1):
      ACPICA: events/evxfregn: don't release the ContextMutex that was never acquired

Darrick J. Wong (5):
      xfs: update btree keys correctly when _insrec splits an inode root block
      xfs: don't drop errno values when we fail to ficlone the entire range
      xfs: return from xfs_symlink_verify early on V4 filesystems
      xfs: fix scrub tracepoints when inode-rooted btrees are involved
      xfs: only run precommits once per transaction object

David (Ming Qiang) Wu (1):
      amdgpu/uvd: get ring reference from rq scheduler

Eduard Zingerman (1):
      bpf: sync_linked_regs() must preserve subreg_def

Eric Dumazet (3):
      tipc: fix NULL deref in cleanup_bearer()
      net: lapb: increase LAPB_HEADER_LEN
      net: defer final 'struct net' free in netns dismantle

Eugene Kobyak (1):
      drm/i915: Fix NULL pointer dereference in capture_engine

Florian Westphal (1):
      netfilter: nf_tables: do not defer rule destruction via call_rcu

Frederik Deweerdt (1):
      splice: do not checksum AF_UNIX sockets

Frédéric Danis (1):
      Bluetooth: SCO: Add support for 16 bits transparent voice setting

Greg Kroah-Hartman (1):
      Linux 6.6.67

Haoyu Li (2):
      wifi: mac80211: init cnt before accessing elem in ieee80211_copy_mbssid_beacon
      wifi: cfg80211: sme: init n_channels before channels[] access

Ilpo Järvinen (1):
      ACPI: resource: Fix memory resource type union access

Iulia Tanasescu (2):
      Bluetooth: ISO: Reassociate a socket with an active BIS
      Bluetooth: iso: Fix recursive locking warning

Jaakko Salo (1):
      ALSA: usb-audio: Add implicit feedback quirk for Yamaha THR5

James Morse (1):
      KVM: arm64: Disable MPAM visibility by default and ignore VMM writes

Jann Horn (2):
      bpf: Fix UAF via mismatching bpf_prog/attachment RCU flavors
      bpf: Fix theoretical prog_array UAF in __uprobe_perf_func()

Jesse Van Gavere (1):
      net: dsa: microchip: KSZ9896 register regmap alignment to 32 bit boundaries

Jiasheng Jiang (1):
      drm/i915: Fix memory leak by correcting cache object name in error handler

Jiri Olsa (1):
      bpf,perf: Fix invalid prog_array access in perf_event_detach_bpf_prog

Joe Hattori (3):
      ata: sata_highbank: fix OF node reference leak in highbank_initialize_phys()
      usb: typec: anx7411: fix fwnode_handle reference leak
      usb: typec: anx7411: fix OF node reference leaks in anx7411_typec_switch_probe()

Johannes Berg (1):
      wifi: mac80211: clean up 'ret' in sta_link_apply_parameters()

Juergen Gross (9):
      xen/netfront: fix crash when removing device
      x86: make get_cpu_vendor() accessible from Xen code
      objtool/x86: allow syscall instruction
      x86/static-call: provide a way to do very early static-call updates
      x86/xen: don't do PV iret hypercall through hypercall page
      x86/xen: add central hypercall functions
      x86/xen: use new hypercall functions instead of hypercall page
      x86/xen: remove hypercall page
      x86/static-call: fix 32-bit build

Kan Liang (1):
      perf/x86/intel/ds: Unconditionally drain PEBS DS when changing PEBS_DATA_CFG

Kumar Kartikeya Dwivedi (1):
      bpf: Check size for BTF-based ctx access of pointer members

Lianqin Hu (1):
      usb: gadget: u_serial: Fix the issue that gs_start_io crashed due to accessing null pointer

Lin Ma (1):
      wifi: nl80211: fix NL80211_ATTR_MLO_LINK_ID off-by-one

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating

Mark Tomlinson (1):
      usb: host: max3421-hcd: Correctly abort a USB request.

Martin Ottens (1):
      net/sched: netem: account for backlog updates from child qdisc

Michal Luczaj (2):
      bpf, sockmap: Fix race between element replace and close()
      bpf, sockmap: Fix update element with same

MoYuanhao (1):
      tcp: check space before adding MPTCP SYN options

Namjae Jeon (1):
      ksmbd: fix racy issue from session lookup and expire

Nathan Chancellor (1):
      blk-iocost: Avoid using clamp() on inuse in __propagate_weights()

Neal Frager (1):
      usb: dwc3: xilinx: make sure pipe clock is deselected in usb2 only mode

Nikita Yushchenko (5):
      net: renesas: rswitch: fix race window between tx start and complete
      net: renesas: rswitch: fix leaked pointer on error path
      net: renesas: rswitch: avoid use-after-put for a device tree node
      net: renesas: rswitch: handle stop vs interrupt race
      net: renesas: rswitch: fix initial MPIC register setting

Nikolay Kuratov (1):
      tracing/kprobes: Skip symbol counting logic for module symbols in create_local_trace_kprobe()

Paul Barker (1):
      Documentation: PM: Clarify pm_runtime_resume_and_get() return value

Phil Sutter (1):
      netfilter: IDLETIMER: Fix for possible ABBA deadlock

Radu Rendec (1):
      net: rswitch: Avoid use-after-free in rswitch_poll()

Remi Pommarel (3):
      batman-adv: Do not send uninitialized TT changes
      batman-adv: Remove uninitialized data in full table TT response
      batman-adv: Do not let TT changes list grows indefinitely

Shung-Hsi Yu (1):
      selftests/bpf: remove use of __xlated()

Stefan Wahren (5):
      usb: dwc2: Fix HCD resume
      usb: dwc2: hcd: Fix GetPortStatus & SetPortFeature
      usb: dwc2: Fix HCD port connection race
      qca_spi: Fix clock speed for multiple QCA7000
      qca_spi: Make driver probing reliable

Suraj Sonawane (1):
      acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl

Takashi Iwai (2):
      usb: gadget: midi2: Fix interpretation of is_midi1 bits
      ALSA: control: Avoid WARN() for symlink errors

Tejun Heo (1):
      blk-cgroup: Fix UAF in blkcg_unpin_online()

Thadeu Lima de Souza Cascardo (1):
      Bluetooth: btmtk: avoid UAF in btmtk_process_coredump

Thomas Weißschuh (1):
      ptp: kvm: x86: Return EOPNOTSUPP instead of ENODEV from kvm_arch_ptp_init()

Tomas Glozar (1):
      rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long

Venkata Prasad Potturu (1):
      ASoC: amd: yc: Fix the wrong return value

Vitalii Mordan (1):
      usb: ehci-hcd: fix call balance of clocks handling routines

Vladimir Oltean (6):
      net: mscc: ocelot: fix memory leak on ocelot_port_add_txtstamp_skb()
      net: mscc: ocelot: improve handling of TX timestamp for unknown skb
      net: mscc: ocelot: ocelot->ts_id_lock and ocelot_port->tx_skbs.lock are IRQ-safe
      net: mscc: ocelot: be resilient to loss of PTP packets during transmission
      net: mscc: ocelot: perform error cleanup in ocelot_hwstamp_set()
      net: dsa: felix: fix stuck CPU-injected packets with short taprio windows

Weizhao Ouyang (1):
      kselftest/arm64: abi: fix SVCR detection

Yoshihiro Shimoda (6):
      net: rswitch: Drop unused argument/return value
      net: rswitch: Use unsigned int for desc related array index
      net: rswitch: Use build_skb() for RX
      net: rswitch: Add unmap_addrs instead of dma address in each desc
      net: rswitch: Add a setting ext descriptor function
      net: rswitch: Add jumbo frames handling for TX

liuderong (1):
      scsi: ufs: core: Update compl_time_stamp_local_clock after completing a cqe


