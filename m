Return-Path: <stable+bounces-176617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27242B3A224
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FF43AE032
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A33128B5;
	Thu, 28 Aug 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wlyx5Ydt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F961C6BE;
	Thu, 28 Aug 2025 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391902; cv=none; b=DE47B0MQo8xjEliftQasi0R+XAu/AmNisqfYXV+8KK6OE9O+0YjtpVyKodi3q3t3TNZXEUF4qa7d+Ku2MnPkwVqXVCOaVWjfKv0dmJqu0ez3OosuHOPRM7Qf5vct4K5nQ6NRk/y+Qu1goLVuAC75MXoqwXQdE2zj0IHaH8xciXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391902; c=relaxed/simple;
	bh=wJL4ePToGg/PRjanozBTtk2bJIULj5yRkzqmo0ilI/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WJ1vSQ33XwMGdnu3Pe6MOia5QgBpkYt+iTXN4oAXXmKMlt5Bt210bfSVmW1naV7eRqE3Y7odOj8b1R1ZUhmn0Cstgs8n2W8LnuUXQV4Hb6NRwg8eG5BHwupqe0JqBb2QK8FWRJ+0C0LW7v+7fJZGctQAj6neYi7lGAYo3oGPP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wlyx5Ydt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F4C4CEF5;
	Thu, 28 Aug 2025 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756391901;
	bh=wJL4ePToGg/PRjanozBTtk2bJIULj5yRkzqmo0ilI/E=;
	h=From:To:Cc:Subject:Date:From;
	b=wlyx5Ydt60+zpyhQy9ZuCK909gDBruhjHuCqVjE+qsQZ1E5u2MLdev6WdzCAwDL2m
	 UNCzIXlGIqMZ7IYdnLVZJS7eTkYkxD73msm3Lwq7nPZNlTZIZ5ciGoc68Avtho7jFy
	 /0YCI59gVtheXxPcEu9kZ+uDnx1JQM1qSF6OwBF4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.297
Date: Thu, 28 Aug 2025 16:38:16 +0200
Message-ID: <2025082817-scrabble-skirmish-579f@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.297 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/firmware-guide/acpi/i2c-muxes.rst                  |    8 
 Makefile                                                         |    5 
 arch/arm/Makefile                                                |    2 
 arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts                     |    1 
 arch/arm/boot/dts/vfxxx.dtsi                                     |    2 
 arch/arm/mach-rockchip/platsmp.c                                 |   15 
 arch/arm/mach-tegra/reset.c                                      |    2 
 arch/arm64/include/asm/acpi.h                                    |    2 
 arch/m68k/Kconfig.debug                                          |    2 
 arch/m68k/kernel/early_printk.c                                  |   42 -
 arch/m68k/kernel/head.S                                          |   39 -
 arch/mips/Makefile                                               |    2 
 arch/mips/include/asm/vpe.h                                      |    8 
 arch/mips/kernel/process.c                                       |   16 
 arch/mips/mm/tlb-r4k.c                                           |   56 +
 arch/parisc/Makefile                                             |    2 
 arch/powerpc/configs/ppc6xx_defconfig                            |    1 
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c                    |    6 
 arch/s390/hypfs/hypfs_dbfs.c                                     |   19 
 arch/s390/include/asm/timex.h                                    |   13 
 arch/s390/kernel/time.c                                          |    2 
 arch/x86/kernel/cpu/mce/amd.c                                    |   13 
 arch/x86/mm/extable.c                                            |    5 
 drivers/acpi/acpi_processor.c                                    |    2 
 drivers/acpi/apei/ghes.c                                         |    2 
 drivers/acpi/processor_idle.c                                    |    4 
 drivers/acpi/processor_perflib.c                                 |   11 
 drivers/ata/Kconfig                                              |   35 -
 drivers/ata/libata-scsi.c                                        |   20 
 drivers/base/power/domain_governor.c                             |   18 
 drivers/base/power/runtime.c                                     |    5 
 drivers/block/drbd/drbd_receiver.c                               |    6 
 drivers/block/sunvdc.c                                           |    4 
 drivers/char/hw_random/mtk-rng.c                                 |    4 
 drivers/char/ipmi/ipmi_msghandler.c                              |    8 
 drivers/char/ipmi/ipmi_watchdog.c                                |   59 +-
 drivers/clk/davinci/psc.c                                        |    5 
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c                             |    3 
 drivers/cpufreq/armada-8k-cpufreq.c                              |    2 
 drivers/cpufreq/cpufreq.c                                        |   11 
 drivers/crypto/ccp/ccp-debugfs.c                                 |    3 
 drivers/crypto/img-hash.c                                        |    2 
 drivers/crypto/marvell/cipher.c                                  |    4 
 drivers/crypto/marvell/hash.c                                    |    5 
 drivers/crypto/qat/qat_common/adf_transport_debug.c              |    4 
 drivers/dma/mv_xor.c                                             |   21 
 drivers/dma/nbpfaxi.c                                            |   24 
 drivers/fpga/zynq-fpga.c                                         |   10 
 drivers/gpio/gpio-tps65912.c                                     |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                          |    4 
 drivers/gpu/drm/amd/display/dc/bios/command_table.c              |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c   |   30 -
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c                 |    2 
 drivers/gpu/drm/drm_dp_helper.c                                  |    2 
 drivers/gpu/drm/scheduler/sched_entity.c                         |   23 
 drivers/hid/hid-core.c                                           |   19 
 drivers/i2c/busses/i2c-qup.c                                     |    4 
 drivers/i2c/busses/i2c-stm32.c                                   |    8 
 drivers/i2c/busses/i2c-stm32f7.c                                 |    4 
 drivers/i3c/internals.h                                          |    1 
 drivers/i3c/master.c                                             |    2 
 drivers/iio/adc/max1363.c                                        |   43 -
 drivers/iio/adc/stm32-adc-core.c                                 |    7 
 drivers/iio/light/hid-sensor-prox.c                              |    3 
 drivers/iio/proximity/isl29501.c                                 |   16 
 drivers/infiniband/core/cache.c                                  |    4 
 drivers/infiniband/hw/hfi1/affinity.c                            |   44 -
 drivers/input/joystick/xpad.c                                    |    2 
 drivers/media/dvb-frontends/dib7000p.c                           |    8 
 drivers/media/i2c/ov2659.c                                       |    3 
 drivers/media/i2c/tc358743.c                                     |   86 +-
 drivers/media/platform/qcom/camss/camss.c                        |    4 
 drivers/media/platform/qcom/venus/core.c                         |    8 
 drivers/media/platform/qcom/venus/core.h                         |    2 
 drivers/media/platform/qcom/venus/hfi_venus.c                    |    5 
 drivers/media/platform/qcom/venus/vdec.c                         |    5 
 drivers/media/usb/gspca/vicam.c                                  |   10 
 drivers/media/usb/hdpvr/hdpvr-i2c.c                              |    6 
 drivers/media/usb/rainshadow-cec/rainshadow-cec.c                |    3 
 drivers/media/usb/usbtv/usbtv-video.c                            |    4 
 drivers/media/usb/uvc/uvc_driver.c                               |    3 
 drivers/media/usb/uvc/uvc_video.c                                |   21 
 drivers/media/v4l2-core/v4l2-ctrls.c                             |   37 +
 drivers/memstick/core/memstick.c                                 |    3 
 drivers/memstick/host/rtsx_usb_ms.c                              |    1 
 drivers/misc/cardreader/rtsx_usb.c                               |   16 
 drivers/mmc/host/bcm2835.c                                       |    3 
 drivers/mmc/host/rtsx_usb_sdmmc.c                                |    4 
 drivers/mmc/host/sdhci-pci-core.c                                |    3 
 drivers/mmc/host/sdhci_am654.c                                   |    9 
 drivers/mtd/ftl.c                                                |    2 
 drivers/mtd/nand/raw/atmel/nand-controller.c                     |    2 
 drivers/mtd/nand/raw/atmel/pmecc.c                               |    6 
 drivers/mtd/nand/raw/fsmc_nand.c                                 |    2 
 drivers/net/can/kvaser_pciefd.c                                  |    1 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c                 |    1 
 drivers/net/dsa/b53/b53_common.c                                 |   33 -
 drivers/net/dsa/b53/b53_regs.h                                   |    1 
 drivers/net/ethernet/agere/et131x.c                              |   36 +
 drivers/net/ethernet/atheros/ag71xx.c                            |    9 
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c                |    4 
 drivers/net/ethernet/emulex/benet/be_cmds.c                      |    2 
 drivers/net/ethernet/emulex/benet/be_main.c                      |    8 
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c               |    4 
 drivers/net/ethernet/freescale/fec_main.c                        |   34 -
 drivers/net/ethernet/freescale/gianfar_ethtool.c                 |    4 
 drivers/net/ethernet/intel/fm10k/fm10k.h                         |    3 
 drivers/net/ethernet/intel/i40e/i40e.h                           |    2 
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c                   |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe.h                         |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c                     |    4 
 drivers/net/ethernet/xilinx/xilinx_emaclite.c                    |    2 
 drivers/net/phy/smsc.c                                           |    1 
 drivers/net/ppp/pptp.c                                           |   18 
 drivers/net/usb/sierra_net.c                                     |    4 
 drivers/net/usb/usbnet.c                                         |   11 
 drivers/net/virtio_net.c                                         |   38 +
 drivers/net/vrf.c                                                |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c      |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c   |    2 
 drivers/net/wireless/intel/iwlegacy/4965-mac.c                   |    5 
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                    |   11 
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c                      |    2 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                      |    7 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                     |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                    |    2 
 drivers/net/wireless/marvell/mwl8k.c                             |    4 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c               |    3 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c            |    2 
 drivers/net/wireless/realtek/rtlwifi/pci.c                       |   18 
 drivers/pci/controller/pcie-rockchip-host.c                      |    2 
 drivers/pci/endpoint/pci-ep-cfs.c                                |    1 
 drivers/pci/endpoint/pci-epf-core.c                              |    2 
 drivers/pci/hotplug/pnv_php.c                                    |   90 ++-
 drivers/pci/pci-acpi.c                                           |    4 
 drivers/pci/pci.c                                                |    8 
 drivers/pci/probe.c                                              |    2 
 drivers/pinctrl/stm32/pinctrl-stm32.c                            |    1 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                            |   11 
 drivers/platform/x86/thinkpad_acpi.c                             |    4 
 drivers/power/supply/bq24190_charger.c                           |   60 --
 drivers/power/supply/max14577_charger.c                          |    4 
 drivers/pps/pps.c                                                |   11 
 drivers/pwm/pwm-imx-tpm.c                                        |    9 
 drivers/pwm/pwm-mediatek.c                                       |   78 +-
 drivers/regulator/core.c                                         |    1 
 drivers/rtc/rtc-ds1307.c                                         |   17 
 drivers/rtc/rtc-hym8563.c                                        |    2 
 drivers/rtc/rtc-pcf8563.c                                        |    2 
 drivers/scsi/aacraid/comminit.c                                  |    3 
 drivers/scsi/bfa/bfad_im.c                                       |    1 
 drivers/scsi/ibmvscsi_tgt/libsrp.c                               |    6 
 drivers/scsi/isci/request.c                                      |    2 
 drivers/scsi/libiscsi.c                                          |    3 
 drivers/scsi/lpfc/lpfc_debugfs.c                                 |    1 
 drivers/scsi/lpfc/lpfc_scsi.c                                    |    4 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                             |   19 
 drivers/scsi/mvsas/mv_sas.c                                      |    4 
 drivers/scsi/qla4xxx/ql4_os.c                                    |    2 
 drivers/scsi/scsi_scan.c                                         |    2 
 drivers/scsi/scsi_transport_sas.c                                |   60 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c                            |   13 
 drivers/soc/qcom/mdt_loader.c                                    |   41 +
 drivers/soc/tegra/pmc.c                                          |   51 -
 drivers/soundwire/stream.c                                       |    2 
 drivers/staging/comedi/comedi_compat32.c                         |    3 
 drivers/staging/comedi/comedi_fops.c                             |   58 +
 drivers/staging/comedi/comedi_internal.h                         |    1 
 drivers/staging/comedi/drivers.c                                 |   30 -
 drivers/staging/comedi/drivers/aio_iiro_16.c                     |    3 
 drivers/staging/comedi/drivers/comedi_test.c                     |    2 
 drivers/staging/comedi/drivers/das16m1.c                         |    3 
 drivers/staging/comedi/drivers/das6402.c                         |    3 
 drivers/staging/comedi/drivers/pcl812.c                          |    3 
 drivers/staging/fbtft/fbtft-core.c                               |    1 
 drivers/staging/media/imx/imx-media-csc-scaler.c                 |    2 
 drivers/staging/nvec/nvec_power.c                                |    2 
 drivers/thermal/thermal_sysfs.c                                  |    9 
 drivers/thunderbolt/domain.c                                     |    2 
 drivers/tty/serial/8250/8250_port.c                              |    3 
 drivers/tty/serial/pch_uart.c                                    |    2 
 drivers/tty/vt/defkeymap.c_shipped                               |  112 +++
 drivers/tty/vt/keyboard.c                                        |    2 
 drivers/usb/atm/cxacru.c                                         |  106 +--
 drivers/usb/chipidea/ci.h                                        |   18 
 drivers/usb/chipidea/udc.c                                       |   89 +--
 drivers/usb/class/cdc-acm.c                                      |   13 
 drivers/usb/core/hub.c                                           |   67 ++
 drivers/usb/core/quirks.c                                        |    1 
 drivers/usb/core/urb.c                                           |    2 
 drivers/usb/dwc3/dwc3-meson-g12a.c                               |    3 
 drivers/usb/dwc3/dwc3-qcom.c                                     |    8 
 drivers/usb/dwc3/gadget.c                                        |    9 
 drivers/usb/early/xhci-dbc.c                                     |    4 
 drivers/usb/gadget/composite.c                                   |    5 
 drivers/usb/gadget/configfs.c                                    |    2 
 drivers/usb/gadget/udc/renesas_usb3.c                            |    1 
 drivers/usb/host/xhci-hub.c                                      |    3 
 drivers/usb/host/xhci-mem.c                                      |   24 
 drivers/usb/host/xhci-plat.c                                     |    3 
 drivers/usb/host/xhci-ring.c                                     |   19 
 drivers/usb/host/xhci.c                                          |   24 
 drivers/usb/host/xhci.h                                          |    3 
 drivers/usb/musb/musb_gadget.c                                   |    2 
 drivers/usb/musb/omap2430.c                                      |   10 
 drivers/usb/phy/phy-mxs-usb.c                                    |    4 
 drivers/usb/serial/ftdi_sio.c                                    |    2 
 drivers/usb/serial/ftdi_sio_ids.h                                |    3 
 drivers/usb/serial/option.c                                      |    7 
 drivers/usb/storage/realtek_cr.c                                 |    2 
 drivers/usb/storage/unusual_devs.h                               |   29 
 drivers/usb/typec/tcpm/fusb302.c                                 |    8 
 drivers/vhost/vhost.c                                            |    3 
 drivers/video/console/vgacon.c                                   |    2 
 drivers/video/fbdev/imxfb.c                                      |    9 
 drivers/watchdog/dw_wdt.c                                        |    2 
 drivers/watchdog/ziirave_wdt.c                                   |    3 
 fs/btrfs/tree-log.c                                              |   53 +
 fs/buffer.c                                                      |    2 
 fs/cifs/cifsglob.h                                               |    1 
 fs/cifs/cifssmb.c                                                |   10 
 fs/cifs/smbdirect.c                                              |   14 
 fs/cifs/transport.c                                              |   34 -
 fs/ext4/fsmap.c                                                  |   23 
 fs/ext4/inline.c                                                 |   19 
 fs/ext4/inode.c                                                  |    2 
 fs/f2fs/f2fs.h                                                   |    2 
 fs/f2fs/inode.c                                                  |   28 
 fs/f2fs/node.c                                                   |   10 
 fs/file.c                                                        |   81 +-
 fs/hfs/bnode.c                                                   |   93 +++
 fs/hfsplus/bnode.c                                               |   92 +++
 fs/hfsplus/extents.c                                             |    3 
 fs/hfsplus/unicode.c                                             |    7 
 fs/hfsplus/xattr.c                                               |    6 
 fs/hugetlbfs/inode.c                                             |    2 
 fs/isofs/inode.c                                                 |    9 
 fs/jbd2/checkpoint.c                                             |    1 
 fs/jfs/file.c                                                    |    3 
 fs/jfs/inode.c                                                   |    2 
 fs/jfs/jfs_dmap.c                                                |   10 
 fs/namespace.c                                                   |   89 ++-
 fs/nfs/blocklayout/blocklayout.c                                 |    4 
 fs/nfs/blocklayout/dev.c                                         |    5 
 fs/nfs/blocklayout/extent_tree.c                                 |   20 
 fs/nfs/client.c                                                  |   44 +
 fs/nfs/direct.c                                                  |   13 
 fs/nfs/export.c                                                  |   11 
 fs/nfs/inode.c                                                   |    6 
 fs/nfs/internal.h                                                |    1 
 fs/nfs/nfs4client.c                                              |   13 
 fs/nfs/nfs4proc.c                                                |   35 -
 fs/nfs/pnfs.c                                                    |   11 
 fs/nfs/write.c                                                   |   11 
 fs/nfsd/nfs4state.c                                              |   34 -
 fs/nilfs2/inode.c                                                |    9 
 fs/orangefs/orangefs-debugfs.c                                   |    8 
 fs/squashfs/super.c                                              |   14 
 fs/udf/super.c                                                   |   13 
 include/linux/fs.h                                               |    4 
 include/linux/if_vlan.h                                          |    6 
 include/linux/mm.h                                               |   26 
 include/linux/moduleparam.h                                      |    5 
 include/linux/nfs_fs.h                                           |    2 
 include/linux/pci.h                                              |    1 
 include/linux/pps_kernel.h                                       |    1 
 include/linux/skbuff.h                                           |   31 +
 include/linux/usb/chipidea.h                                     |    1 
 include/linux/usb/usbnet.h                                       |    1 
 include/net/act_api.h                                            |   25 
 include/net/cfg80211.h                                           |    2 
 include/net/sch_generic.h                                        |   13 
 include/net/udp.h                                                |   24 
 include/uapi/linux/in6.h                                         |    4 
 include/uapi/linux/io_uring.h                                    |    2 
 include/uapi/linux/mount.h                                       |    3 
 kernel/events/core.c                                             |   20 
 kernel/fork.c                                                    |    2 
 kernel/power/console.c                                           |    7 
 kernel/rcu/tree_plugin.h                                         |    3 
 kernel/trace/ftrace.c                                            |   19 
 kernel/trace/trace_events.c                                      |    5 
 mm/filemap.c                                                     |    2 
 mm/hmm.c                                                         |    2 
 mm/kmemleak.c                                                    |  120 ++--
 mm/madvise.c                                                     |    2 
 mm/mmap.c                                                        |   26 
 mm/shmem.c                                                       |    2 
 mm/zsmalloc.c                                                    |    6 
 net/8021q/vlan.c                                                 |   42 +
 net/8021q/vlan.h                                                 |    1 
 net/appletalk/aarp.c                                             |   42 +
 net/appletalk/ddp.c                                              |    7 
 net/bluetooth/hci_sysfs.c                                        |   15 
 net/bluetooth/l2cap_core.c                                       |   26 
 net/bluetooth/l2cap_sock.c                                       |    3 
 net/bluetooth/smp.c                                              |   21 
 net/bluetooth/smp.h                                              |    1 
 net/caif/cfctrl.c                                                |  294 ++++------
 net/core/filter.c                                                |    3 
 net/core/netpoll.c                                               |    7 
 net/ipv4/route.c                                                 |    1 
 net/ipv4/tcp_input.c                                             |    3 
 net/ipv4/udp_offload.c                                           |    2 
 net/ipv6/ip6_offload.c                                           |    4 
 net/ipv6/seg6_hmac.c                                             |    3 
 net/mac80211/tx.c                                                |    1 
 net/ncsi/internal.h                                              |    2 
 net/ncsi/ncsi-rsp.c                                              |    1 
 net/netfilter/nf_conntrack_netlink.c                             |   24 
 net/netfilter/nf_tables_api.c                                    |    4 
 net/netfilter/xt_nfacct.c                                        |    4 
 net/netlink/af_netlink.c                                         |    2 
 net/packet/af_packet.c                                           |   39 -
 net/phonet/pep.c                                                 |    2 
 net/sched/act_api.c                                              |   14 
 net/sched/act_csum.c                                             |    4 
 net/sched/act_ct.c                                               |   10 
 net/sched/act_gact.c                                             |   14 
 net/sched/act_mirred.c                                           |   55 +
 net/sched/act_police.c                                           |    5 
 net/sched/act_tunnel_key.c                                       |    2 
 net/sched/act_vlan.c                                             |    9 
 net/sched/sch_cake.c                                             |   14 
 net/sched/sch_codel.c                                            |    5 
 net/sched/sch_drr.c                                              |    7 
 net/sched/sch_fq_codel.c                                         |    6 
 net/sched/sch_hfsc.c                                             |    8 
 net/sched/sch_htb.c                                              |    6 
 net/sched/sch_netem.c                                            |   40 +
 net/sched/sch_qfq.c                                              |   40 -
 net/sched/sch_sfq.c                                              |  114 ++-
 net/sctp/input.c                                                 |    2 
 net/tls/tls_sw.c                                                 |   13 
 net/vmw_vsock/af_vsock.c                                         |    3 
 net/wireless/mlme.c                                              |    3 
 samples/mei/mei-amt-version.c                                    |    2 
 scripts/Kbuild.include                                           |    8 
 scripts/kconfig/gconf.c                                          |    8 
 scripts/kconfig/lxdialog/inputbox.c                              |    6 
 scripts/kconfig/lxdialog/menubox.c                               |    2 
 scripts/kconfig/nconf.c                                          |    2 
 scripts/kconfig/nconf.gui.c                                      |    1 
 security/inode.c                                                 |    2 
 sound/pci/hda/patch_ca0132.c                                     |    2 
 sound/pci/hda/patch_hdmi.c                                       |   19 
 sound/pci/intel8x0.c                                             |    2 
 sound/soc/codecs/hdac_hdmi.c                                     |   10 
 sound/soc/codecs/rt5640.c                                        |    5 
 sound/soc/fsl/fsl_sai.c                                          |   14 
 sound/soc/intel/boards/Kconfig                                   |    2 
 sound/soc/soc-dapm.c                                             |    4 
 sound/soc/soc-ops.c                                              |   26 
 sound/usb/mixer_quirks.c                                         |   14 
 sound/usb/mixer_scarlett_gen2.c                                  |    9 
 sound/usb/stream.c                                               |   25 
 sound/usb/validate.c                                             |   14 
 tools/bpf/bpftool/net.c                                          |   15 
 tools/perf/tests/bp_account.c                                    |    1 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c          |    4 
 tools/testing/ktest/ktest.pl                                     |    5 
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc |    2 
 tools/testing/selftests/futex/include/futextest.h                |   11 
 tools/testing/selftests/net/forwarding/tc_actions.sh             |   72 ++
 tools/testing/selftests/net/rtnetlink.sh                         |    6 
 365 files changed, 3516 insertions(+), 1487 deletions(-)

Aaron Kling (1):
      ARM: tegra: Use I/O memcpy to write to IRAM

Abdun Nihaal (1):
      staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()

Al Viro (3):
      securityfs: don't pin dentries twice, once is enough...
      use uniform permission checks for all mount propagation changes
      alloc_fdtable(): change calling conventions.

Alessandro Carminati (1):
      regulator: core: fix NULL dereference on unbind due to stale coupling data

Alex Guo (2):
      media: dvb-frontends: dib7090p: fix null-ptr-deref in dib7090p_rw_on_apb()
      media: dvb-frontends: w7090p: fix null-ptr-deref in w7090p_tuner_write_serpar and w7090p_tuner_read_serpar

Alexander Kochetkov (1):
      ARM: rockchip: fix kernel hang during smp initialization

Alok Tiwari (5):
      net: emaclite: Fix missing pointer increment in aligned_read()
      staging: nvec: Fix incorrect null termination of battery manufacturer
      ALSA: intel8x0: Fix incorrect codec index usage in mixer for ICH4
      be2net: Use correct byte order and format string for TCP seq and ack_seq
      net: thunderx: Fix format-truncation warning in bgx_acpi_match_id()

Amir Mohammad Jahangirzad (1):
      fs/orangefs: use snprintf() instead of sprintf()

Ammar Faizi (1):
      net: usbnet: Fix the wrong netif_carrier_on() call

Andreas Dilger (1):
      ext4: check fast symlink for ea_inode correctly

Andrew Jeffery (2):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled

Andrew Lunn (1):
      net: appletalk: fix kerneldoc warnings

Andy Shevchenko (2):
      Documentation: ACPI: Fix parent device references
      mm/hmm: move pmd_to_hmm_pfn_flags() to the respective #ifdeffery

Annette Kobou (1):
      ARM: dts: imx6ul-kontron-bl-common: Fix RTS polarity for RS485 interface

Arnaud Lecomte (1):
      jfs: upper bound check of tree index in dbAllocAG

Arnd Bergmann (4):
      ethernet: intel: fix building with large NR_CPUS
      ASoC: Intel: fix SND_SOC_SOF dependencies
      ASoC: ops: dynamically allocate struct snd_ctl_elem_value
      caif: reduce stack size, again

Arun Raghavan (1):
      ASoC: fsl_sai: Force a software reset when starting in consumer mode

Avraham Stern (1):
      wifi: iwlwifi: mvm: fix scan request validation

Balamanikandan Gunasundar (1):
      mtd: rawnand: atmel: set pmecc data setup time

Baokun Li (1):
      jbd2: prevent softlockup in jbd2_log_do_checkpoint()

Bard Liao (1):
      soundwire: stream: restore params when prepare ports fail

Bartosz Golaszewski (1):
      gpio: tps65912: check the return value of regmap_update_bits()

Benjamin Tissoires (3):
      HID: core: ensure the allocated report buffer can contain the reserved report ID
      HID: core: ensure __hid_request reserves the report ID as the first byte
      HID: core: do not bypass hid_hw_raw_request

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Ensure we don't read past the ELF header

Brahmajit Das (1):
      samples: mei: Fix building on musl libc

Breno Leitao (3):
      ACPI: APEI: GHES: add TAINT_MACHINE_CHECK on GHES panic path
      ipmi: Use dev_warn_ratelimited() for incorrect message warnings
      mm/kmemleak: avoid deadlock by moving pr_warn() outside kmemleak_lock

Brian Masney (3):
      rtc: ds1307: fix incorrect maximum clock rate handling
      rtc: hym8563: fix incorrect maximum clock rate handling
      rtc: pcf8563: fix incorrect maximum clock rate handling

Buday Csaba (1):
      net: phy: smsc: add proper reset flags for LAN8710A

Budimir Markovic (1):
      vsock: Do not allow binding to VMADDR_PORT_ANY

Bui Quang Minh (1):
      virtio-net: ensure the received length does not exceed allocated size

Chao Yu (5):
      f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
      f2fs: fix to avoid panic in f2fs_evict_inode
      f2fs: fix to avoid out-of-boundary access in devs.path
      f2fs: fix to do sanity check on ino and xnid
      f2fs: fix to avoid out-of-boundary access in dnode page

Charles Han (1):
      power: supply: max14577: Handle NULL pdata when CONFIG_OF is not set

Cheick Traore (1):
      pinctrl: stm32: Manage irq affinity settings

Chen Ni (1):
      iio: adc: stm32-adc: Fix race in installing chained IRQ handler

Chenyuan Yang (1):
      fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref

Clément Le Goffic (1):
      i2c: stm32: fix the device used for the DMA map

Cong Wang (4):
      sch_drr: make drr_qlen_notify() idempotent
      sch_hfsc: make hfsc_qlen_notify() idempotent
      sch_qfq: make qfq_qlen_notify() idempotent
      codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()

Corey Minyard (1):
      ipmi: Fix strcpy source and destination the same

Cristian Ciocaltea (1):
      ALSA: usb-audio: Avoid precedence issues in mixer_quirks macros

Cynthia Huang (1):
      selftests/futex: Define SYS_futex on 32-bit architectures with 64-bit time_t

Dai Ngo (1):
      NFSD: detect mismatch of file handle and delegation stateid in OPEN op

Damien Le Moal (5):
      scsi: mpt3sas: Correctly handle ATA device errors
      ata: libata-scsi: Fix ata_to_sense_error() status handling
      PCI: endpoint: Fix configfs group list head handling
      PCI: endpoint: Fix configfs group removal on driver teardown
      ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig

Dan Carpenter (7):
      dmaengine: nbpfaxi: Fix memory corruption in probe()
      watchdog: ziirave_wdt: check record length in ziirave_firm_verify()
      fs/orangefs: Allow 2 more characters in do_c_string()
      cpufreq: armada-8k: Fix off by one in armada_8k_cpufreq_free_table()
      media: gspca: Add bounds checking to firmware parser
      scsi: qla4xxx: Prevent a potential error pointer dereference
      ALSA: usb-audio: Fix size validation in convert_chmap_v3()

Daniel Dadap (1):
      ALSA: hda: Add missing NVIDIA HDA codec IDs

Daniil Dulov (1):
      wifi: rtl818x: Kill URBs before clearing tx status queue

Dave Hansen (1):
      x86/fpu: Delay instruction pointer fixup until after warning

Dave Stevenson (3):
      media: tc358743: Check I2C succeeded during probe
      media: tc358743: Return an appropriate colorspace from tc358743_set_fmt
      media: tc358743: Increase FIFO trigger level to 374

David Lechner (1):
      iio: proximity: isl29501: fix buffered read on big-endian systems

Davide Caratti (2):
      net/sched: act_mirred: better wording on protection against excessive stack growth
      act_mirred: use the backlog for nested calls to mirred ingress

Denis OSTERLAND-HEIM (1):
      pps: fix poll support

Dinghao Liu (1):
      power: supply: bq24190_charger: Fix runtime PM imbalance on error

Dmitry Antipov (1):
      Bluetooth: fix use-after-free in device_for_each_child()

Dong Chenchen (1):
      net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during runtime

Drew Hamilton (1):
      usb: musb: fix gadget state on disconnect

Edson Juliano Drosdeck (1):
      mmc: sdhci-pci: Quirk for broken command queuing on Intel GLK-based Positivo models

Edward Adam Davis (1):
      jfs: Regular file corruption check

Eric Biggers (1):
      thunderbolt: Fix copy+paste error in match_service_id()

Eric Dumazet (6):
      net_sched: sch_sfq: annotate data-races around q->perturb_period
      net_sched: sch_sfq: handle bigger packets
      net_sched: sch_sfq: reject invalid perturb period
      pptp: ensure minimal skb length in pptp_xmit()
      ipv6: reject malicious packets in ipv6_gso_segment()
      pptp: fix pptp_xmit() error path

Fabio Estevam (2):
      iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
      iio: adc: max1363: Reorder mode_list[] entries

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition

Fedor Pchelkin (3):
      drm/amd/pm/powerplay/hwmgr/smu_helper: fix order of mask and value
      netfilter: nf_tables: adjust lockdep assertions handling
      netlink: avoid infinite retry looping in netlink_unicast()

Filipe Manana (1):
      btrfs: fix log tree replay failure due to file with 0 links and extents

Finn Thain (2):
      m68k: Don't unregister boot console needlessly
      m68k: Fix lost column on framebuffer debug console

Florian Westphal (2):
      netfilter: xt_nfacct: don't assume acct name is null-terminated
      netfilter: ctnetlink: fix refcount leak on table dump

Frederic Barrat (2):
      pci/hotplug/pnv-php: Improve error msg on power state change failure
      pci/hotplug/pnv-php: Wrap warnings in macro

Gal Pressman (1):
      net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs

Gautham R. Shenoy (1):
      pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_stop()

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()

Giovanni Cabiddu (1):
      crypto: qat - fix seq_file position update in adf_ring_next()

Gokul Sivakumar (1):
      wifi: brcmfmac: fix P2P discovery failure in P2P peer due to missing P2P IE

Greg Kroah-Hartman (2):
      Revert "vmci: Prevent the dispatching of uninitialized payloads"
      Linux 5.4.297

Gui-Dong Han (1):
      media: rainshadow-cec: fix TOCTOU race condition in rain_interrupt()

Hans Verkuil (1):
      media: v4l2-ctrls: always copy the controls on completion

Hans Zhang (1):
      PCI: rockchip-host: Fix "Unexpected Completion" log message

Haoxiang Li (2):
      media: imx: fix a potential memory leak in imx_media_csc_scaler_device_init()
      ice: Fix a null pointer dereference in ice_copy_and_init_pkg()

Hari Kalavakunta (1):
      net: ncsi: Fix buffer overflow in fetching version id

Harry Yoo (1):
      mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n

He Zhe (1):
      mm/kmemleak: turn kmemleak_lock and object->lock to raw_spinlock_t

Helge Deller (1):
      Revert "vgacon: Add check for vc_origin address range in vgacon_scroll()"

Henry Martin (1):
      clk: davinci: Add NULL check in davinci_lpsc_clk_register()

Herbert Xu (1):
      crypto: marvell/cesa - Fix engine load inaccuracy

Hongyu Xie (1):
      xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS

Hsin-Te Yuan (1):
      thermal: sysfs: Return ENODATA instead of EAGAIN for reads

Ian Abbott (10):
      comedi: pcl812: Fix bit shift out of bounds
      comedi: aio_iiro_16: Fix bit shift out of bounds
      comedi: das16m1: Fix bit shift out of bounds
      comedi: das6402: Fix bit shift out of bounds
      comedi: Fix some signed shift left operations
      comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
      comedi: comedi_test: Fix possible deletion of uninitialized timers
      comedi: fix race between polling and detaching
      comedi: Fix initialization of data for instructions that write to subdevice
      comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large

Ilan Peer (1):
      wifi: cfg80211: Fix interface type validation

Imre Deak (1):
      drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS

Ivan Stepchenko (1):
      mtd: fix possible integer overflow in erase_xfer()

Jack Xiao (1):
      drm/amdgpu: fix incorrect vm flags to map bo

Jakub Kicinski (2):
      netpoll: prevent hanging NAPI when netcons gets enabled
      uapi: in6: restore visibility of most IPv6 socket options

Jan Kara (2):
      isofs: Verify inode mode when loading from disk
      udf: Verify partition map count

Jason Wang (1):
      vhost: fail early when __vhost_add_used() fails

Jason Xing (1):
      ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc

Jay Chen (1):
      usb: xhci: Set avg_trb_len = 8 for EP0 during Address Device Command

Jeff Layton (1):
      nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()

Jiasheng Jiang (2):
      iwlwifi: Add missing check for alloc_ordered_workqueue
      scsi: lpfc: Remove redundant assignment to avoid memory leak

Jiaxun Yang (1):
      MIPS: mm: tlb-r4k: Uniquify TLB entries on init

Jiayi Li (2):
      ACPI: processor: perflib: Fix initial _PPC limit application
      memstick: Fix deadlock by moving removing flag earlier

Jiayuan Chen (1):
      bpf, ktls: Fix data corruption when using bpf_msg_pop_data() in ktls

Jimmy Assarsson (2):
      can: kvaser_pciefd: Store device channel index
      can: kvaser_usb: Assign netdev.dev_port based on device channel index

Jiri Pirko (1):
      selftests: forwarding: tc_actions.sh: add matchall mirror test

Johan Hovold (6):
      net: gianfar: fix device leak when querying time stamp info
      net: dpaa: fix device leak when querying time stamp info
      usb: gadget: udc: renesas_usb3: fix device leak at unbind
      usb: dwc3: meson-g12a: fix device leaks at unbind
      USB: cdc-acm: do not log successful probe on later errors
      usb: musb: omap2430: fix device leak at unbind

Johan Korsnes (1):
      arch: powerpc: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX

Johannes Berg (1):
      wifi: cfg80211: reject HTC bit for management frames

John Ernberg (1):
      net: usbnet: Avoid potential RCU stall on LINK_CHANGE event

John Garry (1):
      scsi: aacraid: Stop using PCI_IRQ_AFFINITY

Jon Hunter (1):
      soc/tegra: pmc: Ensure power-domains are in a known state

Jonas Rebmann (1):
      net: fec: allow disable coalescing

Jorge Ramirez-Ortiz (2):
      media: venus: protect against spurious interrupts during probe
      media: venus: hfi: explicitly release IRQ during teardown

Josef Bacik (1):
      nfs: fix UAF in direct writes

Judith Mendez (1):
      mmc: sdhci_am654: Workaround for Errata i2312

Jun Li (1):
      usb: chipidea: udc: protect usb interrupt enable

Justin Tee (1):
      scsi: lpfc: Check for hdwq null ptr when cleaning up lpfc_vport structure

Kees Cook (2):
      arm64: Handle KCOV __init vs inline mismatches
      platform/x86: thinkpad_acpi: Handle KCOV __init vs inline mismatches

Kito Xu (veritas501) (1):
      net: appletalk: Fix use-after-free in AARP proxy probe

Krishna Kurapati (1):
      usb: dwc3: qcom: Don't leave BCR asserted

Krzysztof Kozlowski (1):
      ARM: dts: vfxxx: Correctly use two tuples for timer address

Kuen-Han Tsai (1):
      usb: dwc3: Ignore late xferNotReady event to prevent halt timeout

Kuninori Morimoto (1):
      ASoC: soc-dapm: set bias_level if snd_soc_dapm_set_bias_level() was successed

Kuniyuki Iwashima (1):
      Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()

Laurentiu Mihalcea (1):
      pwm: imx-tpm: Reset counter if CMOD is 0

Leo Yan (1):
      perf tests bp_account: Fix leaked file descriptor

Li Zhong (1):
      ACPI: processor: idle: Check acpi_fetch_acpi_dev() return value

Lifeng Zheng (2):
      cpufreq: Init policy->rwsem before it may be possibly used
      cpufreq: Exit governor when failed to start old governor

Lin.Cao (1):
      drm/sched: Remove optimization that causes hang when killing dependent jobs

Lizhi Xu (2):
      vmci: Prevent the dispatching of uninitialized payloads
      jfs: truncate good inode pages when hard link is 0

Lorenzo Stoakes (3):
      mm: drop the assumption that VM_SHARED always implies writable
      mm: update memfd seal write check to include F_SEAL_WRITE
      mm: perform the mapping_map_writable() check after call_mmap()

Lucas De Marchi (1):
      usb: early: xhci-dbc: Fix early_ioremap leak

Lucy Thrun (1):
      ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control

Ludwig Disterhof (1):
      media: usbtv: Lock resolution while streaming

Luiz Augusto von Dentz (3):
      Bluetooth: SMP: If an unallowed command is received consider it a failure
      Bluetooth: SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
      Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU

Lukas Wunner (1):
      PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports

Ma Ke (1):
      sunvdc: Balance device refcount in vdc_port_mpgroup_check

Mael GUERIN (1):
      USB: storage: Add unusual-devs entry for Novatek NTK96550-based camera

Maor Gottlieb (1):
      RDMA/core: Rate limit GID cache warning messages

Marek Szyprowski (1):
      zynq_fpga: use sgtable-based scatterlist wrappers

Mario Limonciello (2):
      usb: xhci: Avoid showing warnings for dying controller
      usb: xhci: Avoid showing errors during surprise removal

Mark Brown (1):
      ASoC: hdac_hdmi: Rate limit logging on connection and disconnection

Martin Kaistra (1):
      wifi: rtl8xxxu: Fix RX skb size for aggregation disabled

Masahiro Yamada (3):
      kconfig: gconf: avoid hardcoding model2 in on_treeview2_cursor_changed()
      kconfig: gconf: fix potential memory leak in renderer_edited()
      kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS

Masami Hiramatsu (Google) (1):
      selftests: tracing: Use mutex_unlock for testing glob filter

Mathias Nyman (4):
      usb: hub: fix detection of high tier USB3 devices behind suspended hubs
      usb: hub: Fix flushing and scheduling of delayed work that tunes runtime pm
      usb: hub: avoid warm port reset during USB3 disconnect
      usb: hub: Don't try to recover devices lost during warm reset.

Maulik Shah (1):
      pmdomain: governor: Consider CPU latency tolerance from pm_domain_cpu_gov

Meagan Lloyd (2):
      rtc: ds1307: remove clear of oscillator stop flag (OSF) in probe
      rtc: ds1307: handle oscillator stop flag (OSF) for ds1341

Mengbiao Xiong (1):
      crypto: ccp - Fix crash when rebind ccp device for ccp.ko

Miao Li (1):
      usb: quirks: Add DELAY_INIT quick for another SanDisk 3.2Gen1 Flash Drive

Miaohe Lin (1):
      mm/zsmalloc.c: convert to use kmem_cache_zalloc in cache_alloc_zspage()

Michal Schmidt (1):
      benet: fix BUG when creating VFs

Mina Almasry (1):
      netmem: fix skb_frag_address_safe with unreadable skbs

Minghao Chi (1):
      power: supply: bq24190_charger: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Minhong He (1):
      ipv6: sr: validate HMAC algorithm ID in seg6_hmac_info_add

Myrrh Periwinkle (2):
      vt: keyboard: Don't process Unicode characters in K_OFF mode
      vt: defkeymap: Map keycodes above 127 to K_HOLE

Nathan Chancellor (8):
      phonet/pep: Move call to pn_skb_get_dst_sockaddr() earlier in pep_sock_accept()
      memstick: core: Zero initialize id_reg in h_memstick_read_dev_id()
      usb: atm: cxacru: Merge cxacru_upload_firmware() into cxacru_heavy_init()
      wifi: brcmsmac: Remove const from tbl_ptr parameter in wlc_lcnphy_common_read_table()
      ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
      mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
      kbuild: Add CLANG_FLAGS to as-instr
      kbuild: Add KBUILD_CPPFLAGS to as-option invocation

Nick Desaulniers (1):
      kbuild: Update assembler calls to use proper flags and language target

Nilton Perim Neto (1):
      Input: xpad - set correct controller type for Acer NGR200

Octavian Purdila (3):
      net_sched: sch_sfq: don't allow 1 packet limit
      net_sched: sch_sfq: use a temporary work area for validating configuration
      net_sched: sch_sfq: move the limit validation

Ojaswin Mujoo (2):
      ext4: fix fsmap end of range reporting with bigalloc
      ext4: fix reserved gdt blocks handling in fsmap

Oliver Neukum (3):
      usb: net: sierra: check for no status endpoint
      usb: core: usb_submit_urb: downgrade type check
      cdc-acm: fix race between initial clearing halt and open

Oscar Maes (1):
      net: ipv4: fix incorrect MTU in broadcast routes

Ovidiu Panait (1):
      hwrng: mtk - handle devm_pm_runtime_enable errors

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg_collect

Pali Rohár (1):
      cifs: Fix calling CIFSFindFirst() for root path without msearch

Paul Chaignon (1):
      bpf: Check flow_dissector ctx accesses are aligned

Paul E. McKenney (1):
      rcu: Protect ->defer_qs_iw_pending from data race

Paul Kocialkowski (1):
      clk: sunxi-ng: v3s: Fix de clock definition

Pavel Begunkov (1):
      io_uring: don't use int for ABI

Pavel Tikhomirov (1):
      move_mount: allow to add a mount into an existing group

Peter Chen (3):
      usb: chipidea: udc: add new API ci_hdrc_gadget_connect
      usb: chipidea: introduce CI_HDRC_CONTROLLER_VBUS_EVENT glue layer use
      usb: chipidea: udc: fix sleeping function called from invalid context

Peter Oberparleiter (2):
      s390/hypfs: Avoid unnecessary ioctl registration in debugfs
      s390/hypfs: Enable limited access during lockdown

Petr Pavlu (1):
      module: Restore the moduleparam prefix length check

Phillip Lougher (1):
      squashfs: fix memory leak in squashfs_fill_super

Qu Wenruo (1):
      btrfs: populate otime when logging an inode item

Quang Le (1):
      net/packet: fix a race in packet_set_ring() and packet_notifier()

Rafael J. Wysocki (2):
      ACPI: processor: perflib: Move problematic pr->performance check
      PM: runtime: Clear power.needs_force_resume in pm_runtime_reinit()

Rand Deeb (1):
      wifi: iwlwifi: dvm: fix potential overflow in rs_fill_link_cmd()

Randy Dunlap (1):
      parisc: Makefile: fix a typo in palo.conf

Ranjan Kumar (1):
      scsi: Fix sas_user_scan() to handle wildcard and multi-channel scans

Remi Pommarel (1):
      Reapply "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Ricardo Ribalda (2):
      media: uvcvideo: Do not mark valid metadata as invalid
      media: venus: vdec: Clamp param smaller than 1fps and bigger than 240.

Ricky Wu (1):
      misc: rtsx: usb: Ensure mmc child device is active when card is present

Ryan Mann (NDI) (1):
      USB: serial: ftdi_sio: add support for NDI EMGUIDE GEMINI

Ryusuke Konishi (1):
      nilfs2: reject invalid file types when reading inodes

Sabrina Dubroca (1):
      udp: also consider secpath when evaluating ipsec use for checksumming

Sakari Ailus (1):
      media: v4l2-ctrls: Don't reset handler's error in v4l2_ctrl_handler_free()

Sarah Newman (1):
      drbd: add missing kref_get in handle_write_conflicts

Sasha Levin (1):
      fs: Prevent file descriptor table allocations exceeding INT_MAX

Sebastian Ott (1):
      ACPI: processor: fix acpi_object initialization

Sebastian Reichel (2):
      watchdog: dw_wdt: Fix default timeout
      usb: typec: fusb302: cache PD RX state

Sergey Bashirov (4):
      pNFS: Fix stripe mapping in block/scsi layout
      pNFS: Fix disk addr range check in block/scsi layout
      pNFS: Handle RPC size limit for layoutcommits
      pNFS: Fix uninited ptr deref in block/scsi layout

Shankari Anand (1):
      kconfig: nconf: Ensure null termination where strncpy is used

Shiji Yang (1):
      MIPS: vpe-mt: add missing prototypes for vpe_{alloc,start,stop,free}

Showrya M N (1):
      scsi: libiscsi: Initialize iscsi_conn->dd_data only if memory is allocated

Slark Xiao (2):
      USB: serial: option: add Foxconn T99W640
      USB: serial: option: add Foxconn T99W709

Stanislav Fomichev (1):
      vrf: Drop existing dst reference in vrf_ip6_input_dst

Stanislaw Gruszka (1):
      wifi: iwlegacy: Check rate_idx range after addition

Stefan Metzmacher (1):
      smb: client: let recv_done() cleanup before notifying the callers.

Steven Rostedt (3):
      ktest.pl: Prevent recursion of default variable options
      ftrace: Also allocate and copy hash for reading of filter files
      tracing: Add down_write(trace_event_sem) when adding trace event

Su Hui (1):
      usb: xhci: print xhci->xhc_state when queue_command failed

Suchit Karunakaran (1):
      kconfig: lxdialog: replace strcpy() with strncpy() in inputbox.c

Sven Schnelle (2):
      s390/time: Use monotonic clock in get_cycles()
      s390/stp: Remove udelay from stp_sync_clock()

Takashi Iwai (3):
      ALSA: usb-audio: Validate UAC3 power domain descriptors, too
      ALSA: usb-audio: Validate UAC3 cluster segment descriptors
      ALSA: usb-audio: Use correct sub-type for UAC3 feature unit validation

Tao Xue (1):
      usb: gadget : fix use-after-free in composite_dev_cleanup()

Tetsuo Handa (1):
      hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()

Theodore Ts'o (1):
      ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr

Thomas Fourier (15):
      pch_uart: Fix dma_sync_sg_for_device() nents value
      mmc: bcm2835: Fix dma_unmap_sg() nents value
      mwl8k: Add missing check after DMA map
      scsi: ibmvscsi_tgt: Fix dma_unmap_sg() nents value
      scsi: mvsas: Fix dma_unmap_sg() nents value
      scsi: isci: Fix dma_unmap_sg() nents value
      crypto: img-hash - Fix dma_unmap_sg() nents value
      dmaengine: mv_xor: Fix missing check after DMA map and missing unmap
      dmaengine: nbpfaxi: Add missing check after DMA map
      mtd: rawnand: atmel: Fix dma_mapping_error() address
      et131x: Add missing check after DMA map
      net: ag71xx: Add missing check after DMA map
      (powerpc/512) Fix possible `dma_unmap_single()` on uninitialized pointer
      wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.
      mtd: rawnand: fsmc: Add missing check after DMA map

Thomas Gleixner (3):
      perf/core: Don't leak AUX buffer refcount on allocation failure
      perf/core: Exit early on perf_mmap() fail
      perf/core: Prevent VMA split of buffer mappings

Thomas Weißschuh (1):
      MIPS: Don't crash in stack_top() for tasks without ABI or vDSO

Thorsten Blum (1):
      usb: storage: realtek_cr: Use correct byte order for bcs->Residue

Timothy Pearson (1):
      PCI: pnv_php: Work around switches with broken presence detection

Timur Kristóf (2):
      drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3
      drm/amd/display: Find first CRTC and its line time in dce110_fill_display_configs

Trond Myklebust (5):
      NFS: Fix filehandle bounds checking in nfs_fh_to_dentry()
      NFSv4: Fix nfs4_bitmap_copy_adjust()
      NFS: Fix up handling of outstanding layoutcommit in nfs_update_inode()
      NFS: Fix the setting of capabilities when automounting a new filesystem
      NFS: Fix up commit deadlocks

Ulf Hansson (1):
      mmc: rtsx_usb_sdmmc: Fix error-path in sd_set_power_mode()

Uwe Kleine-König (3):
      pwm: mediatek: Implement .apply() callback
      pwm: mediatek: Handle hardware enable and clock enable separately
      pwm: mediatek: Fix duty and period setting

Vedang Nagar (1):
      media: venus: Add a check for packet size after reading from shared memory

Viacheslav Dubeyko (4):
      hfs: fix slab-out-of-bounds in hfs_bnode_read()
      hfsplus: fix slab-out-of-bounds in hfsplus_bnode_read()
      hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
      hfs: fix not erasing deleted b-tree node issue

Vlad Buslov (4):
      net: sched: extract common action counters update code into function
      net: sched: extract bstats update code into function
      net: sched: extract qstats update code into functions
      net: sched: don't expose action qstats to skb_tc_reinsert()

Vladimir Zapolskiy (1):
      media: qcom: camss: cleanup media device allocated resource on error path

Waiman Long (1):
      mm/kmemleak: avoid soft lockup in __kmemleak_do_cleanup()

Wang Liang (1):
      net: drop UFO packets in udp_rcv_segment()

Weitao Wang (1):
      usb: xhci: Fix slot_id resource race conflict

William Liu (4):
      net/sched: Return NULL when htb_lookup_leaf encounters an empty rbtree
      net/sched: Restrict conditions for adding duplicating netems to qdisc tree
      net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit
      net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate

Wolfram Sang (3):
      media: usb: hdpvr: disable zero-length read messages
      i3c: add missing include to internal header
      i3c: don't fail if GETHDRCAP is unsupported

Xiang Mei (2):
      net/sched: sch_qfq: Fix race condition on qfq_aggregate
      net/sched: sch_qfq: Avoid triggering might_sleep in atomic context in qfq_delete_class

Xin Long (1):
      sctp: linearize cloned gso packets in sctp_rcv

Xinxin Wan (1):
      ASoC: codecs: rt5640: Retry DEVICE_ID verification

Xinyu Liu (1):
      usb: gadget: configfs: Fix OOB read on empty string write

Xiu Jianfeng (1):
      wifi: iwlwifi: Fix memory leak in iwl_mvm_init()

Xiumei Mu (1):
      selftests: rtnetlink.sh: remove esp4_offload after test

Xu Yang (2):
      usb: chipidea: add USB PHY event
      usb: phy: mxs: disconnect line when USB charger is attached

Xu Yilun (1):
      fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()

Yang Xiwen (1):
      i2c: qup: jump out of the loop in case of timeout

Yangtao Li (1):
      hfsplus: remove mutex_lock check in hfsplus_free_extents

Yann E. MORIN (1):
      kconfig: lxdialog: fix 'space' to (de)select options

Yazen Ghannam (1):
      x86/mce/amd: Add default names for MCA banks and blocks

Ye Bin (1):
      fs/buffer: fix use-after-free when call bh_read() helper

Youngjun Lee (1):
      media: uvcvideo: Fix 1-byte out-of-bounds read in uvc_parse_format()

Yuan Chen (2):
      bpftool: Fix memory leak in dump_xx_nlmsg on realloc failure
      pinctrl: sunxi: Fix memory leak on krealloc failure

Yun Lu (2):
      af_packet: fix the SO_SNDTIMEO constraint not effective on tpacked_snd()
      af_packet: fix soft lockup issue caused by tpacket_snd()

Yunhui Cui (1):
      serial: 8250: fix panic due to PSLVERR

Yury Norov [NVIDIA] (1):
      RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()

Zenm Chen (1):
      USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles

Zhang Lixu (1):
      iio: hid-sensor-prox: Fix incorrect OFFSET calculation

Zhang Shurong (1):
      media: ov2659: Fix memory leaks in ov2659_probe()

Zhang Xiaoxu (1):
      cifs: Fix UAF in cifs_demultiplex_thread()

Zheng Wang (1):
      power: supply: bq24190: Fix use after free bug in bq24190_remove due to race condition

Zheng Yu (1):
      jfs: fix metapage reference count leak in dbAllocCtl

chenchangcheng (1):
      media: uvcvideo: Fix bandwidth issue for Alcor camera

jackysliu (1):
      scsi: bfa: Double-free fix

tuhaowen (1):
      PM: sleep: console: Fix the black screen issue

wenxu (1):
      net/sched: act_mirred: refactor the handle of xmit

xin.guo (1):
      tcp: fix tcp_ofo_queue() to avoid including too much DUP SACK range

Álvaro Fernández Rojas (3):
      net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
      net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
      net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325


