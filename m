Return-Path: <stable+bounces-69435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C30295625C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBDF1F21671
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7E32C8B;
	Mon, 19 Aug 2024 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWZ+1DE2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0E1386D2;
	Mon, 19 Aug 2024 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040754; cv=none; b=nfpamJhReX9IptqiJDwhnK8/cxFwz7q6GxRLAzqpYQtMsc90PPRG+iTv+RI15ZBJ5gnUtjHoXtHwUfzMgNKOZIvi0Cz7ADvZwUgIjuk0ZjsYG4Zbav3eiXHwbMSVWl0CGMbrVFPn7qqeMZ5JhK3tufQIfR4wRY+PsGEOnRf1ysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040754; c=relaxed/simple;
	bh=2aUIhnxMNgdElpjIHCVKOSGfvk0fbPwJRQVwLicP0BA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g7SEqthzc8qtHvk9adK+n8Gy9vLYE/X1a3/uAe7N/yMMFSDDnSylO3FPOOZUEuBUSWgpQ1E6VCqEPxqJTA3JHsw2yheAMsdYsfY++EFPAe45mdL0qxIBxGich9/PHQNUveY5jqDqZmmZVD2/ewupo6bw5jE1Tj84LqaUovewyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWZ+1DE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F399C32782;
	Mon, 19 Aug 2024 04:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724040754;
	bh=2aUIhnxMNgdElpjIHCVKOSGfvk0fbPwJRQVwLicP0BA=;
	h=From:To:Cc:Subject:Date:From;
	b=XWZ+1DE2YAU9y8f6ftmmciW0QSI5ZLEWCWAxL6Y3vkC4BZSG24qFVbvvIuFNf1FAL
	 RtJgYBoyg6nh1GCIlkRtuU5oCfPd0IQkzv+v0ywcCtV+C9+495dVhYwzsKBODEaTIW
	 IKC9J7g2ylDHIgj13CrayzQEC1RRX3uzIjwdXpVk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.320
Date: Mon, 19 Aug 2024 06:12:28 +0200
Message-ID: <2024081929-scoreless-cedar-6ad7@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.320 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.txt                         |   18 
 Documentation/hwmon/hwmon-kernel-api.txt                       |   24 
 Makefile                                                       |    2 
 arch/arm64/Kconfig                                             |   38 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                       |    4 
 arch/arm64/include/asm/assembler.h                             |   13 
 arch/arm64/include/asm/barrier.h                               |    4 
 arch/arm64/include/asm/cpucaps.h                               |    4 
 arch/arm64/include/asm/cputype.h                               |   16 
 arch/arm64/include/asm/sysreg.h                                |    6 
 arch/arm64/include/asm/uaccess.h                               |    3 
 arch/arm64/include/uapi/asm/hwcap.h                            |    1 
 arch/arm64/kernel/cpu_errata.c                                 |   43 +
 arch/arm64/kernel/cpufeature.c                                 |  103 +++
 arch/arm64/kernel/cpuinfo.c                                    |    1 
 arch/m68k/amiga/config.c                                       |    9 
 arch/m68k/atari/ataints.c                                      |    6 
 arch/m68k/include/asm/cmpxchg.h                                |    2 
 arch/mips/include/asm/mips-cm.h                                |    4 
 arch/mips/kernel/smp-cps.c                                     |    5 
 arch/powerpc/xmon/ppc-dis.c                                    |   33 -
 arch/sparc/include/asm/oplib_64.h                              |    1 
 arch/sparc/prom/init_64.c                                      |    3 
 arch/sparc/prom/p1275.c                                        |    2 
 arch/x86/events/intel/pt.c                                     |  157 +++--
 arch/x86/events/intel/pt.h                                     |   25 
 arch/x86/include/asm/intel_pt.h                                |   23 
 arch/x86/kernel/cpu/mtrr/mtrr.c                                |    2 
 arch/x86/kernel/devicetree.c                                   |    2 
 arch/x86/mm/pti.c                                              |    6 
 arch/x86/pci/intel_mid_pci.c                                   |    4 
 arch/x86/pci/xen.c                                             |    4 
 arch/x86/platform/intel/iosf_mbi.c                             |    4 
 arch/x86/xen/p2m.c                                             |    4 
 drivers/android/binder.c                                       |    4 
 drivers/base/core.c                                            |   13 
 drivers/base/devres.c                                          |    8 
 drivers/base/module.c                                          |    4 
 drivers/char/hw_random/amd-rng.c                               |    4 
 drivers/char/tpm/eventlog/common.c                             |    2 
 drivers/clk/davinci/da8xx-cfgchip.c                            |    4 
 drivers/clocksource/sh_cmt.c                                   |   13 
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c              |    5 
 drivers/gpu/drm/etnaviv/etnaviv_gem.c                          |    6 
 drivers/gpu/drm/gma500/cdv_intel_lvds.c                        |    3 
 drivers/gpu/drm/gma500/psb_intel_lvds.c                        |    3 
 drivers/gpu/drm/i915/i915_gem.c                                |   47 +
 drivers/gpu/drm/mgag200/mgag200_i2c.c                          |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c                        |    2 
 drivers/hwmon/adt7475.c                                        |    2 
 drivers/hwmon/max6697.c                                        |  145 ++---
 drivers/i2c/i2c-smbus.c                                        |   69 +-
 drivers/infiniband/core/iwcm.c                                 |   11 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                       |    8 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                       |    6 
 drivers/infiniband/hw/mlx4/alias_GUID.c                        |    2 
 drivers/infiniband/hw/mlx4/mad.c                               |    2 
 drivers/infiniband/sw/rxe/rxe_req.c                            |    7 
 drivers/input/mouse/elan_i2c_core.c                            |    2 
 drivers/irqchip/irq-mbigen.c                                   |   20 
 drivers/isdn/hardware/mISDN/hfcmulti.c                         |    7 
 drivers/leds/led-triggers.c                                    |    2 
 drivers/leds/leds-ss4200.c                                     |    7 
 drivers/macintosh/therm_windtunnel.c                           |    2 
 drivers/md/raid5.c                                             |   20 
 drivers/media/pci/saa7134/saa7134-dvb.c                        |    8 
 drivers/media/platform/qcom/venus/vdec.c                       |    1 
 drivers/media/platform/vsp1/vsp1_histo.c                       |   20 
 drivers/media/platform/vsp1/vsp1_pipe.h                        |    2 
 drivers/media/platform/vsp1/vsp1_rpf.c                         |    8 
 drivers/media/rc/imon.c                                        |    5 
 drivers/media/usb/uvc/uvc_ctrl.c                               |   90 ++-
 drivers/media/usb/uvc/uvc_video.c                              |   37 +
 drivers/media/usb/uvc/uvcvideo.h                               |    5 
 drivers/mfd/omap-usb-tll.c                                     |    3 
 drivers/mtd/tests/Makefile                                     |   34 -
 drivers/mtd/tests/mtd_test.c                                   |    9 
 drivers/mtd/ubi/eba.c                                          |    3 
 drivers/net/bonding/bond_main.c                                |    7 
 drivers/net/ethernet/brocade/bna/bna_types.h                   |    2 
 drivers/net/ethernet/brocade/bna/bnad.c                        |   11 
 drivers/net/ethernet/freescale/fec_main.c                      |   52 +
 drivers/net/ethernet/freescale/fec_ptp.c                       |    3 
 drivers/net/ethernet/intel/ice/ice_common.c                    |  102 ++-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h                 |   24 
 drivers/net/netconsole.c                                       |    2 
 drivers/net/usb/qmi_wwan.c                                     |    1 
 drivers/net/usb/sr9700.c                                       |   11 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c |   18 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                |    2 
 drivers/nvme/host/pci.c                                        |    7 
 drivers/parport/daisy.c                                        |    6 
 drivers/parport/ieee1284.c                                     |    4 
 drivers/parport/ieee1284_ops.c                                 |    3 
 drivers/parport/parport_amiga.c                                |    2 
 drivers/parport/parport_atari.c                                |    2 
 drivers/parport/parport_cs.c                                   |    6 
 drivers/parport/parport_gsc.c                                  |   15 
 drivers/parport/parport_ip32.c                                 |   25 
 drivers/parport/parport_mfc3.c                                 |    2 
 drivers/parport/parport_pc.c                                   |  180 ++----
 drivers/parport/parport_sunbpp.c                               |    2 
 drivers/parport/probe.c                                        |    7 
 drivers/parport/procfs.c                                       |   28 
 drivers/parport/share.c                                        |   24 
 drivers/pci/controller/pci-hyperv.c                            |    4 
 drivers/pci/controller/pcie-rockchip.c                         |   12 
 drivers/pci/setup-bus.c                                        |   32 -
 drivers/pinctrl/core.c                                         |   12 
 drivers/pinctrl/freescale/pinctrl-mxs.c                        |    4 
 drivers/pinctrl/pinctrl-single.c                               |    7 
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c                        |   14 
 drivers/platform/chrome/cros_ec_debugfs.c                      |    1 
 drivers/platform/mips/cpu_hwmon.c                              |    3 
 drivers/power/supply/axp288_charger.c                          |   22 
 drivers/pwm/pwm-stm32.c                                        |    5 
 drivers/remoteproc/imx_rproc.c                                 |    5 
 drivers/rtc/rtc-cmos.c                                         |   10 
 drivers/s390/char/sclp_sd.c                                    |   10 
 drivers/scsi/qla2xxx/qla_bsg.c                                 |    2 
 drivers/scsi/qla2xxx/qla_mid.c                                 |    2 
 drivers/scsi/qla2xxx/qla_nvme.c                                |    5 
 drivers/scsi/ufs/ufshcd.c                                      |   11 
 drivers/spi/spi-fsl-lpspi.c                                    |  281 ++++++----
 drivers/tty/serial/serial_core.c                               |    8 
 drivers/usb/gadget/udc/core.c                                  |   10 
 drivers/usb/serial/usb_debug.c                                 |    7 
 drivers/usb/usbip/vhci_hcd.c                                   |    9 
 fs/btrfs/free-space-cache.c                                    |    1 
 fs/exec.c                                                      |    8 
 fs/ext4/mballoc.c                                              |    3 
 fs/ext4/namei.c                                                |   73 ++
 fs/ext4/xattr.c                                                |    6 
 fs/f2fs/inode.c                                                |    3 
 fs/file.c                                                      |    1 
 fs/hfs/inode.c                                                 |    3 
 fs/hfsplus/bfind.c                                             |   15 
 fs/hfsplus/extents.c                                           |    9 
 fs/hfsplus/hfsplus_fs.h                                        |   21 
 fs/jbd2/journal.c                                              |    1 
 fs/jfs/jfs_imap.c                                              |    5 
 fs/nilfs2/btnode.c                                             |   25 
 fs/nilfs2/btree.c                                              |    4 
 fs/nilfs2/segment.c                                            |    7 
 fs/udf/balloc.c                                                |   36 -
 include/linux/hwmon-sysfs.h                                    |   39 +
 include/linux/pci_ids.h                                        |    2 
 include/linux/trace_events.h                                   |    1 
 include/net/netfilter/nf_tables.h                              |   21 
 include/uapi/linux/zorro_ids.h                                 |    3 
 kernel/debug/kdb/kdb_io.c                                      |    8 
 kernel/dma/mapping.c                                           |    2 
 kernel/events/core.c                                           |    2 
 kernel/events/internal.h                                       |    2 
 kernel/time/ntp.c                                              |    9 
 kernel/time/tick-broadcast.c                                   |   24 
 kernel/trace/tracing_map.c                                     |    6 
 kernel/watchdog_hld.c                                          |   11 
 lib/decompress_bunzip2.c                                       |    3 
 lib/kobject_uevent.c                                           |   17 
 mm/page-writeback.c                                            |   30 -
 net/bluetooth/l2cap_core.c                                     |    1 
 net/core/link_watch.c                                          |    4 
 net/ipv4/route.c                                               |   21 
 net/ipv6/addrconf.c                                            |    3 
 net/ipv6/ndisc.c                                               |   34 -
 net/iucv/af_iucv.c                                             |    4 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                          |    4 
 net/netfilter/nf_conntrack_netlink.c                           |    3 
 net/netfilter/nf_tables_api.c                                  |  128 ----
 net/netfilter/nft_set_hash.c                                   |    8 
 net/netfilter/nft_set_rbtree.c                                 |    6 
 net/packet/af_packet.c                                         |   86 ++-
 net/smc/smc_core.c                                             |   32 -
 net/sunrpc/sched.c                                             |    4 
 net/tipc/udp_media.c                                           |    5 
 net/wireless/nl80211.c                                         |   10 
 net/wireless/util.c                                            |    8 
 scripts/gcc-x86_32-has-stack-protector.sh                      |    2 
 scripts/gcc-x86_64-has-stack-protector.sh                      |    2 
 sound/usb/line6/driver.c                                       |    5 
 sound/usb/stream.c                                             |    4 
 tools/memory-model/lock.cat                                    |   20 
 tools/perf/util/sort.c                                         |    2 
 tools/testing/selftests/bpf/test_sockmap.c                     |    3 
 tools/testing/selftests/net/forwarding/devlink_lib.sh          |    2 
 tools/testing/selftests/sigaltstack/current_stack_pointer.h    |    2 
 187 files changed, 1974 insertions(+), 1087 deletions(-)

Adrian Hunter (3):
      perf: Fix perf_aux_size() for greater-than 32-bit size
      perf: Prevent passing zero nr_pages to rb_alloc_aux()
      perf/x86/intel/pt: Fix a topa_entry base address calculation

Al Viro (1):
      protect the fetch of ->fd[fd] in do_dup2() from mispredictions

Alan Stern (1):
      tools/memory-model: Fix bug in lock.cat

Aleksandr Burakov (1):
      saa7134: Unchecked i2c_transfer function result fixed

Aleksandr Mishin (1):
      remoteproc: imx_rproc: Skip over memory region when node value is NULL

Alex Shi (1):
      fs/nilfs2: remove some unused macros to tame gcc

Alexander Shishkin (3):
      perf/x86/intel/pt: Use helpers to obtain ToPA entry size
      perf/x86/intel/pt: Use pointer arithmetics instead in ToPA entry calculation
      perf/x86/intel/pt: Split ToPA metadata and page layout

Alexandra Winter (1):
      net/iucv: fix use after free in iucv_sock_close()

Alexey Kodanev (1):
      bna: adjust 'name' buf size of bna_tcb and bna_ccb structures

Amit Cohen (1):
      selftests: forwarding: devlink_lib: Wait for udev events after reloading

Amit Daniel Kachhap (1):
      arm64: cpufeature: Fix the visibility of compat hwcaps

Andi Kleen (1):
      x86/mtrr: Check if fixed MTRRs exist before saving them

Andi Shyti (1):
      drm/i915/gem: Fix Virtual Memory mapping boundaries calculation

Andreas Larsson (1):
      sparc64: Fix incorrect function signature and add prototype for prom_cif_init

Andy Shevchenko (1):
      driver core: Cast to (void *) with __force for __percpu pointer

Anirudh Venkataramanan (1):
      ice: Rework flex descriptor programming

Arnd Bergmann (2):
      mtd: make mtd_test.c a separate module
      kdb: address -Wformat-security warnings

Baochen Qiang (2):
      wifi: cfg80211: fix typo in cfg80211_calculate_bitrate_he()
      wifi: cfg80211: handle 2x996 RU allocation in cfg80211_calculate_bitrate_he()

Baokun Li (2):
      ext4: check dot and dotdot of dx_root before making dir indexed
      ext4: make sure the first directory block is not a hole

Bart Van Assche (1):
      RDMA/iwcm: Fix a use-after-free related to destroying CM IDs

Bastien Curutchet (1):
      clk: davinci: da8xx-cfgchip: Initialize clk_init_data before use

Benjamin Coddington (1):
      SUNRPC: Fix a race to wake a sync task

Besar Wicaksono (1):
      arm64: Add Neoverse-V2 part

Breno Leitao (1):
      net: netconsole: Disable target before netpoll cleanup

Carlos Llamas (1):
      binder: fix hang of unregistered readers

Chao Peng (1):
      perf/x86/intel/pt: Export pt_cap_get()

Chao Yu (3):
      hfsplus: fix to avoid false alarm of circular locking
      hfs: fix to initialize fields of hfs_inode_info after hfs_alloc_inode()
      f2fs: fix to don't dirty inode for readonly filesystem

Chen Ni (1):
      x86/xen: Convert comma to semicolon

Chen-Yu Tsai (1):
      PCI: rockchip: Make 'ep-gpios' DT property optional

Chengen Du (1):
      af_packet: Handle outgoing VLAN packets without hardware offloading

Chris Wulff (1):
      usb: gadget: core: Check for unset descriptor

Clark Wang (5):
      spi: lpspi: Replace all "master" with "controller"
      spi: lpspi: Add slave mode support
      spi: lpspi: Let watermark change with send data length
      spi: lpspi: Add i.MX8 boards support for lpspi
      spi: lpspi: add the error info of transfer speed setting

Corey Minyard (1):
      i2c: smbus: Don't filter out duplicate alerts

Csókás Bence (1):
      net: fec: Refactor: #define magic constants

Csókás, Bence (2):
      net: fec: Fix FEC_ECR_EN1588 being cleared on link-down
      net: fec: Stop PPS on driver remove

Dan Carpenter (1):
      mISDN: Fix a use after free in hfcmulti_tx()

Dan Williams (1):
      driver core: Fix uevent_show() vs driver detach race

Daniel Schaefer (1):
      media: uvcvideo: Override default flags

Daniele Palmas (1):
      net: usb: qmi_wwan: fix memory leak for not ip packets

Dikshita Agarwal (1):
      media: venus: fix use after free in vdec_close

Dmitry Antipov (1):
      Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()

Dmitry Torokhov (1):
      Input: elan_i2c - do not leave interrupt disabled on suspend failure

Dominique Martinet (1):
      MIPS: Octeron: remove source file executable bit

Dong Aisheng (1):
      remoteproc: imx_rproc: Fix ignoring mapping vdev regions

Douglas Anderson (1):
      kdb: Use the passed prompt in kdb_position_cursor()

Eero Tamminen (1):
      m68k: atari: Fix TT bootup freeze / unexpected (SCU) interrupt messages

Eric Dumazet (1):
      net: linkwatch: use system_unbound_wq

FUJITA Tomonori (1):
      PCI: Add Edimax Vendor ID to pci_ids.h

Fedor Pchelkin (1):
      ubi: eba: properly rollback inside self_check_eba

Filipe Manana (1):
      btrfs: fix bitmap leak when loading free space cache on duplicate entry

Florian Westphal (1):
      netfilter: nf_tables: prefer nft_chain_validate

Geliang Tang (1):
      selftests/bpf: Check length of recv in test_sockmap

George Kennedy (1):
      serial: core: check uartclk for zero to avoid divide by zero

Greg Kroah-Hartman (1):
      Linux 4.19.320

Gregory CLEMENT (1):
      MIPS: SMP-CPS: Fix address for GCR_ACCESS register for CM3 and later

Guangguan Wang (1):
      net/smc: set rmb's SG_MAX_SINGLE_ALLOC limitation only when CONFIG_ARCH_NO_SG_CHAIN is defined

Guenter Roeck (6):
      hwmon: (max6697) Fix underflow when writing limit attributes
      hwmon: Introduce SENSOR_DEVICE_ATTR_{RO, RW, WO} and variants
      hwmon: (max6697) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (max6697) Fix swapped temp{1,8} critical alarms
      i2c: smbus: Improve handling of stuck alerts
      i2c: smbus: Send alert notifications to all devices if source not found

Gustavo A. R. Silva (1):
      parport: parport_pc: Mark expected switch fall-through

Hans de Goede (3):
      leds: trigger: Unregister sysfs attributes before calling deactivate()
      power: supply: axp288_charger: Fix constant_charge_voltage writes
      power: supply: axp288_charger: Round constant_charge_voltage writes down

Honggang LI (1):
      RDMA/rxe: Don't set BTH_ACK_MASK for UC or UD QPs

Ian Forbes (1):
      drm/vmwgfx: Fix overlay when using Screen Targets

Ido Schimmel (1):
      ipv4: Fix incorrect source address in Record Route option

Ilpo Järvinen (7):
      x86/of: Return consistent error type from x86_of_pci_irq_enable()
      x86/pci/intel_mid_pci: Fix PCIBIOS_* return code handling
      x86/pci/xen: Fix PCIBIOS_* return code handling
      x86/platform/iosf_mbi: Convert PCIBIOS_* return codes to errnos
      PCI: Fix resource double counting on remove & rescan
      leds: ss4200: Convert PCIBIOS_* return codes to errnos
      hwrng: amd - Convert PCIBIOS_* return codes to errnos

Ismael Luceno (1):
      ipvs: Avoid unnecessary calls to skb_is_gso_sctp

Jack Wang (1):
      bnxt_re: Fix imm_data endianness

James Morse (1):
      arm64: cpufeature: Force HWCAP to be based on the sysreg visible to user-space

Jan Kara (2):
      ext4: avoid writing unitialized memory to disk in EA inodes
      mm: avoid overflows in dirty throttling logic

Javier Carrasco (1):
      mfd: omap-usb-tll: Use struct_size to allocate tll

Jeongjun Park (1):
      jfs: Fix array-index-out-of-bounds in diFree

Jiaxun Yang (1):
      platform: mips: cpu_hwmon: Disable driver on unsupported hardware

Joe Hattori (1):
      char: tpm: Fix possible memory leak in tpm_bios_measurements_open()

Joe Perches (2):
      parport: Convert printk(KERN_<LEVEL> to pr_<level>(
      parport: Standardize use of printmode

Johannes Berg (2):
      net: bonding: correctly annotate RCU in bond_should_notify_peers()
      wifi: nl80211: don't give key data to userspace

Jon Derrick (1):
      PCI: Equalize hotplug memory and io for occupied and empty slots

Jonas Karlman (1):
      arm64: dts: rockchip: Increase VOP clk rate on RK3328

Joy Chakraborty (1):
      rtc: cmos: Fix return value of nvmem callbacks

Justin Stitt (2):
      ntp: Clamp maxerror and esterror to operating range
      ntp: Safeguard against time_constant overflow

Kees Cook (1):
      exec: Fix ToCToU between perm check and set-uid/gid usage

Kemeng Shi (2):
      jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
      ext4: fix wrong unit use in ext4_mb_find_by_goal

Lance Richardson (1):
      dma: fix call order in dmam_free_coherent

Laurent Pinchart (2):
      media: renesas: vsp1: Fix _irqsave and _irq mix
      media: renesas: vsp1: Store RPF partition configuration per RPF instance

Leon Romanovsky (2):
      RDMA/mlx4: Fix truncated output warning in mad.c
      RDMA/mlx4: Fix truncated output warning in alias_GUID.c

Lucas Stach (2):
      drm/etnaviv: fix DMA direction handling for cached RW buffers
      drm/bridge: analogix_dp: properly handle zero sized AUX transactions

Ma Ke (3):
      drm/gma500: fix null pointer dereference in cdv_intel_lvds_get_modes
      drm/gma500: fix null pointer dereference in psb_intel_lvds_get_modes
      net: usb: sr9700: fix uninitialized variable use in sr_mdio_read

Maciej Żenczykowski (2):
      net: ip_rt_get_source() - use new style struct initializer instead of memset
      ipv6: fix ndisc_is_useropt() handling for PIO

Manish Rangankar (1):
      scsi: qla2xxx: During vport delete send async logout explicitly

Manivannan Sadhasivam (1):
      PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting ep_gpio

Marco Cavenati (1):
      perf/x86/intel/pt: Fix topa_entry base length

Marek Marczykowski-Górecki (1):
      USB: serial: debug: do not echo input by default

Mark Rutland (11):
      arm64: cputype: Add Cortex-X4 definitions
      arm64: cputype: Add Neoverse-V3 definitions
      arm64: errata: Add workaround for Arm errata 3194386 and 3312417
      arm64: cputype: Add Cortex-X3 definitions
      arm64: cputype: Add Cortex-A720 definitions
      arm64: cputype: Add Cortex-X925 definitions
      arm64: errata: Unify speculative SSBS errata logic
      arm64: errata: Expand speculative SSBS workaround
      arm64: cputype: Add Cortex-X1C definitions
      arm64: cputype: Add Cortex-A725 definitions
      arm64: errata: Expand speculative SSBS workaround (again)

Menglong Dong (1):
      bpf: kprobe: remove unused declaring of bpf_kprobe_override

Michael Ellerman (2):
      powerpc/xmon: Fix disassembly CPU feature checks
      selftests/sigaltstack: Fix ppc64 GCC build

Michal Pecio (1):
      media: uvcvideo: Fix the bandwdith quirk on USB 3.x

Namhyung Kim (1):
      perf report: Fix condition in sort__sym_cmp()

Nathan Chancellor (1):
      kbuild: Fix '-S -c' in x86 stack protector scripts

Nick Bowler (1):
      macintosh/therm_windtunnel: fix module unload.

Nicolas Dichtel (1):
      ipv6: take care of scope when choosing the src addr

Niklas Söderlund (1):
      clocksource/drivers/sh_cmt: Address race condition for clock events

Nilesh Javali (1):
      scsi: qla2xxx: validate nvme_local_port correctly

Oleksandr Suvorov (1):
      spi: fsl-lpspi: remove unneeded array

Oliver Neukum (1):
      usb: vhci-hcd: Do not drop references before new references are gained

Pablo Neira Ayuso (3):
      netfilter: ctnetlink: use helper function to calculate expect ID
      netfilter: nf_tables: set element extended ACK reporting support
      netfilter: nf_tables: use timestamp to check for set element timeout

Paolo Pisati (1):
      m68k: amiga: Turn off Warp1260 interrupts during boot

Peng Fan (2):
      pinctrl: freescale: mxs: Fix refcount of child
      remoteproc: imx_rproc: ignore mapping vdev regions

Peter Oberparleiter (1):
      s390/sclp: Prevent release of buffer in I/O

Peter Zijlstra (1):
      x86/mm: Fix pti_clone_pgtable() alignment assumption

Rafael Beims (1):
      wifi: mwifiex: Fix interface type change

Ricardo Ribalda (3):
      media: imon: Fix race getting ictx->lock
      media: uvcvideo: Allow entity-defined get_info and get_cur
      media: uvcvideo: Ignore empty TS packets

Roman Smirnov (1):
      udf: prevent integer overflow in udf_bitmap_free_blocks()

Ross Lagerwall (1):
      decompress_bunzip2: fix rare decompression failure

Ryusuke Konishi (2):
      nilfs2: avoid undefined behavior in nilfs_cnt32_ge macro
      nilfs2: handle inconsistent state in nilfs_btnode_create_block()

Samasth Norway Ananda (1):
      wifi: brcmsmac: LCN PHY code is used for BCM4313 2G-only device

Saurav Kashyap (1):
      scsi: qla2xxx: Return ENOBUFS if sg_cnt is more than one for ELS cmds

Shigeru Yoshida (1):
      tipc: Return non-zero value from tipc_udp_addr2str() on error

Stefan Raspl (1):
      net/smc: Allow SMC-D 1MB DMB allocations

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix scldiv calculation

Takashi Iwai (2):
      ALSA: usb-audio: Correct surround channels in UAC1 channel map
      ALSA: line6: Fix racy access to midibuf

Thomas Gleixner (2):
      watchdog/perf: properly initialize the turbo mode timestamp and rearm counter
      tick/broadcast: Move per CPU pointer access into the atomic section

Thomas Zimmermann (1):
      drm/mgag200: Set DDC timeout in milliseconds

Thorsten Blum (1):
      m68k: cmpxchg: Fix return value for default case in __arch_xchg()

Tze-nan Wu (1):
      tracing: Fix overflow in get_free_elt()

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_debugfs: fix wrong EC message version

Uwe Kleine-König (2):
      pwm: stm32: Always do lazy disabling
      pinctrl: ti: ti-iodelay: Drop if block with always false condition

Vamshi Gajjela (1):
      scsi: ufs: core: Fix hba->last_dme_cmd_tstamp timestamp updating logic

WangYuli (1):
      nvme/pci: Add APST quirk for Lenovo N60z laptop

Wayne Tung (1):
      hwmon: (adt7475) Fix default duty on fan is disabled

Wei Liu (1):
      PCI: hv: Return zero, not garbage, when reading PCI_INTERRUPT_PIN

Wenlin Kang (1):
      kdb: Fix bound check compiler warning

Will Deacon (1):
      arm64: Add support for SB barrier and patch in over DSB; ISB sequences

Yang Yingliang (3):
      pinctrl: core: fix possible memory leak when pinctrl_enable() fails
      pinctrl: single: fix possible memory leak when pinctrl_enable() fails
      pinctrl: ti: ti-iodelay: fix possible memory leak when pinctrl_enable() fails

Yipeng Zou (1):
      irqchip/mbigen: Fix mbigen node address layout

Yu Kuai (1):
      md/raid5: avoid BUG_ON() while continue reshape after reassembling

Yu Liao (1):
      tick/broadcast: Make takeover of broadcast hrtimer reliable

Yunke Cao (1):
      media: uvcvideo: Use entity get_cur in uvc_ctrl_set

Zijun Hu (2):
      kobject_uevent: Fix OOB access within zap_modalias_env()
      devres: Fix memory leakage caused by driver API devm_free_percpu()

tuhaowen (1):
      dev/parport: fix the array out-of-bounds risk


