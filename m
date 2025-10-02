Return-Path: <stable+bounces-183045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C1BB4083
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42522A22F4
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322693126AB;
	Thu,  2 Oct 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="blUHXhNJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CB31196B;
	Thu,  2 Oct 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411806; cv=none; b=f3E9G2yqxDGgCbGCYx2NN4KEOgYmUGm4y1CWEWu0kFY7jRvNREcQkSvIJAEjaNKYQsLeDVS29295yZEp/meliVygcZp540cO7hb6fRT8/+FVjxh5N4OZvd7iYEXhox9QMyo8r3j4wt3hgUIOs4QLB6rJR+na0u382GRkAfDaBK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411806; c=relaxed/simple;
	bh=u0VxSUVq+CMPUr8mJVPNuYFKVfArmA87UM1+r4+/vqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FGIaHXnhn+4EySX8kcRKXGjv3SiCttKpNyolNjO+7SqjLdtsMLVqaZxpFjYW6/5TIXSdBOrGHgEuJn0g4EId4d5P9aeRugOc9Fyye755Fxu0wzIl3SO0CB/IKeXlP2x+V15yG1Z37raXzswuaKGamS8DWXrQH6ZKoAhhiIYIQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=blUHXhNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43E6C4CEF4;
	Thu,  2 Oct 2025 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411803;
	bh=u0VxSUVq+CMPUr8mJVPNuYFKVfArmA87UM1+r4+/vqc=;
	h=From:To:Cc:Subject:Date:From;
	b=blUHXhNJ9uHK8fVJAjSfqBTjVb31H7g7nByDKG9kwgZhJqzTn1XiWxrjDx65UAgiF
	 +9p39s/lSw87Cyx0lIzZDqN7D1gBbhNoLE4f+1SVYgO9Kd1+H67EdhgcvNFG3/PVNq
	 xYmKJO6xcJvrq/UM8PbfwVziVaVuQfrza2eTkEPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.300
Date: Thu,  2 Oct 2025 15:29:57 +0200
Message-ID: <2025100258-chaste-acre-069a@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.300 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                               |    2 
 arch/x86/kvm/svm.c                                     |    3 
 drivers/dma/qcom/bam_dma.c                             |    8 
 drivers/dma/ti/edma.c                                  |    4 
 drivers/edac/altera_edac.c                             |    1 
 drivers/gpu/drm/gma500/oaktrail_hdmi.c                 |    2 
 drivers/infiniband/hw/mlx5/devx.c                      |    1 
 drivers/mmc/host/mvsdio.c                              |    2 
 drivers/mtd/nand/raw/atmel/nand-controller.c           |   18 -
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                 |   45 +-
 drivers/net/can/rcar/rcar_can.c                        |    8 
 drivers/net/can/spi/hi311x.c                           |    1 
 drivers/net/can/sun4i_can.c                            |    1 
 drivers/net/can/usb/mcba_usb.c                         |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c           |    2 
 drivers/net/ethernet/broadcom/cnic.c                   |    3 
 drivers/net/ethernet/cavium/liquidio/request_manager.c |    2 
 drivers/net/ethernet/freescale/fec_main.c              |    3 
 drivers/net/ethernet/intel/i40e/i40e.h                 |    1 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c         |   25 +
 drivers/net/ethernet/intel/i40e/i40e_main.c            |   10 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c            |    3 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c     |   46 ++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h     |    3 
 drivers/net/ethernet/intel/igb/igb_ethtool.c           |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      |    2 
 drivers/net/ethernet/natsemi/ns83820.c                 |   13 
 drivers/pcmcia/omap_cf.c                               |    8 
 drivers/phy/ti/phy-ti-pipe3.c                          |   13 
 drivers/power/supply/bq27xxx_battery.c                 |    4 
 drivers/soc/qcom/mdt_loader.c                          |   12 
 drivers/tty/hvc/hvc_console.c                          |    6 
 drivers/tty/serial/sc16is7xx.c                         |   13 
 drivers/usb/core/hub.c                                 |   21 -
 drivers/usb/core/hub.h                                 |    1 
 drivers/usb/core/quirks.c                              |    2 
 drivers/usb/gadget/udc/dummy_hcd.c                     |   25 -
 drivers/usb/serial/option.c                            |   17 +
 drivers/video/fbdev/core/fbcon.c                       |   13 
 fs/fuse/file.c                                         |    5 
 fs/hugetlbfs/inode.c                                   |   14 
 fs/nfs/nfs4proc.c                                      |    1 
 fs/nilfs2/sysfs.c                                      |    4 
 fs/nilfs2/sysfs.h                                      |    8 
 fs/ocfs2/extent_map.c                                  |   10 
 include/linux/interrupt.h                              |   72 +++-
 include/net/sock.h                                     |   40 ++
 kernel/cgroup/cgroup.c                                 |   43 ++
 kernel/irq/manage.c                                    |  111 ++++++
 mm/khugepaged.c                                        |    2 
 mm/memory-failure.c                                    |    7 
 mm/migrate.c                                           |   12 
 net/can/j1939/bus.c                                    |    5 
 net/can/j1939/socket.c                                 |    3 
 net/core/sock.c                                        |    5 
 net/ipv4/tcp.c                                         |    5 
 net/ipv4/tcp_bpf.c                                     |    5 
 net/mac80211/driver-ops.h                              |    2 
 net/rds/ib_frmr.c                                      |   20 -
 net/rfkill/rfkill-gpio.c                               |   22 +
 sound/firewire/motu/motu-hwdep.c                       |    2 
 sound/soc/codecs/wm8940.c                              |    2 
 sound/soc/codecs/wm8974.c                              |    8 
 sound/soc/sof/intel/hda-stream.c                       |    2 
 sound/usb/mixer_quirks.c                               |  279 ++++++++++++++++-
 65 files changed, 816 insertions(+), 223 deletions(-)

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels

Alexander Dahl (1):
      mtd: nand: raw: atmel: Fix comment in timings preparation

Alexander Sverdlin (1):
      mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing

Alexey Nepomnyashih (1):
      net: liquidio: fix overflow in octeon_init_instr_queue()

Anders Roxell (1):
      dmaengine: ti: edma: Fix memory allocation size for queue_priority_map

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Deal with zero e_shentsize

Charles Keepax (2):
      ASoC: wm8940: Correct typo in control name
      ASoC: wm8974: Correct PLL rate rounding

Chen Ni (1):
      ALSA: usb-audio: Convert comma to semicolon

Chen Ridong (1):
      cgroup: split cgroup_destroy_wq into 3 workqueues

Christophe Kerello (2):
      mtd: rawnand: stm32_fmc2: fix ECC overwrite
      mtd: rawnand: stm32_fmc2: avoid overlapping mappings on ECC buffer

Colin Ian King (1):
      ASoC: SOF: Intel: hda-stream: Fix incorrect variable used in error message

Cristian Ciocaltea (5):
      ALSA: usb-audio: Fix block comments in mixer_quirks
      ALSA: usb-audio: Avoid multiple assignments in mixer_quirks
      ALSA: usb-audio: Simplify NULL comparison in mixer_quirks
      ALSA: usb-audio: Remove unneeded wmb() in mixer_quirks
      ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5

David Hildenbrand (1):
      mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()

Duoming Zhou (1):
      cnic: Fix use-after-free bugs in cnic_delete_task

Fabian Vogt (1):
      tty: hvc_console: Call hvc_kick in hvc_write unconditionally

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A w/audio compositions
      USB: serial: option: add Telit Cinterion LE910C4-WWX new compositions

Geert Uytterhoeven (2):
      pcmcia: omap_cf: Mark driver struct with __refdata to prevent section mismatch
      can: rcar_can: rcar_can_resume(): fix s2ram with PSCI

Greg Kroah-Hartman (1):
      Linux 5.4.300

H. Nikolaus Schaller (2):
      power: supply: bq27xxx: fix error return in case of no bq27000 hdq battery
      power: supply: bq27xxx: restrict no-battery detection to bq27000

Hans de Goede (1):
      net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer

Hugo Villeneuve (1):
      serial: sc16is7xx: fix bug in flow control levels init

Håkon Bugge (1):
      rds: ib: Increment i_fastreg_wrs before bailing out

Jakob Koschel (1):
      usb: gadget: dummy_hcd: remove usage of list iterator past the loop body

Jiayi Li (1):
      usb: core: Add 0x prefix to quirks debug output

Jinjiang Tu (1):
      mm/hugetlb: fix folio is still mapped when deleted

Johan Hovold (1):
      phy: ti-pipe3: fix device leak at unbind

John Garry (1):
      genirq/affinity: Add irq_update_affinity_desc()

Justin Bronder (1):
      i40e: increase max descriptors for XL710

Kohei Enju (1):
      igb: fix link test skipping when interface is admin down

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
      i40e: add validation for ring_len param
      i40e: fix idx validation in config queues msg
      i40e: fix validation of VF state in get resources
      i40e: add mask to apply valid bits for itr_idx

Maciej Fijalkowski (1):
      i40e: remove redundant memory barrier when cleaning Tx descs

Maciej S. Szmigiero (1):
      KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active

Mark Tinguely (1):
      ocfs2: fix recursive semaphore deadlock in fiemap call

Mathias Nyman (1):
      usb: hub: Fix flushing of delayed work used for post resume purposes

Miaohe Lin (1):
      mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory

Michal Schmidt (1):
      i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Miklos Szeredi (2):
      fuse: check if copy_file_range() returns larger than requested size
      fuse: prevent overflow in copy_file_range return value

Nathan Chancellor (1):
      nilfs2: fix CFI failure when accessing /sys/fs/nilfs2/features/*

Nitesh Narayan Lal (1):
      i40e: Use irq_update_affinity_hint()

Or Har-Toov (1):
      IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions

Philipp Zabel (1):
      net: rfkill: gpio: add DT support

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

Trond Myklebust (1):
      NFSv4: Don't clear capabilities that won't be reset

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


