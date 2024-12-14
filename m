Return-Path: <stable+bounces-104202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F929F20BA
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 21:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F7E7A06A0
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 20:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9795C1B0F3D;
	Sat, 14 Dec 2024 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p/IVf91r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE578C6D;
	Sat, 14 Dec 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734209545; cv=none; b=UIXL4bORD4f4YF87Hz67k5pLTJyg37PvVdNPe2RiAO1gWErPjHqJV6FomKLVolvzBwhimbZKcdSXYYvF+Ul/JhBTBccxsJnVQrgQwsrYB7OiqQqikA1q6b5LYMY5qjhe85DorXAN1yUtWO6Fo7nZi72Nw6koQVL/ZXwmRyJbUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734209545; c=relaxed/simple;
	bh=tDmMKUnx+r4LFXMWn4xFWSzDfd31pjOqtVy2ZG42gmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HxaeoTGg9XCleXGSbIm+DoIcYCkPT8qrYeKUgHDl2jwC14MUC1qHi5iDC12ztSy9B4njVKSVcJcLKoq3q0taaE4W4+Qkw0PBXK4Hz8Eg0YNXNMm7W9whbIdtWCg9+uQKP8K8m8Nj2wGBMC4PxycDI69Su95jtby8SkrrgGZFmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p/IVf91r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDA8C4CED1;
	Sat, 14 Dec 2024 20:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734209544;
	bh=tDmMKUnx+r4LFXMWn4xFWSzDfd31pjOqtVy2ZG42gmU=;
	h=From:To:Cc:Subject:Date:From;
	b=p/IVf91r67+GurZzab4svIWdi4R3oZrnDqjEBprIJBa1XlA8hwsT91UX/WLAR59Ve
	 v8HYcLOFyP2VvtREO9VK8y2+8bQv4Y43Y3EVbQuQwplzzXjVBUf2SLnoSeqnnAd8Dq
	 YLWKy6xqqSCgQQmb8JSFSF04DKw/38fIB8+xBZCU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.287
Date: Sat, 14 Dec 2024 21:52:18 +0100
Message-ID: <2024121416-situated-abruptly-7c55@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.287 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-pci                     |   11 
 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml |   67 
 Documentation/devicetree/bindings/clock/axi-clkgen.txt      |   25 
 Documentation/devicetree/bindings/vendor-prefixes.yaml      |    2 
 Makefile                                                    |    2 
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts                 |    4 
 arch/arm64/kernel/process.c                                 |    2 
 arch/m68k/coldfire/device.c                                 |    8 
 arch/m68k/include/asm/mcfgpio.h                             |    2 
 arch/m68k/include/asm/mvme147hw.h                           |    4 
 arch/m68k/kernel/early_printk.c                             |    9 
 arch/m68k/mvme147/config.c                                  |   30 
 arch/m68k/mvme147/mvme147.h                                 |    6 
 arch/m68k/mvme16x/config.c                                  |    2 
 arch/m68k/mvme16x/mvme16x.h                                 |    6 
 arch/mips/include/asm/switch_to.h                           |    2 
 arch/powerpc/include/asm/sstep.h                            |    5 
 arch/powerpc/include/asm/vdso.h                             |    1 
 arch/powerpc/kernel/prom_init.c                             |   29 
 arch/powerpc/lib/sstep.c                                    |   12 
 arch/s390/kernel/perf_cpum_sf.c                             |    4 
 arch/s390/kernel/syscalls/Makefile                          |    2 
 arch/sh/kernel/cpu/proc.c                                   |    2 
 arch/um/drivers/net_kern.c                                  |    2 
 arch/um/drivers/ubd_kern.c                                  |    2 
 arch/um/drivers/vector_kern.c                               |    3 
 arch/um/kernel/physmem.c                                    |    6 
 arch/um/kernel/process.c                                    |    2 
 arch/um/kernel/sysrq.c                                      |   24 
 arch/x86/crypto/aegis128-aesni-asm.S                        |   29 
 arch/x86/events/intel/pt.c                                  |   11 
 arch/x86/events/intel/pt.h                                  |    2 
 arch/x86/include/asm/amd_nb.h                               |    5 
 arch/x86/kernel/head_64.S                                   |   11 
 arch/x86/kvm/vmx/vmx.c                                      |    4 
 arch/x86/platform/pvh/head.S                                |    2 
 block/blk-mq.c                                              |    6 
 block/blk-mq.h                                              |   13 
 crypto/pcrypt.c                                             |   12 
 drivers/acpi/arm64/gtdt.c                                   |    2 
 drivers/base/regmap/regmap-irq.c                            |    4 
 drivers/base/regmap/regmap.c                                |   12 
 drivers/bluetooth/btusb.c                                   |    2 
 drivers/clk/clk-axi-clkgen.c                                |   26 
 drivers/clk/qcom/gcc-qcs404.c                               |    1 
 drivers/cpufreq/loongson2_cpufreq.c                         |    4 
 drivers/crypto/bcm/cipher.c                                 |    5 
 drivers/crypto/cavium/cpt/cptpf_main.c                      |    6 
 drivers/dma-buf/dma-fence-array.c                           |   28 
 drivers/edac/bluefield_edac.c                               |    2 
 drivers/edac/fsl_ddr_edac.c                                 |   22 
 drivers/firmware/arm_scpi.c                                 |    3 
 drivers/firmware/efi/tpm.c                                  |   19 
 drivers/firmware/google/gsmi.c                              |   10 
 drivers/gpio/gpio-grgpio.c                                  |   26 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                 |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                     |    1 
 drivers/gpu/drm/drm_mm.c                                    |    2 
 drivers/gpu/drm/drm_panel_orientation_quirks.c              |    6 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                    |    3 
 drivers/gpu/drm/etnaviv/etnaviv_dump.c                      |   13 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                       |   40 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h                       |   21 
 drivers/gpu/drm/imx/ipuv3-crtc.c                            |    6 
 drivers/gpu/drm/mcde/mcde_drv.c                             |    1 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                       |    4 
 drivers/gpu/drm/omapdrm/omap_gem.c                          |   10 
 drivers/gpu/drm/panfrost/panfrost_gpu.c                     |    1 
 drivers/gpu/drm/radeon/r600_cs.c                            |    2 
 drivers/gpu/drm/sti/sti_mixer.c                             |    2 
 drivers/hid/wacom_sys.c                                     |    3 
 drivers/hid/wacom_wac.c                                     |    4 
 drivers/i3c/master.c                                        |    5 
 drivers/iio/adc/ad7780.c                                    |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                    |    7 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                    |    2 
 drivers/leds/led-class.c                                    |   14 
 drivers/md/bcache/super.c                                   |    2 
 drivers/md/dm-thin.c                                        |    1 
 drivers/media/dvb-core/dvbdev.c                             |   15 
 drivers/media/dvb-frontends/ts2020.c                        |    8 
 drivers/media/i2c/tc358743.c                                |    4 
 drivers/media/platform/qcom/venus/core.c                    |    2 
 drivers/media/radio/wl128x/fmdrv_common.c                   |    3 
 drivers/media/usb/cx231xx/cx231xx-cards.c                   |    2 
 drivers/media/usb/gspca/ov534.c                             |    2 
 drivers/media/usb/uvc/uvc_driver.c                          |   11 
 drivers/message/fusion/mptsas.c                             |    4 
 drivers/mfd/da9052-spi.c                                    |    2 
 drivers/mfd/intel_soc_pmic_bxtwc.c                          |  196 
 drivers/mfd/rt5033.c                                        |    4 
 drivers/mfd/tps65010.c                                      |    8 
 drivers/misc/apds990x.c                                     |   12 
 drivers/misc/eeprom/eeprom_93cx6.c                          |   10 
 drivers/mmc/core/bus.c                                      |    2 
 drivers/mmc/core/core.c                                     |    3 
 drivers/mmc/host/dw_mmc.c                                   |    4 
 drivers/mmc/host/mmc_spi.c                                  |    9 
 drivers/mtd/nand/raw/atmel/pmecc.c                          |    8 
 drivers/mtd/nand/raw/atmel/pmecc.h                          |    2 
 drivers/mtd/ubi/attach.c                                    |   12 
 drivers/mtd/ubi/wl.c                                        |    9 
 drivers/net/can/sun4i_can.c                                 |   22 
 drivers/net/ethernet/broadcom/tg3.c                         |    3 
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c            |    2 
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c        |    2 
 drivers/net/ethernet/intel/igb/igb_main.c                   |    4 
 drivers/net/ethernet/marvell/pxa168_eth.c                   |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c  |    8 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c           |   15 
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                   |    4 
 drivers/net/ethernet/rocker/rocker_main.c                   |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c         |    2 
 drivers/net/usb/lan78xx.c                                   |   11 
 drivers/net/usb/qmi_wwan.c                                  |    1 
 drivers/net/wireless/ath/ath5k/pci.c                        |    2 
 drivers/net/wireless/ath/ath9k/htc_hst.c                    |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |    2 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c              |    8 
 drivers/net/wireless/intersil/p54/p54spi.c                  |    4 
 drivers/net/wireless/marvell/mwifiex/fw.h                   |    2 
 drivers/net/wireless/marvell/mwifiex/main.c                 |    4 
 drivers/nvdimm/dax_devs.c                                   |    4 
 drivers/nvdimm/nd.h                                         |    7 
 drivers/nvme/host/core.c                                    |    7 
 drivers/nvme/host/pci.c                                     |   16 
 drivers/pci/controller/pcie-rockchip-ep.c                   |   18 
 drivers/pci/controller/pcie-rockchip.h                      |    4 
 drivers/pci/hotplug/cpqphp_pci.c                            |   19 
 drivers/pci/pci-sysfs.c                                     |   26 
 drivers/pci/pci.c                                           |    2 
 drivers/pci/pci.h                                           |    1 
 drivers/pci/quirks.c                                        |   15 
 drivers/pci/slot.c                                          |    4 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                    |    2 
 drivers/platform/x86/intel_bxtwc_tmu.c                      |   22 
 drivers/power/avs/smartreflex.c                             |    4 
 drivers/power/supply/power_supply_core.c                    |    2 
 drivers/regulator/rk808-regulator.c                         |    2 
 drivers/rpmsg/qcom_glink_native.c                           |  175 
 drivers/rtc/interface.c                                     |    7 
 drivers/rtc/rtc-ab-eoz9.c                                   |    7 
 drivers/rtc/rtc-abx80x.c                                    |    2 
 drivers/rtc/rtc-st-lpc.c                                    |    5 
 drivers/scsi/bfa/bfad.c                                     |    3 
 drivers/scsi/qedf/qedf_main.c                               |    1 
 drivers/scsi/qedi/qedi_main.c                               |    1 
 drivers/scsi/qla2xxx/qla_attr.c                             |    1 
 drivers/scsi/qla2xxx/qla_bsg.c                              |   10 
 drivers/scsi/qla2xxx/qla_mid.c                              |    1 
 drivers/scsi/st.c                                           |   31 
 drivers/sh/intc/core.c                                      |    2 
 drivers/soc/qcom/qcom-geni-se.c                             |    3 
 drivers/soc/qcom/socinfo.c                                  |    8 
 drivers/spi/spi-mpc52xx.c                                   |    1 
 drivers/spi/spi.c                                           |   13 
 drivers/staging/comedi/comedi_fops.c                        |   12 
 drivers/staging/greybus/uart.c                              |    3 
 drivers/staging/media/allegro-dvt/allegro-core.c            |    4 
 drivers/tty/serial/8250/8250_omap.c                         |    4 
 drivers/tty/tty_ldisc.c                                     |    2 
 drivers/usb/chipidea/udc.c                                  |    2 
 drivers/usb/dwc3/gadget.c                                   |    9 
 drivers/usb/gadget/composite.c                              |   18 
 drivers/usb/host/ehci-spear.c                               |    7 
 drivers/usb/misc/chaoskey.c                                 |   35 
 drivers/usb/misc/iowarrior.c                                |   50 
 drivers/usb/misc/yurex.c                                    |    5 
 drivers/usb/typec/tcpm/wcove.c                              |    4 
 drivers/vfio/pci/vfio_pci_config.c                          |   16 
 drivers/video/fbdev/sh7760fb.c                              |   11 
 drivers/watchdog/iTCO_wdt.c                                 |   21 
 drivers/watchdog/mtk_wdt.c                                  |    6 
 drivers/xen/xenbus/xenbus_probe.c                           |   29 
 drivers/xen/xenbus/xenbus_probe_backend.c                   |   39 
 fs/btrfs/ref-verify.c                                       |    1 
 fs/cifs/smb2ops.c                                           |    6 
 fs/ext4/fsmap.c                                             |   54 
 fs/ext4/mballoc.c                                           |   18 
 fs/ext4/mballoc.h                                           |    1 
 fs/ext4/super.c                                             |    8 
 fs/f2fs/inode.c                                             |    4 
 fs/hfsplus/hfsplus_fs.h                                     |    3 
 fs/hfsplus/wrapper.c                                        |    2 
 fs/jffs2/compr_rtime.c                                      |    3 
 fs/jffs2/erase.c                                            |    7 
 fs/jfs/jfs_dmap.c                                           |    6 
 fs/jfs/jfs_dtree.c                                          |   15 
 fs/jfs/xattr.c                                              |    2 
 fs/nfs/nfs4proc.c                                           |    8 
 fs/nfsd/export.c                                            |    5 
 fs/nfsd/nfs4callback.c                                      |   16 
 fs/nfsd/nfs4proc.c                                          |   14 
 fs/nfsd/nfs4recover.c                                       |    3 
 fs/nfsd/nfs4state.c                                         |   19 
 fs/nilfs2/btnode.c                                          |    2 
 fs/nilfs2/dir.c                                             |    2 
 fs/nilfs2/gcinode.c                                         |    4 
 fs/nilfs2/mdt.c                                             |    1 
 fs/nilfs2/page.c                                            |    2 
 fs/ocfs2/aops.h                                             |    2 
 fs/ocfs2/dlmglue.c                                          |    1 
 fs/ocfs2/file.c                                             |    4 
 fs/ocfs2/localalloc.c                                       |   19 
 fs/ocfs2/namei.c                                            |    4 
 fs/ocfs2/resize.c                                           |    2 
 fs/ocfs2/super.c                                            |   13 
 fs/overlayfs/util.c                                         |    3 
 fs/proc/softirqs.c                                          |    2 
 fs/quota/dquot.c                                            |    2 
 fs/ubifs/super.c                                            |    6 
 fs/ubifs/tnc_commit.c                                       |    2 
 fs/unicode/mkutf8data.c                                     |   70 
 fs/unicode/utf8data.h_shipped                               | 6703 ++++++------
 include/linux/blkdev.h                                      |    2 
 include/linux/cgroup-defs.h                                 |    7 
 include/linux/eeprom_93cx6.h                                |   11 
 include/linux/jiffies.h                                     |    2 
 include/linux/leds.h                                        |    2 
 include/linux/netpoll.h                                     |    2 
 include/linux/sunrpc/xprtsock.h                             |    1 
 include/linux/util_macros.h                                 |   56 
 include/uapi/linux/tipc.h                                   |   21 
 include/xen/xenbus.h                                        |    3 
 init/initramfs.c                                            |   15 
 kernel/bpf/devmap.c                                         |   68 
 kernel/bpf/lpm_trie.c                                       |   27 
 kernel/cgroup/cgroup-internal.h                             |    3 
 kernel/cgroup/cgroup.c                                      |   23 
 kernel/time/time.c                                          |    2 
 kernel/trace/ftrace.c                                       |    3 
 kernel/trace/trace_clock.c                                  |    2 
 kernel/trace/trace_event_perf.c                             |    6 
 kernel/trace/tracing_map.c                                  |    6 
 lib/string_helpers.c                                        |    2 
 mm/shmem.c                                                  |    2 
 net/9p/trans_xen.c                                          |    9 
 net/bluetooth/l2cap_sock.c                                  |    1 
 net/bluetooth/rfcomm/sock.c                                 |   10 
 net/can/af_can.c                                            |    1 
 net/can/j1939/transport.c                                   |    2 
 net/core/filter.c                                           |   85 
 net/core/neighbour.c                                        |    1 
 net/core/netpoll.c                                          |    2 
 net/dccp/feat.c                                             |    6 
 net/ieee802154/socket.c                                     |   12 
 net/ipv4/af_inet.c                                          |   22 
 net/ipv4/ipmr.c                                             |   48 
 net/ipv4/ipmr_base.c                                        |    3 
 net/ipv4/tcp_bpf.c                                          |   11 
 net/ipv6/af_inet6.c                                         |   22 
 net/ipv6/ip6mr.c                                            |    8 
 net/ipv6/route.c                                            |    6 
 net/mac80211/main.c                                         |    2 
 net/netfilter/ipset/ip_set_bitmap_ip.c                      |    7 
 net/netfilter/ipset/ip_set_core.c                           |    5 
 net/netfilter/ipvs/ip_vs_proto.c                            |    4 
 net/netfilter/nft_set_hash.c                                |   16 
 net/netfilter/xt_LED.c                                      |    4 
 net/netlink/af_netlink.c                                    |   31 
 net/netlink/af_netlink.h                                    |    2 
 net/packet/af_packet.c                                      |   12 
 net/rfkill/rfkill-gpio.c                                    |    8 
 net/sched/sch_cbs.c                                         |    2 
 net/sched/sch_tbf.c                                         |   18 
 net/sunrpc/cache.c                                          |    4 
 net/sunrpc/xprtsock.c                                       |   29 
 net/tipc/bearer.c                                           |   14 
 net/tipc/bearer.h                                           |    3 
 net/tipc/node.c                                             |   99 
 net/tipc/node.h                                             |    1 
 net/tipc/udp_media.c                                        |    2 
 samples/bpf/test_cgrp2_sock.c                               |    4 
 samples/bpf/xdp_adjust_tail_kern.c                          |    1 
 scripts/mkcompile_h                                         |    2 
 scripts/mod/file2alias.c                                    |    5 
 scripts/mod/modpost.c                                       |    2 
 security/apparmor/capability.c                              |    2 
 sound/pci/hda/patch_realtek.c                               |  113 
 sound/soc/codecs/da7219.c                                   |    9 
 sound/soc/codecs/hdmi-codec.c                               |  140 
 sound/soc/fsl/fsl_micfil.c                                  |   74 
 sound/soc/fsl/fsl_micfil.h                                  |  272 
 sound/soc/intel/boards/bytcr_rt5640.c                       |   15 
 sound/soc/stm/stm32_sai_sub.c                               |    6 
 sound/usb/6fire/chip.c                                      |   10 
 sound/usb/caiaq/audio.c                                     |   10 
 sound/usb/caiaq/audio.h                                     |    1 
 sound/usb/caiaq/device.c                                    |   19 
 sound/usb/caiaq/input.c                                     |   12 
 sound/usb/caiaq/input.h                                     |    1 
 sound/usb/clock.c                                           |   32 
 sound/usb/quirks.c                                          |   19 
 sound/usb/usx2y/us122l.c                                    |    5 
 tools/perf/builtin-trace.c                                  |   14 
 tools/perf/util/cs-etm.c                                    |   25 
 tools/perf/util/probe-finder.c                              |   17 
 tools/testing/selftests/net/pmtu.sh                         |    2 
 tools/testing/selftests/vDSO/parse_vdso.c                   |    3 
 tools/testing/selftests/watchdog/watchdog-test.c            |    6 
 virt/kvm/arm/vgic/vgic-its.c                                |   32 
 virt/kvm/arm/vgic/vgic.h                                    |   24 
 302 files changed, 5789 insertions(+), 4751 deletions(-)

Adrian Hunter (1):
      perf/x86/intel/pt: Fix buffer full but size is 0 case

Aleksandr Mishin (1):
      acpi/arm64: Adjust error handling procedure in gtdt_parse_timer_block()

Alex Zenla (2):
      9p/xen: fix init sequence
      9p/xen: fix release of IRQ

Alexander Shiyan (1):
      media: i2c: tc358743: Fix crash in the probe error path when using polling

Alexandru Ardelean (3):
      dt-bindings: clock: adi,axi-clkgen: convert old binding to yaml format
      clk: axi-clkgen: use devm_platform_ioremap_resource() short-hand
      util_macros.h: fix/rework find_closest() macros

Alper Nebi Yasak (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()

Andre Przywara (1):
      ARM: dts: cubieboard4: Fix DCDC5 regulator constraints

Andrej Shadura (1):
      Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()

Andrew Morton (1):
      mm: revert "mm: shmem: fix data-race in shmem_getattr()"

Andy Shevchenko (6):
      regmap: irq: Set lockdep class for hierarchical IRQ domains
      drm/mm: Mark drm_mm_interval_tree*() functions with __maybe_unused
      mfd: intel_soc_pmic_bxtwc: Use dev_err_probe()
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices

Anil Gurumurthy (1):
      scsi: qla2xxx: Supported speed displayed incorrectly for VPorts

Antonio Quartulli (1):
      m68k: coldfire/device.c: only build FEC when HW macros are defined

Arnd Bergmann (1):
      x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB

Artem Sadovnikov (1):
      jfs: xattr: check invalid xattr size more strictly

Arthur Heymans (1):
      firmware: google: Unregister driver_info on failure and exit in gsmi

Arun Kumar Neelakantam (2):
      rpmsg: glink: Add TX_DATA_CONT command while sending
      rpmsg: glink: Send READ_NOTIFY command in FIFO full case

Aurelien Jarno (1):
      Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"

Avihai Horon (1):
      vfio/pci: Properly hide first-in-list PCIe extended capability

Barnabás Czémán (1):
      pinctrl: qcom-pmic-gpio: add support for PM8937

Bart Van Assche (1):
      power: supply: core: Remove might_sleep() from power_supply_put()

Bartosz Golaszewski (3):
      mmc: mmc_spi: drop buggy snprintf()
      lib: string_helpers: silence snprintf() output truncation warning
      gpio: grgpio: use a helper variable to store the address of ofdev->dev

Ben Greear (1):
      mac80211: fix user-power when emulating chanctx

Benjamin Peterson (2):
      perf trace: Do not lose last events in a race
      perf trace: Avoid garbage when not printing a syscall's arguments

Benoît Monin (1):
      net: usb: qmi_wwan: add Quectel RG650V

Benoît Sevens (1):
      ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices

Bin Liu (1):
      serial: 8250: omap: Move pm_runtime_get_sync

Bjorn Andersson (2):
      rpmsg: glink: Fix GLINK command prefix
      rpmsg: glink: Propagate TX failures in intentless mode as well

Björn Töpel (1):
      xdp: Simplify devmap cleanup

Breno Leitao (3):
      ipmr: Fix access to mfc_cache_list without lock held
      netpoll: Use rcu_access_pointer() in netpoll_poll_lock
      netpoll: Use rcu_access_pointer() in __netpoll_setup

Calum Mackay (1):
      SUNRPC: correct error code comment in xs_tcp_setup_socket()

Charles Han (2):
      soc: qcom: Add check devm_kasprintf() returned value
      gpio: grgpio: Add NULL check in grgpio_probe

Chen Ridong (1):
      crypto: bcm - add error check in the ahash_hmac_init function

Chris Down (1):
      kbuild: Use uname for LINUX_COMPILE_HOST detection

Christian König (1):
      dma-buf: fix dma_fence_array_signaled v4

Christoph Hellwig (2):
      nvme-pci: fix freeing of the HMB descriptor table
      block: return unsigned int from bdev_io_min

Christophe JAILLET (1):
      crypto: cavium - Fix an error handling path in cpt_ucode_load_fw()

Christophe Leroy (1):
      powerpc/vdso: Flag VDSO64 entry points as functions

Chuck Lever (5):
      NFSD: Force all NFSv4.2 COPY requests to be synchronous
      NFSD: Prevent NULL dereference in nfsd4_process_cb_update()
      NFSD: Cap the number of bytes copied by nfs4_reset_recoverydir()
      NFSD: Fix nfsd4_shutdown_copy()
      NFSD: Prevent a potential integer overflow

Claudiu Beznea (1):
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit

Cosmin Tanislav (1):
      regmap: detach regmap from dev on regmap_exit

Damien Le Moal (1):
      PCI: rockchip-ep: Fix address translation unit programming

Dan Carpenter (2):
      soc: qcom: geni-se: fix array underflow in geni_se_clk_tbl_get()
      sh: intc: Fix use-after-free bug in register_intc_controller()

Daniel Palmer (2):
      m68k: mvme147: Fix SCSI controller IRQ numbers
      m68k: mvme147: Reinstate early console

Dario Binacchi (2):
      can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL
      can: sun4i_can: sun4i_can_err(): fix {rx,tx}_errors statistics

David Disseldorp (1):
      initramfs: avoid filename buffer overrun

David Given (1):
      media: uvcvideo: Add a quirk for the Kaiweets KTI-W02 infrared camera

David Thompson (1):
      EDAC/bluefield: Fix potential integer overflow

David Wang (1):
      proc/softirqs: replace seq_printf with seq_put_decimal_ull_width

Defa Li (1):
      i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock

Dinesh Kumar (1):
      ALSA: hda/realtek: Fix Internal Speaker and Mic boost of Infinix Y4 Max

Dmitry Antipov (6):
      ocfs2: uncache inode which has failed entering the group
      ocfs2: fix UBSAN warning in ocfs2_verify_volume()
      ocfs2: fix uninitialized value in ocfs2_file_read_iter()
      netfilter: x_tables: fix LED ID check in led_tg_check()
      can: j1939: j1939_session_new(): fix skb reference counting
      rocker: fix link status detection in rocker_carrier_init()

Dmitry Safonov (2):
      um/sysrq: remove needless variable sp
      um: add show_stack_loglvl()

Doug Brown (1):
      drm/etnaviv: fix power register offset on GC300

Dragos Tatulea (1):
      net/mlx5e: kTLS, Fix incorrect page refcounting

Edward Adam Davis (1):
      USB: chaoskey: Fix possible deadlock chaoskey_list_lock

Elena Salomatkina (1):
      net/sched: cbs: Fix integer overflow in cbs_set_port_rate()

Eric Biggers (1):
      crypto: x86/aegis128 - access 32-bit arguments as 32-bit

Eric Dumazet (1):
      ipmr: convert /proc handlers to rcu_read_lock()

Everest K.C (1):
      crypto: cavium - Fix the if condition to exit loop after timeout

Filipe Manana (1):
      btrfs: ref-verify: fix use-after-free after invalid ref action

Frank Li (1):
      i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()

Gabor Juhos (1):
      clk: qcom: gcc-qcs404: fix initial rate of GPLL3

Gaosheng Cui (1):
      media: platform: allegro-dvt: Fix possible memory leak in allocate_buffers_internal()

Geert Uytterhoeven (1):
      m68k: mvme16x: Add and use "mvme16x.h"

Ghanshyam Agrawal (3):
      jfs: array-index-out-of-bounds fix in dtReadFirst
      jfs: fix shift-out-of-bounds in dbSplit
      jfs: fix array-index-out-of-bounds in jfs_readdir

Greg Kroah-Hartman (2):
      Revert "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
      Linux 5.4.287

Gregory Price (1):
      tpm: fix signed/unsigned bug when checking event logs

Hans de Goede (1):
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet

Heming Zhao (1):
      ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"

Hilda Wu (1):
      Bluetooth: btusb: Add RTL8852BE device 0489:e123 to device tables

Hou Tao (2):
      bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
      bpf: Fix exact match conditions in trie_get_next_key()

Huacai Chen (1):
      sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Ignat Korchagin (6):
      af_packet: avoid erroring out after sock_init_data() in packet_create()
      Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
      net: af_can: do not leave a dangling sk pointer in can_create()
      net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
      net: inet: do not leave a dangling sk pointer in inet_create()
      net: inet6: do not leave a dangling sk pointer in inet6_create()

Igor Artemiev (1):
      drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()

Igor Prusov (1):
      dt-bindings: vendor-prefixes: Add NeoFidelity, Inc

Ilpo Järvinen (1):
      PCI: cpqphp: Fix PCIBIOS_* return value confusion

Ivan Solodovnikov (1):
      dccp: Fix memory leak in dccp_feat_change_recv

Jakub Kicinski (2):
      netlink: terminate outstanding dump on socket close
      net/neighbor: clear error in case strict check is not set

James Clark (1):
      perf cs-etm: Don't flush when packet_queue fills up

Jann Horn (1):
      comedi: Flush partial mappings in error case

Jason Gerecke (1):
      HID: wacom: Interpret tilt data from Intuos Pro BT as signed values

Jean-Michel Hautbois (1):
      m68k: mcfgpio: Fix incorrect register offset for CONFIG_M5441x

Jeongjun Park (4):
      wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
      usb: using mutex lock and supporting O_NONBLOCK flag in iowarrior_read()
      ext4: supress data-race warnings in ext4_free_inodes_{count,set}()
      netfilter: ipset: add missing range check in bitmap_ip_uadt

Jerry Snitselaar (1):
      efi/tpm: Pass correct address to memblock_reserve

Jiapeng Chong (1):
      wifi: ipw2x00: libipw_rx_any(): fix bad alignment

Jing Zhang (1):
      KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*

Jinghao Jia (1):
      ipvs: fix UB due to uninitialized stack access in ip_vs_protocol_init()

Jinjie Ruan (10):
      soc: ti: smartreflex: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/imx/ipuv3: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/msm/adreno: Use IRQF_NO_AUTOEN flag in request_irq()
      mfd: tps65010: Use IRQF_NO_AUTOEN flag in request_irq() to fix race
      misc: apds990x: Fix missing pm_runtime_disable()
      rtc: st-lpc: Use IRQF_NO_AUTOEN flag in request_irq()
      media: venus: Fix pm_runtime_set_suspended() with runtime pm enabled
      media: gspca: ov534-ov772x: Fix off-by-one error in set_frame_rate()

Jiri Slaby (1):
      x86/asm: Reorder early variables

Jiri Wiesner (1):
      net/ipv6: release expired exception dst cached in socket

Joaquín Ignacio Aramendía (1):
      drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model

Johan Hovold (1):
      staging: greybus: uart: clean up TIOCGSERIAL

Johannes Berg (1):
      um: Clean up stacktrace dump

John Fastabend (1):
      bpf, xdp: Update devmap comments to reflect napi/rcu usage

Jonas Gorski (1):
      mips: asm: fix warning when disabling MIPS_FP_SUPPORT

Jonas Karlman (1):
      ASoC: hdmi-codec: reorder channel allocation list

Jonathan Marek (1):
      rpmsg: glink: use only lower 16-bits of param2 for CMD_OPEN name length

Josh Poimboeuf (1):
      x86/xen/pvh: Annotate indirect branch as safe

Juergen Gross (1):
      xen/xenbus: fix locking

Kai Mäkisara (2):
      scsi: st: Don't modify unknown block number in MTIOCGET
      scsi: st: Add MTIOCGET and MTLOAD to ioctls allowed after device reset

Kailang Yang (2):
      ALSA: hda/realtek: Update ALC225 depop procedure
      ALSA: hda/realtek: Set PCBeep to default value for ALC274

Kashyap Desai (1):
      RDMA/bnxt_re: Check cqe flags to know imm_data vs inv_irkey

Keith Busch (1):
      PCI: Add 'reset_subordinate' to reset hierarchy below bridge

Kinsey Moore (1):
      jffs2: Prevent rtime decompress memory corruption

Kuan-Wei Chiu (1):
      tracing: Fix cmp_entries_dup() to respect sort() comparison rules

Kuniyuki Iwashima (1):
      tipc: Fix use-after-free of kernel socket in cleanup_bearer().

Kunkun Jiang (2):
      KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
      KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE

Leo Yan (1):
      perf probe: Correct demangled symbols in C++ program

Levi Yun (1):
      trace/trace_event_perf: remove duplicate samples on the first tracepoint event

Li Zetao (1):
      media: ts2020: fix null-ptr-deref in ts2020_probe()

Li Zhijian (1):
      selftests/watchdog-test: Fix system accidentally reset after watchdog-test

Liao Chen (1):
      drm/mcde: Enable module autoloading

Liequan Che (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again

Linus Torvalds (1):
      Revert "unicode: Don't special case ignorable code points"

Liu Jian (1):
      sunrpc: clear XPRT_SOCK_UPD_TIMEOUT when reset transport

Louis Leseur (1):
      net/qed: allow old cards not supporting "num_images" to work

Lucas Stach (2):
      drm/etnaviv: hold GPU lock across perfmon sampling
      drm/etnaviv: flush shader L1 cache after user commandstream

Lukas Wunner (1):
      PCI: Fix use-after-free of slot->bus on hot remove

Luo Qiu (1):
      firmware: arm_scpi: Check the DVFS OPP count returned by the firmware

Luo Yifan (2):
      ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
      ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_div()

Maciej Fijalkowski (1):
      bpf: fix OOB devmap writes when deleting elements

Manikanta Mylavarapu (1):
      soc: qcom: socinfo: fix revision check in qcom_socinfo_probe()

Marc Kleine-Budde (1):
      drm/etnaviv: dump: fix sparse warnings

Marcus Folkesson (1):
      mfd: da9052-spi: Change read-mask to write-mask

Mark Bloch (1):
      net/mlx5: fs, lock FTE when checking if active

Martin Ottens (1):
      net/sched: tbf: correct backlog statistic for GSO packets

Masahiro Yamada (2):
      s390/syscalls: Avoid creation of arch/arch/ directory
      modpost: remove incorrect code in do_eisa_entry()

Mauro Carvalho Chehab (1):
      media: dvbdev: fix the logic when DVB_DYNAMIC_MINORS is not set

Maxime Chevallier (2):
      net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as broken
      rtc: ab-eoz9: don't fail temperature reads on undervoltage notification

Mengyuan Lou (1):
      PCI: Add ACS quirk for Wangxun FF5xxx NICs

Michael Ellerman (1):
      powerpc/prom_init: Fixup missing powermac #size-cells

Michal Suchanek (1):
      powerpc/sstep: make emulate_vsx_load and emulate_vsx_store static

Michal Vrastil (1):
      Revert "usb: gadget: composite: fix OS descriptors w_value logic"

Miguel Ojeda (1):
      time: Fix references to _msecs_to_jiffies() handling of values

Mikhail Rudenko (1):
      regulator: rk808: Add apply_bit for BUCK3 on RK809

Mingwei Zheng (1):
      net: rfkill: gpio: Add check for clk_enable()

Miquel Raynal (1):
      mtd: rawnand: atmel: Fix possible memory leak

Muchun Song (1):
      block: fix ordering between checking BLK_MQ_S_STOPPED request adding

Mukesh Ojha (1):
      leds: class: Protect brightness_show() with led_cdev->led_access mutex

Nicolas Bouchinet (1):
      tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler

Nihar Chaithanya (1):
      jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree

Nobuhiro Iwamatsu (1):
      rtc: abx80x: Fix WDT bit position of the status register

Norbert van Bolhuis (1):
      wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()

Nuno Sa (2):
      dt-bindings: clock: axi-clkgen: include AXI clk
      clk: clk-axi-clkgen: make sure to enable the AXI bus clock

Ojaswin Mujoo (1):
      quota: flush quota_release_work upon quota writeback

Oleksandr Ocheretnyi (1):
      iTCO_wdt: mask NMI_NOW bit for update_no_reboot_bit() call

Oleksij Rempel (2):
      net: usb: lan78xx: Fix memory leak on device unplug by freeing PHY device
      net: usb: lan78xx: Fix refcounting and autosuspend on invalid WoL configuration

Oliver Neukum (2):
      usb: yurex: make waiting on yurex_write interruptible
      USB: chaoskey: fail open after removal

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: skip duplicated elements pending gc run

Pali Rohár (1):
      cifs: Fix buffer overflow when parsing NFS reparse points

Paolo Abeni (2):
      selftests: net: really check for bg process completion
      ipmr: fix tables suspicious RCU usage

Parker Newman (1):
      misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle

Paul Durrant (1):
      xen/xenbus: reference count registered modules

Pavan Chebbi (1):
      tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets

Pei Xiao (2):
      drm/sti: Add __iomem for mixer_dbg_mxn's parameter
      spi: mpc52xx: Add cancel_work_sync before module remove

Phil Sutter (1):
      netfilter: ipset: Hold module reference while requesting a module

Piyush Raj Chouhan (1):
      ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13

Prike Liang (1):
      drm/amdgpu: set the right AMDGPU sg segment limitation

Priyanka Singh (1):
      EDAC/fsl_ddr: Fix bad bit shift operations

Puranjay Mohan (1):
      nvme: fix metadata handling in nvme-passthrough

Qi Han (1):
      f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.

Qingfang Deng (1):
      jffs2: fix use of uninitialized variable

Qiu-ji Chen (3):
      ASoC: codecs: Fix atomicity violation in snd_soc_component_get_drvdata()
      media: wl128x: Fix atomicity violation in fmc_send_cmd()
      xen: Fix the issue of resource not being properly released in xenbus_dev_probe()

Quinn Tran (1):
      scsi: qla2xxx: Fix NVMe and NPIV connect issue

Richard Weinberger (1):
      jffs2: Fix rtime decompressor

Rohan Barar (1):
      media: cx231xx: Add support for Dexatek USB Video Grabber 1d19:6108

Rosen Penev (2):
      wifi: ath5k: add PCI ID for SX76X
      wifi: ath5k: add PCI ID for Arcadyan devices

Ryusuke Konishi (3):
      nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint
      nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint
      nilfs2: fix potential out-of-bounds memory access in nilfs_find_entry()

Sascha Hauer (3):
      ASoC: fsl_micfil: Drop unnecessary register read
      ASoC: fsl_micfil: do not define SHIFT/MASK for single bits
      ASoC: fsl_micfil: use GENMASK to define register bit fields

Saurav Kashyap (1):
      scsi: qla2xxx: Remove check req_sg_cnt should be equal to rsp_sg_cnt

Sean Christopherson (1):
      KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind CONFIG_BROKEN

SeongJae Park (2):
      xenbus/backend: Add memory pressure handler callback
      xenbus/backend: Protect xenbus callback with lock

Shengjiu Wang (2):
      ASoC: fsl_micfil: fix regmap_write_bits usage
      ASoC: fsl_micfil: fix the naming style for mask definition

Simon Horman (2):
      net: fec_mpc52xx_phy: Use %pa to format resource_size_t
      net: ethernet: fs_enet: Use %pa to format resource_size_t

Stanislaw Gruszka (1):
      spi: Fix acpi deferred irq probe

Steven Price (1):
      drm/panfrost: Remove unused id_mask from struct panfrost_model

Takashi Iwai (5):
      ALSA: us122l: Use snd_card_free_when_closed() at disconnection
      ALSA: caiaq: Use snd_card_free_when_closed() at disconnection
      ALSA: 6fire: Release resources at card release
      ALSA: hda/realtek: Apply quirk for Medion E15433
      ALSA: usb-audio: Fix out of bounds reads when finding clock sources

Tetsuo Handa (1):
      ocfs2: free inode when ocfs2_get_init_inode() fails

Thadeu Lima de Souza Cascardo (1):
      hfsplus: don't query the device logical block size multiple times

Theodore Ts'o (1):
      ext4: fix FS_IOC_GETFSMAP handling

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix checking for number of TRBs left

Thomas Gleixner (1):
      modpost: Add .irqentry.text to OTHER_SECTIONS

Thomas Richter (1):
      s390/cpum_sf: Handle CPU hotplug remove during sampling

Thomas Zimmermann (1):
      fbdev/sh7760fb: Alloc DMA memory from hardware device

Tiwei Bie (6):
      um: ubd: Do not use drvdata in release
      um: net: Do not use drvdata in release
      um: vector: Do not use drvdata in release
      um: Fix potential integer overflow during physmem setup
      um: Fix the return value of elf_core_copy_task_fpregs
      um: Always dump trace for specified task in show_stack

Tomi Valkeinen (1):
      drm/omap: Fix locking in omap_gem_new_dmabuf()

Trond Myklebust (2):
      NFSv4.0: Fix a use-after-free problem in the asynchronous open()
      SUNRPC: Replace internal use of SOCKWQ_ASYNC_NOSPACE

Tuong Lien (3):
      tipc: add reference counter to bearer
      tipc: enable creating a "preliminary" node
      tipc: add new AEAD key structure for user API

Ulf Hansson (1):
      mmc: core: Further prevent card detect during shutdown

Uros Bizjak (1):
      tracing: Use atomic64_inc_return() in trace_clock_counter()

Vasiliy Kovalev (1):
      ovl: Filter invalid inodes with missing lookup function

Vitalii Mordan (2):
      marvell: pxa168_eth: fix call balance of pep->clk handling routines
      usb: ehci-spear: fix call balance of sehci clk handling routines

Waiman Long (1):
      cgroup: Move rcu_head up near the top of cgroup_root

WangYuli (1):
      HID: wacom: fix when get product name maybe null pointer

Waqar Hameed (1):
      ubifs: authentication: Fix use-after-free in ubifs_tnc_end_commit

Wengang Wang (1):
      ocfs2: update seq_file index in ocfs2_dlm_seq_next

Will Deacon (1):
      arm64: tls: Fix context-switching of tpidrro_el0 when kpti is enabled

Xu Yang (1):
      usb: chipidea: udc: handle USB Error Interrupt if IOC not set

Yafang Shao (1):
      cgroup: Make operations on the cgroup root_list RCU safe

Yang Erkun (3):
      SUNRPC: make sure cache entry active before cache_show
      nfsd: make sure exp active before svc_export_show
      nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur

Yassine Oudjana (1):
      watchdog: mediatek: Make sure system reset gets asserted in mtk_wdt_restart()

Ye Bin (1):
      scsi: bfa: Fix use-after-free in bfad_im_module_exit()

Yi Yang (2):
      crypto: pcrypt - Call crypto layer directly when padata_do_parallel() return -EBUSY
      nvdimm: rectify the illogical code within nd_dax_probe()

Yongliang Gao (1):
      rtc: check if __rtc_read_time was successful in rtc_timer_do_work()

Yuan Can (4):
      firmware: google: Unregister driver_info on failure
      cpufreq: loongson2: Unregister platform_driver on failure
      dm thin: Add missing destroy_work_on_stack()
      igb: Fix potential invalid memory access in igb_init_module()

Yuan Chen (1):
      bpf: Fix the xdp_adjust_tail sample prog issue

Zeng Heng (1):
      scsi: fusion: Remove unused variable 'rc'

Zhang Changzhong (1):
      mfd: rt5033: Fix missing regmap_del_irq_chip()

Zhang Zekun (1):
      Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"

Zhen Lei (3):
      scsi: qedf: Fix a possible memory leak in qedf_alloc_and_init_sb()
      scsi: qedi: Fix a possible memory leak in qedi_alloc_and_init_sb()
      fbdev: sh7760fb: Fix a possible memory leak in sh7760fb_alloc_mem()

Zhihao Cheng (3):
      ubi: wl: Put source PEB into correct list if trying locking LEB failed
      ubifs: Correct the total block count by deducting journal reservation
      ubi: fastmap: Fix duplicate slab cache names while attaching

Zhu Jun (1):
      samples/bpf: Fix a resource leak

Zicheng Qu (1):
      ad7780: fix division by zero in ad7780_write_raw()

Zijian Zhang (4):
      bpf, sockmap: Several fixes to bpf_msg_push_data
      bpf, sockmap: Several fixes to bpf_msg_pop_data
      bpf, sockmap: Fix sk_msg_reset_curr
      tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg

chao liu (1):
      apparmor: fix 'Do simple duplicate message elimination'

guoweikang (1):
      ftrace: Fix regression with module command in stack_trace_filter

weiyufeng (1):
      PCI: cpqphp: Use PCI_POSSIBLE_ERROR() to check config reads


