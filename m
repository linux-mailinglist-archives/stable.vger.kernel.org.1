Return-Path: <stable+bounces-86618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE09A23E4
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7262A1F23110
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1EB1DE2BB;
	Thu, 17 Oct 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="akaeUVie"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05321DE2B6;
	Thu, 17 Oct 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172061; cv=none; b=vFiF2MaL1yyM4mQK73xwPIYzV3KAK9gJjpZX+2iIspVi5WbEW///2GS7D7HzXpqdLqFWKYIMkAjUAvSa/T8wpZIhgOY/JFXmXRfLbVmGb4bE24Xx72gBbUMq7UQN2IzTVfKwj/vY0XwtAlGfz6N/RbvyNRQ0CtStY0bTGDMnQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172061; c=relaxed/simple;
	bh=CpP1SLllQuSrzjY94HxXs94zHJ+L6Au7uiERMWT3oak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RnXXd2JSwT4BZr0u6Y+4Opb+5CYb8dEXzO2WtXHodRyEh3lhKomRJ3bMoKrcS27DpEEbCFEKpEmyRnzO6SA9aReLnGgfEtIz5w7hZr5vvYpP5fo5kYd4GTdzq2SD2M93VDhSao1ds3NUiI4/jcN3cHn7zTjxIR0qyE/dFh9rx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=akaeUVie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC78C4CEC3;
	Thu, 17 Oct 2024 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729172060;
	bh=CpP1SLllQuSrzjY94HxXs94zHJ+L6Au7uiERMWT3oak=;
	h=From:To:Cc:Subject:Date:From;
	b=akaeUViexRzW41uyoSmkN2NTV+BtnUr2wiTJ8vfD+tya3NUk4xU8SIVES5Lg3A96r
	 rytt6Eck24UQ2MSK1oEIY1Pg0NG+lYqlk8sc8XDG3O5BSBl6XhqtDGTZgqHyF4VnUC
	 JNePxRkVn69xswogS4aKqr9pzo4Fs1AKz0EnHgXQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.227
Date: Thu, 17 Oct 2024 15:34:15 +0200
Message-ID: <2024101715-dumpster-cattishly-3a1b@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.227 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                          |    1 
 Documentation/admin-guide/kernel-parameters.txt                     |   10 
 Documentation/arm64/silicon-errata.rst                              |    4 
 Documentation/driver-api/ipmi.rst                                   |    2 
 Makefile                                                            |    2 
 arch/arm/boot/dts/imx7d-zii-rmu2.dts                                |    2 
 arch/arm/boot/dts/sam9x60.dtsi                                      |    4 
 arch/arm/mach-realview/platsmp-dt.c                                 |    1 
 arch/arm64/Kconfig                                                  |    2 
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts                |    4 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                       |   23 
 arch/arm64/include/asm/cputype.h                                    |    4 
 arch/arm64/kernel/cpu_errata.c                                      |    2 
 arch/m68k/kernel/process.c                                          |    2 
 arch/microblaze/mm/init.c                                           |    5 
 arch/parisc/kernel/entry.S                                          |    6 
 arch/parisc/kernel/syscall.S                                        |   14 
 arch/powerpc/kernel/setup-common.c                                  |    1 
 arch/powerpc/mm/mem.c                                               |    2 
 arch/riscv/Kconfig                                                  |    5 
 arch/riscv/kernel/perf_callchain.c                                  |    2 
 arch/s390/include/asm/facility.h                                    |    6 
 arch/s390/kernel/perf_cpum_sf.c                                     |   12 
 arch/s390/mm/cmm.c                                                  |   18 
 arch/x86/events/intel/pt.c                                          |   15 
 arch/x86/include/asm/syscall.h                                      |    7 
 arch/x86/kernel/cpu/mshyperv.c                                      |    1 
 arch/x86/kernel/kprobes/core.c                                      |   11 
 arch/x86/mm/init.c                                                  |   16 
 arch/x86/xen/setup.c                                                |    2 
 block/bfq-iosched.c                                                 |   13 
 block/blk-iocost.c                                                  |    8 
 block/partitions/core.c                                             |    8 
 drivers/acpi/acpica/dbconvert.c                                     |    2 
 drivers/acpi/acpica/exprep.c                                        |    3 
 drivers/acpi/acpica/psargs.c                                        |   47 
 drivers/acpi/battery.c                                              |   28 
 drivers/acpi/device_sysfs.c                                         |    5 
 drivers/acpi/ec.c                                                   |   55 
 drivers/acpi/pmic/tps68470_pmic.c                                   |    6 
 drivers/acpi/resource.c                                             |   20 
 drivers/ata/sata_sil.c                                              |   12 
 drivers/base/bus.c                                                  |    6 
 drivers/base/firmware_loader/main.c                                 |   30 
 drivers/base/property.c                                             |    4 
 drivers/block/aoe/aoecmd.c                                          |   13 
 drivers/block/drbd/drbd_main.c                                      |    6 
 drivers/block/drbd/drbd_state.c                                     |    2 
 drivers/bluetooth/btmrvl_sdio.c                                     |    3 
 drivers/bluetooth/btusb.c                                           |    5 
 drivers/bus/arm-integrator-lm.c                                     |    1 
 drivers/char/hw_random/cctrng.c                                     |    1 
 drivers/char/hw_random/mtk-rng.c                                    |    2 
 drivers/char/tpm/tpm-dev-common.c                                   |    2 
 drivers/char/tpm/tpm2-space.c                                       |    3 
 drivers/char/virtio_console.c                                       |   18 
 drivers/clk/bcm/clk-bcm53573-ilp.c                                  |    2 
 drivers/clk/imx/clk-imx7d.c                                         |    4 
 drivers/clk/imx/clk-imx8mp.c                                        |    4 
 drivers/clk/qcom/clk-rpmh.c                                         |    2 
 drivers/clk/qcom/dispcc-sm8250.c                                    |    3 
 drivers/clk/qcom/gcc-sm8250.c                                       |    6 
 drivers/clk/rockchip/clk-rk3228.c                                   |    2 
 drivers/clk/rockchip/clk.c                                          |    3 
 drivers/clk/ti/clk-dra7-atl.c                                       |    1 
 drivers/clocksource/timer-qcom.c                                    |    7 
 drivers/cpufreq/ti-cpufreq.c                                        |   10 
 drivers/crypto/ccp/sev-dev.c                                        |    2 
 drivers/dma-buf/heaps/heap-helpers.c                                |    2 
 drivers/firmware/efi/libstub/tpm.c                                  |    2 
 drivers/firmware/tegra/bpmp.c                                       |    6 
 drivers/gpio/gpio-aspeed.c                                          |    4 
 drivers/gpio/gpio-davinci.c                                         |    8 
 drivers/gpio/gpiolib-cdev.c                                         |   13 
 drivers/gpio/gpiolib.c                                              |    3 
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c                      |   26 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                               |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c         |    2 
 drivers/gpu/drm/amd/display/dc/core/dc.c                            |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                   |    2 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c              |    2 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c              |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c   |    2 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c             |    2 
 drivers/gpu/drm/amd/include/atombios.h                              |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c            |    2 
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c                     |   10 
 drivers/gpu/drm/drm_atomic_uapi.c                                   |    2 
 drivers/gpu/drm/drm_crtc.c                                          |    1 
 drivers/gpu/drm/drm_print.c                                         |   13 
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                             |    2 
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c                               |    3 
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c                               |    3 
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c                               |    3 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                               |   20 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h                               |    2 
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c                           |   30 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                               |    9 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h                               |   10 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                             |    4 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c                            |    2 
 drivers/gpu/drm/msm/msm_debugfs.c                                   |    7 
 drivers/gpu/drm/msm/msm_drv.c                                       |   13 
 drivers/gpu/drm/msm/msm_drv.h                                       |   15 
 drivers/gpu/drm/msm/msm_gem.c                                       |   28 
 drivers/gpu/drm/msm/msm_gem_shrinker.c                              |   12 
 drivers/gpu/drm/msm/msm_gpu.c                                       |    2 
 drivers/gpu/drm/msm/msm_gpu.h                                       |   16 
 drivers/gpu/drm/nouveau/nouveau_dmem.c                              |    2 
 drivers/gpu/drm/omapdrm/omap_drv.c                                  |    5 
 drivers/gpu/drm/radeon/atombios.h                                   |    2 
 drivers/gpu/drm/radeon/evergreen_cs.c                               |   62 
 drivers/gpu/drm/radeon/r100.c                                       |   70 
 drivers/gpu/drm/radeon/radeon_atombios.c                            |   26 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                         |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                         |  113 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h                         |    3 
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c                         |   25 
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h                         |    1 
 drivers/gpu/drm/scheduler/sched_entity.c                            |    2 
 drivers/gpu/drm/stm/drv.c                                           |    4 
 drivers/hid/hid-ids.h                                               |    2 
 drivers/hid/hid-plantronics.c                                       |   23 
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c                         |    2 
 drivers/hwmon/Kconfig                                               |    2 
 drivers/hwmon/max16065.c                                            |   27 
 drivers/hwmon/ntc_thermistor.c                                      |    1 
 drivers/hwmon/pmbus/pmbus.h                                         |    8 
 drivers/hwmon/pmbus/pmbus_core.c                                    |   39 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                     |    2 
 drivers/i2c/busses/i2c-aspeed.c                                     |   16 
 drivers/i2c/busses/i2c-i801.c                                       |    9 
 drivers/i2c/busses/i2c-isch.c                                       |    3 
 drivers/i2c/busses/i2c-qcom-geni.c                                  |    4 
 drivers/i2c/busses/i2c-stm32f7.c                                    |    6 
 drivers/i2c/busses/i2c-xiic.c                                       |  145 
 drivers/i2c/i2c-core-base.c                                         |   19 
 drivers/iio/adc/ad7606.c                                            |    8 
 drivers/iio/adc/ad7606_spi.c                                        |    5 
 drivers/iio/magnetometer/ak8975.c                                   |   32 
 drivers/infiniband/core/iwcm.c                                      |    2 
 drivers/infiniband/core/mad.c                                       |   14 
 drivers/infiniband/hw/cxgb4/cm.c                                    |    5 
 drivers/infiniband/hw/hns/hns_roce_hem.c                            |  255 
 drivers/infiniband/hw/hns/hns_roce_mr.c                             |   56 
 drivers/infiniband/hw/hns/hns_roce_qp.c                             |   16 
 drivers/infiniband/sw/rxe/rxe_comp.c                                |    6 
 drivers/input/keyboard/adp5589-keys.c                               |   13 
 drivers/input/mouse/synaptics.c                                     |    1 
 drivers/input/rmi4/rmi_driver.c                                     |    6 
 drivers/input/serio/i8042-acpipnpio.h                               |   46 
 drivers/input/touchscreen/ads7846.c                                 |    2 
 drivers/input/touchscreen/goodix.c                                  |   18 
 drivers/interconnect/qcom/sm8250.c                                  |    1 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                          |    7 
 drivers/iommu/intel/dmar.c                                          |   16 
 drivers/iommu/intel/iommu.c                                         |    6 
 drivers/mailbox/bcm2835-mailbox.c                                   |    3 
 drivers/mailbox/rockchip-mailbox.c                                  |    2 
 drivers/md/dm-rq.c                                                  |    4 
 drivers/md/dm.c                                                     |   11 
 drivers/media/common/videobuf2/videobuf2-core.c                     |    8 
 drivers/media/dvb-frontends/rtl2830.c                               |    2 
 drivers/media/dvb-frontends/rtl2832.c                               |    2 
 drivers/media/platform/qcom/venus/core.c                            |    1 
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c                  |    5 
 drivers/media/usb/usbtv/usbtv-video.c                               |    7 
 drivers/mtd/devices/powernv_flash.c                                 |    3 
 drivers/mtd/devices/slram.c                                         |    2 
 drivers/net/bareudp.c                                               |   25 
 drivers/net/can/m_can/m_can.c                                       |   13 
 drivers/net/can/m_can/m_can.h                                       |    2 
 drivers/net/can/m_can/m_can_platform.c                              |   13 
 drivers/net/dsa/b53/b53_common.c                                    |   17 
 drivers/net/dsa/lan9303-core.c                                      |   29 
 drivers/net/dsa/microchip/ksz9477.c                                 |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c                 |    4 
 drivers/net/ethernet/cortina/gemini.c                               |   15 
 drivers/net/ethernet/faraday/ftgmac100.c                            |   26 
 drivers/net/ethernet/faraday/ftgmac100.h                            |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                      |    9 
 drivers/net/ethernet/freescale/enetc/enetc.c                        |    3 
 drivers/net/ethernet/hisilicon/hip04_eth.c                          |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                   |    1 
 drivers/net/ethernet/hisilicon/hns_mdio.c                           |    1 
 drivers/net/ethernet/ibm/emac/mal.c                                 |    2 
 drivers/net/ethernet/intel/ice/ice_sched.c                          |    6 
 drivers/net/ethernet/intel/ice/ice_switch.c                         |    4 
 drivers/net/ethernet/intel/igb/igb_main.c                           |    4 
 drivers/net/ethernet/jme.c                                          |   10 
 drivers/net/ethernet/lantiq_etop.c                                  |    4 
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h                          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                     |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c               |   10 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                      |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c                 |    2 
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c                 |    5 
 drivers/net/ethernet/realtek/r8169_main.c                           |   31 
 drivers/net/ethernet/realtek/r8169_phy_config.c                     |    2 
 drivers/net/ethernet/seeq/ether3.c                                  |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                     |    1 
 drivers/net/geneve.c                                                |   91 
 drivers/net/ieee802154/Kconfig                                      |    1 
 drivers/net/ieee802154/mcr20a.c                                     |    5 
 drivers/net/phy/bcm84881.c                                          |    4 
 drivers/net/phy/dp83869.c                                           |    1 
 drivers/net/phy/vitesse.c                                           |   14 
 drivers/net/ppp/ppp_async.c                                         |    2 
 drivers/net/slip/slhc.c                                             |   57 
 drivers/net/usb/ipheth.c                                            |    5 
 drivers/net/vrf.c                                                   |   13 
 drivers/net/wireless/ath/ath11k/dp_rx.c                             |    2 
 drivers/net/wireless/ath/ath9k/debug.c                              |    4 
 drivers/net/wireless/ath/ath9k/hif_usb.c                            |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                   |    9 
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c            |    3 
 drivers/net/wireless/marvell/mwifiex/fw.h                           |    2 
 drivers/net/wireless/marvell/mwifiex/scan.c                         |    3 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                    |    3 
 drivers/net/wireless/microchip/wilc1000/hif.c                       |    4 
 drivers/net/wireless/realtek/rtw88/Kconfig                          |    1 
 drivers/net/wireless/realtek/rtw88/main.c                           |    7 
 drivers/net/wireless/realtek/rtw88/rtw8822c.c                       |   10 
 drivers/net/xen-netback/hash.c                                      |    5 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                                  |    2 
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c                              |    1 
 drivers/ntb/test/ntb_perf.c                                         |    2 
 drivers/nvdimm/nd_virtio.c                                          |    9 
 drivers/of/irq.c                                                    |   38 
 drivers/pci/controller/dwc/pci-keystone.c                           |    2 
 drivers/pci/controller/pcie-xilinx-nwl.c                            |   24 
 drivers/pci/quirks.c                                                |    8 
 drivers/pinctrl/mvebu/pinctrl-dove.c                                |   45 
 drivers/pinctrl/pinctrl-at91.c                                      |    5 
 drivers/pinctrl/pinctrl-single.c                                    |    3 
 drivers/platform/x86/touchscreen_dmi.c                              |   26 
 drivers/power/reset/brcmstb-reboot.c                                |    3 
 drivers/power/supply/axp20x_battery.c                               |   31 
 drivers/power/supply/max17042_battery.c                             |    5 
 drivers/powercap/intel_rapl_msr.c                                   |    2 
 drivers/pps/clients/pps_parport.c                                   |   14 
 drivers/reset/reset-berlin.c                                        |    3 
 drivers/rtc/rtc-at91sam9.c                                          |    1 
 drivers/s390/char/zcore.c                                           |   44 
 drivers/scsi/aacraid/aacraid.h                                      |    2 
 drivers/soc/versatile/soc-integrator.c                              |    1 
 drivers/soc/versatile/soc-realview.c                                |   20 
 drivers/soundwire/stream.c                                          |    8 
 drivers/spi/spi-bcm63xx.c                                           |    2 
 drivers/spi/spi-fsl-lpspi.c                                         |    9 
 drivers/spi/spi-imx.c                                               |    2 
 drivers/spi/spi-nxp-fspi.c                                          |    5 
 drivers/spi/spi-ppc4xx.c                                            |    7 
 drivers/spi/spi-s3c64xx.c                                           |    4 
 drivers/staging/media/atomisp/pci/sh_css_frac.h                     |   26 
 drivers/tty/serial/rp2.c                                            |    2 
 drivers/usb/chipidea/udc.c                                          |    8 
 drivers/usb/class/cdc-acm.c                                         |    2 
 drivers/usb/class/usbtmc.c                                          |    2 
 drivers/usb/dwc2/platform.c                                         |   26 
 drivers/usb/dwc3/core.c                                             |   63 
 drivers/usb/dwc3/core.h                                             |   15 
 drivers/usb/dwc3/gadget.c                                           |   11 
 drivers/usb/host/xhci-pci-renesas.c                                 |    5 
 drivers/usb/host/xhci-pci.c                                         |   15 
 drivers/usb/host/xhci-pci.h                                         |    3 
 drivers/usb/misc/appledisplay.c                                     |   15 
 drivers/usb/misc/cypress_cy7c63.c                                   |    4 
 drivers/usb/misc/yurex.c                                            |    5 
 drivers/usb/serial/pl2303.c                                         |    1 
 drivers/usb/serial/pl2303.h                                         |    4 
 drivers/usb/storage/unusual_devs.h                                  |   11 
 drivers/vhost/scsi.c                                                |   27 
 drivers/vhost/vdpa.c                                                |   18 
 drivers/video/fbdev/hpfb.c                                          |    1 
 drivers/video/fbdev/pxafb.c                                         |    1 
 drivers/video/fbdev/sis/sis_main.c                                  |    2 
 drivers/virtio/virtio_vdpa.c                                        |    1 
 drivers/watchdog/imx_sc_wdt.c                                       |   24 
 drivers/xen/swiotlb-xen.c                                           |    6 
 fs/btrfs/disk-io.c                                                  |   11 
 fs/btrfs/inode.c                                                    |    1 
 fs/btrfs/relocation.c                                               |    2 
 fs/ceph/addr.c                                                      |    1 
 fs/exec.c                                                           |    3 
 fs/exfat/balloc.c                                                   |   10 
 fs/ext4/extents.c                                                   |   57 
 fs/ext4/file.c                                                      |  155 
 fs/ext4/ialloc.c                                                    |   14 
 fs/ext4/inline.c                                                    |   35 
 fs/ext4/inode.c                                                     |   11 
 fs/ext4/mballoc.c                                                   |   10 
 fs/ext4/migrate.c                                                   |    2 
 fs/ext4/move_extent.c                                               |    1 
 fs/ext4/namei.c                                                     |   14 
 fs/ext4/xattr.c                                                     |    4 
 fs/f2fs/acl.c                                                       |   23 
 fs/f2fs/dir.c                                                       |    3 
 fs/f2fs/f2fs.h                                                      |    4 
 fs/f2fs/file.c                                                      |   24 
 fs/f2fs/super.c                                                     |    4 
 fs/f2fs/xattr.c                                                     |   27 
 fs/fcntl.c                                                          |   14 
 fs/inode.c                                                          |    4 
 fs/jbd2/checkpoint.c                                                |   14 
 fs/jbd2/journal.c                                                   |    2 
 fs/jfs/jfs_discard.c                                                |   11 
 fs/jfs/jfs_dmap.c                                                   |   11 
 fs/jfs/jfs_imap.c                                                   |    2 
 fs/jfs/xattr.c                                                      |    2 
 fs/namespace.c                                                      |   23 
 fs/nfs/callback_xdr.c                                               |    2 
 fs/nfs/client.c                                                     |    1 
 fs/nfs/delegation.c                                                 |   15 
 fs/nfs/nfs42proc.c                                                  |    2 
 fs/nfs/nfs4state.c                                                  |    3 
 fs/nfsd/filecache.c                                                 |    7 
 fs/nfsd/nfs4idmap.c                                                 |   13 
 fs/nfsd/nfs4recover.c                                               |    8 
 fs/nfsd/nfs4state.c                                                 |    5 
 fs/nfsd/nfs4xdr.c                                                   |   10 
 fs/nfsd/vfs.c                                                       |    1 
 fs/nilfs2/btree.c                                                   |   12 
 fs/ocfs2/aops.c                                                     |    5 
 fs/ocfs2/buffer_head_io.c                                           |    4 
 fs/ocfs2/journal.c                                                  |    7 
 fs/ocfs2/localalloc.c                                               |   19 
 fs/ocfs2/quota_local.c                                              |    8 
 fs/ocfs2/refcounttree.c                                             |   26 
 fs/ocfs2/xattr.c                                                    |   38 
 fs/proc/base.c                                                      |   61 
 fs/super.c                                                          |    3 
 fs/unicode/mkutf8data.c                                             |   70 
 fs/unicode/utf8data.h_shipped                                       | 6703 ++++------
 include/drm/drm_print.h                                             |   54 
 include/linux/cgroup-defs.h                                         |    7 
 include/linux/fs.h                                                  |    2 
 include/linux/i2c.h                                                 |    2 
 include/linux/kallsyms.h                                            |    7 
 include/linux/module.h                                              |    9 
 include/linux/nfs_fs_sb.h                                           |    1 
 include/linux/pci_ids.h                                             |    2 
 include/linux/property.h                                            |    4 
 include/linux/skbuff.h                                              |    5 
 include/linux/vdpa.h                                                |    6 
 include/net/flow.h                                                  |    6 
 include/net/ip_tunnels.h                                            |   16 
 include/net/netfilter/nf_tables.h                                   |   13 
 include/net/sch_generic.h                                           |    1 
 include/net/sock.h                                                  |    2 
 include/net/tcp.h                                                   |   21 
 include/trace/events/f2fs.h                                         |    3 
 include/trace/events/sched.h                                        |   84 
 include/uapi/linux/cec.h                                            |    6 
 include/uapi/linux/if_link.h                                        |    1 
 include/uapi/linux/netfilter/nf_tables.h                            |    2 
 kernel/bpf/arraymap.c                                               |    3 
 kernel/bpf/devmap.c                                                 |   20 
 kernel/bpf/hashtab.c                                                |    3 
 kernel/bpf/helpers.c                                                |    4 
 kernel/bpf/trampoline.c                                             |   20 
 kernel/cgroup/cgroup-internal.h                                     |    3 
 kernel/cgroup/cgroup.c                                              |   14 
 kernel/events/core.c                                                |    6 
 kernel/events/uprobes.c                                             |    2 
 kernel/kallsyms.c                                                   |    2 
 kernel/kprobes.c                                                    |    8 
 kernel/kthread.c                                                    |   19 
 kernel/locking/lockdep.c                                            |   48 
 kernel/module.c                                                     |    2 
 kernel/padata.c                                                     |    6 
 kernel/rcu/rcuscale.c                                               |    4 
 kernel/resource.c                                                   |   58 
 kernel/signal.c                                                     |   11 
 kernel/trace/ftrace.c                                               |   71 
 kernel/trace/trace.c                                                |   18 
 kernel/trace/trace_kprobe.c                                         |   76 
 kernel/trace/trace_output.c                                         |    6 
 kernel/trace/trace_probe.h                                          |    1 
 lib/debugobjects.c                                                  |    5 
 lib/xz/xz_crc32.c                                                   |    2 
 lib/xz/xz_private.h                                                 |    4 
 mm/slab_common.c                                                    |    7 
 mm/util.c                                                           |    2 
 net/bluetooth/l2cap_sock.c                                          |   52 
 net/bluetooth/rfcomm/sock.c                                         |    2 
 net/bridge/br_netfilter_hooks.c                                     |    5 
 net/can/bcm.c                                                       |    4 
 net/can/j1939/transport.c                                           |    8 
 net/core/dev.c                                                      |   12 
 net/core/sock_destructor.h                                          |   12 
 net/core/sock_map.c                                                 |    1 
 net/ipv4/devinet.c                                                  |    6 
 net/ipv4/fib_frontend.c                                             |    9 
 net/ipv4/fib_semantics.c                                            |    2 
 net/ipv4/fib_trie.c                                                 |    7 
 net/ipv4/fou.c                                                      |    4 
 net/ipv4/inet_fragment.c                                            |   70 
 net/ipv4/ip_fragment.c                                              |    2 
 net/ipv4/ip_gre.c                                                   |   10 
 net/ipv4/ip_tunnel.c                                                |    9 
 net/ipv4/netfilter/ipt_rpfilter.c                                   |    3 
 net/ipv4/netfilter/nf_dup_ipv4.c                                    |    7 
 net/ipv4/netfilter/nft_fib_ipv4.c                                   |    5 
 net/ipv4/route.c                                                    |    4 
 net/ipv4/tcp_input.c                                                |   31 
 net/ipv4/tcp_ipv4.c                                                 |    3 
 net/ipv4/xfrm4_policy.c                                             |    4 
 net/ipv6/Kconfig                                                    |    1 
 net/ipv6/ip6_output.c                                               |    3 
 net/ipv6/netfilter/ip6t_rpfilter.c                                  |    6 
 net/ipv6/netfilter/nf_conntrack_reasm.c                             |    2 
 net/ipv6/netfilter/nf_dup_ipv6.c                                    |    7 
 net/ipv6/netfilter/nf_reject_ipv6.c                                 |   14 
 net/ipv6/netfilter/nft_fib_ipv6.c                                   |    8 
 net/ipv6/route.c                                                    |   12 
 net/ipv6/rpl_iptunnel.c                                             |   12 
 net/ipv6/seg6_local.c                                               |    1 
 net/ipv6/xfrm6_policy.c                                             |    3 
 net/l3mdev/l3mdev.c                                                 |   43 
 net/mac80211/iface.c                                                |   17 
 net/mptcp/options.c                                                 |    2 
 net/mptcp/pm_netlink.c                                              |   27 
 net/mptcp/protocol.h                                                |    5 
 net/mptcp/subflow.c                                                 |    2 
 net/netfilter/nf_conntrack_netlink.c                                |    7 
 net/netfilter/nf_tables_api.c                                       |   15 
 net/netfilter/nft_lookup.c                                          |    1 
 net/netfilter/nft_set_pipapo.c                                      |    6 
 net/netlink/af_netlink.c                                            |    3 
 net/qrtr/af_qrtr.c                                                  |    2 
 net/sched/sch_api.c                                                 |    7 
 net/sched/sch_taprio.c                                              |    4 
 net/sctp/socket.c                                                   |   20 
 net/tipc/bcast.c                                                    |    2 
 net/tipc/bearer.c                                                   |    8 
 net/wireless/nl80211.c                                              |    3 
 net/wireless/scan.c                                                 |    6 
 net/wireless/sme.c                                                  |    3 
 net/xfrm/xfrm_policy.c                                              |    4 
 scripts/kconfig/merge_config.sh                                     |    2 
 scripts/kconfig/qconf.cc                                            |    2 
 security/Kconfig                                                    |   32 
 security/selinux/hooks.c                                            |    3 
 security/smack/smack_lsm.c                                          |    3 
 security/smack/smackfs.c                                            |    2 
 security/tomoyo/domain.c                                            |    9 
 sound/core/init.c                                                   |   14 
 sound/core/oss/mixer_oss.c                                          |    4 
 sound/pci/asihpi/hpimsgx.c                                          |    2 
 sound/pci/hda/hda_generic.c                                         |    4 
 sound/pci/hda/hda_intel.c                                           |    2 
 sound/pci/hda/patch_conexant.c                                      |   24 
 sound/pci/hda/patch_realtek.c                                       |   78 
 sound/pci/rme9652/hdsp.c                                            |    6 
 sound/pci/rme9652/hdspm.c                                           |    6 
 sound/soc/au1x/db1200.c                                             |    1 
 sound/soc/codecs/rt5682.c                                           |    4 
 sound/soc/codecs/tda7419.c                                          |    1 
 sound/soc/intel/keembay/kmb_platform.c                              |    1 
 sound/soc/meson/axg-card.c                                          |    3 
 sound/usb/card.c                                                    |    6 
 sound/usb/line6/podhd.c                                             |    2 
 sound/usb/quirks-table.h                                            |   77 
 tools/iio/iio_generic_buffer.c                                      |    4 
 tools/perf/builtin-sched.c                                          |    8 
 tools/perf/util/time-utils.c                                        |    4 
 tools/testing/ktest/ktest.pl                                        |    2 
 tools/testing/selftests/bpf/bench.c                                 |    1 
 tools/testing/selftests/bpf/map_tests/sk_storage_map.c              |    2 
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c             |    1 
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c                  |    1 
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c                    |    1 
 tools/testing/selftests/bpf/progs/cg_storage_multi.h                |    2 
 tools/testing/selftests/bpf/test_cpp.cpp                            |    4 
 tools/testing/selftests/bpf/test_lru_map.c                          |    3 
 tools/testing/selftests/breakpoints/step_after_suspend_test.c       |    5 
 tools/testing/selftests/net/fcnal-test.sh                           |    2 
 tools/testing/selftests/vDSO/parse_vdso.c                           |    3 
 tools/testing/selftests/vm/charge_reserved_hugetlb.sh               |    2 
 tools/testing/selftests/vm/write_to_hugetlbfs.c                     |   21 
 483 files changed, 7111 insertions(+), 5131 deletions(-)

Adrian Hunter (1):
      perf/x86/intel/pt: Fix sampling synchronization

Adrian Ratiu (1):
      proc: add config & param to block forcing mem writes

Ai Chao (1):
      ALSA: hda/realtek: Add quirk for Huawei MateBook 13 KLV-WX9

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

Alex Hung (4):
      drm/amd/display: Check null pointers before using dc->clk_mgr
      drm/amd/display: Check stream before comparing them
      drm/amd/display: Initialize get_bytes_per_element's default to 1
      drm/amd/display: Check null pointer before dereferencing se

Alex Williamson (1):
      PCI: Mark Creative Labs EMU20k2 INTx masking as broken

Alexander Dahl (1):
      ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks

Alexander Egorenkov (2):
      s390/zcore: no need to check return value of debugfs_create functions
      s390/zcore: release dump save area on restart or power down

Alexander Stein (2):
      spi: lpspi: Silence error message upon deferred probe
      spi: lpspi: release requested DMA channels

Anastasia Kovaleva (1):
      net: Fix an unsafe loop on the list

Anatolij Gustschin (1):
      net: dsa: lan9303: ensure chip reset and wait for READY status

Anders Roxell (1):
      scripts: kconfig: merge_config: config files: add a trailing newline

Andi Shyti (1):
      i2c: xiic: Use devm_clk_get_enabled()

Andrea Mayer (1):
      net: seg6: fix seg6_lookup_any_nexthop() to handle VRFs using flowi_l3mdev

Andrew Davis (2):
      hwmon: (max16065) Remove use of i2c_match_id()
      power: reset: brcmstb: Do not go into infinite loop if reset fails

Andrew Jones (1):
      of/irq: Support #msi-cells=<0> in of_msi_get_domain

Andrey Shumilin (1):
      fbdev: sisfb: Fix strbuf array overflow

Andrii Nakryiko (1):
      tracing/kprobes: Fix symbol counting logic by looking at modules as well

Andy Roulin (1):
      netfilter: br_netfilter: fix panic with metadata_dst skb

Andy Shevchenko (4):
      fs/namespace: fnic: Switch to use %ptTd
      spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ
      device property: Add const qualifier to device_get_match_data() parameter
      i2c: isch: Add missed 'else'

Ankit Agrawal (1):
      clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_timer_init()

Anshuman Khandual (1):
      arm64: Add Cortex-715 CPU part definition

Anthony Iliopoulos (1):
      mount: warn only once about timestamp range expiration

Antoine Tenart (1):
      net: vrf: determine the dst using the original ifindex for multicast

Anton Danilov (1):
      ipv4: ip_gre: Fix drops of small packets in ipgre_xmit

Ard Biesheuvel (1):
      efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption

Armin Wolf (4):
      ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
      ACPICA: Fix memory leak if acpi_ps_get_next_field() fails
      ACPI: battery: Simplify battery hook locking
      ACPI: battery: Fix possible crash when unregistering a battery hook

Arseniy Krasnov (1):
      ASoC: meson: axg-card: fix 'use-after-free'

Artem Sadovnikov (1):
      ext4: fix i_data_sem unlock order in ext4_ind_migrate()

Artur Weber (1):
      power: supply: max17042_battery: Fix SOC threshold calc w/ no current sense

Baokun Li (8):
      ext4: avoid use-after-free in ext4_ext_show_leaf()
      ext4: fix slab-use-after-free in ext4_split_extent_at()
      ext4: propagate errors from ext4_find_extent() in ext4_insert_range()
      ext4: drop ppath from ext4_ext_replay_update_ex() to avoid double-free
      ext4: aovid use-after-free in ext4_ext_insert_extent()
      ext4: fix double brelse() the buffer of the extents path
      ext4: update orig_path in ext4_find_extent()
      jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error

Barnabás Czémán (1):
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Ben Dooks (1):
      spi: s3c64xx: fix timeout counters in flush_fifo

Benjamin Berg (1):
      wifi: iwlwifi: lower message level for FW buffer destination

Benjamin Gaignard (1):
      media: usbtv: Remove useless locks in usbtv_video_free()

Biju Das (1):
      i2c: Add i2c_get_match_data()

Billy Tsai (2):
      gpio: aspeed: Add the flush write to ensure the write complete.
      gpio: aspeed: Use devm_clk api to manage clock source

Bitterblue Smith (1):
      wifi: rtw88: 8822c: Fix reported RX band width

Bob Pearson (1):
      RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt

Chao Yu (4):
      f2fs: enhance to update i_mode and acl atomically in f2fs_setattr()
      f2fs: fix to update i_ctime in __f2fs_setxattr()
      f2fs: remove unneeded check condition in __f2fs_setxattr()
      f2fs: reduce expensive checkpoint trigger frequency

Charles Han (1):
      mtd: powernv: Add check devm_kasprintf() returned value

Chen Yu (1):
      kthread: fix task state in kthread worker if being frozen

Chengchang Tang (1):
      RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled

Chris Morgan (1):
      power: supply: axp20x_battery: Remove design from min and max voltage

Christian Heusel (1):
      block: print symbolic error name instead of error code

Christoph Hellwig (1):
      fs: explicitly unregister per-superblock BDIs

Christophe JAILLET (6):
      fbdev: hpfb: Fix an error handling path in hpfb_dio_probe()
      drm/stm: Fix an error handling path in stm_drm_platform_probe()
      pps: remove usage of the deprecated ida_simple_xx() API
      spi: lpspi: Simplify some error message
      ALSA: mixer_oss: Remove some incorrect kfree_const() usages
      net: phy: bcm84881: Fix some error handling paths

Christophe Leroy (2):
      powerpc/mm: Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL
      selftests: vDSO: fix vDSO symbols lookup for powerpc64

Chuck Lever (2):
      NFSD: Fix NFSv4's PUTPUBFH operation
      NFSD: Mark filecache "down" if init fails

Chun-Yi Lee (1):
      aoe: fix the potential use-after-free problem in more places

Ckath (1):
      platform/x86: touchscreen_dmi: add nanote-next quirk

Colin Ian King (1):
      r8169: Fix spelling mistake: "tx_underun" -> "tx_underrun"

Damien Le Moal (1):
      ata: sata_sil: Rename sil_blacklist to sil_quirks

Dan Carpenter (2):
      PCI: keystone: Fix if-statement expression in ks_pcie_quirk()
      SUNRPC: Fix integer overflow in decode_rc_list()

Daniel Borkmann (1):
      bpf: Fix bpf_strtol and bpf_strtoul helpers for 32bit

Daniel Jordan (1):
      ktest.pl: Avoid false positives with grub2 skip regex

Danilo Krummrich (1):
      mm: krealloc: consider spare memory for __GFP_ZERO

Dave Ertman (1):
      ice: fix VLAN replay after reset

David Ahern (3):
      net: Add l3mdev index to flow struct and avoid oif reset for port devices
      xfrm: Pass flowi_oif or l3mdev as oif to xfrm_dst_lookup
      net: Handle l3mdev in ip_tunnel_init_flow

David Gow (1):
      mm: only enforce minimum stack gap size if it's sensible

David Hildenbrand (1):
      selftests/mm: fix charge_reserved_hugetlb.sh test

David Lechner (1):
      clk: ti: dra7-atl: Fix leak of of_nodes

Davide Caratti (1):
      mptcp: validate 'id' when stopping the ADD_ADDR retransmit timer

Dmitry Antipov (5):
      wifi: rtw88: always wait for both firmware loading attempts
      wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()
      wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors
      wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()
      net: sched: consistently use rcu_replace_pointer() in taprio_change()

Dmitry Baryshkov (1):
      clk: qcom: dispcc-sm8250: use CLK_SET_RATE_PARENT for branch clocks

Dmitry Kandybka (1):
      wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()

Dragan Simic (2):
      arm64: dts: rockchip: Raise Pinebook Pro's panel backlight PWM frequency
      arm64: dts: rockchip: Correct the Pinebook Pro battery design capacity

Edward Adam Davis (5):
      mptcp: pm: Fix uaf in __timer_delete_sync
      USB: usbtmc: prevent kernel-usb-infoleak
      jfs: Fix uaf in dbFreeBits
      jfs: check if leafidx greater than num leaves per dmap tree
      ext4: no need to continue when the number of entries is 1

Emanuele Ghidoli (1):
      gpio: davinci: fix lazy disable

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead

Eric Dumazet (8):
      sock_map: Add a cond_resched() in sock_hash_free()
      netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
      netfilter: nf_tables: prevent nf_skb_duplicated corruption
      net: avoid potential underflow in qdisc_pkt_len_init() with UFO
      net: add more sanity checks to qdisc_pkt_len_init()
      net/sched: accept TCA_STAB only for root qdisc
      ppp: fix ppp_async_encode() illegal access
      slip: make slhc_remember() more robust against malicious packets

Eyal Birger (2):
      net: geneve: support IPv4/IPv6 as inner protocol
      net: geneve: add missing netlink policy and size for IFLA_GENEVE_INNER_PROTO_INHERIT

Faisal Hassan (1):
      usb: dwc3: core: update LC timer as per USB Spec V3.2

Faiz Abbas (1):
      can: m_can: Add support for transceiver as phy

Fangzhi Zuo (1):
      drm/amd/display: Fix Synaptics Cascaded Panamera DSC Determination

Ferry Meng (2):
      ocfs2: add bounds checking to ocfs2_xattr_find_entry()
      ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()

Filipe Manana (1):
      btrfs: wait for fixup workers before stopping cleaner kthread during umount

Finn Thain (1):
      m68k: Fix kernel_clone_args.flags in m68k_clone()

Florian Fainelli (1):
      tty: rp2: Fix reset with non forgiving PCIe host bridges

Florian Westphal (2):
      inet: inet_defrag: prevent sk release while still in use
      netfilter: fib: check correct rtable in vrf setups

Foster Snowhill (1):
      usbnet: ipheth: fix carrier detection in modes 1 and 4

Francis Laniel (1):
      tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols

Gabriel Krisman Bertazi (1):
      unicode: Don't special case ignorable code points

Gal Pressman (1):
      geneve: Fix incorrect inner network header offset when innerprotoinherit is set

Gaosheng Cui (1):
      hwrng: cctrng - Add missing clk_disable_unprepare in cctrng_resume

Gautham Ananthakrishna (1):
      ocfs2: reserve space for inline xattr before attaching reflink tree

Geert Uytterhoeven (2):
      drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()
      of/irq: Refer to actual buffer size in of_irq_parse_one()

Geliang Tang (1):
      mptcp: export lookup_anno_list_by_saddr

Gerald Schaefer (1):
      s390/mm: Add cond_resched() to cmm_alloc/free_pages()

Gerd Bayer (1):
      net/mlx5: Fix error path in multi-packet WQE transmit

Greg Kroah-Hartman (2):
      net: dsa: microchip: fix build warning
      Linux 5.10.227

Guenter Roeck (3):
      hwmon: (max16065) Fix overflows seen when writing limits
      hwmon: (max16065) Fix alarm attributes
      hwmon: (tmp513) Add missing dependency on REGMAP_I2C

Guillaume Nault (4):
      bareudp: allow redirecting bareudp packets to eth devices
      bareudp: Pull inner IP header in bareudp_udp_encap_recv().
      bareudp: Pull inner IP header on xmit.
      netfilter: rpfilter/fib: Set ->flowic_uid correctly for user namespaces.

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

Han Xu (1):
      spi: nxp-fspi: fix the KASAN report out-of-bounds bug

Hans P. Moller (1):
      ALSA: line6: add hw monitor volume control to POD HD500X

Hans Verkuil (1):
      media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags

Hans de Goede (4):
      Input: goodix - use the new soc_intel_is_byt() helper
      ACPI: resource: Add Asus Vivobook X1704VAP to irq1_level_low_skip_override[]
      ACPI: resource: Add Asus ExpertBook B2502CVA to irq1_level_low_skip_override[]
      i2c: i801: Use a different adapter-name for IDF adapters

Haoran Zhang (1):
      vhost/scsi: null-ptr-dereference in vhost_scsi_get_req()

Harshit Mogalapalli (1):
      usb: yurex: Fix inconsistent locking bug in yurex_read()

Heiko Carstens (1):
      s390/facility: Disable compile time optimization for decompressor code

Heiner Kallweit (2):
      r8169: disable ALDPS per default for RTL8125
      r8169: add tally counter fields added with RTL8125

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

Howard Hsu (1):
      wifi: mt76: mt7915: fix rx filter setting for bfee functionality

Huang Ying (1):
      resource: fix region_intersects() vs add_memory_driver_managed()

Hugh Cole-Baker (2):
      drm/rockchip: define gamma registers for RK3399
      drm/rockchip: support gamma control on RK3399

Ian Rogers (1):
      perf time-utils: Fix 32-bit nsec parsing

Icenowy Zheng (1):
      usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip

Ido Schimmel (1):
      ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family

Ingo van Lil (1):
      net: phy: dp83869: fix memory corruption when enabling fiber

Jack Pham (1):
      usb: dwc3: Decouple USB 2.0 L1 & L2 events

Jacky Chou (2):
      net: ftgmac100: Enable TX interrupt to avoid TX timeout
      net: ftgmac100: Ensure tx descriptor updates are visible

Jacob Keller (1):
      ice: fix accounting for filters shared by multiple VSIs

Jan Kara (2):
      ext4: properly sync file size update after O_SYNC direct IO
      ext4: fix warning in ext4_dio_write_end_io()

Jann Horn (2):
      firmware_loader: Block path traversal
      f2fs: Require FMODE_WRITE for atomic write ioctls

Jaroslav Kysela (1):
      ALSA: core: add isascii() check to card ID generator

Jason Wang (1):
      vhost_vdpa: assign irq bypass producer token correctly

Jason Xing (1):
      tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process

Javier Carrasco (1):
      hwmon: (adm9240) Add missing dependency on REGMAP_I2C

Jeff Layton (3):
      btrfs: update target inode's ctime on unlink
      nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
      nfsd: fix refcount leak when file is unhashed after being found

Jeongjun Park (2):
      jfs: fix out-of-bounds in dbNextAG() and diAlloc()
      net/xen-netback: prevent UAF in xenvif_flush_hash()

Jiawei Ye (2):
      wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param
      smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso

Jinjie Ruan (12):
      net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
      riscv: Fix fp alignment bug in perf_callchain_user()
      ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
      spi: spi-fsl-lpspi: Undo runtime PM changes at driver exit time
      ieee802154: Fix build error
      net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
      Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
      nfp: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
      i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: bcm63xx: Fix module autoloading
      i2c: xiic: Fix pm_runtime_set_suspended() with runtime pm enabled

Jiri Olsa (2):
      kallsyms: Make kallsyms_on_each_symbol generally available
      kallsyms: Make module_kallsyms_on_each_symbol generally available

Jisheng Zhang (1):
      riscv: define ILLEGAL_POINTER_VALUE for 64bit

Jonas Blixt (1):
      watchdog: imx_sc_wdt: Don't disable WDT in suspend

Jonas Gorski (5):
      net: dsa: b53: fix jumbo frame mtu check
      net: dsa: b53: fix max MTU for 1g switches
      net: dsa: b53: fix max MTU for BCM5325/BCM5365
      net: dsa: b53: allow lower MTUs on BCM5325/5365
      net: dsa: b53: fix jumbo frames on 10/100 ports

Jonas Karlman (2):
      drm/rockchip: dw_hdmi: Fix reading EDID when using a forced mode
      clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228

Jonathan Denose (1):
      Input: synaptics - enable SMBus for HP Elitebook 840 G2

Jonathan McDowell (1):
      tpm: Clean up TPM space after command failure

Jose Alberto Reguero (1):
      usb: xhci: Fix problem with xhci resume from suspend

Joseph Qi (2):
      ocfs2: fix uninit-value in ocfs2_get_block()
      ocfs2: cancel dqi_sync_work before freeing oinfo

Josh Hunt (1):
      tcp: check skb is non-NULL in tcp_rto_delta_us()

Joshua Pius (1):
      ALSA: usb-audio: Add logitech Audio profile quirk

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

Justin Iurman (1):
      net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input

Kailang Yang (2):
      ALSA: hda/realtek - Fixed ALC256 headphone no sound
      ALSA: hda/realtek - FIxed ALC285 headphone no sound

Kaixin Wang (3):
      net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition
      fbdev: pxafb: Fix possible use after free in pxafb_task()
      ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition

Kamlesh Gurudasani (1):
      padata: Honor the caller's alignment in case of chunk_size 0

Karthikeyan Periyasamy (1):
      wifi: ath11k: fix array out-of-bound access in SoC stats

Kees Cook (2):
      x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()
      scsi: aacraid: Rearrange order of struct aac_srb_unit

Kemeng Shi (4):
      ext4: avoid buffer_head leak in ext4_mark_inode_used()
      ext4: avoid potential buffer_head leak in __ext4_new_inode()
      ext4: avoid negative min_clusters in find_group_orlov()
      jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit

Kent Gibson (1):
      gpiolib: cdev: Ignore reconfiguration without direction

KhaiWenTan (1):
      net: stmmac: Fix zero-division error when disabling tc cbs

Konrad Dybcio (1):
      interconnect: qcom: sm8250: Enable sync_state

Konstantin Ovsepian (1):
      blk_iocost: fix more out of bound shifts

Krzysztof Kozlowski (15):
      soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"
      ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property
      ARM: versatile: fix OF node leak in CPUs prepare
      reset: berlin: fix OF node leak in probe() error path
      soc: versatile: integrator: fix OF node leak in probe() error path
      bus: integrator-lm: fix OF node leak in probe()
      soc: versatile: realview: fix memory leak during device remove
      soc: versatile: realview: fix soc_dev leak during device remove
      net: hisilicon: hip04: fix OF node leak in probe()
      net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
      net: hisilicon: hns_mdio: fix OF node leak in probe()
      firmware: tegra: bpmp: Drop unused mbox_client_to_bpmp()
      rtc: at91sam9: fix OF node leak in probe() error path
      i2c: xiic: Simplify with dev_err_probe()
      clk: bcm: bcm53573: fix OF node leak in init

Kuniyuki Iwashima (2):
      can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().
      ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).

Lars-Peter Clausen (1):
      i2c: xiic: xiic_xfer(): Fix runtime PM leak on error path

Lasse Collin (1):
      xz: cleanup CRC32 edits from 2018

Laurent Pinchart (2):
      Remove *.orig pattern from .gitignore
      media: sun4i_csi: Implement link validate for sun4i_csi subdev

Lee Jones (1):
      usb: yurex: Replace snprintf() with the safer scnprintf() variant

Li Lingfeng (3):
      nfsd: return -EINVAL when namelen is 0
      nfs: fix memory leak in error path of nfs4_do_reclaim
      nfsd: map the EBADMSG to nfserr_io to avoid warning

Liao Chen (4):
      ASoC: intel: fix module autoloading
      ASoC: tda7419: fix module autoloading
      spi: bcm63xx: Enable module autoloading
      mailbox: rockchip: fix a typo in module autoloading

Linus Walleij (1):
      net: ethernet: cortina: Drop TSO support

Lizhi Xu (2):
      ocfs2: remove unreasonable unlock in ocfs2_read_blocks
      ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

Lorenzo Stoakes (1):
      minmax: reduce min/max macro expansion in atomisp driver

Lu Baolu (1):
      iommu/vt-d: Always reserve a domain ID for identity setup

Luis Henriques (SUSE) (2):
      ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
      ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()

Luiz Augusto von Dentz (3):
      Bluetooth: btusb: Fix not handling ZPL/short-transfer
      Bluetooth: L2CAP: Fix not validating setsockopt user input
      Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change

Luo Gengkun (1):
      perf/core: Fix small negative period being ignored

Ma Ke (4):
      spi: ppc4xx: handle irq_of_parse_and_map() errors
      ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error
      pps: add an error check in parport_attach
      drm: omapdrm: Add missing check for alloc_ordered_workqueue

Manivannan Sadhasivam (1):
      clk: qcom: gcc-sm8250: Do not turn off PCIe GDSCs during gdsc_disable()

Marc Ferland (1):
      i2c: xiic: improve error message when transfer fails to start

Marc Gonzalez (1):
      iommu/arm-smmu-qcom: hide last LPASS SMMU context bank from linux

Marc Kleine-Budde (1):
      can: m_can: m_can_close(): stop clocks after device has been shut down

Marek Vasut (5):
      Input: ads7846 - ratelimit the spi_sync error message
      i2c: xiic: Fix broken locking on tx_msg
      i2c: xiic: Switch from waitqueue to completion
      i2c: xiic: Fix RX IRQ busy check
      i2c: stm32f7: Do not prepare/unprepare clock during runtime suspend/resume

Mark Rutland (2):
      arm64: cputype: Add Neoverse-N3 definitions
      arm64: errata: Expand speculative SSBS workaround once more

Masahiro Yamada (1):
      kconfig: qconf: fix buffer overflow in debug links

Mathias Krause (1):
      Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal

Mathias Nyman (1):
      xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and freeing them.

Matthew Brost (1):
      drm/printer: Allow NULL data in devcoredump printer

Matthieu Baerts (NGI0) (1):
      mptcp: fix sometimes-uninitialized warning

Max Hawking (1):
      ntb_perf: Fix printk format

Meir Lichtinger (1):
      net/mlx5: Update the list of the PCI supported devices

Michael Kelley (1):
      x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency

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

Mikulas Patocka (1):
      Revert "dm: requeue IO if mapping table not yet available"

Mirsad Todorovac (1):
      mtd: slram: insert break after errors in parsing the map

Mohamed Khalfella (2):
      net/mlx5: Added cond_resched() to crdump collection
      igb: Do not bring the device up after non-fatal error

Moon Yeounsu (1):
      net: ethernet: use ip_hdrlen() instead of bit shift

Moritz Fischer (1):
      usb: renesas-xhci: Remove renesas_xhci_pci_exit()

Muhammad Usama Anjum (1):
      fou: fix initialization of grc

Mårten Lindahl (1):
      hwmon: (pmbus) Introduce and use write_byte_data callback

Neal Cardwell (2):
      tcp: fix to allow timestamp undo if no retransmits were sent
      tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe

NeilBrown (1):
      nfsd: fix delegation_blocked() to block correctly for at least 30 seconds

Nikita Zhandarovich (3):
      drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets
      f2fs: prevent possible int overflow in dir_block_index()
      f2fs: avoid potential int overflow in sanity_check_area_boundary()

Nishanth Menon (1):
      cpufreq: ti-cpufreq: Introduce quirks to handle syscon fails appropriately

Nuno Sa (1):
      Input: adp5589-keys - fix adp5589_gpio_get_value()

Oder Chiou (1):
      ALSA: hda/realtek: Fix the push button function for the ALC257

Olaf Hering (1):
      mount: handle OOM on mnt_warn_timestamp_expiry

Oleg Nesterov (1):
      uprobes: fix kernel info leak via "[uprobes]" vma

Oliver Neukum (5):
      USB: appledisplay: close race between probe and completion handler
      USB: misc: cypress_cy7c63: check for short transfer
      USB: class: CDC-ACM: fix race between get_serial and set_serial
      USB: misc: yurex: fix race between read and write
      Revert "usb: yurex: Replace snprintf() with the safer scnprintf() variant"

Pablo Neira Ayuso (5):
      netfilter: nft_set_pipapo: walk over current view on netlink dump
      netfilter: nf_tables: missing iterator type in lookup walk
      netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire
      netfilter: nf_tables: reject element expiration with no timeout
      netfilter: nf_tables: reject expiration higher than timeout

Patryk Biel (1):
      hwmon: (pmbus) Conditionally clear individual status bits for pmbus rev >= 1.2

Paul E. McKenney (1):
      rcuscale: Provide clear error when async specified without primitives

Paulo Miguel Almeida (2):
      drm/amdgpu: Replace one-element array with flexible-array member
      drm/radeon: Replace one-element array with flexible-array member

Pavan Kumar Paluri (1):
      crypto: ccp - Properly unregister /dev/sev on sev PLATFORM_STATUS failure

Pawel Dembicki (1):
      net: phy: vitesse: repair vsc73xx autonegotiation

Pei Xiao (1):
      ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()

Peng Fan (1):
      clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D

Peng Liu (2):
      drm/amdgpu: add raven1 gfxoff quirk
      drm/amdgpu: enable gfxoff quirk on HP 705G4

Peter Zijlstra (1):
      x86/ibt,ftrace: Search for __fentry__ location

Phil Sutter (4):
      netfilter: nf_tables: Keep deleted flowtable hooks until after RCU
      netfilter: uapi: NFTA_FLOWTABLE_HOOK is NLA_NESTED
      netfilter: rpfilter/fib: Populate flowic_l3mdev field
      netfilter: ip6t_rpfilter: Fix regression with VRF interfaces

Philip Chen (1):
      virtio_pmem: Check device status before requesting flush

Piyush Mehta (1):
      usb: dwc3: core: Enable GUCTL1 bit 10 for fixing termination error after resume bug

Pu Lehui (2):
      Revert "bpf: Fix DEVMAP_HASH overflow check on 32-bit arches"
      Revert "bpf: Eliminate rlimit-based memory accounting for devmap maps"

Qiu-ji Chen (1):
      drbd: Fix atomicity violation in drbd_uuid_set_bm()

Qu Wenruo (1):
      btrfs: fix a NULL pointer dereference when failed to start a new trasacntion

Quentin Schulz (1):
      arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog on RK3399 Puma

Rafael J. Wysocki (1):
      ACPI: EC: Do not release locks during operation region accesses

Remington Brasga (1):
      jfs: UBSAN: shift-out-of-bounds in dbFindBits

Riyan Dhiman (1):
      block: fix potential invalid pointer dereference in blk_add_partition

Rob Clark (5):
      drm/msm/adreno: Fix error return if missing firmware-name
      drm/msm: Add priv->mm_lock to protect active/inactive lists
      drm/msm: Drop priv->lastctx
      kthread: add kthread_work tracepoints
      drm/crtc: fix uninitialized variable use even harder

Robert Hancock (2):
      i2c: xiic: Try re-initialization on bus busy timeout
      i2c: xiic: Wait for TX empty to avoid missed TX NAKs

Robin Chen (1):
      drm/amd/display: Round calculated vtotal

Rosen Penev (1):
      net: ibm: emac: mal: fix wrong goto

Ryusuke Konishi (3):
      nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()
      nilfs2: determine empty node blocks as corrupted
      nilfs2: fix potential oob read in nilfs_btree_check_delete()

Sanjay K Kumar (1):
      iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count

Saravanan Vajravel (1):
      RDMA/mad: Improve handling of timed out WRs of mad agent

Scott Mayhew (1):
      selinux,smack: don't bypass permissions check in inode_setsecctx hook

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

Simon Horman (4):
      netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS
      tipc: guard against string buffer overrun
      net: mvpp2: Increase size of queue_name buffer
      net: atlantic: Avoid warning about potential string truncation

Srinivasan Shanmugam (4):
      drm/amd/display: Add null check for top_pipe_to_program in commit_planes_for_stream
      drm/amd/display: Fix index out of bounds in DCN30 degamma hardware format translation
      drm/amd/display: Fix index out of bounds in degamma hardware format translation
      drm/amd/display: Fix index out of bounds in DCN30 color transformation

Stefan Wahren (1):
      mailbox: bcm2835: Fix timeout during suspend mode

Steven Rostedt (Google) (2):
      tracing: Remove precision vsnprintf() check from print event
      tracing: Have saved_cmdlines arrays all in one allocation

Su Hui (1):
      net: tipc: avoid possible garbage value

Subramanian Ananthanarayanan (1):
      PCI: Add ACS quirk for Qualcomm SA8775P

Sumeet Pawnikar (1):
      powercap: RAPL: fix invalid initialization for pl4_supported field

SurajSonawane2415 (1):
      hid: intel-ish-hid: Fix uninitialized variable 'rv' in ish_fw_xfer_direct_dma

Suzuki K Poulose (1):
      coresight: tmc: sg: Do not leak sg_table

T.J. Mercier (1):
      dma-buf: heaps: Fix off-by-one in CMA heap fault handler

Takashi Iwai (6):
      Input: i8042 - add Fujitsu Lifebook E756 to i8042 quirk table
      ALSA: hda/generic: Unconditionally prefer preferred_dacs pairs
      ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin
      ALSA: usb-audio: Define macros for quirk table entries
      ALSA: asihpi: Fix potential OOB array access
      ALSA: hdsp: Break infinite MIDI input flush loop

Tao Chen (1):
      bpf: Check percpu map value size first

Tetsuo Handa (1):
      tomoyo: fallback to realpath if symlink's pathname does not exist

Thadeu Lima de Souza Cascardo (3):
      ext4: return error on ext4_find_inline_entry
      ext4: avoid OOB when system.data xattr changes underneath the filesystem
      ext4: ext4_search_dir should return a proper error

Thomas Blocher (1):
      pinctrl: at91: make it work with current gpiolib

Thomas Gleixner (2):
      PCI: xilinx-nwl: Use irq_data_get_irq_chip_data()
      signal: Replace BUG_ON()s

Thomas Richter (1):
      s390/cpum_sf: Remove WARN_ON_ONCE statements

Thomas Weißschuh (2):
      net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
      ACPI: sysfs: validate return type of _STR method

Thomas Zimmermann (1):
      drm: Consistently use struct drm_mode_rect for FB_DAMAGE_CLIPS

Tim Huang (1):
      drm/amd/pm: ensure the fw_info is not null before using it

Toke Høiland-Jørgensen (2):
      bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
      wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

Tommy Huang (1):
      i2c: aspeed: Update the stop sw state when the bus recovery occurs

Tony Ambardar (8):
      selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
      selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c
      selftests/bpf: Fix compiling kfree_skb.c with musl-libc
      selftests/bpf: Fix compiling flow_dissector.c with musl-libc
      selftests/bpf: Fix compiling tcp_rtt.c with musl-libc
      selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc
      selftests/bpf: Fix error compiling test_lru_map.c
      selftests/bpf: Fix C++ compile error from missing _Bool type

Tony Luck (1):
      x86/mm: Switch to new Intel CPU model defines

Trond Myklebust (1):
      NFS: Avoid unnecessary rescanning of the per-server delegation list

Tvrtko Ursulin (1):
      drm/sched: Add locking to drm_sched_entity_modify_sched

Val Packett (1):
      drm/rockchip: vop: clear DMA stop bit on RK3066

VanGiang Nguyen (1):
      padata: use integer wrap around to prevent deadlock on seq_nr overflow

Vincenzo Palazzo (1):
      usb: dwc3: Fix a typo in field name

Vladimir Lypak (4):
      drm/msm/a5xx: disable preemption in submits by default
      drm/msm/a5xx: properly clear preemption records on resume
      drm/msm/a5xx: fix races in preemption evaluation stage
      drm/msm/a5xx: workaround early ring-buffer emptiness check

Wade Wang (1):
      HID: plantronics: Workaround for an unexcepted opposite volume key

Waiman Long (1):
      cgroup: Move rcu_head up near the top of cgroup_root

Wang Jianzheng (1):
      pinctrl: mvebu: Fix devinit_dove_pinctrl_probe function

WangYuli (1):
      PCI: Add function 0 DMA alias quirk for Glenfly Arise chip

Werner Sembach (4):
      Input: i8042 - add TUXEDO Stellaris 16 Gen5 AMD to i8042 quirk table
      Input: i8042 - add TUXEDO Stellaris 15 Slim Gen6 AMD to i8042 quirk table
      Input: i8042 - add another board name for TUXEDO Stellaris Gen5 AMD line
      ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Wojciech Gładysz (1):
      ext4: nested locking for xattr inode

Wolfram Sang (1):
      ipmi: docs: don't advertise deprecated sysfs entries

Xi Wang (2):
      RDMA/hns: Add mapped page count checking for MTR
      RDMA/hns: Refactor root BT allocation for MTR

Xie Yongji (1):
      vdpa: Add eventfd for the vdpa callback

Xin Long (2):
      sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start
      sctp: ensure sk_state is set to CLOSED if hashing fails in sctp_listen_start

Xiubo Li (1):
      ceph: remove the incorrect Fw reference check when dirtying pages

Xu Yang (1):
      usb: chipidea: udc: enable suspend interrupt after usb reset

Yafang Shao (1):
      cgroup: Make operations on the cgroup root_list RCU safe

Yang Jihong (2):
      perf sched timehist: Fix missing free of session in perf_sched__timehist()
      perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time

Yang Yingliang (1):
      pinctrl: single: fix missing error code in pcs_probe()

Yangtao Li (1):
      pinctrl: mvebu: Use devm_platform_get_and_ioremap_resource()

Yanjun Zhang (1):
      NFSv4: Prevent NULL-pointer dereference in nfs42_complete_copies()

Yifei Liu (1):
      selftests: breakpoints: use remaining time to check if suspend succeed

Yixing Liu (1):
      RDMA/hns: Fix uninitialized variable

Yonatan Maman (1):
      nouveau/dmem: Fix vulnerability in migrate_to_ram upon copy error

Yonggil Song (1):
      f2fs: fix typo

Youssef Samir (1):
      net: qrtr: Update packets cloning when broadcasting

Yu Kuai (3):
      block, bfq: fix possible UAF for bfqq->bic with merge chain
      block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()
      block, bfq: don't break merge chain in bfq_split_bfqq()

Yuesong Li (1):
      drivers:drm:exynos_drm_gsc:Fix wrong assignment in gsc_bind()

Yuezhang Mo (1):
      exfat: fix memory leak in exfat_load_bitmap()

Yunke Cao (1):
      media: videobuf2-core: clear memory related fields in __vb2_plane_dmabuf_put()

Yuntao Liu (1):
      hwmon: (ntc_thermistor) fix module autoloading

Zhang Changzhong (1):
      can: j1939: use correct function name in comment

Zhao Mengmeng (1):
      jfs: Fix uninit-value access of new_ea in ea_buffer

Zhen Lei (1):
      debugobjects: Fix conditions in fill_pool()

Zheng Wang (1):
      media: venus: fix use after free bug in venus_remove due to race condition

Zheng Yejian (1):
      ftrace: Fix possible use-after-free issue in ftrace_location()

Zhiguo Niu (1):
      lockdep: fix deadlock issue between lockdep and rcu

Zhihao Cheng (1):
      ext4: dax: fix overflowing extents beyond inode size when partially writing

Zhipeng Wang (1):
      clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

Zhu Jun (1):
      tools/iio: Add memory allocation failure check for trigger_name

Zhu Yanjun (1):
      RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency

Zijun Hu (1):
      driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute

Zong-Zhe Yang (1):
      wifi: rtw88: select WANT_DEV_COREDUMP

hongchi.peng (1):
      drm: komeda: Fix an issue related to normalized zpos

wenglianfa (1):
      RDMA/hns: Fix the overflow risk of hem_list_calc_ba_range()

yangerkun (1):
      ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard

zhanchengbin (1):
      ext4: fix inode tree inconsistency caused by ENOMEM


