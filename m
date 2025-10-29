Return-Path: <stable+bounces-191624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBC2C1B82F
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 16:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828AD666AD7
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63613559EC;
	Wed, 29 Oct 2025 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdiAOHEQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA93559E5;
	Wed, 29 Oct 2025 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745351; cv=none; b=lVycaHozYE3oOZwaLNQCybRmTJJU9JBAhH35VZMq7+i+mNCIfvRVxIjWGpM19EW8HmTAshk9bn8xLKGC6SkictCr4fg65iz5RdNn41CO8Hq0coWIAVBCg73hE68eDN+KiQ/cJDI8KZzajRPtqq55ojRT2x1PtDOP53D2oTFNyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745351; c=relaxed/simple;
	bh=97J7rsmCsDTd2EVv4GxpUY/dqM/L7TRvzzwkPrjnEL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fhjIpAopW6YKEjUkuiUPm/OaXmumrbzoFFybPDbCSuzY+bP3+GQRZFegSiN94BHxj2r2zdRpnXCMuHaxPqVzOM6wqMofHAjD7quQnkxFkTcLjk244ee2g4tmNnBWODom5EmkW8ICoH4DEaV50XZPhd4iWdkOhSwbTRCpGElKFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdiAOHEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B77C4CEF7;
	Wed, 29 Oct 2025 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761745351;
	bh=97J7rsmCsDTd2EVv4GxpUY/dqM/L7TRvzzwkPrjnEL8=;
	h=From:To:Cc:Subject:Date:From;
	b=cdiAOHEQLacJGOdBcvl4D0CToFkcL8zdFW/U7BmcUaNSIEVXDXlHqr32NS3c9Q9Fh
	 EtqeDryJgtK9PRgOQ2+FSA+V9qNcCnfFaT+m7StzV2y8BT6Q8GqCm9Kl26IbeGV000
	 nHdJ3WNTZHE2tB6V8iHUm6I/W6b/n2LaXvkDa9nA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.115
Date: Wed, 29 Oct 2025 14:41:47 +0100
Message-ID: <2025102948-surgery-scribing-95c2@gregkh>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.115 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml |   10 
 Makefile                                                   |    6 
 arch/arm64/include/asm/pgtable.h                           |    3 
 arch/m68k/include/asm/bitops.h                             |   25 -
 arch/mips/mti-malta/malta-setup.c                          |    2 
 arch/nios2/kernel/setup.c                                  |   15 
 arch/powerpc/include/asm/pgtable.h                         |   12 
 arch/powerpc/mm/book3s32/mmu.c                             |    4 
 arch/powerpc/mm/pgtable_32.c                               |    2 
 arch/riscv/include/asm/pgtable.h                           |    2 
 arch/riscv/kernel/cpu.c                                    |    4 
 arch/x86/kernel/cpu/microcode/amd.c                        |    2 
 arch/x86/kernel/cpu/resctrl/monitor.c                      |    8 
 drivers/acpi/acpica/tbprint.c                              |    6 
 drivers/android/binder.c                                   |   11 
 drivers/base/arch_topology.c                               |    2 
 drivers/base/devcoredump.c                                 |  138 ++++---
 drivers/comedi/comedi_buf.c                                |    2 
 drivers/cpuidle/governors/menu.c                           |   21 -
 drivers/firmware/arm_scmi/common.h                         |   24 +
 drivers/firmware/arm_scmi/driver.c                         |   47 --
 drivers/gpio/Kconfig                                       |    4 
 drivers/gpio/gpio-104-idio-16.c                            |    1 
 drivers/gpio/gpio-ljca.c                                   |  250 +++++++------
 drivers/gpio/gpio-pci-idio-16.c                            |    1 
 drivers/hwmon/sht3x.c                                      |   27 -
 drivers/misc/fastrpc.c                                     |    2 
 drivers/misc/lkdtm/fortify.c                               |    6 
 drivers/misc/mei/hw-me-regs.h                              |    2 
 drivers/misc/mei/pci-me.c                                  |    2 
 drivers/most/most_usb.c                                    |   13 
 drivers/net/bonding/bond_main.c                            |   40 --
 drivers/net/can/bxcan.c                                    |    2 
 drivers/net/can/dev/netlink.c                              |    6 
 drivers/net/ethernet/amazon/ena/ena_netdev.c               |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c           |    3 
 drivers/net/ethernet/freescale/enetc/enetc.c               |   27 +
 drivers/net/ethernet/freescale/enetc/enetc.h               |    2 
 drivers/net/ethernet/freescale/fec_main.c                  |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                |    2 
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c              |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c              |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c               |    2 
 drivers/net/ethernet/marvell/mvneta.c                      |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c            |    2 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en.h               |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h           |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c            |  128 ++++--
 drivers/net/ethernet/netronome/nfp/nfd3/xsk.c              |    2 
 drivers/net/ethernet/renesas/ravb_main.c                   |   24 +
 drivers/net/ethernet/sfc/efx_channels.c                    |    2 
 drivers/net/ethernet/sfc/siena/efx_channels.c              |    2 
 drivers/net/ethernet/socionext/netsec.c                    |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c             |    9 
 drivers/net/ethernet/ti/cpsw_priv.c                        |    2 
 drivers/net/usb/rtl8150.c                                  |   11 
 drivers/perf/hisilicon/hisi_uncore_pmu.c                   |    2 
 drivers/perf/hisilicon/hisi_uncore_pmu.h                   |    3 
 drivers/s390/cio/device.c                                  |   37 +
 drivers/spi/spi-nxp-fspi.c                                 |    6 
 drivers/tty/serial/8250/8250_dw.c                          |    4 
 drivers/tty/serial/8250/8250_exar.c                        |   11 
 drivers/tty/serial/8250/8250_mtk.c                         |    6 
 drivers/usb/core/quirks.c                                  |    2 
 drivers/usb/gadget/legacy/raw_gadget.c                     |    2 
 drivers/usb/host/xhci-dbgcap.c                             |    9 
 drivers/usb/serial/option.c                                |   10 
 drivers/usb/typec/tcpm/tcpm.c                              |    4 
 fs/dlm/lockspace.c                                         |    2 
 fs/exec.c                                                  |    2 
 fs/fuse/dir.c                                              |    2 
 fs/fuse/file.c                                             |   75 ++-
 fs/fuse/fuse_i.h                                           |    2 
 fs/hfs/bfind.c                                             |    8 
 fs/hfs/brec.c                                              |   27 +
 fs/hfs/mdb.c                                               |    2 
 fs/hfsplus/bfind.c                                         |    8 
 fs/hfsplus/bnode.c                                         |   41 --
 fs/hfsplus/btree.c                                         |    6 
 fs/hfsplus/hfsplus_fs.h                                    |   42 ++
 fs/hfsplus/super.c                                         |   25 -
 fs/notify/fdinfo.c                                         |    6 
 fs/ocfs2/move_extents.c                                    |    5 
 fs/smb/client/cifsglob.h                                   |    2 
 fs/smb/server/transport_ipc.c                              |    8 
 fs/smb/server/transport_rdma.c                             |   11 
 fs/xfs/xfs_super.c                                         |   33 +
 io_uring/filetable.c                                       |    2 
 kernel/dma/debug.c                                         |    5 
 kernel/sched/sched.h                                       |    2 
 net/core/rtnetlink.c                                       |    3 
 net/sctp/inqueue.c                                         |   13 
 net/vmw_vsock/af_vsock.c                                   |   38 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh            |    6 
 tools/testing/selftests/net/sctp_hello.c                   |   17 
 tools/testing/selftests/net/sctp_vrf.sh                    |   85 ++--
 99 files changed, 922 insertions(+), 603 deletions(-)

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

Amir Goldstein (1):
      fuse: allocate ff->release_args only if release is needed

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

Babu Moger (1):
      x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID

Carolina Jubran (1):
      net/mlx5e: Reuse per-RQ XDP buffer to avoid stack zeroing overhead

Christophe Leroy (1):
      powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup failure

Cristian Marussi (1):
      firmware: arm_scmi: Account for failed debug initialization

Daniel Golle (1):
      serial: 8250_mtk: Enable baud clock and manage in runtime PM

Darrick J. Wong (2):
      xfs: always warn about deprecated mount options
      fuse: fix livelock in synchronous file put from fuseblk workers

David Howells (1):
      cifs: Fix TCP_Server_Info::credits to be signed

Deepanshu Kartikey (2):
      ocfs2: clear extent cache after moving/defragmenting extents
      comedi: fix divide-by-zero in comedi_buf_munge()

Florian Eckert (1):
      serial: 8250_exar: add support for Advantech 2 port card with Device ID 0x0018

Geert Uytterhoeven (1):
      m68k: bitops: Fix find_*_bit() signatures

Greg Kroah-Hartman (1):
      Linux 6.6.115

Guenter Roeck (1):
      hwmon: (sht3x) Fix error handling

Han Xu (1):
      spi: spi-nxp-fspi: add extra delay after dll locked

Hangbin Liu (1):
      selftests/net: convert sctp_vrf.sh to run it in unique namespace

Haotian Zhang (1):
      gpio: ljca: Fix duplicated IRQ mapping

Haoyu Li (1):
      gpio: ljca: Initialize num before accessing item in ljca_gpio_config

Huang Ying (1):
      arm64, mm: avoid always making PTE dirty in pte_mkwrite()

Ioana Ciornei (1):
      dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx path

Jakub Acs (1):
      fs/notify: call exportfs_encode_fid with s_umount

Jianpeng Chang (1):
      net: enetc: fix the deadlock of enetc_mdio_lock

Johannes Wiesböck (1):
      rtnetlink: Allow deleting FDB entries in user namespace

Junhao Xie (1):
      misc: fastrpc: Fix dma_buf object leak in fastrpc_map_lookup

Junjie Cao (1):
      lkdtm: fortify: Fix potential NULL dereference on kmalloc failure

Kaushlendra Kumar (1):
      arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()

LI Qingwu (1):
      USB: serial: option: add Telit FN920C04 ECM compositions

Lad Prabhakar (2):
      net: ravb: Enforce descriptor type ordering
      net: ravb: Ensure memory write completes before ringing TX doorbell

Linus Torvalds (1):
      Unbreak 'make tools/*' for user-space targets

Maarten Lankhorst (1):
      devcoredump: Fix circular locking dependency with devcd->mutex.

Maciej W. Rozycki (1):
      MIPS: Malta: Fix keyboard resource preventing i8042 driver from registering

Marc Kleine-Budde (2):
      can: bxcan: bxcan_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: netlink: can_changelink(): allow disabling of automatic restart

Marek Szyprowski (1):
      dma-debug: don't report false positives with DMA_BOUNCE_UNALIGNED_KMALLOC

Mathias Nyman (1):
      xhci: dbc: enable back DbC in resume if it was enabled before suspend

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: join: mark 'flush re-add' as skipped if not supported
      selftests: mptcp: join: mark implicit tests as skipped if not supported

Michael Grzeschik (1):
      tcpm: switch check for role_sw device with fw_node

Michal Pecio (1):
      net: usb: rtl8150: Fix frame padding

Nathan Chancellor (1):
      net/mlx5e: Return 1 instead of 0 in invalid case in mlx5e_mpwrq_umr_entry_size()

Qianchang Zhao (1):
      ksmbd: transport_ipc: validate payload size before reading handle

Rafael J. Wysocki (1):
      Revert "cpuidle: menu: Avoid discarding useful information"

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RG255C

Renjun Wang (1):
      USB: serial: option: add UNISOC UIS7720

Sebastian Andrzej Siewior (1):
      net: Tree wide: Replace xdp_do_flush_map() with xdp_do_flush().

Sebastian Reichel (1):
      net: stmmac: dwmac-rk: Fix disabling set_clock_selection

Simon Schuster (1):
      nios2: ensure that memblock.current_limit is set when setting pfn limits

Stefan Metzmacher (1):
      smb: server: let smb_direct_flush_send_list() invalidate a remote key first

Stefano Garzarella (1):
      vsock: fix lock inversion in vsock_assign_transport()

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

Vineeth Vijayan (1):
      s390/cio: Update purge function to unregister the unused subchannels

Wei Fang (1):
      net: enetc: correct the value of ENETC_RXB_TRUESIZE

Wentong Wu (1):
      gpio: update Intel LJCA USB GPIO driver

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


