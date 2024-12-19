Return-Path: <stable+bounces-105336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 447429F821F
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E693163B85
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11E61AAA34;
	Thu, 19 Dec 2024 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xrQAYgGi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705231A9B2C;
	Thu, 19 Dec 2024 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629901; cv=none; b=E3GRsb4nq0U1ETHyXV+xKK6pTfY5J/quiE3OjaYO6p/ylfB8CJzOV+jX90HSrlbIfXGsjB54Z9PayvdKrjTC61GIswPUj/M3Z854z6kTDrlhDWqVb9cYGvNtY/odDNetMtO08eN7uyhoLSJmk29ALpNe+VMBId2NcaZixXYTIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629901; c=relaxed/simple;
	bh=LRFxEjzDTFs2l0jEp21HOXysu0/k5wHgGqgSboQ3bGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EKBpH8czD+5pZVq5qAB6CwqR0D28qpAr3LHugjLOwRiLcUcqs0Oq/TOaZIVfiZKUDLlLsDJdYG1q7gOfTGQebBamCDkhKaHnJx6u/A2YU+u5SmCo/Zo49a8PxCpG62YDyKih1Oh+kHeFzRi0bGC4taRpVpdLRPjG2y8gjEVyfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xrQAYgGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C1BC4CECE;
	Thu, 19 Dec 2024 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734629901;
	bh=LRFxEjzDTFs2l0jEp21HOXysu0/k5wHgGqgSboQ3bGc=;
	h=From:To:Cc:Subject:Date:From;
	b=xrQAYgGiYw7Yyex0VwimBJcn2FX0qJrgEt96Xvp4BHDbXEIr9/wdBPUSXZrcQpoHQ
	 ePy6frAOQ/+hd4X6xRBW4dW6nytpZJbCi7IJgLILORdp08M58Nu6i4G/ng0wmABFWm
	 XqKSerXAmBuQBqKC5u+oBPtcb60IPjYGdHjPYKNY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.121
Date: Thu, 19 Dec 2024 18:38:10 +0100
Message-ID: <2024121910-flint-available-a248@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.121 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/power/runtime_pm.rst                           |    4 
 Makefile                                                     |    2 
 arch/x86/include/asm/processor.h                             |    2 
 arch/x86/include/asm/static_call.h                           |   15 
 arch/x86/include/asm/sync_core.h                             |    6 
 arch/x86/include/asm/xen/hypercall.h                         |   36 +
 arch/x86/kernel/cpu/common.c                                 |   38 +-
 arch/x86/kernel/static_call.c                                |    9 
 arch/x86/xen/enlighten.c                                     |   65 +++
 arch/x86/xen/enlighten_hvm.c                                 |   13 
 arch/x86/xen/enlighten_pv.c                                  |    4 
 arch/x86/xen/enlighten_pvh.c                                 |    7 
 arch/x86/xen/xen-asm.S                                       |   50 ++
 arch/x86/xen/xen-head.S                                      |  106 ++++-
 arch/x86/xen/xen-ops.h                                       |    9 
 block/blk-cgroup.c                                           |    6 
 block/blk-iocost.c                                           |    9 
 drivers/acpi/acpica/evxfregn.c                               |    2 
 drivers/acpi/nfit/core.c                                     |    7 
 drivers/acpi/resource.c                                      |    6 
 drivers/ata/sata_highbank.c                                  |    1 
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                        |    2 
 drivers/gpu/drm/i915/i915_scheduler.c                        |    2 
 drivers/net/bonding/bond_main.c                              |    1 
 drivers/net/dsa/ocelot/felix_vsc9959.c                       |   17 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h                   |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c              |    2 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                   |    5 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c |    4 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c          |   11 
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c          |    2 
 drivers/net/ethernet/mscc/ocelot_ptp.c                       |  209 ++++++-----
 drivers/net/ethernet/qualcomm/qca_spi.c                      |   26 -
 drivers/net/ethernet/qualcomm/qca_spi.h                      |    1 
 drivers/net/team/team.c                                      |    3 
 drivers/net/xen-netfront.c                                   |    5 
 drivers/ptp/ptp_kvm_arm.c                                    |    4 
 drivers/ptp/ptp_kvm_common.c                                 |    1 
 drivers/ptp/ptp_kvm_x86.c                                    |   61 ++-
 drivers/spi/spi-aspeed-smc.c                                 |   10 
 drivers/usb/dwc2/hcd.c                                       |   19 -
 drivers/usb/dwc3/dwc3-xilinx.c                               |    5 
 drivers/usb/gadget/function/u_serial.c                       |    9 
 drivers/usb/host/ehci-sh.c                                   |    9 
 drivers/usb/host/max3421-hcd.c                               |   16 
 drivers/usb/typec/anx7411.c                                  |   66 ++-
 fs/exfat/dir.c                                               |   15 
 fs/exfat/exfat_fs.h                                          |    5 
 fs/smb/client/connect.c                                      |   76 +---
 fs/smb/server/auth.c                                         |    2 
 fs/smb/server/mgmt/user_session.c                            |    6 
 fs/smb/server/server.c                                       |    4 
 fs/smb/server/smb2pdu.c                                      |   27 -
 fs/xfs/libxfs/xfs_btree.c                                    |   29 +
 fs/xfs/libxfs/xfs_symlink_remote.c                           |    4 
 fs/xfs/scrub/trace.h                                         |    2 
 fs/xfs/xfs_file.c                                            |    8 
 fs/xfs/xfs_trans.c                                           |   16 
 include/linux/compiler.h                                     |   37 +
 include/linux/dsa/ocelot.h                                   |    1 
 include/linux/ptp_kvm.h                                      |    1 
 include/linux/static_call.h                                  |    6 
 include/net/bluetooth/bluetooth.h                            |    1 
 include/net/lapb.h                                           |    2 
 include/net/net_namespace.h                                  |    1 
 include/soc/mscc/ocelot.h                                    |    2 
 kernel/bpf/verifier.c                                        |    5 
 kernel/static_call_inline.c                                  |    2 
 kernel/trace/bpf_trace.c                                     |   11 
 kernel/trace/trace_kprobe.c                                  |    2 
 net/batman-adv/translation-table.c                           |   58 ++-
 net/bluetooth/iso.c                                          |    8 
 net/bluetooth/sco.c                                          |   29 -
 net/core/net_namespace.c                                     |   21 +
 net/core/sock_map.c                                          |    1 
 net/ipv4/tcp_output.c                                        |    6 
 net/mac80211/cfg.c                                           |    9 
 net/sched/sch_netem.c                                        |   22 -
 net/tipc/udp_media.c                                         |    7 
 net/wireless/nl80211.c                                       |    2 
 sound/soc/amd/yc/acp6x-mach.c                                |   13 
 sound/usb/quirks.c                                           |   44 +-
 tools/objtool/check.c                                        |   11 
 tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh    |   55 ++
 84 files changed, 983 insertions(+), 457 deletions(-)

Anumula Murali Mohan Reddy (1):
      cxgb4: use port number to set mac addr

Benjamin Lin (1):
      wifi: mac80211: fix station NSS capability initialization order

Christophe JAILLET (1):
      spi: aspeed: Fix an error handling path in aspeed_spi_[read|write]_user()

Dan Carpenter (2):
      net/mlx5: DR, prevent potential error pointer dereference
      ALSA: usb-audio: Fix a DMA to stack memory bug

Daniel Borkmann (2):
      bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
      team: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL

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

Frédéric Danis (1):
      Bluetooth: SCO: Add support for 16 bits transparent voice setting

Greg Kroah-Hartman (1):
      Linux 6.1.121

Ilpo Järvinen (1):
      ACPI: resource: Fix memory resource type union access

Iulia Tanasescu (1):
      Bluetooth: iso: Fix recursive locking warning

Jaakko Salo (1):
      ALSA: usb-audio: Add implicit feedback quirk for Yamaha THR5

Jann Horn (1):
      bpf: Fix UAF via mismatching bpf_prog/attachment RCU flavors

Jeremi Piotrowski (1):
      ptp: kvm: Use decrypted memory in confidential guest on x86

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

Lianqin Hu (1):
      usb: gadget: u_serial: Fix the issue that gs_start_io crashed due to accessing null pointer

Lin Ma (1):
      wifi: nl80211: fix NL80211_ATTR_MLO_LINK_ID off-by-one

Mark Tomlinson (1):
      usb: host: max3421-hcd: Correctly abort a USB request.

Martin Ottens (1):
      net/sched: netem: account for backlog updates from child qdisc

Michal Luczaj (1):
      bpf, sockmap: Fix update element with same

MoYuanhao (1):
      tcp: check space before adding MPTCP SYN options

Namjae Jeon (1):
      ksmbd: fix racy issue from session lookup and expire

Nathan Chancellor (1):
      blk-iocost: Avoid using clamp() on inuse in __propagate_weights()

Neal Frager (1):
      usb: dwc3: xilinx: make sure pipe clock is deselected in usb2 only mode

Nikolay Kuratov (1):
      tracing/kprobes: Skip symbol counting logic for module symbols in create_local_trace_kprobe()

Paul Barker (1):
      Documentation: PM: Clarify pm_runtime_resume_and_get() return value

Paulo Alcantara (1):
      smb: client: fix UAF in smb2_reconnect_server()

Remi Pommarel (3):
      batman-adv: Do not send uninitialized TT changes
      batman-adv: Remove uninitialized data in full table TT response
      batman-adv: Do not let TT changes list grows indefinitely

Stefan Wahren (5):
      usb: dwc2: Fix HCD resume
      usb: dwc2: hcd: Fix GetPortStatus & SetPortFeature
      usb: dwc2: Fix HCD port connection race
      qca_spi: Fix clock speed for multiple QCA7000
      qca_spi: Make driver probing reliable

Sungjong Seo (1):
      exfat: fix potential deadlock on __exfat_get_dentry_set

Suraj Sonawane (1):
      acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl

Tejun Heo (1):
      blk-cgroup: Fix UAF in blkcg_unpin_online()

Thomas Weißschuh (1):
      ptp: kvm: x86: Return EOPNOTSUPP instead of ENODEV from kvm_arch_ptp_init()

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

Yuezhang Mo (1):
      exfat: support dynamic allocate bh for exfat_entry_set_cache


