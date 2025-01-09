Return-Path: <stable+bounces-108107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C71A0765A
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305BF18854E9
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E821885A;
	Thu,  9 Jan 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dkvtNf6k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83888219EA5;
	Thu,  9 Jan 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427452; cv=none; b=MRCxbC5vPrZvD0I45SV+7pcG29hGopt4OsYV5aK9aK6Tt8YBkgRo6e4z42u+E514SOoW/4LpY/fuCPR+wG9VRapUG3cyi9Ss/mQ71n8ciXNJp4H3tTHvbcd3YXlepY0xElybDf/BLS1rXTNO1wlvF/+gLIiQ7k1O1ZEs1pP/E+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427452; c=relaxed/simple;
	bh=Ht+U0TsDWMiMDLf1FQC9a2jVp8xszyNhyL5hvTRWCkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwrM9mw32xQ/WOt+ctt7tzpNg6ARQLSQaXcryFkWk08pilD1153i3+LC0fTqmZmhiw94O08DXhWq+OgWt0LspPu/NGwIYDw/k/7g+tbqevu8IxOedOl4UQVSIWbTmenGM0fh1wQEGZwfEumXpI0bNN8ga7wrLqZkxsDxB2b6PA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dkvtNf6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E590FC4CED2;
	Thu,  9 Jan 2025 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736427452;
	bh=Ht+U0TsDWMiMDLf1FQC9a2jVp8xszyNhyL5hvTRWCkI=;
	h=From:To:Cc:Subject:Date:From;
	b=dkvtNf6kbn+O6RASxnRYfeqWirRGjONBVI4zfhKZYMF9seLoeJraaQOZ34o+UdydM
	 Ei2qtV9jA+CAGitcVCTCel38Z+LEFRo8HSMDApivc7LSSq2conK6ysGOWxqn/Yw78H
	 cE3zkp7oyJw541IH+bGrPe0rxLkzLO6B63hZkXgs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.9
Date: Thu,  9 Jan 2025 13:57:04 +0100
Message-ID: <2025010904-dry-sandblast-c76b@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.9 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/laptops/thinkpad-acpi.rst               |   10 
 Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml |    2 
 Makefile                                                          |    2 
 arch/arc/Kconfig                                                  |    4 
 arch/arc/Makefile                                                 |    2 
 arch/arc/include/asm/cmpxchg.h                                    |    2 
 arch/arc/net/bpf_jit_arcv2.c                                      |    2 
 arch/x86/events/intel/core.c                                      |    1 
 block/blk.h                                                       |    9 
 drivers/clk/imx/clk-imx8mp-audiomix.c                             |    3 
 drivers/clk/thead/clk-th1520-ap.c                                 |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                           |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                          |    4 
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c                    |   14 
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c                      |   10 
 drivers/gpu/drm/bridge/adv7511/adv7533.c                          |    4 
 drivers/gpu/drm/i915/display/intel_cx0_phy.c                      |   12 
 drivers/gpu/drm/i915/gt/intel_rc6.c                               |    2 
 drivers/gpu/drm/xe/xe_bo.c                                        |   12 
 drivers/gpu/drm/xe/xe_devcoredump.c                               |   15 
 drivers/gpu/drm/xe/xe_exec_queue.c                                |    9 
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c                        |    2 
 drivers/infiniband/core/cma.c                                     |   16 
 drivers/infiniband/core/nldev.c                                   |    2 
 drivers/infiniband/core/uverbs_cmd.c                              |   16 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                          |   34 -
 drivers/infiniband/hw/bnxt_re/main.c                              |    8 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                          |   65 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                          |    3 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                        |    5 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                          |   18 
 drivers/infiniband/hw/hns/hns_roce_hem.c                          |   43 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |   11 
 drivers/infiniband/hw/hns/hns_roce_mr.c                           |    5 
 drivers/infiniband/hw/mlx5/main.c                                 |    8 
 drivers/infiniband/sw/rxe/rxe.c                                   |   23 
 drivers/infiniband/sw/rxe/rxe.h                                   |    3 
 drivers/infiniband/sw/rxe/rxe_mcast.c                             |   22 
 drivers/infiniband/sw/rxe/rxe_net.c                               |   24 
 drivers/infiniband/sw/rxe/rxe_verbs.c                             |   26 
 drivers/infiniband/sw/rxe/rxe_verbs.h                             |   11 
 drivers/infiniband/sw/siw/siw.h                                   |    7 
 drivers/infiniband/sw/siw/siw_cm.c                                |   27 -
 drivers/infiniband/sw/siw/siw_main.c                              |   15 
 drivers/infiniband/sw/siw/siw_verbs.c                             |   35 -
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                            |    2 
 drivers/irqchip/irq-gic.c                                         |    2 
 drivers/mmc/host/sdhci-msm.c                                      |   16 
 drivers/net/dsa/microchip/ksz9477.c                               |   47 +
 drivers/net/dsa/microchip/ksz9477_reg.h                           |    4 
 drivers/net/dsa/microchip/lan937x_main.c                          |   62 ++
 drivers/net/dsa/microchip/lan937x_reg.h                           |    9 
 drivers/net/ethernet/broadcom/bcmsysport.c                        |   21 
 drivers/net/ethernet/google/gve/gve.h                             |    1 
 drivers/net/ethernet/google/gve/gve_main.c                        |   63 +-
 drivers/net/ethernet/google/gve/gve_tx.c                          |   46 +
 drivers/net/ethernet/marvell/mv643xx_eth.c                        |   14 
 drivers/net/ethernet/marvell/sky2.c                               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c         |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                 |   19 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                  |   15 
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c            |    6 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                 |    3 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c        |    5 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c        |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c               |    3 
 drivers/net/ethernet/sfc/tc_conntrack.c                           |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c             |   43 -
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                          |    2 
 drivers/net/ethernet/ti/icssg/icss_iep.c                          |    8 
 drivers/net/ethernet/ti/icssg/icssg_common.c                      |   25 
 drivers/net/ethernet/ti/icssg/icssg_config.c                      |   41 +
 drivers/net/ethernet/ti/icssg/icssg_config.h                      |    1 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                      |  261 ++++++----
 drivers/net/ethernet/ti/icssg/icssg_prueth.h                      |    5 
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c                  |   24 
 drivers/net/phy/micrel.c                                          |  114 +++-
 drivers/net/pse-pd/tps23881.c                                     |   16 
 drivers/net/usb/qmi_wwan.c                                        |    3 
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c                       |    1 
 drivers/net/wireless/intel/iwlwifi/iwl-config.h                   |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                       |   14 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                     |   37 +
 drivers/net/wwan/iosm/iosm_ipc_mmio.c                             |    2 
 drivers/net/wwan/t7xx/t7xx_state_monitor.c                        |   26 
 drivers/net/wwan/t7xx/t7xx_state_monitor.h                        |    5 
 drivers/nvme/host/nvme.h                                          |    5 
 drivers/nvme/host/pci.c                                           |    9 
 drivers/nvme/target/configfs.c                                    |   11 
 drivers/pinctrl/pinctrl-mcp23s08.c                                |    6 
 drivers/platform/x86/hp/hp-wmi.c                                  |    4 
 drivers/platform/x86/mlx-platform.c                               |    2 
 drivers/platform/x86/thinkpad_acpi.c                              |    4 
 drivers/pmdomain/core.c                                           |    6 
 drivers/pmdomain/imx/gpcv2.c                                      |    4 
 drivers/spi/spi-cadence-quadspi.c                                 |   10 
 fs/btrfs/bio.c                                                    |   23 
 fs/btrfs/disk-io.c                                                |    9 
 fs/btrfs/inode.c                                                  |    5 
 fs/ocfs2/quota_global.c                                           |    2 
 fs/ocfs2/quota_local.c                                            |    1 
 fs/proc/task_mmu.c                                                |    2 
 fs/smb/client/cifsfs.c                                            |    1 
 fs/smb/server/smb2pdu.c                                           |   22 
 fs/smb/server/vfs.h                                               |    1 
 include/linux/bio.h                                               |   17 
 include/linux/filter.h                                            |    2 
 include/linux/if_vlan.h                                           |   16 
 include/linux/memfd.h                                             |   14 
 include/linux/mlx5/driver.h                                       |    7 
 include/linux/mlx5/mlx5_ifc.h                                     |    4 
 include/linux/mm.h                                                |   59 +-
 include/linux/mm_types.h                                          |   30 +
 include/net/bluetooth/hci_core.h                                  |  108 ++--
 include/net/netfilter/nf_tables.h                                 |    7 
 include/sound/cs35l56.h                                           |    6 
 io_uring/kbuf.c                                                   |    4 
 io_uring/net.c                                                    |    1 
 io_uring/rw.c                                                     |    2 
 kernel/bpf/core.c                                                 |    8 
 kernel/bpf/verifier.c                                             |    2 
 kernel/kcov.c                                                     |    2 
 kernel/sched/ext.c                                                |    4 
 kernel/trace/fgraph.c                                             |    2 
 kernel/trace/ftrace.c                                             |    8 
 kernel/trace/trace_events.c                                       |   12 
 kernel/workqueue.c                                                |   23 
 lib/maple_tree.c                                                  |    1 
 mm/damon/core.c                                                   |   10 
 mm/hugetlb.c                                                      |   16 
 mm/kmemleak.c                                                     |    2 
 mm/memfd.c                                                        |    2 
 mm/mmap.c                                                         |    4 
 mm/readahead.c                                                    |    6 
 mm/shmem.c                                                        |    7 
 mm/vmscan.c                                                       |    9 
 net/bluetooth/hci_core.c                                          |   10 
 net/bluetooth/iso.c                                               |    6 
 net/bluetooth/l2cap_core.c                                        |   12 
 net/bluetooth/rfcomm/core.c                                       |    6 
 net/bluetooth/sco.c                                               |   12 
 net/core/dev.c                                                    |    4 
 net/core/filter.c                                                 |   65 +-
 net/core/netdev-genl.c                                            |    6 
 net/core/sock.c                                                   |    5 
 net/ipv4/ip_tunnel.c                                              |    6 
 net/ipv4/tcp_input.c                                              |    1 
 net/ipv6/ila/ila_xlat.c                                           |   16 
 net/llc/llc_input.c                                               |    2 
 net/mac80211/cfg.c                                                |    8 
 net/mac80211/mesh.c                                               |    6 
 net/mac80211/util.c                                               |    3 
 net/mptcp/options.c                                               |    7 
 net/mptcp/protocol.c                                              |   22 
 net/netrom/nr_route.c                                             |    6 
 net/packet/af_packet.c                                            |   28 -
 net/sctp/associola.c                                              |    3 
 net/wireless/util.c                                               |    3 
 scripts/mksysmap                                                  |    4 
 scripts/mod/file2alias.c                                          |    2 
 scripts/package/PKGBUILD                                          |    2 
 scripts/sorttable.h                                               |    5 
 security/selinux/ss/services.c                                    |    8 
 sound/core/seq/oss/seq_oss_synth.c                                |    2 
 sound/core/seq/seq_clientmgr.c                                    |   14 
 sound/core/ump.c                                                  |    2 
 sound/pci/hda/cs35l56_hda.c                                       |    8 
 sound/pci/hda/patch_ca0132.c                                      |   37 -
 sound/pci/hda/patch_realtek.c                                     |   24 
 sound/soc/generic/audio-graph-card2.c                             |    2 
 sound/usb/format.c                                                |    7 
 sound/usb/mixer_us16x08.c                                         |    2 
 sound/usb/quirks.c                                                |    2 
 tools/sched_ext/scx_central.c                                     |    2 
 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c                    |    2 
 tools/testing/selftests/net/forwarding/local_termination.sh       |    1 
 177 files changed, 1687 insertions(+), 753 deletions(-)

Aditya Kumar Singh (1):
      wifi: cfg80211: clear link ID from bitmap during link delete after clean up

Adrian Ratiu (2):
      sound: usb: enable DSD output for ddHiFi TC44C
      sound: usb: format: don't warn that raw DSD is unsupported

Alessandro Carminati (1):
      mm/kmemleak: fix sleeping function called from invalid context at print message

Alex Deucher (1):
      drm/amdgpu: fix backport of commit 73dae652dcac

Anton Protopopov (1):
      bpf: fix potential error return

Antonio Pastor (1):
      net: llc: reset skb->transport_header

Anumula Murali Mohan Reddy (1):
      RDMA/core: Fix ENODEV error for iWARP test over vlan

Arnd Bergmann (1):
      kcov: mark in_softirq_really() as __always_inline

Baolin Wang (2):
      mm: shmem: fix the update of 'shmem_falloc->nr_unswapped'
      mm: shmem: fix incorrect index alignment for within_size policy

Bernard Metzler (1):
      RDMA/siw: Remove direct link to net_device

Biju Das (3):
      drm: adv7511: Drop dsi single lane support
      dt-bindings: display: adi,adv7533: Drop single lane support
      drm: adv7511: Fix use-after-free in adv7533_attach_dsi()

Chengchang Tang (3):
      RDMA/hns: Fix accessing invalid dip_ctx during destroying QP
      RDMA/hns: Fix warning storm caused by invalid input in IO path
      RDMA/hns: Fix missing flush CQE for DWQE

Chiara Meiohas (1):
      RDMA/nldev: Set error code in rdma_nl_notify_event

Christoph Hellwig (2):
      block: lift bio_is_zone_append to bio.h
      btrfs: use bio_is_zone_append() in the completion handler

Damodharam Ammepalli (2):
      RDMA/bnxt_re: Add send queue size check for variable wqe
      RDMA/bnxt_re: Fix MSN table size for variable wqe mode

Dan Carpenter (1):
      RDMA/uverbs: Prevent integer overflow issue

Daniel Schaefer (1):
      ALSA hda/realtek: Add quirk for Framework F111:000C

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FE910C04 compositions

David Hildenbrand (1):
      fs/proc/task_mmu: fix pagemap flags with PMD THP entries on 32bit

Dennis Lam (1):
      ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv

Dragos Tatulea (1):
      net/mlx5e: macsec: Maintain TX SA from encoding_sa

Eduard Zingerman (2):
      bpf: refactor bpf_helper_changes_pkt_data to use helper number
      bpf: consider that tail calls invalidate packet pointers

Emmanuel Grumbach (2):
      wifi: iwlwifi: fix CRF name for Bz
      wifi: mac80211: wake the queues in case of failure in resume

Enzo Matsumiya (1):
      smb: client: destroy cfid_put_wq on module exit

Eric Biggers (1):
      mmc: sdhci-msm: fix crypto key eviction

Eric Dumazet (4):
      net: restrict SO_REUSEPORT to inet sockets
      af_packet: fix vlan_get_tci() vs MSG_PEEK
      af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
      ila: serialize calls to nf_register_net_hooks()

Evgenii Shatokhin (1):
      pinctrl: mcp23s08: Fix sleeping in atomic context due to regmap locking

Filipe Manana (2):
      btrfs: allow swap activation to be interruptible
      btrfs: flush delalloc workers queue before stopping cleaner kthread during unmount

Greg Kroah-Hartman (1):
      Linux 6.12.9

Hardevsinh Palaniya (1):
      ARC: bpf: Correct conditional check in 'check_jmp_32'

Henry Huang (1):
      sched_ext: initialize kit->cursor.flags

Hobin Woo (1):
      ksmbd: retry iterate_dir in smb2_query_dir

Ilya Shchipletsov (1):
      netrom: check buffer length before accessing it

Issam Hamdi (1):
      wifi: mac80211: fix mbss changed flags corruption on 32 bit systems

Jakub Kicinski (1):
      netdev-genl: avoid empty messages in napi get

Jens Axboe (2):
      io_uring/net: always initialize kmsg->msg.msg_inq upfront
      io_uring/kbuf: use pre-committed buffer address for non-pollable file

Jianbo Liu (2):
      net/mlx5e: Skip restore TC rules for vport rep without loaded flag
      net/mlx5e: Keep netdev when leave switchdev for devlink set legacy only

Jinjian Song (1):
      net: wwan: t7xx: Fix FSM command timeout issue

Joe Hattori (4):
      platform/x86: mlx-platform: call pci_dev_put() to balance the refcount
      pmdomain: imx: gpcv2: fix an OF node reference leak in imx_gpcv2_probe()
      net: stmmac: restructure the error path of stmmac_probe_config_dt()
      net: mv643xx_eth: fix an OF node reference leak

Johannes Thumshirn (1):
      btrfs: handle bio_split() errors

John Harrison (1):
      drm/xe: Revert some changes that break a mesa debug tool

Joshua Washington (6):
      gve: process XSK TX descriptors as part of RX NAPI
      gve: clean XDP queues in gve_tx_stop_ring_gqi
      gve: guard XSK operations on the existence of queues
      gve: fix XDP allocation path in edge cases
      gve: guard XDP xmit NDO on existence of xdp queues
      gve: trigger RX NAPI instead of TX NAPI in gve_xsk_wakeup

Kalesh AP (4):
      RDMA/bnxt_re: Fix the check for 9060 condition
      RDMA/bnxt_re: Fix reporting hw_ver in query_device
      RDMA/bnxt_re: Disable use of reserved wqes
      RDMA/bnxt_re: Fix error recovery sequence

Kan Liang (1):
      perf/x86/intel: Add Arrow Lake U support

Kashyap Desai (2):
      RDMA/bnxt_re: Fix max SGEs for the Work Request
      RDMA/bnxt_re: Avoid sending the modify QP workaround for latest adapters

Kees Cook (1):
      wifi: iwlwifi: mvm: Fix __counted_by usage in cfg80211_wowlan_nd_*

Kohei Enju (1):
      ftrace: Fix function profiler's filtering functionality

Kory Maincent (1):
      net: pse-pd: tps23881: Fix power on/off issue

Kuan-Wei Chiu (1):
      scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity

Leo Stone (1):
      nvmet: Don't overflow subsysnqn

Leon Romanovsky (2):
      RDMA/bnxt_re: Remove always true dattr validity check
      ARC: build: Try to guess GCC variant of cross compiler

Li Zhijian (1):
      RDMA/rtrs: Ensure 'ib_sge list' is accessible

Liang Jie (1):
      net: sfc: Correct key_len for efx_tc_ct_zone_ht_params

Liu Shixin (1):
      mm: hugetlb: independent PMD page table shared count

Lorenzo Stoakes (1):
      mm: reinstate ability to map write-sealed memfd mappings read-only

Lucas De Marchi (1):
      drm/xe: Fix fault on fd close after unbind

Lucas Stach (1):
      pmdomain: core: add dummy release function to genpd device

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix sleeping function called from invalid context

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix firmware load sequence.

Maciej S. Szmigiero (1):
      net: wwan: iosm: Properly check for valid exec stage in ipc_mmio_init()

Maksim Kiselev (1):
      clk: thead: Fix TH1520 emmc and shdci clock rate

Mark Zhang (1):
      RDMA/mlx5: Enable multiplane mode only when it is supported

Masahiro Yamada (1):
      modpost: fix the missed iteration for the max bit in do_input()

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init

Michal Wajdeczko (1):
      drm/xe/pf: Use correct function to check LMEM provisioning

Mingcong Bai (1):
      platform/x86: hp-wmi: mark 8A15 board for timed OMEN thermal profile

Mostafa Saleh (1):
      scripts/mksysmap: Fix escape chars '$'

Namjae Jeon (1):
      ksmbd: set ATTR_CTIME flags when setting mtime

Nikolaus Voss (1):
      clk: clk-imx8mp-audiomix: fix function signature

Nikolay Kuratov (1):
      net/sctp: Prevent autoclose integer overflow in sctp_association_init()

Niravkumar L Rabara (1):
      spi: spi-cadence-qspi: Disable STIG mode for Altera SoCFPGA.

Nirmoy Das (2):
      drm/xe: Use non-interruptible wait when moving BO to system
      drm/xe: Wait for migration job before unmapping pages

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: unaligned atomic read on struct nft_set_ext

Paolo Abeni (3):
      mptcp: fix TCP options overflow.
      mptcp: fix recvbuffer adjust on sleeping rcvmsg
      mptcp: don't always assume copied data in mptcp_cleanup_rbuf()

Pascal Hambourg (1):
      sky2: Add device ID 11ab:4373 for Marvell 88E8075

Patrisious Haddad (1):
      RDMA/mlx5: Enforce same type port association for multiport RoCE

Paul E. McKenney (1):
      ARC: build: Use __force to suppress per-CPU cmpxchg warnings

Pavel Begunkov (1):
      io_uring/rw: fix downgraded mshot read

Prike Liang (1):
      drm/amdkfd: Correct the migration DMA map direction

Robert Beckett (1):
      nvme-pci: 512 byte aligned dma pool segment quirk

Rodrigo Vivi (1):
      drm/i915/dg1: Fix power gate sequence.

Saravanan Vajravel (1):
      RDMA/bnxt_re: Add check for path mtu in modify_qp

Seiji Nishikawa (1):
      mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()

Selvin Xavier (3):
      RDMA/bnxt_re: Avoid initializing the software queue for user queues
      RDMA/bnxt_re: Fix max_qp_wrs reported
      RDMA/bnxt_re: Fix the locking while accessing the QP table

SeongJae Park (2):
      mm/damon/core: fix ignored quota goals and filters of newly committed schemes
      mm/damon/core: fix new damon_target objects leaks on damon_commit_targets()

Shahar Shitrit (1):
      net/mlx5: DR, select MSIX vector 0 for completion queue creation

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw: default to round-robin for host port receive

Simon Trimmer (1):
      ALSA: hda: cs35l56: Remove calls to cs35l56_force_sync_asp1_registers_from_cache()

Stefan Ekenberg (1):
      drm/bridge: adv7511_audio: Update Audio InfoFrame properly

Stephen Gordon (1):
      ASoC: audio-graph-card: Call of_node_put() on correct node

Steven Rostedt (1):
      tracing: Have process_string() also allow arrays

Su Hui (1):
      workqueue: add printf attribute to __alloc_workqueue()

Suraj Kandpal (1):
      drm/i915/cx0_phy: Fix C10 pll programming sequence

Takashi Iwai (4):
      ALSA: hda/ca0132: Use standard HD-audio quirk matching helpers
      Revert "ALSA: ump: Don't enumeration invalid groups for legacy rawmidi"
      ALSA: seq: Check UMP support for midi_version change
      ALSA: seq: oss: Fix races at processing SysEx messages

Tanya Agarwal (1):
      ALSA: usb-audio: US16x08: Initialize array before use

Tejun Heo (1):
      sched_ext: Fix invalid irq restore in scx_ops_bypass()

Thiébaud Weksteen (1):
      selinux: ignore unknown extended permissions

Thomas Weißschuh (1):
      kbuild: pacman-pkg: provide versioned linux-api-headers package

Tristram Ha (2):
      net: dsa: microchip: Fix KSZ9477 set_ageing_time function
      net: dsa: microchip: Fix LAN937X set_ageing_time function

Tvrtko Ursulin (1):
      workqueue: Do not warn when cancelling WQ_MEM_RECLAIM work from !WQ_MEM_RECLAIM worker

Uros Bizjak (1):
      irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base

Vasiliy Kovalev (2):
      ALSA: hda/realtek - Add support for ASUS Zen AIO 27 Z272SD_A272SD audio
      ALSA: hda/realtek: Add new alc2xx-fixup-headset-mic model

Victor Zhao (1):
      drm/amdgpu: use sjt mec fw on gfx943 for sriov

Vineet Gupta (1):
      ARC: build: disallow invalid PAE40 + 4K page config

Vishnu Sankar (1):
      platform/x86: thinkpad-acpi: Add support for hotkey 0x1401

Vitalii Mordan (1):
      eth: bcmsysport: fix call balance of priv->clk handling routines

Vladimir Oltean (1):
      selftests: net: local_termination: require mausezahn

Wang Liang (1):
      net: fix memory leak in tcp_conn_request()

Wei Fang (1):
      net: phy: micrel: Dynamically control external clock of KSZ PHY

Willem de Bruijn (1):
      net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets

Xiao Liang (1):
      net: Fix netns for ip_tunnel_init_flow()

Yafang Shao (1):
      mm/readahead: fix large folio support in async readahead

Yang Erkun (1):
      maple_tree: reload mas before the second call for mas_empty_area

Zhu Yanjun (1):
      RDMA/rxe: Remove the direct link to net_device

Zilin Guan (1):
      fgraph: Add READ_ONCE() when accessing fgraph_array[]

guanjing (1):
      sched_ext: fix application of sizeof to pointer

wenglianfa (1):
      RDMA/hns: Fix mapping error of zero-hop WQE buffer


