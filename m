Return-Path: <stable+bounces-180664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A02B8A13C
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 16:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D32A1C23CDF
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D33258ED6;
	Fri, 19 Sep 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QmmVj+QT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF83F1F3FEC;
	Fri, 19 Sep 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293449; cv=none; b=B1T2LPNMFYp5ekgxs+2TfPnCS7mZBeEDX5XbXHMYYR+IVnHplSjaY8FaHeMAbLFWnfbYme1Y+1uWWdtb9YOuPqbWHbTpToFxdWImM9iB7n13zoGyEH07vmtPSI+glFMxeqjg6I19LFwclAb6aSQNlZojCYx72/TwjSKKH/h7zyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293449; c=relaxed/simple;
	bh=4QPs1GqEcmhynn34KuKOA1fUMqRhpN6hoHgUtNVHr6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mMTKZVVTVtt4qA4axkhSoc6PfPjD/5LEANWYi9d9qrpKkcXGVnOwJG88EbGHC+RqybcEupKYmUo7v/Yd07br7k6vI3tNv5GfjKvDHKwT3rE578u5WwfzeG6o6LzlxGXqgul1oa7DjfhAyJOHUDPf1kDHV8lSOZNXZZjK/gYwusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QmmVj+QT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B6BC4CEF0;
	Fri, 19 Sep 2025 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758293449;
	bh=4QPs1GqEcmhynn34KuKOA1fUMqRhpN6hoHgUtNVHr6o=;
	h=From:To:Cc:Subject:Date:From;
	b=QmmVj+QTrV30kRWqCMdlKxFcBtvoEEn9el2wTJrLdwADKbxZfiauH+EC7r7ORWUrv
	 5fXRoffdObaxUvbczqWNkn1Qh4XTC/jLw1EEs9kx9EBHPTIJ0sVA44DyPppIVZ3cUk
	 zE/Za6xfKjt09CIYc9Imw9EXtz5vL6izODZpCD/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.153
Date: Fri, 19 Sep 2025 16:50:44 +0200
Message-ID: <2025091945-rewrite-roast-b95a@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.153 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml |    2 
 Documentation/networking/can.rst                                |    2 
 Makefile                                                        |    2 
 arch/x86/kvm/cpuid.c                                            |   33 +-
 drivers/dma/dw/rzn1-dmamux.c                                    |   15 
 drivers/dma/idxd/init.c                                         |   33 +-
 drivers/dma/qcom/bam_dma.c                                      |    8 
 drivers/dma/ti/edma.c                                           |    4 
 drivers/edac/altera_edac.c                                      |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                        |    3 
 drivers/gpu/drm/i915/display/intel_display_power.c              |    6 
 drivers/input/misc/iqs7222.c                                    |    3 
 drivers/input/serio/i8042-acpipnpio.h                           |   14 
 drivers/media/i2c/imx214.c                                      |   27 +
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c      |    4 
 drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c      |    6 
 drivers/mtd/nand/raw/atmel/nand-controller.c                    |   18 -
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                          |   46 +-
 drivers/net/can/xilinx_can.c                                    |   16 
 drivers/net/ethernet/freescale/fec_main.c                       |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    2 
 drivers/net/ethernet/intel/igb/igb_ethtool.c                    |    5 
 drivers/phy/tegra/xusb-tegra210.c                               |    6 
 drivers/phy/ti/phy-ti-pipe3.c                                   |   13 
 drivers/regulator/sy7636a-regulator.c                           |    7 
 drivers/soc/qcom/mdt_loader.c                                   |   14 
 drivers/tty/hvc/hvc_console.c                                   |    6 
 drivers/tty/serial/sc16is7xx.c                                  |   14 
 drivers/usb/gadget/udc/dummy_hcd.c                              |    8 
 drivers/usb/serial/option.c                                     |   17 +
 fs/fuse/file.c                                                  |    5 
 fs/kernfs/file.c                                                |   54 ++-
 fs/nfs/client.c                                                 |    2 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |   21 -
 fs/nfs/nfs4proc.c                                               |    6 
 fs/ocfs2/extent_map.c                                           |   10 
 fs/proc/generic.c                                               |    3 
 include/linux/compiler-clang.h                                  |   29 +
 include/linux/pgalloc.h                                         |   29 +
 include/linux/pgtable.h                                         |   13 
 include/net/sock.h                                              |   40 ++
 kernel/time/hrtimer.c                                           |   50 ---
 kernel/trace/trace.c                                            |   10 
 kernel/trace/trace_events_synth.c                               |    2 
 mm/damon/lru_sort.c                                             |    3 
 mm/damon/reclaim.c                                              |    3 
 mm/damon/sysfs.c                                                |   14 
 mm/kasan/init.c                                                 |   12 
 mm/kasan/kasan_test.c                                           |    1 
 mm/khugepaged.c                                                 |   22 -
 mm/memory-failure.c                                             |    7 
 mm/percpu.c                                                     |    6 
 mm/sparse-vmemmap.c                                             |    6 
 net/can/j1939/bus.c                                             |    5 
 net/can/j1939/socket.c                                          |    3 
 net/ceph/messenger.c                                            |    7 
 net/core/sock.c                                                 |    5 
 net/hsr/hsr_device.c                                            |  163 +++++++++-
 net/hsr/hsr_main.c                                              |    4 
 net/hsr/hsr_main.h                                              |    4 
 net/hsr/hsr_slave.c                                             |   18 -
 net/ipv4/ip_tunnel_core.c                                       |    6 
 net/ipv4/tcp_bpf.c                                              |    5 
 net/mptcp/sockopt.c                                             |   11 
 net/sunrpc/sched.c                                              |    2 
 samples/ftrace/ftrace-direct-modify.c                           |    2 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                |   28 +
 67 files changed, 667 insertions(+), 282 deletions(-)

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

Arnd Bergmann (1):
      media: mtk-vcodec: venc: avoid -Wenum-compare-conditional warning

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Deal with zero e_shentsize

Boris Ostrovsky (1):
      KVM: SVM: Return TSA_SQ_NO and TSA_L1_NO bits in __do_cpuid_func()

Borislav Petkov (AMD) (1):
      KVM: SVM: Set synthesized TSA CPUID flags

Chen Ridong (1):
      kernfs: Fix UAF in polling when open file is released

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Pro Gen10 AMD to i8042 quirk table

Christophe Kerello (2):
      mtd: rawnand: stm32_fmc2: avoid overlapping mappings on ECC buffer
      mtd: rawnand: stm32_fmc2: fix ECC overwrite

Dan Carpenter (2):
      dmaengine: idxd: Fix double free in idxd_setup_wqs()
      soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()

Fabian Vogt (1):
      tty: hvc_console: Call hvc_kick in hvc_write unconditionally

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A w/audio compositions
      USB: serial: option: add Telit Cinterion LE910C4-WWX new compositions

Greg Kroah-Hartman (1):
      Linux 6.1.153

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

Jiasheng Jiang (1):
      media: mediatek: vcodec: Fix a resource leak related to the scp device in FW initialization

Johan Hovold (2):
      phy: tegra: xusb: fix device and OF node leak at probe
      phy: ti-pipe3: fix device leak at unbind

Jonathan Curley (1):
      NFSv4/flexfiles: Fix layout merge mirror check.

Kim Phillips (1):
      KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX bit propagation code

Kohei Enju (1):
      igb: fix link test skipping when interface is admin down

Krister Johansen (1):
      mptcp: sockopt: make sync_socket_options propagate SOCK_KEEPOPEN

Krzysztof Kozlowski (1):
      dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks

Kuniyuki Iwashima (2):
      net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
      tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict() fails to allocate psock->cork.

Luo Gengkun (1):
      tracing: Fix tracing_marker may trigger page fault during preempt_disable

Mark Tinguely (1):
      ocfs2: fix recursive semaphore deadlock in fiemap call

Miaohe Lin (1):
      mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory

Miaoqian Lin (1):
      dmaengine: dw: dmamux: Fix device reference leak in rzn1_dmamux_route_allocate

Michal Schmidt (1):
      i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Miklos Szeredi (2):
      fuse: check if copy_file_range() returns larger than requested size
      fuse: prevent overflow in copy_file_range return value

Murali Karicheri (2):
      net: hsr: Add support for MC filtering at the slave device
      net: hsr: Add VLAN CTAG filter support

Nathan Chancellor (1):
      compiler-clang.h: define __SANITIZE_*__ macros only when undefined

Oleksij Rempel (1):
      net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups

Paolo Abeni (1):
      Revert "net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups"

Pu Lehui (1):
      tracing: Silence warning when chunk allocation fails in trace_pid_write

Quanmin Yan (2):
      mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()
      mm/damon/lru_sort: avoid divide-by-zero in damon_lru_sort_apply_parameters()

Ravi Gunasekaran (2):
      net: hsr: Disable promiscuous mode in offload mode
      net: hsr: hsr_slave: Fix the promiscuous mode in offload mode

Salah Triki (1):
      EDAC/altera: Delete an inappropriate dma_free_coherent() call

Srinivas Kandagatla (1):
      ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs

Stanislav Fort (1):
      mm/damon/sysfs: fix use-after-free in state_show()

Stefan Wahren (1):
      net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()

Stephan Gerhold (1):
      dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees

Steven Rostedt (1):
      tracing: Do not add length to print format in synthetic events

Tetsuo Handa (2):
      can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed
      can: j1939: j1939_local_ecu_get(): undo increment when j1939_local_ecu_get() fails

Tigran Mkrtchyan (1):
      flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_read

Trond Myklebust (4):
      NFSv4: Don't clear capabilities that won't be reset
      NFSv4: Clear the NFS_CAP_FS_LOCATIONS flag if it is not set
      NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server
      Revert "SUNRPC: Don't allow waiting for exiting tasks"

Vishal Moola (Oracle) (1):
      mm/khugepaged: convert hpage_collapse_scan_pmd() to use folios

Vladimir Riabchun (1):
      ftrace/samples: Fix function size computation

Wei Yang (1):
      mm/khugepaged: fix the address passed to notifier on testing young

Xiongfeng Wang (1):
      hrtimers: Unconditionally update target CPU base after offline timer migration

Yeoreum Yun (1):
      kunit: kasan_test: disable fortify string checker on kasan_strings() test

wangzijie (1):
      proc: fix type confusion in pde_set_flags()


