Return-Path: <stable+bounces-105341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C76E9F825D
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F59A1891434
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB721B041E;
	Thu, 19 Dec 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MjsJTOFs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD61B040D;
	Thu, 19 Dec 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629924; cv=none; b=JrReqL0Db/lzDq5eIFV+3FdjElvOY2WYyvnKQeH08RXCQNzH9Jx/+FWVFSiTx9fzmEXbdkbhnvHOVi6IObW7bKokGh+Sq2ng//ADzZR51xYY91hUd5YSS7j+8ve1K5asfQxq6gZr2vrNno/jKkj6WNFPvjrpV5Yw48KWQs2Wr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629924; c=relaxed/simple;
	bh=Y9tZGaOaXQf1C4GQdY1JGqDXc437WLlvqh3BuqfgC0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b0jayovjDufQD++8SAYn0mM0KZlwKD7CxIIt77TVPJWQZVxWUx1VaL3V/W19k921epf/c1HcRl+VtnEy2qPRz7CC+NwdhNq8OFKCl1qIiPDNl1dHI1af38Pqw0CctrrsvnPIKmxvSzH/r8Pt+hgIdI/Zxj/0o7IJSXM/jlDGIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MjsJTOFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653C1C4CECE;
	Thu, 19 Dec 2024 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734629924;
	bh=Y9tZGaOaXQf1C4GQdY1JGqDXc437WLlvqh3BuqfgC0I=;
	h=From:To:Cc:Subject:Date:From;
	b=MjsJTOFs2qwVpNx+TfhoRaHX4b9AwIsJcqAdZPkGL7BzTAKtvEuTgUY5cHsCPNky3
	 h33bAseG/2kuLThVJ0/sD1ZngjBrCXvSn+KEkR6o2U45ZZ3BkmAmqKor7Q7RQiyyan
	 GlK/26R7X1nAL8uU9S8N8EacgFMBnXQ0iXgdwpwQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.6
Date: Thu, 19 Dec 2024 18:38:25 +0100
Message-ID: <2024121926-banjo-gem-06ff@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.6 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/networking/ip-sysctl.rst                       |    6 
 Documentation/power/runtime_pm.rst                           |    4 
 Makefile                                                     |    2 
 arch/arm64/kvm/sys_regs.c                                    |   55 +
 arch/riscv/include/asm/kfence.h                              |    4 
 arch/riscv/kernel/setup.c                                    |    2 
 arch/riscv/mm/init.c                                         |    7 
 arch/x86/events/intel/ds.c                                   |    2 
 arch/x86/include/asm/processor.h                             |    2 
 arch/x86/include/asm/static_call.h                           |   15 
 arch/x86/include/asm/sync_core.h                             |    6 
 arch/x86/include/asm/xen/hypercall.h                         |   36 
 arch/x86/kernel/callthunks.c                                 |    5 
 arch/x86/kernel/cpu/common.c                                 |   38 
 arch/x86/kernel/static_call.c                                |    9 
 arch/x86/xen/enlighten.c                                     |   64 +
 arch/x86/xen/enlighten_hvm.c                                 |   13 
 arch/x86/xen/enlighten_pv.c                                  |    4 
 arch/x86/xen/enlighten_pvh.c                                 |    7 
 arch/x86/xen/xen-asm.S                                       |   50 -
 arch/x86/xen/xen-head.S                                      |  106 +-
 arch/x86/xen/xen-ops.h                                       |    9 
 block/blk-cgroup.c                                           |    6 
 block/blk-iocost.c                                           |    9 
 block/blk-mq-sysfs.c                                         |   16 
 block/blk-mq.c                                               |  127 ++
 block/blk-sysfs.c                                            |    4 
 block/blk-zoned.c                                            |  524 ++++-------
 drivers/acpi/acpica/evxfregn.c                               |    2 
 drivers/acpi/nfit/core.c                                     |    7 
 drivers/acpi/resource.c                                      |    6 
 drivers/ata/sata_highbank.c                                  |    1 
 drivers/bluetooth/btmtk.c                                    |   20 
 drivers/clk/clk-en7523.c                                     |    5 
 drivers/crypto/hisilicon/debugfs.c                           |    4 
 drivers/gpio/gpio-graniterapids.c                            |   52 -
 drivers/gpio/gpio-ljca.c                                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                       |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                       |   13 
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                        |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                        |   24 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c        |   15 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                     |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c       |   12 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c         |    1 
 drivers/gpu/drm/drm_panic_qr.rs                              |    1 
 drivers/gpu/drm/i915/display/intel_color.c                   |   30 
 drivers/gpu/drm/i915/i915_gpu_error.c                        |   18 
 drivers/gpu/drm/i915/i915_scheduler.c                        |    2 
 drivers/gpu/drm/xe/tests/xe_migrate.c                        |    4 
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c                  |    8 
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h                  |    1 
 drivers/gpu/drm/xe/xe_pt.c                                   |    3 
 drivers/gpu/drm/xe/xe_reg_sr.c                               |   31 
 drivers/gpu/drm/xe/xe_reg_sr_types.h                         |    6 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c               |    2 
 drivers/iommu/intel/cache.c                                  |   34 
 drivers/iommu/intel/iommu.c                                  |    4 
 drivers/md/dm-zoned-reclaim.c                                |    6 
 drivers/net/bonding/bond_main.c                              |   10 
 drivers/net/dsa/microchip/ksz_common.c                       |   42 
 drivers/net/dsa/ocelot/felix_vsc9959.c                       |   17 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                    |   14 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                    |    9 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h                   |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c              |    2 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                   |    5 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c |    4 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c          |   11 
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c          |    2 
 drivers/net/ethernet/microsoft/mana/gdma_main.c              |    6 
 drivers/net/ethernet/mscc/ocelot_ptp.c                       |  209 ++--
 drivers/net/ethernet/qualcomm/qca_spi.c                      |   26 
 drivers/net/ethernet/qualcomm/qca_spi.h                      |    1 
 drivers/net/ethernet/renesas/rswitch.c                       |   85 +
 drivers/net/ethernet/renesas/rswitch.h                       |   14 
 drivers/net/team/team_core.c                                 |   11 
 drivers/net/virtio_net.c                                     |   24 
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c            |    2 
 drivers/net/xen-netfront.c                                   |    5 
 drivers/ptp/ptp_kvm_x86.c                                    |    6 
 drivers/regulator/axp20x-regulator.c                         |   36 
 drivers/spi/spi-aspeed-smc.c                                 |   10 
 drivers/spi/spi-rockchip.c                                   |   14 
 drivers/tty/serial/sh-sci.c                                  |   29 
 drivers/ufs/core/ufshcd.c                                    |    1 
 drivers/usb/core/hcd.c                                       |    8 
 drivers/usb/dwc2/hcd.c                                       |   19 
 drivers/usb/dwc3/dwc3-imx8mp.c                               |   30 
 drivers/usb/dwc3/dwc3-xilinx.c                               |    5 
 drivers/usb/gadget/function/f_midi2.c                        |    6 
 drivers/usb/gadget/function/u_serial.c                       |    9 
 drivers/usb/host/ehci-sh.c                                   |    9 
 drivers/usb/host/max3421-hcd.c                               |   16 
 drivers/usb/misc/onboard_usb_dev.c                           |    4 
 drivers/usb/typec/anx7411.c                                  |   66 -
 drivers/usb/typec/ucsi/ucsi.c                                |    6 
 drivers/virtio/virtio_ring.c                                 |    6 
 fs/smb/client/inode.c                                        |    5 
 fs/smb/server/auth.c                                         |    2 
 fs/smb/server/mgmt/user_session.c                            |    6 
 fs/smb/server/server.c                                       |    4 
 fs/smb/server/smb2pdu.c                                      |   27 
 fs/xfs/libxfs/xfs_btree.c                                    |   33 
 fs/xfs/libxfs/xfs_btree.h                                    |    2 
 fs/xfs/libxfs/xfs_ialloc_btree.c                             |    4 
 fs/xfs/libxfs/xfs_symlink_remote.c                           |    4 
 fs/xfs/scrub/agheader.c                                      |    6 
 fs/xfs/scrub/agheader_repair.c                               |    6 
 fs/xfs/scrub/fscounters.c                                    |    2 
 fs/xfs/scrub/ialloc.c                                        |    4 
 fs/xfs/scrub/refcount.c                                      |    2 
 fs/xfs/scrub/symlink_repair.c                                |    3 
 fs/xfs/scrub/trace.h                                         |    2 
 fs/xfs/xfs_bmap_util.c                                       |    2 
 fs/xfs/xfs_file.c                                            |    8 
 fs/xfs/xfs_rtalloc.c                                         |    2 
 fs/xfs/xfs_trans.c                                           |   19 
 include/linux/blkdev.h                                       |    5 
 include/linux/bpf.h                                          |   19 
 include/linux/compiler.h                                     |   37 
 include/linux/dsa/ocelot.h                                   |    1 
 include/linux/netdev_features.h                              |    7 
 include/linux/static_call.h                                  |    6 
 include/linux/virtio.h                                       |    3 
 include/net/bluetooth/bluetooth.h                            |   10 
 include/net/lapb.h                                           |    2 
 include/net/mac80211.h                                       |    4 
 include/net/net_namespace.h                                  |    1 
 include/net/netfilter/nf_tables.h                            |    4 
 include/soc/mscc/ocelot.h                                    |    2 
 kernel/bpf/btf.c                                             |  149 +++
 kernel/bpf/verifier.c                                        |   79 -
 kernel/sched/deadline.c                                      |    2 
 kernel/static_call_inline.c                                  |    2 
 kernel/trace/bpf_trace.c                                     |   11 
 kernel/trace/trace_uprobe.c                                  |    6 
 mm/slub.c                                                    |   21 
 net/batman-adv/translation-table.c                           |   58 -
 net/bluetooth/hci_event.c                                    |   33 
 net/bluetooth/hci_sock.c                                     |   14 
 net/bluetooth/iso.c                                          |   69 +
 net/bluetooth/l2cap_sock.c                                   |   20 
 net/bluetooth/rfcomm/sock.c                                  |    9 
 net/bluetooth/sco.c                                          |   40 
 net/core/net_namespace.c                                     |   20 
 net/core/sock_map.c                                          |    6 
 net/dsa/tag_ocelot_8021q.c                                   |    2 
 net/ipv4/tcp_output.c                                        |    6 
 net/mac80211/cfg.c                                           |    9 
 net/mac80211/ieee80211_i.h                                   |   49 -
 net/mac80211/iface.c                                         |   12 
 net/mac80211/mlme.c                                          |    2 
 net/mac80211/util.c                                          |   23 
 net/netfilter/nf_tables_api.c                                |   32 
 net/netfilter/xt_IDLETIMER.c                                 |   52 -
 net/sched/sch_netem.c                                        |   22 
 net/tipc/udp_media.c                                         |    7 
 net/unix/af_unix.c                                           |    1 
 net/wireless/nl80211.c                                       |    2 
 net/wireless/sme.c                                           |    1 
 rust/Makefile                                                |   15 
 sound/core/control_led.c                                     |   14 
 sound/pci/hda/patch_realtek.c                                |    1 
 sound/soc/amd/yc/acp6x-mach.c                                |   13 
 sound/soc/codecs/tas2781-i2c.c                               |    2 
 sound/soc/fsl/fsl_spdif.c                                    |    2 
 sound/soc/fsl/fsl_xcvr.c                                     |    2 
 sound/soc/intel/boards/sof_sdw.c                             |    8 
 sound/usb/quirks.c                                           |    2 
 tools/lib/perf/evlist.c                                      |   18 
 tools/objtool/check.c                                        |    9 
 tools/perf/builtin-ftrace.c                                  |    3 
 tools/perf/util/build-id.c                                   |    4 
 tools/perf/util/machine.c                                    |    2 
 tools/testing/selftests/arm64/abi/syscall-abi-asm.S          |   32 
 tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c     |    6 
 tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c  |    4 
 tools/testing/selftests/bpf/progs/verifier_d_path.c          |    4 
 tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh    |   55 -
 tools/testing/selftests/net/netfilter/rpath.sh               |   18 
 182 files changed, 2197 insertions(+), 1291 deletions(-)

Alan Borzeszkowski (5):
      gpio: graniterapids: Fix GPIO Ack functionality
      gpio: graniterapids: Fix vGPIO driver crash
      gpio: graniterapids: Fix incorrect BAR assignment
      gpio: graniterapids: Determine if GPIO pad can be used by driver
      gpio: graniterapids: Check if GPIO line can be used for IRQs

Alexandre Ghiti (2):
      riscv: Fix wrong usage of __pa() on a fixmap address
      riscv: Fix IPIs usage in kfence_protect_page()

Andrew Martin (1):
      drm/amdkfd: Dereference null return value

Anumula Murali Mohan Reddy (1):
      cxgb4: use port number to set mac addr

Arnaldo Carvalho de Melo (1):
      perf machine: Initialize machine->env to address a segfault

Benjamin Lin (1):
      wifi: mac80211: fix station NSS capability initialization order

Björn Töpel (1):
      riscv: mm: Do not call pmd dtor on vmemmap page table teardown

Charles Keepax (1):
      ASoC: Intel: sof_sdw: Add space for a terminator into DAIs array

Chenghai Huang (1):
      crypto: hisilicon/debugfs - fix the struct pointer incorrectly offset problem

Christian König (2):
      drm/amdgpu: fix UVD contiguous CS mapping problem
      drm/amdgpu: fix when the cleaner shader is emitted

Christian Loehle (1):
      spi: rockchip: Fix PM runtime count on no-op cs

Christian Marangi (1):
      clk: en7523: Fix wrong BUS clock for EN7581

Christophe JAILLET (1):
      spi: aspeed: Fix an error handling path in aspeed_spi_[read|write]_user()

Claudiu Beznea (1):
      serial: sh-sci: Check if TX data was written to device in .tx_empty()

Damien Le Moal (5):
      block: Switch to using refcount_t for zone write plugs
      block: Use a zone write plug BIO work for REQ_NOWAIT BIOs
      dm: Fix dm-zoned-reclaim zone write pointer alignment
      block: Prevent potential deadlocks in zone write plug error recovery
      block: Ignore REQ_NOWAIT for zone reset and zone finish operations

Dan Carpenter (1):
      net/mlx5: DR, prevent potential error pointer dereference

Daniel Borkmann (5):
      net, team, bonding: Add netdev_base_features helper
      bonding: Fix initial {vlan,mpls}_feature set in bond_compute_features
      bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
      team: Fix initial vlan_feature set in __team_compute_features
      team: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL

Daniel Machon (2):
      net: sparx5: fix FDMA performance issue
      net: sparx5: fix the maximum frame length register

Daniele Ceraolo Spurio (1):
      drm/xe: Call invalidation_fence_fini for PT inval fences in error state

Danielle Ratson (3):
      selftests: mlxsw: sharedbuffer: Remove h1 ingress test case
      selftests: mlxsw: sharedbuffer: Remove duplicate test cases
      selftests: mlxsw: sharedbuffer: Ensure no extra packets are counted

Daniil Tatianin (1):
      ACPICA: events/evxfregn: don't release the ContextMutex that was never acquired

Darrick J. Wong (9):
      xfs: set XFS_SICK_INO_SYMLINK_ZAPPED explicitly when zapping a symlink
      xfs: update btree keys correctly when _insrec splits an inode root block
      xfs: don't drop errno values when we fail to ficlone the entire range
      xfs: return a 64-bit block count from xfs_btree_count_blocks
      xfs: fix null bno_hint handling in xfs_rtallocate_rtg
      xfs: return from xfs_symlink_verify early on V4 filesystems
      xfs: fix scrub tracepoints when inode-rooted btrees are involved
      xfs: only run precommits once per transaction object
      xfs: unlock inodes when erroring out of xfs_trans_alloc_dir

David (Ming Qiang) Wu (1):
      amdgpu/uvd: get ring reference from rq scheduler

David Howells (1):
      cifs: Fix rmdir failure due to ongoing I/O on deleted file

Emmanuel Grumbach (1):
      wifi: mac80211: fix a queue stall in certain cases of CSA

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
      Linux 6.12.6

Haoyu Li (3):
      gpio: ljca: Initialize num before accessing item in ljca_gpio_config
      wifi: mac80211: init cnt before accessing elem in ieee80211_copy_mbssid_beacon
      wifi: cfg80211: sme: init n_channels before channels[] access

Harish Kasiviswanathan (2):
      drm/amdkfd: hard-code cacheline size for gfx11
      drm/amdkfd: hard-code MALL cacheline size for gfx11, gfx12

Hridesh MG (1):
      ALSA: hda/realtek: Fix headset mic on Acer Nitro 5

Ilpo Järvinen (1):
      ACPI: resource: Fix memory resource type union access

Iulia Tanasescu (4):
      Bluetooth: iso: Always release hdev at the end of iso_listen_bis
      Bluetooth: iso: Fix recursive locking warning
      Bluetooth: iso: Fix circular lock in iso_listen_bis
      Bluetooth: iso: Fix circular lock in iso_conn_big_sync

Jaakko Salo (1):
      ALSA: usb-audio: Add implicit feedback quirk for Yamaha THR5

James Clark (1):
      libperf: evlist: Fix --cpu argument on hybrid platform

James Morse (1):
      KVM: arm64: Disable MPAM visibility by default and ignore VMM writes

Jann Horn (2):
      bpf: Fix UAF via mismatching bpf_prog/attachment RCU flavors
      bpf: Fix theoretical prog_array UAF in __uprobe_perf_func()

Jesse Van Gavere (1):
      net: dsa: microchip: KSZ9896 register regmap alignment to 32 bit boundaries

Jesse.zhang@amd.com (1):
      drm/amdkfd: pause autosuspend when creating pdd

Jiasheng Jiang (1):
      drm/i915: Fix memory leak by correcting cache object name in error handler

Jiri Olsa (1):
      bpf,perf: Fix invalid prog_array access in perf_event_detach_bpf_prog

Joe Hattori (3):
      ata: sata_highbank: fix OF node reference leak in highbank_initialize_phys()
      usb: typec: anx7411: fix fwnode_handle reference leak
      usb: typec: anx7411: fix OF node reference leaks in anx7411_typec_switch_probe()

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

Juri Lelli (1):
      sched/deadline: Fix replenish_dl_new_period dl_server condition

Kan Liang (1):
      perf/x86/intel/ds: Unconditionally drain PEBS DS when changing PEBS_DATA_CFG

Kenneth Feng (1):
      drm/amd/pm: Set SMU v13.0.7 default workload type

Koichiro Den (3):
      virtio_net: correct netdev_tx_reset_queue() invocation point
      virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
      virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize

Kuan-Wei Chiu (1):
      perf ftrace: Fix undefined behavior in cmp_profile_data()

Kumar Kartikeya Dwivedi (3):
      bpf: Revert "bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"
      bpf: Check size for BTF-based ctx access of pointer members
      bpf: Augment raw_tp arguments with PTR_MAYBE_NULL

Lianqin Hu (1):
      usb: gadget: u_serial: Fix the issue that gs_start_io crashed due to accessing null pointer

Lin Ma (1):
      wifi: nl80211: fix NL80211_ATTR_MLO_LINK_ID off-by-one

LongPing Wei (1):
      block: get wp_offset by bdev_offset_from_zone_start

Lu Baolu (1):
      iommu/vt-d: Remove cache tags before disabling ATS

Lucas De Marchi (1):
      drm/xe/reg_sr: Remove register pool

Luis Claudio R. Goncalves (1):
      iommu/tegra241-cmdqv: do not use smp_processor_id in preemptible context

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating

Mark Tomlinson (1):
      usb: host: max3421-hcd: Correctly abort a USB request.

Martin Ottens (1):
      net/sched: netem: account for backlog updates from child qdisc

Maxim Levitsky (2):
      net: mana: Fix memory leak in mana_gd_setup_irqs
      net: mana: Fix irq_contexts memory leak in mana_gd_setup_irqs

Michael Chan (2):
      bnxt_en: Fix GSO type for HW GRO packets on 5750X chips
      bnxt_en: Fix aggregation ID mask to prevent oops on 5760X chips

Michal Luczaj (3):
      bpf, sockmap: Fix race between element replace and close()
      bpf, sockmap: Fix update element with same
      Bluetooth: Improve setsockopt() handling of malformed user input

Miguel Ojeda (2):
      drm/panic: remove spurious empty line to clean warning
      rust: kbuild: set `bindgen`'s Rust target version

Ming Lei (1):
      blk-mq: move cpuhp callback registering out of q->sysfs_lock

Mirsad Todorovac (1):
      drm/xe: fix the ERR_PTR() returned on failure to allocate tiny pt

MoYuanhao (1):
      tcp: check space before adding MPTCP SYN options

Namhyung Kim (1):
      perf tools: Fix build-id event recording

Namjae Jeon (1):
      ksmbd: fix racy issue from session lookup and expire

Nathan Chancellor (1):
      blk-iocost: Avoid using clamp() on inuse in __propagate_weights()

Neal Frager (1):
      usb: dwc3: xilinx: make sure pipe clock is deselected in usb2 only mode

Nikita Yushchenko (6):
      net: renesas: rswitch: fix possible early skb release
      net: renesas: rswitch: fix race window between tx start and complete
      net: renesas: rswitch: fix leaked pointer on error path
      net: renesas: rswitch: avoid use-after-put for a device tree node
      net: renesas: rswitch: handle stop vs interrupt race
      net: renesas: rswitch: fix initial MPIC register setting

Nilay Shroff (1):
      block: Fix potential deadlock while freezing queue and acquiring sysfs_lock

Paul Barker (1):
      Documentation: PM: Clarify pm_runtime_resume_and_get() return value

Petr Machata (1):
      Documentation: networking: Add a caveat to nexthop_compat_mode sysctl

Phil Sutter (2):
      selftests: netfilter: Stabilize rpath.sh
      netfilter: IDLETIMER: Fix for possible ABBA deadlock

Philippe Simons (1):
      regulator: axp20x: AXP717: set ramp_delay

Radhey Shyam Pandey (1):
      usb: misc: onboard_usb_dev: skip suspend/resume sequence for USB5744 SMBus support

Remi Pommarel (3):
      batman-adv: Do not send uninitialized TT changes
      batman-adv: Remove uninitialized data in full table TT response
      batman-adv: Do not let TT changes list grows indefinitely

Robert Hodaszi (1):
      net: dsa: tag_ocelot_8021q: fix broken reception

Shakeel Butt (1):
      memcg: slub: fix SUnreclaim for post charged objects

Shankar Bandal (2):
      gpio: graniterapids: Fix invalid GPI_IS register offset
      gpio: graniterapids: Fix invalid RXEVCFG register bitmask

Shenghao Ding (1):
      ASoC: tas2781: Fix calibration issue in stress test

Shengjiu Wang (2):
      ASoC: fsl_xcvr: change IFACE_PCM to IFACE_MIXER
      ASoC: fsl_spdif: change IFACE_PCM to IFACE_MIXER

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

Venkata Prasad Potturu (1):
      ASoC: amd: yc: Fix the wrong return value

Ville Syrjälä (1):
      drm/i915/color: Stop using non-posted DSB writes for legacy LUT

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

Xu Yang (2):
      usb: core: hcd: only check primary hcd skip_phy_initialization
      usb: dwc3: imx8mp: fix software node kernel dump

Yi Liu (1):
      iommu/vt-d: Fix qi_batch NULL pointer with nested parent domain

liuderong (1):
      scsi: ufs: core: Update compl_time_stamp_local_clock after completing a cqe

Łukasz Bartosik (1):
      usb: typec: ucsi: Fix completion notifications


