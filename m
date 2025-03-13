Return-Path: <stable+bounces-124282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2040DA5F457
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1753BC52D
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153682673A1;
	Thu, 13 Mar 2025 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zeSrHVwB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5D21423A;
	Thu, 13 Mar 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868878; cv=none; b=s6V9xU7mp27PiOKr095oo1G32prP9Bn//gRVUHl3odeqpFly/FOsafQ5lieNIJAtxJsIR7fwjq5+7oPUIUGmfMBAbN9pGAOoNOU7aEgieG9jrXQ9ft2s+ugRy3CzRQ1ZWawMBSgP2LWMX1D/aiiGd/lMFzatxJ7vox4JIHCjkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868878; c=relaxed/simple;
	bh=PyPLnRRNmle860GTR+V0gnxZapqSttjh58gY65Wz03k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ca5D4yBCknRXvqil6O3S5vrpj5YUN9GphuAnEr052boDklVBYmJTNmVtVcK1wQoRSovygzRl2Foj7/nWOg+9fFhlcgGZEKKIUmeQZh3vFIr9wQUAgQ8wpTZCJPvFKhuvpZjSuPm244GG9gVLP9RHQVb8/mv7msCeTPf3v9rPHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zeSrHVwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85B8C4CEDD;
	Thu, 13 Mar 2025 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741868878;
	bh=PyPLnRRNmle860GTR+V0gnxZapqSttjh58gY65Wz03k=;
	h=From:To:Cc:Subject:Date:From;
	b=zeSrHVwB+AR57CGirxB0ZO1pmbtpt7M3iWsAaYBkYETesP6jfIP4pf+amA9qWKvur
	 fqsRgMv0gwlBbF97KhWTVizF3Xsde2XyQqSq2EoJ2F8tSH+OB35WXIAXf4lsazkI2Z
	 p8iPZxagoJXfIWRVVw4R2AE3mgMoEoZ/Smx8XSCI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.235
Date: Thu, 13 Mar 2025 13:27:47 +0100
Message-ID: <2025031348-activism-outlying-e232@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.235 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                 |   10 
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml       |    2 
 Makefile                                                        |    7 
 arch/alpha/include/uapi/asm/ptrace.h                            |    2 
 arch/alpha/kernel/asm-offsets.c                                 |    2 
 arch/alpha/kernel/entry.S                                       |   24 -
 arch/alpha/kernel/traps.c                                       |    2 
 arch/alpha/mm/fault.c                                           |    4 
 arch/arm/boot/dts/mt7623.dtsi                                   |    2 
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi                    |   29 -
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts                     |   25 -
 arch/arm64/boot/dts/mediatek/mt8516.dtsi                        |   38 -
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi                |    2 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                           |    2 
 arch/arm64/boot/dts/qcom/msm8994.dtsi                           |    2 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                            |    2 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                   |    2 
 arch/arm64/include/asm/mman.h                                   |    9 
 arch/arm64/kernel/cacheinfo.c                                   |   12 
 arch/arm64/kernel/vdso/vdso.lds.S                               |    1 
 arch/arm64/kernel/vmlinux.lds.S                                 |    1 
 arch/hexagon/include/asm/cmpxchg.h                              |    2 
 arch/hexagon/kernel/traps.c                                     |    4 
 arch/m68k/include/asm/vga.h                                     |    8 
 arch/mips/kernel/ftrace.c                                       |    2 
 arch/powerpc/include/asm/book3s/64/hash-4k.h                    |   28 +
 arch/powerpc/include/asm/book3s/64/pgtable.h                    |   26 -
 arch/powerpc/lib/code-patching.c                                |    2 
 arch/powerpc/platforms/pseries/eeh_pseries.c                    |    6 
 arch/s390/include/asm/futex.h                                   |    2 
 arch/s390/kernel/traps.c                                        |    6 
 arch/s390/kvm/vsie.c                                            |   25 -
 arch/x86/Kconfig                                                |    3 
 arch/x86/boot/compressed/Makefile                               |    1 
 arch/x86/events/intel/core.c                                    |    5 
 arch/x86/include/asm/msr-index.h                                |    3 
 arch/x86/kernel/amd_nb.c                                        |    4 
 arch/x86/kernel/cpu/bugs.c                                      |   20 
 arch/x86/kernel/cpu/cacheinfo.c                                 |    2 
 arch/x86/kernel/cpu/cyrix.c                                     |    4 
 arch/x86/kernel/cpu/intel.c                                     |   52 +-
 arch/x86/kernel/i8253.c                                         |   11 
 arch/x86/kernel/static_call.c                                   |    1 
 arch/x86/mm/init.c                                              |   23 -
 arch/x86/xen/mmu_pv.c                                           |   79 ++-
 arch/x86/xen/xen-head.S                                         |    5 
 block/blk-cgroup.c                                              |    1 
 block/partitions/efi.c                                          |    2 
 block/partitions/ldm.h                                          |    2 
 block/partitions/mac.c                                          |   18 
 crypto/testmgr.h                                                |  227 +++++++---
 drivers/acpi/apei/ghes.c                                        |   10 
 drivers/acpi/fan.c                                              |   10 
 drivers/base/regmap/regmap-irq.c                                |    2 
 drivers/block/nbd.c                                             |    1 
 drivers/char/ipmi/ipmb_dev_int.c                                |    3 
 drivers/char/tpm/eventlog/acpi.c                                |   16 
 drivers/char/tpm/eventlog/efi.c                                 |   13 
 drivers/char/tpm/eventlog/of.c                                  |    3 
 drivers/char/tpm/tpm-chip.c                                     |    1 
 drivers/clk/analogbits/wrpll-cln28hpc.c                         |    2 
 drivers/clk/imx/clk-imx8mp.c                                    |    5 
 drivers/clk/qcom/clk-alpha-pll.c                                |    2 
 drivers/clk/qcom/clk-rpmh.c                                     |    2 
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c                          |    6 
 drivers/clocksource/i8253.c                                     |   13 
 drivers/cpufreq/acpi-cpufreq.c                                  |   36 +
 drivers/cpufreq/s3c64xx-cpufreq.c                               |   11 
 drivers/crypto/hisilicon/qm.c                                   |   46 +-
 drivers/crypto/qce/core.c                                       |   13 
 drivers/dma/ti/edma.c                                           |    3 
 drivers/firmware/Kconfig                                        |    2 
 drivers/firmware/efi/efi.c                                      |    6 
 drivers/firmware/efi/libstub/Makefile                           |    2 
 drivers/firmware/efi/libstub/randomalloc.c                      |    3 
 drivers/firmware/efi/libstub/relocate.c                         |    3 
 drivers/firmware/efi/mokvar-table.c                             |   41 -
 drivers/gpio/gpio-aggregator.c                                  |   20 
 drivers/gpio/gpio-bcm-kona.c                                    |   71 ++-
 drivers/gpio/gpio-pca953x.c                                     |   19 
 drivers/gpio/gpio-rcar.c                                        |    7 
 drivers/gpio/gpio-stmpe.c                                       |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                      |   11 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c             |    2 
 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c        |    4 
 drivers/gpu/drm/drm_dp_cec.c                                    |   14 
 drivers/gpu/drm/drm_fb_helper.c                                 |   14 
 drivers/gpu/drm/drm_probe_helper.c                              |  116 +++--
 drivers/gpu/drm/etnaviv/etnaviv_gem.c                           |   16 
 drivers/gpu/drm/radeon/r300.c                                   |    3 
 drivers/gpu/drm/radeon/radeon_asic.h                            |    1 
 drivers/gpu/drm/radeon/rs400.c                                  |   18 
 drivers/gpu/drm/rockchip/cdn-dp-core.c                          |    9 
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h                 |    4 
 drivers/gpu/drm/tidss/tidss_dispc.c                             |   22 
 drivers/hid/hid-appleir.c                                       |    2 
 drivers/hid/hid-core.c                                          |    2 
 drivers/hid/hid-google-hammer.c                                 |    2 
 drivers/hid/hid-multitouch.c                                    |    5 
 drivers/hid/hid-sensor-hub.c                                    |   21 
 drivers/hid/intel-ish-hid/ishtp-hid.c                           |    4 
 drivers/hid/wacom_wac.c                                         |    5 
 drivers/hwmon/ad7314.c                                          |   10 
 drivers/hwmon/ntc_thermistor.c                                  |   66 +-
 drivers/hwmon/pmbus/pmbus.c                                     |    2 
 drivers/hwmon/xgene-hwmon.c                                     |    2 
 drivers/hwtracing/intel_th/pci.c                                |   15 
 drivers/i2c/busses/i2c-npcm7xx.c                                |    7 
 drivers/i2c/i2c-core-acpi.c                                     |   22 
 drivers/idle/intel_idle.c                                       |    4 
 drivers/iio/light/as73211.c                                     |   24 -
 drivers/infiniband/hw/cxgb4/device.c                            |    6 
 drivers/infiniband/hw/mlx4/main.c                               |    6 
 drivers/infiniband/hw/mlx5/counters.c                           |    8 
 drivers/infiniband/hw/mlx5/qp.c                                 |    4 
 drivers/leds/leds-lp8860.c                                      |    2 
 drivers/leds/leds-netxbig.c                                     |    1 
 drivers/md/dm-crypt.c                                           |   27 -
 drivers/media/dvb-frontends/cxd2841er.c                         |    8 
 drivers/media/i2c/ov5640.c                                      |    1 
 drivers/media/platform/exynos4-is/mipi-csis.c                   |   10 
 drivers/media/platform/marvell-ccic/mcam-core.c                 |    7 
 drivers/media/platform/s3c-camif/camif-core.c                   |   13 
 drivers/media/rc/iguanair.c                                     |    4 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                 |    8 
 drivers/media/usb/dvb-usb-v2/lmedm04.c                          |   14 
 drivers/media/usb/uvc/uvc_ctrl.c                                |   85 +++
 drivers/media/usb/uvc/uvc_driver.c                              |   63 +-
 drivers/media/usb/uvc/uvc_queue.c                               |    3 
 drivers/media/usb/uvc/uvc_status.c                              |    1 
 drivers/media/usb/uvc/uvc_v4l2.c                                |    2 
 drivers/media/usb/uvc/uvcvideo.h                                |    9 
 drivers/media/v4l2-core/v4l2-mc.c                               |    2 
 drivers/mfd/lpc_ich.c                                           |    3 
 drivers/misc/eeprom/digsy_mtc_eeprom.c                          |    2 
 drivers/misc/fastrpc.c                                          |    2 
 drivers/misc/mei/hw-me-regs.h                                   |    2 
 drivers/misc/mei/pci-me.c                                       |    2 
 drivers/mmc/core/sdio.c                                         |    2 
 drivers/mmc/host/sdhci-msm.c                                    |   53 ++
 drivers/mtd/hyperbus/hbmc-am654.c                               |   19 
 drivers/mtd/nand/onenand/onenand_base.c                         |    1 
 drivers/mtd/nand/raw/cadence-nand-controller.c                  |   44 +
 drivers/net/caif/caif_virtio.c                                  |    2 
 drivers/net/can/c_can/c_can_platform.c                          |    5 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c                 |    4 
 drivers/net/ethernet/broadcom/bgmac.h                           |    3 
 drivers/net/ethernet/broadcom/tg3.c                             |   58 ++
 drivers/net/ethernet/cadence/macb.h                             |    2 
 drivers/net/ethernet/cadence/macb_main.c                        |   12 
 drivers/net/ethernet/davicom/dm9000.c                           |    3 
 drivers/net/ethernet/emulex/benet/be.h                          |    2 
 drivers/net/ethernet/emulex/benet/be_cmds.c                     |  197 ++++----
 drivers/net/ethernet/emulex/benet/be_main.c                     |    2 
 drivers/net/ethernet/freescale/fec_main.c                       |   31 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                     |   15 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                     |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                 |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c         |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c       |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c                  |    2 
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c             |   24 -
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c                 |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c          |    4 
 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c                   |    2 
 drivers/net/ethernet/renesas/sh_eth.c                           |    4 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                        |    2 
 drivers/net/geneve.c                                            |   16 
 drivers/net/gtp.c                                               |    5 
 drivers/net/loopback.c                                          |   14 
 drivers/net/netdevsim/ipsec.c                                   |   12 
 drivers/net/netdevsim/netdevsim.h                               |    1 
 drivers/net/netdevsim/udp_tunnels.c                             |   23 -
 drivers/net/ppp/ppp_generic.c                                   |   28 -
 drivers/net/team/team.c                                         |   11 
 drivers/net/tun.c                                               |    2 
 drivers/net/usb/gl620a.c                                        |    4 
 drivers/net/usb/rtl8150.c                                       |   28 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c         |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c    |    3 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                    |    2 
 drivers/net/wireless/mediatek/mt76/usb.c                        |    4 
 drivers/net/wireless/realtek/rtlwifi/base.c                     |   42 -
 drivers/net/wireless/realtek/rtlwifi/base.h                     |    2 
 drivers/net/wireless/realtek/rtlwifi/pci.c                      |   67 --
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c             |    7 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h             |    4 
 drivers/net/wireless/realtek/rtlwifi/usb.c                      |   13 
 drivers/net/wireless/realtek/rtlwifi/wifi.h                     |   23 -
 drivers/net/wireless/ti/wlcore/main.c                           |   10 
 drivers/nvme/host/core.c                                        |   16 
 drivers/nvme/host/pci.c                                         |   66 ++
 drivers/nvme/target/tcp.c                                       |   15 
 drivers/nvmem/core.c                                            |    2 
 drivers/nvmem/qcom-spmi-sdam.c                                  |    1 
 drivers/of/base.c                                               |    8 
 drivers/parport/parport_pc.c                                    |    5 
 drivers/pci/controller/pcie-rcar-ep.c                           |    2 
 drivers/pci/endpoint/pci-epc-core.c                             |    2 
 drivers/pci/quirks.c                                            |    1 
 drivers/phy/samsung/phy-exynos5-usbdrd.c                        |   12 
 drivers/phy/tegra/xusb-tegra186.c                               |   11 
 drivers/platform/x86/thinkpad_acpi.c                            |    1 
 drivers/power/supply/da9150-fg.c                                |    4 
 drivers/pps/clients/pps-gpio.c                                  |    4 
 drivers/pps/clients/pps-ktimer.c                                |    4 
 drivers/pps/clients/pps-ldisc.c                                 |    6 
 drivers/pps/clients/pps_parport.c                               |    4 
 drivers/pps/kapi.c                                              |   10 
 drivers/pps/kc.c                                                |   10 
 drivers/pps/pps.c                                               |  127 ++---
 drivers/ptp/ptp_clock.c                                         |    8 
 drivers/pwm/pwm-stm32.c                                         |    7 
 drivers/rapidio/devices/rio_mport_cdev.c                        |    3 
 drivers/rapidio/rio-scan.c                                      |    5 
 drivers/regulator/of_regulator.c                                |   14 
 drivers/rtc/rtc-pcf85063.c                                      |   11 
 drivers/scsi/mpt3sas/mpt3sas_base.c                             |    3 
 drivers/scsi/qla2xxx/qla_def.h                                  |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                  |  124 ++++-
 drivers/scsi/qla2xxx/qla_gbl.h                                  |    3 
 drivers/scsi/qla2xxx/qla_init.c                                 |   28 -
 drivers/scsi/storvsc_drv.c                                      |    1 
 drivers/scsi/ufs/ufs_bsg.c                                      |    1 
 drivers/slimbus/messaging.c                                     |    5 
 drivers/soc/qcom/smem_state.c                                   |    3 
 drivers/soc/qcom/socinfo.c                                      |    2 
 drivers/spi/spi-mxs.c                                           |    3 
 drivers/spi/spi-zynq-qspi.c                                     |   13 
 drivers/staging/media/imx/imx-media-of.c                        |    8 
 drivers/tee/optee/supp.c                                        |   35 -
 drivers/tty/serial/8250/8250.h                                  |    2 
 drivers/tty/serial/8250/8250_dma.c                              |   16 
 drivers/tty/serial/8250/8250_pci.c                              |   10 
 drivers/tty/serial/8250/8250_port.c                             |    9 
 drivers/tty/serial/sh-sci.c                                     |   25 +
 drivers/usb/atm/cxacru.c                                        |   13 
 drivers/usb/class/cdc-acm.c                                     |   28 -
 drivers/usb/core/hub.c                                          |   16 
 drivers/usb/core/quirks.c                                       |   10 
 drivers/usb/dwc2/gadget.c                                       |    1 
 drivers/usb/dwc3/gadget.c                                       |   37 +
 drivers/usb/gadget/composite.c                                  |   17 
 drivers/usb/gadget/function/f_midi.c                            |   22 
 drivers/usb/gadget/function/f_tcm.c                             |   66 +-
 drivers/usb/gadget/udc/renesas_usb3.c                           |    2 
 drivers/usb/host/pci-quirks.c                                   |    9 
 drivers/usb/host/xhci-mem.c                                     |    5 
 drivers/usb/host/xhci-pci.c                                     |   17 
 drivers/usb/host/xhci-ring.c                                    |   12 
 drivers/usb/host/xhci.c                                         |   23 -
 drivers/usb/host/xhci.h                                         |   11 
 drivers/usb/renesas_usbhs/common.c                              |    6 
 drivers/usb/renesas_usbhs/mod_gadget.c                          |    2 
 drivers/usb/roles/class.c                                       |    5 
 drivers/usb/serial/option.c                                     |   49 +-
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                          |   11 
 drivers/usb/typec/tcpm/tcpm.c                                   |    2 
 drivers/usb/typec/ucsi/ucsi.c                                   |    2 
 drivers/vfio/pci/vfio_pci_rdwr.c                                |    1 
 drivers/vfio/platform/vfio_platform_common.c                    |   10 
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c                   |    1 
 fs/afs/dir.c                                                    |    7 
 fs/afs/xdr_fs.h                                                 |    2 
 fs/afs/yfsclient.c                                              |    5 
 fs/binfmt_flat.c                                                |    2 
 fs/btrfs/inode.c                                                |    4 
 fs/btrfs/locking.c                                              |   68 ++
 fs/btrfs/relocation.c                                           |   14 
 fs/btrfs/super.c                                                |    2 
 fs/btrfs/transaction.c                                          |    4 
 fs/cifs/smb2ops.c                                               |    4 
 fs/f2fs/file.c                                                  |   13 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |   27 -
 fs/nfs/nfs42xdr.c                                               |    2 
 fs/nfsd/nfs2acl.c                                               |    2 
 fs/nfsd/nfs3acl.c                                               |    2 
 fs/nfsd/nfs4callback.c                                          |    8 
 fs/nilfs2/dir.c                                                 |   24 -
 fs/nilfs2/inode.c                                               |   10 
 fs/nilfs2/mdt.c                                                 |    6 
 fs/nilfs2/namei.c                                               |   37 -
 fs/nilfs2/nilfs.h                                               |   10 
 fs/nilfs2/page.c                                                |   55 +-
 fs/nilfs2/page.h                                                |    4 
 fs/nilfs2/segment.c                                             |    4 
 fs/ocfs2/dir.c                                                  |   25 -
 fs/ocfs2/quota_global.c                                         |    5 
 fs/ocfs2/super.c                                                |    2 
 fs/ocfs2/symlink.c                                              |    5 
 fs/orangefs/orangefs-debugfs.c                                  |    4 
 fs/select.c                                                     |    4 
 fs/squashfs/inode.c                                             |    5 
 fs/ubifs/debug.c                                                |   22 
 fs/udf/super.c                                                  |    2 
 include/asm-generic/vmlinux.lds.h                               |    2 
 include/drm/drm_probe_helper.h                                  |    1 
 include/linux/efi.h                                             |    1 
 include/linux/i8253.h                                           |    1 
 include/linux/kallsyms.h                                        |    2 
 include/linux/kvm_host.h                                        |    9 
 include/linux/mlx5/driver.h                                     |    1 
 include/linux/netdevice.h                                       |    6 
 include/linux/pci_ids.h                                         |    4 
 include/linux/pps_kernel.h                                      |    3 
 include/linux/usb/hcd.h                                         |    5 
 include/net/dst.h                                               |   23 -
 include/net/flow_dissector.h                                    |   16 
 include/net/flow_offload.h                                      |    6 
 include/net/l3mdev.h                                            |    2 
 include/net/net_namespace.h                                     |   15 
 include/trace/events/oom.h                                      |   36 +
 include/uapi/linux/input-event-codes.h                          |    1 
 kernel/acct.c                                                   |  141 +++---
 kernel/bpf/syscall.c                                            |   18 
 kernel/debug/kdb/kdb_io.c                                       |    2 
 kernel/events/core.c                                            |   17 
 kernel/irq/internals.h                                          |    9 
 kernel/padata.c                                                 |   45 +
 kernel/power/hibernate.c                                        |    7 
 kernel/printk/printk.c                                          |    2 
 kernel/sched/core.c                                             |    8 
 kernel/sched/cpufreq_schedutil.c                                |   12 
 kernel/time/clocksource.c                                       |   79 +++
 kernel/trace/bpf_trace.c                                        |    2 
 kernel/trace/ftrace.c                                           |   27 -
 lib/Kconfig.debug                                               |    8 
 mm/memcontrol.c                                                 |    7 
 mm/oom_kill.c                                                   |   14 
 mm/page_alloc.c                                                 |    1 
 net/8021q/vlan.c                                                |    3 
 net/8021q/vlan.h                                                |    2 
 net/8021q/vlan_dev.c                                            |   15 
 net/8021q/vlan_netlink.c                                        |    7 
 net/batman-adv/bat_v.c                                          |    3 
 net/batman-adv/bat_v_elp.c                                      |  124 +++--
 net/batman-adv/bat_v_elp.h                                      |    2 
 net/batman-adv/bat_v_ogm.c                                      |    1 
 net/batman-adv/fragmentation.c                                  |    2 
 net/batman-adv/hard-interface.c                                 |    1 
 net/batman-adv/icmp_socket.c                                    |    1 
 net/batman-adv/main.c                                           |    1 
 net/batman-adv/netlink.c                                        |    1 
 net/batman-adv/tp_meter.c                                       |    1 
 net/batman-adv/types.h                                          |    3 
 net/bluetooth/l2cap_core.c                                      |    9 
 net/bluetooth/l2cap_sock.c                                      |    7 
 net/can/j1939/socket.c                                          |    4 
 net/can/j1939/transport.c                                       |    5 
 net/core/drop_monitor.c                                         |   29 -
 net/core/flow_dissector.c                                       |   49 +-
 net/core/flow_offload.c                                         |    7 
 net/core/neighbour.c                                            |   11 
 net/core/skbuff.c                                               |    2 
 net/core/sysctl_net_core.c                                      |    5 
 net/hsr/hsr_forward.c                                           |    7 
 net/ipv4/arp.c                                                  |    4 
 net/ipv4/devinet.c                                              |    3 
 net/ipv4/ip_input.c                                             |    1 
 net/ipv4/ip_output.c                                            |    1 
 net/ipv4/ipmr_base.c                                            |    3 
 net/ipv4/route.c                                                |    8 
 net/ipv4/tcp_minisocks.c                                        |   10 
 net/ipv4/tcp_offload.c                                          |   11 
 net/ipv4/udp.c                                                  |    4 
 net/ipv4/udp_offload.c                                          |    8 
 net/ipv6/ila/ila_lwt.c                                          |    4 
 net/ipv6/ip6_output.c                                           |    1 
 net/ipv6/ndisc.c                                                |   24 -
 net/ipv6/route.c                                                |    7 
 net/ipv6/rpl_iptunnel.c                                         |   67 +-
 net/ipv6/seg6_iptunnel.c                                        |    2 
 net/ipv6/udp.c                                                  |    4 
 net/llc/llc_s_ac.c                                              |   49 +-
 net/mptcp/pm_netlink.c                                          |    6 
 net/mptcp/protocol.c                                            |    1 
 net/ncsi/ncsi-manage.c                                          |   13 
 net/netfilter/nf_tables_api.c                                   |    8 
 net/nfc/nci/hci.c                                               |    2 
 net/openvswitch/datapath.c                                      |   12 
 net/rose/af_rose.c                                              |   40 +
 net/rose/rose_timer.c                                           |   15 
 net/sched/cls_flower.c                                          |    8 
 net/sched/sch_api.c                                             |    4 
 net/sched/sch_cake.c                                            |  140 +++---
 net/sched/sch_fifo.c                                            |    3 
 net/sched/sch_netem.c                                           |    2 
 net/smc/af_smc.c                                                |    2 
 net/smc/smc_rx.c                                                |   37 -
 net/smc/smc_rx.h                                                |    8 
 net/sunrpc/cache.c                                              |   10 
 net/tipc/crypto.c                                               |    4 
 net/vmw_vsock/af_vsock.c                                        |   82 ++-
 net/wireless/nl80211.c                                          |    5 
 net/wireless/reg.c                                              |    3 
 net/wireless/scan.c                                             |   35 +
 net/xfrm/xfrm_replay.c                                          |   10 
 scripts/Makefile.extrawarn                                      |    5 
 scripts/genksyms/genksyms.c                                     |   11 
 scripts/genksyms/genksyms.h                                     |    2 
 scripts/genksyms/parse.y                                        |   18 
 security/integrity/ima/ima_api.c                                |   16 
 security/integrity/ima/ima_template_lib.c                       |   17 
 security/safesetid/securityfs.c                                 |    3 
 security/tomoyo/common.c                                        |    2 
 sound/pci/hda/hda_intel.c                                       |    2 
 sound/pci/hda/patch_conexant.c                                  |    1 
 sound/pci/hda/patch_realtek.c                                   |   78 +++
 sound/soc/codecs/es8328.c                                       |   15 
 sound/soc/intel/boards/bytcr_rt5640.c                           |   17 
 sound/soc/sunxi/sun4i-spdif.c                                   |    7 
 sound/usb/midi.c                                                |    2 
 sound/usb/usx2y/usbusx2y.c                                      |   11 
 sound/usb/usx2y/usbusx2y.h                                      |   26 +
 sound/usb/usx2y/usbusx2yaudio.c                                 |   27 -
 tools/bootconfig/main.c                                         |    4 
 tools/perf/bench/epoll-wait.c                                   |    7 
 tools/perf/builtin-report.c                                     |    2 
 tools/perf/builtin-top.c                                        |    2 
 tools/perf/builtin-trace.c                                      |    6 
 tools/perf/util/bpf-event.c                                     |   10 
 tools/perf/util/cs-etm.c                                        |    2 
 tools/perf/util/dso.c                                           |   14 
 tools/perf/util/env.c                                           |   28 -
 tools/perf/util/env.h                                           |    8 
 tools/perf/util/header.c                                        |   29 -
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c         |   15 
 tools/testing/ktest/ktest.pl                                    |    7 
 tools/testing/selftests/bpf/test_tc_tunnel.sh                   |    1 
 tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh |   16 
 tools/testing/selftests/kselftest_harness.h                     |   24 -
 tools/testing/selftests/net/ipsec.c                             |    3 
 tools/testing/selftests/net/rtnetlink.sh                        |    4 
 tools/testing/selftests/net/udpgso.c                            |   26 +
 434 files changed, 4053 insertions(+), 2023 deletions(-)

Ahmed S. Darwish (3):
      x86/cacheinfo: Validate CPUID leaf 0x2 EDX output
      x86/cpu: Validate CPUID leaf 0x2 EDX output
      x86/cpu: Properly parse CPUID leaf 0x2 TLB descriptor 0x63

Alan Stern (2):
      HID: core: Fix assumption that Resolution Multipliers must be in Logical Collections
      USB: hub: Ignore non-compliant devices with too many configs or interfaces

Alex Deucher (1):
      drm/amdgpu: disable BAR resize on Dell G5 SE

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Alexander Hölzl (1):
      can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero

Alexander Shishkin (2):
      intel_th: pci: Add Panther Lake-H support
      intel_th: pci: Add Panther Lake-P/U support

Alexander Sverdlin (1):
      leds: lp8860: Write full EEPROM, not only half of it

Alexander Usyskin (1):
      mei: me: add panther lake P DID

Anastasia Belova (1):
      clk: qcom: clk-rpmh: prevent integer overflow in recalc_rate

Andreas Kemnade (1):
      wifi: wlcore: fix unbalanced pm_runtime calls

Andrew Cooper (1):
      x86/static-call: Remove early_boot_irqs_disabled check to fix Xen PVH dom0

Andrey Vatoropin (1):
      power: supply: da9150-fg: fix potential overflow

Andy Shevchenko (2):
      xhci: pci: Fix indentation in the PCI device ID definitions
      eeprom: digsy_mtc: Make GPIO lookup table match the device

Andy Strohman (1):
      batman-adv: fix panic during interface removal

AngeloGioacchino Del Regno (1):
      usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix functionality

Antoine Tenart (1):
      net: gso: fix ownership in __udp_gso_segment

Ard Biesheuvel (2):
      efi: Avoid cold plugged memory for placing the kernel
      vmlinux.lds: Ensure that const vars with relocations are mapped R/O

Arnaldo Carvalho de Melo (2):
      perf env: Conditionally compile BPF support code on having HAVE_LIBBPF_SUPPORT
      perf top: Don't complain about lack of vmlinux when not resolving some kernel samples

Arnd Bergmann (2):
      media: cxd2841er: fix 64-bit division on gcc-9
      sunrpc: suppress warnings for unused procfs functions

Artur Weber (3):
      gpio: bcm-kona: Fix GPIO lock/unlock for banks above bank 0
      gpio: bcm-kona: Make sure GPIO bits are unlocked when requesting IRQ
      gpio: bcm-kona: Add missing newline to dev_err format string

BH Hsieh (1):
      phy: tegra: xusb: reset VBUS & ID OVERRIDE

Ba Jing (1):
      ktest.pl: Remove unused declarations in run_bisect_test function

Bartosz Golaszewski (2):
      crypto: qce - fix goto jump in error path
      crypto: qce - unregister previously registered algos in error path

Ben Hutchings (2):
      perf cs-etm: Add missing variable in cs_etm__process_queues()
      udf: Fix use of check_add_overflow() with mixed type arguments

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8821ae: Fix media status report

Bo Gan (1):
      clk: analogbits: Fix incorrect calculation of vco rate delta

Borislav Petkov (1):
      APEI: GHES: Have GHES honor the panic= setting

Brian Vazquez (2):
      net: use indirect call helpers for dst_input
      net: use indirect call helpers for dst_output

Calvin Owens (1):
      pps: Fix a use-after-free

Carlos Galo (1):
      mm: update mark_victim tracepoints fields

Carlos Llamas (1):
      lockdep: Fix upper limit for LOCKDEP_*_BITS configs

Casey Chen (1):
      nvme-pci: fix multiple races in nvme_setup_io_queues

Catalin Marinas (1):
      arm64: mte: Do not allow PROT_MTE on MAP_HUGETLB user mappings

Chao Yu (1):
      f2fs: fix to wait dio completion

Charles Han (2):
      ipmi: ipmb: Add check devm_kasprintf() returned value
      HID: multitouch: Add NULL check in mt_input_configured

Chen Ni (1):
      media: lmedm04: Handle errors for lme2510_int_read

Chen Ridong (4):
      padata: fix UAF in padata_reorder
      padata: add pd get/put refcnt helper
      padata: avoid UAF for reorder_work
      memcg: fix soft lockup in the OOM process

Chen-Yu Tsai (4):
      arm64: dts: mediatek: mt8173-evb: Drop regulator-compatible property
      arm64: dts: mediatek: mt8173-elm: Drop regulator-compatible property
      arm64: dts: mediatek: mt8173-elm: Fix MT6397 PMIC sub-node names
      arm64: dts: mediatek: mt8173-evb: Fix MT6397 PMIC sub-node names

Chenyuan Yang (1):
      net: davicom: fix UAF in dm9000_drv_remove

Chester A. Unal (1):
      USB: serial: option: add MeiG Smart SLM828

Christian Brauner (2):
      acct: block access to kernel internal filesystems
      acct: perform last write from workqueue

Christian Heusel (1):
      Revert "drivers/card_reader/rtsx_usb: Restore interrupt based detection"

Christophe Leroy (3):
      select: Fix unbalanced user_access_end()
      powerpc/64s: Rewrite __real_pte() and __rpte_to_hidx() as static inline
      powerpc/code-patching: Fix KASAN hit by not flagging text patching area as VM_ALLOC

Chuck Lever (1):
      NFSD: Reset cb_seq_status after NFS4ERR_DELAY

Claudiu Beznea (5):
      serial: sh-sci: Drop __initdata macro for port_cfg
      serial: sh-sci: Do not probe the serial port if its slot in sci_ports[] is in use
      usb: renesas_usbhs: Call clk_put()
      usb: renesas_usbhs: Use devm_usb_get_phy()
      usb: renesas_usbhs: Flush the notify_hotplug_work

Cody Eksal (1):
      clk: sunxi-ng: a100: enable MMC clock reparenting

Colin Ian King (1):
      rtlwifi: remove redundant assignment to variable err

Cong Wang (3):
      netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()
      flow_dissector: Fix handling of mixed port and port-range keys
      flow_dissector: Fix port range key handling in BPF conversion

Cosmin Tanislav (1):
      media: mc: fix endpoint iteration

Dai Ngo (1):
      NFSD: fix hang in nfsd4_shutdown_callback

Dan Carpenter (4):
      rdma/cxgb4: Prevent potential integer overflow on 32bit
      tipc: re-order conditions in tipc_crypto_key_rcv()
      binfmt_flat: Fix integer overflow bug on 32 bit systems
      NFC: nci: Add bounds checking in nci_hci_create_pipe()

Daniel Wagner (1):
      nvme: handle connectivity loss in nvme_set_queue_count

Daniil Dulov (1):
      HID: appleir: Fix potential NULL dereference at raw event handle

David Hildenbrand (1):
      KVM: s390: vsie: fix some corner-cases when grabbing vsie pages

David Howells (3):
      afs: Fix EEXIST error returned from afs_rmdir() to be ENOTEMPTY
      afs: Fix directory format encoding struct
      afs: Fix the fallback handling for the YFS.RemoveFile2 RPC call

David Woodhouse (1):
      x86/i8253: Disable PIT timer 0 when not in use

Davidlohr Bueso (1):
      usb/gadget: f_midi: Replace tasklet with work

Devarsh Thakkar (1):
      drm/tidss: Clear the interrupt status for interrupts being disabled

Dheeraj Reddy Jonnalagadda (1):
      net: fec: implement TSO descriptor cleanup

Dmitry Antipov (4):
      wifi: rtlwifi: remove unused timer and related code
      wifi: rtlwifi: remove unused dualmac control leftovers
      wifi: cfg80211: adjust allocation of colocated AP data
      wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()

Dmitry Baryshkov (3):
      arm64: dts: qcom: msm8916: correct sleep clock frequency
      arm64: dts: qcom: msm8994: correct sleep clock frequency
      arm64: dts: qcom: sm8250: correct sleep clock frequency

Dmitry V. Levin (1):
      selftests: harness: fix printing of mismatch values in __EXPECT()

Eddie James (1):
      tpm: Use managed allocation for bios event log

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Positivo C6400

Edward Adam Davis (1):
      media: vidtv: Fix a null-ptr-deref in vidtv_mux_stop_thread

Ekansh Gupta (1):
      misc: fastrpc: Fix registered buffer page address

Elson Roy Serrao (1):
      usb: roles: set switch registered flag early on

Emil Renner Berthing (1):
      net: usb: rtl8150: use new tasklet API

Eric Dumazet (17):
      ipmr: do not call mr_mfc_uses_dev() for unres entries
      net: rose: fix timer races against user threads
      net: hsr: fix fill_frame_info() regression vs VLAN packets
      net: rose: lock the socket in rose_bind()
      ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()
      vrf: use RCU protection in l3mdev_l3_out()
      team: better TEAM_OPTION_TYPE_STRING validation
      net: add dev_net_rcu() helper
      ipv4: use RCU protection in rt_is_expired()
      ipv4: use RCU protection in inet_select_addr()
      ipv6: use RCU protection in ip6_default_advmss()
      ndisc: use RCU protection in ndisc_alloc_skb()
      neighbour: use RCU protection in __neigh_notify()
      arp: use RCU protection in arp_xmit()
      openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
      ndisc: extend RCU protection in ndisc_send_skb()
      llc: do not use skb_get() before dev_queue_xmit()

Erik Schumacher (1):
      hwmon: (ad7314) Validate leading zero bits and return error

Even Xu (1):
      HID: Wacom: Add PCI Wacom device support

Fabien Parent (1):
      arm64: dts: mediatek: mt8516: remove 2 invalid i2c clocks

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990B compositions
      USB: serial: option: fix Telit Cinterion FN990A name

Fabrice Gasnier (1):
      usb: dwc2: gadget: remove of_node reference upon udc_stop

Fabrizio Castro (1):
      gpio: rcar: Fix missing of_node_put() call

Fedor Pchelkin (3):
      Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
      Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection
      usb: typec: ucsi: increase timeout for PPM reset operations

Filipe Manana (3):
      btrfs: fix use-after-free when attempting to join an aborted transaction
      btrfs: avoid monopolizing a core when activating a swap file
      btrfs: bring back the incorrectly removed extent buffer lock recursion support

Gabor Juhos (1):
      clk: qcom: clk-alpha-pll: fix alpha mode configuration

Gautham R. Shenoy (1):
      cpufreq: ACPI: Fix max-frequency computation

Gavrilov Ilia (1):
      drop_monitor: fix incorrect initialization order

George Lander (1):
      ASoC: sun4i-spdif: Add clock multiplier settings

Greg Kroah-Hartman (1):
      Linux 5.10.235

Guangguan Wang (1):
      net/smc: fix data error when recvmsg with MSG_PEEK flag

Guixin Liu (1):
      scsi: ufs: bsg: Delete bsg_dev when setting up bsg fails

Guo Ren (1):
      usb: gadget: udc: renesas_usb3: Fix compiler warning

Hangbin Liu (2):
      netdevsim: print human readable IP address
      selftests: rtnetlink: update netdevsim ipsec output format

Hans Verkuil (1):
      gpu: drm_dp_cec: fix broken CEC adapter properties check

Hans de Goede (2):
      mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet 5V

Hao Zhang (1):
      mm/page_alloc: fix uninitialized variable

Haoxiang Li (5):
      drm/komeda: Add check for komeda_get_layer_fourcc_list()
      nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
      smb: client: Add check for next_buffer in receive_encrypted_standard()
      rapidio: add check for rio_add_net() in rio_scan_alloc_net()
      rapidio: fix an API misues when rio_add_net() fails

Hardik Gajjar (1):
      usb: xhci: Add timeout argument in address_device USB HCD callback

Harshal Chaudhari (1):
      net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow defination.

He Rongguang (1):
      cpupower: fix TSC MHz calculation

Heiko Carstens (2):
      s390/futex: Fix FUTEX_OP_ANDN implementation
      s390/traps: Fix test_monitor_call() inline assembly

Heiko Stuebner (1):
      HID: hid-sensor-hub: don't use stale platform-data on remove

Heming Zhao (1):
      ocfs2: fix incorrect CPU endianness conversion causing mount failure

Hoku Ishibe (1):
      ALSA: hda: intel: Add Dell ALC3271 to power_save denylist

Hou Tao (2):
      dm-crypt: don't update io->sector after kcryptd_crypt_write_io_submit()
      dm-crypt: track tag_offset in convert_context

Howard Chu (1):
      perf trace: Fix runtime error of index out of bounds

Huacai Chen (1):
      USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI

Hui Su (1):
      kernel/acct.c: use #elif instead of #end and #elif

Ido Schimmel (1):
      net: loopback: Avoid sending IP packets without an Ethernet header

Ignat Korchagin (2):
      crypto: testmgr - populate RSA CRT parameters in RSA test vectors
      crypto: testmgr - some more fixes to RSA test vectors

Ilan Peer (1):
      wifi: cfg80211: Handle specific BSSID in 6GHz scanning

Illia Ostapyshyn (1):
      Input: allocate keycode for phone linking

Ivan Kokshaysky (3):
      alpha: make stack 16-byte aligned (most cases)
      alpha: align stack for page fault and user unaligned trap handlers
      alpha: replace hardcoded stack offsets with autogenerated ones

Ivan Stepchenko (2):
      drm/amdgpu: Fix potential NULL pointer dereference in atomctrl_get_smc_sclk_range_table
      mtd: onenand: Fix uninitialized retlen in do_otp_read()

Jacob Moroni (1):
      net: atlantic: fix warning during hot unplug

Jakob Koschel (1):
      rtlwifi: replace usage of found with dedicated list iterator variable

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: increase gmac rx_delay on rk3399-puma

Jakub Kicinski (2):
      net: netdevsim: try to close UDP port harness races
      net: ipv6: fix dst refleaks in rpl, seg6 and ioam6 lwtunnels

Jamal Hadi Salim (1):
      net: sched: Disallow replacing of child qdisc from one parent to another

Jann Horn (3):
      usb: cdc-acm: Check control transfer buffer size before access
      usb: cdc-acm: Fix handling of oversized fragments
      partitions: mac: fix handling of bogus partition table

Jarkko Sakkinen (1):
      tpm: Change to kvalloc() in eventlog/acpi.c

Jason Xing (1):
      net-timestamp: support TCP GSO case for a few missing flags

Javier Carrasco (1):
      iio: light: as73211: fix channel handling in only-color triggered buffer

Jennifer Berringer (1):
      nvmem: core: improve range check for nvmem_cell_write()

Jiachen Zhang (1):
      perf report: Fix misleading help message about --demangle

Jian Shen (1):
      net: hns3: fix oops when unload drivers paralleling

Jianbo Liu (1):
      xfrm: replay: Fix the update of replay_esn->oseq_hi for GSO

Jiaqing Zhao (3):
      can: ems_pci: move ASIX AX99100 ids to pci_ids.h
      serial: 8250_pci: add support for ASIX AX99100
      parport_pc: add support for ASIX AX99100

Jiasheng Jiang (4):
      media: marvell: Add check for clk_enable()
      media: mipi-csis: Add check for clk_enable()
      media: camif-core: Add check for clk_enable()
      regmap-irq: Add missing kfree()

Jiayuan Chen (1):
      ppp: Fix KMSAN uninit-value warning with bpf

Jill Donahue (1):
      USB: gadget: f_midi: f_midi_complete to call queue_work

Jiri Pirko (1):
      net: treat possible_net_t net pointer as an RCU one and add read_pnet_rcu()

Joe Hattori (7):
      ACPI: fan: cleanup resources in the error path of .probe()
      leds: netxbig: Fix an OF node reference leak in netxbig_leds_get_of_pdata()
      regulator: of: Implement the unwind path of of_regulator_match()
      fbdev: omapfb: Fix an OF node leak in dss_of_port_get_parent_device()
      mtd: hyperbus: hbmc-am654: fix an OF node reference leak
      staging: media: imx: fix OF node leak in imx_media_add_of_subdevs()
      dmaengine: ti: edma: fix OF node reference leaks in edma_driver

Johan Hovold (1):
      USB: serial: option: drop MeiG Smart defines

Johannes Berg (1):
      wifi: iwlwifi: limit printed string from FW file

John Keeping (2):
      usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
      serial: 8250: Fix fifo underflow on flush

John Ogness (1):
      kdb: Do not assume write() callback available

John Veness (1):
      ALSA: hda/conexant: Add quirk for HP ProBook 450 G4 mute LED

Jos Wang (1):
      usb: typec: tcpm: set SRC_SEND_CAPABILITIES timeout to PD_T_SENDER_RESPONSE

Josef Bacik (1):
      btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling

Juergen Gross (3):
      x86/xen: fix xen_hypercall_hvm() to not clobber %rbx
      x86/xen: add FRAME_END to xen_hypercall_hvm()
      x86/xen: allow larger contiguous memory regions in PV guests

Justin Iurman (5):
      include: net: add static inline dst_dev_overhead() to dst.h
      net: ipv6: rpl_iptunnel: mitigate 2-realloc issue
      net: ipv6: fix dst ref loop on input in rpl lwt
      net: ipv6: fix dst ref loop in ila lwtunnel
      net: ipv6: fix missing dst ref drop in ila lwtunnel

Kailang Yang (2):
      ALSA: hda/realtek: Fixup ALC225 depop procedure
      ALSA: hda/realtek: update ALC222 depop optimize

Kan Liang (1):
      perf/core: Fix low freq setting via IOC_PERIOD

Kaustabh Chakraborty (1):
      phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and SSC_REFCLKSEL masks in refclk

Keisuke Nishimura (1):
      nvme: Add error check for xa_store in nvme_get_effects_log

King Dix (1):
      PCI: rcar-ep: Fix incorrect variable used when calling devm_request_mem_region()

Koichiro Den (2):
      Revert "btrfs: avoid monopolizing a core when activating a swap file"
      gpio: aggregator: protect driver attr handlers against module unload

Kory Maincent (1):
      net: sh_eth: Fix missing rtnl lock in suspend/resume path

Krzysztof Kozlowski (2):
      soc: qcom: smem_state: fix missing of_node_put in error path
      can: c_can: fix unbalanced runtime PM disable in error path

Kuan-Wei Chiu (2):
      printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
      perf bench: Fix undefined behavior in cmpworker()

Kuniyuki Iwashima (3):
      geneve: Fix use-after-free in geneve_find_dev().
      gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
      geneve: Suppress list corruption splat in geneve_destroy_tunnels().

Laurent Pinchart (1):
      media: uvcvideo: Fix double free in error path

Lei He (2):
      crypto: testmgr - fix wrong key length for pkcs1pad
      crypto: testmgr - Fix wrong test case of RSA

Lei Huang (1):
      USB: quirks: add USB_QUIRK_NO_LPM quirk for Teclast dist

Lenny Szubowicz (1):
      tg3: Disable tg3 PCIe AER on system reboot

Leo Stone (1):
      safesetid: check size of policy writes

Leon Romanovsky (1):
      RDMA/mlx4: Avoid false error about access to uninitialized gids array

Li Lingfeng (1):
      nfsd: clear acl_access/acl_default after releasing them

Li Zetao (1):
      neighbour: delete redundant judgment statements

Lin Yujun (1):
      hexagon: Fix unbalanced spinlock in die()

Liu Jian (1):
      net: let net.core.dev_weight always be non-zero

Liu Ye (1):
      selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()

Long Li (1):
      scsi: storvsc: Set correct data length for sending SCSI command without payload

Luca Weiss (1):
      nvmem: qcom-spmi-sdam: Set size in struct nvmem_config

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response

Luo Yifan (1):
      tools/bootconfig: Fix the wrong format specifier

Ma Jun (1):
      drm/amdgpu: Check extended configuration space register when system uses large bar

Maarten Lankhorst (1):
      drm/modeset: Handle tiled displays in pan_display_atomic.

Maher Sanalla (1):
      net/mlxfw: Drop hard coded max FW flash image size

Maksym Glubokiy (1):
      net: extract port range fields from fl_flow_key

Maksym Planeta (1):
      Grab mm lock before grabbing pt lock

Malcolm Priestley (1):
      media: lmedm04: Use GFP_KERNEL for URB allocation/submission.

Marcel Hamer (1):
      wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()

Marco Leogrande (1):
      tools/testing/selftests/bpf/test_tc_tunnel.sh: Fix wait for server bind

Marek Szyprowski (1):
      usb: gadget: Fix setting self-powered state on suspend

Marek Vasut (2):
      clk: imx8mp: Fix clkout1/2 support
      USB: cdc-acm: Fill in Renesas R-Car D3 USB Download mode quirk

Mark Tomlinson (1):
      gpio: pca953x: Improve interrupt support

Mark Zhang (1):
      IB/mlx5: Set and get correct qp_num for a DCT QP

Masahiro Yamada (2):
      genksyms: fix memory leak when the same symbol is added from source
      genksyms: fix memory leak when the same symbol is read from *.symref file

Mathias Nyman (1):
      USB: Add USB_QUIRK_NO_LPM quirk for sony xperia xz1 smartphone

Matthew Wilcox (Oracle) (1):
      ocfs2: handle a symlink read error correctly

Maud Spierings (1):
      hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor table

Maxime Ripard (1):
      drm/probe-helper: Create a HPD IRQ event helper for a single connector

Meir Elisha (1):
      nvmet-tcp: Fix a possible sporadic response drops in weakly ordered arch

Miao Li (1):
      usb: quirks: Add DELAY_INIT and NO_LPM for Prolific Mass Storage Card Reader

Michael Ellerman (1):
      powerpc/64s/mm: Move __real_pte stubs into hash-4k.h

Michal Luczaj (4):
      vsock: Allow retrying on connect() failure
      bpf, vsock: Invoke proto::close on close()
      vsock: Keep the binding until socket destruction
      vsock: Orphan socket after transport release

Michal Pecio (2):
      usb: xhci: Fix NULL pointer dereference on certain command aborts
      usb: xhci: Enable the TRB overfetch quirk on VIA VL805

Mike Marshall (1):
      orangefs: fix a oob in orangefs_debug_write

Mike Snitzer (1):
      pnfs/flexfiles: retry getting layout segment for reads

Mingcong Bai (1):
      platform/x86: thinkpad_acpi: Add battery quirk for ThinkPad X131e

Mingwei Zheng (2):
      spi: zynq-qspi: Add check for clk_enable()
      pwm: stm32: Add check for clk_enable()

Murad Masimov (1):
      ALSA: usx2y: validate nrpacks module parameter on probe

Narayana Murty N (1):
      powerpc/pseries/eeh: Fix get PE state translation

Nathan Chancellor (4):
      efi: libstub: Use '-std=gnu11' to fix build with GCC 15
      kbuild: Move -Wenum-enum-conversion to W=2
      x86/boot: Use '-std=gnu11' to fix build with GCC 15
      arm64: Handle .ARM.attributes section in linker scripts

Neil Armstrong (1):
      dt-bindings: mmc: controller: clarify the address-cells description

Nicolas Frattaroli (1):
      ASoC: es8328: fix route from DAC to output

Nikita Zhandarovich (6):
      net/rose: prevent integer overflows in rose_setsockopt()
      net: usb: rtl8150: enable basic endpoint checking
      nilfs2: fix possible int overflows in nilfs_fiemap()
      usbnet: gl620a: fix endpoint checking in genelink_bind()
      wifi: cfg80211: regulatory: improve invalid hints checking
      usb: atm: cxacru: fix a flaw in existing endpoint checks

Nikolay Aleksandrov (1):
      be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink

Nikolay Kuratov (1):
      ftrace: Avoid potential division by zero in function_stat_show()

Niravkumar L Rabara (4):
      mtd: rawnand: cadence: fix error code in cadence_nand_init()
      mtd: rawnand: cadence: use dma_map_resource for sdma address
      mtd: rawnand: cadence: fix incorrect device in dma_unmap_single
      mtd: rawnand: cadence: fix unchecked dereference

Octavian Purdila (1):
      team: prevent adding a device which is already a team device lower

Oleksij Rempel (1):
      rtc: pcf85063: fix potential OOB write in PCF85063 NVMEM read

Olga Kornievskaia (1):
      NFSv4.2: fix COPY_NOTIFY xdr buf size calculation

Oliver Neukum (1):
      media: rc: iguanair: handle timeouts

Olivier Gayot (1):
      block: fix conversion of GPT partition name to 7-bit

Oscar Maes (1):
      vlan: enforce underlying device type

Pablo Neira Ayuso (1):
      netfilter: nf_tables: reject mismatching sum of field_len with set key length

Paolo Abeni (2):
      mptcp: prevent excessive coalescing on receive
      mptcp: always handle address removal under msk socket lock

Patrick Bellasi (1):
      x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit

Patrisious Haddad (1):
      RDMA/mlx5: Fix bind QP error cleanup flow

Paul E. McKenney (1):
      clocksource: Limit number of CPUs checked for clock synchronization

Paul Fertser (1):
      net/ncsi: wait for the last response to Deselect Package before configuring channel

Paul Menzel (1):
      scsi: mpt3sas: Set ioc->manu_pg11.EEDPTagMode directly to 1

Pawel Chmielewski (1):
      intel_th: pci: Add Arrow Lake support

Peter Jones (1):
      efi: Don't map the entire mokvar table to determine its size

Petr Tesarik (1):
      xen: remove a confusing comment on auto-translated guest I/O

Philipp Stanner (1):
      drm/sched: Fix preprocessor guard

Phillip Lougher (1):
      Squashfs: check the inode number is not the invalid value of zero

Philo Lu (1):
      ipvs: Always clear ipvs_property flag in skb_scrub_packet()

Prasad Pandit (1):
      firmware: iscsi_ibft: fix ISCSI_IBFT Kconfig entry

Prashanth K (2):
      usb: gadget: Set self-powered based on MaxPower and bmAttributes
      usb: gadget: Check bmAttributes only if configuration is valid

Puranjay Mohan (1):
      bpf: Send signals asynchronously if !preemptible

Qu Wenruo (1):
      btrfs: output the reason for open_ctree() failure

Quang Le (1):
      pfifo_tail_enqueue: Drop new packet when sch->limit == 0

Quinn Tran (1):
      scsi: qla2xxx: Move FCE Trace buffer allocation to user control

Radu Rendec (1):
      arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array

Rafael J. Wysocki (1):
      cpufreq: schedutil: Simplify sugov_update_next_freq()

Rafał Miłecki (2):
      ARM: dts: mediatek: mt7623: fix IR nodename
      bgmac: reduce max frame size to support just MTU 1500

Ralf Schlatterbeck (1):
      spi-mxs: Fix chipselect glitch

Ramesh Thomas (1):
      vfio/pci: Enable iowrite64 and ioread64 for vfio pci

Randolph Ha (1):
      i2c: Force ELAN06FA touchpad I2C bus freq to 100KHz

Randy Dunlap (1):
      partitions: ldm: remove the initial kernel-doc notation

Ricardo B. Marliere (1):
      ktest.pl: Check kernelrelease return in get_version

Ricardo Ribalda (5):
      media: uvcvideo: Propagate buf->error to userspace
      media: uvcvideo: Fix event flags in uvc_ctrl_send_events
      media: uvcvideo: Remove redundant NULL assignment
      media: uvcvideo: Only save async fh if success
      media: uvcvideo: Remove dangling pointers

Richard Thier (1):
      drm/radeon: Fix rs400_gpu_init for ATI mobility radeon Xpress 200M

Rob Herring (Arm) (1):
      Revert "of: reserved-memory: Fix using wrong number of cells to get property 'alignment'"

Roger Quadros (1):
      net: ethernet: ti: am65-cpsw: fix freeing IRQ in am65_cpsw_nuss_remove_tx_chns()

Russell Senior (1):
      x86/CPU: Fix warm boot hang regression on AMD SC1100 SoC systems

Ryusuke Konishi (6):
      nilfs2: do not output warnings when clearing dirty buffers
      nilfs2: do not force clear folio if buffer is referenced
      nilfs2: protect access to buffers with no active references
      nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
      nilfs2: eliminate staggered calls to kunmap in nilfs_rename
      nilfs2: handle errors that nilfs_prepare_chunk() may return

Sam Bobrowicz (1):
      media: ov5640: fix get_light_freq on auto

Sean Anderson (1):
      net: cadence: macb: Synchronize stats calculations

Sean Christopherson (2):
      KVM: Explicitly verify target vCPU is online in kvm_get_vcpu()
      perf/x86/intel: Ensure LBRs are disabled when a CPU is starting

Sean Rhodes (1):
      drivers/card_reader/rtsx_usb: Restore interrupt based detection

Sebastian Andrzej Siewior (2):
      module: Extend the preempt disabled section in dereference_symbol_descriptor().
      clocksource: Replace deprecated CPU-hotplug functions.

Selvarasu Ganesan (1):
      usb: dwc3: Fix timeout issue during controller enter/exit from halt state

Shawn Lin (1):
      mmc: core: Respect quirk_max_rate for non-UHS SDIO card

Stas Sergeev (1):
      tun: fix group permission check

Stefan Berger (1):
      ima: Fix use-after-free on a dentry's dname.name

Stefan Eichenberger (1):
      usb: core: fix pipe creation for get_bMaxPacketSize0

Stephan Gerhold (1):
      soc: qcom: socinfo: Avoid out of bounds read of serial number

Su Yue (2):
      ocfs2: mark dquot as inactive if failed to start trans while releasing dquot
      ocfs2: check dir i_size in ocfs2_find_entry

Sui Jingfeng (1):
      drm/etnaviv: Fix page property being used for non writecombine buffers

Suleiman Souhlal (1):
      sched: Don't try to catch up excess steal time.

Sultan Alsawaf (unemployed) (1):
      cpufreq: schedutil: Fix superfluous updates caused by need_freq_update

Sumit Garg (1):
      tee: optee: Fix supplicant wait loop

Sven Eckelmann (4):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Add new include for min/max helpers
      batman-adv: Drop initialization of flexible ethtool_link_ksettings
      batman-adv: Drop unmanaged ELP metric worker

Takashi Iwai (2):
      PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P
      ALSA: usb-audio: Avoid dropping MIDI events at closing multiple ports

Tetsuo Handa (1):
      tomoyo: don't emit warning in tomoyo_write_control()

Thadeu Lima de Souza Cascardo (10):
      wifi: rtlwifi: do not complete firmware loading needlessly
      wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
      wifi: rtlwifi: wait for firmware loading before releasing memory
      wifi: rtlwifi: fix init_sw_vars leak when probe fails
      wifi: rtlwifi: usb: fix workqueue leak when probe fails
      wifi: rtlwifi: remove unused check_buddy_priv
      wifi: rtlwifi: destroy workqueue at rtl_deinit_core
      wifi: rtlwifi: fix memory leaks and invalid access at probe error path
      wifi: rtlwifi: pci: wait for firmware loading before releasing memory
      Revert "media: uvcvideo: Require entities to have a non-zero unique ID"

Thinh Nguyen (6):
      usb: gadget: f_tcm: Fix Get/SetInterface return value
      usb: gadget: f_tcm: Don't free command immediately
      usb: gadget: f_tcm: Translate error to sense
      usb: gadget: f_tcm: Decrement command ref count on cleanup
      usb: gadget: f_tcm: ep_autoconfig with fullspeed endpoint
      usb: gadget: f_tcm: Don't prepare BOT write request twice

Thomas Gleixner (3):
      genirq: Make handle_enforce_irqctx() unconditionally available
      sched/core: Prevent rescheduling when interrupts are disabled
      intel_idle: Handle older CPUs, which stop the TSC in deeper C states, correctly

Thomas Weißschuh (3):
      padata: fix sysfs store callback check
      ptp: Ensure info->enable callback is always set
      kbuild: userprogs: use correct lld when linking through clang

Thomas Zimmermann (2):
      m68k: vga: Fix I/O defines
      drm/rockchip: cdn-dp: Use drm_connector_helper_hpd_irq_event()

Titus Rwantare (1):
      hwmon: (pmbus) Initialise page count in pmbus_identify()

Toke Høiland-Jørgensen (1):
      sched: sch_cake: add bounds checks to host bulk flow fairness counts

Tomi Valkeinen (1):
      drm/tidss: Fix issue in irq handling causing irq-flood issue

Tyrone Ting (1):
      i2c: npcm: disable interrupt enable bit before devm_request_irq

Vadim Fedorenko (1):
      net/mlx5: use do_aux_work for PHC overflow checks

Val Packett (4):
      arm64: dts: mediatek: mt8516: fix GICv2 range
      arm64: dts: mediatek: mt8516: fix wdt irq type
      arm64: dts: mediatek: mt8516: add i2c clock-div property
      arm64: dts: mediatek: mt8516: reserve 192 KiB for TF-A

Viresh Kumar (1):
      cpufreq: s3c64xx: Fix compilation warning

Visweswara Tanuku (1):
      slimbus: messaging: Free transaction ID in delayed interrupt scenario

Vitaliy Shevtsov (2):
      wifi: nl80211: reject cooked mode if it is set along with other flags
      caif_virtio: fix wrong pointer check in cfv_probe()

Waiman Long (2):
      clocksource: Use pr_info() for "Checking clocksource synchronization" message
      clocksource: Use migrate_disable() to avoid calling get_random_u32() in atomic context

Wang Hai (1):
      tcp: Defer ts_recent changes until req is owned

WangYuli (2):
      wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
      MIPS: ftrace: Declare ftrace_get_parent_ra_addr() as static

Weili Qian (1):
      crypto: hisilicon/qm - inject error before stopping queue

Wentao Liang (3):
      PM: hibernate: Add error handling for syscore_suspend()
      gpio: stmpe: Check return value of stmpe_reg_read in stmpe_gpio_irq_sync_unlock
      mlxsw: Add return value check for mlxsw_sp_port_get_stats_raw()

Wesley Cheng (1):
      usb: dwc3: Increase DWC3 controller halt timeout

Willem de Bruijn (2):
      hexagon: fix using plain integer as NULL pointer warning in cmpxchg
      tun: revert fix group permission check

Xi Ruoyao (1):
      x86/mm: Don't disable PCID when INVLPG has been fixed by microcode

Xin Long (2):
      vlan: introduce vlan_dev_free_egress_priority
      vlan: move dev_put into vlan_dev_uninit

Xinghuo Chen (1):
      hwmon: fix a NULL vs IS_ERR_OR_NULL() check in xgene_hwmon_probe()

Yan Zhai (2):
      udp: gso: do not drop small packets when PMTU reduces
      bpf: skip non exist keys in generic_map_lookup_batch

Yang Yang (1):
      kernel/acct.c: use dedicated helper to access rlimit values

Yazen Ghannam (1):
      x86/amd_nb: Restrict init function to AMD-based systems

Yu Kuai (1):
      nbd: don't allow reconnect after disconnect

Yu-Chun Lin (1):
      HID: google: fix unused variable warning under !CONFIG_ACPI

Yuanjie Yang (1):
      mmc: sdhci-msm: Correctly set the load for the regulator

Yury Norov (1):
      clocksource: Replace cpumask_weight() with cpumask_empty()

Zhang Lixu (1):
      HID: intel-ish-hid: Fix use-after-free issue in ishtp_hid_remove()

Zheng Yongjun (1):
      net: ipv6: rpl_iptunnel: simplify the return expression of rpl_do_srh()

Zhongqiu Han (3):
      perf header: Fix one memory leakage in process_bpf_btf()
      perf header: Fix one memory leakage in process_bpf_prog_info()
      perf bpf: Fix two memory leakages when calling perf_env__insert_bpf_prog_info()

Zijun Hu (5):
      PCI: endpoint: Destroy the EPC device in devm_pci_epc_destroy()
      blk-cgroup: Fix class @block_class's subsystem refcount leakage
      of: Correct child specifier used as input of the 2nd nexus node
      of: Fix of_find_node_opts_by_path() handling of alias+path+options
      of: reserved-memory: Fix using wrong number of cells to get property 'alignment'

lei he (1):
      crypto: testmgr - fix version number of RSA tests

pangliyuan (1):
      ubifs: skip dumping tnc tree when zroot is null


