Return-Path: <stable+bounces-180671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FE4B8A185
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 16:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F81679BE
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1A0315D43;
	Fri, 19 Sep 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l4at6b0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B7315D32;
	Fri, 19 Sep 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293479; cv=none; b=GeNufg1mD+9i+mHJ6mAwAvD0SpB2pj1WEQGa6n9KJAsLFEX0kYnvcmMTSh/itKmdtjp0eJSu/exeA/ssmtgSpIrQf/5XTRTN9TOknlCQs5EVVuWpz68D2uP3XculabgEHbBA530sn9f0/92xW6qIWnyGtj6z7LWb2BWysfYKOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293479; c=relaxed/simple;
	bh=e2YMHjCW2W1Yz3GfGygzShzRhvdTPFwnrklHDfQkL44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oxZaOc4KhmUDoXe7IdCjz/q/mLb2xGdBDmTYAhkgdXYGi4oJn2NFzARqhwRNzaPWP3gd7oZLtA0BkjxOluAwgsAOkexa6AvI/tsvrLv10G78jqBQwhiDJy3Z1AHWJwK2IKgyuAN48/xixTAar2bqi6wpZNBQQ2cc+c1fF4n4HI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l4at6b0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FC8C4CEF5;
	Fri, 19 Sep 2025 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758293479;
	bh=e2YMHjCW2W1Yz3GfGygzShzRhvdTPFwnrklHDfQkL44=;
	h=From:To:Cc:Subject:Date:From;
	b=l4at6b0jJwoliS/Q6pPCKLvPozuOpEIf2wNLRdMHhi4xlXLew5Fvo5fOUrapZigng
	 51qiz+zpaGfZZTMSF2DUfkILGkEXwEqzbEgqtwnq3dgTewMIkAH8gvTLyJBE+0cwEf
	 yWRlOaJ9BvhLRk8YsZ/D2s+RUVAEIcimbuWCMeKE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.8
Date: Fri, 19 Sep 2025 16:51:02 +0200
Message-ID: <2025091902-contort-federal-7ca6@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.16.8 kernel.

All users of the 6.16 kernel series must upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml |    2 
 Documentation/netlink/specs/mptcp_pm.yaml                       |    2 
 Documentation/networking/can.rst                                |    2 
 Documentation/networking/mptcp.rst                              |    8 
 Makefile                                                        |    2 
 arch/arm64/kernel/machine_kexec_file.c                          |    2 
 arch/s390/kernel/kexec_elf.c                                    |    2 
 arch/s390/kernel/kexec_image.c                                  |    2 
 arch/s390/kernel/machine_kexec_file.c                           |    6 
 arch/s390/kernel/perf_cpum_cf.c                                 |    4 
 arch/s390/kernel/perf_pai_crypto.c                              |    4 
 arch/s390/kernel/perf_pai_ext.c                                 |    2 
 arch/x86/kernel/cpu/topology_amd.c                              |   25 
 block/fops.c                                                    |   13 
 drivers/cpufreq/amd-pstate.c                                    |   19 
 drivers/cpufreq/intel_pstate.c                                  |    4 
 drivers/dma/dw/rzn1-dmamux.c                                    |   15 
 drivers/dma/idxd/init.c                                         |   39 -
 drivers/dma/qcom/bam_dma.c                                      |    8 
 drivers/dma/ti/edma.c                                           |    4 
 drivers/edac/altera_edac.c                                      |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                         |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h                         |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c                          |    4 
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c                          |   31 -
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c                        |   25 
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c                          |   18 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c                          |   25 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c                        |   25 
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c                          |   25 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                           |   12 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                           |   64 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c               |  106 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c     |    1 
 drivers/gpu/drm/amd/display/dc/dc.h                             |    1 
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c          |   74 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c         |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c         |  115 ----
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c          |    3 
 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c        |    3 
 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h                 |    1 
 drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c         |   78 +-
 drivers/gpu/drm/display/drm_dp_helper.c                         |   42 +
 drivers/gpu/drm/drm_edid.c                                      |  232 ++++----
 drivers/gpu/drm/i915/display/intel_display_power.c              |    6 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                          |   11 
 drivers/gpu/drm/panthor/panthor_drv.c                           |    2 
 drivers/gpu/drm/xe/tests/xe_bo.c                                |    2 
 drivers/gpu/drm/xe/tests/xe_dma_buf.c                           |   10 
 drivers/gpu/drm/xe/xe_bo.c                                      |   16 
 drivers/gpu/drm/xe/xe_bo.h                                      |    2 
 drivers/gpu/drm/xe/xe_device_types.h                            |    6 
 drivers/gpu/drm/xe/xe_dma_buf.c                                 |    2 
 drivers/gpu/drm/xe/xe_exec.c                                    |    9 
 drivers/gpu/drm/xe/xe_pm.c                                      |   42 +
 drivers/gpu/drm/xe/xe_survivability_mode.c                      |    3 
 drivers/gpu/drm/xe/xe_vm.c                                      |   42 +
 drivers/gpu/drm/xe/xe_vm.h                                      |    2 
 drivers/gpu/drm/xe/xe_vm_types.h                                |    5 
 drivers/i2c/busses/i2c-i801.c                                   |    2 
 drivers/i2c/busses/i2c-rtl9300.c                                |   22 
 drivers/input/joystick/xpad.c                                   |    2 
 drivers/input/misc/iqs7222.c                                    |    3 
 drivers/input/serio/i8042-acpipnpio.h                           |   14 
 drivers/iommu/intel/cache.c                                     |    5 
 drivers/iommu/intel/iommu.c                                     |  263 ++++++----
 drivers/iommu/intel/iommu.h                                     |   12 
 drivers/iommu/intel/nested.c                                    |    4 
 drivers/iommu/intel/svm.c                                       |    1 
 drivers/irqchip/irq-mvebu-gicp.c                                |    2 
 drivers/md/md.c                                                 |    6 
 drivers/mtd/nand/raw/atmel/nand-controller.c                    |   16 
 drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c           |    4 
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                          |   46 -
 drivers/mtd/nand/spi/core.c                                     |   18 
 drivers/mtd/nand/spi/winbond.c                                  |   80 ++-
 drivers/net/can/xilinx_can.c                                    |   16 
 drivers/net/dsa/b53/b53_common.c                                |   17 
 drivers/net/ethernet/freescale/fec_main.c                       |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    2 
 drivers/net/ethernet/intel/igb/igb_ethtool.c                    |    5 
 drivers/net/ethernet/intel/igb/igb_main.c                       |    3 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                    |   20 
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                      |    4 
 drivers/net/macsec.c                                            |    1 
 drivers/net/phy/phy.c                                           |   12 
 drivers/net/phy/phylink.c                                       |   28 -
 drivers/net/wireless/ath/ath12k/core.h                          |    1 
 drivers/net/wireless/ath/ath12k/dp_mon.c                        |   22 
 drivers/net/wireless/ath/ath12k/dp_rx.c                         |   11 
 drivers/net/wireless/ath/ath12k/hw.c                            |   55 ++
 drivers/net/wireless/ath/ath12k/hw.h                            |    2 
 drivers/net/wireless/ath/ath12k/mac.c                           |  127 ++--
 drivers/net/wireless/ath/ath12k/peer.c                          |    2 
 drivers/net/wireless/ath/ath12k/peer.h                          |   28 +
 drivers/net/wireless/ath/ath12k/wmi.c                           |   58 ++
 drivers/net/wireless/ath/ath12k/wmi.h                           |   16 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                   |   26 
 drivers/pci/controller/pci-mvebu.c                              |   21 
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c                  |    4 
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c                        |   25 
 drivers/phy/tegra/xusb-tegra210.c                               |    6 
 drivers/phy/ti/phy-omap-usb2.c                                  |   13 
 drivers/phy/ti/phy-ti-pipe3.c                                   |   13 
 drivers/regulator/sy7636a-regulator.c                           |    7 
 drivers/tty/hvc/hvc_console.c                                   |    6 
 drivers/tty/serial/sc16is7xx.c                                  |   14 
 drivers/usb/gadget/function/f_midi2.c                           |   11 
 drivers/usb/gadget/udc/dummy_hcd.c                              |    8 
 drivers/usb/host/xhci-dbgcap.c                                  |   94 ++-
 drivers/usb/host/xhci-mem.c                                     |    2 
 drivers/usb/serial/option.c                                     |   17 
 drivers/usb/typec/tcpm/tcpm.c                                   |   12 
 fs/btrfs/extent_io.c                                            |   73 ++
 fs/btrfs/inode.c                                                |   12 
 fs/btrfs/qgroup.c                                               |    6 
 fs/ceph/addr.c                                                  |    9 
 fs/ceph/debugfs.c                                               |   14 
 fs/ceph/dir.c                                                   |   17 
 fs/ceph/file.c                                                  |   24 
 fs/ceph/inode.c                                                 |   88 ++-
 fs/ceph/mds_client.c                                            |  172 +++---
 fs/ceph/mds_client.h                                            |   18 
 fs/coredump.c                                                   |    4 
 fs/erofs/data.c                                                 |    8 
 fs/erofs/fileio.c                                               |    2 
 fs/erofs/fscache.c                                              |    2 
 fs/erofs/inode.c                                                |    8 
 fs/erofs/internal.h                                             |    2 
 fs/erofs/super.c                                                |   16 
 fs/erofs/zdata.c                                                |   17 
 fs/erofs/zmap.c                                                 |   98 +--
 fs/exec.c                                                       |    2 
 fs/fhandle.c                                                    |    8 
 fs/fuse/dev.c                                                   |    2 
 fs/fuse/file.c                                                  |    5 
 fs/fuse/passthrough.c                                           |    5 
 fs/kernfs/file.c                                                |   58 +-
 fs/nfs/client.c                                                 |    2 
 fs/nfs/file.c                                                   |    7 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |   21 
 fs/nfs/inode.c                                                  |    4 
 fs/nfs/internal.h                                               |   10 
 fs/nfs/io.c                                                     |   13 
 fs/nfs/localio.c                                                |   12 
 fs/nfs/nfs42proc.c                                              |    2 
 fs/nfs/nfs4file.c                                               |    2 
 fs/nfs/nfs4proc.c                                               |    7 
 fs/nfs/write.c                                                  |    1 
 fs/ocfs2/extent_map.c                                           |   10 
 fs/proc/generic.c                                               |    3 
 fs/resctrl/ctrlmondata.c                                        |    2 
 fs/resctrl/internal.h                                           |    4 
 fs/resctrl/monitor.c                                            |    6 
 fs/smb/client/cifsglob.h                                        |   13 
 fs/smb/client/file.c                                            |   18 
 fs/smb/client/inode.c                                           |   86 ++-
 fs/smb/client/smb2glob.h                                        |    3 
 fs/smb/client/smb2inode.c                                       |  204 ++++++-
 fs/smb/client/smb2ops.c                                         |   32 +
 fs/smb/client/smb2proto.h                                       |    3 
 fs/smb/client/trace.h                                           |    9 
 include/drm/display/drm_dp_helper.h                             |    6 
 include/drm/drm_connector.h                                     |    4 
 include/drm/drm_edid.h                                          |    8 
 include/linux/compiler-clang.h                                  |   29 -
 include/linux/energy_model.h                                    |   10 
 include/linux/fs.h                                              |    3 
 include/linux/kasan.h                                           |    6 
 include/linux/mtd/spinand.h                                     |    8 
 include/net/netfilter/nf_tables.h                               |   11 
 include/net/netfilter/nf_tables_core.h                          |   49 -
 include/net/netns/nftables.h                                    |    1 
 include/uapi/linux/raid/md_p.h                                  |    2 
 io_uring/rw.c                                                   |    3 
 kernel/bpf/Makefile                                             |    1 
 kernel/bpf/core.c                                               |   16 
 kernel/bpf/cpumap.c                                             |    4 
 kernel/bpf/crypto.c                                             |    2 
 kernel/bpf/helpers.c                                            |    7 
 kernel/bpf/rqspinlock.c                                         |    2 
 kernel/dma/debug.c                                              |   48 +
 kernel/dma/debug.h                                              |   20 
 kernel/dma/mapping.c                                            |    4 
 kernel/events/core.c                                            |    1 
 kernel/power/energy_model.c                                     |   29 -
 kernel/power/hibernate.c                                        |    1 
 kernel/time/hrtimer.c                                           |   11 
 kernel/trace/fgraph.c                                           |    3 
 kernel/trace/trace.c                                            |   10 
 kernel/trace/trace_osnoise.c                                    |    3 
 mm/damon/core.c                                                 |    4 
 mm/damon/lru_sort.c                                             |    5 
 mm/damon/reclaim.c                                              |    5 
 mm/damon/sysfs.c                                                |   14 
 mm/hugetlb.c                                                    |    9 
 mm/kasan/shadow.c                                               |   31 -
 mm/khugepaged.c                                                 |    4 
 mm/memory-failure.c                                             |   20 
 mm/vmalloc.c                                                    |    8 
 net/bluetooth/hci_conn.c                                        |   14 
 net/bluetooth/hci_event.c                                       |    7 
 net/bluetooth/iso.c                                             |    2 
 net/bridge/br.c                                                 |    7 
 net/can/j1939/bus.c                                             |    5 
 net/can/j1939/j1939-priv.h                                      |    1 
 net/can/j1939/main.c                                            |    3 
 net/can/j1939/socket.c                                          |   52 +
 net/ceph/messenger.c                                            |    7 
 net/core/dev_ioctl.c                                            |   22 
 net/hsr/hsr_device.c                                            |   28 -
 net/hsr/hsr_main.c                                              |    4 
 net/hsr/hsr_main.h                                              |    3 
 net/ipv4/ip_tunnel_core.c                                       |    6 
 net/ipv4/tcp_bpf.c                                              |    5 
 net/mptcp/sockopt.c                                             |   11 
 net/netfilter/nf_tables_api.c                                   |  123 +++-
 net/netfilter/nft_dynset.c                                      |    5 
 net/netfilter/nft_lookup.c                                      |   67 +-
 net/netfilter/nft_objref.c                                      |    5 
 net/netfilter/nft_set_bitmap.c                                  |   14 
 net/netfilter/nft_set_hash.c                                    |   54 --
 net/netfilter/nft_set_pipapo.c                                  |  214 ++------
 net/netfilter/nft_set_pipapo_avx2.c                             |   27 -
 net/netfilter/nft_set_rbtree.c                                  |   46 -
 net/netlink/genetlink.c                                         |    3 
 net/sunrpc/sched.c                                              |    2 
 net/sunrpc/xprtsock.c                                           |    6 
 net/xdp/xsk.c                                                   |  113 +++-
 net/xdp/xsk_queue.h                                             |   12 
 samples/ftrace/ftrace-direct-modify.c                           |    2 
 tools/testing/selftests/net/can/config                          |    3 
 234 files changed, 3151 insertions(+), 1712 deletions(-)

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels

Alex Deucher (3):
      Revert "drm/amdgpu: Add more checks to PSP mailbox"
      drm/amdgpu: fix a memory leak in fence cleanup when unloading
      drm/amd/display: use udelay rather than fsleep

Alex Markuze (2):
      ceph: fix race condition validating r_parent before applying state
      ceph: fix race condition where r_parent becomes stale before sending message

Alex Tran (1):
      docs: networking: can: change bcm_msg_head frames member to support flexible array

Alexander Sverdlin (1):
      mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing

Alok Tiwari (1):
      genetlink: fix genl_bind() invoking bind() after -EPERM

Amir Goldstein (2):
      fhandle: use more consistent rules for decoding file handle from userns
      fuse: do not allow mapping a non-regular backing file

Anders Roxell (1):
      dmaengine: ti: edma: Fix memory allocation size for queue_priority_map

Andreas Kemnade (1):
      regulator: sy7636a: fix lifecycle of power good gpio

Anssi Hannula (1):
      can: xilinx_can: xcan_write_frame(): fix use-after-free of transmitted SKB

Antheas Kapenekakis (1):
      Input: xpad - add support for Flydigi Apex 5

Antoine Tenart (1):
      tunnels: reset the GSO metadata before reusing the skb

Baochen Qiang (1):
      dma-debug: don't enforce dma mapping check on noncoherent allocations

Boris Burkov (2):
      btrfs: fix squota compressed stats leak
      btrfs: use readahead_expand() on compressed extents

Breno Leitao (2):
      arm64: kexec: initialize kexec_buf struct in load_other_segments()
      s390: kexec: initialize kexec_buf struct

Carolina Jubran (1):
      net: dev_ioctl: take ops lock in hwtstamp lower paths

Chen Ridong (1):
      kernfs: Fix UAF in polling when open file is released

Chia-I Wu (1):
      drm/panthor: validate group queue count

Chiasheng Lee (1):
      i2c: i801: Hide Intel Birch Stream SoC TCO WDT

Christian Brauner (1):
      coredump: don't pointlessly check and spew warnings

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Pro Gen10 AMD to i8042 quirk table

Christoph Hellwig (2):
      fs: add a FMODE_ flag to indicate IOCB_HAS_METADATA availability
      block: don't silently ignore metadata for sync read/write

Christophe JAILLET (1):
      mtd: rawnand: nuvoton: Fix an error handling path in ma35_nand_chips_init()

Christophe Kerello (2):
      mtd: rawnand: stm32_fmc2: avoid overlapping mappings on ECC buffer
      mtd: rawnand: stm32_fmc2: fix ECC overwrite

Dan Carpenter (2):
      irqchip/mvebu-gicp: Fix an IS_ERR() vs NULL check in probe()
      dmaengine: idxd: Fix double free in idxd_setup_wqs()

Daniel Borkmann (1):
      bpf: Fix out-of-bounds dynptr write in bpf_crypto_crypt

David Rosca (2):
      drm/amdgpu/vcn: Allow limiting ctx to instance 0 for AV1 at any time
      drm/amdgpu/vcn4: Fix IB parsing with multiple engine info packages

Davide Caratti (1):
      selftests: can: enable CONFIG_CAN_VCAN as a module

Edward Adam Davis (1):
      fuse: Block access to folio overlimit

Fabian Vogt (1):
      tty: hvc_console: Call hvc_kick in hvc_write unconditionally

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A w/audio compositions
      USB: serial: option: add Telit Cinterion LE910C4-WWX new compositions

Fangzhi Zuo (1):
      drm/amd/display: Disable DPCD Probe Quirk

Florian Westphal (11):
      netfilter: nft_set_bitmap: fix lockdep splat due to missing annotation
      netfilter: nft_set_pipapo: remove unused arguments
      netfilter: nft_set: remove one argument from lookup and update functions
      netfilter: nft_set_pipapo: merge pipapo_get/lookup
      netfilter: nft_set_pipapo: don't return bogus extension pointer
      netfilter: nft_set_pipapo: don't check genbit from packetpath lookups
      netfilter: nft_set_rbtree: continue traversal if element is inactive
      netfilter: nf_tables: place base_seq in struct net
      netfilter: nf_tables: make nft_set_do_lookup available unconditionally
      netfilter: nf_tables: restart set lookup on base_seq change
      netfilter: nft_set_pipapo: fix null deref for empty set

Gao Xiang (4):
      erofs: get rid of {get,put}_page() for ztailpacking data
      erofs: remove need_kmap in erofs_read_metabuf()
      erofs: unify meta buffers in z_erofs_fill_inode()
      erofs: fix invalid algorithm for encoded extents

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Fix setting of CPPC.min_perf in active mode for performance governor

Geoffrey McRae (1):
      drm/amd/display: remove oem i2c adapter on finish

Greg Kroah-Hartman (1):
      Linux 6.16.8

Guenter Roeck (1):
      trace/fgraph: Fix error handling

Hangbin Liu (3):
      hsr: use rtnl lock when iterating over ports
      hsr: use hsr_for_each_port_rtnl in hsr_port_get_hsr
      hsr: hold rcu and dev lock for hsr_get_port_ndev

Hugo Villeneuve (1):
      serial: sc16is7xx: fix bug in flow control levels init

Ilya Dryomov (1):
      libceph: fix invalid accesses to ceph_connection_v1_info

Imre Deak (3):
      drm/edid: Define the quirks in an enum list
      drm/edid: Add support for quirks visible to DRM core and drivers
      drm/dp: Add an EDID quirk for the DPCD register access probe

Jani Nikula (1):
      drm/i915/power: fix size for for_each_set_bit() in abox iteration

Jason Gunthorpe (3):
      iommu/vt-d: Split intel_iommu_domain_alloc_paging_flags()
      iommu/vt-d: Create unique domain ops for each stage
      iommu/vt-d: Split paging_domain_compatible()

Jeff LaBundy (1):
      Input: iqs7222 - avoid enabling unused interrupts

Jeongjun Park (1):
      mm/hugetlb: add missing hugetlb_lock in __unmap_hugepage_range()

Jesper Dangaard Brouer (1):
      bpf, cpumap: Disable page_pool direct xdp_return need larger scope

Jiawen Wu (1):
      net: libwx: fix to enable RSS

Johan Hovold (4):
      drm/mediatek: fix potential OF node use-after-free
      phy: tegra: xusb: fix device and OF node leak at probe
      phy: ti: omap-usb2: fix device leak at unbind
      phy: ti-pipe3: fix device leak at unbind

Johannes Berg (1):
      wifi: iwlwifi: fix 130/1030 configs

Jonas Gorski (1):
      net: dsa: b53: fix ageing time for BCM53101

Jonas Jelonek (3):
      i2c: rtl9300: fix channel number bound check
      i2c: rtl9300: ensure data length is within supported range
      i2c: rtl9300: remove broken SMBus Quick operation support

Jonathan Curley (1):
      NFSv4/flexfiles: Fix layout merge mirror check.

Justin Worrell (1):
      SUNRPC: call xs_sock_process_cmsg for all cmsg

K Prateek Nayak (1):
      x86/cpu/topology: Always try cpu_parse_topology_ext() on AMD/Hygon

KaFai Wan (1):
      bpf: Allow fall back to interpreter for programs with stack size <= 512

Kan Liang (1):
      perf: Fix the POLL_HUP delivery breakage

Klaus Kudielka (1):
      PCI: mvebu: Fix use of for_each_of_range() iterator

Kohei Enju (1):
      igb: fix link test skipping when interface is admin down

Krister Johansen (1):
      mptcp: sockopt: make sync_socket_options propagate SOCK_KEEPOPEN

Krzysztof Kozlowski (1):
      dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks

Kumar Kartikeya Dwivedi (1):
      rqspinlock: Choose trylock fallback for NMI waiters

Kuniyuki Iwashima (1):
      tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict() fails to allocate psock->cork.

Kyle Meyer (1):
      mm/memory-failure: fix redundant updates for already poisoned pages

Lu Baolu (1):
      iommu/vt-d: Make iotlb_sync_map a static property of dmar_domain

Luiz Augusto von Dentz (3):
      Bluetooth: hci_conn: Fix not cleaning up Broadcaster/Broadcast Source
      Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK
      Bluetooth: ISO: Fix getname not returning broadcast fields

Luo Gengkun (1):
      tracing: Fix tracing_marker may trigger page fault during preempt_disable

Maciej Fijalkowski (1):
      xsk: Fix immature cq descriptor production

Mario Limonciello (1):
      drm/amd/display: Destroy cached state in complete() callback

Mario Limonciello (AMD) (2):
      cpufreq/amd-pstate: Fix a regression leading to EPP 0 after resume
      drm/amd/display: Drop dm_prepare_suspend() and dm_complete()

Mark Tinguely (1):
      ocfs2: fix recursive semaphore deadlock in fiemap call

Mathias Nyman (3):
      xhci: dbc: decouple endpoint allocation from initialization
      xhci: dbc: Fix full DbC transfer ring after several reconnects
      xhci: fix memory leak regression when freeing xhci vdev devices depth first

Matthieu Baerts (NGI0) (2):
      doc: mptcp: net.mptcp.pm_type is deprecated
      netlink: specs: mptcp: fix if-idx attribute type

Max Kellermann (2):
      ceph: always call ceph_shift_unused_folios_left()
      ceph: fix crash after fscrypt_encrypt_pagecache_blocks() error

Miaohe Lin (1):
      mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory

Miaoqian Lin (1):
      dmaengine: dw: dmamux: Fix device reference leak in rzn1_dmamux_route_allocate

Miaoqing Pan (2):
      wifi: ath12k: Fix missing station power save configuration
      wifi: ath12k: fix WMI TLV header misalignment

Michal Schmidt (1):
      i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Michal Wajdeczko (1):
      drm/xe/configfs: Don't touch survivability_mode on fini

Miklos Szeredi (2):
      fuse: check if copy_file_range() returns larger than requested size
      fuse: prevent overflow in copy_file_range return value

Miquel Raynal (2):
      mtd: spinand: Add a ->configure_chip() hook
      mtd: spinand: winbond: Enable high-speed modes on w25n0xjw

Nathan Chancellor (1):
      compiler-clang.h: define __SANITIZE_*__ macros only when undefined

Oleksij Rempel (1):
      net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups

Omar Sandoval (1):
      btrfs: fix subvolume deletion lockup caused by inodes xarray race

Ovidiu Bunea (1):
      drm/amd/display: Correct sequences and delays for DCN35 PG & RCG

Paolo Abeni (1):
      Revert "net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups"

Paulo Alcantara (2):
      smb: client: fix compound alignment with encryption
      smb: client: fix data loss due to broken rename(2)

Peilin Ye (1):
      bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()

Pengyu Luo (1):
      phy: qualcomm: phy-qcom-eusb2-repeater: fix override properties

Petr Machata (1):
      net: bridge: Bounce invalid boolopts

Phil Sutter (1):
      netfilter: nf_tables: Reintroduce shortened deletion notifications

Pratap Nirujogi (1):
      drm/amd/amdgpu: Declare isp firmware binary file

Pu Lehui (1):
      tracing: Silence warning when chunk allocation fails in trace_pid_write

Qu Wenruo (1):
      btrfs: fix corruption reading compressed range when block size is smaller than page size

Quanmin Yan (2):
      mm/damon/lru_sort: avoid divide-by-zero in damon_lru_sort_apply_parameters()
      mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()

RD Babiera (1):
      usb: typec: tcpm: properly deliver cable vdms to altmode drivers

Rafael J. Wysocki (2):
      PM: EM: Add function for registering a PD without capacity update
      PM: hibernate: Restrict GFP mask in hibernation_snapshot()

Reinette Chatre (1):
      fs/resctrl: Eliminate false positive lockdep warning when reading SNC counters

Salah Triki (1):
      EDAC/altera: Delete an inappropriate dma_free_coherent() call

Sang-Heon Jeon (1):
      mm/damon/core: set quota->charged_from to jiffies at first charge window

Santhosh Kumar K (1):
      mtd: spinand: winbond: Fix oob_layout for W25N01JW

Sarika Sharma (1):
      wifi: ath12k: add link support for multi-link in arsta

Scott Mayhew (1):
      nfs/localio: restore creds before releasing pageio data

Sriram R (1):
      wifi: ath12k: Add support to enqueue management frame at MLD level

Stanislav Fomichev (1):
      macsec: sync features on RTM_NEWLINK

Stanislav Fort (1):
      mm/damon/sysfs: fix use-after-free in state_show()

Stefan Wahren (1):
      net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()

Stephan Gerhold (2):
      dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees
      phy: qcom: qmp-pcie: Fix PHY initialization when powered down by firmware

Takashi Iwai (2):
      usb: gadget: midi2: Fix missing UMP group attributes initialization
      usb: gadget: midi2: Fix MIDI2 IN EP max packet size

Tetsuo Handa (3):
      can: j1939: implement NETDEV_UNREGISTER notification handler
      can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed
      can: j1939: j1939_local_ecu_get(): undo increment when j1939_local_ecu_get() fails

Thomas Hellström (3):
      drm/xe: Attempt to bring bos back to VRAM after eviction
      drm/xe: Allow the pm notifier to continue on failure
      drm/xe: Block exec and rebind worker while evicting for suspend / hibernate

Thomas Richter (2):
      s390/pai: Deny all events not handled by this PMU
      s390/cpum_cf: Deny all sampling events by counter PMU

Tianyu Xu (1):
      igb: Fix NULL pointer dereference in ethtool loopback test

Tigran Mkrtchyan (1):
      flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_read

Trond Myklebust (10):
      NFSv4: Don't clear capabilities that won't be reset
      NFSv4: Clear the NFS_CAP_FS_LOCATIONS flag if it is not set
      NFSv4: Clear NFS_CAP_OPEN_XOR and NFS_CAP_DELEGTIME if not supported
      NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server
      NFS: Serialise O_DIRECT i/o and truncate()
      NFSv4.2: Serialise O_DIRECT i/o and fallocate()
      NFSv4.2: Serialise O_DIRECT i/o and clone range
      NFSv4.2: Serialise O_DIRECT i/o and copy range
      NFS: nfs_invalidate_folio() must observe the offset and size arguments
      Revert "SUNRPC: Don't allow waiting for exiting tasks"

Uladzislau Rezki (Sony) (1):
      mm/vmalloc, mm/kasan: respect gfp mask in kasan_populate_vmalloc()

Vladimir Oltean (2):
      net: phylink: add lock for serializing concurrent pl->phydev writes with resolver
      net: phy: transfer phy_config_inband() locking responsibility to phylink

Vladimir Riabchun (1):
      ftrace/samples: Fix function size computation

Wang Liang (1):
      tracing/osnoise: Fix null-ptr-deref in bitmap_parselist()

Wei Yang (1):
      mm/khugepaged: fix the address passed to notifier on testing young

Xiao Ni (1):
      md: keep recovery_cp in mdp_superblock_s

Xiongfeng Wang (1):
      hrtimers: Unconditionally update target CPU base after offline timer migration

Yi Sun (2):
      dmaengine: idxd: Remove improper idxd_free
      dmaengine: idxd: Fix refcount underflow on module unload

Yuezhang Mo (1):
      erofs: fix runtime warning on truncate_folio_batch_exceptionals()

wangzijie (1):
      proc: fix type confusion in pde_set_flags()


