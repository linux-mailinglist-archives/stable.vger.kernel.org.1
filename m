Return-Path: <stable+bounces-151390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8502AACDE74
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E9F18982E7
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2375228ECE5;
	Wed,  4 Jun 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2hrG7euS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7426AC3;
	Wed,  4 Jun 2025 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042361; cv=none; b=EfeM3zbw9OByhqM+N9mRD1ZqOk0xb53iZYlbdJ6mKVHepo0s51KwmgqWWiQIEay05xSC8jwNAaWN617vRqoCzvANaLyDcPssLG3eqXBGVS9mm4TnPQ5dhPOFhlX4flMKIkUT3HcfAjOxMybTin62Ta2NM+OPt58DlWDL/zQIXVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042361; c=relaxed/simple;
	bh=VqTV+nJz0ytxttXPlUQ/iAedCX5a5P9HkTM1urLY2XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q4W20+PGwGpT0weZhdXPT5BYcNiFZCV0LmXvkJEjNyZtuVbz1RqPYFaKWX9M/sqp/ODqS3a7sly7jifwGBqt+4NWQQf0bDwFN4cUAEOVpAU8A4KVBPGFJGsNNfRGV2vrawyUxHbO48lAgUlG8kMJ9HHp/bsPA6Q/QU4CHbWnriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2hrG7euS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7571C4CEE7;
	Wed,  4 Jun 2025 13:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749042361;
	bh=VqTV+nJz0ytxttXPlUQ/iAedCX5a5P9HkTM1urLY2XU=;
	h=From:To:Cc:Subject:Date:From;
	b=2hrG7euSL6QTi7r6FrfQcVCq4iuLLzb7yg3EErKi0F0tvJO8ZFMJaFK+zH0xJGUzP
	 jKfT+GXFGgVd0Xrfe7GInHSoqHdRlmbN38uS3KcSwDAgVT/im5E2wd8CJvMKt6hOpc
	 4z0N3zagSkKUXpkjiDfVp6v3d3LXSA4xfUnq02OM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.294
Date: Wed,  4 Jun 2025 15:05:56 +0200
Message-ID: <2025060457-precinct-hedge-839f@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.294 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt          |    2 
 Makefile                                                 |   14 
 arch/arm/boot/dts/tegra114.dtsi                          |    2 
 arch/arm64/boot/dts/rockchip/px30.dtsi                   |    4 
 arch/mips/include/asm/ftrace.h                           |   16 
 arch/mips/include/asm/ptrace.h                           |    3 
 arch/mips/kernel/pm-cps.c                                |   30 -
 arch/parisc/math-emu/driver.c                            |   16 
 arch/powerpc/kernel/prom_init.c                          |    4 
 arch/um/Makefile                                         |    1 
 arch/um/kernel/mem.c                                     |    1 
 arch/x86/include/asm/nmi.h                               |    2 
 arch/x86/kernel/cpu/bugs.c                               |   10 
 arch/x86/kernel/nmi.c                                    |   42 +
 arch/x86/kernel/reboot.c                                 |   10 
 arch/x86/um/os-Linux/mcontext.c                          |    3 
 crypto/algif_hash.c                                      |    4 
 drivers/acpi/Kconfig                                     |    2 
 drivers/acpi/hed.c                                       |    7 
 drivers/acpi/pptt.c                                      |   11 
 drivers/clocksource/i8253.c                              |    6 
 drivers/cpuidle/governors/menu.c                         |   13 
 drivers/dma/dmatest.c                                    |    6 
 drivers/edac/altera_edac.c                               |    9 
 drivers/edac/altera_edac.h                               |    2 
 drivers/edac/ie31200_edac.c                              |   28 -
 drivers/fpga/altera-cvp.c                                |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                 |   16 
 drivers/gpu/drm/drm_atomic_helper.c                      |   28 +
 drivers/gpu/drm/drm_edid.c                               |    1 
 drivers/gpu/drm/i915/gvt/opregion.c                      |    8 
 drivers/gpu/drm/mediatek/mtk_dpi.c                       |    5 
 drivers/hid/hid-ids.h                                    |    4 
 drivers/hid/hid-quirks.c                                 |    2 
 drivers/hid/usbhid/usbkbd.c                              |    2 
 drivers/hwmon/gpio-fan.c                                 |   16 
 drivers/hwmon/xgene-hwmon.c                              |    2 
 drivers/i2c/busses/i2c-imx-lpi2c.c                       |    4 
 drivers/i2c/busses/i2c-pxa.c                             |    5 
 drivers/iio/accel/adis16201.c                            |    4 
 drivers/iio/adc/ad7606_spi.c                             |    2 
 drivers/iio/adc/ad7768-1.c                               |    2 
 drivers/iio/adc/dln2-adc.c                               |    2 
 drivers/iio/chemical/sps30.c                             |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c           |    6 
 drivers/infiniband/sw/rxe/rxe_cq.c                       |    5 
 drivers/input/mouse/synaptics.c                          |    5 
 drivers/iommu/amd_iommu_init.c                           |    8 
 drivers/irqchip/irq-gic-v2m.c                            |    8 
 drivers/mailbox/mailbox.c                                |    7 
 drivers/md/dm-cache-target.c                             |   24 
 drivers/md/dm-integrity.c                                |    2 
 drivers/md/dm-table.c                                    |    9 
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c    |    3 
 drivers/media/usb/cx231xx/cx231xx-417.c                  |    2 
 drivers/mmc/host/sdhci-pci-core.c                        |    6 
 drivers/mmc/host/sdhci.c                                 |    9 
 drivers/net/bonding/bond_main.c                          |    2 
 drivers/net/dsa/b53/b53_common.c                         |    2 
 drivers/net/dsa/sja1105/sja1105_main.c                   |    6 
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c                |    9 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                 |   24 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                 |   11 
 drivers/net/ethernet/amd/xgbe/xgbe.h                     |    4 
 drivers/net/ethernet/apm/xgene-v2/main.c                 |    4 
 drivers/net/ethernet/dlink/dl2k.c                        |    2 
 drivers/net/ethernet/dlink/dl2k.h                        |    2 
 drivers/net/ethernet/freescale/fec_main.c                |    7 
 drivers/net/ethernet/mellanox/mlx4/alloc.c               |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c         |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/events.c         |   11 
 drivers/net/ethernet/mellanox/mlx5/core/health.c         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c           |    2 
 drivers/net/ethernet/microchip/lan743x_main.c            |   75 +-
 drivers/net/ethernet/microchip/lan743x_main.h            |   21 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c        |    2 
 drivers/net/ieee802154/ca8210.c                          |    9 
 drivers/net/vxlan.c                                      |   18 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c   |    6 
 drivers/net/wireless/realtek/rtw88/main.c                |   17 
 drivers/net/wireless/realtek/rtw88/rtw8822b.c            |   14 
 drivers/nvdimm/label.c                                   |    3 
 drivers/nvme/host/core.c                                 |    3 
 drivers/nvme/host/tcp.c                                  |   31 +
 drivers/nvme/target/tcp.c                                |    3 
 drivers/of/device.c                                      |    7 
 drivers/pci/controller/dwc/pci-imx6.c                    |    5 
 drivers/pci/setup-bus.c                                  |    6 
 drivers/phy/phy-core.c                                   |    7 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                 |    7 
 drivers/phy/tegra/xusb.c                                 |    8 
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c                   |   44 -
 drivers/pinctrl/devicetree.c                             |   10 
 drivers/pinctrl/meson/pinctrl-meson.c                    |    2 
 drivers/platform/x86/asus-wmi.c                          |    3 
 drivers/platform/x86/fujitsu-laptop.c                    |   33 +
 drivers/platform/x86/thinkpad_acpi.c                     |    7 
 drivers/regulator/ad5398.c                               |   12 
 drivers/rtc/rtc-ds1307.c                                 |    4 
 drivers/scsi/lpfc/lpfc_hbadisc.c                         |   17 
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                       |   12 
 drivers/scsi/st.c                                        |   29 -
 drivers/scsi/st.h                                        |    2 
 drivers/spi/spi-fsl-dspi.c                               |   20 
 drivers/spi/spi-loopback-test.c                          |    2 
 drivers/spi/spi-sun4i.c                                  |    5 
 drivers/staging/axis-fifo/axis-fifo.c                    |  415 +++++----------
 drivers/staging/axis-fifo/axis-fifo.txt                  |   18 
 drivers/staging/iio/adc/ad7816.c                         |    2 
 drivers/target/iscsi/iscsi_target.c                      |    2 
 drivers/target/target_core_file.c                        |    3 
 drivers/target/target_core_iblock.c                      |    4 
 drivers/target/target_core_sbc.c                         |    6 
 drivers/usb/chipidea/ci_hdrc_imx.c                       |   42 -
 drivers/usb/class/usbtmc.c                               |   59 +-
 drivers/usb/host/uhci-platform.c                         |    2 
 drivers/usb/typec/tcpm/tcpm.c                            |    2 
 drivers/usb/typec/ucsi/displayport.c                     |    2 
 drivers/video/fbdev/core/tileblit.c                      |   37 +
 drivers/video/fbdev/fsl-diu-fb.c                         |    1 
 drivers/xen/platform-pci.c                               |    4 
 drivers/xen/swiotlb-xen.c                                |   18 
 drivers/xen/xenbus/xenbus.h                              |    2 
 drivers/xen/xenbus/xenbus_comms.c                        |    9 
 drivers/xen/xenbus/xenbus_dev_frontend.c                 |    2 
 drivers/xen/xenbus/xenbus_probe.c                        |   14 
 drivers/xen/xenbus/xenbus_xs.c                           |   18 
 fs/btrfs/extent_io.c                                     |    7 
 fs/btrfs/send.c                                          |    6 
 fs/cifs/readdir.c                                        |    7 
 fs/coredump.c                                            |   80 ++
 fs/ext4/balloc.c                                         |    4 
 fs/namespace.c                                           |    9 
 fs/nfs/callback_proc.c                                   |    2 
 fs/nfs/filelayout/filelayoutdev.c                        |    6 
 fs/nfs/flexfilelayout/flexfilelayout.c                   |    1 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                |    6 
 fs/nfs/nfs4proc.c                                        |    9 
 fs/nfs/nfs4state.c                                       |   10 
 fs/nfs/pnfs.c                                            |   29 -
 fs/nfs/pnfs.h                                            |    5 
 fs/nfs/pnfs_nfs.c                                        |    9 
 fs/ocfs2/journal.c                                       |   80 ++
 fs/ocfs2/journal.h                                       |    1 
 fs/ocfs2/ocfs2.h                                         |   17 
 fs/ocfs2/quota_local.c                                   |    9 
 fs/ocfs2/super.c                                         |    3 
 fs/orangefs/inode.c                                      |    7 
 include/drm/drm_atomic.h                                 |   23 
 include/linux/binfmts.h                                  |    1 
 include/linux/dma-mapping.h                              |   12 
 include/linux/mlx4/device.h                              |    2 
 include/linux/pid.h                                      |    5 
 include/linux/rcutree.h                                  |    2 
 include/linux/types.h                                    |    3 
 include/sound/pcm.h                                      |    2 
 include/trace/events/btrfs.h                             |    2 
 include/uapi/linux/types.h                               |    1 
 kernel/cgroup/cgroup.c                                   |    2 
 kernel/fork.c                                            |  108 +++
 kernel/params.c                                          |    4 
 kernel/rcu/tree_plugin.h                                 |   11 
 kernel/time/posix-timers.c                               |    1 
 kernel/trace/trace.c                                     |    5 
 lib/dynamic_queue_limits.c                               |    2 
 mm/memcontrol.c                                          |    6 
 mm/page_alloc.c                                          |    8 
 net/bridge/br_nf_core.c                                  |    7 
 net/bridge/br_private.h                                  |    1 
 net/can/bcm.c                                            |   79 +-
 net/core/pktgen.c                                        |   13 
 net/ipv4/fib_rules.c                                     |    4 
 net/ipv6/fib6_rules.c                                    |    4 
 net/llc/af_llc.c                                         |    8 
 net/netfilter/ipset/ip_set_hash_gen.h                    |    2 
 net/netfilter/nf_conntrack_standalone.c                  |   12 
 net/netfilter/nf_tables_api.c                            |   51 +
 net/openvswitch/actions.c                                |    3 
 net/sched/sch_drr.c                                      |    9 
 net/sched/sch_hfsc.c                                     |   15 
 net/sched/sch_htb.c                                      |   13 
 net/sched/sch_qfq.c                                      |   11 
 net/sunrpc/clnt.c                                        |    3 
 net/xfrm/xfrm_policy.c                                   |    3 
 net/xfrm/xfrm_state.c                                    |    3 
 scripts/config                                           |   26 
 scripts/kconfig/merge_config.sh                          |    4 
 security/smack/smackfs.c                                 |    4 
 sound/core/oss/pcm_oss.c                                 |    3 
 sound/core/pcm_native.c                                  |   11 
 sound/pci/es1968.c                                       |    6 
 sound/sh/Kconfig                                         |    2 
 sound/soc/intel/boards/bytcr_rt5640.c                    |   13 
 sound/soc/soc-ops.c                                      |   29 +
 tools/bpf/bpftool/common.c                               |    3 
 tools/build/Makefile.build                               |    6 
 198 files changed, 1680 insertions(+), 838 deletions(-)

Abdun Nihaal (1):
      qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()

Aditya Garg (3):
      Input: synaptics - enable InterTouch on Dynabook Portege X30L-G
      Input: synaptics - enable InterTouch on Dell Precision M3800
      Input: synaptics - enable InterTouch on TUXEDO InfinityBook Pro 14 v5

Al Viro (2):
      do_umount(): add missing barrier before refcount checks in sync case
      __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock

Alessandro Grassi (1):
      spi: spi-sun4i: fix early activation

Alexander Stein (2):
      usb: chipidea: ci_hdrc_imx: use dev_err_probe()
      hwmon: (gpio-fan) Add missing mutex locks

Alexandre Belloni (1):
      rtc: ds1307: stop disabling alarms on probe

Alexei Lazar (1):
      net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB

Alexey Charkov (1):
      usb: uhci-platform: Make the clock really optional

Alexey Denisov (1):
      lan743x: fix endianness when accessing descriptors

Alistair Francis (1):
      nvmet-tcp: don't restore null sk_state_change

Andreas Schwab (1):
      powerpc/prom_init: Fixup missing #size-cells on PowerBook6,7

Andrei Kuchynski (1):
      usb: typec: ucsi: displayport: Fix NULL pointer access

Andrey Vatoropin (1):
      hwmon: (xgene-hwmon) use appropriate type for the latency value

Andy Shevchenko (2):
      types: Complement the aligned types with signed 64-bit one
      ieee802154: ca8210: Use proper setters and getters for bitwise types

Angelo Dureghello (1):
      iio: adc: ad7606: fix serial register access

AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_dpi: Add checks for reg_h_fre_con existence

Ankur Arora (2):
      rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
      rcu: fix header guard for rcu_all_qs()

Arnd Bergmann (2):
      net: xgene-v2: remove incorrect ACPI_PTR annotation
      EDAC/ie31200: work around false positive build warning

Artur Weber (1):
      pinctrl: bcm281xx: Use "unsigned int" instead of bare "unsigned"

Benjamin Berg (1):
      um: Store full CSGSFS and SS register from mcontext

Benjamin Marzinski (1):
      dm: always update the array size in realloc_argv on success

Bibo Mao (1):
      MIPS: Use arch specific syscall name match function

Bitterblue Smith (2):
      wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
      wifi: rtw88: Don't use static local variable in rtw8822b_set_tx_power_index_by_rate

Breno Leitao (2):
      x86/bugs: Make spectre user default depend on MITIGATION_SPECTRE_V2
      memcg: always call cond_resched() after fn()

Christian Brauner (5):
      coredump: fix error handling for replace_fd()
      pidfd: check pid has attached task in fdinfo
      pid: add pidfd_prepare()
      fork: use pidfd_prepare()
      coredump: hand a pidfd to the usermode coredump helper

Christian Göttsche (1):
      ext4: reorder capability check last

Clark Wang (1):
      i2c: imx-lpi2c: Fix clock count when probe defers

Claudiu Beznea (1):
      phy: renesas: rcar-gen3-usb2: Set timing registers only once

Colin Ian King (1):
      lan743x: remove redundant initialization of variable current_head_index

Cong Wang (3):
      sch_htb: make htb_qlen_notify() idempotent
      sch_htb: make htb_deactivate() idempotent
      sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()

Daniel Gomez (1):
      kconfig: merge_config: use an empty file as initfile

Daniel Wagner (1):
      nvme: unblock ctrl state transition for firmware update

Dave Penkler (3):
      usb: usbtmc: Fix erroneous get_stb ioctl error returns
      usb: usbtmc: Fix erroneous wait_srq ioctl return
      usb: usbtmc: Fix erroneous generic_read ioctl return

David Lechner (1):
      iio: chemical: sps30: use aligned_s64 for timestamp

Dmitry Antipov (1):
      module: ensure that kobject_put() is safe for module type kobjects

Dmitry Baryshkov (1):
      phy: core: don't require set_mode() callback for phy_get_mode() to work

Dmitry Bogdanov (1):
      scsi: target: iscsi: Fix timeout on deleted connection

Dmitry Torokhov (1):
      Input: synaptics - enable SMBus for HP Elitebook 850 G1

Eelco Chaudron (1):
      openvswitch: Fix unsafe attribute parsing in output_userspace()

Eric Dumazet (1):
      posix-timers: Add cond_resched() to posix_timer_add() search loop

Erick Shepherd (2):
      mmc: host: Wait for Vdd to settle on card power off
      mmc: sdhci: Disable SD card clock before changing parameters

Fedor Pchelkin (1):
      usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error handling

Filipe Manana (1):
      btrfs: send: return -ENAMETOOLONG when attempting a path that is too long

Florian Westphal (2):
      netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
      netfilter: nf_tables: do not defer rule destruction via call_rcu

Frediano Ziglio (1):
      xen: Add support for XenServer 6.1 platform device

Gabriel Shahrouzi (4):
      staging: iio: adc: ad7816: Correct conditional logic for store mode
      iio: adis16201: Correct inclinometer channel resolution
      staging: axis-fifo: Remove hardware resets for user errors
      staging: axis-fifo: Correct handling of tx_fifo_depth for size validation

Geert Uytterhoeven (2):
      spi: loopback-test: Do not split 1024-byte hexdumps
      ALSA: sh: SND_AICA should depend on SH_DMA_API

Goldwyn Rodrigues (1):
      btrfs: correct the order of prelim_ref arguments in btrfs__prelim_ref

Greg Kroah-Hartman (1):
      Linux 5.4.294

Hangbin Liu (1):
      bonding: report duplicate MAC address in all situations

Hans Verkuil (1):
      media: cx231xx: set device_caps for 417

Hans de Goede (1):
      platform/x86: asus-wmi: Fix wlan_ctrl_by_user detection

Heiko Stuebner (1):
      arm64: dts: rockchip: fix iface clock-name on px30 iommus

Helge Deller (1):
      parisc: Fix double SIGFPE crash

Ian Rogers (1):
      tools/build: Don't pass test log files to linker

Ido Schimmel (2):
      vxlan: Annotate FDB data races
      bridge: netfilter: Fix forwarding of fragmented packets

Ilia Gavrilov (1):
      llc: fix data loss when reading from a socket in llc_ui_recvmsg()

Ilpo Järvinen (1):
      PCI: Fix old_size lower bound in calculate_iosize() too

Isaac Scott (1):
      regulator: ad5398: Add device tree support

Ivan Pravdin (1):
      crypto: algif_hash - fix double free in hash_accept

Jan Kara (3):
      ocfs2: switch osb->disable_recovery to enum
      ocfs2: implement handshaking with ocfs2 recovery thread
      ocfs2: stop quota recovery before disabling quotas

Jani Nikula (1):
      drm/i915/gvt: fix unterminated-string-initialization warning

Jason Andryuk (2):
      xenbus: Use kref to track req lifetime
      xenbus: Allow PVH dom0 a non-local xenstore

Jeff Layton (1):
      nfs: don't share pNFS DS connections between net namespaces

Jeongjun Park (1):
      tracing: Fix oob write in trace_seq_to_buffer()

Jeremy Linton (1):
      ACPI: PPTT: Fix processor subtable walk

Jessica Zhang (1):
      drm: Add valid clones check

Jing Su (1):
      dql: Fix dql->limit value when reset.

John Chau (1):
      platform/x86: thinkpad_acpi: Support also NEC Lavie X1475JAS

Jonas Gorski (1):
      net: dsa: b53: fix learning on VLAN unaware bridges

Jonathan Cameron (2):
      iio: adc: dln2: Use aligned_s64 for timestamp
      iio: adc: ad7768-1: Fix insufficient alignment of timestamp.

Jozsef Kadlecsik (1):
      netfilter: ipset: fix region locking in hash types

Juergen Gross (1):
      xen/swiotlb: relax alignment requirements

Justin Tee (1):
      scsi: lpfc: Handle duplicate D_IDs in ndlp search-by D_ID routine

Kai Mäkisara (3):
      scsi: st: Tighten the page format heuristics with MODE SELECT
      scsi: st: ERASE does not change tape location
      scsi: st: Restore some drive settings after reset

Kees Cook (1):
      net/mlx4_core: Avoid impossible mlx4_db_alloc() order value

Konstantin Andreev (1):
      smack: recognize ipv4 CIPSO w/o categories

Kuhanh Murugasen Krishnan (1):
      fpga: altera-cvp: Increase credit timeout

Kuniyuki Iwashima (1):
      ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().

Larisa Grigore (1):
      spi: spi-fsl-dspi: restrict register range for regmap access

Li Lingfeng (1):
      nfs: handle failure of nfs_get_lock_context in unlock path

Ma Ke (1):
      phy: Fix error handling in tegra_xusb_port_init

Manuel Fombuena (1):
      Input: synaptics - enable InterTouch on Dynabook Portege X30-D

Maor Gottlieb (1):
      net/mlx5: E-Switch, Initialize MAC Address for Default GID

Marek Szyprowski (1):
      dma-mapping: avoid potential unused data compilation warning

Mark Harmstone (1):
      btrfs: avoid linker error in btrfs_find_create_tree_block()

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Ignore battery threshold change event notification

Markus Elfring (1):
      media: c8sectpfe: Call of_node_put(i2c_bus) only once in c8sectpfe_probe()

Martin Blumenstingl (1):
      pinctrl: meson: define the pull up/down resistor value as 60 kOhm

Martin Povišer (1):
      ASoC: ops: Enforce platform maximum on initial value

Masahiro Yamada (1):
      um: let 'make clean' properly clean underlying SUBARCH as well

Matthew Wilcox (Oracle) (1):
      orangefs: Do not truncate file size

Mattias Barthel (1):
      net: fec: ERR007885 Workaround for conventional TX

Michael Liang (1):
      nvme-tcp: fix premature queue removal and I/O failover

Mike Christie (1):
      scsi: target: Fix WRITE_SAME No Data Buffer crash

Mikulas Patocka (2):
      dm-integrity: fix a warning on invalid table line
      dm: restrict dm device size to 2^63-512 bytes

Milton Barrera (1):
      HID: quirks: Add ADATA XPG alpha wireless mouse support

Ming-Hung Tsai (1):
      dm cache: prevent BUG_ON by blocking retries on failed device resumes

Moshe Shemesh (1):
      net/mlx5: Avoid report two health errors on same syndrome

Nathan Chancellor (1):
      kbuild: Disable -Wdefault-const-init-unsafe

Nathan Lynch (1):
      dmaengine: Revert "dmaengine: dmatest: Fix dmatest waiting less when interrupted"

Nicolas Bouchinet (1):
      netfilter: conntrack: Bound nf_conntrack sysctl writes

Niravkumar L Rabara (2):
      EDAC/altera: Test the correct error reg offset
      EDAC/altera: Set DDR and SDMMC interrupt mask before registration

Oliver Hartkopp (2):
      can: bcm: add locking for bcm_op runtime updates
      can: bcm: add missing rcu read protection for procfs content

Oliver Neukum (1):
      USB: usbtmc: use interruptible sleep in usbtmc_read

Pablo Neira Ayuso (1):
      netfilter: nf_tables: wait for rcu grace period on net_device removal

Paul Burton (1):
      MIPS: pm-cps: Use per-CPU variables as per-CPU, not per-core

Paul Chaignon (1):
      xfrm: Sanitize marks before insert

Paul Kocialkowski (1):
      net: dwmac-sun8i: Use parsed internal PHY address instead of 1

Pavel Paklov (1):
      iommu/amd: Fix potential buffer overflow in parse_ivrs_acpihid

Pedro Tammela (1):
      net_sched: hfsc: Address reentrant enqueue adding class to eltree twice

Peter Chen (2):
      usb: chipidea: imx: change hsic power regulator as optional
      usb: chipidea: imx: refine the error handling for hsic

Peter Seiderer (2):
      net: pktgen: fix mpls maximum labels list parsing
      net: pktgen: fix access outside of user given buffer in pktgen_thread_write()

Philip Yang (1):
      drm/amdkfd: KFD release_work possible circular locking

Quentin Deslandes (2):
      staging: axis-fifo: replace spinlock with mutex
      staging: axis-fifo: avoid parsing ignored device tree properties

RD Babiera (1):
      usb: typec: tcpm: delay SNK_TRY_WAIT_DEBOUNCE to SRC_TRYWAIT transition

Rafael J. Wysocki (1):
      cpuidle: menu: Avoid discarding useful information

Richard Zhu (1):
      PCI: imx6: Skip controller_id generation logic for i.MX7D

Robert Richter (1):
      libnvdimm/labels: Fix divide error in nd_label_data_init()

Sebastian Andrzej Siewior (1):
      clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()

Sergey Shtylyov (1):
      of: module: add buffer overflow check in of_modalias()

Seyediman Seyedarab (1):
      kbuild: fix argument parsing in scripts/config

Shahar Shitrit (2):
      net/mlx5: Modify LSB bitmask in temperature event to include only the first bit
      net/mlx5: Apply rate-limiting to high temperature warning

Shivasharan S (1):
      scsi: mpt3sas: Send a diag reset if target reset fails

Shixiong Ou (1):
      fbdev: fsl-diu-fb: add missing device_remove_file()

Silvano Seva (2):
      iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo
      iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_tagged_fifo

Simon Horman (1):
      net: dlink: Correct endianness handling of led_mode

Simona Vetter (1):
      drm/atomic: clarify the rules around drm_atomic_state->allow_modeset

Suzuki K Poulose (1):
      irqchip/gic-v2m: Prevent use after free of gicv2m_get_fwnode()

Svyatoslav Ryhel (1):
      ARM: tegra: Switch DSI-B clock parent to PLLD on Tegra114

Takashi Iwai (2):
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Acer Aspire SW3-013
      ALSA: pcm: Fix race of buffer access at PCM OSS layer

Thangaraj Samynathan (1):
      net: lan743x: Fix memleak issue when GSO enabled

Thomas Gleixner (1):
      irqchip/gic-v2m: Mark a few functions __init

Thorsten Blum (1):
      MIPS: Fix MAX_REG_OFFSET

Tianyang Zhang (1):
      mm/page_alloc.c: avoid infinite retries caused by cpuset race

Tiwei Bie (1):
      um: Update min_low_pfn to match changes in uml_reserved

Trond Myklebust (5):
      NFSv4/pnfs: pnfs_set_layout_stateid() should update the layout cred
      NFSv4/pnfs: Reset the layout state after a layoutreturn
      NFSv4: Treat ENETUNREACH errors as fatal for state recovery
      SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
      pNFS/flexfiles: Report ENETDOWN as a connection error

Tudor Ambarus (2):
      dm: fix copying after src array boundaries
      mailbox: use error ret code of of_parse_phandle_with_args()

Valentin Caron (1):
      pinctrl: devicetree: do not goto err when probing hogs in pinctrl_dt_to_map

Valtteri Koskivuori (1):
      platform/x86: fujitsu-laptop: Support Lifebook S2110 hotkeys

Victor Nogueira (3):
      net_sched: drr: Fix double list add in class with netem as child qdisc
      net_sched: hfsc: Fix a UAF vulnerability in class with netem as child qdisc
      net_sched: qfq: Fix double list add in class with netem as child qdisc

Viktor Malik (1):
      bpftool: Fix readlink usage in get_fd_type

Vishal Badole (1):
      amd-xgbe: Fix to ensure dependent features are toggled with RX checksum offload

Vitalii Mordan (1):
      i2c: pxa: fix call balance of i2c->clk handling routines

Vladimir Oltean (1):
      net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING

Waiman Long (1):
      x86/nmi: Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()

Wang Zhaolong (2):
      smb: client: Fix use-after-free in cifs_fill_dirent
      smb: client: Reset all search buffer pointers when releasing buffer

Wentao Liang (2):
      wifi: brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()
      ALSA: es1968: Add error handling for snd_pcm_hw_constraint_pow2()

William Tu (2):
      net/mlx5e: set the tx_queue_len for pfifo_fast
      net/mlx5e: reduce rep rxq depth to 256 for ECPF

Xiang wangx (1):
      irqchip/gic-v2m: Add const to of_device_id

Xiaofei Tan (1):
      ACPI: HED: Always initialize before evged

Zhu Yanjun (1):
      RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug

Zsolt Kajtar (1):
      fbdev: core: tileblit: Implement missing margin clearing for tileblit

feijuan.li (1):
      drm/edid: fixed the bug that hdr metadata was not reset

gaoxu (1):
      cgroup: Fix compilation issue due to cgroup_mutex not being exported

junan (1):
      HID: usbkbd: Fix the bit shift number for LED_KANA


