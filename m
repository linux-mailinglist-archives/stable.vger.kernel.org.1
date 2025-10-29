Return-Path: <stable+bounces-191628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 077ACC1B0B0
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23C02588A5F
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A977253957;
	Wed, 29 Oct 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ioI9CNVl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78A624468A;
	Wed, 29 Oct 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745376; cv=none; b=R7dMZZNH7fcq9gNRPN6twQsZfIcDtqxNmvJefofjCCTKFFQTXIx/phgAhL/gMUFbOoqUYU77Ddp9ZHAw+X7Mbt4u3Q1pr2L61R3n1f+0AEptEjxdC7vgkFJQnq9C1KrxGVGrMtwistTxxLJntwPbOGUGZ9D5a3pJm0fVog2PHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745376; c=relaxed/simple;
	bh=WU5cFgFewrIJT9oUIMEpuUs6F3Oj7ji+oMHnW+vdnFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJYt1rvVOy3J+OHvNl5m35yxZDdsfkuVxJ7bRgIE+pw0wJS++RniwX+3zE65yxozq5XhpFqAeaw2pMSPAffjo3CmBV2osWQY9gTSXT4YOXiLmXIwbuna+emNXzzdeb4lirFwl9BVx1RpdmM4qsgTL6SsXZ3Y399z5/tV/y4xS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ioI9CNVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB65C4CEF7;
	Wed, 29 Oct 2025 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761745376;
	bh=WU5cFgFewrIJT9oUIMEpuUs6F3Oj7ji+oMHnW+vdnFg=;
	h=From:To:Cc:Subject:Date:From;
	b=ioI9CNVlNLNv82WBDsrFplMJZIdQ+zkWy70fwigk42rKTk1Yezsa5EmIIDSYBMoGr
	 y4X+2BamOvoVMTnVpEkt0bh/smm2ZzgJqYDVm+ceRGPuVuIbM3pRG78BvXExG5FR1s
	 pK+pg/KioRRl6CY1fbQBh0Fv+KA9ktdOfHZyW6vk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.6
Date: Wed, 29 Oct 2025 14:42:01 +0100
Message-ID: <2025102901-nuzzle-gizmo-9f40@gregkh>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.6 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/renesas,scif.yaml  |    1 
 Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml  |   10 
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml   |    3 
 Makefile                                                    |    6 
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi                   |    3 
 arch/arm64/include/asm/pgtable.h                            |    3 
 arch/arm64/mm/copypage.c                                    |   11 
 arch/arm64/tools/sysreg                                     |    4 
 arch/m68k/include/asm/bitops.h                              |   25 +-
 arch/mips/mti-malta/malta-setup.c                           |    2 
 arch/nios2/kernel/setup.c                                   |   15 +
 arch/powerpc/include/asm/pgtable.h                          |   12 -
 arch/powerpc/mm/book3s32/mmu.c                              |    4 
 arch/powerpc/mm/pgtable_32.c                                |    2 
 arch/powerpc/platforms/pseries/cmm.c                        |    2 
 arch/riscv/include/asm/hwprobe.h                            |    7 
 arch/riscv/include/asm/pgtable.h                            |    2 
 arch/riscv/include/asm/vdso/arch_data.h                     |    6 
 arch/riscv/kernel/cpu.c                                     |    4 
 arch/riscv/kernel/cpufeature.c                              |   10 
 arch/riscv/kernel/pi/cmdline_early.c                        |    4 
 arch/riscv/kernel/pi/fdt_early.c                            |   40 +++
 arch/riscv/kernel/pi/pi.h                                   |    1 
 arch/riscv/kernel/sys_hwprobe.c                             |   90 ++++++-
 arch/riscv/kernel/unaligned_access_speed.c                  |    9 
 arch/riscv/kernel/vdso/hwprobe.c                            |    2 
 arch/riscv/mm/init.c                                        |   11 
 arch/s390/mm/pgalloc.c                                      |   13 -
 arch/x86/kernel/cpu/microcode/amd.c                         |    2 
 block/blk-settings.c                                        |   10 
 drivers/acpi/acpica/tbprint.c                               |    6 
 drivers/android/binder.c                                    |   11 
 drivers/base/arch_topology.c                                |    2 
 drivers/base/devcoredump.c                                  |  136 +++++++-----
 drivers/block/nbd.c                                         |   15 +
 drivers/comedi/comedi_buf.c                                 |    2 
 drivers/cpufreq/amd-pstate.c                                |    6 
 drivers/cpuidle/governors/menu.c                            |   21 -
 drivers/firmware/arm_ffa/driver.c                           |   37 ++-
 drivers/firmware/arm_scmi/common.h                          |   32 ++
 drivers/firmware/arm_scmi/driver.c                          |   54 +---
 drivers/gpio/gpio-104-idio-16.c                             |    1 
 drivers/gpio/gpio-idio-16.c                                 |    5 
 drivers/gpio/gpio-ljca.c                                    |   14 -
 drivers/gpio/gpio-pci-idio-16.c                             |    1 
 drivers/gpio/gpio-regmap.c                                  |   53 ++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c   |    3 
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h           |    8 
 drivers/gpu/drm/drm_panic.c                                 |   54 ++++
 drivers/gpu/drm/panthor/panthor_mmu.c                       |   10 
 drivers/gpu/drm/xe/xe_ggtt.c                                |    3 
 drivers/hwmon/cgbc-hwmon.c                                  |    3 
 drivers/hwmon/pmbus/isl68137.c                              |    3 
 drivers/hwmon/pmbus/max34440.c                              |   12 -
 drivers/hwmon/sht3x.c                                       |   27 +-
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c                 |    2 
 drivers/misc/fastrpc.c                                      |    2 
 drivers/misc/lkdtm/fortify.c                                |    6 
 drivers/misc/mei/hw-me-regs.h                               |    2 
 drivers/misc/mei/pci-me.c                                   |    2 
 drivers/misc/vmw_balloon.c                                  |    8 
 drivers/most/most_usb.c                                     |   13 -
 drivers/net/bonding/bond_main.c                             |   47 ++--
 drivers/net/can/bxcan.c                                     |    2 
 drivers/net/can/dev/netlink.c                               |    6 
 drivers/net/can/esd/esdacc.c                                |    2 
 drivers/net/can/rockchip/rockchip_canfd-tx.c                |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c            |    3 
 drivers/net/ethernet/freescale/enetc/enetc.c                |   25 +-
 drivers/net/ethernet/freescale/enetc/enetc.h                |    2 
 drivers/net/ethernet/hisilicon/Kconfig                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c         |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h    |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c |   25 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c             |   51 +++-
 drivers/net/ethernet/renesas/ravb_main.c                    |   24 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c              |    9 
 drivers/net/ethernet/ti/am65-cpts.c                         |   63 +++--
 drivers/net/ovpn/tcp.c                                      |   26 +-
 drivers/net/phy/micrel.c                                    |    4 
 drivers/net/phy/realtek/realtek_main.c                      |   16 -
 drivers/net/usb/rtl8150.c                                   |   11 
 drivers/nvmem/rcar-efuse.c                                  |    1 
 drivers/of/irq.c                                            |   62 +++--
 drivers/pci/msi/irqdomain.c                                 |    2 
 drivers/pci/pci.c                                           |    6 
 drivers/perf/hisilicon/hisi_uncore_pmu.c                    |    2 
 drivers/perf/hisilicon/hisi_uncore_pmu.h                    |    3 
 drivers/platform/mellanox/mlxbf-pmc.c                       |    1 
 drivers/platform/x86/dell/alienware-wmi-wmax.c              |   12 -
 drivers/ptp/ptp_ocp.c                                       |    2 
 drivers/s390/crypto/zcrypt_ep11misc.c                       |    4 
 drivers/spi/spi-airoha-snfi.c                               |  128 ++++++++---
 drivers/spi/spi-cadence-quadspi.c                           |    5 
 drivers/spi/spi-nxp-fspi.c                                  |   80 ++++++-
 drivers/spi/spi-rockchip-sfc.c                              |   12 -
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c        |   12 -
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c                    |    5 
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c                   |   13 -
 drivers/tty/serial/8250/8250_dw.c                           |    4 
 drivers/tty/serial/8250/8250_exar.c                         |   11 
 drivers/tty/serial/8250/8250_mtk.c                          |    6 
 drivers/tty/serial/sc16is7xx.c                              |    7 
 drivers/tty/serial/sh-sci.c                                 |   14 -
 drivers/usb/core/quirks.c                                   |    2 
 drivers/usb/gadget/legacy/raw_gadget.c                      |    2 
 drivers/usb/host/xhci-dbgcap.c                              |   15 +
 drivers/usb/serial/option.c                                 |   10 
 drivers/usb/typec/tcpm/tcpm.c                               |    4 
 drivers/vfio/cdx/Makefile                                   |    6 
 drivers/vfio/cdx/private.h                                  |   14 +
 drivers/virtio/virtio_balloon.c                             |    2 
 fs/aio.c                                                    |    2 
 fs/btrfs/inode.c                                            |    4 
 fs/btrfs/ref-verify.c                                       |    2 
 fs/btrfs/send.c                                             |   56 ++++
 fs/btrfs/super.c                                            |    8 
 fs/dlm/lock.c                                               |    2 
 fs/dlm/lockspace.c                                          |    2 
 fs/dlm/recover.c                                            |    2 
 fs/erofs/zmap.c                                             |   39 ++-
 fs/exec.c                                                   |    2 
 fs/gfs2/lock_dlm.c                                          |   11 
 fs/hfs/bfind.c                                              |    8 
 fs/hfs/brec.c                                               |   27 ++
 fs/hfs/mdb.c                                                |    2 
 fs/hfsplus/bfind.c                                          |    8 
 fs/hfsplus/bnode.c                                          |   41 ---
 fs/hfsplus/btree.c                                          |    6 
 fs/hfsplus/hfsplus_fs.h                                     |   42 +++
 fs/hfsplus/super.c                                          |   25 +-
 fs/hugetlbfs/inode.c                                        |    4 
 fs/jfs/jfs_metapage.c                                       |    8 
 fs/notify/fdinfo.c                                          |    6 
 fs/ocfs2/move_extents.c                                     |    5 
 fs/smb/client/cifsglob.h                                    |    2 
 fs/smb/client/inode.c                                       |    5 
 fs/smb/client/smbdirect.c                                   |   30 +-
 fs/smb/client/smbdirect.h                                   |    2 
 fs/smb/server/transport_ipc.c                               |    8 
 fs/smb/server/transport_rdma.c                              |   11 
 fs/sysfs/group.c                                            |   26 +-
 fs/xfs/scrub/nlinks.c                                       |   34 ++-
 fs/xfs/xfs_super.c                                          |   33 +-
 include/linux/arm_ffa.h                                     |   21 +
 include/linux/exportfs.h                                    |    7 
 include/linux/gpio/regmap.h                                 |   16 +
 include/linux/hung_task.h                                   |    8 
 include/linux/migrate.h                                     |   11 
 include/linux/misc_cgroup.h                                 |    2 
 include/linux/of_irq.h                                      |    6 
 include/linux/skbuff.h                                      |    3 
 include/linux/virtio_net.h                                  |    4 
 io_uring/fdinfo.c                                           |    8 
 io_uring/filetable.c                                        |    2 
 io_uring/sqpoll.c                                           |   65 +++--
 io_uring/sqpoll.h                                           |    1 
 io_uring/waitid.c                                           |    2 
 kernel/dma/debug.c                                          |    5 
 kernel/sched/fair.c                                         |    9 
 kernel/sched/sched.h                                        |    2 
 kernel/trace/rv/monitors/pagefault/Kconfig                  |    1 
 kernel/trace/rv/rv.c                                        |   12 -
 mm/damon/core.c                                             |    7 
 mm/damon/sysfs.c                                            |    7 
 mm/huge_memory.c                                            |    3 
 mm/migrate.c                                                |   88 +++----
 mm/migrate_device.c                                         |    2 
 mm/mremap.c                                                 |   15 -
 mm/page_owner.c                                             |    3 
 mm/slub.c                                                   |   23 +-
 mm/zsmalloc.c                                               |    4 
 net/core/datagram.c                                         |   44 +++
 net/core/rtnetlink.c                                        |    3 
 net/hsr/hsr_netlink.c                                       |    8 
 net/mptcp/pm_kernel.c                                       |    6 
 net/sctp/inqueue.c                                          |   13 -
 net/smc/smc_inet.c                                          |   13 -
 net/vmw_vsock/af_vsock.c                                    |   38 +--
 net/xfrm/espintcp.c                                         |    6 
 rust/kernel/auxiliary.rs                                    |    8 
 rust/kernel/device.rs                                       |    4 
 tools/objtool/check.c                                       |    1 
 tools/testing/selftests/net/mptcp/mptcp_join.sh             |    8 
 tools/testing/selftests/net/sctp_hello.c                    |   17 -
 tools/testing/selftests/net/sctp_vrf.sh                     |   73 +++---
 187 files changed, 1853 insertions(+), 832 deletions(-)

Akash Goel (1):
      drm/panthor: Fix kernel panic on partial unmap of a GPU VA region

Aksh Garg (1):
      net: ethernet: ti: am65-cpts: fix timestamp loss due to race conditions

Aleksander Jan Bajkowski (1):
      net: phy: realtek: fix rtl8221b-vm-cg name

Alexander Aring (2):
      dlm: move to rinfo for all middle conversion cases
      dlm: check for defined force value in dlm_lockspace_release

Alexander Usyskin (1):
      mei: me: add wildcat lake P DID

Alexei Starovoitov (1):
      mm: don't spin in add_stack_record when gfp flags don't allow

Alexey Simakov (1):
      sctp: avoid NULL dereference when chunk data buffer is missing

Alexis Czezar Torreno (1):
      hwmon: (pmbus/max34440) Update adpm12160 coeff due to latest FW

Alice Ryhl (1):
      binder: remove "invalid inc weak" check

Alok Tiwari (2):
      io_uring: fix incorrect unlikely() usage in io_waitid_prep()
      io_uring: correct __must_hold annotation in io_install_fixed_file

Amery Hung (2):
      net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy RQ
      net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for striding RQ

Amit Dhingra (1):
      btrfs: ref-verify: fix IS_ERR() vs NULL check in btrfs_build_ref_tree()

Andreas Gruenbacher (1):
      gfs2: Fix unlikely race in gdlm_put_lock

Andrew Cooper (1):
      x86/microcode: Fix Entrysign revision check for Zen1/Naples

Andrey Konovalov (1):
      usb: raw-gadget: do not limit transfer length

Andy Shevchenko (1):
      sched: Remove never used code in mm_cid_get()

Anup Patel (2):
      RISC-V: Define pgprot_dmacoherent() for non-coherent devices
      RISC-V: Don't print details of CPUs disabled in DT

Artem Shimko (2):
      firmware: arm_scmi: Fix premature SCMI_XFER_FLAG_IS_RAW clearing in raw mode
      serial: 8250_dw: handle reset control deassert error

Catalin Marinas (1):
      arm64: mte: Do not warn if the page is already tagged in copy_highpage()

Charlene Liu (1):
      drm/amd/display: increase max link count and fix link->enc NULL pointer access

Christoph Hellwig (1):
      block: require LBA dma_alignment when using PI

Christophe Leroy (1):
      powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup failure

Clément Léger (1):
      riscv: cpufeature: add validation for zfa, zfh and zfhmin

Cosmin Tanislav (2):
      nvmem: rcar-efuse: add missing MODULE_DEVICE_TABLE
      tty: serial: sh-sci: fix RSCI FIFO overrun handling

Cristian Marussi (2):
      firmware: arm_scmi: Account for failed debug initialization
      include: trace: Fix inflight count helper on failed initialization

Daniel Golle (1):
      serial: 8250_mtk: Enable baud clock and manage in runtime PM

Danilo Krummrich (1):
      rust: device: fix device context of Device::parent()

Darrick J. Wong (2):
      xfs: fix locking in xchk_nlinks_collect_dir
      xfs: always warn about deprecated mount options

Dave Penkler (3):
      staging: gpib: Fix no EOI on 1 and 2 byte writes
      staging: gpib: Return -EINTR on device clear
      staging: gpib: Fix sending clear and trigger events

David Hildenbrand (3):
      mm/migrate: remove MIGRATEPAGE_UNMAP
      treewide: remove MIGRATEPAGE_SUCCESS
      vmw_balloon: indicate success when effectively deflating during migration

David Howells (1):
      cifs: Fix TCP_Server_Info::credits to be signed

David Thompson (1):
      platform/mellanox: mlxbf-pmc: add sysfs_attr_init() to count_clock init

Deepanshu Kartikey (2):
      ocfs2: clear extent cache after moving/defragmenting extents
      comedi: fix divide-by-zero in comedi_buf_munge()

Dewei Meng (1):
      btrfs: directly free partially initialized fs_info in btrfs_check_leaked_roots()

Enze Li (1):
      mm/damon/core: fix potential memory leak by cleaning ops_filter in damon_destroy_scheme

Erick Karanja (1):
      hwmon: (pmbus/isl68137) Fix child node reference leak on early return

Fernando Fernandez Mancera (2):
      net: hsr: prevent creation of HSR device with slaves from another netns
      sysfs: check visibility before changing group attribute ownership

Florian Eckert (1):
      serial: 8250_exar: add support for Advantech 2 port card with Device ID 0x0018

Fuad Tabba (1):
      arm64: sysreg: Correct sign definitions for EIESB and DoubleLock

Gao Xiang (2):
      erofs: fix crafted invalid cases for encoded extents
      erofs: avoid infinite loops due to corrupted subpage compact indexes

Geert Uytterhoeven (2):
      m68k: bitops: Fix find_*_bit() signatures
      dt-bindings: serial: sh-sci: Fix r8a78000 interrupts

Greg Kroah-Hartman (1):
      Linux 6.17.6

Guenter Roeck (1):
      hwmon: (sht3x) Fix error handling

Haibo Chen (3):
      spi: spi-nxp-fspi: add the support for sample data from DQS pad
      spi: spi-nxp-fspi: re-config the clock rate when operation require new clock rate
      spi: spi-nxp-fspi: limit the clock rate for different sample clock source selection

Han Xu (1):
      spi: spi-nxp-fspi: add extra delay after dll locked

Hao Ge (2):
      slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
      slab: Fix obj_ext mistakenly considered NULL due to race condition

Haotian Zhang (1):
      gpio: ljca: Fix duplicated IRQ mapping

Harald Freudenberger (1):
      s390/pkey: Forward keygenflags to ep11_unwrapkey

Heiko Carstens (1):
      s390/mm: Use __GFP_ACCOUNT for user page table allocations

Heiner Kallweit (1):
      net: hibmcge: select FIXED_PHY

Huang Ying (1):
      arm64, mm: avoid always making PTE dirty in pte_mkwrite()

Hugo Villeneuve (1):
      serial: sc16is7xx: remove useless enable of enhanced features

Ioana Ciornei (2):
      dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx path
      gpio: regmap: add the .fixed_direction_output configuration parameter

Jakub Acs (1):
      fs/notify: call exportfs_encode_fid with s_umount

Jan Kara (1):
      expfs: Fix exportfs_can_encode_fh() for EXPORT_FH_FID

Jason Wang (1):
      virtio-net: zero unused hash fields

Jens Axboe (2):
      io_uring/sqpoll: switch away from getrusage() for CPU accounting
      io_uring/sqpoll: be smarter on when to update the stime usage

Jianpeng Chang (1):
      net: enetc: fix the deadlock of enetc_mdio_lock

Jiasheng Jiang (1):
      ptp: ocp: Fix typo using index 1 instead of i in SMA initialization loop

Jingwei Wang (1):
      riscv: hwprobe: Fix stale vDSO data for late-initialized keys at boot

Jocelyn Falempe (3):
      drm/panic: Fix drawing the logo on a small narrow screen
      drm/panic: Fix qr_code, ensure vmargin is positive
      drm/panic: Fix 24bit pixel crossing page boundaries

Johannes Wiesböck (1):
      rtnetlink: Allow deleting FDB entries in user namespace

Junhao Xie (1):
      misc: fastrpc: Fix dma_buf object leak in fastrpc_map_lookup

Junhui Liu (2):
      riscv: mm: Return intended SATP mode for noXlvl options
      riscv: mm: Use mmu-type from FDT to limit SATP mode

Junjie Cao (1):
      lkdtm: fortify: Fix potential NULL dereference on kmalloc failure

K Prateek Nayak (1):
      sched/fair: Block delayed tasks on throttled hierarchy during dequeue

Kaushlendra Kumar (1):
      arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()

Kees Cook (1):
      PCI: Test for bit underflow in pcie_set_readrq()

Krishna Kurapati (1):
      dt-bindings: usb: qcom,snps-dwc3: Fix bindings for X1E80100

Krzysztof Kozlowski (1):
      arm64: dts: broadcom: bcm2712: Add default GIC address cells

Kurt Borja (1):
      platform/x86: alienware-wmi-wmax: Fix NULL pointer dereference in sleep handlers

LI Qingwu (1):
      USB: serial: option: add Telit FN920C04 ECM compositions

Lad Prabhakar (2):
      net: ravb: Enforce descriptor type ordering
      net: ravb: Ensure memory write completes before ringing TX doorbell

Lance Yang (1):
      hung_task: fix warnings caused by unaligned lock pointers

Li Qiang (1):
      hwmon: (cgbc-hwmon) Add missing NULL check after devm_kzalloc()

Linus Torvalds (1):
      Unbreak 'make tools/*' for user-space targets

Lorenzo Pieralisi (2):
      of/irq: Convert of_msi_map_id() callers to of_msi_xlate()
      of/irq: Add msi-parent check to of_msi_xlate()

Lorenzo Stoakes (1):
      mm/mremap: correctly account old mapping after MREMAP_DONTUNMAP remap

Ma Ke (1):
      staging: gpib: Fix device reference leak in fmh_gpib driver

Maarten Lankhorst (1):
      devcoredump: Fix circular locking dependency with devcd->mutex.

Maciej W. Rozycki (1):
      MIPS: Malta: Fix keyboard resource preventing i8042 driver from registering

Marc Kleine-Budde (4):
      can: bxcan: bxcan_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: esd: acc_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: rockchip-canfd: rkcanfd_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: netlink: can_changelink(): allow disabling of automatic restart

Marek Szyprowski (2):
      dma-debug: don't report false positives with DMA_BOUNCE_UNALIGNED_KMALLOC
      spi: rockchip-sfc: Fix DMA-API usage

Mario Limonciello (AMD) (1):
      cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate

Mathias Nyman (2):
      xhci: dbc: enable back DbC in resume if it was enabled before suspend
      xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event

Mathieu Dubois-Briand (1):
      gpio: regmap: Allow to allocate regmap-irq device

Matthew Brost (1):
      drm/xe: Check return value of GGTT workqueue allocation

Matthieu Baerts (NGI0) (4):
      mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
      selftests: mptcp: join: mark 'flush re-add' as skipped if not supported
      selftests: mptcp: join: mark implicit tests as skipped if not supported
      selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported

Mattijs Korpershoek (1):
      spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER

Michael Grzeschik (1):
      tcpm: switch check for role_sw device with fw_node

Michal Pecio (1):
      net: usb: rtl8150: Fix frame padding

Miguel Ojeda (1):
      objtool/rust: add one more `noreturn` Rust function

Mikhail Kshevetskiy (4):
      spi: airoha: return an error for continuous mode dirmap creation cases
      spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
      spi: airoha: switch back to non-dma mode in the case of error
      spi: airoha: fix reading/writing of flashes with more than one plane per lun

Nam Cao (2):
      rv: Fully convert enabled_monitors to use list_head as iterator
      rv: Make rtapp/pagefault monitor depends on CONFIG_MMU

Nathan Chancellor (1):
      net/mlx5e: Return 1 instead of 0 in invalid case in mlx5e_mpwrq_umr_entry_size()

Nipun Gupta (1):
      vfio/cdx: update driver to build without CONFIG_GENERIC_MSI_IRQ

Ondrej Mosnacek (1):
      nbd: override creds to kernel when calling sock_{send,recv}msg()

Patrisious Haddad (1):
      net/mlx5: Fix IPsec cleanup over MPV device

Paul Walmsley (2):
      riscv: cpufeature: avoid uninitialized variable in has_thead_homogeneous_vlenb()
      riscv: hwprobe: avoid uninitialized variable use in hwprobe_arch_id()

Paulo Alcantara (1):
      smb: client: get rid of d_drop() in cifs_do_rename()

Peter Robinson (1):
      arm64: dts: broadcom: bcm2712: Define VGIC interrupt

Qianchang Zhao (1):
      ksmbd: transport_ipc: validate payload size before reading handle

Qiuxu Zhuo (1):
      mm: prevent poison consumption when splitting THP

Rafael J. Wysocki (1):
      Revert "cpuidle: menu: Avoid discarding useful information"

Ralf Lici (3):
      espintcp: use datagram_poll_queue for socket readiness
      net: datagram: introduce datagram_poll_queue for custom receive queues
      ovpn: use datagram_poll_queue for socket readiness in TCP

Randy Dunlap (1):
      cgroup/misc: fix misc_res_type kernel-doc warning

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RG255C

Renjun Wang (1):
      USB: serial: option: add UNISOC UIS7720

Robert Marko (1):
      net: phy: micrel: always set shared->phydev for LAN8814

Sebastian Reichel (1):
      net: stmmac: dwmac-rk: Fix disabling set_clock_selection

SeongJae Park (4):
      mm/damon/core: use damos_commit_quota_goal() for new goal commit
      mm/damon/core: fix list_add_tail() call on damon_call()
      mm/damon/sysfs: catch commit test ctx alloc failure
      mm/damon/sysfs: dealloc commit test ctx always

Simon Schuster (1):
      nios2: ensure that memblock.current_limit is set when setting pfn limits

Stefan Metzmacher (4):
      smb: client: queue post_recv_credits_work also if the peer raises the credit target
      smb: client: limit the range of info->receive_credit_target
      smb: client: make use of ib_wc_status_msg() and skip IB_WC_WR_FLUSH_ERR logging
      smb: server: let smb_direct_flush_send_list() invalidate a remote key first

Stefano Garzarella (1):
      vsock: fix lock inversion in vsock_assign_transport()

Sudeep Holla (1):
      firmware: arm_ffa: Add support for IMPDEF value in the memory access descriptor

Tim Guttzeit (1):
      usb/core/quirks: Add Huawei ME906S to wakeup quirk

Ting-Chang Hou (1):
      btrfs: send: fix duplicated rmdir operations when using extrefs

Tonghao Zhang (2):
      net: bonding: fix possible peer notify event loss or dup issue
      net: bonding: update the slave array for broadcast mode

Viacheslav Dubeyko (5):
      hfs: clear offset and space out of valid records in b-tree node
      hfs: make proper initalization of struct hfs_find_data
      hfsplus: fix KMSAN uninit-value issue in __hfsplus_ext_cache_extent()
      hfsplus: fix KMSAN uninit-value issue in hfsplus_delete_cat()
      hfs: fix KMSAN uninit-value issue in hfs_find_set_zero_bits()

Victoria Votokina (2):
      most: usb: Fix use-after-free in hdm_disconnect
      most: usb: hdm_probe: Fix calling put_device() before device initialization

Wang Liang (1):
      net/smc: fix general protection fault in __smc_diag_dump

Wei Fang (1):
      net: enetc: correct the value of ENETC_RXB_TRUESIZE

William Breathitt Gray (3):
      gpio: pci-idio-16: Define maximum valid register address offset
      gpio: 104-idio-16: Define maximum valid register address offset
      gpio: idio-16: Define fixed direction of the GPIO lines

Xi Ruoyao (1):
      ACPICA: Work around bogus -Wstringop-overread warning since GCC 11

Xichao Zhao (1):
      exec: Fix incorrect type for ret

Xin Long (1):
      selftests: net: fix server bind failure in sctp_vrf.sh

Xu Yang (1):
      dt-bindings: usb: dwc3-imx8mp: dma-range is required only for imx8mp

Yang Chenzhi (1):
      hfs: validate record offset in hfsplus_bmap_alloc

Yangtao Li (1):
      hfsplus: return EIO when type of hidden directory mismatch in hfsplus_fill_super()

Yicong Yang (1):
      drivers/perf: hisi: Relax the event ID check in the framework

tr1x_em (1):
      platform/x86: alienware-wmi-wmax: Add AWCC support to Dell G15 5530


