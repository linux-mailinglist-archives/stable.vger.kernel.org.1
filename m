Return-Path: <stable+bounces-132098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB966A843CC
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C271B83C1C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777772853F8;
	Thu, 10 Apr 2025 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fL7yGGcE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F46283CB2;
	Thu, 10 Apr 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289847; cv=none; b=OuCysCGP9W5YgTobl/aJ7s167BGWmGoiuZHHD5Kuv8OaNkiRBKUq3Ymr7AeGS6MW+jaeNsvZ2QJLs6VrorFgOxcLVBiFtVUE9VDxU0gPzUgkVuUppvftqPZ+TxBR9+1T+HR+lpYX/Y7GwNZpALdY/rCLIv9lpftMLNb0mepfaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289847; c=relaxed/simple;
	bh=388x3Kxg8dVophX7Mz6HcvO2Np2sLqPboUxYV6I2m4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oiRE1RRxAegfn39pK1ApwHSA5ZrObxu5Q7O31t6IOWnDcG17RiCUZUW7CnK2Esa9J9cODOCrfXdpQxAPUVYLZokIrJQxd3lilw20VMVwiL5rg+ChG83nun2Nj5YP5aXTbzpqSPLfNLPl1QAkKq9KX1GlJYCaLLzctiUQ27BUPfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fL7yGGcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598E6C4CEDD;
	Thu, 10 Apr 2025 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744289845;
	bh=388x3Kxg8dVophX7Mz6HcvO2Np2sLqPboUxYV6I2m4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=fL7yGGcEv+XoGHczPkEeKVoPbbatNtJBfl2gWxyPBG1FMcNTBuqVqmCNAMJx8jwLq
	 UEz1cQy/nuGRWY31SsWcj5Aogn/HGi83cLN/NpkNX8frp8ka/r53RGCsgxstQ4vqPq
	 DoeaB6+pr8qdxNuj6yc55nAJ58kZney6BLWZFp8Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.292
Date: Thu, 10 Apr 2025 14:55:48 +0200
Message-ID: <2025041049-denote-unhinge-7564@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.292 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/timers/no_hz.rst                           |    7 
 Makefile                                                 |    2 
 arch/arm/mach-shmobile/headsmp.S                         |    1 
 arch/arm/mm/fault.c                                      |    8 
 arch/powerpc/platforms/cell/spufs/inode.c                |    9 
 arch/x86/Kconfig                                         |    2 
 arch/x86/entry/calling.h                                 |    2 
 arch/x86/include/asm/tlbflush.h                          |    2 
 arch/x86/kernel/cpu/microcode/amd.c                      |    2 
 arch/x86/kernel/cpu/mshyperv.c                           |   11 -
 arch/x86/kernel/dumpstack.c                              |    5 
 arch/x86/kernel/irq.c                                    |    2 
 arch/x86/kernel/process.c                                |    7 
 arch/x86/kernel/tsc.c                                    |    4 
 arch/x86/mm/pageattr-test.c                              |    2 
 block/bio.c                                              |    2 
 drivers/acpi/resource.c                                  |   13 +
 drivers/base/power/main.c                                |    8 
 drivers/clk/meson/g12a.c                                 |   38 ++-
 drivers/clk/meson/gxbb.c                                 |   14 -
 drivers/clk/rockchip/clk-rk3328.c                        |    2 
 drivers/clocksource/i8253.c                              |   36 ++-
 drivers/counter/stm32-lptimer-cnt.c                      |   24 +-
 drivers/cpufreq/cpufreq_governor.c                       |   45 ++--
 drivers/edac/ie31200_edac.c                              |   19 +
 drivers/firmware/imx/imx-scu.c                           |    1 
 drivers/firmware/iscsi_ibft.c                            |    5 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c        |    7 
 drivers/gpu/drm/drm_atomic_uapi.c                        |    4 
 drivers/gpu/drm/drm_connector.c                          |    4 
 drivers/gpu/drm/gma500/mid_bios.c                        |    5 
 drivers/gpu/drm/mediatek/mtk_hdmi.c                      |    8 
 drivers/gpu/drm/nouveau/nouveau_connector.c              |    1 
 drivers/gpu/drm/radeon/radeon_vce.c                      |    2 
 drivers/gpu/drm/v3d/v3d_sched.c                          |    9 
 drivers/hid/hid-ids.h                                    |    1 
 drivers/hid/hid-plantronics.c                            |  144 ++++++---------
 drivers/hid/hid-quirks.c                                 |    1 
 drivers/hid/intel-ish-hid/ipc/ipc.c                      |    6 
 drivers/hv/vmbus_drv.c                                   |   23 +-
 drivers/hwmon/nct6775.c                                  |    4 
 drivers/hwtracing/coresight/coresight-catu.c             |    2 
 drivers/i2c/busses/i2c-ali1535.c                         |   12 +
 drivers/i2c/busses/i2c-ali15x3.c                         |   12 +
 drivers/i2c/busses/i2c-omap.c                            |   26 --
 drivers/i2c/busses/i2c-sis630.c                          |   12 +
 drivers/iio/accel/mma8452.c                              |   10 -
 drivers/infiniband/core/mad.c                            |   38 ++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                 |    2 
 drivers/infiniband/hw/hns/hns_roce_main.c                |    2 
 drivers/infiniband/hw/mlx5/cq.c                          |    2 
 drivers/media/dvb-frontends/dib8000.c                    |    5 
 drivers/memstick/host/rtsx_usb_ms.c                      |    1 
 drivers/mfd/sm501.c                                      |    6 
 drivers/mmc/host/atmel-mci.c                             |    4 
 drivers/mmc/host/sdhci-pxav3.c                           |    1 
 drivers/net/arcnet/com20020-pci.c                        |   17 +
 drivers/net/can/flexcan.c                                |    6 
 drivers/net/dsa/mv88e6xxx/chip.c                         |   11 -
 drivers/net/dsa/mv88e6xxx/phy.c                          |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |    6 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c |    8 
 drivers/net/usb/qmi_wwan.c                               |    2 
 drivers/net/usb/usbnet.c                                 |   21 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              |   86 ++++++--
 drivers/ntb/hw/intel/ntb_hw_gen3.c                       |    3 
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c                   |    2 
 drivers/ntb/test/ntb_perf.c                              |    4 
 drivers/nvme/host/core.c                                 |    2 
 drivers/nvme/host/fc.c                                   |    3 
 drivers/nvme/target/rdma.c                               |   33 ++-
 drivers/pci/hotplug/pciehp_hpc.c                         |    4 
 drivers/pci/pcie/aspm.c                                  |   17 -
 drivers/pci/pcie/portdrv_core.c                          |    8 
 drivers/pci/probe.c                                      |    5 
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c                   |    2 
 drivers/pinctrl/pinctrl-rza2.c                           |    2 
 drivers/power/supply/max77693_charger.c                  |    2 
 drivers/powercap/powercap_sys.c                          |    3 
 drivers/s390/cio/chp.c                                   |    3 
 drivers/scsi/qla1280.c                                   |    2 
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c  |    3 
 drivers/tty/serial/8250/8250_dma.c                       |    2 
 drivers/tty/serial/8250/8250_pci.c                       |   16 +
 drivers/usb/serial/ftdi_sio.c                            |   14 +
 drivers/usb/serial/ftdi_sio_ids.h                        |   13 +
 drivers/usb/serial/option.c                              |   48 +++--
 drivers/video/console/Kconfig                            |    2 
 drivers/video/fbdev/au1100fb.c                           |    4 
 drivers/video/fbdev/sm501fb.c                            |    7 
 fs/affs/file.c                                           |    9 
 fs/fuse/dir.c                                            |    2 
 fs/isofs/dir.c                                           |    3 
 fs/jfs/jfs_dtree.c                                       |    3 
 fs/jfs/xattr.c                                           |   15 +
 fs/namei.c                                               |   24 +-
 fs/ocfs2/alloc.c                                         |    8 
 fs/proc/base.c                                           |    2 
 include/linux/fs.h                                       |    2 
 include/linux/i8253.h                                    |    1 
 include/linux/interrupt.h                                |    8 
 include/linux/netpoll.h                                  |   10 -
 include/linux/sched/smt.h                                |    2 
 kernel/events/ring_buffer.c                              |    2 
 kernel/kexec_elf.c                                       |    2 
 kernel/locking/semaphore.c                               |   13 -
 kernel/sched/deadline.c                                  |    2 
 kernel/time/hrtimer.c                                    |   22 +-
 kernel/trace/bpf_trace.c                                 |    2 
 kernel/trace/ring_buffer.c                               |    4 
 kernel/trace/trace_functions_graph.c                     |    1 
 kernel/trace/trace_irqsoff.c                             |    2 
 kernel/trace/trace_sched_wakeup.c                        |    2 
 lib/842/842_compress.c                                   |    2 
 net/8021q/vlan_netlink.c                                 |   10 -
 net/atm/lec.c                                            |    3 
 net/atm/mpc.c                                            |    2 
 net/batman-adv/bat_iv_ogm.c                              |    3 
 net/batman-adv/bat_v_ogm.c                               |    3 
 net/bluetooth/6lowpan.c                                  |    7 
 net/can/af_can.c                                         |   12 -
 net/can/af_can.h                                         |   12 -
 net/can/proc.c                                           |   46 ++--
 net/core/neighbour.c                                     |    1 
 net/core/netpoll.c                                       |   38 +++
 net/ipv6/addrconf.c                                      |   37 ++-
 net/ipv6/calipso.c                                       |   21 +-
 net/ipv6/netfilter/nf_socket_ipv6.c                      |   23 ++
 net/ipv6/route.c                                         |    5 
 net/netfilter/ipvs/ip_vs_ctl.c                           |    8 
 net/netfilter/nf_conncount.c                             |    2 
 net/netfilter/nft_exthdr.c                               |   10 -
 net/sched/sch_api.c                                      |    6 
 net/sched/sch_skbprio.c                                  |    3 
 net/sctp/stream.c                                        |    2 
 net/sctp/sysctl.c                                        |    6 
 net/vmw_vsock/af_vsock.c                                 |    6 
 net/xfrm/xfrm_output.c                                   |    2 
 scripts/selinux/install_policy.sh                        |   15 -
 sound/pci/hda/patch_realtek.c                            |    6 
 sound/soc/codecs/wm0010.c                                |   13 +
 sound/soc/sh/rcar/core.c                                 |   14 -
 sound/soc/sh/rcar/rsnd.h                                 |    1 
 sound/soc/sh/rcar/src.c                                  |   18 +
 sound/usb/mixer_quirks.c                                 |   51 +++++
 tools/perf/util/python.c                                 |   13 +
 tools/perf/util/units.c                                  |    2 
 148 files changed, 1002 insertions(+), 535 deletions(-)

Al Viro (2):
      spufs: fix a leak on spufs_new_file() failure
      spufs: fix a leak in spufs_create_context()

Alex Hung (1):
      drm/amd/display: Assign normalized_pix_clk when color depth = 14

Alexey Kashavkin (1):
      netfilter: nft_exthdr: fix offset with ipv4_find_option()

Andreas Kemnade (1):
      i2c: omap: fix IRQ storms

Andy Shevchenko (1):
      hrtimers: Mark is_migration_base() with __always_inline

AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_hdmi: Fix typo for aud_sampe_size member

Arnaldo Carvalho de Melo (4):
      perf units: Fix insufficient array space
      perf python: Fixup description of sample.id event member
      perf python: Decrement the refcount of just created event on failure
      perf python: Check if there is space to copy all the event

Arnd Bergmann (3):
      x86/irq: Define trace events conditionally
      x86/platform: Only allow CONFIG_EISA for 32-bit
      mdacon: rework dependency list

Artur Weber (2):
      pinctrl: bcm281xx: Fix incorrect regmap max_registers value
      power: supply: max77693: Fix wrong conversion of charge input threshold value

Bart Van Assche (1):
      fs/procfs: fix the comment above proc_pid_wchan()

Benjamin Berg (1):
      x86/fpu: Avoid copying dynamic FP state from init_task in arch_dup_task_struct()

Boon Khai Ng (1):
      USB: serial: ftdi_sio: add support for Altera USB Blaster 3

Breno Leitao (1):
      netpoll: hold rcu read lock in __netpoll_send_skb()

Cameron Williams (1):
      tty: serial: 8250: Add some more device IDs

Carolina Jubran (1):
      net/mlx5e: Prevent bridge link show failure for non-eswitch-allowed devices

Chengen Du (1):
      iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()

Chenyuan Yang (1):
      thermal: int340x: Add NULL check for adev

Chia-Lin Kao (AceLan) (1):
      HID: ignore non-functional sensor in HP 5MP Camera

Christophe JAILLET (4):
      ASoC: codecs: wm0010: Fix error handling path in wm0010_spi_probe()
      i2c: ali1535: Fix an error handling path in ali1535_probe()
      i2c: ali15x3: Fix an error handling path in ali15x3_probe()
      i2c: sis630: Fix an error handling path in sis630_probe()

Cong Wang (2):
      net_sched: Prevent creation of classes with TC_H_ROOT
      net_sched: skbprio: Remove overly strict queue assertions

Cosmin Ratiu (1):
      xfrm_output: Force software GSO only in tunnel mode

Dan Carpenter (4):
      ipvs: prevent integer overflow in do_ip_vs_get_ctl()
      Bluetooth: Fix error code in chan_alloc_skb_cb()
      net: atm: fix use after free in lec_send()
      PCI: Remove stray put_device() in pci_register_host_bridge()

Daniel Stodden (1):
      PCI/ASPM: Fix link state exit during switch upstream function removal

Daniel Wagner (2):
      nvme-fc: go straight to connecting state when initializing
      nvme: only allow entering LIVE from CONNECTING state

Danila Chernetsov (1):
      fbdev: sm501fb: Add some geometry checks.

David Oberhollenzer (1):
      net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy

David Woodhouse (1):
      clockevents/drivers/i8253: Fix stop sequence for timer 0

Davidlohr Bueso (1):
      drivers/hv: Replace binary semaphore with mutex

Debin Zhu (1):
      netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets

Dominique Martinet (1):
      net: usb: usbnet: restore usb%d name exception for local mac addresses

Eric Dumazet (4):
      vlan: fix memory leak in vlan_newlink()
      netpoll: remove dev argument from netpoll_send_skb_on_dev()
      netpoll: move netpoll_send_skb() out of line
      netpoll: netpoll_send_skb() returns transmit status

Fabio Porcedda (4):
      USB: serial: option: add Telit Cinterion FE990B compositions
      USB: serial: option: fix Telit Cinterion FE990A name
      net: usb: qmi_wwan: add Telit Cinterion FN990B composition
      net: usb: qmi_wwan: add Telit Cinterion FE990B composition

Fabrice Gasnier (1):
      counter: stm32-lptimer-cnt: fix error handling when enabling

Fabrizio Castro (1):
      pinctrl: renesas: rza2: Fix missing of_node_put() call

Feng Tang (1):
      PCI/portdrv: Only disable pciehp interrupts early when needed

Feng Yang (1):
      ring-buffer: Fix bytes_dropped calculation issue

Fernando Fernandez Mancera (1):
      ipv6: fix omitted netlink attributes when using RTEXT_FILTER_SKIP_STATS

Florent Revest (1):
      x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes

Gannon Kolding (1):
      ACPI: resource: IRQ override for Eluktronics MECH-17

Geert Uytterhoeven (1):
      ARM: shmobile: smp: Enforce shmobile_smp_* alignment

Geetha sowjanya (1):
      octeontx2-af: Fix mbox INTR handler when num VFs > 64

Greg Kroah-Hartman (1):
      Linux 5.4.292

Gu Bowen (1):
      mmc: atmel-mci: Add missing clk_disable_unprepare()

Guilherme G. Piccoli (1):
      x86/tsc: Always save/restore TSC sched_clock() on suspend/resume

Haibo Chen (1):
      can: flexcan: only change CAN state when link up in system PM

Haoxiang Li (1):
      qlcnic: fix memory leak issues in qlcnic_sriov_common.c

Henry Martin (1):
      arcnet: Add NULL check in com20020pci_probe()

Hou Tao (1):
      bpf: Use preempt_count() directly in bpf_send_signal_common()

Ilkka Koskinen (1):
      coresight: catu: Fix number of pages while using 64k pages

Ilpo Järvinen (1):
      PCI: pciehp: Don't enable HPIE when resuming in poll mode

Ivan Abramov (1):
      drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()

Jann Horn (3):
      x86/entry: Fix ORC unwinder for PUSH_REGS with save_ret=1
      x86/dumpstack: Fix inaccurate unwinding from exception stacks due to misplaced assignment
      x86/mm: Fix flush_tlb_range() when used for zapping normal PMDs

Jerome Brunet (4):
      clk: amlogic: gxbb: drop incorrect flag on 32k clock
      clk: amlogic: g12b: fix cluster A parent data
      clk: amlogic: gxbb: drop non existing 32k clock parent
      clk: amlogic: g12a: fix mmc A peripheral clock

Jie Zhan (1):
      cpufreq: governor: Fix negative 'idle_time' handling in dbs_update()

Joe Hattori (2):
      powercap: call put_device() on an error path in powercap_register_control_type()
      firmware: imx-scu: fix OF node leak in .probe()

Johan Hovold (1):
      USB: serial: option: match on interface class for Telit FN990B

Johannes Berg (1):
      wifi: iwlwifi: fw: allocate chained SG tables for dump

John Keeping (1):
      serial: 8250_dma: terminate correct DMA in tx_dma_flush()

Jonathan Cameron (1):
      iio: accel: mma8452: Ensure error return on failure to matching oversampling ratio

Josh Poimboeuf (2):
      objtool, media: dib8000: Prevent divide-by-zero in dib8000_set_dds()
      sched/smt: Always inline sched_smt_active()

Junxian Huang (1):
      RDMA/hns: Fix wrong value of max_sge_rd

Karel Balej (1):
      mmc: sdhci-pxav3: set NEED_RSP_BUSY capability

Kees Cook (2):
      ARM: 9350/1: fault: Implement copy_from_kernel_nofault_allowed()
      ARM: 9351/1: fault: Add "cut here" line for prefetch aborts

Kohei Enju (1):
      netfilter: nf_conncount: Fully initialize struct nf_conncount_tuple in insert_tree()

Kuninori Morimoto (1):
      ASoC: rsnd: don't indicate warning on rsnd_kctrl_accept_runtime()

Kuniyuki Iwashima (2):
      ipv6: Fix memleak of nhc_pcpu_rth_output in fib_check_nh_v6_gw().
      ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().

Lin Ma (1):
      net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES

Luo Qiu (1):
      memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove

Magali Lemes (2):
      Revert "sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy"
      Revert "sctp: sysctl: auth_enable: avoid using current->nsproxy"

Magnus Lindholm (1):
      scsi: qla1280: Fix kernel oops when debug level > 2

Maher Sanalla (1):
      IB/mad: Check available slots before posting receive WRs

Markus Elfring (2):
      fbdev: au1100fb: Move a variable assignment behind a null pointer check
      ntb_perf: Delete duplicate dmaengine_unmap_put() call in perf_copy_chunk()

Matthieu Baerts (NGI0) (2):
      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      sctp: sysctl: auth_enable: avoid using current->nsproxy

Maxim Mikityanskiy (1):
      netfilter: socket: Lookup orig tuple for IPv6 SNAT

Maíra Canal (1):
      drm/v3d: Don't run jobs that have errors flagged in its fence

Michael Kelley (1):
      Drivers: hv: vmbus: Don't release fb_mmio resource in vmbus_free_mmio()

Mike Rapoport (Microsoft) (1):
      x86/mm/pat: cpa-test: fix length for CPA_ARRAY test

Miklos Szeredi (1):
      fuse: don't truncate cached, mutated symlink

Ming Lei (1):
      block: fix 'kmem_cache of name 'bio-108' already exists'

Minjoong Kim (1):
      atm: Fix NULL pointer dereference

Nikita Shubin (1):
      ntb: intel: Fix using link status DB's

Nikita Zhandarovich (2):
      drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()
      mfd: sm501: Switch to BIT() to mitigate integer overflows

Oleg Nesterov (1):
      sched/isolation: Prevent boot crash when the boot CPU is nohz_full

Oliver Hartkopp (1):
      can: statistics: use atomic access in hot path

Patrisious Haddad (1):
      RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow

Paul Menzel (1):
      ACPI: resource: Skip IRQ override on ASUS Vivobook 14 X1404VAP

Peter Geis (1):
      clk: rockchip: rk3328: fix wrong clk_ref_usb3otg parent

Peter Oberparleiter (1):
      s390/cio: Fix CHPID "configure" attribute caching

Qasim Ijaz (2):
      isofs: fix KMSAN uninit-value bug in do_isofs_readdir()
      jfs: fix slab-out-of-bounds read in ea_get()

Qiuxu Zhuo (3):
      EDAC/ie31200: Fix the size of EDAC_MC_LAYER_CHIP_SELECT layer
      EDAC/ie31200: Fix the DIMM size mask for several SoCs
      EDAC/ie31200: Fix the error path order of ie31200_init()

Rafael J. Wysocki (1):
      PM: sleep: Fix handling devices with direct_complete set on errors

Roman Smirnov (1):
      jfs: add index corruption check to DT_GETPAGE()

Ruozhu Li (1):
      nvmet-rdma: recheck queue state is LIVE in state lock in recv done

Saravanan Vajravel (1):
      RDMA/bnxt_re: Avoid clearing VLAN_ID mask in modify qp path

Sebastian Andrzej Siewior (1):
      lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()

Shrikanth Hegde (1):
      sched/deadline: Use online cpus for validating runtime

Simon Tatham (2):
      affs: generate OFS sequence numbers starting at 1
      affs: don't write overlarge OFS data block size fields

Sourabh Jain (1):
      kexec: initialize ELF lowest address to ULONG_MAX

Stefano Garzarella (1):
      vsock: avoid timeout during connect() if the socket is closing

Sven Eckelmann (1):
      batman-adv: Ignore own maximum aggregation size during RX

Takashi Iwai (1):
      ALSA: hda/realtek: Always honor no_shutup_pins

Tanya Agarwal (1):
      lib: 842: Improve error handling in sw842_compress()

Tao Chen (1):
      perf/ring_buffer: Allow the EPOLLRDNORM flag for poll

Tasos Sahanidis (1):
      hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}

Tengda Wu (1):
      tracing: Fix use-after-free in print_graph_function_flags during tracer switching

Terry Junge (2):
      ALSA: usb-audio: Add quirk for Plantronics headsets to fix control names
      HID: hid-plantronics: Add mic mute mapping and generalize quirks

Thomas Zimmermann (1):
      drm/nouveau: Do not override forced connector status

Tim Schumacher (1):
      selinux: Chain up tool resolving errors in install_policy.sh

Vasiliy Kovalev (1):
      ocfs2: validate l_tree_depth to avoid out-of-bounds access

Ville Syrjälä (1):
      drm/atomic: Filter out redundant DPMS calls

Waiman Long (1):
      locking/semaphore: Use wake_q to wake up processes outside lock critical section

Yajun Deng (1):
      ntb_hw_switchtec: Fix shift-out-of-bounds in switchtec_ntb_mw_set_trans

Yanjun Yang (1):
      ARM: Remove address checking for MMUless devices

Yu-Chun Lin (1):
      sctp: Fix undefined behavior in left shift operation

Yunjian Wang (1):
      netpoll: Fix use correct return type for ndo_start_xmit()

Zhang Lixu (1):
      HID: intel-ish-hid: fix the length of MNG_SYNC_FW_CLOCK in doorbell


