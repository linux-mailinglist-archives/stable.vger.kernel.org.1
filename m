Return-Path: <stable+bounces-91946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A865A9C2154
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB881C23C30
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9B721C167;
	Fri,  8 Nov 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aly3KjJE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F221B45D;
	Fri,  8 Nov 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081582; cv=none; b=OYo2CAt7nZHr06o94uVOw+GAkZ969tf0OLE3oeJGR9qCX7oagX8pvAwVzdCeRuFZjWFblgbDx8F/ciVoUF57Org7OsuTwDTDzbFHS5enjq9cbFOfnkGsiZ2kHSKU9qJNfllE+HfU0RhGLEnFuxIEc7ePnTeR5hDXv9ncDf6Gu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081582; c=relaxed/simple;
	bh=zNgUfbffdpHU8fWjXb3+6YWpHdc7C+xpMOq7nnFPzFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VDhWOWCWg1Cx4N2YqwaiiTWu95gsYxrAW9RUFdEJObqVAHHgzGS0OGg11QjZCDw3e0GZJH5niU4C00y3UVYuw6yaIChShLZ130lb1DXZl6R6trAv/VMOuOSq1pVSsG9CKQgE5MeEKak6yubmCmHo8Yv0sQaMKTawkWkMzgt3XZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aly3KjJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44082C4CECD;
	Fri,  8 Nov 2024 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081581;
	bh=zNgUfbffdpHU8fWjXb3+6YWpHdc7C+xpMOq7nnFPzFk=;
	h=From:To:Cc:Subject:Date:From;
	b=aly3KjJEiRUWEwG6LcoppzF+8wK9Y8zmWekuN2N8wbxKbdsBosRuFf7mPdfDJoA9B
	 Buf1S+C0wbH7oX08diAqBLNFeXuC3Q1CuWEXK6PWUHfZ6m1G0GImOQJOMhJpDg1qqw
	 sq/mc/L2B2lt+mHs4QhLkyvJTrkSlQDzn2Pf7Tl4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.285
Date: Fri,  8 Nov 2024 16:59:15 +0100
Message-ID: <2024110816-resident-stellar-1e7f@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.285 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                          |    1 
 Documentation/IPMI.txt                                              |    2 
 Documentation/admin-guide/kernel-parameters.txt                     |   10 
 Documentation/arm64/silicon-errata.rst                              |    4 
 Documentation/devicetree/bindings/gpu/samsung-rotator.txt           |   28 
 Documentation/devicetree/bindings/gpu/samsung-rotator.yaml          |   48 
 Makefile                                                            |    2 
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts                           |    2 
 arch/arm/boot/dts/imx7d-zii-rmu2.dts                                |    2 
 arch/arm/mach-realview/platsmp-dt.c                                 |    1 
 arch/arm64/Kconfig                                                  |    2 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                       |   23 
 arch/arm64/include/asm/cputype.h                                    |    4 
 arch/arm64/include/asm/uprobes.h                                    |   12 
 arch/arm64/kernel/cpu_errata.c                                      |    2 
 arch/arm64/kernel/probes/decode-insn.c                              |   16 
 arch/arm64/kernel/probes/simulate-insn.c                            |   18 
 arch/arm64/kernel/probes/uprobes.c                                  |    4 
 arch/microblaze/mm/init.c                                           |    5 
 arch/parisc/kernel/entry.S                                          |    6 
 arch/parisc/kernel/syscall.S                                        |   14 
 arch/riscv/Kconfig                                                  |    5 
 arch/riscv/kernel/asm-offsets.c                                     |    2 
 arch/riscv/kernel/perf_callchain.c                                  |    2 
 arch/s390/include/asm/facility.h                                    |    6 
 arch/s390/kernel/perf_cpum_sf.c                                     |   12 
 arch/s390/kvm/diag.c                                                |    2 
 arch/s390/kvm/gaccess.c                                             |  162 
 arch/s390/kvm/gaccess.h                                             |   14 
 arch/s390/mm/cmm.c                                                  |   18 
 arch/x86/include/asm/cpufeatures.h                                  |    3 
 arch/x86/include/asm/syscall.h                                      |    7 
 arch/x86/kernel/apic/apic.c                                         |   14 
 arch/x86/kernel/cpu/mshyperv.c                                      |    1 
 arch/x86/kernel/cpu/resctrl/core.c                                  |    4 
 arch/x86/xen/setup.c                                                |    2 
 block/bfq-iosched.c                                                 |   13 
 block/blk-rq-qos.c                                                  |    2 
 crypto/aead.c                                                       |    3 
 crypto/cipher.c                                                     |    3 
 drivers/acpi/acpica/dbconvert.c                                     |    2 
 drivers/acpi/acpica/exprep.c                                        |    3 
 drivers/acpi/acpica/psargs.c                                        |   47 
 drivers/acpi/battery.c                                              |   28 
 drivers/acpi/button.c                                               |   11 
 drivers/acpi/device_sysfs.c                                         |    5 
 drivers/acpi/ec.c                                                   |   55 
 drivers/acpi/pmic/tps68470_pmic.c                                   |    6 
 drivers/acpi/resource.c                                             |   27 
 drivers/ata/sata_sil.c                                              |   12 
 drivers/base/bus.c                                                  |    6 
 drivers/base/core.c                                                 |   13 
 drivers/base/firmware_loader/main.c                                 |   30 
 drivers/base/module.c                                               |    4 
 drivers/block/aoe/aoecmd.c                                          |   13 
 drivers/block/drbd/drbd_main.c                                      |    6 
 drivers/block/drbd/drbd_state.c                                     |    2 
 drivers/bluetooth/btmrvl_sdio.c                                     |   16 
 drivers/bluetooth/btusb.c                                           |   10 
 drivers/char/hw_random/mtk-rng.c                                    |    2 
 drivers/char/tpm/tpm-dev-common.c                                   |    2 
 drivers/char/tpm/tpm2-space.c                                       |    3 
 drivers/char/virtio_console.c                                       |   18 
 drivers/clk/bcm/clk-bcm53573-ilp.c                                  |    2 
 drivers/clk/qcom/clk-rpmh.c                                         |   33 
 drivers/clk/rockchip/clk-rk3228.c                                   |    2 
 drivers/clk/rockchip/clk.c                                          |    3 
 drivers/clk/ti/clk-dra7-atl.c                                       |    1 
 drivers/clocksource/timer-qcom.c                                    |    7 
 drivers/firmware/arm_sdei.c                                         |    2 
 drivers/firmware/tegra/bpmp.c                                       |    6 
 drivers/gpio/gpio-aspeed.c                                          |    4 
 drivers/gpio/gpio-davinci.c                                         |    8 
 drivers/gpio/gpiolib.c                                              |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                            |   15 
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c                      |   26 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                   |    2 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c              |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c   |    2 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c             |    2 
 drivers/gpu/drm/amd/include/atombios.h                              |    2 
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c                     |   10 
 drivers/gpu/drm/drm_atomic_uapi.c                                   |    2 
 drivers/gpu/drm/drm_crtc.c                                          |    1 
 drivers/gpu/drm/drm_mipi_dsi.c                                      |    2 
 drivers/gpu/drm/drm_print.c                                         |   13 
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                             |    2 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                               |    8 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h                               |    1 
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c                           |   26 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                             |    2 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c                            |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                  |    2 
 drivers/gpu/drm/nouveau/nouveau_dmem.c                              |    2 
 drivers/gpu/drm/omapdrm/omap_drv.c                                  |    5 
 drivers/gpu/drm/radeon/atombios.h                                   |    2 
 drivers/gpu/drm/radeon/evergreen_cs.c                               |   62 
 drivers/gpu/drm/radeon/r100.c                                       |   70 
 drivers/gpu/drm/radeon/radeon_atombios.c                            |   26 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                         |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                         |    4 
 drivers/gpu/drm/stm/drv.c                                           |    4 
 drivers/gpu/drm/vboxvideo/hgsmi_base.c                              |   10 
 drivers/gpu/drm/vboxvideo/vboxvideo.h                               |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                 |    1 
 drivers/hid/hid-ids.h                                               |    2 
 drivers/hid/hid-plantronics.c                                       |   23 
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c                         |    2 
 drivers/hwmon/max16065.c                                            |    5 
 drivers/hwmon/ntc_thermistor.c                                      |    1 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                     |    2 
 drivers/i2c/busses/i2c-aspeed.c                                     |   16 
 drivers/i2c/busses/i2c-i801.c                                       |    9 
 drivers/i2c/busses/i2c-isch.c                                       |    3 
 drivers/i2c/busses/i2c-qcom-geni.c                                  |   59 
 drivers/i2c/busses/i2c-stm32f7.c                                    |    6 
 drivers/i2c/busses/i2c-xiic.c                                       |   19 
 drivers/iio/adc/Kconfig                                             |    4 
 drivers/iio/adc/ad7606.c                                            |    8 
 drivers/iio/adc/ad7606_spi.c                                        |    5 
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c                 |    2 
 drivers/iio/dac/Kconfig                                             |    2 
 drivers/iio/light/opt3001.c                                         |    4 
 drivers/iio/magnetometer/ak8975.c                                   |   32 
 drivers/iio/proximity/Kconfig                                       |    2 
 drivers/infiniband/core/iwcm.c                                      |    2 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                            |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                          |    2 
 drivers/infiniband/hw/cxgb4/cm.c                                    |   14 
 drivers/infiniband/hw/hns/hns_roce_hem.c                            |   10 
 drivers/infiniband/sw/rxe/rxe_comp.c                                |    6 
 drivers/input/keyboard/adp5589-keys.c                               |   13 
 drivers/input/rmi4/rmi_driver.c                                     |    6 
 drivers/mailbox/bcm2835-mailbox.c                                   |    3 
 drivers/mailbox/rockchip-mailbox.c                                  |    2 
 drivers/media/common/videobuf2/videobuf2-core.c                     |    8 
 drivers/media/dvb-frontends/rtl2830.c                               |    2 
 drivers/media/dvb-frontends/rtl2832.c                               |    2 
 drivers/media/platform/qcom/venus/core.c                            |    1 
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c                  |    5 
 drivers/misc/sgi-gru/grukservices.c                                 |    2 
 drivers/misc/sgi-gru/grumain.c                                      |    4 
 drivers/misc/sgi-gru/grutlbpurge.c                                  |    2 
 drivers/misc/ti-st/st_core.c                                        |    4 
 drivers/mtd/devices/powernv_flash.c                                 |    3 
 drivers/mtd/devices/slram.c                                         |    2 
 drivers/net/Kconfig                                                 |   64 
 drivers/net/caif/Kconfig                                            |   36 
 drivers/net/ethernet/aeroflex/greth.c                               |    3 
 drivers/net/ethernet/amd/mvme147.c                                  |    7 
 drivers/net/ethernet/broadcom/bcmsysport.c                          |    1 
 drivers/net/ethernet/cortina/gemini.c                               |   15 
 drivers/net/ethernet/emulex/benet/be_main.c                         |   10 
 drivers/net/ethernet/faraday/ftgmac100.c                            |   26 
 drivers/net/ethernet/faraday/ftgmac100.h                            |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                      |    9 
 drivers/net/ethernet/freescale/fs_enet/Kconfig                      |    8 
 drivers/net/ethernet/hisilicon/hip04_eth.c                          |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                   |    1 
 drivers/net/ethernet/hisilicon/hns_mdio.c                           |    1 
 drivers/net/ethernet/i825xx/sun3_82586.c                            |    1 
 drivers/net/ethernet/ibm/emac/mal.c                                 |    2 
 drivers/net/ethernet/intel/ice/ice_sched.c                          |    6 
 drivers/net/ethernet/intel/ice/ice_switch.c                         |    4 
 drivers/net/ethernet/intel/igb/igb_main.c                           |    4 
 drivers/net/ethernet/jme.c                                          |   10 
 drivers/net/ethernet/lantiq_etop.c                                  |    4 
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h                          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                |    4 
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c               |   10 
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c                 |    5 
 drivers/net/ethernet/realtek/r8169_main.c                           |   35 
 drivers/net/ethernet/seeq/ether3.c                                  |    2 
 drivers/net/gtp.c                                                   |   27 
 drivers/net/hyperv/netvsc_drv.c                                     |   30 
 drivers/net/ieee802154/Kconfig                                      |   13 
 drivers/net/ieee802154/mcr20a.c                                     |    5 
 drivers/net/macsec.c                                                |   18 
 drivers/net/phy/vitesse.c                                           |   14 
 drivers/net/ppp/ppp_async.c                                         |    2 
 drivers/net/slip/slhc.c                                             |   57 
 drivers/net/usb/cdc_ncm.c                                           |    8 
 drivers/net/usb/ipheth.c                                            |    5 
 drivers/net/usb/usbnet.c                                            |    3 
 drivers/net/wireless/ath/Kconfig                                    |   12 
 drivers/net/wireless/ath/ar5523/Kconfig                             |   14 
 drivers/net/wireless/ath/ath10k/wmi-tlv.c                           |    7 
 drivers/net/wireless/ath/ath10k/wmi.c                               |    2 
 drivers/net/wireless/ath/ath9k/Kconfig                              |   58 
 drivers/net/wireless/ath/ath9k/debug.c                              |    6 
 drivers/net/wireless/ath/ath9k/hif_usb.c                            |    6 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c                      |    2 
 drivers/net/wireless/atmel/Kconfig                                  |   42 
 drivers/net/wireless/intel/iwlegacy/common.c                        |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                         |   22 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                   |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                       |    8 
 drivers/net/wireless/marvell/mwifiex/fw.h                           |    2 
 drivers/net/wireless/marvell/mwifiex/scan.c                         |    3 
 drivers/net/wireless/ralink/rt2x00/Kconfig                          |   44 
 drivers/net/wireless/realtek/rtw88/Kconfig                          |    1 
 drivers/net/wireless/realtek/rtw88/rtw8822c.c                       |   10 
 drivers/net/wireless/ti/wl12xx/Kconfig                              |    8 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                                  |    2 
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c                              |    1 
 drivers/nvdimm/nd_virtio.c                                          |    9 
 drivers/of/irq.c                                                    |   38 
 drivers/parport/procfs.c                                            |   22 
 drivers/pci/controller/dwc/pci-keystone.c                           |    2 
 drivers/pci/controller/pcie-xilinx-nwl.c                            |   24 
 drivers/pci/quirks.c                                                |    8 
 drivers/pinctrl/mvebu/pinctrl-dove.c                                |   42 
 drivers/pinctrl/pinctrl-at91.c                                      |    5 
 drivers/pinctrl/pinctrl-single.c                                    |    3 
 drivers/power/reset/brcmstb-reboot.c                                |    3 
 drivers/power/supply/axp20x_battery.c                               |   31 
 drivers/power/supply/max17042_battery.c                             |    5 
 drivers/pps/clients/pps_parport.c                                   |   14 
 drivers/reset/reset-berlin.c                                        |    3 
 drivers/rtc/rtc-at91sam9.c                                          |    1 
 drivers/s390/char/sclp_vt220.c                                      |    4 
 drivers/scsi/aacraid/aacraid.h                                      |    2 
 drivers/soc/versatile/soc-integrator.c                              |    1 
 drivers/soc/versatile/soc-realview.c                                |   20 
 drivers/soundwire/stream.c                                          |    8 
 drivers/spi/spi-bcm63xx.c                                           |    2 
 drivers/spi/spi-nxp-fspi.c                                          |    5 
 drivers/spi/spi-ppc4xx.c                                            |    7 
 drivers/spi/spi-s3c64xx.c                                           |    4 
 drivers/staging/iio/frequency/ad9832.c                              |    7 
 drivers/staging/wilc1000/wilc_hif.c                                 |    4 
 drivers/target/target_core_user.c                                   |    2 
 drivers/tty/serial/rp2.c                                            |    2 
 drivers/tty/vt/vt.c                                                 |    2 
 drivers/usb/chipidea/udc.c                                          |    8 
 drivers/usb/class/cdc-acm.c                                         |    2 
 drivers/usb/class/usbtmc.c                                          |    2 
 drivers/usb/dwc2/platform.c                                         |   26 
 drivers/usb/dwc3/core.c                                             |   22 
 drivers/usb/dwc3/core.h                                             |    4 
 drivers/usb/dwc3/gadget.c                                           |   11 
 drivers/usb/host/xhci-pci.c                                         |    5 
 drivers/usb/host/xhci-ring.c                                        |   16 
 drivers/usb/host/xhci.h                                             |    2 
 drivers/usb/misc/appledisplay.c                                     |   15 
 drivers/usb/misc/cypress_cy7c63.c                                   |    4 
 drivers/usb/misc/yurex.c                                            |    5 
 drivers/usb/phy/phy.c                                               |    2 
 drivers/usb/serial/option.c                                         |    8 
 drivers/usb/serial/pl2303.c                                         |    1 
 drivers/usb/serial/pl2303.h                                         |    4 
 drivers/usb/storage/unusual_devs.h                                  |   11 
 drivers/usb/typec/class.c                                           |    3 
 drivers/video/fbdev/hpfb.c                                          |    1 
 drivers/video/fbdev/pxafb.c                                         |    1 
 drivers/video/fbdev/sis/sis_main.c                                  |    2 
 drivers/watchdog/imx_sc_wdt.c                                       |   24 
 drivers/xen/swiotlb-xen.c                                           |    6 
 fs/btrfs/disk-io.c                                                  |   11 
 fs/btrfs/relocation.c                                               |    2 
 fs/ceph/addr.c                                                      |    1 
 fs/cifs/smb2pdu.c                                                   |    9 
 fs/erofs/decompressor.c                                             |   24 
 fs/exec.c                                                           |    3 
 fs/ext4/extents.c                                                   |    5 
 fs/ext4/ialloc.c                                                    |    2 
 fs/ext4/inline.c                                                    |   35 
 fs/ext4/inode.c                                                     |   11 
 fs/ext4/mballoc.c                                                   |   10 
 fs/ext4/migrate.c                                                   |    2 
 fs/ext4/namei.c                                                     |   14 
 fs/ext4/xattr.c                                                     |    4 
 fs/f2fs/acl.c                                                       |   23 
 fs/f2fs/dir.c                                                       |    3 
 fs/f2fs/f2fs.h                                                      |    4 
 fs/f2fs/file.c                                                      |   24 
 fs/f2fs/super.c                                                     |    4 
 fs/f2fs/xattr.c                                                     |   27 
 fs/fat/namei_vfat.c                                                 |    2 
 fs/fcntl.c                                                          |   14 
 fs/inode.c                                                          |    4 
 fs/jbd2/checkpoint.c                                                |   14 
 fs/jbd2/commit.c                                                    |   36 
 fs/jbd2/journal.c                                                   |    2 
 fs/jfs/jfs_discard.c                                                |   11 
 fs/jfs/jfs_dmap.c                                                   |   11 
 fs/jfs/jfs_imap.c                                                   |    2 
 fs/jfs/xattr.c                                                      |    2 
 fs/namespace.c                                                      |   23 
 fs/nfs/callback_xdr.c                                               |    2 
 fs/nfs/nfs4state.c                                                  |    1 
 fs/nfsd/nfs4idmap.c                                                 |   13 
 fs/nfsd/nfs4recover.c                                               |    8 
 fs/nfsd/nfs4state.c                                                 |   15 
 fs/nilfs2/btree.c                                                   |   12 
 fs/nilfs2/dir.c                                                     |   50 
 fs/nilfs2/namei.c                                                   |   42 
 fs/nilfs2/nilfs.h                                                   |    2 
 fs/nilfs2/page.c                                                    |    7 
 fs/ocfs2/aops.c                                                     |    5 
 fs/ocfs2/buffer_head_io.c                                           |    4 
 fs/ocfs2/file.c                                                     |    8 
 fs/ocfs2/journal.c                                                  |    7 
 fs/ocfs2/localalloc.c                                               |   19 
 fs/ocfs2/quota_local.c                                              |    8 
 fs/ocfs2/refcounttree.c                                             |   26 
 fs/ocfs2/xattr.c                                                    |   38 
 fs/proc/base.c                                                      |   61 
 fs/super.c                                                          |    3 
 fs/udf/inode.c                                                      |    9 
 fs/unicode/mkutf8data.c                                             |   70 
 fs/unicode/utf8data.h_shipped                                       | 6703 ++++------
 include/drm/drm_print.h                                             |   54 
 include/linux/fs.h                                                  |    2 
 include/linux/jbd2.h                                                |    4 
 include/linux/pci_ids.h                                             |    2 
 include/linux/skbuff.h                                              |    5 
 include/net/genetlink.h                                             |    3 
 include/net/mac80211.h                                              |   24 
 include/net/sch_generic.h                                           |    1 
 include/net/sock.h                                                  |    8 
 include/net/tcp.h                                                   |   21 
 include/trace/events/f2fs.h                                         |    3 
 include/trace/events/sched.h                                        |   84 
 include/uapi/linux/cec.h                                            |    6 
 include/uapi/linux/netfilter/nf_tables.h                            |    2 
 kernel/bpf/arraymap.c                                               |    3 
 kernel/bpf/devmap.c                                                 |    9 
 kernel/bpf/hashtab.c                                                |    3 
 kernel/bpf/helpers.c                                                |    4 
 kernel/bpf/lpm_trie.c                                               |    2 
 kernel/cgroup/cgroup.c                                              |    4 
 kernel/events/core.c                                                |    6 
 kernel/events/uprobes.c                                             |    2 
 kernel/kthread.c                                                    |   19 
 kernel/locking/lockdep.c                                            |  215 
 kernel/resource.c                                                   |   58 
 kernel/signal.c                                                     |   11 
 kernel/time/posix-clock.c                                           |    3 
 kernel/trace/trace.c                                                |   18 
 kernel/trace/trace_kprobe.c                                         |   76 
 kernel/trace/trace_output.c                                         |    6 
 kernel/trace/trace_probe.c                                          |    2 
 kernel/trace/trace_probe.h                                          |    1 
 lib/debugobjects.c                                                  |    5 
 lib/xz/xz_crc32.c                                                   |    2 
 lib/xz/xz_private.h                                                 |    4 
 mm/shmem.c                                                          |    2 
 mm/slab_common.c                                                    |    7 
 mm/swapfile.c                                                       |    2 
 mm/util.c                                                           |    2 
 net/bluetooth/af_bluetooth.c                                        |    1 
 net/bluetooth/bnep/core.c                                           |    3 
 net/bluetooth/rfcomm/sock.c                                         |    2 
 net/bridge/br_netfilter_hooks.c                                     |    5 
 net/can/bcm.c                                                       |    4 
 net/can/j1939/transport.c                                           |    8 
 net/core/dev.c                                                      |   29 
 net/core/sock_destructor.h                                          |   12 
 net/core/sock_map.c                                                 |    1 
 net/dccp/proto.c                                                    |    2 
 net/ipv4/af_inet.c                                                  |    2 
 net/ipv4/devinet.c                                                  |   41 
 net/ipv4/fib_frontend.c                                             |    2 
 net/ipv4/inet_connection_sock.c                                     |    2 
 net/ipv4/inet_fragment.c                                            |   70 
 net/ipv4/ip_fragment.c                                              |    2 
 net/ipv4/ip_gre.c                                                   |    6 
 net/ipv4/netfilter/nf_dup_ipv4.c                                    |    7 
 net/ipv4/tcp.c                                                      |    4 
 net/ipv4/tcp_diag.c                                                 |    4 
 net/ipv4/tcp_input.c                                                |   31 
 net/ipv4/tcp_ipv4.c                                                 |    5 
 net/ipv6/netfilter/nf_conntrack_reasm.c                             |    2 
 net/ipv6/netfilter/nf_dup_ipv6.c                                    |    7 
 net/ipv6/netfilter/nf_reject_ipv6.c                                 |   14 
 net/ipv6/tcp_ipv6.c                                                 |    2 
 net/l2tp/l2tp_netlink.c                                             |    4 
 net/mac80211/cfg.c                                                  |    6 
 net/mac80211/ieee80211_i.h                                          |    3 
 net/mac80211/iface.c                                                |   32 
 net/mac80211/key.c                                                  |   44 
 net/mac80211/mlme.c                                                 |   14 
 net/mac80211/tx.c                                                   |   78 
 net/mac80211/util.c                                                 |   45 
 net/netfilter/nf_conntrack_netlink.c                                |    7 
 net/netfilter/nf_tables_api.c                                       |    8 
 net/netfilter/nft_payload.c                                         |    3 
 net/netlink/af_netlink.c                                            |    3 
 net/netlink/genetlink.c                                             |   28 
 net/qrtr/qrtr.c                                                     |    2 
 net/sched/em_meta.c                                                 |    4 
 net/sched/sch_api.c                                                 |    9 
 net/sched/sch_taprio.c                                              |    7 
 net/sctp/diag.c                                                     |    4 
 net/sctp/socket.c                                                   |   24 
 net/tipc/bcast.c                                                    |    2 
 net/tipc/bearer.c                                                   |    8 
 net/wireless/nl80211.c                                              |   11 
 net/wireless/scan.c                                                 |    6 
 net/wireless/sme.c                                                  |    3 
 net/xfrm/xfrm_user.c                                                |    6 
 scripts/kconfig/merge_config.sh                                     |    2 
 security/Kconfig                                                    |   32 
 security/selinux/selinuxfs.c                                        |   31 
 security/smack/smackfs.c                                            |    2 
 security/tomoyo/domain.c                                            |    9 
 sound/core/init.c                                                   |   14 
 sound/firewire/amdtp-stream.c                                       |    3 
 sound/pci/asihpi/hpimsgx.c                                          |    2 
 sound/pci/hda/hda_generic.c                                         |    4 
 sound/pci/hda/patch_conexant.c                                      |   24 
 sound/pci/hda/patch_realtek.c                                       |  125 
 sound/pci/rme9652/hdsp.c                                            |    6 
 sound/pci/rme9652/hdspm.c                                           |    6 
 sound/soc/au1x/db1200.c                                             |    1 
 sound/soc/codecs/cs42l51.c                                          |    7 
 sound/soc/codecs/tda7419.c                                          |    1 
 sound/soc/meson/Kconfig                                             |    4 
 sound/soc/meson/Makefile                                            |    2 
 sound/soc/meson/axg-card.c                                          |  406 
 sound/soc/meson/meson-card-utils.c                                  |  385 
 sound/soc/meson/meson-card.h                                        |   55 
 tools/iio/iio_generic_buffer.c                                      |    4 
 tools/perf/builtin-sched.c                                          |    8 
 tools/perf/util/time-utils.c                                        |    4 
 tools/testing/ktest/ktest.pl                                        |    2 
 tools/testing/selftests/bpf/map_tests/sk_storage_map.c              |    2 
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c             |    1 
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c                    |    1 
 tools/testing/selftests/bpf/test_lru_map.c                          |    3 
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c         |    2 
 tools/testing/selftests/breakpoints/step_after_suspend_test.c       |    5 
 tools/testing/selftests/vDSO/parse_vdso.c                           |    3 
 tools/usb/usbip/src/usbip_detach.c                                  |    1 
 virt/kvm/kvm_main.c                                                 |    5 
 437 files changed, 7154 insertions(+), 5445 deletions(-)

Aaron Thompson (1):
      Bluetooth: Remove debugfs directory on module init failure

Abhishek Pandit-Subedi (1):
      Bluetooth: btmrvl_sdio: Refactor irq wakeup

Adrian Ratiu (1):
      proc: add config & param to block forcing mem writes

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: fix memory disclosure

Aleksandr Mishin (3):
      ACPI: PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()
      drm/msm: Fix incorrect file name output in adreno_request_fw()
      ice: Adjust over allocation of memory in ice_sched_add_root_node() and ice_sched_add_node()

Aleksandrs Vinarskis (1):
      ACPICA: iasl: handle empty connection_node

Alex Bee (1):
      drm/rockchip: vop: Allow 4096px width scaling

Alex Deucher (2):
      drm/amdgpu: properly handle vbios fake edid sizing
      drm/radeon: properly handle vbios fake edid sizing

Alex Hung (2):
      drm/amd/display: Check stream before comparing them
      drm/amd/display: Initialize get_bytes_per_element's default to 1

Alex Williamson (1):
      PCI: Mark Creative Labs EMU20k2 INTx masking as broken

Anastasia Kovaleva (1):
      net: Fix an unsafe loop on the list

Anders Roxell (1):
      scripts: kconfig: merge_config: config files: add a trailing newline

Andrew Davis (1):
      power: reset: brcmstb: Do not go into infinite loop if reset fails

Andrew Jones (1):
      of/irq: Support #msi-cells=<0> in of_msi_get_domain

Andrey Shumilin (2):
      fbdev: sisfb: Fix strbuf array overflow
      ALSA: firewire-lib: Avoid division by zero in apply_constraint_to_size()

Andrii Nakryiko (1):
      tracing/kprobes: Fix symbol counting logic by looking at modules as well

Andy Roulin (1):
      netfilter: br_netfilter: fix panic with metadata_dst skb

Andy Shevchenko (3):
      fs/namespace: fnic: Switch to use %ptTd
      spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ
      i2c: isch: Add missed 'else'

Ankit Agrawal (1):
      clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_timer_init()

Anshuman Khandual (1):
      arm64: Add Cortex-715 CPU part definition

Anthony Iliopoulos (1):
      mount: warn only once about timestamp range expiration

Anton Danilov (1):
      ipv4: ip_gre: Fix drops of small packets in ipgre_xmit

Anumula Murali Mohan Reddy (1):
      RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP

Armin Wolf (4):
      ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
      ACPICA: Fix memory leak if acpi_ps_get_next_field() fails
      ACPI: battery: Simplify battery hook locking
      ACPI: battery: Fix possible crash when unregistering a battery hook

Arnd Bergmann (1):
      nfsd: use ktime_get_seconds() for timestamps

Arseniy Krasnov (1):
      ASoC: meson: axg-card: fix 'use-after-free'

Artem Sadovnikov (1):
      ext4: fix i_data_sem unlock order in ext4_ind_migrate()

Artur Weber (1):
      power: supply: max17042_battery: Fix SOC threshold calc w/ no current sense

Baokun Li (4):
      ext4: propagate errors from ext4_find_extent() in ext4_insert_range()
      ext4: aovid use-after-free in ext4_ext_insert_extent()
      ext4: fix double brelse() the buffer of the extents path
      jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error

Barnabás Czémán (1):
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Ben Dooks (1):
      spi: s3c64xx: fix timeout counters in flush_fifo

Benjamin B. Frost (1):
      USB: serial: option: add support for Quectel EG916Q-GL

Benoît Monin (1):
      net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension

Billy Tsai (2):
      gpio: aspeed: Add the flush write to ensure the write complete.
      gpio: aspeed: Use devm_clk api to manage clock source

Bitterblue Smith (1):
      wifi: rtw88: 8822c: Fix reported RX band width

Bob Pearson (1):
      RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt

Breno Leitao (1):
      KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()

Byeonguk Jeong (1):
      bpf: Fix out-of-bounds write in trie_get_next_key()

Chao Yu (4):
      f2fs: enhance to update i_mode and acl atomically in f2fs_setattr()
      f2fs: fix to update i_ctime in __f2fs_setxattr()
      f2fs: remove unneeded check condition in __f2fs_setxattr()
      f2fs: reduce expensive checkpoint trigger frequency

Charles Han (1):
      mtd: powernv: Add check devm_kasprintf() returned value

Chen Yu (1):
      kthread: fix task state in kthread worker if being frozen

Chris Morgan (1):
      power: supply: axp20x_battery: Remove design from min and max voltage

Christian Heusel (1):
      ACPI: resource: Add LG 16T90SP to irq1_level_low_skip_override[]

Christoph Hellwig (1):
      fs: explicitly unregister per-superblock BDIs

Christophe JAILLET (6):
      fbdev: hpfb: Fix an error handling path in hpfb_dio_probe()
      drm/stm: Fix an error handling path in stm_drm_platform_probe()
      pps: remove usage of the deprecated ida_simple_xx() API
      iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()
      ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()
      gtp: simplify error handling code in 'gtp_encap_enable()'

Christophe Leroy (1):
      selftests: vDSO: fix vDSO symbols lookup for powerpc64

Chun-Yi Lee (1):
      aoe: fix the potential use-after-free problem in more places

Chunyan Zhang (1):
      riscv: Remove unused GENERATING_ASM_OFFSETS

Colin Ian King (1):
      r8169: Fix spelling mistake: "tx_underun" -> "tx_underrun"

Damien Le Moal (1):
      ata: sata_sil: Rename sil_blacklist to sil_quirks

Dan Carpenter (2):
      PCI: keystone: Fix if-statement expression in ks_pcie_quirk()
      SUNRPC: Fix integer overflow in decode_rc_list()

Daniel Borkmann (1):
      bpf: Fix bpf_strtol and bpf_strtoul helpers for 32bit

Daniel Gabay (2):
      wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()
      wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()

Daniel Jordan (1):
      ktest.pl: Avoid false positives with grub2 skip regex

Daniel Palmer (1):
      net: amd: mvme147: Fix probe banner message

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 MBIM compositions

Danilo Krummrich (1):
      mm: krealloc: consider spare memory for __GFP_ZERO

Dave Ertman (1):
      ice: fix VLAN replay after reset

Dave Kleikamp (1):
      jfs: Fix sanity check in dbMount

David Gow (1):
      mm: only enforce minimum stack gap size if it's sensible

David Lechner (1):
      clk: ti: dra7-atl: Fix leak of of_nodes

Dimitri Sivanich (1):
      misc: sgi-gru: Don't disable preemption in GRU driver

Dmitry Antipov (5):
      wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()
      wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors
      wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()
      net: sched: consistently use rcu_replace_pointer() in taprio_change()
      net: sched: fix use-after-free in taprio_change()

Dmitry Kandybka (1):
      wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()

Edward Adam Davis (5):
      USB: usbtmc: prevent kernel-usb-infoleak
      jfs: Fix uaf in dbFreeBits
      jfs: check if leafidx greater than num leaves per dmap tree
      ext4: no need to continue when the number of entries is 1
      ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow

Emanuele Ghidoli (1):
      gpio: davinci: fix lazy disable

Emil Gedenryd (1):
      iio: light: opt3001: add missing full-scale range value

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead
      wifi: iwlwifi: mvm: disconnect station vifs if recovery failed

Eric Dumazet (11):
      sock_map: Add a cond_resched() in sock_hash_free()
      netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
      netfilter: nf_tables: prevent nf_skb_duplicated corruption
      net: avoid potential underflow in qdisc_pkt_len_init() with UFO
      net: add more sanity checks to qdisc_pkt_len_init()
      net/sched: accept TCA_STAB only for root qdisc
      net: annotate lockless accesses to sk->sk_ack_backlog
      net: annotate lockless accesses to sk->sk_max_ack_backlog
      ppp: fix ppp_async_encode() illegal access
      slip: make slhc_remember() more robust against malicious packets
      genetlink: hold RCU in genlmsg_mcast()

Faisal Hassan (1):
      xhci: Fix Link TRB DMA in command ring stopped completion event

Felix Fietkau (2):
      wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys
      wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower

Ferry Meng (2):
      ocfs2: add bounds checking to ocfs2_xattr_find_entry()
      ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()

Filipe Manana (1):
      btrfs: wait for fixup workers before stopping cleaner kthread during umount

Florian Fainelli (1):
      tty: rp2: Fix reset with non forgiving PCIe host bridges

Florian Klink (1):
      ARM: dts: bcm2837-rpi-cm3-io3: Fix HDMI hpd-gpio pin

Florian Westphal (1):
      inet: inet_defrag: prevent sk release while still in use

Foster Snowhill (1):
      usbnet: ipheth: fix carrier detection in modes 1 and 4

Francis Laniel (1):
      tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols

Gabriel Krisman Bertazi (1):
      unicode: Don't special case ignorable code points

Gao Xiang (1):
      erofs: fix lz4 inplace decompression

Gautham Ananthakrishna (1):
      ocfs2: reserve space for inline xattr before attaching reflink tree

Geert Uytterhoeven (2):
      drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()
      of/irq: Refer to actual buffer size in of_irq_parse_one()

Gerald Schaefer (1):
      s390/mm: Add cond_resched() to cmm_alloc/free_pages()

Gianfranco Trad (1):
      udf: fix uninit-value use in udf_get_fileshortad

Greg Kroah-Hartman (2):
      Revert "driver core: Fix uevent_show() vs driver detach race"
      Linux 5.4.285

Guenter Roeck (1):
      hwmon: (max16065) Fix overflows seen when writing limits

Guillaume Stols (2):
      iio: adc: ad7606: fix oversampling gpio array
      iio: adc: ad7606: fix standby gpio state to match the documentation

Guoqing Jiang (2):
      nfsd: call cache_put if xdr_reserve_space returns NULL
      hwrng: mtk - Use devm_pm_runtime_enable

Gustavo A. R. Silva (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()

Hagar Hemdan (1):
      gpio: prevent potential speculation leaks in gpio_device_get_desc()

Hailey Mothershead (1):
      crypto: aead,cipher - zeroize key buffer after use

Haiyang Zhang (1):
      hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event

Han Xu (1):
      spi: nxp-fspi: fix the KASAN report out-of-bounds bug

Hans Verkuil (1):
      media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags

Hans de Goede (4):
      ACPI: resource: Add Asus Vivobook X1704VAP to irq1_level_low_skip_override[]
      ACPI: resource: Add Asus ExpertBook B2502CVA to irq1_level_low_skip_override[]
      i2c: i801: Use a different adapter-name for IDF adapters
      drm/vboxvideo: Replace fake VLA at end of vbva_mouse_pointer_shape with real VLA

Harshit Mogalapalli (1):
      usb: yurex: Fix inconsistent locking bug in yurex_read()

Heiko Carstens (1):
      s390/facility: Disable compile time optimization for decompressor code

Heiner Kallweit (2):
      r8169: add tally counter fields added with RTL8125
      r8169: avoid unsolicited interrupts

Helge Deller (3):
      parisc: Fix itlb miss handler for 64-bit programs
      parisc: Fix 64-bit userspace syscall path
      parisc: Fix stack start for ADDR_NO_RANDOMIZE personality

Heming Zhao (1):
      ocfs2: fix the la space leak when unmounting an ocfs2 volume

Hermann Lauer (1):
      power: supply: axp20x_battery: allow disabling battery charging

Hongbo Li (1):
      ASoC: allow module autoloading for table db1200_pids

Huang Ying (1):
      resource: fix region_intersects() vs add_memory_driver_managed()

Ian Rogers (1):
      perf time-utils: Fix 32-bit nsec parsing

Icenowy Zheng (1):
      usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip

Ido Schimmel (1):
      ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family

Jacky Chou (2):
      net: ftgmac100: Enable TX interrupt to avoid TX timeout
      net: ftgmac100: Ensure tx descriptor updates are visible

Jacob Keller (1):
      ice: fix accounting for filters shared by multiple VSIs

Janis Schoetterl-Glausch (3):
      KVM: s390: gaccess: Refactor gpa and length calculation
      KVM: s390: gaccess: Refactor access address range check
      KVM: s390: gaccess: Cleanup access to guest pages

Jann Horn (2):
      firmware_loader: Block path traversal
      f2fs: Require FMODE_WRITE for atomic write ioctls

Jaroslav Kysela (1):
      ALSA: core: add isascii() check to card ID generator

Jason Xing (1):
      tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process

Jason-JH.Lin (1):
      Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"

Javier Carrasco (5):
      iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig
      iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig
      iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig

Jeongjun Park (3):
      jfs: fix out-of-bounds in dbNextAG() and diAlloc()
      mm: shmem: fix data-race in shmem_getattr()
      vt: prevent kernel-infoleak in con_font_get()

Jerome Brunet (1):
      ASoC: meson: axg: extract sound card utils

Jiawei Ye (2):
      wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param
      smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso

Jim Mattson (1):
      x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET

Jinjie Ruan (10):
      riscv: Fix fp alignment bug in perf_callchain_user()
      ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
      ieee802154: Fix build error
      net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
      Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
      nfp: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: bcm63xx: Fix module autoloading
      i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()
      posix-clock: Fix missing timespec64 check in pc_clock_settime()
      posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()

Jisheng Zhang (1):
      riscv: define ILLEGAL_POINTER_VALUE for 64bit

Johannes Berg (3):
      wifi: mac80211: fix potential key use-after-free
      mac80211: do drv_reconfig_complete() before restarting all
      mac80211: always have ieee80211_sta_restart()

Jonas Blixt (1):
      watchdog: imx_sc_wdt: Don't disable WDT in suspend

Jonas Karlman (2):
      drm/rockchip: dw_hdmi: Fix reading EDID when using a forced mode
      clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228

Jonathan Marek (1):
      drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation

Jonathan McDowell (1):
      tpm: Clean up TPM space after command failure

Jose Alberto Reguero (1):
      usb: xhci: Fix problem with xhci resume from suspend

Joseph Qi (2):
      ocfs2: fix uninit-value in ocfs2_get_block()
      ocfs2: cancel dqi_sync_work before freeing oinfo

Josh Hunt (1):
      tcp: check skb is non-NULL in tcp_rto_delta_us()

José Relvas (1):
      ALSA: hda/realtek: Add subwoofer quirk for Acer Predator G9-593

Juergen Gross (2):
      xen: use correct end address of kernel for conflict checking
      xen/swiotlb: add alignment check for dma buffers

Julian Sun (2):
      vfs: fix race between evice_inodes() and find_inode()&iput()
      ocfs2: fix null-ptr-deref when journal load failed.

Junhao Xie (1):
      USB: serial: pl2303: add device id for Macrosilicon MS3020

Junlin Li (2):
      drivers: media: dvb-frontends/rtl2832: fix an out-of-bounds write error
      drivers: media: dvb-frontends/rtl2830: fix an out-of-bounds write error

Junxian Huang (1):
      RDMA/hns: Optimize hem allocation performance

Kailang Yang (3):
      ALSA: hda/realtek - Fixed ALC256 headphone no sound
      ALSA: hda/realtek - FIxed ALC285 headphone no sound
      ALSA: hda/realtek: Update default depop procedure

Kaixin Wang (3):
      net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition
      fbdev: pxafb: Fix possible use after free in pxafb_task()
      ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition

Kalesh AP (1):
      RDMA/bnxt_re: Return more meaningful error

Kees Cook (2):
      x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()
      scsi: aacraid: Rearrange order of struct aac_srb_unit

Kemeng Shi (1):
      ext4: avoid negative min_clusters in find_group_orlov()

Krzysztof Kozlowski (14):
      soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"
      ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property
      ARM: versatile: fix OF node leak in CPUs prepare
      reset: berlin: fix OF node leak in probe() error path
      soc: versatile: integrator: fix OF node leak in probe() error path
      soc: versatile: realview: fix memory leak during device remove
      soc: versatile: realview: fix soc_dev leak during device remove
      drivers: net: Fix Kconfig indentation, continued
      net: hisilicon: hip04: fix OF node leak in probe()
      net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
      net: hisilicon: hns_mdio: fix OF node leak in probe()
      firmware: tegra: bpmp: Drop unused mbox_client_to_bpmp()
      rtc: at91sam9: fix OF node leak in probe() error path
      clk: bcm: bcm53573: fix OF node leak in init

Kuniyuki Iwashima (2):
      can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().
      ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).

Lasse Collin (1):
      xz: cleanup CRC32 edits from 2018

Laurent Pinchart (2):
      Remove *.orig pattern from .gitignore
      media: sun4i_csi: Implement link validate for sun4i_csi subdev

Lee Jones (1):
      usb: yurex: Replace snprintf() with the safer scnprintf() variant

Leo Yan (1):
      tracing: Consider the NULL character when validating the event length

Li Lingfeng (2):
      nfsd: return -EINVAL when namelen is 0
      nfs: fix memory leak in error path of nfs4_do_reclaim

Liao Chen (3):
      ASoC: tda7419: fix module autoloading
      spi: bcm63xx: Enable module autoloading
      mailbox: rockchip: fix a typo in module autoloading

Linus Walleij (1):
      net: ethernet: cortina: Drop TSO support

Liu Shixin (1):
      mm/swapfile: skip HugeTLB pages for unuse_vma

Lizhi Xu (2):
      ocfs2: remove unreasonable unlock in ocfs2_read_blocks
      ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

Luis Henriques (SUSE) (2):
      ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
      ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()

Luiz Augusto von Dentz (3):
      Bluetooth: btusb: Fix not handling ZPL/short-transfer
      Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
      Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

Luo Gengkun (1):
      perf/core: Fix small negative period being ignored

Ma Ke (3):
      spi: ppc4xx: handle irq_of_parse_and_map() errors
      pps: add an error check in parport_attach
      drm: omapdrm: Add missing check for alloc_ordered_workqueue

Maciej Falkowski (1):
      dt-bindings: gpu: Convert Samsung Image Rotator to dt-schema

Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Marek Vasut (1):
      i2c: stm32f7: Do not prepare/unprepare clock during runtime suspend/resume

Mario Limonciello (1):
      drm/amd: Guard against bad data for ATIF ACPI method

Mark Rutland (5):
      arm64: cputype: Add Neoverse-N3 definitions
      arm64: errata: Expand speculative SSBS workaround once more
      arm64: probes: Remove broken LDR (literal) uprobe support
      arm64: probes: Fix simulate_ldr*_literal()
      arm64: probes: Fix uprobes for big-endian kernels

Masami Hiramatsu (1):
      selftests: breakpoints: Fix a typo of function name

Mathias Krause (1):
      Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal

Mathias Nyman (1):
      xhci: Fix incorrect stream context type macro

Mathy Vanhoef (2):
      mac80211: parse radiotap header when selecting Tx queue
      mac80211: Fix NULL ptr deref for injected rate info

Matthew Brost (1):
      drm/printer: Allow NULL data in devcoredump printer

Mauricio Faria de Oliveira (1):
      jbd2: introduce/export functions jbd2_journal_submit|finish_inode_data_buffers()

Michael Kelley (1):
      x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency

Michael Mueller (1):
      KVM: s390: Change virtual to physical address access in diag 0x258 handler

Michael S. Tsirkin (1):
      virtio_console: fix misc probe bugs

Mickaël Salaün (1):
      fs: Fix file_set_fowner LSM hook inconsistencies

Mike Rapoport (1):
      microblaze: don't treat zero reserved memory regions as error

Mike Tipton (1):
      clk: qcom: clk-rpmh: Fix overflow in BCM vote

Mikhail Lobanov (2):
      RDMA/cxgb4: Added NULL check for lookup_atid
      drbd: Add NULL check for net_conf to prevent dereference in state validation

Minjie Du (1):
      wifi: ath9k: fix parameter check in ath9k_init_debug()

Mirsad Todorovac (1):
      mtd: slram: insert break after errors in parsing the map

Mohamed Khalfella (2):
      net/mlx5: Added cond_resched() to crdump collection
      igb: Do not bring the device up after non-fatal error

Moon Yeounsu (1):
      net: ethernet: use ip_hdrlen() instead of bit shift

Nathan Chancellor (1):
      x86/resctrl: Annotate get_mem_config() functions as __init

Neal Cardwell (2):
      tcp: fix to allow timestamp undo if no retransmits were sent
      tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe

NeilBrown (1):
      nfsd: fix delegation_blocked() to block correctly for at least 30 seconds

Nico Boehr (1):
      KVM: s390: gaccess: Check if guest address is in memslot

Nikita Zhandarovich (3):
      drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets
      f2fs: prevent possible int overflow in dir_block_index()
      f2fs: avoid potential int overflow in sanity_check_area_boundary()

Nikolay Kuratov (1):
      drm/vmwgfx: Handle surface check failure correctly

Nuno Sa (1):
      Input: adp5589-keys - fix adp5589_gpio_get_value()

OGAWA Hirofumi (1):
      fat: fix uninitialized variable

Oder Chiou (1):
      ALSA: hda/realtek: Fix the push button function for the ALC257

Olaf Hering (1):
      mount: handle OOM on mnt_warn_timestamp_expiry

Oleg Nesterov (1):
      uprobes: fix kernel info leak via "[uprobes]" vma

Oliver Neukum (7):
      USB: appledisplay: close race between probe and completion handler
      USB: misc: cypress_cy7c63: check for short transfer
      USB: class: CDC-ACM: fix race between get_serial and set_serial
      USB: misc: yurex: fix race between read and write
      CDC-NCM: avoid overflow in sanity checking
      Revert "usb: yurex: Replace snprintf() with the safer scnprintf() variant"
      net: usb: usbnet: fix name regression

Omar Sandoval (1):
      blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_function race

Pablo Neira Ayuso (5):
      netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire
      netfilter: nf_tables: reject element expiration with no timeout
      netfilter: nf_tables: reject expiration higher than timeout
      gtp: allow -1 to be specified as file description from userspace
      netfilter: nft_payload: sanitize offset and length before calling skb_checksum()

Paul Moore (1):
      selinux: improve error checking in sel_write_load()

Paulo Alcantara (1):
      smb: client: fix OOBs when building SMB2_IOCTL request

Paulo Miguel Almeida (2):
      drm/amdgpu: Replace one-element array with flexible-array member
      drm/radeon: Replace one-element array with flexible-array member

Pawel Dembicki (1):
      net: phy: vitesse: repair vsc73xx autonegotiation

Pedro Tammela (1):
      net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Pei Xiao (1):
      ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()

Peter Zijlstra (2):
      locking/lockdep: Fix bad recursion pattern
      locking/lockdep: Rework lockdep_lock

Phil Sutter (1):
      netfilter: uapi: NFTA_FLOWTABLE_HOOK is NLA_NESTED

Philip Chen (1):
      virtio_pmem: Check device status before requesting flush

Qiu-ji Chen (1):
      drbd: Fix atomicity violation in drbd_uuid_set_bm()

Qu Wenruo (1):
      btrfs: fix a NULL pointer dereference when failed to start a new trasacntion

Quentin Schulz (1):
      arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog on RK3399 Puma

Qun-Wei Lin (1):
      mm: krealloc: Fix MTE false alarm in __do_krealloc

Rafael J. Wysocki (1):
      ACPI: EC: Do not release locks during operation region accesses

Remington Brasga (1):
      jfs: UBSAN: shift-out-of-bounds in dbFindBits

Rob Clark (2):
      kthread: add kthread_work tracepoints
      drm/crtc: fix uninitialized variable use even harder

Robert Hancock (1):
      i2c: xiic: Wait for TX empty to avoid missed TX NAKs

Robin Chen (1):
      drm/amd/display: Round calculated vtotal

Rosen Penev (1):
      net: ibm: emac: mal: fix wrong goto

Ryusuke Konishi (7):
      nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()
      nilfs2: determine empty node blocks as corrupted
      nilfs2: fix potential oob read in nilfs_btree_check_delete()
      nilfs2: propagate directory read errors from nilfs_find_entry()
      nilfs2: fix kernel bug due to missing clearing of buffer delay flag
      nilfs2: fix potential deadlock with newly created symlinks
      nilfs2: fix kernel bug due to missing clearing of checked flag

Sabrina Dubroca (2):
      macsec: don't increment counters for an unrelated SA
      xfrm: validate new SA's prefixlen using SA family when sel.family is unset

Saravanan Vajravel (1):
      RDMA/bnxt_re: Fix incorrect AVID type in WQE structure

Sean Anderson (3):
      net: dpaa: Pad packets to ETH_ZLEN
      PCI: xilinx-nwl: Fix register misspelling
      PCI: xilinx-nwl: Fix off-by-one in INTx IRQ handler

Sebastian Reichel (1):
      clk: rockchip: fix error for unknown clocks

Selvarasu Ganesan (1):
      usb: dwc3: core: Stop processing of pending events if controller is halted

Shahar Shitrit (1):
      net/mlx5e: Add missing link modes to ptys2ethtool_map

Shawn Shao (1):
      usb: dwc2: Adjust the timing of USB Driver Interrupt Registration in the Crashkernel Scenario

Sherry Yang (1):
      drm/msm: fix %s null argument error

Shubham Panwar (1):
      ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix initial lid detection issue

Simon Horman (3):
      netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS
      tipc: guard against string buffer overrun
      net: mvpp2: Increase size of queue_name buffer

Srinivasan Shanmugam (1):
      drm/amd/display: Fix index out of bounds in degamma hardware format translation

Stefan Wahren (1):
      mailbox: bcm2835: Fix timeout during suspend mode

Stephen Boyd (3):
      i2c: qcom-geni: Let firmware specify irq trigger flags
      i2c: qcom-geni: Grow a dev pointer to simplify code
      clk: qcom: rpmh: Simplify clk_rpmh_bcm_send_cmd()

Steven Rostedt (Google) (2):
      tracing: Remove precision vsnprintf() check from print event
      tracing: Have saved_cmdlines arrays all in one allocation

Su Hui (1):
      net: tipc: avoid possible garbage value

Subramanian Ananthanarayanan (1):
      PCI: Add ACS quirk for Qualcomm SA8775P

SurajSonawane2415 (1):
      hid: intel-ish-hid: Fix uninitialized variable 'rv' in ish_fw_xfer_direct_dma

Suzuki K Poulose (1):
      coresight: tmc: sg: Do not leak sg_table

Takashi Iwai (5):
      ALSA: hda/generic: Unconditionally prefer preferred_dacs pairs
      ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin
      ALSA: asihpi: Fix potential OOB array access
      ALSA: hdsp: Break infinite MIDI input flush loop
      parport: Proper fix for array out-of-bounds access

Tao Chen (1):
      bpf: Check percpu map value size first

Tetsuo Handa (1):
      tomoyo: fallback to realpath if symlink's pathname does not exist

Thadeu Lima de Souza Cascardo (4):
      ext4: return error on ext4_find_inline_entry
      ext4: avoid OOB when system.data xattr changes underneath the filesystem
      ext4: ext4_search_dir should return a proper error
      usb: typec: altmode should keep reference to parent

Thomas Blocher (1):
      pinctrl: at91: make it work with current gpiolib

Thomas Gleixner (2):
      PCI: xilinx-nwl: Use irq_data_get_irq_chip_data()
      signal: Replace BUG_ON()s

Thomas Richter (1):
      s390/cpum_sf: Remove WARN_ON_ONCE statements

Thomas Weißschuh (2):
      ACPI: sysfs: validate return type of _STR method
      s390/sclp_vt220: Convert newlines to CRLF instead of LFCR

Thomas Zimmermann (1):
      drm: Consistently use struct drm_mode_rect for FB_DAMAGE_CLIPS

Toke Høiland-Jørgensen (3):
      bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
      wifi: ath9k: Remove error checks when creating debugfs entries
      wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

Tommy Huang (1):
      i2c: aspeed: Update the stop sw state when the bus recovery occurs

Tony Ambardar (4):
      selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
      selftests/bpf: Fix compiling flow_dissector.c with musl-libc
      selftests/bpf: Fix compiling tcp_rtt.c with musl-libc
      selftests/bpf: Fix error compiling test_lru_map.c

Ville Syrjälä (1):
      wifi: iwlegacy: Clear stale interrupts before resuming device

Vladimir Lypak (3):
      drm/msm/a5xx: disable preemption in submits by default
      drm/msm/a5xx: properly clear preemption records on resume
      drm/msm/a5xx: fix races in preemption evaluation stage

Wade Wang (1):
      HID: plantronics: Workaround for an unexcepted opposite volume key

Waiman Long (1):
      locking/lockdep: Avoid potential access of invalid memory in lock_class

Wang Hai (4):
      net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()
      net: systemport: fix potential memory leak in bcm_sysport_xmit()
      net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
      be2net: fix potential memory leak in be_xmit()

Wang Jianzheng (1):
      pinctrl: mvebu: Fix devinit_dove_pinctrl_probe function

WangYuli (1):
      PCI: Add function 0 DMA alias quirk for Glenfly Arise chip

Werner Sembach (1):
      ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Wojciech Gładysz (1):
      ext4: nested locking for xattr inode

Wolfram Sang (1):
      ipmi: docs: don't advertise deprecated sysfs entries

Xin Long (4):
      sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start
      sctp: ensure sk_state is set to CLOSED if hashing fails in sctp_listen_start
      ipv4: give an IPv4 dev to blackhole_netdev
      net: support ip generic csum processing in skb_csum_hwoffload_help

Xiongfeng Wang (1):
      firmware: arm_sdei: Fix the input parameter of cpuhp_remove_state()

Xiu Jianfeng (1):
      cgroup: Fix potential overflow issue when checking max_depth

Xiubo Li (1):
      ceph: remove the incorrect Fw reference check when dirtying pages

Xu Yang (1):
      usb: chipidea: udc: enable suspend interrupt after usb reset

Yang Jihong (2):
      perf sched timehist: Fix missing free of session in perf_sched__timehist()
      perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time

Yang Yingliang (1):
      pinctrl: single: fix missing error code in pcs_probe()

Ye Bin (1):
      Bluetooth: bnep: fix wild-memory-access in proto_unregister

Yifei Liu (1):
      selftests: breakpoints: use remaining time to check if suspend succeed

Yonatan Maman (1):
      nouveau/dmem: Fix vulnerability in migrate_to_ram upon copy error

Yonggil Song (1):
      f2fs: fix typo

Youghandhar Chintala (1):
      mac80211: Add support to trigger sta disconnect on hardware restart

Youssef Samir (1):
      net: qrtr: Update packets cloning when broadcasting

Yu Kuai (3):
      block, bfq: fix possible UAF for bfqq->bic with merge chain
      block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()
      block, bfq: don't break merge chain in bfq_split_bfqq()

Yuesong Li (1):
      drivers:drm:exynos_drm_gsc:Fix wrong assignment in gsc_bind()

Yunke Cao (1):
      media: videobuf2-core: clear memory related fields in __vb2_plane_dmabuf_put()

Yuntao Liu (1):
      hwmon: (ntc_thermistor) fix module autoloading

Zhang Changzhong (1):
      can: j1939: use correct function name in comment

Zhang Rui (1):
      x86/apic: Always explicitly disarm TSC-deadline timer

Zhao Mengmeng (1):
      jfs: Fix uninit-value access of new_ea in ea_buffer

Zhen Lei (1):
      debugobjects: Fix conditions in fill_pool()

Zheng Wang (1):
      media: venus: fix use after free bug in venus_remove due to race condition

Zhiguo Niu (1):
      lockdep: fix deadlock issue between lockdep and rcu

Zhu Jun (1):
      tools/iio: Add memory allocation failure check for trigger_name

Zhu Yanjun (1):
      RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency

Zicheng Qu (1):
      staging: iio: frequency: ad9832: fix division by zero in ad9832_calc_freqreg()

Zijun Hu (2):
      driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
      usb: phy: Fix API devm_usb_put_phy() can not release the phy

Zong-Zhe Yang (1):
      wifi: rtw88: select WANT_DEV_COREDUMP

Zongmin Zhou (1):
      usbip: tools: Fix detach_port() invalid port error path

hongchi.peng (1):
      drm: komeda: Fix an issue related to normalized zpos

junhua huang (2):
      arm64:uprobe fix the uprobe SWBP_INSN in big-endian
      arm64/uprobes: change the uprobe_opcode_t typedef to fix the sparse warning

rd.dunlab@gmail.com (1):
      Minor fixes to the CAIF Transport drivers Kconfig file

yangerkun (1):
      ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard

zhanchengbin (1):
      ext4: fix inode tree inconsistency caused by ENOMEM

zhong jiang (1):
      drivers/misc: ti-st: Remove unneeded variable in st_tty_open


