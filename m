Return-Path: <stable+bounces-191621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6DFC1B249
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9B2582F5C
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D553354715;
	Wed, 29 Oct 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nzOXFalN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC335470A;
	Wed, 29 Oct 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745328; cv=none; b=Vy/dlX4vxiprW1YfdBB0HVBis0XnO+auANdDHLgXuBNYac56B2r+MFgJRGFW7jqgWYg8Hlf40FdnjQ9pCii2mW1Tj78a2shOALSohd1J9NmeUEbMTMA7pHZzVMZ//L+OBnHVAgN4bIGW360iDhfn/t3BRgQdMxMrR2H2A9Qdnsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745328; c=relaxed/simple;
	bh=VjIBSB9YTYW1RUhyVPeemV/CL6UAcQyngdfmWKP0Ge8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eq7Q5y46TTU9GrntSovoIyrHBS8RSLQv4OhFS6hggXakm/ZjcHHwKfwRO/Raz+3XWra1j+K5/BB7gjLtIZvefNC+ddTfKk+UaGguey0WI4W9slq5TbjfSs6cua4cctIE4+2P/NCv7ci78L2iVvRyOGpHWHyAOuGJIDjt1JVbL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nzOXFalN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A51C4CEF7;
	Wed, 29 Oct 2025 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761745325;
	bh=VjIBSB9YTYW1RUhyVPeemV/CL6UAcQyngdfmWKP0Ge8=;
	h=From:To:Cc:Subject:Date:From;
	b=nzOXFalNBa3Xu4BBtCHCOD28wbDMtZ87aE8fJqp7rP2m7y0rTBWJZmtjZafV2sEpv
	 SnWl6qZXEkmheqnM/LL6x6rHZDqdJ587oS5t4EVIGqtrqeOYbxH7jH5zfShuuTvK3X
	 W+GglrwXoJvKZ20GoTRY7+6KnENiMI3AiF8pZf0Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.158
Date: Wed, 29 Oct 2025 14:41:38 +0100
Message-ID: <2025102939-cataract-remission-7107@gregkh>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.158 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/RCU/Design/Requirements/Requirements.rst      |    2 
 Documentation/arm64/silicon-errata.rst                      |    2 
 Documentation/core-api/local_ops.rst                        |    2 
 Documentation/kernel-hacking/locking.rst                    |   17 
 Documentation/networking/seg6-sysctl.rst                    |    3 
 Documentation/timers/hrtimers.rst                           |    2 
 Documentation/translations/it_IT/kernel-hacking/locking.rst |   14 
 Documentation/translations/zh_CN/core-api/local_ops.rst     |    2 
 Makefile                                                    |    2 
 arch/arm/mach-spear/time.c                                  |    8 
 arch/arm64/Kconfig                                          |    1 
 arch/arm64/include/asm/cputype.h                            |    2 
 arch/arm64/include/asm/pgtable.h                            |    3 
 arch/arm64/kernel/cpu_errata.c                              |    1 
 arch/arm64/kernel/cpufeature.c                              |   10 
 arch/arm64/kernel/mte.c                                     |    2 
 arch/m68k/include/asm/bitops.h                              |   25 
 arch/mips/mti-malta/malta-setup.c                           |    2 
 arch/nios2/kernel/setup.c                                   |   15 
 arch/powerpc/include/asm/pgtable.h                          |   12 
 arch/powerpc/mm/book3s32/mmu.c                              |    4 
 arch/powerpc/mm/pgtable_32.c                                |    2 
 arch/riscv/include/asm/pgtable.h                            |    2 
 arch/riscv/kernel/cpu.c                                     |    4 
 arch/riscv/kernel/probes/kprobes.c                          |   13 
 arch/x86/kernel/cpu/resctrl/monitor.c                       |    8 
 drivers/acpi/acpica/tbprint.c                               |    6 
 drivers/android/binder.c                                    |   11 
 drivers/base/arch_topology.c                                |    2 
 drivers/base/devcoredump.c                                  |  138 +++--
 drivers/base/power/runtime.c                                |   44 +
 drivers/bluetooth/hci_qca.c                                 |   10 
 drivers/clocksource/arm_arch_timer.c                        |   12 
 drivers/clocksource/timer-sp804.c                           |    6 
 drivers/comedi/comedi_buf.c                                 |    2 
 drivers/cpufreq/cppc_cpufreq.c                              |   14 
 drivers/cpuidle/governors/menu.c                            |   21 
 drivers/crypto/rockchip/rk3288_crypto_ahash.c               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c            |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c                       |    7 
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                       |    7 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c         |    3 
 drivers/gpu/drm/bridge/lontium-lt9211.c                     |    3 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c                  |   98 +--
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c                     |    5 
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h                |    8 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                |    2 
 drivers/gpu/drm/scheduler/sched_main.c                      |   13 
 drivers/hid/hid-input.c                                     |    5 
 drivers/hid/hid-multitouch.c                                |   28 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c           |    5 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c            |   35 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c            |    5 
 drivers/misc/fastrpc.c                                      |    2 
 drivers/misc/lkdtm/fortify.c                                |    6 
 drivers/misc/mei/hw-me-regs.h                               |    2 
 drivers/misc/mei/pci-me.c                                   |    2 
 drivers/most/most_usb.c                                     |   13 
 drivers/net/bonding/bond_main.c                             |   40 -
 drivers/net/can/dev/netlink.c                               |    6 
 drivers/net/can/m_can/m_can_platform.c                      |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                    |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                   |    1 
 drivers/net/ethernet/broadcom/tg3.c                         |    5 
 drivers/net/ethernet/dlink/dl2k.c                           |   23 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c            |    3 
 drivers/net/ethernet/freescale/enetc/enetc.h                |    2 
 drivers/net/ethernet/intel/ixgbevf/defines.h                |    6 
 drivers/net/ethernet/intel/ixgbevf/ipsec.c                  |   10 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h                |   13 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c           |   46 +
 drivers/net/ethernet/intel/ixgbevf/mbx.h                    |    8 
 drivers/net/ethernet/intel/ixgbevf/vf.c                     |  194 ++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.h                     |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c         |    2 
 drivers/net/ethernet/realtek/r8169_main.c                   |    5 
 drivers/net/ethernet/renesas/ravb_main.c                    |   24 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c              |    9 
 drivers/net/usb/lan78xx.c                                   |   38 +
 drivers/net/usb/r8152.c                                     |    7 
 drivers/net/usb/rtl8150.c                                   |   11 
 drivers/pci/controller/cadence/pci-j721e.c                  |   64 ++
 drivers/pci/controller/dwc/pcie-tegra194.c                  |   10 
 drivers/pci/pci-sysfs.c                                     |   10 
 drivers/phy/cadence/cdns-dphy.c                             |  131 +++--
 drivers/s390/cio/device.c                                   |   37 -
 drivers/tty/serial/8250/8250_dw.c                           |    4 
 drivers/tty/serial/8250/8250_exar.c                         |   11 
 drivers/usb/core/quirks.c                                   |    2 
 drivers/usb/gadget/function/f_acm.c                         |   42 -
 drivers/usb/gadget/function/f_ecm.c                         |   48 -
 drivers/usb/gadget/function/f_ncm.c                         |   78 +--
 drivers/usb/gadget/function/f_rndis.c                       |   85 +--
 drivers/usb/gadget/legacy/raw_gadget.c                      |    2 
 drivers/usb/gadget/udc/core.c                               |    3 
 drivers/usb/host/xhci-dbgcap.c                              |    9 
 drivers/usb/serial/option.c                                 |   10 
 fs/btrfs/free-space-tree.c                                  |   15 
 fs/btrfs/relocation.c                                       |   13 
 fs/dax.c                                                    |    2 
 fs/dcache.c                                                 |    2 
 fs/dlm/lockspace.c                                          |    2 
 fs/exec.c                                                   |    2 
 fs/ext4/ext4_jbd2.c                                         |   11 
 fs/ext4/inode.c                                             |    8 
 fs/ext4/super.c                                             |   17 
 fs/f2fs/data.c                                              |  108 ++--
 fs/f2fs/f2fs.h                                              |    6 
 fs/f2fs/file.c                                              |   16 
 fs/fuse/dir.c                                               |    2 
 fs/fuse/file.c                                              |   75 +-
 fs/fuse/fuse_i.h                                            |    2 
 fs/hfs/bfind.c                                              |    8 
 fs/hfs/brec.c                                               |   27 -
 fs/hfs/mdb.c                                                |    2 
 fs/hfsplus/bfind.c                                          |    8 
 fs/hfsplus/bnode.c                                          |   41 -
 fs/hfsplus/btree.c                                          |    6 
 fs/hfsplus/hfsplus_fs.h                                     |   42 +
 fs/hfsplus/super.c                                          |   25 
 fs/hfsplus/unicode.c                                        |   24 
 fs/jbd2/transaction.c                                       |   13 
 fs/nfsd/blocklayout.c                                       |    5 
 fs/nfsd/blocklayoutxdr.c                                    |    7 
 fs/nfsd/flexfilelayout.c                                    |    8 
 fs/nfsd/flexfilelayoutxdr.c                                 |    3 
 fs/nfsd/nfs4layouts.c                                       |    1 
 fs/nfsd/nfs4proc.c                                          |   34 -
 fs/nfsd/nfs4xdr.c                                           |   14 
 fs/nfsd/xdr4.h                                              |   36 +
 fs/ocfs2/move_extents.c                                     |    5 
 fs/smb/client/inode.c                                       |    6 
 fs/smb/client/misc.c                                        |   17 
 fs/smb/client/smb2ops.c                                     |    8 
 fs/smb/server/ksmbd_netlink.h                               |    3 
 fs/smb/server/server.h                                      |    1 
 fs/smb/server/smb2pdu.c                                     |    4 
 fs/smb/server/transport_ipc.c                               |    9 
 fs/smb/server/transport_rdma.c                              |   11 
 fs/smb/server/transport_tcp.c                               |   69 +-
 fs/smb/server/transport_tcp.h                               |    1 
 fs/xfs/libxfs/xfs_log_format.h                              |   30 +
 fs/xfs/xfs_log.c                                            |    8 
 fs/xfs/xfs_log_priv.h                                       |    4 
 fs/xfs/xfs_log_recover.c                                    |   34 -
 fs/xfs/xfs_ondisk.h                                         |    2 
 fs/xfs/xfs_super.c                                          |   33 -
 include/linux/cpufreq.h                                     |    3 
 include/linux/mm.h                                          |    2 
 include/linux/pci.h                                         |   14 
 include/linux/pm_runtime.h                                  |    4 
 include/linux/timer.h                                       |    2 
 include/linux/usb/gadget.h                                  |   25 
 include/net/ip_tunnels.h                                    |   15 
 include/trace/events/f2fs.h                                 |   11 
 io_uring/filetable.c                                        |    2 
 kernel/padata.c                                             |    6 
 kernel/sched/fair.c                                         |   38 -
 kernel/time/timer.c                                         |  311 +++++++++---
 net/core/rtnetlink.c                                        |    3 
 net/ipv4/ip_tunnel.c                                        |   14 
 net/ipv4/tcp_output.c                                       |   19 
 net/ipv6/ip6_tunnel.c                                       |    3 
 net/sctp/inqueue.c                                          |   13 
 net/tls/tls_main.c                                          |    7 
 net/tls/tls_sw.c                                            |   28 -
 net/vmw_vsock/af_vsock.c                                    |   38 -
 rust/bindings/bindings_helper.h                             |    2 
 rust/bindings/lib.rs                                        |    1 
 sound/firewire/amdtp-stream.h                               |    2 
 sound/soc/codecs/nau8821.c                                  |   53 +-
 sound/usb/card.c                                            |   10 
 tools/testing/selftests/net/mptcp/mptcp_join.sh             |    6 
 tools/testing/selftests/vm/map_hugetlb.c                    |    7 
 175 files changed, 2091 insertions(+), 1070 deletions(-)

Alexander Aring (1):
      dlm: check for defined force value in dlm_lockspace_release

Alexander Usyskin (1):
      mei: me: add wildcat lake P DID

Alexey Simakov (2):
      tg3: prevent use of uninitialized remote_adv and local_adv variables
      sctp: avoid NULL dereference when chunk data buffer is missing

Alice Ryhl (1):
      binder: remove "invalid inc weak" check

Alok Tiwari (2):
      drm/rockchip: vop2: use correct destination rectangle height check
      io_uring: correct __must_hold annotation in io_install_fixed_file

Amir Goldstein (1):
      fuse: allocate ff->release_args only if release is needed

Andrey Konovalov (1):
      usb: raw-gadget: do not limit transfer length

Anup Patel (2):
      RISC-V: Define pgprot_dmacoherent() for non-coherent devices
      RISC-V: Don't print details of CPUs disabled in DT

Artem Shimko (1):
      serial: 8250_dw: handle reset control deassert error

Babu Moger (1):
      x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID

Bence Csókás (1):
      PM: runtime: Add new devm functions

Benjamin Tissoires (1):
      HID: multitouch: fix sticky fingers

Brian Norris (1):
      PCI/sysfs: Ensure devices are powered for config reads (part 2)

Catalin Marinas (1):
      arm64: mte: Do not flag the zero page as PG_mte_tagged

Christoph Hellwig (5):
      xfs: rename the old_crc variable in xlog_recover_process
      xfs: fix log CRC mismatches between i386 and other architectures
      f2fs: add a f2fs_get_block_locked helper
      f2fs: remove the create argument to f2fs_map_blocks
      f2fs: factor a f2fs_map_blocks_cached helper

Christophe Leroy (1):
      powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup failure

Chuck Lever (1):
      NFSD: Define a proc_layoutcommit for the FlexFiles layout type

Cristian Ciocaltea (3):
      ASoC: nau8821: Cancel jdet_work before handling jack ejection
      ASoC: nau8821: Generalize helper to clear IRQ status
      ASoC: nau8821: Add DMI quirk to bypass jack debounce circuit

Darrick J. Wong (2):
      fuse: fix livelock in synchronous file put from fuseblk workers
      xfs: always warn about deprecated mount options

David Lechner (1):
      iio: imu: inv_icm42600: use = { } instead of memset()

Deepanshu Kartikey (3):
      ext4: detect invalid INLINE_DATA + EXTENTS flag combination
      ocfs2: clear extent cache after moving/defragmenting extents
      comedi: fix divide-by-zero in comedi_buf_munge()

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

Florian Eckert (1):
      serial: 8250_exar: add support for Advantech 2 port card with Device ID 0x0018

Geert Uytterhoeven (1):
      m68k: bitops: Fix find_*_bit() signatures

Greg Kroah-Hartman (1):
      Linux 6.1.158

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

Jakub Acs (1):
      mm/ksm: fix flag-dropping behavior in ksm_madvise

Jan Kara (1):
      vfs: Don't leak disconnected dentries on umount

Jedrzej Jagielski (2):
      ixgbevf: fix getting link speed data for E610 devices
      ixgbevf: fix mailbox API compatibility by negotiating supported features

Jiaming Zhang (1):
      ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card

Johannes Wiesböck (1):
      rtnetlink: Allow deleting FDB entries in user namespace

Junhao Xie (1):
      misc: fastrpc: Fix dma_buf object leak in fastrpc_map_lookup

Junjie Cao (1):
      lkdtm: fortify: Fix potential NULL dereference on kmalloc failure

Kaushlendra Kumar (1):
      arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()

Kaustabh Chakraborty (3):
      drm/exynos: exynos7_drm_decon: fix uninitialized crtc reference in functions
      drm/exynos: exynos7_drm_decon: properly clear channels during bind
      drm/exynos: exynos7_drm_decon: remove ctx->suspended

Kuen-Han Tsai (6):
      usb: gadget: Store endpoint pointer in usb_request
      usb: gadget: Introduce free_usb_request helper
      usb: gadget: f_rndis: Refactor bind path to use __free()
      usb: gadget: f_ecm: Refactor bind path to use __free()
      usb: gadget: f_acm: Refactor bind path to use __free()
      usb: gadget: f_ncm: Refactor bind path to use __free()

LI Qingwu (1):
      USB: serial: option: add Telit FN920C04 ECM compositions

Lad Prabhakar (2):
      net: ravb: Enforce descriptor type ordering
      net: ravb: Ensure memory write completes before ringing TX doorbell

Leon Hwang (1):
      Revert "selftests: mm: fix map_hugetlb failure on 64K page size systems"

Linmao Li (1):
      r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H

Maarten Lankhorst (1):
      devcoredump: Fix circular locking dependency with devcd->mutex.

Maciej W. Rozycki (1):
      MIPS: Malta: Fix keyboard resource preventing i8042 driver from registering

Marc Kleine-Budde (2):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: netlink: can_changelink(): allow disabling of automatic restart

Marek Vasut (2):
      drm/rcar-du: dsi: Fix 1/2/3 lane support
      drm/bridge: lt9211: Drop check for last nibble of version register

Mario Limonciello (1):
      drm/amd: Check whether secure display TA loaded successfully

Mark Rutland (2):
      arm64: cputype: Add Neoverse-V3AE definitions
      arm64: errata: Apply workarounds for Neoverse-V3AE

Mathias Nyman (1):
      xhci: dbc: enable back DbC in resume if it was enabled before suspend

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: join: mark 'flush re-add' as skipped if not supported
      selftests: mptcp: join: mark implicit tests as skipped if not supported

Michal Pecio (1):
      net: usb: rtl8150: Fix frame padding

Namjae Jeon (1):
      ksmbd: browse interfaces list on FSCTL_QUERY_INTERFACE_INFO IOCTL

Nathan Chancellor (1):
      net/mlx5e: Return 1 instead of 0 in invalid case in mlx5e_mpwrq_umr_entry_size()

Nicolas Dichtel (1):
      doc: fix seg6_flowlabel path

Niklas Cassel (1):
      PCI: tegra194: Reset BARs when running in PCIe endpoint mode

Oleksij Rempel (1):
      net: usb: lan78xx: Add error handling to lan78xx_init_mac_address

Piotr Kwapulinski (2):
      PCI: Add PCI_VDEVICE_SUB helper macro
      ixgbevf: Add support for Intel(R) E610 device

Qianchang Zhao (1):
      ksmbd: transport_ipc: validate payload size before reading handle

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

Sabrina Dubroca (4):
      tls: wait for async encrypt in case of error during latter iterations of sendmsg
      tls: always set record_type in tls_process_cmsg
      tls: wait for pending async decryptions if tls_strp_msg_hold fails
      tls: don't rely on tx_work during send()

Sascha Hauer (1):
      net: tls: wait for async completion on last message

Sean Nyekjaer (2):
      iio: imu: inv_icm42600: Simplify pm_runtime setup
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended

Sebastian Reichel (1):
      net: stmmac: dwmac-rk: Fix disabling set_clock_selection

Sergey Bashirov (3):
      NFSD: Rework encoding and decoding of nfsd4_deviceid
      NFSD: Minor cleanup in layoutcommit processing
      NFSD: Fix last write offset handling in layoutcommit

Shuhao Fu (1):
      smb: client: Fix refcount leak for cifs_sb_tlink

Siddharth Vadapalli (2):
      PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists
      PCI: j721e: Fix programming sequence of "strap" settings

Simon Schuster (1):
      nios2: ensure that memblock.current_limit is set when setting pfn limits

Stefan Metzmacher (1):
      smb: server: let smb_direct_flush_send_list() invalidate a remote key first

Stefano Garzarella (1):
      vsock: fix lock inversion in vsock_assign_transport()

Steven Rostedt (Google) (4):
      ARM: spear: Do not use timer namespace for timer_shutdown() function
      clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function
      clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function
      timers: Update the documentation to reflect on the new timer_shutdown() API

Thadeu Lima de Souza Cascardo (1):
      HID: multitouch: fix name of Stylus input devices

Theodore Ts'o (1):
      ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()

Thomas Fourier (1):
      crypto: rockchip - Fix dma_unmap_sg() nents value

Thomas Gleixner (8):
      Documentation: Remove bogus claim about del_timer_sync()
      timers: Replace BUG_ON()s
      Documentation: Replace del_timer/del_timer_sync()
      timers: Silently ignore timers with a NULL function
      timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode
      timers: Add shutdown mechanism to the internal functions
      timers: Provide timer_shutdown[_sync]()
      Bluetooth: hci_qca: Fix the teardown problem for real

Tim Guttzeit (1):
      usb/core/quirks: Add Huawei ME906S to wakeup quirk

Timur Kristóf (1):
      drm/amd/powerplay: Fix CIK shutdown temperature

Tomi Valkeinen (1):
      phy: cdns-dphy: Store hs_clk_rate and return it

Tonghao Zhang (1):
      net: bonding: fix possible peer notify event loss or dup issue

Tvrtko Ursulin (1):
      drm/sched: Fix potential double free in drm_sched_job_add_resv_dependencies

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

Vincent Guittot (1):
      sched/fair: Fix pelt lost idle time detection

Vineeth Vijayan (1):
      s390/cio: Update purge function to unregister the unused subchannels

Wei Fang (1):
      net: enetc: correct the value of ENETC_RXB_TRUESIZE

Xi Ruoyao (1):
      ACPICA: Work around bogus -Wstringop-overread warning since GCC 11

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

Yuezhang Mo (1):
      dax: skip read lock assertion for read-only filesystems

Zhang Yi (2):
      jbd2: ensure that all ongoing I/O complete before freeing blocks
      ext4: wait for ongoing I/O to complete before freeing blocks


