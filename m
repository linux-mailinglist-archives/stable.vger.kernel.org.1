Return-Path: <stable+bounces-189130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C5C01D15
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 543014EA36A
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04683093AB;
	Thu, 23 Oct 2025 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jlI05AIe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62232B998;
	Thu, 23 Oct 2025 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230142; cv=none; b=Gg8hLjctz19CjXJM5T9Qy6ZI1C7ezoQ/LHTKcKCZzP6W84HX4FQKS4Sr9p4HLnx94oV+pweFEQWcL7Z7FX9rYaWU4D9Qml8QwjW/toP5tsrM0geoy/mHBE1bUQQeB0ziziTz2gRBZAiSvI9adGfKZxVlXQZISQnbfXiov+/jrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230142; c=relaxed/simple;
	bh=+bfCyD1LrfAqT8UxB7jhqeKAoDRRJaBrt5HDM8ZZtEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f8DFsb0WtB/GQCpfrc6d4GlZwLKJ2Xu1jRdZlj/IrdbaRD2J2wKeTgDDwDj60wo58NUS+BiWml2rYDBYj5K2K9lFFtPi1mC2GPVMachN24NFsKBBODlER+b8M1Bqxi0rPbtNnAsR1TSN6Lw++l9sltMIpJi/JAAro6BCg9dzmaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jlI05AIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0908C4CEF7;
	Thu, 23 Oct 2025 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761230142;
	bh=+bfCyD1LrfAqT8UxB7jhqeKAoDRRJaBrt5HDM8ZZtEE=;
	h=From:To:Cc:Subject:Date:From;
	b=jlI05AIe87lSBXutjFO6a4YADsjG11OLSC2y4NBSCnX7MrB5QjUmPJKpWWEkNtsQq
	 6/tT3eXVelnPdR92MSP6hZqx2cP0zjGxo/cQ0Y3m1hWzXDNKnikmANVm1QBDuTQVTO
	 v0uK87Pj/8NuzLrLKybifw3rfiziEhE/4ZjRpe8Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.114
Date: Thu, 23 Oct 2025 16:35:37 +0200
Message-ID: <2025102338-kick-avatar-03ef@gregkh>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.114 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/silicon-errata.rst          |    2 
 Documentation/networking/seg6-sysctl.rst             |    3 
 Makefile                                             |    2 
 arch/arm64/Kconfig                                   |    1 
 arch/arm64/include/asm/cputype.h                     |    2 
 arch/arm64/kernel/cpu_errata.c                       |    1 
 arch/riscv/kernel/probes/kprobes.c                   |   13 -
 block/bdev.c                                         |   17 +
 block/blk-zoned.c                                    |    5 
 block/fops.c                                         |   16 +
 block/ioctl.c                                        |    6 
 drivers/accel/qaic/qaic_control.c                    |    2 
 drivers/base/power/runtime.c                         |   44 +++
 drivers/bluetooth/btusb.c                            |    2 
 drivers/cpufreq/cppc_cpufreq.c                       |   14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c     |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c              |    2 
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c                |    7 
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                |    7 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c  |    3 
 drivers/gpu/drm/bridge/lontium-lt9211.c              |    3 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c           |   98 ++------
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c            |    9 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                |   38 +--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h                |    6 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                |   10 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c         |    2 
 drivers/gpu/drm/scheduler/sched_main.c               |   13 -
 drivers/hid/hid-input.c                              |    5 
 drivers/hid/hid-multitouch.c                         |   28 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h          |    8 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c     |   35 +-
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h  |    2 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c    |    2 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c   |  225 +++++++------------
 drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c  |    2 
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
 drivers/net/usb/lan78xx.c                            |   38 ++-
 drivers/net/usb/r8152.c                              |    7 
 drivers/nvme/host/multipath.c                        |    6 
 drivers/pci/controller/cadence/pci-j721e.c           |   64 +++++
 drivers/pci/controller/dwc/pcie-tegra194.c           |   10 
 drivers/pci/pci-sysfs.c                              |   10 
 drivers/phy/cadence/cdns-dphy.c                      |  131 ++++++++---
 drivers/usb/gadget/function/f_acm.c                  |   42 +--
 drivers/usb/gadget/function/f_ecm.c                  |   48 +---
 drivers/usb/gadget/function/f_ncm.c                  |   78 ++----
 drivers/usb/gadget/function/f_rndis.c                |   85 ++-----
 drivers/usb/gadget/udc/core.c                        |    3 
 fs/btrfs/extent_io.c                                 |    2 
 fs/btrfs/free-space-tree.c                           |   15 -
 fs/btrfs/relocation.c                                |   13 -
 fs/dax.c                                             |    2 
 fs/dcache.c                                          |    2 
 fs/eventpoll.c                                       |  145 ++----------
 fs/ext4/ext4_jbd2.c                                  |   11 
 fs/ext4/inode.c                                      |    8 
 fs/ext4/super.c                                      |   17 -
 fs/f2fs/data.c                                       |    2 
 fs/hfsplus/unicode.c                                 |   24 ++
 fs/jbd2/transaction.c                                |   13 -
 fs/nfsd/blocklayout.c                                |    5 
 fs/nfsd/blocklayoutxdr.c                             |    7 
 fs/nfsd/export.c                                     |   60 ++++-
 fs/nfsd/export.h                                     |    2 
 fs/nfsd/flexfilelayout.c                             |    8 
 fs/nfsd/flexfilelayoutxdr.c                          |    3 
 fs/nfsd/nfs4layouts.c                                |    1 
 fs/nfsd/nfs4proc.c                                   |   34 +-
 fs/nfsd/nfs4xdr.c                                    |   14 -
 fs/nfsd/nfsfh.c                                      |   12 -
 fs/nfsd/xdr4.h                                       |   36 ++-
 fs/nilfs2/the_nilfs.c                                |    3 
 fs/ocfs2/super.c                                     |    6 
 fs/quota/dquot.c                                     |   13 -
 fs/quota/quota_v1.c                                  |    3 
 fs/quota/quota_v2.c                                  |    9 
 fs/smb/client/inode.c                                |    6 
 fs/smb/client/misc.c                                 |   17 +
 fs/smb/client/smb2ops.c                              |    8 
 fs/smb/server/ksmbd_netlink.h                        |    3 
 fs/smb/server/server.h                               |    1 
 fs/smb/server/smb2pdu.c                              |    4 
 fs/smb/server/transport_ipc.c                        |    1 
 fs/smb/server/transport_tcp.c                        |   69 ++---
 fs/smb/server/transport_tcp.h                        |    1 
 fs/xfs/libxfs/xfs_log_format.h                       |   30 ++
 fs/xfs/scrub/reap.c                                  |   19 +
 fs/xfs/xfs_log.c                                     |    8 
 fs/xfs/xfs_log_priv.h                                |    4 
 fs/xfs/xfs_log_recover.c                             |   34 ++
 fs/xfs/xfs_ondisk.h                                  |    2 
 include/linux/cpufreq.h                              |    3 
 include/linux/mm.h                                   |    2 
 include/linux/pci.h                                  |   14 +
 include/linux/pm_runtime.h                           |    4 
 include/linux/quota.h                                |    2 
 include/linux/usb/gadget.h                           |   25 ++
 include/net/ip_tunnels.h                             |   15 +
 kernel/padata.c                                      |    6 
 kernel/sched/fair.c                                  |   38 +--
 mm/shmem.c                                           |    7 
 net/ipv4/ip_tunnel.c                                 |   14 -
 net/ipv4/tcp_output.c                                |   19 +
 net/ipv6/ip6_tunnel.c                                |    3 
 net/tls/tls_main.c                                   |    7 
 net/tls/tls_sw.c                                     |   33 ++
 rust/bindings/bindings_helper.h                      |    2 
 rust/bindings/lib.rs                                 |    1 
 sound/firewire/amdtp-stream.h                        |    2 
 sound/soc/codecs/idt821034.c                         |   12 -
 sound/soc/codecs/nau8821.c                           |   53 +++-
 sound/usb/card.c                                     |   10 
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c |   12 -
 127 files changed, 1542 insertions(+), 923 deletions(-)

Akhil P Oommen (1):
      drm/msm/a6xx: Fix PDC sleep sequence

Alexey Simakov (1):
      tg3: prevent use of uninitialized remote_adv and local_adv variables

Alok Tiwari (1):
      drm/rockchip: vop2: use correct destination rectangle height check

Amit Chaudhary (1):
      nvme-multipath: Skip nr_active increments in RETRY disposition

Andrii Nakryiko (1):
      selftests/bpf: make arg_parsing.c more robust to crashes

Bence Csókás (1):
      PM: runtime: Add new devm functions

Benjamin Tissoires (1):
      HID: multitouch: fix sticky fingers

Boris Burkov (1):
      btrfs: fix incorrect readahead expansion length

Brian Norris (1):
      PCI/sysfs: Ensure devices are powered for config reads (part 2)

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

Cristian Ciocaltea (3):
      ASoC: nau8821: Cancel jdet_work before handling jack ejection
      ASoC: nau8821: Generalize helper to clear IRQ status
      ASoC: nau8821: Add DMI quirk to bypass jack debounce circuit

Darrick J. Wong (2):
      block: fix race between set_blocksize and read paths
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

Eric Dumazet (1):
      tcp: fix tcp_tso_should_defer() vs large RTT

Eugene Korenevsky (1):
      cifs: parse_dfs_referrals: prevent oob on malformed input

Fabian Vogt (1):
      riscv: kprobes: Fix probe address validation

Filipe Manana (2):
      btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation already running
      btrfs: do not assert we found block group item when creating free space tree

Greg Kroah-Hartman (1):
      Linux 6.6.114

Gui-Dong Han (1):
      drm/amdgpu: use atomic functions with memory barriers for vm fault info

Guoniu Zhou (1):
      media: nxp: imx8-isi: m2m: Fix streaming cleanup on release

Huang Xiaojia (1):
      epoll: Remove ep_scan_ready_list() in comments

I Viswanath (1):
      net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset

Ingo Molnar (1):
      sched/balancing: Rename newidle_balance() => sched_balance_newidle()

Jaegeuk Kim (1):
      f2fs: fix wrong block mapping for multi-devices

Jakub Acs (1):
      mm/ksm: fix flag-dropping behavior in ksm_madvise

Jan Kara (1):
      vfs: Don't leak disconnected dentries on umount

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: reorganize DMA aligned buffers in structure

Jedrzej Jagielski (2):
      ixgbevf: fix getting link speed data for E610 devices
      ixgbevf: fix mailbox API compatibility by negotiating supported features

Jiaming Zhang (1):
      ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card

Kaustabh Chakraborty (3):
      drm/exynos: exynos7_drm_decon: fix uninitialized crtc reference in functions
      drm/exynos: exynos7_drm_decon: properly clear channels during bind
      drm/exynos: exynos7_drm_decon: remove ctx->suspended

Kemeng Shi (1):
      quota: remove unneeded return value of register_quota_format

Konrad Dybcio (1):
      drm/msm/adreno: De-spaghettify the use of memory barriers

Kuen-Han Tsai (6):
      usb: gadget: Store endpoint pointer in usb_request
      usb: gadget: Introduce free_usb_request helper
      usb: gadget: f_ecm: Refactor bind path to use __free()
      usb: gadget: f_acm: Refactor bind path to use __free()
      usb: gadget: f_ncm: Refactor bind path to use __free()
      usb: gadget: f_rndis: Refactor bind path to use __free()

Laurent Pinchart (1):
      media: nxp: imx8-isi: Drop unused argument to mxc_isi_channel_chain()

Linmao Li (1):
      r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H

Marc Kleine-Budde (1):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()

Marek Vasut (1):
      drm/bridge: lt9211: Drop check for last nibble of version register

Mario Limonciello (1):
      drm/amd: Check whether secure display TA loaded successfully

Mark Rutland (2):
      arm64: cputype: Add Neoverse-V3AE definitions
      arm64: errata: Apply workarounds for Neoverse-V3AE

Nam Cao (1):
      eventpoll: Replace rwlock with spinlock

Namjae Jeon (1):
      ksmbd: browse interfaces list on FSCTL_QUERY_INTERFACE_INFO IOCTL

Nicolas Dichtel (1):
      doc: fix seg6_flowlabel path

Niklas Cassel (1):
      PCI: tegra194: Reset BARs when running in PCIe endpoint mode

Oleksij Rempel (1):
      net: usb: lan78xx: Add error handling to lan78xx_init_mac_address

Piotr Kwapulinski (2):
      PCI: Add PCI_VDEVICE_SUB helper macro
      ixgbevf: Add support for Intel(R) E610 device

Rafael J. Wysocki (1):
      cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition delay

Raju Rangoju (1):
      amd-xgbe: Avoid spurious link down messages during interface toggle

Randy Dunlap (1):
      ALSA: firewire: amdtp-stream: fix enum kernel-doc warnings

Ryusuke Konishi (1):
      nilfs2: fix deadlock warnings caused by lock dependency in init_nilfs()

Sabrina Dubroca (5):
      tls: trim encrypted message to match the plaintext on short splice
      tls: wait for async encrypt in case of error during latter iterations of sendmsg
      tls: always set record_type in tls_process_cmsg
      tls: wait for pending async decryptions if tls_strp_msg_hold fails
      tls: don't rely on tx_work during send()

Sascha Hauer (1):
      net: tls: wait for async completion on last message

Scott Mayhew (1):
      nfsd: decouple the xprtsec policy check from check_nfsd_access()

Sean Nyekjaer (2):
      iio: imu: inv_icm42600: Simplify pm_runtime setup
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended

Sergey Bashirov (3):
      NFSD: Rework encoding and decoding of nfsd4_deviceid
      NFSD: Minor cleanup in layoutcommit processing
      NFSD: Fix last write offset handling in layoutcommit

Shashank A P (1):
      fs: quota: create dedicated workqueue for quota_release_work

Shuhao Fu (1):
      smb: client: Fix refcount leak for cifs_sb_tlink

Siddharth Vadapalli (2):
      PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists
      PCI: j721e: Fix programming sequence of "strap" settings

Thadeu Lima de Souza Cascardo (1):
      HID: multitouch: fix name of Stylus input devices

Theodore Ts'o (1):
      ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()

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

Yuezhang Mo (1):
      dax: skip read lock assertion for read-only filesystems

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1

Zhang Yi (2):
      jbd2: ensure that all ongoing I/O complete before freeing blocks
      ext4: wait for ongoing I/O to complete before freeing blocks

Zhanjun Dong (1):
      drm/i915/guc: Skip communication warning on reset in progress


