Return-Path: <stable+bounces-180666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27730B8A14B
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BE41C23C8C
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9312316196;
	Fri, 19 Sep 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kdnDTj6a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99483315778;
	Fri, 19 Sep 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293459; cv=none; b=LMZXfp6RgO6UhSXhgc3B/5PxvJU5800USwlaEk4zQNOySZu4IjCXlrnh7MdYSN4h0UowwhsNSqcp7eqFtT6vbXNl2uq37V8+uQGjUQIOCAPseqMZk3R8/9RwWq2ggzL+Y5JeUSP7mU0GpEylf25VhBUy/T9FSq/gcck/z81/hyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293459; c=relaxed/simple;
	bh=WrYTr/xs89W/OqkkL0d4+0e3s9TZrhHgQ7laTt5z2tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HiX6ZpRywr6UCVwOkhSCJBPH4Gox+Vfca70v1KhL7J5iUdbrEGGK/Rp+CixfAbq3+K27fuM5bMcsmK3Hx6kji8TiM1YMCmvtuEaAaAzpm4yjTTGRc1IabpqUsQgiVvSYhCVNoTludil+vdySsrHuw/dD/04PFUL49ea2S31sths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kdnDTj6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FE8C4CEF5;
	Fri, 19 Sep 2025 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758293459;
	bh=WrYTr/xs89W/OqkkL0d4+0e3s9TZrhHgQ7laTt5z2tg=;
	h=From:To:Cc:Subject:Date:From;
	b=kdnDTj6aAQ8DlnlpDYXh22980bQYlexfDZKGKn7JF7gKGYbG4jkJXbINFbL2vH3eV
	 npKlupk+9LVe1T4v/kA8HCNDHtqMy6Tz5eYPvNBVboL5g1aat6nWReaHNbT7kQq4jQ
	 O+QXdKj7GPS4kt0NujKV55PS8vV8lgdNblGPRXBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.107
Date: Fri, 19 Sep 2025 16:50:50 +0200
Message-ID: <2025091951-likewise-schilling-85be@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.107 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml |    2 
 Documentation/networking/can.rst                                |    2 
 Makefile                                                        |    2 
 arch/riscv/include/asm/compat.h                                 |    1 
 arch/s390/kernel/perf_cpum_cf.c                                 |    4 
 arch/x86/kernel/vmlinux.lds.S                                   |   10 
 arch/x86/kvm/cpuid.c                                            |    5 
 drivers/dma/dw/rzn1-dmamux.c                                    |   15 
 drivers/dma/idxd/init.c                                         |   39 +-
 drivers/dma/qcom/bam_dma.c                                      |    8 
 drivers/dma/ti/edma.c                                           |    4 
 drivers/edac/altera_edac.c                                      |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                           |   12 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                           |   64 +---
 drivers/gpu/drm/i915/display/intel_display_power.c              |    6 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                          |   11 
 drivers/i2c/busses/i2c-i801.c                                   |    2 
 drivers/input/misc/iqs7222.c                                    |    3 
 drivers/input/serio/i8042-acpipnpio.h                           |   14 
 drivers/media/i2c/imx214.c                                      |   27 +
 drivers/mtd/nand/raw/atmel/nand-controller.c                    |   18 -
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                          |   46 +-
 drivers/net/can/xilinx_can.c                                    |   16 -
 drivers/net/ethernet/freescale/fec_main.c                       |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    2 
 drivers/net/ethernet/intel/igb/igb_ethtool.c                    |    5 
 drivers/net/phy/mdio_bus.c                                      |    4 
 drivers/phy/tegra/xusb-tegra210.c                               |    6 
 drivers/phy/ti/phy-ti-pipe3.c                                   |   13 
 drivers/regulator/sy7636a-regulator.c                           |    7 
 drivers/tty/hvc/hvc_console.c                                   |    6 
 drivers/tty/serial/sc16is7xx.c                                  |   14 
 drivers/usb/gadget/function/f_midi2.c                           |   11 
 drivers/usb/gadget/udc/dummy_hcd.c                              |    8 
 drivers/usb/host/xhci-mem.c                                     |    2 
 drivers/usb/serial/option.c                                     |   17 +
 fs/btrfs/extent_io.c                                            |   78 ++++
 fs/fuse/file.c                                                  |    5 
 fs/kernfs/file.c                                                |   54 ++-
 fs/nfs/client.c                                                 |    2 
 fs/nfs/direct.c                                                 |   21 +
 fs/nfs/file.c                                                   |   14 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |   21 -
 fs/nfs/inode.c                                                  |    4 
 fs/nfs/internal.h                                               |   17 -
 fs/nfs/io.c                                                     |   55 ++-
 fs/nfs/nfs42proc.c                                              |    2 
 fs/nfs/nfs4file.c                                               |    2 
 fs/nfs/nfs4proc.c                                               |    6 
 fs/nfsd/nfs4proc.c                                              |    4 
 fs/nfsd/vfs.c                                                   |   13 
 fs/ocfs2/extent_map.c                                           |   10 
 fs/proc/generic.c                                               |    3 
 fs/smb/client/file.c                                            |   16 -
 fs/smb/server/connection.h                                      |   11 
 fs/smb/server/mgmt/user_session.c                               |    4 
 fs/smb/server/smb2pdu.c                                         |   14 
 include/linux/compiler-clang.h                                  |   29 +
 include/linux/pgalloc.h                                         |   29 +
 include/linux/pgtable.h                                         |   13 
 include/net/sock.h                                              |   40 ++
 kernel/bpf/helpers.c                                            |    7 
 kernel/rcu/tasks.h                                              |  107 +++++-
 kernel/time/hrtimer.c                                           |   50 ---
 kernel/trace/trace.c                                            |   10 
 mm/Kconfig                                                      |    2 
 mm/damon/core.c                                                 |    4 
 mm/damon/lru_sort.c                                             |    3 
 mm/damon/reclaim.c                                              |    3 
 mm/damon/sysfs.c                                                |   14 
 mm/kasan/init.c                                                 |   12 
 mm/kasan/kasan_test.c                                           |    1 
 mm/khugepaged.c                                                 |   22 -
 mm/memory-failure.c                                             |    7 
 mm/percpu.c                                                     |    6 
 mm/sparse-vmemmap.c                                             |    6 
 net/bridge/br.c                                                 |    7 
 net/can/j1939/bus.c                                             |    5 
 net/can/j1939/socket.c                                          |    3 
 net/ceph/messenger.c                                            |    7 
 net/core/sock.c                                                 |    5 
 net/hsr/hsr_device.c                                            |  158 +++++++++-
 net/hsr/hsr_main.c                                              |    4 
 net/hsr/hsr_main.h                                              |    3 
 net/ipv4/ip_tunnel_core.c                                       |    6 
 net/ipv4/tcp_bpf.c                                              |    5 
 net/mptcp/sockopt.c                                             |   11 
 net/sunrpc/sched.c                                              |    2 
 net/sunrpc/xprtsock.c                                           |    6 
 samples/ftrace/ftrace-direct-modify.c                           |    2 
 scripts/Makefile.kasan                                          |   12 
 security/integrity/ima/ima_main.c                               |   16 -
 security/integrity/integrity.h                                  |    3 
 94 files changed, 985 insertions(+), 404 deletions(-)

Ada Couprie Diaz (1):
      kasan: fix GCC mem-intrinsic prefix with sw tags

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels

Alex Deucher (1):
      drm/amdgpu: fix a memory leak in fence cleanup when unloading

Alex Tran (1):
      docs: networking: can: change bcm_msg_head frames member to support flexible array

Alexander Dahl (1):
      mtd: nand: raw: atmel: Fix comment in timings preparation

Alexander Sverdlin (1):
      mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing

Anders Roxell (1):
      dmaengine: ti: edma: Fix memory allocation size for queue_priority_map

Andreas Kemnade (1):
      regulator: sy7636a: fix lifecycle of power good gpio

André Apitzsch (1):
      media: i2c: imx214: Fix link frequency validation

Anssi Hannula (1):
      can: xilinx_can: xcan_write_frame(): fix use-after-free of transmitted SKB

Antoine Tenart (1):
      tunnels: reset the GSO metadata before reusing the skb

Boris Burkov (1):
      btrfs: use readahead_expand() on compressed extents

Borislav Petkov (AMD) (1):
      KVM: SVM: Set synthesized TSA CPUID flags

Buday Csaba (1):
      net: mdiobus: release reset_gpio in mdiobus_unregister_device()

Chen Ridong (1):
      kernfs: Fix UAF in polling when open file is released

Chiasheng Lee (1):
      i2c: i801: Hide Intel Birch Stream SoC TCO WDT

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Pro Gen10 AMD to i8042 quirk table

Christophe Kerello (2):
      mtd: rawnand: stm32_fmc2: avoid overlapping mappings on ECC buffer
      mtd: rawnand: stm32_fmc2: fix ECC overwrite

Chuck Lever (1):
      NFSD: nfsd_unlink() clobbers non-zero status returned from fh_fill_pre_attrs()

Dan Carpenter (1):
      dmaengine: idxd: Fix double free in idxd_setup_wqs()

David Rosca (2):
      drm/amdgpu/vcn: Allow limiting ctx to instance 0 for AV1 at any time
      drm/amdgpu/vcn4: Fix IB parsing with multiple engine info packages

Fabian Vogt (1):
      tty: hvc_console: Call hvc_kick in hvc_write unconditionally

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A w/audio compositions
      USB: serial: option: add Telit Cinterion LE910C4-WWX new compositions

Greg Kroah-Hartman (1):
      Linux 6.6.107

Guenter Roeck (1):
      x86: disable image size check for test builds

Hangbin Liu (2):
      hsr: use rtnl lock when iterating over ports
      hsr: use hsr_for_each_port_rtnl in hsr_port_get_hsr

Harry Yoo (1):
      mm: introduce and use {pgd,p4d}_populate_kernel()

Hugo Villeneuve (1):
      serial: sc16is7xx: fix bug in flow control levels init

Ilya Dryomov (1):
      libceph: fix invalid accesses to ceph_connection_v1_info

Jani Nikula (1):
      drm/i915/power: fix size for for_each_set_bit() in abox iteration

Jeff LaBundy (1):
      Input: iqs7222 - avoid enabling unused interrupts

Jiapeng Chong (2):
      hrtimer: Remove unused function
      hrtimer: Rename __hrtimer_hres_active() to hrtimer_hres_active()

Johan Hovold (3):
      drm/mediatek: fix potential OF node use-after-free
      phy: tegra: xusb: fix device and OF node leak at probe
      phy: ti-pipe3: fix device leak at unbind

Jonathan Curley (1):
      NFSv4/flexfiles: Fix layout merge mirror check.

Justin Worrell (1):
      SUNRPC: call xs_sock_process_cmsg for all cmsg

Kohei Enju (1):
      igb: fix link test skipping when interface is admin down

Krister Johansen (1):
      mptcp: sockopt: make sync_socket_options propagate SOCK_KEEPOPEN

Krzysztof Kozlowski (1):
      dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks

Kuniyuki Iwashima (2):
      net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
      tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict() fails to allocate psock->cork.

Linus Torvalds (1):
      Disable SLUB_TINY for build testing

Luo Gengkun (1):
      tracing: Fix tracing_marker may trigger page fault during preempt_disable

Mark Tinguely (1):
      ocfs2: fix recursive semaphore deadlock in fiemap call

Mathias Nyman (1):
      xhci: fix memory leak regression when freeing xhci vdev devices depth first

Max Kellermann (1):
      fs/nfs/io: make nfs_start_io_*() killable

Miaohe Lin (1):
      mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory

Miaoqian Lin (1):
      dmaengine: dw: dmamux: Fix device reference leak in rzn1_dmamux_route_allocate

Michal Schmidt (1):
      i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Miklos Szeredi (2):
      fuse: check if copy_file_range() returns larger than requested size
      fuse: prevent overflow in copy_file_range return value

Mimi Zohar (1):
      ima: limit the number of ToMToU integrity violations

Murali Karicheri (2):
      net: hsr: Add support for MC filtering at the slave device
      net: hsr: Add VLAN CTAG filter support

Namjae Jeon (1):
      ksmbd: fix null pointer dereference in alloc_preauth_hash()

Nathan Chancellor (1):
      compiler-clang.h: define __SANITIZE_*__ macros only when undefined

Oleksij Rempel (1):
      net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups

Palmer Dabbelt (1):
      RISC-V: Remove unnecessary include from compat.h

Paolo Abeni (1):
      Revert "net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups"

Paul E. McKenney (3):
      rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
      rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
      rcu-tasks: Maintain real-time response in rcu_tasks_postscan()

Peilin Ye (1):
      bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()

Petr Machata (1):
      net: bridge: Bounce invalid boolopts

Pu Lehui (1):
      tracing: Silence warning when chunk allocation fails in trace_pid_write

Qu Wenruo (1):
      btrfs: fix corruption reading compressed range when block size is smaller than page size

Quanmin Yan (2):
      mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()
      mm/damon/lru_sort: avoid divide-by-zero in damon_lru_sort_apply_parameters()

Salah Triki (1):
      EDAC/altera: Delete an inappropriate dma_free_coherent() call

Sang-Heon Jeon (1):
      mm/damon/core: set quota->charged_from to jiffies at first charge window

Stanislav Fort (1):
      mm/damon/sysfs: fix use-after-free in state_show()

Stefan Wahren (1):
      net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()

Stephan Gerhold (1):
      dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees

Takashi Iwai (2):
      usb: gadget: midi2: Fix missing UMP group attributes initialization
      usb: gadget: midi2: Fix MIDI2 IN EP max packet size

Tetsuo Handa (2):
      can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed
      can: j1939: j1939_local_ecu_get(): undo increment when j1939_local_ecu_get() fails

Thomas Richter (1):
      s390/cpum_cf: Deny all sampling events by counter PMU

Tigran Mkrtchyan (1):
      flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_read

Trond Myklebust (9):
      nfsd: Fix a regression in nfsd_setattr()
      NFSv4: Don't clear capabilities that won't be reset
      NFSv4: Clear the NFS_CAP_FS_LOCATIONS flag if it is not set
      NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server
      NFS: Serialise O_DIRECT i/o and truncate()
      NFSv4.2: Serialise O_DIRECT i/o and fallocate()
      NFSv4.2: Serialise O_DIRECT i/o and clone range
      NFSv4.2: Serialise O_DIRECT i/o and copy range
      Revert "SUNRPC: Don't allow waiting for exiting tasks"

Vishal Moola (Oracle) (1):
      mm/khugepaged: convert hpage_collapse_scan_pmd() to use folios

Vladimir Riabchun (1):
      ftrace/samples: Fix function size computation

Wei Yang (1):
      mm/khugepaged: fix the address passed to notifier on testing young

Xiongfeng Wang (1):
      hrtimers: Unconditionally update target CPU base after offline timer migration

Yang Erkun (1):
      cifs: fix pagecache leak when do writepages

Yeoreum Yun (1):
      kunit: kasan_test: disable fortify string checker on kasan_strings() test

Yi Sun (2):
      dmaengine: idxd: Remove improper idxd_free
      dmaengine: idxd: Fix refcount underflow on module unload

wangzijie (1):
      proc: fix type confusion in pde_set_flags()


