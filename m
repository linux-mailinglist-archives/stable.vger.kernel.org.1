Return-Path: <stable+bounces-66359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3972A94E0F8
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 13:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCAAB21030
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAF487B0;
	Sun, 11 Aug 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IEurU9bS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E49938F83;
	Sun, 11 Aug 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723375394; cv=none; b=PYkxuthPYw4jlOu+t3swW5LtDLP8+JupHw18/VtArNgN4JlnVxkE9xU6D93hy+hsbkvrrN0w6Vy1DXItP74SlI+DkkrWIctljNfpWYnMrtnhp+y0J/xP+XpGraStv05GL2/bwtCI58Iyq+AVwbkd66DDKAgNqMS5wrGI4nJESb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723375394; c=relaxed/simple;
	bh=3N/hSryftXl9eIKegRKD/YNZzH0RuyM4c1h+2Aallw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oHqyQd7rzlXT6oeR+/Gvsusc7/NHTuz4wEj1N/ISP7K7drSNsLvVlMphPzuWRkGnxvJWLM/CjV6DH+32l6mOJygGMBr5l+kHgVUqxLHbJHXZwC20jMAvsPsYfVFu9SF1df/kqR55mN0+H7kGLYJQEXAEZTuFpY2YtLIc+iinxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IEurU9bS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FDFC32786;
	Sun, 11 Aug 2024 11:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723375393;
	bh=3N/hSryftXl9eIKegRKD/YNZzH0RuyM4c1h+2Aallw0=;
	h=From:To:Cc:Subject:Date:From;
	b=IEurU9bSwDnnIHlbXBWlN9rCwNUJu9QqgofdT57RQX1bquzqCCM0UWXtDbxINSqZG
	 ANd9n3tCVmOZ9kDY0UXdXlLbGs16nv06ggfbg18Nvlhi7u0ihSlcaJ3ocNycV7zHbl
	 pxpmSjyrpprVaUsLEybobmeTyKMwbSvcdpb7vmxQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.4
Date: Sun, 11 Aug 2024 13:23:04 +0200
Message-ID: <2024081104-pelican-fiction-fad3@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.4 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/mm/transhuge.rst                       |   11 
 Documentation/netlink/specs/ethtool.yaml                         |    2 
 Documentation/networking/ethtool-netlink.rst                     |    1 
 Makefile                                                         |    2 
 arch/arm/kernel/perf_callchain.c                                 |    3 
 arch/arm/mm/proc.c                                               |   20 
 arch/arm64/include/asm/jump_label.h                              |    1 
 arch/arm64/kernel/jump_label.c                                   |   11 
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi               |   81 +
 arch/riscv/kernel/sbi-ipi.c                                      |    2 
 arch/riscv/mm/fault.c                                            |   17 
 arch/riscv/mm/init.c                                             |   15 
 arch/riscv/purgatory/entry.S                                     |    2 
 arch/s390/kernel/fpu.c                                           |    2 
 arch/s390/mm/dump_pagetables.c                                   |   21 
 arch/x86/events/intel/core.c                                     |  162 +--
 drivers/bluetooth/btintel.c                                      |    3 
 drivers/gpu/drm/Kconfig                                          |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                           |   16 
 drivers/gpu/drm/ast/ast_dp.c                                     |    7 
 drivers/gpu/drm/ast/ast_drv.c                                    |    5 
 drivers/gpu/drm/ast/ast_drv.h                                    |    1 
 drivers/gpu/drm/ast/ast_mode.c                                   |   29 
 drivers/gpu/drm/drm_atomic_uapi.c                                |    5 
 drivers/gpu/drm/drm_client.c                                     |    2 
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c                    |    6 
 drivers/gpu/drm/i915/display/intel_hdcp_regs.h                   |    2 
 drivers/gpu/drm/i915/i915_perf.c                                 |   33 
 drivers/gpu/drm/nouveau/nouveau_prime.c                          |    3 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                           |    1 
 drivers/gpu/drm/v3d/v3d_drv.h                                    |    4 
 drivers/gpu/drm/v3d/v3d_sched.c                                  |   44 
 drivers/gpu/drm/v3d/v3d_submit.c                                 |  121 +-
 drivers/gpu/drm/virtio/virtgpu_submit.c                          |    2 
 drivers/gpu/drm/vmwgfx/vmw_surface_cache.h                       |   10 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                               |  127 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                               |   15 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                              |   40 
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                            |   17 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                              |  502 ++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                              |   17 
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                              |   14 
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c                          |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c                            |   32 
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c                         |   27 
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c                             |   33 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                             |  174 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                          |  280 +++++
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c                             |   40 
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                         |   18 
 drivers/hid/wacom_wac.c                                          |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                        |    6 
 drivers/net/ethernet/intel/ice/ice.h                             |   11 
 drivers/net/ethernet/intel/ice/ice_base.c                        |    4 
 drivers/net/ethernet/intel/ice/ice_main.c                        |    2 
 drivers/net/ethernet/intel/ice/ice_txrx.c                        |   10 
 drivers/net/ethernet/intel/ice/ice_xsk.c                         |  184 ++-
 drivers/net/ethernet/intel/ice/ice_xsk.h                         |   14 
 drivers/net/ethernet/intel/igc/igc_main.c                        |   33 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                  |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c             |    7 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c               |    5 
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c           |   10 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                |    2 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c          |    1 
 drivers/net/ethernet/realtek/r8169_main.c                        |    8 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                |    2 
 drivers/net/phy/micrel.c                                         |   34 
 drivers/net/phy/realtek.c                                        |    7 
 drivers/net/usb/sr9700.c                                         |   11 
 drivers/net/wan/fsl_qmc_hdlc.c                                   |   31 
 drivers/net/wireless/ath/ath12k/pci.c                            |    3 
 drivers/pci/hotplug/pciehp_hpc.c                                 |    4 
 drivers/perf/fsl_imx9_ddr_perf.c                                 |    6 
 drivers/perf/riscv_pmu_sbi.c                                     |    2 
 drivers/platform/chrome/cros_ec_proto.c                          |    2 
 fs/btrfs/block-group.c                                           |   13 
 fs/btrfs/extent-tree.c                                           |    3 
 fs/btrfs/free-space-cache.c                                      |    4 
 fs/btrfs/inode.c                                                 |   16 
 fs/btrfs/space-info.c                                            |    5 
 fs/btrfs/space-info.h                                            |    1 
 fs/ceph/caps.c                                                   |   35 
 fs/ceph/super.h                                                  |    7 
 fs/ext4/inode.c                                                  |   76 +
 fs/f2fs/segment.c                                                |    4 
 fs/file.c                                                        |    1 
 include/linux/cpuhotplug.h                                       |    1 
 include/linux/huge_mm.h                                          |   12 
 include/linux/migrate.h                                          |    7 
 include/trace/events/btrfs.h                                     |    8 
 include/trace/events/mptcp.h                                     |    2 
 init/Kconfig                                                     |    1 
 io_uring/poll.c                                                  |    1 
 mm/huge_memory.c                                                 |   20 
 mm/khugepaged.c                                                  |   33 
 mm/memory.c                                                      |   11 
 mm/migrate.c                                                     |   94 -
 net/bluetooth/hci_core.c                                         |    7 
 net/bluetooth/hci_event.c                                        |    5 
 net/bluetooth/hci_sync.c                                         |   21 
 net/core/rtnetlink.c                                             |    2 
 net/ethtool/ioctl.c                                              |    5 
 net/ethtool/rss.c                                                |    8 
 net/ipv4/netfilter/iptable_nat.c                                 |   18 
 net/ipv4/tcp_input.c                                             |   23 
 net/ipv6/ndisc.c                                                 |   34 
 net/ipv6/netfilter/ip6table_nat.c                                |   14 
 net/iucv/af_iucv.c                                               |    4 
 net/mac80211/cfg.c                                               |    7 
 net/mac80211/tx.c                                                |    5 
 net/mac80211/util.c                                              |    2 
 net/mptcp/mib.c                                                  |    2 
 net/mptcp/mib.h                                                  |    2 
 net/mptcp/options.c                                              |    2 
 net/mptcp/pm.c                                                   |   12 
 net/mptcp/pm_netlink.c                                           |   46 
 net/mptcp/pm_userspace.c                                         |   18 
 net/mptcp/protocol.c                                             |   18 
 net/mptcp/protocol.h                                             |    4 
 net/mptcp/subflow.c                                              |   26 
 net/sched/act_ct.c                                               |    4 
 net/wireless/scan.c                                              |   11 
 net/wireless/sme.c                                               |    1 
 sound/core/seq/seq_ump_convert.c                                 |   37 
 sound/firewire/amdtp-stream.c                                    |   38 
 sound/firewire/amdtp-stream.h                                    |    1 
 sound/pci/hda/hda_controller.h                                   |    2 
 sound/pci/hda/hda_intel.c                                        |   10 
 sound/pci/hda/patch_conexant.c                                   |   54 -
 sound/pci/hda/patch_realtek.c                                    |    1 
 sound/usb/stream.c                                               |    4 
 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json        |    2 
 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json         |    2 
 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json        |    2 
 tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json |    2 
 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json |    2 
 tools/perf/util/callchain.c                                      |    2 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                |    8 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                  |   74 +
 143 files changed, 2028 insertions(+), 1273 deletions(-)

Al Viro (1):
      protect the fetch of ->fd[fd] in do_dup2() from mispredictions

Alexandra Winter (1):
      net/iucv: fix use after free in iucv_sock_close()

Alice Ryhl (1):
      rust: SHADOW_CALL_STACK is incompatible with Rust

André Almeida (2):
      drm/atomic: Allow userspace to use explicit sync with atomic async flips
      drm/atomic: Allow userspace to use damage clips with async flips

Andy Chiu (1):
      net: axienet: start napi before enabling Rx/Tx

Basavaraj Natikar (1):
      HID: amd_sfh: Move sensor discovery before HID device initialization

Blazej Kucman (1):
      PCI: pciehp: Retain Power Indicator bits for userspace indicators

Boris Burkov (1):
      btrfs: make cow_file_range_inline() honor locked_page on error

Casey Chen (1):
      perf tool: fix dereferencing NULL al->maps

Chris Mi (1):
      net/mlx5e: Fix CT entry update leaks of modify header context

Christian König (1):
      drm/amdgpu: fix contiguous handling for IB parsing v2

Dan Carpenter (2):
      drm/client: Fix error code in drm_client_buffer_vmap_local()
      net: mvpp2: Don't re-use loop iterator

Daniel Maslowski (1):
      riscv/purgatory: align riscv_kernel_entry

Danilo Krummrich (2):
      drm/gpuvm: fix missing dependency to DRM_EXEC
      drm/nouveau: prime: fix refcount underflow

Dave Airlie (1):
      nouveau: set placement to original placement on uvmm validate.

David Hildenbrand (2):
      mm/migrate: make migrate_misplaced_folio() return 0 on success
      mm/migrate: move NUMA hinting fault folio isolation + checks under PTL

Dmitry Osipenko (1):
      drm/virtio: Fix type of dma-fence context variable

Edmund Raile (2):
      Revert "ALSA: firewire-lib: obsolete workqueue for period update"
      Revert "ALSA: firewire-lib: operate for period elapse event in process context"

Eric Dumazet (1):
      sched: act_ct: take care of padding in struct zones_ht_key

Eric Lin (1):
      perf arch events: Fix duplicate RISC-V SBI firmware event name

Faizal Rahim (1):
      igc: Fix double reset adapter triggered from a single taprio cmd

Greg Kroah-Hartman (1):
      Linux 6.10.4

Heiko Carstens (2):
      s390/mm/ptdump: Fix handling of identity mapping area
      s390/fpu: Re-add exception handling in load_fpu_state()

Heiner Kallweit (1):
      r8169: don't increment tx_dropped in case of NETDEV_TX_BUSY

Herve Codina (2):
      net: wan: fsl_qmc_hdlc: Convert carrier_lock spinlock to a mutex
      net: wan: fsl_qmc_hdlc: Discard received CRC

Ian Forbes (2):
      drm/vmwgfx: Fix overlay when using Screen Targets
      drm/vmwgfx: Trigger a modeset when the screen moves

Jaegeuk Kim (1):
      f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid

Jakub Kicinski (3):
      netlink: specs: correct the spec of ethtool
      ethtool: rss: echo the context number back
      ethtool: fix setting key and resetting indir at once

Jammy Huang (1):
      drm/ast: Fix black screen after resume

Jiaxun Yang (3):
      MIPS: Loongson64: DTS: Fix PCIe port nodes for ls7a
      MIPS: dts: loongson: Fix liointc IRQ polarity
      MIPS: dts: loongson: Fix ls2k1000-rtc interrupt

Jinjie Ruan (1):
      ARM: 9406/1: Fix callchain_trace() return value

Johan Hovold (1):
      wifi: ath12k: fix soft lockup on suspend

Johannes Berg (2):
      wifi: cfg80211: correct S1G beacon length calculation
      wifi: mac80211: use monitor sdata with driver only if desired

Kan Liang (1):
      perf/x86/intel: Add a distinct name for Granite Rapids

Kiran K (1):
      Bluetooth: btintel: Fail setup on error

Kuniyuki Iwashima (3):
      rtnetlink: Don't ignore IFLA_TARGET_NETNSID when ifname is specified in rtnl_dellink().
      netfilter: iptables: Fix null-ptr-deref in iptable_nat_table_init().
      netfilter: iptables: Fix potential null-ptr-deref in ip6table_nat_table_init().

Linus Walleij (1):
      ARM: 9408/1: mm: CFI: Fix some erroneous reset prototypes

Liu Jing (1):
      selftests: mptcp: always close input's FD if opened

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix suspending with wrong filter policy
      Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scanning

Ma Ke (1):
      net: usb: sr9700: fix uninitialized variable use in sr_mdio_read

Maciej Fijalkowski (7):
      ice: don't busy wait for Rx queue disable in ice_qp_dis()
      ice: replace synchronize_rcu with synchronize_net
      ice: modify error handling when setting XSK pool in ndo_bpf
      ice: toggle netif_carrier when setting up XSK pool
      ice: improve updating ice_{t,r}x_ring::xsk_pool
      ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
      ice: xsk: fix txq interrupt mapping

Maciej Żenczykowski (1):
      ipv6: fix ndisc_is_useropt() handling for PIO

Mark Bloch (1):
      net/mlx5: Lag, don't use the hardcoded value of the first port

Mark Mentovai (1):
      net: phy: realtek: add support for RTL8366S Gigabit PHY

Matthieu Baerts (NGI0) (7):
      mptcp: sched: check both directions for backup
      mptcp: distinguish rcv vs sent backup flag in requests
      mptcp: mib: count MPJ with backup flag
      mptcp: pm: fix backup support in signal endpoints
      mptcp: pm: only set request_bkup flag when sending MP_PRIO
      selftests: mptcp: join: validate backup in MPJ
      selftests: mptcp: join: check backup support in signal endp

Mavroudis Chatzilazaridis (1):
      ALSA: hda/realtek: Add quirk for Acer Aspire E5-574G

Michal Kubiak (1):
      ice: respect netif readiness in AF_XDP ZC related ndo's

Moshe Shemesh (1):
      net/mlx5: Fix missing lock on sync reset reload

Naohiro Aota (2):
      btrfs: zoned: fix zone_unusable accounting on making block group read-write again
      btrfs: do not subtract delalloc from avail bytes

Nick Hu (1):
      RISC-V: Enable the IPI before workqueue_online_cpu()

Nikita Zhandarovich (1):
      drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()

Olivier Langlois (1):
      io_uring: keep multishot request NAPI timeout current

Paolo Abeni (5):
      mptcp: fix user-space PM announced address accounting
      mptcp: fix NL PM announced address accounting
      mptcp: fix bad RCVPRUNED mib accounting
      mptcp: fix duplicate data handling
      selftests: mptcp: fix error path

Patryk Duda (1):
      platform/chrome: cros_ec_proto: Lock device when updating MKBP version

Pavan Chebbi (1):
      bnxt_en: Fix RSS logic in __bnxt_reserve_rings()

Peter Xu (1):
      mm/migrate: putback split folios when numa hint migration fails

Rahul Rameshbabu (1):
      net/mlx5e: Require mlx5 tc classifier action support for IPsec prio capability

Raju Lakkaraju (1):
      net: phy: micrel: Fix the KSZ9131 MDI-X status issue

Ran Xiaokai (1):
      mm/huge_memory: mark racy access onhuge_anon_orders_always

Ryan Roberts (1):
      mm: fix khugepaged activation policy

Shahar Shitrit (1):
      net/mlx5e: Add a check for the return value from mlx5_port_set_eth_ptys

Shay Drory (2):
      net/mlx5: Always drain health in shutdown callback
      net/mlx5: Fix error handling in irq_pool_request_irq

Shifrin Dmitry (1):
      perf: riscv: Fix selecting counters in legacy mode

Stuart Menefy (1):
      riscv: Fix linear mapping checks for non-contiguous memory regions

Subash Abhinov Kasiviswanathan (1):
      tcp: Adjust clamping window for applications specifying SO_RCVBUF

Suraj Kandpal (1):
      drm/i915/hdcp: Fix HDCP2_STREAM_STATUS macro

Takashi Iwai (3):
      ALSA: hda: Conditionally use snooping for AMD HDMI
      ALSA: usb-audio: Correct surround channels in UAC1 channel map
      ALSA: seq: ump: Optimize conversions from SysEx to UMP

Tatsunosuke Tobita (1):
      HID: wacom: Modify pen IDs

Thomas Zimmermann (1):
      drm/ast: astdp: Wake up during connector status detection

Tony Luck (1):
      perf/x86/intel: Switch to new Intel CPU model defines

Tvrtko Ursulin (5):
      drm/v3d: Prevent out of bounds access in performance query extensions
      drm/v3d: Fix potential memory leak in the timestamp extension
      drm/v3d: Fix potential memory leak in the performance extension
      drm/v3d: Validate passed in drm syncobj handles in the timestamp extension
      drm/v3d: Validate passed in drm syncobj handles in the performance extension

Umesh Nerlige Ramappa (1):
      i915/perf: Remove code to update PWR_CLK_STATE for gen12

Veerendranath Jakkam (1):
      wifi: cfg80211: fix reporting failed MLO links status with cfg80211_connect_done

Will Deacon (1):
      arm64: jump_label: Ensure patched jump_labels are visible to all CPUs

Xiubo Li (1):
      ceph: force sending a cap update msg back to MDS for revoke op

Xu Yang (1):
      perf: imx_perf: fix counter start and config sequence

Zack Rusin (3):
      drm/vmwgfx: Make sure the screen surface is ref counted
      drm/vmwgfx: Fix a deadlock in dma buf fence polling
      drm/vmwgfx: Fix handling of dumb buffers

Zhang Yi (2):
      ext4: factor out a common helper to query extent map
      ext4: check the extent status again before inserting delalloc block

Zhe Qiao (1):
      riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()

Zhiguo Niu (1):
      f2fs: fix to avoid use SSR allocate when do defragment

songxiebing (1):
      ALSA: hda: conexant: Fix headset auto detect fail in the polling mode


