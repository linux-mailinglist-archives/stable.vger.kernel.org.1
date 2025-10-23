Return-Path: <stable+bounces-189132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AB4C01DB1
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B513B264E
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0132D44E;
	Thu, 23 Oct 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r21gTSTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C078324B39;
	Thu, 23 Oct 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230153; cv=none; b=umzf06ID2p+I82JRzyUHlkx3sPVtSd/YqLcvtHwLakBIrDN1REKTBDr0TPWpGSaAg59nCBLbi7xKM40PbETlIDKnwLpiP//M4qKwT8DBVMfvzd4BW6SW1m16khHSExDRskEGUThYjazgmmQu/CEPJTH2ZUMvIFSpuYSRTN/8Sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230153; c=relaxed/simple;
	bh=fgu80mYU5I6jOaU67bbspgeh0eqOCVaeD6WJ8yF0fPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GSu4o9B/eYQwJdKm1ojZVcUvgyVS2FdT01BJyybOLOgF1aYJpfJIThNESC1GuYJaGpnQcq8SW5Ey4P2JVxSbUVCJF3tfxRJ5Q2ftjVhvnWdd6OURQApqRmzKYxVk8xTmAMY11CEuZuTgeh6qXubpQdGXjx4y4FcNFAjX8MjDtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r21gTSTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921E9C4CEE7;
	Thu, 23 Oct 2025 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761230152;
	bh=fgu80mYU5I6jOaU67bbspgeh0eqOCVaeD6WJ8yF0fPg=;
	h=From:To:Cc:Subject:Date:From;
	b=r21gTSTjbK5iIy7k7jMeO8zo7TksnEI4PpirhDdh5EzPUDgn5TwnfvOq6KAlNwhli
	 PRABAQBdA7//jAy3Z2pFfLM5eSWwxE4avAyhWztGLGpe//3xZGBSCJ+DcyrBm87jYu
	 Top+gvevRVy5Q9Lo73IwMmH7i50yarsTh5liokdM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.55
Date: Thu, 23 Oct 2025 16:35:44 +0200
Message-ID: <2025102345-quiet-decorated-a417@gregkh>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.55 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/silicon-errata.rst          |    2 
 Documentation/networking/seg6-sysctl.rst             |    3 
 Makefile                                             |    2 
 arch/Kconfig                                         |    1 
 arch/arm64/Kconfig                                   |    1 
 arch/arm64/include/asm/cputype.h                     |    2 
 arch/arm64/kernel/cpu_errata.c                       |    1 
 arch/riscv/kernel/probes/kprobes.c                   |   13 -
 arch/x86/kernel/cpu/resctrl/monitor.c                |   44 ++-
 drivers/accel/qaic/qaic.h                            |    2 
 drivers/accel/qaic/qaic_control.c                    |    2 
 drivers/accel/qaic/qaic_data.c                       |   12 -
 drivers/accel/qaic/qaic_debugfs.c                    |    5 
 drivers/accel/qaic/qaic_drv.c                        |    3 
 drivers/base/power/runtime.c                         |   44 +++
 drivers/cdx/cdx_msi.c                                |    5 
 drivers/cpufreq/cppc_cpufreq.c                       |   14 +
 drivers/dma/idxd/init.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/Makefile                  |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c     |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c        |   48 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c              |    2 
 drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c |   56 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c                |    7 
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                |    7 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c               |    7 
 drivers/gpu/drm/amd/amdgpu/nv.h                      |    1 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c  |    3 
 drivers/gpu/drm/bridge/lontium-lt9211.c              |    3 
 drivers/gpu/drm/drm_draw.c                           |    2 
 drivers/gpu/drm/drm_draw_internal.h                  |    2 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c           |   98 ++------
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c            |    9 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                |   28 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h                |    6 
 drivers/gpu/drm/panthor/panthor_fw.c                 |    1 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c         |    2 
 drivers/gpu/drm/scheduler/sched_main.c               |   13 -
 drivers/gpu/drm/xe/xe_guc_submit.c                   |   13 +
 drivers/hid/hid-input.c                              |    5 
 drivers/hid/hid-multitouch.c                         |   28 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c     |   35 +-
 drivers/md/md-linear.c                               |    1 
 drivers/md/raid0.c                                   |   16 +
 drivers/md/raid1.c                                   |   37 ++-
 drivers/md/raid10.c                                  |   55 ++++
 drivers/md/raid5.c                                   |    2 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h  |    2 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c    |    2 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c   |  225 +++++++------------
 drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c  |    2 
 drivers/net/can/m_can/m_can.c                        |   84 ++++---
 drivers/net/can/m_can/m_can.h                        |    1 
 drivers/net/can/m_can/m_can_platform.c               |    2 
 drivers/net/can/usb/gs_usb.c                         |   23 -
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c             |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c            |    1 
 drivers/net/ethernet/broadcom/tg3.c                  |    5 
 drivers/net/ethernet/dlink/dl2k.c                    |   23 +
 drivers/net/ethernet/intel/ixgbevf/defines.h         |    6 
 drivers/net/ethernet/intel/ixgbevf/ipsec.c           |   10 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h         |   13 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c    |   46 +++
 drivers/net/ethernet/intel/ixgbevf/mbx.h             |    8 
 drivers/net/ethernet/intel/ixgbevf/vf.c              |  194 +++++++++++++---
 drivers/net/ethernet/intel/ixgbevf/vf.h              |    5 
 drivers/net/ethernet/realtek/r8169_main.c            |    5 
 drivers/net/netdevsim/netdev.c                       |    7 
 drivers/net/usb/lan78xx.c                            |   38 ++-
 drivers/net/usb/r8152.c                              |    7 
 drivers/net/wireless/realtek/rtw89/core.c            |   39 +--
 drivers/net/wireless/realtek/rtw89/core.h            |    6 
 drivers/net/wireless/realtek/rtw89/mac80211.c        |    2 
 drivers/net/wireless/realtek/rtw89/pci.c             |    2 
 drivers/nvme/host/multipath.c                        |    6 
 drivers/nvme/host/tcp.c                              |    3 
 drivers/phy/cadence/cdns-dphy.c                      |  131 ++++++++---
 drivers/usb/gadget/function/f_acm.c                  |   42 +--
 drivers/usb/gadget/function/f_ecm.c                  |   48 +---
 drivers/usb/gadget/function/f_ncm.c                  |   78 ++----
 drivers/usb/gadget/function/f_rndis.c                |   85 ++-----
 drivers/usb/gadget/udc/core.c                        |    3 
 fs/btrfs/extent_io.c                                 |    2 
 fs/btrfs/free-space-tree.c                           |   15 -
 fs/btrfs/ioctl.c                                     |    2 
 fs/btrfs/relocation.c                                |   13 -
 fs/btrfs/zoned.c                                     |    2 
 fs/dax.c                                             |    2 
 fs/dcache.c                                          |   12 -
 fs/ext4/ext4_jbd2.c                                  |   11 
 fs/ext4/inode.c                                      |    8 
 fs/f2fs/data.c                                       |    2 
 fs/hfsplus/unicode.c                                 |   24 ++
 fs/jbd2/transaction.c                                |   13 -
 fs/nfsd/blocklayout.c                                |   33 +-
 fs/nfsd/blocklayoutxdr.c                             |  171 ++++++++------
 fs/nfsd/blocklayoutxdr.h                             |    8 
 fs/nfsd/flexfilelayout.c                             |    8 
 fs/nfsd/flexfilelayoutxdr.c                          |    3 
 fs/nfsd/nfs4layouts.c                                |    1 
 fs/nfsd/nfs4proc.c                                   |   36 +--
 fs/nfsd/nfs4xdr.c                                    |   25 --
 fs/nfsd/nfsd.h                                       |    1 
 fs/nfsd/pnfs.h                                       |    1 
 fs/nfsd/xdr4.h                                       |   39 +++
 fs/smb/client/inode.c                                |    6 
 fs/smb/client/misc.c                                 |   17 +
 fs/smb/client/smb2ops.c                              |    8 
 fs/smb/server/mgmt/user_session.c                    |    7 
 fs/smb/server/smb2pdu.c                              |    9 
 fs/smb/server/transport_ipc.c                        |   12 +
 fs/xfs/libxfs/xfs_log_format.h                       |   30 ++
 fs/xfs/libxfs/xfs_ondisk.h                           |    2 
 fs/xfs/scrub/reap.c                                  |    9 
 fs/xfs/xfs_log.c                                     |    8 
 fs/xfs/xfs_log_priv.h                                |    4 
 fs/xfs/xfs_log_recover.c                             |   34 ++
 include/linux/mm.h                                   |    2 
 include/linux/pci.h                                  |   14 +
 include/linux/pm_runtime.h                           |    4 
 include/linux/usb/gadget.h                           |   25 ++
 include/net/dst.h                                    |   32 ++
 include/net/inet6_hashtables.h                       |    2 
 include/net/inet_connection_sock.h                   |    3 
 include/net/inet_hashtables.h                        |    2 
 include/net/ip.h                                     |   11 
 include/net/ip_tunnels.h                             |   15 +
 include/net/route.h                                  |    2 
 io_uring/rw.c                                        |    2 
 kernel/events/core.c                                 |    8 
 kernel/padata.c                                      |    6 
 kernel/sched/fair.c                                  |   26 +-
 mm/slub.c                                            |    9 
 net/core/dst.c                                       |    4 
 net/core/sock.c                                      |   14 -
 net/ipv4/icmp.c                                      |   24 +-
 net/ipv4/igmp.c                                      |    2 
 net/ipv4/ip_fragment.c                               |    2 
 net/ipv4/ip_output.c                                 |   19 +
 net/ipv4/ip_tunnel.c                                 |   14 -
 net/ipv4/ip_vti.c                                    |    4 
 net/ipv4/netfilter.c                                 |    4 
 net/ipv4/route.c                                     |    8 
 net/ipv4/tcp_fastopen.c                              |    4 
 net/ipv4/tcp_input.c                                 |    3 
 net/ipv4/tcp_ipv4.c                                  |   12 -
 net/ipv4/tcp_metrics.c                               |    8 
 net/ipv4/tcp_output.c                                |   19 +
 net/ipv4/xfrm4_output.c                              |    2 
 net/ipv6/ip6_tunnel.c                                |    3 
 net/ipv6/tcp_ipv6.c                                  |   22 -
 net/mptcp/ctrl.c                                     |    9 
 net/tls/tls_main.c                                   |    7 
 net/tls/tls_sw.c                                     |   31 ++
 rust/bindings/bindings_helper.h                      |    1 
 sound/firewire/amdtp-stream.h                        |    2 
 sound/soc/amd/acp/acp-sdw-sof-mach.c                 |    2 
 sound/soc/codecs/idt821034.c                         |   12 -
 sound/soc/codecs/nau8821.c                           |   53 +++-
 sound/usb/card.c                                     |   10 
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c |   12 -
 161 files changed, 1901 insertions(+), 955 deletions(-)

Adrian Hunter (3):
      perf/core: Fix address filter match with backing files
      perf/core: Fix MMAP event path names with backing files
      perf/core: Fix MMAP2 event device with backing files

Akhil P Oommen (1):
      drm/msm/a6xx: Fix PDC sleep sequence

Al Viro (1):
      d_alloc_parallel(): set DCACHE_PAR_LOOKUP earlier

Alex Deucher (3):
      drm/amdgpu: add ip offset support for cyan skillfish
      drm/amdgpu: add support for cyan skillfish without IP discovery
      drm/amdgpu: fix handling of harvesting for ip_discovery firmware

Alexey Simakov (1):
      tg3: prevent use of uninitialized remote_adv and local_adv variables

Alok Tiwari (1):
      drm/rockchip: vop2: use correct destination rectangle height check

Amit Chaudhary (1):
      nvme-multipath: Skip nr_active increments in RETRY disposition

Andrii Nakryiko (1):
      selftests/bpf: make arg_parsing.c more robust to crashes

Babu Moger (2):
      x86/resctrl: Refactor resctrl_arch_rmid_read()
      x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID

Bence Csókás (1):
      PM: runtime: Add new devm functions

Benjamin Tissoires (1):
      HID: multitouch: fix sticky fingers

Boris Burkov (1):
      btrfs: fix incorrect readahead expansion length

Breno Leitao (1):
      netdevsim: set the carrier when the device goes up

Celeste Liu (2):
      can: gs_usb: gs_make_candev(): populate net_device->dev_port
      can: gs_usb: increase max interface to U8_MAX

Christoph Hellwig (2):
      xfs: rename the old_crc variable in xlog_recover_process
      xfs: fix log CRC mismatches between i386 and other architectures

Christophe Leroy (1):
      ASoC: codecs: Fix gain setting ranges for Renesas IDT821034 codec

Chuck Lever (1):
      NFSD: Define a proc_layoutcommit for the FlexFiles layout type

Conor Dooley (1):
      rust: cfi: only 64-bit arm and x86 support CFI_CLANG

Cristian Ciocaltea (3):
      ASoC: nau8821: Cancel jdet_work before handling jack ejection
      ASoC: nau8821: Generalize helper to clear IRQ status
      ASoC: nau8821: Add DMI quirk to bypass jack debounce circuit

Darrick J. Wong (1):
      xfs: use deferred intent items for reaping crosslinked blocks

Deepanshu Kartikey (1):
      ext4: detect invalid INLINE_DATA + EXTENTS flag combination

Devarsh Thakkar (2):
      phy: cadence: cdns-dphy: Fix PLL lock and O_CMN_READY polling
      phy: cadence: cdns-dphy: Update calibration wait time for startup state machine

Dmitry Safonov (1):
      net/ip6_tunnel: Prevent perpetual tunnel growth

Dmitry Torokhov (1):
      HID: hid-input: only ignore 0 battery events for digitizers

Eric Dumazet (5):
      tcp: fix tcp_tso_should_defer() vs large RTT
      tcp: convert to dev_net_rcu()
      tcp: cache RTAX_QUICKACK metric in a hot cache line
      net: dst: add four helpers to annotate data-races around dst->dev
      ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]

Eugene Korenevsky (1):
      cifs: parse_dfs_referrals: prevent oob on malformed input

Fabian Vogt (1):
      riscv: kprobes: Fix probe address validation

Fedor Pchelkin (1):
      wifi: rtw89: avoid possible TX wait initialization race

Filipe Manana (2):
      btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation already running
      btrfs: do not assert we found block group item when creating free space tree

Francesco Valla (1):
      drm/draw: fix color truncation in drm_draw_fill24

Greg Kroah-Hartman (1):
      Linux 6.12.55

Guenter Roeck (1):
      dmaengine: Add missing cleanup on module unload

Gui-Dong Han (1):
      drm/amdgpu: use atomic functions with memory barriers for vm fault info

Guoniu Zhou (1):
      media: nxp: imx8-isi: m2m: Fix streaming cleanup on release

Hao Ge (1):
      slab: reset slab->obj_ext when freeing and it is OBJEXTS_ALLOC_FAIL

I Viswanath (1):
      net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset

Jaegeuk Kim (1):
      f2fs: fix wrong block mapping for multi-devices

Jakub Acs (1):
      mm/ksm: fix flag-dropping behavior in ksm_madvise

Jan Kara (1):
      vfs: Don't leak disconnected dentries on umount

Jedrzej Jagielski (2):
      ixgbevf: fix getting link speed data for E610 devices
      ixgbevf: fix mailbox API compatibility by negotiating supported features

Jeffrey Hugo (1):
      accel/qaic: Fix bootlog initialization ordering

Jens Axboe (1):
      Revert "io_uring/rw: drop -EOPNOTSUPP check in __io_complete_rw_common()"

Jiaming Zhang (1):
      ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card

Jiri Slaby (SUSE) (1):
      irqdomain: cdx: Switch to of_fwnode_handle()

John Garry (3):
      md/raid0: Handle bio_split() errors
      md/raid1: Handle bio_split() errors
      md/raid10: Handle bio_split() errors

Jonathan Kim (1):
      drm/amdgpu: fix gfx12 mes packet status return check

Kaustabh Chakraborty (3):
      drm/exynos: exynos7_drm_decon: fix uninitialized crtc reference in functions
      drm/exynos: exynos7_drm_decon: properly clear channels during bind
      drm/exynos: exynos7_drm_decon: remove ctx->suspended

Ketil Johnsen (1):
      drm/panthor: Ensure MCU is disabled on suspend

Kuen-Han Tsai (6):
      usb: gadget: Store endpoint pointer in usb_request
      usb: gadget: Introduce free_usb_request helper
      usb: gadget: f_ncm: Refactor bind path to use __free()
      usb: gadget: f_acm: Refactor bind path to use __free()
      usb: gadget: f_ecm: Refactor bind path to use __free()
      usb: gadget: f_rndis: Refactor bind path to use __free()

Kuniyuki Iwashima (2):
      mptcp: Call dst_release() in mptcp_active_enable().
      mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().

Laurent Pinchart (1):
      media: nxp: imx8-isi: Drop unused argument to mxc_isi_channel_chain()

Li Qiang (1):
      ASoC: amd/sdw_utils: avoid NULL deref when devm_kasprintf() fails

Linmao Li (1):
      r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H

Marc Kleine-Budde (4):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
      can: m_can: m_can_chip_config(): bring up interface in correct state
      can: m_can: fix CAN state in system PM

Marek Vasut (1):
      drm/bridge: lt9211: Drop check for last nibble of version register

Mario Limonciello (1):
      drm/amd: Check whether secure display TA loaded successfully

Marios Makassikis (1):
      ksmbd: fix recursive locking in RPC handle list access

Mark Rutland (2):
      arm64: cputype: Add Neoverse-V3AE definitions
      arm64: errata: Apply workarounds for Neoverse-V3AE

Matthieu Baerts (NGI0) (1):
      mptcp: reset blackhole on success with non-loopback ifaces

Miaoqian Lin (1):
      cdx: Fix device node reference leak in cdx_msi_domain_init

Miquel Sabaté Solà (2):
      btrfs: fix memory leak on duplicated memory in the qgroup assign ioctl
      btrfs: fix memory leaks when rejecting a non SINGLE data profile without an RST

Nicolas Dichtel (1):
      doc: fix seg6_flowlabel path

Oleksij Rempel (1):
      net: usb: lan78xx: Add error handling to lan78xx_init_mac_address

Piotr Kwapulinski (2):
      PCI: Add PCI_VDEVICE_SUB helper macro
      ixgbevf: Add support for Intel(R) E610 device

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Synchronize access to DBC request queue head & tail pointer

Rafael J. Wysocki (1):
      cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition delay

Raju Rangoju (1):
      amd-xgbe: Avoid spurious link down messages during interface toggle

Randy Dunlap (1):
      ALSA: firewire: amdtp-stream: fix enum kernel-doc warnings

Sabrina Dubroca (5):
      tls: trim encrypted message to match the plaintext on short splice
      tls: wait for async encrypt in case of error during latter iterations of sendmsg
      tls: always set record_type in tls_process_cmsg
      tls: wait for pending async decryptions if tls_strp_msg_hold fails
      tls: don't rely on tx_work during send()

Sean Nyekjaer (4):
      can: m_can: add deinit callback
      can: m_can: call deinit/init callback when going into suspend/resume
      iio: imu: inv_icm42600: Simplify pm_runtime setup
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended

Sergey Bashirov (6):
      nfsd: Use correct error code when decoding extents
      nfsd: Drop dprintk in blocklayout xdr functions
      NFSD: Rework encoding and decoding of nfsd4_deviceid
      NFSD: Minor cleanup in layoutcommit processing
      NFSD: Implement large extent array support in pNFS
      NFSD: Fix last write offset handling in layoutcommit

Sharath Chandra Vurukala (1):
      net: Add locking to protect skb->dev access in ip_output

Shuhao Fu (1):
      smb: client: Fix refcount leak for cifs_sb_tlink

Shuicheng Lin (1):
      drm/xe/guc: Check GuC running state before deregistering exec queue

Thadeu Lima de Souza Cascardo (1):
      HID: multitouch: fix name of Stylus input devices

Timur Kristóf (1):
      drm/amd/powerplay: Fix CIK shutdown temperature

Tomi Valkeinen (1):
      phy: cdns-dphy: Store hs_clk_rate and return it

Tvrtko Ursulin (1):
      drm/sched: Fix potential double free in drm_sched_job_add_resv_dependencies

Viacheslav Dubeyko (1):
      hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()

Vincent Guittot (1):
      sched/fair: Fix pelt lost idle time detection

Wilfred Mallawa (1):
      nvme/tcp: handle tls partially sent records in write_space()

Xiao Liang (1):
      padata: Reset next CPU when reorder sequence wraps around

Xing Guo (1):
      selftests: arg_parsing: Ensure data is flushed to disk before reading.

Yeounsu Moon (1):
      net: dlink: handle dma_map_single() failure properly

Yi Cong (1):
      r8152: add error handling in rtl8152_driver_init

Youssef Samir (1):
      accel/qaic: Treat remaining == 0 as error in find_and_map_user_pages()

Yu Kuai (1):
      md: fix mssing blktrace bio split events

Yuezhang Mo (1):
      dax: skip read lock assertion for read-only filesystems

Zhang Yi (2):
      jbd2: ensure that all ongoing I/O complete before freeing blocks
      ext4: wait for ongoing I/O to complete before freeing blocks

Zhanjun Dong (1):
      drm/i915/guc: Skip communication warning on reset in progress


