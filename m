Return-Path: <stable+bounces-180669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BDCB8A15E
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 16:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D04C7BDFD4
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC453176ED;
	Fri, 19 Sep 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wEvYIwmh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572272737E6;
	Fri, 19 Sep 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293471; cv=none; b=DCOyQtnnIB5aHLCAlNnKJx77f8VdHOCH1cPJnC4ne1n6Vx21pt6sdyvfDzmliienVX9hCqU3kvL5Ch3zAa4lMmMe4pTU+YVpvT1uCbHRlmG7Dwvx3La+1HhDRk1xjhYB9yyF802kM2HrJw/u0rWGzr7B70GuM3FMAZrLMfCC1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293471; c=relaxed/simple;
	bh=gY4fonPtQefdzU0EIqej0Dv23KXZJ748wv2gqCnn2C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fggLhkWEGzMzwGIn4QhdtCpHW2xfR5nW8+6PX1Y0CKeP3jpE/qR3qr4IkbEQoUi/dLy5yq5Mo8GFYDikYG8Wgxl6uiMTJ29mWL7cFnhM0uQPiYgB5Qa7sVJkzFsSPVMFlvH3HTD3rY+t2yRZsfrMLQ/fhEn2mx/K1HwDNlQaPX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wEvYIwmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8800DC4CEF0;
	Fri, 19 Sep 2025 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758293470;
	bh=gY4fonPtQefdzU0EIqej0Dv23KXZJ748wv2gqCnn2C8=;
	h=From:To:Cc:Subject:Date:From;
	b=wEvYIwmhqAc9+4eDpjQ+D7UQcf2QXjG0pcAqCpbepcUnGIQ6JQwWv6VrechCpdkaR
	 f0vUinHi/Jo0PKoGoqbfe7hWSDXkKPE6Bs9W5tWIuZFzkQT5YPaC90cX7x5RmbjkLM
	 t8Tf7mLlPL9h/jCf0fPA6bWmrhikKJ2sab5zhIr0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.48
Date: Fri, 19 Sep 2025 16:50:56 +0200
Message-ID: <2025091956-breeching-ceramics-a2b8@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.48 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml        |    2 
 Documentation/filesystems/nfs/localio.rst                              |   13 
 Documentation/netlink/specs/mptcp_pm.yaml                              |   52 +-
 Documentation/networking/can.rst                                       |    2 
 Makefile                                                               |    2 
 arch/riscv/include/asm/compat.h                                        |    1 
 arch/s390/kernel/perf_cpum_cf.c                                        |    4 
 arch/s390/kernel/perf_pai_crypto.c                                     |    4 
 arch/s390/kernel/perf_pai_ext.c                                        |    2 
 arch/x86/kernel/cpu/topology_amd.c                                     |   25 -
 arch/x86/kernel/vmlinux.lds.S                                          |   10 
 drivers/dma-buf/Kconfig                                                |    1 
 drivers/dma-buf/udmabuf.c                                              |   22 -
 drivers/dma/dw/rzn1-dmamux.c                                           |   15 
 drivers/dma/idxd/init.c                                                |   39 -
 drivers/dma/qcom/bam_dma.c                                             |    8 
 drivers/dma/ti/edma.c                                                  |    4 
 drivers/edac/altera_edac.c                                             |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                               |    3 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                  |   12 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                  |   64 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                                        |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |    5 
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c                   |    7 
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c              |    6 
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c                 |    8 
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c               |   10 
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c                |    2 
 drivers/gpu/drm/i915/display/intel_display_power.c                     |    6 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c                      |   16 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                 |   11 
 drivers/gpu/drm/panthor/panthor_drv.c                                  |    2 
 drivers/gpu/drm/xe/tests/xe_bo.c                                       |    2 
 drivers/gpu/drm/xe/tests/xe_dma_buf.c                                  |   10 
 drivers/gpu/drm/xe/xe_bo.c                                             |   16 
 drivers/gpu/drm/xe/xe_bo.h                                             |    2 
 drivers/gpu/drm/xe/xe_dma_buf.c                                        |    2 
 drivers/i2c/busses/i2c-i801.c                                          |    2 
 drivers/input/misc/iqs7222.c                                           |    3 
 drivers/input/serio/i8042-acpipnpio.h                                  |   14 
 drivers/mtd/nand/raw/atmel/nand-controller.c                           |   16 
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                                 |   46 +-
 drivers/mtd/nand/spi/winbond.c                                         |   37 +
 drivers/net/can/xilinx_can.c                                           |   16 
 drivers/net/ethernet/freescale/fec_main.c                              |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                            |    2 
 drivers/net/ethernet/intel/igb/igb_ethtool.c                           |    5 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c |   24 -
 drivers/net/phy/mdio_bus.c                                             |    4 
 drivers/nvme/host/pci.c                                                |    3 
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c                         |    4 
 drivers/phy/tegra/xusb-tegra210.c                                      |    6 
 drivers/phy/ti/phy-omap-usb2.c                                         |   13 
 drivers/phy/ti/phy-ti-pipe3.c                                          |   13 
 drivers/regulator/sy7636a-regulator.c                                  |    7 
 drivers/tty/hvc/hvc_console.c                                          |    6 
 drivers/tty/serial/sc16is7xx.c                                         |   14 
 drivers/usb/gadget/function/f_midi2.c                                  |   11 
 drivers/usb/gadget/udc/dummy_hcd.c                                     |    8 
 drivers/usb/host/xhci-mem.c                                            |    2 
 drivers/usb/serial/option.c                                            |   17 
 drivers/usb/typec/tcpm/tcpm.c                                          |   12 
 fs/btrfs/extent_io.c                                                   |   72 ++-
 fs/btrfs/inode.c                                                       |   12 
 fs/btrfs/qgroup.c                                                      |    6 
 fs/ceph/debugfs.c                                                      |   14 
 fs/ceph/dir.c                                                          |   17 
 fs/ceph/file.c                                                         |   24 -
 fs/ceph/inode.c                                                        |   88 +++-
 fs/ceph/mds_client.c                                                   |  172 ++++----
 fs/ceph/mds_client.h                                                   |   18 
 fs/ext4/namei.c                                                        |   14 
 fs/fhandle.c                                                           |    8 
 fs/fuse/file.c                                                         |    5 
 fs/fuse/passthrough.c                                                  |    5 
 fs/kernfs/file.c                                                       |   58 +-
 fs/nfs/client.c                                                        |    2 
 fs/nfs/direct.c                                                        |   22 -
 fs/nfs/file.c                                                          |   21 
 fs/nfs/flexfilelayout/flexfilelayout.c                                 |   21 
 fs/nfs/inode.c                                                         |    4 
 fs/nfs/internal.h                                                      |   17 
 fs/nfs/io.c                                                            |   55 +-
 fs/nfs/localio.c                                                       |  125 ++++-
 fs/nfs/nfs42proc.c                                                     |    2 
 fs/nfs/nfs4file.c                                                      |    2 
 fs/nfs/nfs4proc.c                                                      |    7 
 fs/nfs/write.c                                                         |    1 
 fs/ocfs2/extent_map.c                                                  |   10 
 fs/proc/generic.c                                                      |    3 
 include/linux/compiler-clang.h                                         |   29 +
 include/linux/fs.h                                                     |   10 
 include/linux/nfs_xdr.h                                                |    1 
 include/linux/pgalloc.h                                                |   29 +
 include/linux/pgtable.h                                                |   13 
 include/net/netfilter/nf_tables.h                                      |   11 
 include/net/netfilter/nf_tables_core.h                                 |   49 +-
 include/net/netns/nftables.h                                           |    1 
 include/trace/events/dma.h                                             |  153 ++++++-
 include/uapi/linux/mptcp_pm.h                                          |   50 +-
 kernel/bpf/core.c                                                      |   16 
 kernel/bpf/crypto.c                                                    |    2 
 kernel/bpf/helpers.c                                                   |    7 
 kernel/dma/debug.c                                                     |  135 +++---
 kernel/dma/debug.h                                                     |   20 
 kernel/dma/mapping.c                                                   |   41 +
 kernel/time/hrtimer.c                                                  |   11 
 kernel/trace/fgraph.c                                                  |    3 
 kernel/trace/trace.c                                                   |   10 
 mm/Kconfig                                                             |    2 
 mm/damon/core.c                                                        |    4 
 mm/damon/lru_sort.c                                                    |    5 
 mm/damon/reclaim.c                                                     |    5 
 mm/damon/sysfs.c                                                       |   14 
 mm/hugetlb.c                                                           |    9 
 mm/kasan/init.c                                                        |   12 
 mm/kasan/kasan_test_c.c                                                |    1 
 mm/khugepaged.c                                                        |    4 
 mm/memory-failure.c                                                    |   20 
 mm/percpu.c                                                            |    6 
 mm/sparse-vmemmap.c                                                    |    6 
 net/bridge/br.c                                                        |    7 
 net/can/j1939/bus.c                                                    |    5 
 net/can/j1939/socket.c                                                 |    3 
 net/ceph/messenger.c                                                   |    7 
 net/hsr/hsr_device.c                                                   |   97 ++++
 net/hsr/hsr_main.c                                                     |    4 
 net/hsr/hsr_main.h                                                     |    3 
 net/ipv4/ip_tunnel_core.c                                              |    6 
 net/ipv4/tcp_bpf.c                                                     |    5 
 net/mptcp/sockopt.c                                                    |   11 
 net/netfilter/nf_tables_api.c                                          |  123 +++--
 net/netfilter/nft_dynset.c                                             |    5 
 net/netfilter/nft_lookup.c                                             |   67 ++-
 net/netfilter/nft_objref.c                                             |    5 
 net/netfilter/nft_set_bitmap.c                                         |   11 
 net/netfilter/nft_set_hash.c                                           |   54 +-
 net/netfilter/nft_set_pipapo.c                                         |  214 +++-------
 net/netfilter/nft_set_pipapo_avx2.c                                    |   27 -
 net/netfilter/nft_set_rbtree.c                                         |   46 +-
 net/netlink/genetlink.c                                                |    3 
 net/sunrpc/sched.c                                                     |    2 
 net/sunrpc/xprtsock.c                                                  |    6 
 samples/ftrace/ftrace-direct-modify.c                                  |    2 
 sound/pci/hda/patch_realtek.c                                          |    1 
 145 files changed, 1896 insertions(+), 988 deletions(-)

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels

Alex Deucher (2):
      drm/amd/display: use udelay rather than fsleep
      drm/amdgpu: fix a memory leak in fence cleanup when unloading

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

Antoine Tenart (1):
      tunnels: reset the GSO metadata before reusing the skb

Aurabindo Pillai (1):
      Revert "drm/amd/display: Optimize cursor position updates"

Baochen Qiang (1):
      dma-debug: don't enforce dma mapping check on noncoherent allocations

Boris Burkov (2):
      btrfs: fix squota compressed stats leak
      btrfs: use readahead_expand() on compressed extents

Buday Csaba (1):
      net: mdiobus: release reset_gpio in mdiobus_unregister_device()

Chen Ridong (1):
      kernfs: Fix UAF in polling when open file is released

Chia-I Wu (1):
      drm/panthor: validate group queue count

Chiasheng Lee (1):
      i2c: i801: Hide Intel Birch Stream SoC TCO WDT

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Pro Gen10 AMD to i8042 quirk table

Christoph Hellwig (1):
      dma-debug: store a phys_addr_t in struct dma_debug_entry

Christophe Kerello (2):
      mtd: rawnand: stm32_fmc2: avoid overlapping mappings on ECC buffer
      mtd: rawnand: stm32_fmc2: fix ECC overwrite

Dan Carpenter (1):
      dmaengine: idxd: Fix double free in idxd_setup_wqs()

Daniel Borkmann (1):
      bpf: Fix out-of-bounds dynptr write in bpf_crypto_crypt

David Rosca (3):
      drm/amdgpu: Add back JPEG to video caps for carrizo and newer
      drm/amdgpu/vcn: Allow limiting ctx to instance 0 for AV1 at any time
      drm/amdgpu/vcn4: Fix IB parsing with multiple engine info packages

Fabian Vogt (1):
      tty: hvc_console: Call hvc_kick in hvc_write unconditionally

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A w/audio compositions
      USB: serial: option: add Telit Cinterion LE910C4-WWX new compositions

Fedor Pchelkin (1):
      dma-debug: fix physical address calculation for struct dma_debug_entry

Florian Westphal (10):
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

Greg Kroah-Hartman (1):
      Linux 6.12.48

Guenter Roeck (2):
      trace/fgraph: Fix error handling
      x86: disable image size check for test builds

Hangbin Liu (2):
      hsr: use rtnl lock when iterating over ports
      hsr: use hsr_for_each_port_rtnl in hsr_port_get_hsr

Harry Yoo (1):
      mm: introduce and use {pgd,p4d}_populate_kernel()

Huan Yang (1):
      Revert "udmabuf: fix vmap_udmabuf error page set"

Hugo Villeneuve (1):
      serial: sc16is7xx: fix bug in flow control levels init

Ilya Dryomov (1):
      libceph: fix invalid accesses to ceph_connection_v1_info

Jakub Kicinski (1):
      netlink: specs: mptcp: replace underscores with dashes in names

Jani Nikula (1):
      drm/i915/power: fix size for for_each_set_bit() in abox iteration

Jeff LaBundy (1):
      Input: iqs7222 - avoid enabling unused interrupts

Jeongjun Park (1):
      mm/hugetlb: add missing hugetlb_lock in __unmap_hugepage_range()

Johan Hovold (4):
      drm/mediatek: fix potential OF node use-after-free
      phy: tegra: xusb: fix device and OF node leak at probe
      phy: ti: omap-usb2: fix device leak at unbind
      phy: ti-pipe3: fix device leak at unbind

Jonathan Curley (1):
      NFSv4/flexfiles: Fix layout merge mirror check.

Justin Worrell (1):
      SUNRPC: call xs_sock_process_cmsg for all cmsg

K Prateek Nayak (1):
      x86/cpu/topology: Always try cpu_parse_topology_ext() on AMD/Hygon

KaFai Wan (1):
      bpf: Allow fall back to interpreter for programs with stack size <= 512

Kohei Enju (1):
      igb: fix link test skipping when interface is admin down

Krister Johansen (1):
      mptcp: sockopt: make sync_socket_options propagate SOCK_KEEPOPEN

Krzysztof Kozlowski (1):
      dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks

Kuniyuki Iwashima (1):
      tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict() fails to allocate psock->cork.

Kyle Meyer (1):
      mm/memory-failure: fix redundant updates for already poisoned pages

Linus Torvalds (1):
      Disable SLUB_TINY for build testing

Luo Gengkun (1):
      tracing: Fix tracing_marker may trigger page fault during preempt_disable

Mark Tinguely (1):
      ocfs2: fix recursive semaphore deadlock in fiemap call

Mathias Nyman (1):
      xhci: fix memory leak regression when freeing xhci vdev devices depth first

Matthieu Baerts (NGI0) (3):
      netlink: specs: mptcp: add missing 'server-side' attr
      netlink: specs: mptcp: clearly mention attributes
      netlink: specs: mptcp: fix if-idx attribute type

Maurizio Lombardi (1):
      nvme-pci: skip nvme_write_sq_db on empty rqlist

Max Kellermann (1):
      fs/nfs/io: make nfs_start_io_*() killable

Miaohe Lin (1):
      mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory

Miaoqian Lin (1):
      dmaengine: dw: dmamux: Fix device reference leak in rzn1_dmamux_route_allocate

Michal Schmidt (1):
      i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Mike Snitzer (2):
      nfs/localio: remove extra indirect nfs_to call to check {read,write}_iter
      nfs/localio: add direct IO enablement with sync and async IO support

Miklos Szeredi (2):
      fuse: check if copy_file_range() returns larger than requested size
      fuse: prevent overflow in copy_file_range return value

Murali Karicheri (1):
      net: hsr: Add VLAN CTAG filter support

Nathan Chancellor (1):
      compiler-clang.h: define __SANITIZE_*__ macros only when undefined

Oleksij Rempel (1):
      net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups

Omar Sandoval (1):
      btrfs: fix subvolume deletion lockup caused by inodes xarray race

Palmer Dabbelt (1):
      RISC-V: Remove unnecessary include from compat.h

Paolo Abeni (1):
      Revert "net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups"

Peilin Ye (1):
      bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()

Pengyu Luo (1):
      phy: qualcomm: phy-qcom-eusb2-repeater: fix override properties

Petr Machata (1):
      net: bridge: Bounce invalid boolopts

Phil Sutter (1):
      netfilter: nf_tables: Reintroduce shortened deletion notifications

Pu Lehui (1):
      tracing: Silence warning when chunk allocation fails in trace_pid_write

Qu Wenruo (1):
      btrfs: fix corruption reading compressed range when block size is smaller than page size

Quanmin Yan (2):
      mm/damon/lru_sort: avoid divide-by-zero in damon_lru_sort_apply_parameters()
      mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()

RD Babiera (1):
      usb: typec: tcpm: properly deliver cable vdms to altmode drivers

Salah Triki (1):
      EDAC/altera: Delete an inappropriate dma_free_coherent() call

Sang-Heon Jeon (1):
      mm/damon/core: set quota->charged_from to jiffies at first charge window

Santhosh Kumar K (1):
      mtd: spinand: winbond: Fix oob_layout for W25N01JW

Scott Mayhew (1):
      nfs/localio: restore creds before releasing pageio data

Sean Anderson (4):
      dma-mapping: trace dma_alloc/free direction
      dma-mapping: use trace_dma_alloc for dma_alloc* instead of using trace_dma_map
      dma-mapping: trace more error paths
      dma-mapping: fix swapped dir/flags arguments to trace_dma_alloc_sgt_err

Srinivasan Shanmugam (1):
      drm/amd/display: Fix error pointers in amdgpu_dm_crtc_mem_type_changed

Stanislav Fort (1):
      mm/damon/sysfs: fix use-after-free in state_show()

Stefan Wahren (1):
      net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()

Stephan Gerhold (1):
      dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees

Takashi Iwai (3):
      ALSA: hda/realtek: Fix built-in mic assignment on ASUS VivoBook X515UA
      usb: gadget: midi2: Fix missing UMP group attributes initialization
      usb: gadget: midi2: Fix MIDI2 IN EP max packet size

Tetsuo Handa (2):
      can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed
      can: j1939: j1939_local_ecu_get(): undo increment when j1939_local_ecu_get() fails

Theodore Ts'o (1):
      ext4: introduce linear search for dentries

Thomas Hellström (1):
      drm/xe: Attempt to bring bos back to VRAM after eviction

Thomas Richter (2):
      s390/pai: Deny all events not handled by this PMU
      s390/cpum_cf: Deny all sampling events by counter PMU

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

Umesh Nerlige Ramappa (1):
      drm/i915/pmu: Fix zero delta busyness issue

Vladimir Riabchun (1):
      ftrace/samples: Fix function size computation

Wei Yang (1):
      mm/khugepaged: fix the address passed to notifier on testing young

Xiongfeng Wang (1):
      hrtimers: Unconditionally update target CPU base after offline timer migration

Yeoreum Yun (1):
      kunit: kasan_test: disable fortify string checker on kasan_strings() test

Yevgeny Kliteynik (1):
      net/mlx5: HWS, change error flow on matcher disconnect

Yi Sun (2):
      dmaengine: idxd: Remove improper idxd_free
      dmaengine: idxd: Fix refcount underflow on module unload

wangzijie (1):
      proc: fix type confusion in pde_set_flags()


