Return-Path: <stable+bounces-191619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86674C1B0F9
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7749588835
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3612344047;
	Wed, 29 Oct 2025 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vkb70p0e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25D2C11F4;
	Wed, 29 Oct 2025 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745311; cv=none; b=FWxl7fv8hdRerI5I+6LJKAMIqdyJtU98Ip/Kidxa2Lt+UiQGpvQLuRAbilrilk8aVigf6vfs9UcyfrJvBOhN5EtI1Ddx/AoKaLTi9AxpVHEE2ERBbwgthDEGZY2o51lGFGI+rOH6IW1Ar16ITPrOs1KmeXAulijeWA5zhMfrq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745311; c=relaxed/simple;
	bh=CKmBKxAP/JhEyy66qBMUp7jsa53gNp1hsZO3F/vHDJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U+wkvY9GoIBmNhF3nfzl/rtuNEN7CkmP7Gyyi1ORYPTGXoYkXGnMiZt/38CAgYa+RatBjhD/onX5Je5GE4bETzOkKjdegxIyrlzpA3jJY5wDQn/I66ZZNeyLhak9qD4fGZ+6unlWGuHMi9Qk+o+uCTHLlxH8x9WZ5E4TNwDJG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vkb70p0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35061C4CEF7;
	Wed, 29 Oct 2025 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761745311;
	bh=CKmBKxAP/JhEyy66qBMUp7jsa53gNp1hsZO3F/vHDJc=;
	h=From:To:Cc:Subject:Date:From;
	b=vkb70p0ep24BWAbmv98ztzan52iSGk4teBOaui7b52GsJWCklJ6J/mmAdlyKLx9yo
	 y+/YIJ3Q79Nrs6nvtKEQUR0nyDYCAx0a06JrAaRX+1k+9Z7a/jGoUHmANMlHGu72a/
	 A4wsrtK/Sf3wfuJ5E1XIm05Bdy6226TfCmScf7ns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.196
Date: Wed, 29 Oct 2025 14:41:29 +0100
Message-ID: <2025102930-gloater-always-6c2f@gregkh>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.196 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.rst              |    2 
 Documentation/networking/seg6-sysctl.rst            |    3 
 Makefile                                            |    2 
 arch/arm64/Kconfig                                  |    1 
 arch/arm64/include/asm/cputype.h                    |    2 
 arch/arm64/include/asm/pgtable.h                    |    3 
 arch/arm64/kernel/cpu_errata.c                      |    1 
 arch/m68k/include/asm/bitops.h                      |   25 ++-
 arch/mips/mti-malta/malta-setup.c                   |    2 
 arch/nios2/kernel/setup.c                           |   15 ++
 arch/riscv/kernel/probes/kprobes.c                  |   13 +
 block/blk-crypto-fallback.c                         |    3 
 drivers/android/binder.c                            |   11 -
 drivers/base/arch_topology.c                        |    2 
 drivers/base/devcoredump.c                          |  138 ++++++++++++--------
 drivers/base/power/runtime.c                        |   44 ++++++
 drivers/comedi/comedi_buf.c                         |    2 
 drivers/cpufreq/cppc_cpufreq.c                      |   14 +-
 drivers/cpuidle/governors/menu.c                    |   21 +--
 drivers/crypto/rockchip/rk3288_crypto_ahash.c       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    |    5 
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c               |    7 -
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c               |    7 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c |    3 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c          |   98 ++++----------
 drivers/hid/hid-multitouch.c                        |   27 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c   |    5 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c    |   35 +----
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c    |    5 
 drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c     |   35 +----
 drivers/media/rc/lirc_dev.c                         |   15 +-
 drivers/media/rc/rc-main.c                          |    6 
 drivers/misc/mei/hw-me-regs.h                       |    2 
 drivers/misc/mei/pci-me.c                           |    2 
 drivers/most/most_usb.c                             |   13 -
 drivers/net/bonding/bond_main.c                     |   40 ++---
 drivers/net/can/m_can/m_can_platform.c              |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c            |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c           |    1 
 drivers/net/ethernet/broadcom/tg3.c                 |    5 
 drivers/net/ethernet/dlink/dl2k.c                   |   23 ++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c    |    3 
 drivers/net/ethernet/freescale/enetc/enetc.h        |    2 
 drivers/net/ethernet/realtek/r8169_main.c           |    5 
 drivers/net/ethernet/renesas/ravb_main.c            |    8 +
 drivers/net/usb/aqc111.c                            |    2 
 drivers/net/usb/lan78xx.c                           |   42 ++++--
 drivers/net/usb/r8152.c                             |    9 +
 drivers/net/usb/rndis_host.c                        |    2 
 drivers/net/usb/rtl8150.c                           |   13 +
 drivers/net/wireless/ath/ath11k/core.c              |    6 
 drivers/net/wireless/ath/ath11k/hal.c               |   16 ++
 drivers/net/wireless/ath/ath11k/hal.h               |    1 
 drivers/pci/controller/cadence/pci-j721e.c          |   64 +++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c     |    1 
 drivers/pci/controller/dwc/pcie-tegra194.c          |   28 +++-
 drivers/pci/controller/pcie-rcar-host.c             |   83 ++++++------
 drivers/pci/pci-sysfs.c                             |   10 +
 drivers/s390/cio/device.c                           |   37 +++--
 drivers/tty/serial/8250/8250_exar.c                 |   11 +
 drivers/usb/core/quirks.c                           |    2 
 drivers/usb/gadget/function/f_acm.c                 |   42 ++----
 drivers/usb/gadget/function/f_ncm.c                 |   78 ++++-------
 drivers/usb/gadget/legacy/raw_gadget.c              |    2 
 drivers/usb/gadget/udc/core.c                       |    3 
 drivers/usb/host/xhci-dbgcap.c                      |    9 +
 drivers/usb/serial/option.c                         |   10 +
 fs/btrfs/relocation.c                               |   13 +
 fs/dax.c                                            |    2 
 fs/dcache.c                                         |    2 
 fs/dlm/lockspace.c                                  |    2 
 fs/exec.c                                           |    2 
 fs/ext4/inode.c                                     |    8 +
 fs/f2fs/data.c                                      |    2 
 fs/fuse/dir.c                                       |    2 
 fs/fuse/file.c                                      |   75 ++++++----
 fs/fuse/fuse_i.h                                    |    2 
 fs/hfs/bfind.c                                      |    8 +
 fs/hfs/brec.c                                       |   27 +++
 fs/hfs/mdb.c                                        |    2 
 fs/hfsplus/bfind.c                                  |    8 +
 fs/hfsplus/bnode.c                                  |   41 -----
 fs/hfsplus/btree.c                                  |    6 
 fs/hfsplus/hfsplus_fs.h                             |   42 ++++++
 fs/hfsplus/super.c                                  |   25 ++-
 fs/hfsplus/unicode.c                                |   24 +++
 fs/jbd2/transaction.c                               |   13 +
 fs/nfsd/blocklayout.c                               |    5 
 fs/nfsd/blocklayoutxdr.c                            |    7 -
 fs/nfsd/flexfilelayout.c                            |    8 +
 fs/nfsd/flexfilelayoutxdr.c                         |    3 
 fs/nfsd/nfs4layouts.c                               |    1 
 fs/nfsd/nfs4proc.c                                  |   34 ++--
 fs/nfsd/nfs4xdr.c                                   |   14 --
 fs/nfsd/xdr4.h                                      |   36 +++++
 fs/ocfs2/move_extents.c                             |    5 
 fs/splice.c                                         |   31 ++++
 fs/xfs/libxfs/xfs_log_format.h                      |   30 ++++
 fs/xfs/xfs_log.c                                    |    8 -
 fs/xfs/xfs_log_priv.h                               |    4 
 fs/xfs/xfs_log_recover.c                            |   34 +++-
 fs/xfs/xfs_ondisk.h                                 |    2 
 fs/xfs/xfs_super.c                                  |   33 +++-
 include/linux/cpufreq.h                             |    3 
 include/linux/fs.h                                  |    1 
 include/linux/net.h                                 |    1 
 include/linux/netdevice.h                           |    9 +
 include/linux/pm_runtime.h                          |    4 
 include/linux/splice.h                              |    1 
 include/linux/usb/gadget.h                          |   25 +++
 include/net/ip_tunnels.h                            |   15 ++
 include/net/rtnetlink.h                             |    9 +
 include/net/sock.h                                  |    1 
 include/uapi/linux/netlink.h                        |    1 
 kernel/padata.c                                     |    6 
 kernel/sched/fair.c                                 |   38 ++---
 net/core/rtnetlink.c                                |   81 ++++++++---
 net/ipv4/ip_tunnel.c                                |   14 --
 net/ipv4/tcp_output.c                               |   19 ++
 net/ipv6/ip6_tunnel.c                               |    3 
 net/sctp/inqueue.c                                  |   13 +
 net/socket.c                                        |   10 +
 net/tls/tls_main.c                                  |    7 -
 net/tls/tls_sw.c                                    |   22 ++-
 net/vmw_vsock/af_vsock.c                            |   38 ++---
 sound/firewire/amdtp-stream.h                       |    2 
 sound/usb/card.c                                    |   10 +
 tools/perf/tests/perf-record.c                      |    4 
 128 files changed, 1304 insertions(+), 727 deletions(-)

Alexander Aring (1):
      dlm: check for defined force value in dlm_lockspace_release

Alexander Usyskin (1):
      mei: me: add wildcat lake P DID

Alexey Simakov (2):
      tg3: prevent use of uninitialized remote_adv and local_adv variables
      sctp: avoid NULL dereference when chunk data buffer is missing

Alice Ryhl (1):
      binder: remove "invalid inc weak" check

Amir Goldstein (1):
      fuse: allocate ff->release_args only if release is needed

Andrey Konovalov (1):
      usb: raw-gadget: do not limit transfer length

Arnd Bergmann (1):
      media: s5p-mfc: remove an unused/uninitialized variable

Bence Csókás (1):
      PM: runtime: Add new devm functions

Benjamin Tissoires (1):
      HID: multitouch: fix sticky fingers

Brian Norris (1):
      PCI/sysfs: Ensure devices are powered for config reads (part 2)

Christoph Hellwig (2):
      xfs: rename the old_crc variable in xlog_recover_process
      xfs: fix log CRC mismatches between i386 and other architectures

Chuck Lever (1):
      NFSD: Define a proc_layoutcommit for the FlexFiles layout type

Darrick J. Wong (2):
      fuse: fix livelock in synchronous file put from fuseblk workers
      xfs: always warn about deprecated mount options

David Howells (1):
      splice, net: Add a splice_eof op to file-ops and socket-ops

David Lechner (1):
      iio: imu: inv_icm42600: use = { } instead of memset()

Deepanshu Kartikey (3):
      ext4: detect invalid INLINE_DATA + EXTENTS flag combination
      ocfs2: clear extent cache after moving/defragmenting extents
      comedi: fix divide-by-zero in comedi_buf_munge()

Dmitry Safonov (1):
      net/ip6_tunnel: Prevent perpetual tunnel growth

Eric Dumazet (1):
      tcp: fix tcp_tso_should_defer() vs large RTT

Fabian Vogt (1):
      riscv: kprobes: Fix probe address validation

Filipe Manana (1):
      btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation already running

Florian Eckert (1):
      serial: 8250_exar: add support for Advantech 2 port card with Device ID 0x0018

Geert Uytterhoeven (1):
      m68k: bitops: Fix find_*_bit() signatures

Greg Kroah-Hartman (1):
      Linux 5.15.196

Gui-Dong Han (1):
      drm/amdgpu: use atomic functions with memory barriers for vm fault info

Huang Ying (1):
      arm64, mm: avoid always making PTE dirty in pte_mkwrite()

I Viswanath (1):
      net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset

Ingo Molnar (1):
      sched/balancing: Rename newidle_balance() => sched_balance_newidle()

Ioana Ciornei (1):
      dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx path

Jaegeuk Kim (1):
      f2fs: fix wrong block mapping for multi-devices

Jakub Kicinski (1):
      net: usb: use eth_hw_addr_set() instead of ether_addr_copy()

Jan Kara (1):
      vfs: Don't leak disconnected dentries on umount

Jiaming Zhang (1):
      ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card

Johannes Wiesböck (1):
      rtnetlink: Allow deleting FDB entries in user namespace

Kaushlendra Kumar (1):
      arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()

Kaustabh Chakraborty (3):
      drm/exynos: exynos7_drm_decon: fix uninitialized crtc reference in functions
      drm/exynos: exynos7_drm_decon: properly clear channels during bind
      drm/exynos: exynos7_drm_decon: remove ctx->suspended

Kuen-Han Tsai (4):
      usb: gadget: Store endpoint pointer in usb_request
      usb: gadget: Introduce free_usb_request helper
      usb: gadget: f_ncm: Refactor bind path to use __free()
      usb: gadget: f_acm: Refactor bind path to use __free()

LI Qingwu (1):
      USB: serial: option: add Telit FN920C04 ECM compositions

Lad Prabhakar (1):
      net: ravb: Ensure memory write completes before ringing TX doorbell

Linmao Li (1):
      r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H

Ma Ke (1):
      media: lirc: Fix error handling in lirc_register()

Maarten Lankhorst (1):
      devcoredump: Fix circular locking dependency with devcd->mutex.

Maciej W. Rozycki (1):
      MIPS: Malta: Fix keyboard resource preventing i8042 driver from registering

Marc Kleine-Budde (1):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()

Marek Vasut (4):
      PCI: rcar-host: Convert struct rcar_msi mask_lock into raw spinlock
      PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()
      PCI: rcar-host: Drop PMSR spinlock
      PCI: rcar: Demote WARN() to dev_warn_ratelimited() in rcar_pcie_wakeup()

Mark Rutland (2):
      arm64: cputype: Add Neoverse-V3AE definitions
      arm64: errata: Apply workarounds for Neoverse-V3AE

Mathias Nyman (1):
      xhci: dbc: enable back DbC in resume if it was enabled before suspend

Michal Pecio (1):
      net: usb: rtl8150: Fix frame padding

Muhammad Usama Anjum (1):
      wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again

Nicolas Dichtel (1):
      doc: fix seg6_flowlabel path

Niklas Cassel (1):
      PCI: tegra194: Reset BARs when running in PCIe endpoint mode

Niko Mauno (1):
      Revert "perf test: Don't leak workload gopipe in PERF_RECORD_*"

Nikolay Aleksandrov (6):
      net: rtnetlink: add helper to extract msg type's kind
      net: rtnetlink: use BIT for flag values
      net: netlink: add NLM_F_BULK delete request modifier
      net: rtnetlink: add bulk delete support flag
      net: add ndo_fdb_del_bulk
      net: rtnetlink: add NLM_F_BULK support to rtnl_fdb_del

Oleksij Rempel (1):
      net: usb: lan78xx: Add error handling to lan78xx_init_mac_address

Rafael J. Wysocki (2):
      cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition delay
      Revert "cpuidle: menu: Avoid discarding useful information"

Raju Rangoju (1):
      amd-xgbe: Avoid spurious link down messages during interface toggle

Randy Dunlap (1):
      ALSA: firewire: amdtp-stream: fix enum kernel-doc warnings

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RG255C

Renjun Wang (1):
      USB: serial: option: add UNISOC UIS7720

Sabrina Dubroca (3):
      tls: wait for async encrypt in case of error during latter iterations of sendmsg
      tls: always set record_type in tls_process_cmsg
      tls: don't rely on tx_work during send()

Sascha Hauer (1):
      net: tls: wait for async completion on last message

Sean Nyekjaer (2):
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
      iio: imu: inv_icm42600: Simplify pm_runtime setup

Sergey Bashirov (3):
      NFSD: Rework encoding and decoding of nfsd4_deviceid
      NFSD: Minor cleanup in layoutcommit processing
      NFSD: Fix last write offset handling in layoutcommit

Siddharth Vadapalli (2):
      PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists
      PCI: j721e: Fix programming sequence of "strap" settings

Simon Schuster (1):
      nios2: ensure that memblock.current_limit is set when setting pfn limits

Stefano Garzarella (1):
      vsock: fix lock inversion in vsock_assign_transport()

Thomas Fourier (1):
      crypto: rockchip - Fix dma_unmap_sg() nents value

Tim Guttzeit (1):
      usb/core/quirks: Add Huawei ME906S to wakeup quirk

Timur Kristóf (1):
      drm/amd/powerplay: Fix CIK shutdown temperature

Tonghao Zhang (1):
      net: bonding: fix possible peer notify event loss or dup issue

Viacheslav Dubeyko (6):
      hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()
      hfs: clear offset and space out of valid records in b-tree node
      hfs: make proper initalization of struct hfs_find_data
      hfsplus: fix KMSAN uninit-value issue in __hfsplus_ext_cache_extent()
      hfsplus: fix KMSAN uninit-value issue in hfsplus_delete_cat()
      hfs: fix KMSAN uninit-value issue in hfs_find_set_zero_bits()

Victoria Votokina (2):
      most: usb: Fix use-after-free in hdm_disconnect
      most: usb: hdm_probe: Fix calling put_device() before device initialization

Vidya Sagar (1):
      PCI: tegra194: Handle errors in BPMP response

Vincent Guittot (1):
      sched/fair: Fix pelt lost idle time detection

Vineeth Vijayan (1):
      s390/cio: Update purge function to unregister the unused subchannels

Wei Fang (1):
      net: enetc: correct the value of ENETC_RXB_TRUESIZE

Xiao Liang (1):
      padata: Reset next CPU when reorder sequence wraps around

Xichao Zhao (1):
      exec: Fix incorrect type for ret

Yang Chenzhi (1):
      hfs: validate record offset in hfsplus_bmap_alloc

Yangtao Li (1):
      hfsplus: return EIO when type of hidden directory mismatch in hfsplus_fill_super()

Yeounsu Moon (1):
      net: dlink: handle dma_map_single() failure properly

Yi Cong (1):
      r8152: add error handling in rtl8152_driver_init

Yu Kuai (1):
      blk-crypto: fix missing blktrace bio split events

Yuezhang Mo (1):
      dax: skip read lock assertion for read-only filesystems

Zhang Yi (1):
      jbd2: ensure that all ongoing I/O complete before freeing blocks

Zhengchao Shao (1):
      net: rtnetlink: fix module reference count leak issue in rtnetlink_rcv_msg

keliu (1):
      media: rc: Directly use ida_free()


