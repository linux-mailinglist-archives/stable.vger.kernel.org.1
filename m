Return-Path: <stable+bounces-183047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F84BB408C
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8E519E0CC2
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D43126A3;
	Thu,  2 Oct 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CEa5kmdX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1D310652;
	Thu,  2 Oct 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411816; cv=none; b=dtOLkk5wy5t4gnCj+Bow9F9G8P73+VETecNsHm76aqUuR2HI9r0lyGxOrxQAJLymYeGBvoihrifUSgMrYitR2ALZbBp8D6FdeDvgS6dugT+mR3ilcdjRBDJtSvHEw5e6soc1/qNwSCsFPvF4i9nuwby9Se6mSsHxFTsHMcD85a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411816; c=relaxed/simple;
	bh=FptpxFV0hC1fmme4Fv53ogY9FPUulU51aa9+6cFj6J4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kVyVY7fAE1wESIM5KvnIq/52B9E8992A+8Ku/qh31Son/YoKfBVHTH7E7CYc2Ku0lS8zb2u+AEDQEM1J//d+IR5Lk+Dgjo2lR8+Q3Hz0fq54j/tIcKdQtgBGTLjpGtxxAc/6ITp6jqpUhVPksOTbq1lQ4phWAeySPJd5Xlbuc9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CEa5kmdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3141BC4CEF4;
	Thu,  2 Oct 2025 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411815;
	bh=FptpxFV0hC1fmme4Fv53ogY9FPUulU51aa9+6cFj6J4=;
	h=From:To:Cc:Subject:Date:From;
	b=CEa5kmdXcvveV6IPC5zPNcOW9RzQ7XrIEG8DGGMrVhfG4Tomcoi/fbd82PV7DT032
	 Ho5dEoNoh4eooV6oKl0bqMrz2b+c2aUpeZYurQaNVzWyxclNnM8npHaRpWv8tZ95Dp
	 E7K7RW/7ugAqBAbDufyikvVcSUWqTm9dlv2NDDc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.245
Date: Thu,  2 Oct 2025 15:30:10 +0200
Message-ID: <2025100211-unlearned-shuffle-fce1@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.245 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                               |    2 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi              |    4 
 arch/um/drivers/virtio_uml.c                           |    6 
 arch/x86/kvm/svm/svm.c                                 |    3 
 crypto/af_alg.c                                        |    7 
 drivers/cpufreq/cpufreq.c                              |   20 -
 drivers/dma/qcom/bam_dma.c                             |    8 
 drivers/dma/ti/edma.c                                  |    4 
 drivers/edac/altera_edac.c                             |    1 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |    6 
 drivers/gpu/drm/gma500/oaktrail_hdmi.c                 |    2 
 drivers/gpu/drm/i915/display/intel_display_power.c     |    6 
 drivers/infiniband/hw/mlx5/devx.c                      |    1 
 drivers/input/serio/i8042-acpipnpio.h                  |   14 
 drivers/media/i2c/imx214.c                             |   27 +
 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c  |    6 
 drivers/mmc/host/mvsdio.c                              |    2 
 drivers/mtd/mtdpstore.c                                |    3 
 drivers/mtd/nand/raw/atmel/nand-controller.c           |   18 -
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                 |   48 +-
 drivers/net/can/rcar/rcar_can.c                        |    8 
 drivers/net/can/spi/hi311x.c                           |    1 
 drivers/net/can/sun4i_can.c                            |    1 
 drivers/net/can/usb/mcba_usb.c                         |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c           |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c           |    2 
 drivers/net/ethernet/broadcom/cnic.c                   |    3 
 drivers/net/ethernet/cavium/liquidio/request_manager.c |    2 
 drivers/net/ethernet/freescale/fec_main.c              |    3 
 drivers/net/ethernet/intel/i40e/i40e.h                 |    1 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c         |   25 +
 drivers/net/ethernet/intel/i40e/i40e_main.c            |   10 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c            |    3 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c     |   45 ++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h     |    3 
 drivers/net/ethernet/intel/igb/igb_ethtool.c           |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      |    2 
 drivers/net/ethernet/natsemi/ns83820.c                 |   13 
 drivers/net/ethernet/qlogic/qed/qed_debug.c            |    7 
 drivers/pcmcia/omap_cf.c                               |    8 
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c             |    4 
 drivers/phy/broadcom/phy-bcm-kona-usb2.c               |    4 
 drivers/phy/broadcom/phy-bcm-ns-usb2.c                 |    4 
 drivers/phy/broadcom/phy-bcm-ns-usb3.c                 |  168 ----------
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c              |   13 
 drivers/phy/broadcom/phy-bcm-sr-pcie.c                 |    5 
 drivers/phy/broadcom/phy-bcm-sr-usb.c                  |    4 
 drivers/phy/broadcom/phy-brcm-sata.c                   |    8 
 drivers/phy/marvell/phy-berlin-usb.c                   |    7 
 drivers/phy/ralink/phy-ralink-usb.c                    |   10 
 drivers/phy/rockchip/phy-rockchip-pcie.c               |   11 
 drivers/phy/rockchip/phy-rockchip-usb.c                |   10 
 drivers/phy/ti/phy-omap-control.c                      |   26 -
 drivers/phy/ti/phy-omap-usb2.c                         |   28 +
 drivers/phy/ti/phy-ti-pipe3.c                          |   42 +-
 drivers/power/supply/bq27xxx_battery.c                 |    4 
 drivers/soc/qcom/mdt_loader.c                          |   12 
 drivers/tty/hvc/hvc_console.c                          |    6 
 drivers/tty/serial/sc16is7xx.c                         |   14 
 drivers/usb/core/quirks.c                              |    2 
 drivers/usb/gadget/udc/dummy_hcd.c                     |   25 -
 drivers/usb/host/xhci-dbgcap.c                         |   94 +++--
 drivers/usb/serial/option.c                            |   17 +
 drivers/video/fbdev/core/fbcon.c                       |   13 
 fs/btrfs/tree-checker.c                                |    4 
 fs/fuse/file.c                                         |    5 
 fs/hugetlbfs/inode.c                                   |   14 
 fs/nfs/client.c                                        |    2 
 fs/nfs/flexfilelayout/flexfilelayout.c                 |   21 -
 fs/nfs/nfs4proc.c                                      |    1 
 fs/nilfs2/sysfs.c                                      |    4 
 fs/nilfs2/sysfs.h                                      |    8 
 fs/ocfs2/extent_map.c                                  |   10 
 include/crypto/if_alg.h                                |   10 
 include/linux/compiler-clang.h                         |   42 +-
 include/linux/compiler-gcc.h                           |    4 
 include/linux/interrupt.h                              |   72 ++--
 include/linux/overflow.h                               |  208 ++----------
 include/net/nexthop.h                                  |    3 
 include/net/sock.h                                     |   40 ++
 include/uapi/linux/rtnetlink.h                         |    6 
 kernel/cgroup/cgroup.c                                 |   43 ++
 kernel/irq/manage.c                                    |  111 ++++++
 kernel/trace/trace.c                                   |    4 
 kernel/trace/trace_dynevent.c                          |    4 
 mm/khugepaged.c                                        |    2 
 mm/memory-failure.c                                    |    7 
 mm/migrate.c                                           |   12 
 net/can/j1939/bus.c                                    |    5 
 net/can/j1939/socket.c                                 |    3 
 net/core/sock.c                                        |    5 
 net/ipv4/fib_semantics.c                               |    2 
 net/ipv4/ip_tunnel_core.c                              |    6 
 net/ipv4/nexthop.c                                     |   28 +
 net/ipv4/tcp.c                                         |    5 
 net/ipv4/tcp_bpf.c                                     |    5 
 net/mac80211/driver-ops.h                              |    2 
 net/mptcp/pm_netlink.c                                 |    1 
 net/mptcp/protocol.c                                   |   16 
 net/rds/ib_frmr.c                                      |   20 -
 net/rfkill/rfkill-gpio.c                               |   22 +
 sound/firewire/motu/motu-hwdep.c                       |    2 
 sound/soc/codecs/wm8940.c                              |    2 
 sound/soc/codecs/wm8974.c                              |    8 
 sound/soc/sof/intel/hda-stream.c                       |    2 
 sound/usb/mixer_quirks.c                               |  285 ++++++++++++++++-
 tools/include/linux/compiler-gcc.h                     |    4 
 tools/include/linux/overflow.h                         |  140 --------
 tools/testing/selftests/net/fib_nexthops.sh            |   12 
 109 files changed, 1181 insertions(+), 895 deletions(-)

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels

Alexander Dahl (1):
      mtd: nand: raw: atmel: Fix comment in timings preparation

Alexander Sverdlin (1):
      mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing

Alexey Nepomnyashih (1):
      net: liquidio: fix overflow in octeon_init_instr_queue()

Alok Tiwari (1):
      bnxt_en: correct offset handling for IPv6 destination address

Anders Roxell (1):
      dmaengine: ti: edma: Fix memory allocation size for queue_priority_map

André Apitzsch (1):
      media: i2c: imx214: Fix link frequency validation

Antoine Tenart (1):
      tunnels: reset the GSO metadata before reusing the skb

Arnd Bergmann (1):
      media: mtk-vcodec: venc: avoid -Wenum-compare-conditional warning

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Deal with zero e_shentsize

Charles Keepax (2):
      ASoC: wm8940: Correct typo in control name
      ASoC: wm8974: Correct PLL rate rounding

Chen Ni (1):
      ALSA: usb-audio: Convert comma to semicolon

Chen Ridong (1):
      cgroup: split cgroup_destroy_wq into 3 workqueues

Christian Loehle (1):
      cpufreq: Initialize cpufreq-based invariance before subsys

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Pro Gen10 AMD to i8042 quirk table

Christophe Kerello (2):
      mtd: rawnand: stm32_fmc2: fix ECC overwrite
      mtd: rawnand: stm32_fmc2: avoid overlapping mappings on ECC buffer

Chunfeng Yun (2):
      phy: broadcom: convert to devm_platform_ioremap_resource(_byname)
      phy: ti: convert to devm_platform_ioremap_resource(_byname)

Colin Ian King (1):
      ASoC: SOF: Intel: hda-stream: Fix incorrect variable used in error message

Cristian Ciocaltea (6):
      ALSA: usb-audio: Fix block comments in mixer_quirks
      ALSA: usb-audio: Drop unnecessary parentheses in mixer_quirks
      ALSA: usb-audio: Avoid multiple assignments in mixer_quirks
      ALSA: usb-audio: Simplify NULL comparison in mixer_quirks
      ALSA: usb-audio: Remove unneeded wmb() in mixer_quirks
      ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5

David Hildenbrand (1):
      mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()

Duoming Zhou (1):
      cnic: Fix use-after-free bugs in cnic_delete_task

Eric Biggers (1):
      crypto: af_alg - Fix incorrect boolean values in af_alg_ctx

Fabian Vogt (1):
      tty: hvc_console: Call hvc_kick in hvc_write unconditionally

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A w/audio compositions
      USB: serial: option: add Telit Cinterion LE910C4-WWX new compositions

Geert Uytterhoeven (2):
      pcmcia: omap_cf: Mark driver struct with __refdata to prevent section mismatch
      can: rcar_can: rcar_can_resume(): fix s2ram with PSCI

Greg Kroah-Hartman (1):
      Linux 5.10.245

H. Nikolaus Schaller (2):
      power: supply: bq27xxx: fix error return in case of no bq27000 hdq battery
      power: supply: bq27xxx: restrict no-battery detection to bq27000

Hans de Goede (1):
      net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer

Herbert Xu (1):
      crypto: af_alg - Disallow concurrent writes in af_alg_sendmsg

Hugo Villeneuve (1):
      serial: sc16is7xx: fix bug in flow control levels init

Håkon Bugge (1):
      rds: ib: Increment i_fastreg_wrs before bailing out

Ido Schimmel (6):
      nexthop: Pass extack to nexthop notifier
      rtnetlink: Add RTNH_F_TRAP flag
      nexthop: Emit a notification when a nexthop is added
      nexthop: Emit a notification when a single nexthop is replaced
      nexthop: Forbid FDB status change while nexthop is in a group
      selftests: fib_nexthops: Fix creation of non-FDB nexthops

Jack Wang (1):
      mtd: rawnand: stm32_fmc2: Fix dma_map_sg error check

Jakob Koschel (1):
      usb: gadget: dummy_hcd: remove usage of list iterator past the loop body

Jamie Bainbridge (1):
      qed: Don't collect too many protection override GRC elements

Jani Nikula (1):
      drm/i915/power: fix size for for_each_set_bit() in abox iteration

Jiasheng Jiang (1):
      mtd: Add check for devm_kcalloc()

Jiayi Li (1):
      usb: core: Add 0x prefix to quirks debug output

Jinjiang Tu (1):
      mm/hugetlb: fix folio is still mapped when deleted

Johan Hovold (2):
      phy: ti-pipe3: fix device leak at unbind
      phy: ti: omap-usb2: fix device leak at unbind

John Garry (1):
      genirq/affinity: Add irq_update_affinity_desc()

Jonathan Curley (1):
      NFSv4/flexfiles: Fix layout merge mirror check.

Justin Bronder (1):
      i40e: increase max descriptors for XL710

Kees Cook (1):
      overflow: Allow mixed type arguments

Keith Busch (1):
      overflow: Correct check_shl_overflow() comment

Kohei Enju (1):
      igb: fix link test skipping when interface is admin down

Krzysztof Kozlowski (1):
      phy: broadcom: ns-usb3: fix Wvoid-pointer-to-enum-cast warning

Kuniyuki Iwashima (3):
      net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
      tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict() fails to allocate psock->cork.
      tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().

Liao Yuanhong (1):
      wifi: mac80211: fix incorrect type for ret

Lukasz Czapnik (7):
      i40e: fix idx validation in i40e_validate_queue_map
      i40e: fix input validation logic for action_meta
      i40e: add max boundary check for VF filters
      i40e: add mask to apply valid bits for itr_idx
      i40e: add validation for ring_len param
      i40e: fix idx validation in config queues msg
      i40e: fix validation of VF state in get resources

Luo Gengkun (1):
      tracing: Fix tracing_marker may trigger page fault during preempt_disable

Maciej Fijalkowski (1):
      i40e: remove redundant memory barrier when cleaning Tx descs

Maciej S. Szmigiero (1):
      KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active

Mark Tinguely (1):
      ocfs2: fix recursive semaphore deadlock in fiemap call

Masami Hiramatsu (Google) (1):
      tracing: dynevent: Add a missing lockdown check on dynevent

Mathias Nyman (2):
      xhci: dbc: decouple endpoint allocation from initialization
      xhci: dbc: Fix full DbC transfer ring after several reconnects

Matthieu Baerts (NGI0) (2):
      mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
      mptcp: propagate shutdown to subflows when possible

Miaohe Lin (1):
      mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory

Miaoqian Lin (1):
      um: virtio_uml: Fix use-after-free after put_device in probe

Michal Schmidt (1):
      i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Miklos Szeredi (2):
      fuse: check if copy_file_range() returns larger than requested size
      fuse: prevent overflow in copy_file_range return value

Nathan Chancellor (2):
      compiler-clang.h: define __SANITIZE_*__ macros only when undefined
      nilfs2: fix CFI failure when accessing /sys/fs/nilfs2/features/*

Nick Desaulniers (1):
      compiler.h: drop fallback overflow checkers

Nitesh Narayan Lal (1):
      i40e: Use irq_update_affinity_hint()

Or Har-Toov (1):
      IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions

Peng Fan (1):
      arm64: dts: imx8mp: Correct thermal sensor index

Philipp Zabel (1):
      net: rfkill: gpio: add DT support

Qi Xi (1):
      drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on error path

Qu Wenruo (1):
      btrfs: tree-checker: fix the incorrect inode ref size check

Rafał Miłecki (1):
      phy: phy-bcm-ns-usb3: drop support for deprecated DT binding

Rob Herring (1):
      phy: Use device_get_match_data()

Salah Triki (1):
      EDAC/altera: Delete an inappropriate dma_free_coherent() call

Samasth Norway Ananda (1):
      fbcon: fix integer overflow in fbcon_do_set_font

Stefan Wahren (1):
      net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()

Stephan Gerhold (1):
      dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees

Stéphane Grosjean (1):
      can: peak_usb: fix shift-out-of-bounds issue

Takashi Iwai (1):
      ALSA: usb-audio: Fix build with CONFIG_INPUT=n

Takashi Sakamoto (1):
      ALSA: firewire-motu: drop EPOLLOUT from poll return values as write is not supported

Tariq Toukan (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon port speed set"

Tetsuo Handa (2):
      can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed
      can: j1939: j1939_local_ecu_get(): undo increment when j1939_local_ecu_get() fails

Thomas Fourier (1):
      mmc: mvsdio: Fix dma_unmap_sg() nents value

Thomas Gleixner (2):
      genirq: Export affinity setter for modules
      genirq: Provide new interfaces for affinity hints

Thomas Zimmermann (1):
      fbcon: Fix OOB access in font allocation

Tigran Mkrtchyan (1):
      flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_read

Trond Myklebust (2):
      NFSv4: Don't clear capabilities that won't be reset
      NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server

Vincent Mailhol (3):
      can: hi311x: populate ndo_change_mtu() to prevent buffer overflow
      can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow

Wei Yang (1):
      mm/khugepaged: fix the address passed to notifier on testing young

Yeounsu Moon (1):
      net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` failure

Zabelin Nikita (1):
      drm/gma500: Fix null dereference in hdmi teardown


