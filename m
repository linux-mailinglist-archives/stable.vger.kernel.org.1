Return-Path: <stable+bounces-191626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E1C1B0C2
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8D1463F1D
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD843587A4;
	Wed, 29 Oct 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gfSFCCRA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23B357A5D;
	Wed, 29 Oct 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745363; cv=none; b=WiVDUWBqv5ISPI5y8YUoO8K1pU1XbEHB8fm90ZB7KbSS8LdliDVfhYz0FOV6yH7Ot5zg/LgRHoj9Uj66zvRaxSLQDCBRZvcukL0w6mSDZSu02HpNTVVAVjCVYxew7gMeyNKErLaZdx2UI0j9O+XsxAyJVV31Fx1KuilZgbFOPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745363; c=relaxed/simple;
	bh=QA31KMYwZqXjcnC6rZ/4RhIptkNYCum+OXJUun49VgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jY4Ksk5I41PZBt4e89gFmabTPC9SzOdOpL0QRkhMTYBlAo+6y2GHjZvgpCV+9dgBJA1iBi1VWYOrEMOEAUZ12VgbkpFQED/6obRCmuJH4cKECptZwmlpAUppIbqGcWibFwHy3UuOVWLkG5e+iFVu03F8UAk30p1ImHTYlvZoWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gfSFCCRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997C9C4CEF7;
	Wed, 29 Oct 2025 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761745363;
	bh=QA31KMYwZqXjcnC6rZ/4RhIptkNYCum+OXJUun49VgM=;
	h=From:To:Cc:Subject:Date:From;
	b=gfSFCCRAAZ3LpGycW0OBUUqGi0dlQOEM14qyj81ry/NAQeSCyfqj+Sc8piaimB24l
	 EggjFTK5vrPWfq4h6uamkpZxAza8Zl7ph7jW2rED6UOOyZMjXe7puvf+ZRrf50B+Re
	 azawjzQ64k3vmdfAM58mvk+ahtDlj3orrtBPpbxc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.56
Date: Wed, 29 Oct 2025 14:41:54 +0100
Message-ID: <2025102954-afford-herself-8e53@gregkh>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.56 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml  |   10 
 Makefile                                                    |    6 
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi                   |    3 
 arch/arm64/include/asm/pgtable.h                            |    3 
 arch/arm64/mm/copypage.c                                    |    9 
 arch/arm64/tools/sysreg                                     |    4 
 arch/m68k/include/asm/bitops.h                              |   25 -
 arch/mips/mti-malta/malta-setup.c                           |    2 
 arch/nios2/kernel/setup.c                                   |   15 
 arch/powerpc/include/asm/pgtable.h                          |   12 
 arch/powerpc/mm/book3s32/mmu.c                              |    4 
 arch/powerpc/mm/pgtable_32.c                                |    2 
 arch/riscv/include/asm/pgtable.h                            |    2 
 arch/riscv/kernel/cpu.c                                     |    4 
 arch/riscv/kernel/sys_hwprobe.c                             |    6 
 arch/s390/mm/pgalloc.c                                      |   13 
 arch/x86/kernel/cpu/microcode/amd.c                         |    2 
 drivers/acpi/acpica/tbprint.c                               |    6 
 drivers/android/binder.c                                    |   11 
 drivers/base/arch_topology.c                                |    2 
 drivers/base/devcoredump.c                                  |  138 +++--
 drivers/block/nbd.c                                         |   15 
 drivers/bluetooth/btintel.c                                 |   28 -
 drivers/bluetooth/btintel.h                                 |    3 
 drivers/comedi/comedi_buf.c                                 |    2 
 drivers/cpuidle/governors/menu.c                            |   21 
 drivers/firmware/arm_scmi/common.h                          |   24 -
 drivers/firmware/arm_scmi/driver.c                          |   47 --
 drivers/gpio/gpio-104-idio-16.c                             |    1 
 drivers/gpio/gpio-ljca.c                                    |   14 
 drivers/gpio/gpio-pci-idio-16.c                             |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c   |    3 
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h           |    8 
 drivers/gpu/drm/drm_panic.c                                 |    8 
 drivers/gpu/drm/panthor/panthor_mmu.c                       |   10 
 drivers/hwmon/sht3x.c                                       |   27 -
 drivers/misc/fastrpc.c                                      |    2 
 drivers/misc/lkdtm/fortify.c                                |    6 
 drivers/misc/mei/hw-me-regs.h                               |    2 
 drivers/misc/mei/pci-me.c                                   |    2 
 drivers/most/most_usb.c                                     |   13 
 drivers/net/bonding/bond_main.c                             |   40 -
 drivers/net/can/bxcan.c                                     |    2 
 drivers/net/can/dev/netlink.c                               |    6 
 drivers/net/can/esd/esdacc.c                                |    2 
 drivers/net/can/rockchip/rockchip_canfd-tx.c                |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c            |    3 
 drivers/net/ethernet/freescale/enetc/enetc.c                |   25 -
 drivers/net/ethernet/freescale/enetc/enetc.h                |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c         |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h            |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h    |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c |   25 -
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c             |  128 +++--
 drivers/net/ethernet/renesas/ravb_main.c                    |   24 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c              |    9 
 drivers/net/ethernet/ti/am65-cpts.c                         |   63 +-
 drivers/net/phy/micrel.c                                    |    4 
 drivers/net/usb/rtl8150.c                                   |   11 
 drivers/pci/pci.c                                           |    6 
 drivers/perf/hisilicon/hisi_uncore_pmu.c                    |    2 
 drivers/perf/hisilicon/hisi_uncore_pmu.h                    |    3 
 drivers/platform/x86/amd/hsmp.c                             |    5 
 drivers/ptp/ptp_ocp.c                                       |    2 
 drivers/spi/spi-airoha-snfi.c                               |  280 +++++++-----
 drivers/spi/spi-nxp-fspi.c                                  |    6 
 drivers/tty/serial/8250/8250_dw.c                           |    4 
 drivers/tty/serial/8250/8250_exar.c                         |   11 
 drivers/tty/serial/8250/8250_mtk.c                          |    6 
 drivers/tty/serial/sc16is7xx.c                              |    7 
 drivers/usb/core/quirks.c                                   |    2 
 drivers/usb/gadget/legacy/raw_gadget.c                      |    2 
 drivers/usb/host/xhci-dbgcap.c                              |   15 
 drivers/usb/serial/option.c                                 |   10 
 drivers/usb/typec/tcpm/tcpm.c                               |    4 
 fs/btrfs/super.c                                            |    8 
 fs/dlm/lockspace.c                                          |    2 
 fs/exec.c                                                   |    2 
 fs/gfs2/lock_dlm.c                                          |   11 
 fs/hfs/bfind.c                                              |    8 
 fs/hfs/brec.c                                               |   27 -
 fs/hfs/mdb.c                                                |    2 
 fs/hfsplus/bfind.c                                          |    8 
 fs/hfsplus/bnode.c                                          |   41 -
 fs/hfsplus/btree.c                                          |    6 
 fs/hfsplus/hfsplus_fs.h                                     |   42 +
 fs/hfsplus/super.c                                          |   25 -
 fs/notify/fdinfo.c                                          |    6 
 fs/ocfs2/move_extents.c                                     |    5 
 fs/smb/client/cifsglob.h                                    |    2 
 fs/smb/server/transport_ipc.c                               |    8 
 fs/smb/server/transport_rdma.c                              |   11 
 fs/xfs/scrub/nlinks.c                                       |   34 +
 fs/xfs/xfs_super.c                                          |   33 -
 io_uring/fdinfo.c                                           |    8 
 io_uring/filetable.c                                        |    2 
 io_uring/sqpoll.c                                           |   65 +-
 io_uring/sqpoll.h                                           |    1 
 kernel/dma/debug.c                                          |    5 
 kernel/power/energy_model.c                                 |   58 +-
 kernel/sched/sched.h                                        |    2 
 mm/huge_memory.c                                            |    3 
 mm/migrate.c                                                |    3 
 mm/slub.c                                                   |   23 
 net/core/rtnetlink.c                                        |    3 
 net/sctp/inqueue.c                                          |   13 
 net/smc/smc_inet.c                                          |   13 
 net/vmw_vsock/af_vsock.c                                    |   38 -
 tools/objtool/check.c                                       |    1 
 tools/testing/selftests/net/mptcp/mptcp_join.sh             |    6 
 tools/testing/selftests/net/sctp_hello.c                    |   17 
 tools/testing/selftests/net/sctp_vrf.sh                     |   73 +--
 114 files changed, 1176 insertions(+), 688 deletions(-)

Akash Goel (1):
      drm/panthor: Fix kernel panic on partial unmap of a GPU VA region

Aksh Garg (1):
      net: ethernet: ti: am65-cpts: fix timestamp loss due to race conditions

Alexander Aring (1):
      dlm: check for defined force value in dlm_lockspace_release

Alexander Usyskin (1):
      mei: me: add wildcat lake P DID

Alexey Simakov (1):
      sctp: avoid NULL dereference when chunk data buffer is missing

Alice Ryhl (1):
      binder: remove "invalid inc weak" check

Alok Tiwari (1):
      io_uring: correct __must_hold annotation in io_install_fixed_file

Amery Hung (2):
      net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy RQ
      net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for striding RQ

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

Carolina Jubran (1):
      net/mlx5e: Reuse per-RQ XDP buffer to avoid stack zeroing overhead

Catalin Marinas (1):
      arm64: mte: Do not warn if the page is already tagged in copy_highpage()

Charlene Liu (1):
      drm/amd/display: increase max link count and fix link->enc NULL pointer access

Christian Loehle (1):
      PM: EM: Fix late boot with holes in CPU topology

Christophe Leroy (1):
      powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup failure

Cristian Marussi (1):
      firmware: arm_scmi: Account for failed debug initialization

Daniel Golle (1):
      serial: 8250_mtk: Enable baud clock and manage in runtime PM

Darrick J. Wong (2):
      xfs: fix locking in xchk_nlinks_collect_dir
      xfs: always warn about deprecated mount options

David Howells (1):
      cifs: Fix TCP_Server_Info::credits to be signed

Deepanshu Kartikey (2):
      ocfs2: clear extent cache after moving/defragmenting extents
      comedi: fix divide-by-zero in comedi_buf_munge()

Dewei Meng (1):
      btrfs: directly free partially initialized fs_info in btrfs_check_leaked_roots()

Florian Eckert (1):
      serial: 8250_exar: add support for Advantech 2 port card with Device ID 0x0018

Fuad Tabba (1):
      arm64: sysreg: Correct sign definitions for EIESB and DoubleLock

Geert Uytterhoeven (1):
      m68k: bitops: Fix find_*_bit() signatures

Greg Kroah-Hartman (1):
      Linux 6.12.56

Guenter Roeck (1):
      hwmon: (sht3x) Fix error handling

Han Xu (1):
      spi: spi-nxp-fspi: add extra delay after dll locked

Hao Ge (2):
      slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
      slab: Fix obj_ext mistakenly considered NULL due to race condition

Haotian Zhang (1):
      gpio: ljca: Fix duplicated IRQ mapping

Heiko Carstens (1):
      s390/mm: Use __GFP_ACCOUNT for user page table allocations

Huang Ying (1):
      arm64, mm: avoid always making PTE dirty in pte_mkwrite()

Hugo Villeneuve (1):
      serial: sc16is7xx: remove useless enable of enhanced features

Ioana Ciornei (1):
      dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx path

Jakub Acs (1):
      fs/notify: call exportfs_encode_fid with s_umount

Jens Axboe (2):
      io_uring/sqpoll: switch away from getrusage() for CPU accounting
      io_uring/sqpoll: be smarter on when to update the stime usage

Jianpeng Chang (1):
      net: enetc: fix the deadlock of enetc_mdio_lock

Jiasheng Jiang (1):
      ptp: ocp: Fix typo using index 1 instead of i in SMA initialization loop

Jocelyn Falempe (2):
      drm/panic: Fix drawing the logo on a small narrow screen
      drm/panic: Fix qr_code, ensure vmargin is positive

Johannes Wiesböck (1):
      rtnetlink: Allow deleting FDB entries in user namespace

Junhao Xie (1):
      misc: fastrpc: Fix dma_buf object leak in fastrpc_map_lookup

Junjie Cao (1):
      lkdtm: fortify: Fix potential NULL dereference on kmalloc failure

Kaushlendra Kumar (1):
      arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()

Kees Cook (1):
      PCI: Test for bit underflow in pcie_set_readrq()

Kiran K (1):
      Bluetooth: btintel: Add DSBR support for BlazarIW, BlazarU and GaP

Krzysztof Kozlowski (1):
      arm64: dts: broadcom: bcm2712: Add default GIC address cells

LI Qingwu (1):
      USB: serial: option: add Telit FN920C04 ECM compositions

Lad Prabhakar (2):
      net: ravb: Enforce descriptor type ordering
      net: ravb: Ensure memory write completes before ringing TX doorbell

Linus Torvalds (1):
      Unbreak 'make tools/*' for user-space targets

Lorenzo Bianconi (1):
      spi: airoha: do not keep {tx,rx} dma buffer always mapped

Maarten Lankhorst (1):
      devcoredump: Fix circular locking dependency with devcd->mutex.

Maciej W. Rozycki (1):
      MIPS: Malta: Fix keyboard resource preventing i8042 driver from registering

Marc Kleine-Budde (4):
      can: bxcan: bxcan_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: esd: acc_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: rockchip-canfd: rkcanfd_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: netlink: can_changelink(): allow disabling of automatic restart

Marek Szyprowski (1):
      dma-debug: don't report false positives with DMA_BOUNCE_UNALIGNED_KMALLOC

Mathias Nyman (2):
      xhci: dbc: enable back DbC in resume if it was enabled before suspend
      xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: join: mark 'flush re-add' as skipped if not supported
      selftests: mptcp: join: mark implicit tests as skipped if not supported

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

Nathan Chancellor (1):
      net/mlx5e: Return 1 instead of 0 in invalid case in mlx5e_mpwrq_umr_entry_size()

Ondrej Mosnacek (1):
      nbd: override creds to kernel when calling sock_{send,recv}msg()

Patrisious Haddad (1):
      net/mlx5: Fix IPsec cleanup over MPV device

Paul Walmsley (1):
      riscv: hwprobe: avoid uninitialized variable use in hwprobe_arch_id()

Peter Robinson (1):
      arm64: dts: broadcom: bcm2712: Define VGIC interrupt

Qianchang Zhao (1):
      ksmbd: transport_ipc: validate payload size before reading handle

Qiuxu Zhuo (1):
      mm: prevent poison consumption when splitting THP

Rafael J. Wysocki (4):
      PM: EM: Drop unused parameter from em_adjust_new_capacity()
      PM: EM: Slightly reduce em_check_capacity_update() overhead
      PM: EM: Move CPU capacity check to em_adjust_new_capacity()
      Revert "cpuidle: menu: Avoid discarding useful information"

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RG255C

Renjun Wang (1):
      USB: serial: option: add UNISOC UIS7720

Robert Marko (1):
      net: phy: micrel: always set shared->phydev for LAN8814

Sebastian Reichel (1):
      net: stmmac: dwmac-rk: Fix disabling set_clock_selection

Simon Schuster (1):
      nios2: ensure that memblock.current_limit is set when setting pfn limits

Stefan Metzmacher (1):
      smb: server: let smb_direct_flush_send_list() invalidate a remote key first

Stefano Garzarella (1):
      vsock: fix lock inversion in vsock_assign_transport()

Suma Hegde (1):
      platform/x86/amd/hsmp: Ensure sock->metric_tbl_addr is non-NULL

Tim Guttzeit (1):
      usb/core/quirks: Add Huawei ME906S to wakeup quirk

Tonghao Zhang (1):
      net: bonding: fix possible peer notify event loss or dup issue

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

William Breathitt Gray (2):
      gpio: pci-idio-16: Define maximum valid register address offset
      gpio: 104-idio-16: Define maximum valid register address offset

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


