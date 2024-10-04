Return-Path: <stable+bounces-80755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D4990698
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC101C22C11
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D15121B44D;
	Fri,  4 Oct 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jH+Foyho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55AF21B430;
	Fri,  4 Oct 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053101; cv=none; b=lBh7J2LIlTeNYRR/v4bwajAaGNa4iPBoxdZXAyWQ3S9BHn0pN07BbEKHWqfZ/FG+rxGBWl1WaORiUqea+xWO7fLlzdk0HGX3I18BJND4wdJX5Av65pPMiF/LhaG41pEVwUlh6AzkqDyhcfuES9flx30t/NQnvBDxxcLCMoossSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053101; c=relaxed/simple;
	bh=CIkyoPIHH4kmP047pOoDv1JmB6SuEfk0VcQ6o7sMIbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rDCl823ZLp2miSdIGZTfqd3E1C7u5VOv3EB3GWPwENiesKosHg6D/MvyftjkHEYs9NDO5vbGK38jE+5aO9cwJuNQF0ZzjqqbvzfOG+C6zocA7G6y2d5xuGT2i6yHjMqyGfdLhQvJ+rCtUtzxNrLjokLchkgFoV+iXBTWur+ReV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jH+Foyho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBA7C4CEC6;
	Fri,  4 Oct 2024 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728053099;
	bh=CIkyoPIHH4kmP047pOoDv1JmB6SuEfk0VcQ6o7sMIbY=;
	h=From:To:Cc:Subject:Date:From;
	b=jH+Foyhoqa3UAhdZ11RtneB6HJrWsXH9zz0e0nTXm7sSxCmYQq8mDt3pYOkjn43ZA
	 hNcAzSqHHbBMgKYpUKUvnomOfQPI4EKr0nVB9h/sP4bgBTi99x+7zn/hWfC0MKPvNY
	 tRH8IS43QaFDoIsPxCIL6fc83dHumE92btNZWuMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.54
Date: Fri,  4 Oct 2024 16:44:54 +0200
Message-ID: <2024100454-germproof-smuggler-14d6@gregkh>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.54 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                                    |    1 
 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818                       |    2 
 Documentation/arch/arm64/silicon-errata.rst                                   |    2 
 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml    |    1 
 Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml                       |   19 
 Documentation/driver-api/ipmi.rst                                             |    2 
 Documentation/virt/kvm/locking.rst                                            |   33 
 Makefile                                                                      |    2 
 arch/arm/boot/dts/microchip/sam9x60.dtsi                                      |    4 
 arch/arm/boot/dts/microchip/sama7g5.dtsi                                      |    2 
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts                                     |    2 
 arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts                                  |    2 
 arch/arm/mach-ep93xx/clock.c                                                  |    2 
 arch/arm/mach-versatile/platsmp-realview.c                                    |    1 
 arch/arm/vfp/vfpinstr.h                                                       |   48 
 arch/arm64/Kconfig                                                            |    2 
 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts                          |    2 
 arch/arm64/boot/dts/mediatek/mt8186.dtsi                                      |   12 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                               |    1 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                                      |   12 
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                                         |    2 
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi                                   |    4 
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi                                    |    4 
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi                                    |    4 
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts                          |    4 
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts                             |    2 
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts                            |    4 
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                                        |    4 
 arch/arm64/include/asm/cputype.h                                              |    2 
 arch/arm64/include/asm/esr.h                                                  |   88 -
 arch/arm64/include/uapi/asm/sigcontext.h                                      |    6 
 arch/arm64/kernel/cpu_errata.c                                                |   10 
 arch/arm64/kvm/hyp/nvhe/ffa.c                                                 |   21 
 arch/m68k/kernel/process.c                                                    |    2 
 arch/powerpc/crypto/Kconfig                                                   |    1 
 arch/powerpc/include/asm/asm-compat.h                                         |    6 
 arch/powerpc/include/asm/atomic.h                                             |    5 
 arch/powerpc/include/asm/uaccess.h                                            |    7 
 arch/powerpc/kernel/head_8xx.S                                                |    6 
 arch/powerpc/kernel/vdso/gettimeofday.S                                       |    4 
 arch/powerpc/mm/nohash/8xx.c                                                  |    4 
 arch/riscv/include/asm/kvm_vcpu_pmu.h                                         |   21 
 arch/riscv/kernel/perf_callchain.c                                            |    2 
 arch/riscv/kvm/vcpu_sbi.c                                                     |    4 
 arch/x86/coco/tdx/tdx.c                                                       |    6 
 arch/x86/events/intel/pt.c                                                    |   15 
 arch/x86/include/asm/acpi.h                                                   |    8 
 arch/x86/include/asm/hardirq.h                                                |    8 
 arch/x86/include/asm/idtentry.h                                               |   73 
 arch/x86/kernel/acpi/boot.c                                                   |   11 
 arch/x86/kernel/cpu/sgx/main.c                                                |   27 
 arch/x86/kernel/jailhouse.c                                                   |    1 
 arch/x86/kernel/mmconf-fam10h_64.c                                            |    1 
 arch/x86/kernel/process_64.c                                                  |   29 
 arch/x86/kernel/smpboot.c                                                     |    1 
 arch/x86/kernel/x86_init.c                                                    |    1 
 arch/x86/kvm/lapic.c                                                          |   35 
 arch/x86/mm/tlb.c                                                             |    7 
 arch/x86/pci/fixup.c                                                          |    4 
 arch/x86/xen/mmu_pv.c                                                         |    5 
 arch/x86/xen/p2m.c                                                            |   98 +
 arch/x86/xen/setup.c                                                          |  203 ++
 arch/x86/xen/xen-ops.h                                                        |    6 
 block/bfq-iosched.c                                                           |   81 -
 block/partitions/core.c                                                       |    8 
 crypto/asymmetric_keys/asymmetric_type.c                                      |    7 
 crypto/xor.c                                                                  |   31 
 drivers/acpi/cppc_acpi.c                                                      |   43 
 drivers/acpi/device_sysfs.c                                                   |    5 
 drivers/acpi/pmic/tps68470_pmic.c                                             |    6 
 drivers/acpi/resource.c                                                       |    6 
 drivers/ata/libata-eh.c                                                       |    8 
 drivers/ata/libata-scsi.c                                                     |    5 
 drivers/base/core.c                                                           |   15 
 drivers/base/firmware_loader/main.c                                           |   30 
 drivers/base/module.c                                                         |   14 
 drivers/base/power/domain.c                                                   |    2 
 drivers/block/drbd/drbd_main.c                                                |    6 
 drivers/block/drbd/drbd_state.c                                               |    2 
 drivers/block/nbd.c                                                           |   13 
 drivers/block/ublk_drv.c                                                      |   62 
 drivers/bluetooth/btusb.c                                                     |    5 
 drivers/bus/arm-integrator-lm.c                                               |    1 
 drivers/bus/mhi/host/pci_generic.c                                            |   13 
 drivers/char/hw_random/bcm2835-rng.c                                          |    4 
 drivers/char/hw_random/cctrng.c                                               |    1 
 drivers/char/hw_random/mtk-rng.c                                              |    2 
 drivers/char/tpm/tpm-dev-common.c                                             |    2 
 drivers/char/tpm/tpm2-space.c                                                 |    3 
 drivers/clk/at91/sama7g5.c                                                    |    5 
 drivers/clk/imx/clk-composite-7ulp.c                                          |    7 
 drivers/clk/imx/clk-composite-8m.c                                            |   63 
 drivers/clk/imx/clk-composite-93.c                                            |   15 
 drivers/clk/imx/clk-fracn-gppll.c                                             |    4 
 drivers/clk/imx/clk-imx6ul.c                                                  |    4 
 drivers/clk/imx/clk-imx8mp-audiomix.c                                         |   13 
 drivers/clk/imx/clk-imx8mp.c                                                  |    4 
 drivers/clk/imx/clk-imx8qxp.c                                                 |   10 
 drivers/clk/qcom/clk-alpha-pll.c                                              |   52 
 drivers/clk/qcom/clk-alpha-pll.h                                              |    2 
 drivers/clk/qcom/dispcc-sm8250.c                                              |    9 
 drivers/clk/qcom/dispcc-sm8550.c                                              |   14 
 drivers/clk/qcom/gcc-ipq5332.c                                                |    1 
 drivers/clk/rockchip/clk-rk3228.c                                             |    2 
 drivers/clk/rockchip/clk-rk3588.c                                             |    2 
 drivers/clk/starfive/clk-starfive-jh7110-vout.c                               |    2 
 drivers/clk/ti/clk-dra7-atl.c                                                 |    1 
 drivers/clocksource/timer-qcom.c                                              |    7 
 drivers/cpufreq/ti-cpufreq.c                                                  |   10 
 drivers/cpuidle/cpuidle-riscv-sbi.c                                           |   21 
 drivers/crypto/caam/caamhash.c                                                |    1 
 drivers/crypto/ccp/sev-dev.c                                                  |    2 
 drivers/crypto/hisilicon/hpre/hpre_main.c                                     |   54 
 drivers/crypto/hisilicon/qm.c                                                 |  151 +
 drivers/crypto/hisilicon/sec2/sec_main.c                                      |   16 
 drivers/crypto/hisilicon/zip/zip_main.c                                       |   23 
 drivers/cxl/core/pci.c                                                        |    8 
 drivers/edac/igen6_edac.c                                                     |    2 
 drivers/edac/synopsys_edac.c                                                  |   85 -
 drivers/firewire/core-cdev.c                                                  |    2 
 drivers/firmware/arm_scmi/optee.c                                             |    7 
 drivers/firmware/efi/libstub/tpm.c                                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h                                   |    4 
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c                                |   29 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   16 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                   |    9 
 drivers/gpu/drm/amd/display/dc/dc_dsc.h                                       |    3 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c                            |    6 
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c                                   |    5 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c                       |    2 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                                      |   35 
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                                       |    2 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                                       |   32 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                         |   12 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h                                         |    2 
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c                                     |   30 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                       |    2 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c                                      |    2 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c                                     |   12 
 drivers/gpu/drm/radeon/evergreen_cs.c                                         |   62 
 drivers/gpu/drm/radeon/radeon_atombios.c                                      |   29 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                                   |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                                   |    4 
 drivers/gpu/drm/stm/drv.c                                                     |    4 
 drivers/gpu/drm/stm/ltdc.c                                                    |    2 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                                |    8 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                                            |   13 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                                            |    3 
 drivers/hid/wacom_wac.c                                                       |   13 
 drivers/hid/wacom_wac.h                                                       |    2 
 drivers/hwmon/max16065.c                                                      |   27 
 drivers/hwmon/ntc_thermistor.c                                                |    1 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                               |    2 
 drivers/i2c/busses/i2c-aspeed.c                                               |   16 
 drivers/i2c/busses/i2c-isch.c                                                 |    3 
 drivers/iio/adc/ad7606.c                                                      |    8 
 drivers/iio/adc/ad7606_spi.c                                                  |    5 
 drivers/iio/chemical/bme680_core.c                                            |    7 
 drivers/iio/magnetometer/ak8975.c                                             |   85 -
 drivers/infiniband/core/cache.c                                               |    4 
 drivers/infiniband/core/iwcm.c                                                |    2 
 drivers/infiniband/hw/cxgb4/cm.c                                              |    5 
 drivers/infiniband/hw/erdma/erdma_verbs.c                                     |   25 
 drivers/infiniband/hw/hns/hns_roce_hem.c                                      |   22 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                    |   33 
 drivers/infiniband/hw/hns/hns_roce_qp.c                                       |   16 
 drivers/infiniband/hw/irdma/verbs.c                                           |    2 
 drivers/infiniband/hw/mlx5/main.c                                             |    2 
 drivers/infiniband/hw/mlx5/mr.c                                               |   14 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                        |    9 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                        |    1 
 drivers/input/keyboard/adp5588-keys.c                                         |    2 
 drivers/input/serio/i8042-acpipnpio.h                                         |   37 
 drivers/input/touchscreen/ilitek_ts_i2c.c                                     |   18 
 drivers/interconnect/icc-clk.c                                                |    3 
 drivers/iommu/amd/io_pgtable_v2.c                                             |    2 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                    |   28 
 drivers/iommu/iommufd/io_pagetable.c                                          |    8 
 drivers/leds/leds-bd2606mvv.c                                                 |   23 
 drivers/leds/leds-pca995x.c                                                   |   78 
 drivers/md/dm-rq.c                                                            |    4 
 drivers/md/dm.c                                                               |   11 
 drivers/media/dvb-frontends/rtl2830.c                                         |    2 
 drivers/media/dvb-frontends/rtl2832.c                                         |    2 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c        |    9 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c  |    9 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c         |   10 
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c                         |    1 
 drivers/media/tuners/tuner-i2c.h                                              |    4 
 drivers/mtd/devices/powernv_flash.c                                           |    3 
 drivers/mtd/devices/slram.c                                                   |    2 
 drivers/mtd/nand/raw/mtk_nand.c                                               |   36 
 drivers/net/bareudp.c                                                         |   26 
 drivers/net/bonding/bond_main.c                                               |    6 
 drivers/net/can/m_can/m_can.c                                                 |   14 
 drivers/net/can/usb/esd_usb.c                                                 |    6 
 drivers/net/ethernet/freescale/enetc/enetc.c                                  |    3 
 drivers/net/ethernet/realtek/r8169_phy_config.c                               |    2 
 drivers/net/ethernet/seeq/ether3.c                                            |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c                          |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                             |    2 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                   |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                             |   37 
 drivers/net/usb/usbnet.c                                                      |   37 
 drivers/net/virtio_net.c                                                      |   10 
 drivers/net/wireless/ath/ath12k/mac.c                                         |    5 
 drivers/net/wireless/ath/ath12k/wmi.c                                         |    1 
 drivers/net/wireless/ath/ath12k/wmi.h                                         |    3 
 drivers/net/wireless/ath/ath9k/debug.c                                        |    2 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c                                |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c                     |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c                   |   26 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c                       |  115 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h                       |  147 +
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c                                   |   11 
 drivers/net/wireless/intel/iwlwifi/iwl-config.h                               |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h                            |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                                 |   36 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                              |    3 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                              |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                              |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/init.c                              |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                              |   65 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                              |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                               |   23 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                               |    4 
 drivers/net/wireless/microchip/wilc1000/hif.c                                 |    4 
 drivers/net/wireless/realtek/rtw88/coex.c                                     |   38 
 drivers/net/wireless/realtek/rtw88/fw.c                                       |   13 
 drivers/net/wireless/realtek/rtw88/main.c                                     |    7 
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c                                |    2 
 drivers/net/wireless/realtek/rtw88/rtw8822c.c                                 |   10 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                                            |    2 
 drivers/ntb/ntb_transport.c                                                   |   23 
 drivers/ntb/test/ntb_perf.c                                                   |    2 
 drivers/nvdimm/namespace_devs.c                                               |   34 
 drivers/nvme/host/multipath.c                                                 |    2 
 drivers/pci/controller/dwc/pci-dra7xx.c                                       |    3 
 drivers/pci/controller/dwc/pci-imx6.c                                         |    7 
 drivers/pci/controller/dwc/pci-keystone.c                                     |    2 
 drivers/pci/controller/dwc/pcie-kirin.c                                       |    4 
 drivers/pci/controller/pcie-xilinx-nwl.c                                      |   39 
 drivers/pci/pci.c                                                             |   20 
 drivers/pci/pci.h                                                             |    6 
 drivers/pci/quirks.c                                                          |   31 
 drivers/perf/alibaba_uncore_drw_pmu.c                                         |    2 
 drivers/perf/arm-cmn.c                                                        |  242 +--
 drivers/perf/hisilicon/hisi_pcie_pmu.c                                        |   16 
 drivers/pinctrl/bcm/pinctrl-ns.c                                              |    8 
 drivers/pinctrl/berlin/berlin-bg2.c                                           |    8 
 drivers/pinctrl/berlin/berlin-bg2cd.c                                         |    8 
 drivers/pinctrl/berlin/berlin-bg2q.c                                          |    8 
 drivers/pinctrl/berlin/berlin-bg4ct.c                                         |    9 
 drivers/pinctrl/berlin/pinctrl-as370.c                                        |    9 
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c                                    |    9 
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c                                    |    9 
 drivers/pinctrl/mvebu/pinctrl-armada-ap806.c                                  |    5 
 drivers/pinctrl/mvebu/pinctrl-armada-cp110.c                                  |    6 
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c                                     |    9 
 drivers/pinctrl/mvebu/pinctrl-dove.c                                          |   48 
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c                                      |    7 
 drivers/pinctrl/mvebu/pinctrl-orion.c                                         |    7 
 drivers/pinctrl/nomadik/pinctrl-abx500.c                                      |    9 
 drivers/pinctrl/nomadik/pinctrl-nomadik.c                                     |   10 
 drivers/pinctrl/pinctrl-at91.c                                                |   11 
 drivers/pinctrl/pinctrl-single.c                                              |    3 
 drivers/pinctrl/pinctrl-xway.c                                                |   11 
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c                                       |  113 -
 drivers/power/supply/axp20x_battery.c                                         |   16 
 drivers/power/supply/max17042_battery.c                                       |    5 
 drivers/powercap/intel_rapl_common.c                                          |    2 
 drivers/pps/clients/pps_parport.c                                             |   14 
 drivers/regulator/of_regulator.c                                              |    2 
 drivers/remoteproc/imx_rproc.c                                                |    6 
 drivers/reset/reset-berlin.c                                                  |    3 
 drivers/reset/reset-k210.c                                                    |    3 
 drivers/scsi/NCR5380.c                                                        |   78 
 drivers/scsi/elx/libefc/efc_nport.c                                           |    2 
 drivers/scsi/mac_scsi.c                                                       |  162 +-
 drivers/scsi/sd.c                                                             |    2 
 drivers/scsi/smartpqi/smartpqi_init.c                                         |   20 
 drivers/soc/fsl/qe/tsa.c                                                      |    2 
 drivers/soc/qcom/smd-rpm.c                                                    |   35 
 drivers/soc/versatile/soc-integrator.c                                        |    1 
 drivers/soc/versatile/soc-realview.c                                          |   20 
 drivers/spi/atmel-quadspi.c                                                   |   15 
 drivers/spi/spi-bcmbca-hsspi.c                                                |    8 
 drivers/spi/spi-fsl-lpspi.c                                                   |    1 
 drivers/spi/spi-nxp-fspi.c                                                    |   54 
 drivers/spi/spi-ppc4xx.c                                                      |    7 
 drivers/thunderbolt/switch.c                                                  |  331 +++-
 drivers/thunderbolt/tb.c                                                      |  784 +++++++---
 drivers/thunderbolt/tb.h                                                      |   56 
 drivers/thunderbolt/tb_regs.h                                                 |    9 
 drivers/thunderbolt/tunnel.c                                                  |  217 +-
 drivers/thunderbolt/tunnel.h                                                  |   26 
 drivers/thunderbolt/usb4.c                                                    |  116 +
 drivers/tty/serial/8250/8250_omap.c                                           |    2 
 drivers/tty/serial/qcom_geni_serial.c                                         |   31 
 drivers/tty/serial/rp2.c                                                      |    2 
 drivers/tty/serial/serial_core.c                                              |   14 
 drivers/ufs/host/ufs-qcom.c                                                   |    2 
 drivers/usb/cdns3/cdnsp-ring.c                                                |    6 
 drivers/usb/cdns3/host.c                                                      |    4 
 drivers/usb/class/cdc-acm.c                                                   |    2 
 drivers/usb/dwc2/drd.c                                                        |    9 
 drivers/usb/host/xhci-mem.c                                                   |    5 
 drivers/usb/host/xhci-pci.c                                                   |   15 
 drivers/usb/host/xhci-ring.c                                                  |   14 
 drivers/usb/host/xhci.h                                                       |    3 
 drivers/usb/misc/appledisplay.c                                               |   15 
 drivers/usb/misc/cypress_cy7c63.c                                             |    4 
 drivers/usb/misc/yurex.c                                                      |   24 
 drivers/vhost/vdpa.c                                                          |   16 
 drivers/video/fbdev/hpfb.c                                                    |    1 
 drivers/watchdog/imx_sc_wdt.c                                                 |   24 
 drivers/xen/swiotlb-xen.c                                                     |   10 
 fs/btrfs/btrfs_inode.h                                                        |   47 
 fs/btrfs/ctree.h                                                              |    2 
 fs/btrfs/extent-tree.c                                                        |    4 
 fs/btrfs/file.c                                                               |   34 
 fs/btrfs/ioctl.c                                                              |    4 
 fs/btrfs/subpage.c                                                            |   10 
 fs/btrfs/tree-checker.c                                                       |    2 
 fs/cachefiles/xattr.c                                                         |   34 
 fs/crypto/fname.c                                                             |    8 
 fs/ecryptfs/crypto.c                                                          |   10 
 fs/erofs/inode.c                                                              |   20 
 fs/ext4/ialloc.c                                                              |   14 
 fs/ext4/inline.c                                                              |   35 
 fs/ext4/mballoc.c                                                             |   10 
 fs/ext4/super.c                                                               |   29 
 fs/f2fs/compress.c                                                            |   87 -
 fs/f2fs/data.c                                                                |   14 
 fs/f2fs/dir.c                                                                 |    3 
 fs/f2fs/extent_cache.c                                                        |    4 
 fs/f2fs/f2fs.h                                                                |   48 
 fs/f2fs/file.c                                                                |  167 +-
 fs/f2fs/inode.c                                                               |    5 
 fs/f2fs/namei.c                                                               |   69 
 fs/f2fs/segment.c                                                             |    8 
 fs/f2fs/super.c                                                               |   20 
 fs/f2fs/xattr.c                                                               |   14 
 fs/fcntl.c                                                                    |   14 
 fs/inode.c                                                                    |    4 
 fs/jfs/jfs_dmap.c                                                             |    4 
 fs/jfs/jfs_imap.c                                                             |    2 
 fs/namei.c                                                                    |    6 
 fs/namespace.c                                                                |   14 
 fs/nfs/nfs4state.c                                                            |    1 
 fs/nfsd/filecache.c                                                           |    3 
 fs/nfsd/nfs4idmap.c                                                           |   13 
 fs/nfsd/nfs4recover.c                                                         |    8 
 fs/nilfs2/btree.c                                                             |   12 
 fs/smb/server/vfs.c                                                           |   19 
 include/acpi/cppc_acpi.h                                                      |    2 
 include/linux/bitmap.h                                                        |   77 
 include/linux/bpf.h                                                           |    7 
 include/linux/f2fs_fs.h                                                       |    2 
 include/linux/fs.h                                                            |   11 
 include/linux/mm.h                                                            |    4 
 include/linux/mm_types.h                                                      |   31 
 include/linux/sbitmap.h                                                       |    2 
 include/linux/sched/numa_balancing.h                                          |   10 
 include/linux/usb/usbnet.h                                                    |   15 
 include/linux/xarray.h                                                        |    6 
 include/net/bluetooth/hci_core.h                                              |    4 
 include/net/ip.h                                                              |    2 
 include/net/mac80211.h                                                        |    7 
 include/net/tcp.h                                                             |   21 
 include/sound/tas2781.h                                                       |    8 
 include/trace/events/f2fs.h                                                   |    3 
 include/trace/events/sched.h                                                  |   52 
 io_uring/io-wq.c                                                              |   25 
 io_uring/io_uring.c                                                           |    4 
 io_uring/sqpoll.c                                                             |   12 
 kernel/bpf/btf.c                                                              |    8 
 kernel/bpf/helpers.c                                                          |   12 
 kernel/bpf/syscall.c                                                          |    4 
 kernel/bpf/verifier.c                                                         |   57 
 kernel/kthread.c                                                              |   10 
 kernel/locking/lockdep.c                                                      |   48 
 kernel/module/Makefile                                                        |    2 
 kernel/padata.c                                                               |    6 
 kernel/rcu/tree_nocb.h                                                        |    5 
 kernel/sched/fair.c                                                           |  134 +
 kernel/trace/bpf_trace.c                                                      |   15 
 lib/debugobjects.c                                                            |    5 
 lib/sbitmap.c                                                                 |    4 
 lib/test_xarray.c                                                             |   93 +
 lib/xarray.c                                                                  |   49 
 lib/xz/xz_crc32.c                                                             |    2 
 lib/xz/xz_private.h                                                           |    4 
 mm/damon/vaddr.c                                                              |    2 
 mm/filemap.c                                                                  |   50 
 mm/mmap.c                                                                     |    4 
 mm/util.c                                                                     |    2 
 net/bluetooth/hci_conn.c                                                      |    6 
 net/bluetooth/hci_sync.c                                                      |    5 
 net/bluetooth/mgmt.c                                                          |   13 
 net/can/bcm.c                                                                 |    4 
 net/can/j1939/transport.c                                                     |    8 
 net/core/filter.c                                                             |   50 
 net/core/sock_map.c                                                           |    1 
 net/ipv4/icmp.c                                                               |  103 -
 net/ipv6/Kconfig                                                              |    1 
 net/ipv6/icmp.c                                                               |   28 
 net/ipv6/netfilter/nf_reject_ipv6.c                                           |   14 
 net/ipv6/route.c                                                              |    2 
 net/ipv6/rpl_iptunnel.c                                                       |   12 
 net/mac80211/iface.c                                                          |   17 
 net/mac80211/offchannel.c                                                     |    1 
 net/mac80211/rate.c                                                           |    2 
 net/mac80211/scan.c                                                           |    2 
 net/mac80211/tx.c                                                             |    2 
 net/netfilter/nf_conntrack_netlink.c                                          |    7 
 net/netfilter/nf_tables_api.c                                                 |   16 
 net/qrtr/af_qrtr.c                                                            |    2 
 net/tipc/bcast.c                                                              |    2 
 net/wireless/nl80211.c                                                        |    3 
 net/wireless/scan.c                                                           |    6 
 net/wireless/sme.c                                                            |    3 
 samples/bpf/Makefile                                                          |    6 
 security/bpf/hooks.c                                                          |    1 
 security/smack/smackfs.c                                                      |    2 
 sound/pci/hda/cs35l41_hda_spi.c                                               |    1 
 sound/pci/hda/tas2781_hda_i2c.c                                               |   14 
 sound/soc/codecs/rt5682.c                                                     |    4 
 sound/soc/codecs/rt5682s.c                                                    |    4 
 sound/soc/codecs/tas2781-comlib.c                                             |    4 
 sound/soc/codecs/tas2781-fmwlib.c                                             |    1 
 sound/soc/codecs/tas2781-i2c.c                                                |   58 
 sound/soc/loongson/loongson_card.c                                            |    4 
 tools/bpf/runqslower/Makefile                                                 |    3 
 tools/perf/builtin-annotate.c                                                 |    2 
 tools/perf/builtin-inject.c                                                   |    1 
 tools/perf/builtin-mem.c                                                      |    1 
 tools/perf/builtin-report.c                                                   |   11 
 tools/perf/builtin-sched.c                                                    |    8 
 tools/perf/builtin-top.c                                                      |    3 
 tools/perf/ui/browsers/annotate.c                                             |   77 
 tools/perf/ui/browsers/hists.c                                                |   34 
 tools/perf/ui/browsers/hists.h                                                |    2 
 tools/perf/util/annotate.c                                                    |  116 -
 tools/perf/util/annotate.h                                                    |   37 
 tools/perf/util/block-info.c                                                  |   10 
 tools/perf/util/block-info.h                                                  |    3 
 tools/perf/util/hist.h                                                        |   25 
 tools/perf/util/session.c                                                     |    3 
 tools/perf/util/sort.c                                                        |   14 
 tools/perf/util/stat-display.c                                                |    3 
 tools/perf/util/time-utils.c                                                  |    4 
 tools/perf/util/tool.h                                                        |    1 
 tools/power/cpupower/lib/powercap.c                                           |    8 
 tools/testing/selftests/arm64/signal/Makefile                                 |    2 
 tools/testing/selftests/arm64/signal/sve_helpers.c                            |   56 
 tools/testing/selftests/arm64/signal/sve_helpers.h                            |   21 
 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c |   46 
 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c |   30 
 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c                    |   36 
 tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c                 |   36 
 tools/testing/selftests/arm64/signal/testcases/sve_regs.c                     |   32 
 tools/testing/selftests/arm64/signal/testcases/za_no_regs.c                   |   32 
 tools/testing/selftests/arm64/signal/testcases/za_regs.c                      |   36 
 tools/testing/selftests/bpf/Makefile                                          |   30 
 tools/testing/selftests/bpf/bench.c                                           |    1 
 tools/testing/selftests/bpf/bench.h                                           |    1 
 tools/testing/selftests/bpf/map_tests/sk_storage_map.c                        |    2 
 tools/testing/selftests/bpf/network_helpers.c                                 |   24 
 tools/testing/selftests/bpf/network_helpers.h                                 |    4 
 tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c                  |    2 
 tools/testing/selftests/bpf/prog_tests/core_reloc.c                           |    1 
 tools/testing/selftests/bpf/prog_tests/decap_sanity.c                         |    1 
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c                       |    3 
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c                            |    1 
 tools/testing/selftests/bpf/prog_tests/lwt_helpers.h                          |    2 
 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c                         |    2 
 tools/testing/selftests/bpf/prog_tests/lwt_reroute.c                          |    2 
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c                  |  154 +
 tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c                    |    1 
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c                            |    1 
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c                          |   12 
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c                              |    1 
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c                         |    1 
 tools/testing/selftests/bpf/progs/cg_storage_multi.h                          |    2 
 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c             |    1 
 tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c                  |   17 
 tools/testing/selftests/bpf/test_cpp.cpp                                      |    4 
 tools/testing/selftests/bpf/test_lru_map.c                                    |    3 
 tools/testing/selftests/bpf/test_progs.c                                      |   18 
 tools/testing/selftests/bpf/testing_helpers.c                                 |    4 
 tools/testing/selftests/bpf/unpriv_helpers.c                                  |    1 
 tools/testing/selftests/bpf/veristat.c                                        |    8 
 tools/testing/selftests/bpf/xdp_hw_metadata.c                                 |   14 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc              |    2 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc            |    2 
 virt/kvm/kvm_main.c                                                           |   31 
 499 files changed, 6253 insertions(+), 3268 deletions(-)

Aaron Lu (1):
      x86/sgx: Fix deadlock in SGX NUMA node search

Adrian Hunter (1):
      perf/x86/intel/pt: Fix sampling synchronization

Aleksandr Mishin (2):
      ACPI: PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()
      drm/msm: Fix incorrect file name output in adreno_request_fw()

Alex Bee (1):
      drm/rockchip: vop: Allow 4096px width scaling

Alex Deucher (2):
      drm/amdgpu: properly handle vbios fake edid sizing
      drm/radeon: properly handle vbios fake edid sizing

Alexander Dahl (3):
      ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks
      spi: atmel-quadspi: Avoid overwriting delay register settings
      spi: atmel-quadspi: Fix wrong register value written to MR

Alexander Shiyan (1):
      clk: rockchip: rk3588: Fix 32k clock name for pmu_24m_32k_100m_src_p

Alexandra Diupina (1):
      PCI: kirin: Fix buffer overflow in kirin_pcie_parse_port()

Alexei Starovoitov (1):
      selftests/bpf: Workaround strict bpf_lsm return value check.

Alexey Gladkov (Intel) (1):
      x86/tdx: Fix "in-kernel MMIO" check

Anastasia Belova (1):
      arm64: esr: Define ESR_ELx_EC_* constants as UL

Andre Przywara (1):
      kselftest/arm64: signal: fix/refactor SVE vector length enumeration

Andrew Davis (3):
      arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations
      arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x carveout locations
      hwmon: (max16065) Remove use of i2c_match_id()

Andrew Jones (1):
      RISC-V: KVM: Fix sbiret init before forwarding to userspace

André Apitzsch (1):
      iio: magnetometer: ak8975: Fix 'Unexpected device' error

Andy Shevchenko (2):
      spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ
      i2c: isch: Add missed 'else'

AngeloGioacchino Del Regno (1):
      arm64: dts: mediatek: mt8186: Fix supported-hw mask for GPU OPPs

Ankit Agrawal (1):
      clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_timer_init()

Antoniu Miclaus (1):
      ABI: testing: fix admv8818 attr description

Ard Biesheuvel (1):
      efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption

Arend van Spriel (3):
      wifi: brcmfmac: export firmware interface functions
      wifi: brcmfmac: introducing fwil query functions
      wifi: brcmfmac: add linefeed at end of file

Artur Weber (1):
      power: supply: max17042_battery: Fix SOC threshold calc w/ no current sense

Atish Patra (2):
      RISC-V: KVM: Allow legacy PMU access from guest
      RISC-V: KVM: Fix to allow hpmcounter31 from the guest

Avraham Stern (1):
      wifi: iwlwifi: mvm: increase the time between ranging measurements

Baochen Qiang (1):
      wifi: ath12k: fix invalid AMPDU factor calculation in ath12k_peer_assoc_h_he()

Benjamin Lin (1):
      wifi: mt76: mt7996: ensure 4-byte alignment for beacon commands

Biju Das (2):
      media: platform: rzg2l-cru: rzg2l-csi2: Add missing MODULE_DEVICE_TABLE
      iio: magnetometer: ak8975: Convert enum->pointer for data in the match tables

Bitterblue Smith (2):
      wifi: rtw88: Fix USB/SDIO devices not transmitting beacons
      wifi: rtw88: 8822c: Fix reported RX band width

Bjørn Mork (1):
      wifi: mt76: mt7915: fix oops on non-dbdc mt7986

Calvin Owens (1):
      ARM: 9410/1: vfp: Use asm volatile in fmrx/fmxr macros

Chao Yu (12):
      f2fs: atomic: fix to avoid racing w/ GC
      f2fs: reduce expensive checkpoint trigger frequency
      f2fs: fix to avoid racing in between read and OPU dio write
      f2fs: fix to wait page writeback before setting gcing flag
      f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation
      f2fs: support .shutdown in f2fs_sops
      f2fs: fix to avoid use-after-free in f2fs_stop_gc_thread()
      f2fs: compress: do sanity check on cluster when CONFIG_F2FS_CHECK_FS is on
      f2fs: clean up w/ dotdot_name
      f2fs: get rid of online repaire on corrupted directory
      f2fs: fix to don't set SB_RDONLY in f2fs_handle_critical_error()
      f2fs: fix to check atomic_file in f2fs ioctl interfaces

Charles Han (1):
      mtd: powernv: Add check devm_kasprintf() returned value

Chen Yu (1):
      kthread: fix task state in kthread worker if being frozen

Chen-Yu Tsai (3):
      regulator: Return actual error in of_regulator_bulk_get_all()
      arm64: dts: mediatek: mt8195: Correct clock order for dp_intf*
      arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled

Cheng Xu (1):
      RDMA/erdma: Return QP state in erdma_query_qp

Chengchang Tang (2):
      RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled
      RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS

Chris Morgan (1):
      power: supply: axp20x_battery: Remove design from min and max voltage

Christian Heusel (1):
      block: print symbolic error name instead of error code

Christophe JAILLET (4):
      fbdev: hpfb: Fix an error handling path in hpfb_dio_probe()
      drm/stm: Fix an error handling path in stm_drm_platform_probe()
      pinctrl: ti: ti-iodelay: Fix some error handling paths
      pps: remove usage of the deprecated ida_simple_xx() API

Christophe Leroy (3):
      powerpc/8xx: Fix initial memory mapping
      powerpc/8xx: Fix kernel vs user address comparison
      powerpc/vdso: Inconditionally use CFUNC macro

Chuck Lever (1):
      fs: Create a generic is_dot_dotdot() utility

Claudiu Beznea (3):
      ARM: dts: microchip: sama7g5: Fix RTT clock
      drm/stm: ltdc: check memory returned by devm_kzalloc()
      clk: at91: sama7g5: Allocate only the needed amount of memory for PLLs

Clément Léger (1):
      ACPI: CPPC: Fix MASK_VAL() usage

Cristian Marussi (1):
      firmware: arm_scmi: Fix double free in OPTEE transport

Cupertino Miranda (1):
      selftests/bpf: Add CFLAGS per source file and runner

D Scott Phillips (1):
      arm64: errata: Enable the AC03_CPU_38 workaround for ampere1a

Daeho Jeong (1):
      f2fs: prevent atomic file from being dirtied before commit

Daehwan Jung (1):
      xhci: Add a quirk for writing ERST in high-low order

Damien Le Moal (1):
      ata: libata-scsi: Fix ata_msense_control() CDL page reporting

Dan Carpenter (4):
      powercap: intel_rapl: Fix off by one in get_rpi()
      scsi: elx: libefc: Fix potential use after free in efc_nport_vport_del()
      PCI: keystone: Fix if-statement expression in ks_pcie_quirk()
      ep93xx: clock: Fix off by one in ep93xx_div_recalc_rate()

Daniel Borkmann (4):
      bpf: Fix bpf_strtol and bpf_strtoul helpers for 32bit
      bpf: Fix helper writes to read-only maps
      bpf: Improve check_raw_mode_ok test for MEM_UNINIT-tagged types
      bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error

Danny Tsen (1):
      crypto: powerpc/p10-aes-gcm - Disable CRYPTO_AES_GCM_P10

Dave Jiang (1):
      ntb: Force physically contiguous allocation of rx ring buffers

Dave Martin (1):
      arm64: signal: Fix some under-bracketed UAPI macros

David Gow (1):
      mm: only enforce minimum stack gap size if it's sensible

David Howells (1):
      cachefiles: Fix non-taking of sb_writers around set/removexattr

David Lechner (1):
      clk: ti: dra7-atl: Fix leak of of_nodes

David Sterba (1):
      btrfs: reorder btrfs_inode to fill gaps

David Virag (1):
      arm64: dts: exynos: exynos7885-jackpotlte: Correct RAM amount to 4GB

Dmitry Antipov (4):
      wifi: rtw88: always wait for both firmware loading attempts
      wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()
      wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors
      wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()

Dmitry Baryshkov (8):
      iommu/arm-smmu-qcom: apply num_context_bank fixes for SDM630 / SDM660
      drm/msm/dsi: correct programming sequence for SM8350 / SM8450
      clk: qcom: dispcc-sm8550: fix several supposed typos
      clk: qcom: dispcc-sm8550: use rcg2_ops for mdss_dptx1_aux_clk_src
      clk: qcom: dispcc-sm8650: Update the GDSC flags
      clk: qcom: dispcc-sm8550: use rcg2_shared_ops for ESC RCGs
      clk: qcom: dispcc-sm8250: use special function for Lucid 5LPE PLL
      Revert "soc: qcom: smd-rpm: Match rpmsg channel instead of compatible"

Dmitry Kandybka (1):
      wifi: rtw88: remove CPT execution branch never used

Dmitry Vyukov (2):
      x86/entry: Remove unwanted instrumentation in common_interrupt()
      module: Fix KCOV-ignored file name

Dragan Simic (2):
      arm64: dts: rockchip: Raise Pinebook Pro's panel backlight PWM frequency
      arm64: dts: rockchip: Correct the Pinebook Pro battery design capacity

Duanqiang Wen (1):
      Revert "net: libwx: fix alloc msix vectors failed"

Eduard Zingerman (1):
      bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos

Emanuele Ghidoli (2):
      Input: ilitek_ts_i2c - avoid wrong input subsystem sync
      Input: ilitek_ts_i2c - add report id message validation

Eric Dumazet (4):
      sock_map: Add a cond_resched() in sock_hash_free()
      ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()
      netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
      icmp: change the order of rate limits

Fabio Porcedda (1):
      bus: mhi: host: pci_generic: Fix the name for the Telit FE990A

Fangzhi Zuo (2):
      drm/amd/display: Fix Synaptics Cascaded Panamera DSC Determination
      drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Fei Shao (1):
      drm/mediatek: Use spin_lock_irqsave() for CRTC event lock

Felix Fietkau (2):
      wifi: mt76: mt7603: fix mixed declarations and code
      wifi: mt76: mt7996: fix uninitialized TLV data

Felix Moessbauer (4):
      io_uring/io-wq: do not allow pinning outside of cpuset
      io_uring/io-wq: inherit cpuset of cgroup in io worker
      io_uring/sqpoll: do not allow pinning outside of cpuset
      io_uring/sqpoll: do not put cpumask on stack

Filipe Manana (2):
      btrfs: update comment for struct btrfs_inode::lock
      btrfs: fix race setting file private on concurrent lseek using same fd

Finn Thain (5):
      m68k: Fix kernel_clone_args.flags in m68k_clone()
      scsi: NCR5380: Check for phase match during PDMA fixup
      scsi: mac_scsi: Revise printk(KERN_DEBUG ...) messages
      scsi: mac_scsi: Refactor polling loop
      scsi: mac_scsi: Disallow bus errors during PDMA send

Florian Fainelli (1):
      tty: rp2: Fix reset with non forgiving PCIe host bridges

Frank Li (1):
      PCI: imx6: Fix missing call to phy_power_off() in error handling

Frederic Weisbecker (1):
      rcu/nocb: Fix RT throttling hrtimer armed from offline CPU

Furong Xu (1):
      net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled

Gao Xiang (1):
      erofs: fix incorrect symlink detection in fast symlink

Gaosheng Cui (2):
      hwrng: bcm2835 - Add missing clk_disable_unprepare in bcm2835_rng_init
      hwrng: cctrng - Add missing clk_disable_unprepare in cctrng_resume

Geert Uytterhoeven (1):
      pmdomain: core: Harden inter-column space in debug summary

Gergo Koteles (1):
      ASoC: tas2781: remove unused acpi_subysystem_id

Gil Fine (9):
      thunderbolt: Fix debug log when DisplayPort adapter not available for pairing
      thunderbolt: Create multiple DisplayPort tunnels if there are more DP IN/OUT pairs
      thunderbolt: Make is_gen4_link() available to the rest of the driver
      thunderbolt: Change bandwidth reservations to comply USB4 v2
      thunderbolt: Introduce tb_port_path_direction_downstream()
      thunderbolt: Add support for asymmetric link
      thunderbolt: Configure asymmetric link if needed and bandwidth allows
      thunderbolt: Improve DisplayPort tunnel setup process to be more robust
      thunderbolt: Fix minimum allocated USB 3.x and PCIe bandwidth

Gilbert Wu (1):
      scsi: smartpqi: revert propagate-the-multipath-failure-to-SML-quickly

Golan Ben Ami (1):
      wifi: iwlwifi: remove AX101, AX201 and AX203 support from LNL

Greg Kroah-Hartman (1):
      Linux 6.6.54

Guenter Roeck (2):
      hwmon: (max16065) Fix overflows seen when writing limits
      hwmon: (max16065) Fix alarm attributes

Guillaume Nault (2):
      bareudp: Pull inner IP header in bareudp_udp_encap_recv().
      bareudp: Pull inner IP header on xmit.

Guillaume Stols (2):
      iio: adc: ad7606: fix oversampling gpio array
      iio: adc: ad7606: fix standby gpio state to match the documentation

Guoqing Jiang (2):
      nfsd: call cache_put if xdr_reserve_space returns NULL
      hwrng: mtk - Use devm_pm_runtime_enable

Haibo Chen (3):
      spi: fspi: involve lut_num for struct nxp_fspi_devtype_data
      dt-bindings: spi: nxp-fspi: add imx8ulp support
      spi: fspi: add support for imx8ulp

Hannes Reinecke (1):
      nvme-multipath: system fails to create generic nvme device

Harshit Mogalapalli (1):
      usb: yurex: Fix inconsistent locking bug in yurex_read()

Heiner Kallweit (1):
      r8169: disable ALDPS per default for RTL8125

Helge Deller (1):
      crypto: xor - fix template benchmarking

Herbert Xu (1):
      crypto: caam - Pad SG length when allocating hash edesc

Herve Codina (1):
      soc: fsl: cpm1: tsa: Fix tsa_write8()

Hobin Woo (1):
      ksmbd: make __dir_empty() compatible with POSIX

Howard Hsu (3):
      wifi: mt76: mt7996: fix HE and EHT beamforming capabilities
      wifi: mt76: mt7996: fix EHT beamforming capability check
      wifi: mt76: mt7915: fix rx filter setting for bfee functionality

Ian Rogers (2):
      perf inject: Fix leader sampling inserting additional samples
      perf time-utils: Fix 32-bit nsec parsing

Ilpo Järvinen (1):
      PCI: Wait for Link before restoring Downstream Buses

Jack Wang (1):
      RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer

Jacky Bai (1):
      clk: imx: composite-93: keep root clock on when mcore enabled

Jake Hamby (1):
      can: m_can: enable NAPI before enabling interrupts

Jann Horn (2):
      firmware_loader: Block path traversal
      f2fs: Require FMODE_WRITE for atomic write ioctls

Jason Gerecke (2):
      HID: wacom: Support sequence numbers smaller than 16-bit
      HID: wacom: Do not warn about dropped packets for first packet

Jason Gunthorpe (2):
      iommu/amd: Do not set the D bit on AMD v2 table entries
      iommufd: Protect against overflow of ALIGN() during iova allocation

Jason Wang (1):
      vhost_vdpa: assign irq bypass producer token correctly

Jason-JH.Lin (1):
      drm/mediatek: Fix missing configuration flags in mtk_crtc_ddp_config()

Javier Carrasco (3):
      leds: bd2606mvv: Fix device child node usage in bd2606mvv_probe()
      leds: pca995x: Use device_for_each_child_node() to access device child nodes
      leds: pca995x: Fix device child node usage in pca995x_probe()

Jeff Layton (2):
      nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
      nfsd: fix refcount leak when file is unhashed after being found

Jens Axboe (2):
      io_uring: check for presence of task_work rather than TIF_NOTIFY_SIGNAL
      io_uring/sqpoll: retain test for whether the CPU is valid

Jeongjun Park (1):
      jfs: fix out-of-bounds in dbNextAG() and diAlloc()

Jiangshan Yi (1):
      samples/bpf: Fix compilation errors with cf-protection option

Jiawei Ye (2):
      wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param
      smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso

Jing Zhang (1):
      drivers/perf: Fix ali_drw_pmu driver interrupt status clearing

Jinjie Ruan (8):
      net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
      mtd: rawnand: mtk: Use for_each_child_of_node_scoped()
      riscv: Fix fp alignment bug in perf_callchain_user()
      ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
      spi: atmel-quadspi: Undo runtime PM changes at driver exit time
      spi: spi-fsl-lpspi: Undo runtime PM changes at driver exit time
      driver core: Fix a potential null-ptr-deref in module_add_driver()

Jiri Slaby (SUSE) (1):
      serial: don't use uninitialized value in uart_poll_init()

Jiwon Kim (1):
      bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()

Johan Hovold (1):
      serial: qcom-geni: fix fifo polling timeout

Johannes Berg (1):
      wifi: iwlwifi: config: label 'gl' devices as discrete

John B. Wyatt IV (1):
      pm:cpupower: Add missing powercap_set_enabled() stub function

Jonas Blixt (1):
      watchdog: imx_sc_wdt: Don't disable WDT in suspend

Jonas Karlman (3):
      arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-M1
      drm/rockchip: dw_hdmi: Fix reading EDID when using a forced mode
      clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228

Jonathan McDowell (1):
      tpm: Clean up TPM space after command failure

Jose E. Marchesi (3):
      bpf: Use -Wno-error in certain tests when building with GCC
      bpf: Disable some `attribute ignored' warnings in GCC
      bpf: Temporarily define BPF_NO_PRESEVE_ACCESS_INDEX for GCC

Josh Hunt (1):
      tcp: check skb is non-NULL in tcp_rto_delta_us()

Juergen Gross (9):
      xen: use correct end address of kernel for conflict checking
      xen: introduce generic helper checking for memory map conflicts
      xen: move max_pfn in xen_memory_setup() out of function scope
      xen: add capability to remap non-RAM pages to different PFNs
      xen: tolerate ACPI NVS memory overlapping with Xen allocated memory
      xen/swiotlb: add alignment check for dma buffers
      xen/swiotlb: fix allocated size
      xen: move checks for e820 conflicts further up
      xen: allow mapping ACPI data using a different physical address

Julian Sun (1):
      vfs: fix race between evice_inodes() and find_inode()&iput()

Junlin Li (2):
      drivers: media: dvb-frontends/rtl2832: fix an out-of-bounds write error
      drivers: media: dvb-frontends/rtl2830: fix an out-of-bounds write error

Junxian Huang (4):
      RDMA/hns: Don't modify rq next block addr in HIP09 QPC
      RDMA/hns: Fix VF triggering PF reset in abnormal interrupt handler
      RDMA/hns: Optimize hem allocation performance
      RDMA/hns: Fix restricted __le16 degrades to integer issue

Justin Iurman (1):
      net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input

Kairui Song (3):
      mm/filemap: return early if failed to allocate memory for split
      lib/xarray: introduce a new helper xas_get_order
      mm/filemap: optimize filemap folio adding

Kaixin Wang (1):
      net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition

Kamlesh Gurudasani (1):
      padata: Honor the caller's alignment in case of chunk_size 0

Kan Liang (1):
      perf report: Fix --total-cycles --stdio output error

Kees Cook (1):
      interconnect: icc-clk: Add missed num_nodes initialization

Kemeng Shi (3):
      ext4: avoid buffer_head leak in ext4_mark_inode_used()
      ext4: avoid potential buffer_head leak in __ext4_new_inode()
      ext4: avoid negative min_clusters in find_group_orlov()

Konrad Dybcio (1):
      iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/ 16K pages

Krzysztof Kozlowski (12):
      ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property
      ARM: versatile: fix OF node leak in CPUs prepare
      reset: berlin: fix OF node leak in probe() error path
      reset: k210: fix OF node leak in probe() error path
      iio: magnetometer: ak8975: drop incorrect AK09116 compatible
      dt-bindings: iio: asahi-kasei,ak8975: drop incorrect AK09116 compatible
      soc: versatile: integrator: fix OF node leak in probe() error path
      bus: integrator-lm: fix OF node leak in probe()
      cpuidle: riscv-sbi: Use scoped device node handling to fix missing of_node_put
      ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp pinctrl
      soc: versatile: realview: fix memory leak during device remove
      soc: versatile: realview: fix soc_dev leak during device remove

Kuniyuki Iwashima (1):
      can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().

Lad Prabhakar (3):
      arm64: dts: renesas: r9a07g043u: Correct GICD and GICR sizes
      arm64: dts: renesas: r9a07g054: Correct GICD and GICR sizes
      arm64: dts: renesas: r9a07g044: Correct GICD and GICR sizes

Lasse Collin (1):
      xz: cleanup CRC32 edits from 2018

Laurent Pinchart (1):
      Remove *.orig pattern from .gitignore

Lee Jones (1):
      usb: yurex: Replace snprintf() with the safer scnprintf() variant

Leo Ma (1):
      drm/amd/display: Add HDMI DSC native YCbCr422 support

Li Lingfeng (2):
      nfsd: return -EINVAL when namelen is 0
      nfs: fix memory leak in error path of nfs4_do_reclaim

Li Zhijian (1):
      nvdimm: Fix devs leaks in scan_labels()

Liam R. Howlett (1):
      mm/damon/vaddr: protect vma traversal in __damon_va_thre_regions() with rcu read lock

Linus Torvalds (1):
      minmax: avoid overly complex min()/max() macro arguments in xen

Linus Walleij (2):
      ASoC: tas2781-i2c: Drop weird GPIO code
      ASoC: tas2781-i2c: Get the right GPIO line

Liu Ying (1):
      drm/bridge: lontium-lt8912b: Validate mode in drm_bridge_funcs::mode_valid()

Luca Stefani (1):
      btrfs: always update fstrim_range on failure in FITRIM ioctl

Luiz Augusto von Dentz (3):
      Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED
      Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL
      Bluetooth: btusb: Fix not handling ZPL/short-transfer

Ma Ke (8):
      spi: ppc4xx: handle irq_of_parse_and_map() errors
      ASoC: rt5682s: Return devm_of_clk_add_hw_provider to transfer the error
      ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error
      wifi: mt76: mt7921: Check devm_kasprintf() returned value
      wifi: mt76: mt7915: check devm_kasprintf() returned value
      wifi: mt76: mt7996: fix NULL pointer dereference in mt7996_mcu_sta_bfer_he
      wifi: mt76: mt7615: check devm_kasprintf() returned value
      pps: add an error check in parport_attach

Maciej W. Rozycki (4):
      PCI: Revert to the original speed after PCIe failed link retraining
      PCI: Clear the LBMS bit after a link retrain
      PCI: Correct error reporting with PCIe failed link retraining
      PCI: Use an error code with PCIe failed link retraining

Manish Pandey (1):
      scsi: ufs: qcom: Update MODE_MAX cfg_bw value

Marc Gonzalez (1):
      iommu/arm-smmu-qcom: hide last LPASS SMMU context bank from linux

Marc Kleine-Budde (1):
      can: m_can: m_can_close(): stop clocks after device has been shut down

Mario Limonciello (1):
      drm/amd/display: Validate backlight caps are sane

Mark Bloch (1):
      RDMA/mlx5: Obtain upper net device only when needed

Mark Brown (1):
      kselftest/arm64: Actually test SME vector length changes via sigreturn

Markus Elfring (1):
      clk: imx: composite-8m: Less function calls in __imx8m_clk_hw_composite() after error detection

Markus Schneider-Pargmann (1):
      serial: 8250: omap: Cleanup on error in request_irq

Martin Wilck (1):
      scsi: sd: Fix off-by-one error in sd_read_block_characteristics()

Masami Hiramatsu (Google) (1):
      selftests/ftrace: Add required dependency for kprobe tests

Mathias Nyman (1):
      xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and freeing them.

Max Hawking (1):
      ntb_perf: Fix printk format

Md Haris Iqbal (1):
      RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds

Mel Gorman (5):
      sched/numa: Document vma_numab_state fields
      sched/numa: Rename vma_numab_state::access_pids[] => ::pids_active[], ::next_pid_reset => ::pids_active_reset
      sched/numa: Trace decisions related to skipping VMAs
      sched/numa: Complete scanning of partial VMAs regardless of PID activity
      sched/numa: Complete scanning of inactive VMAs when there is no alternative

Michael Ellerman (1):
      powerpc/atomic: Use YZ constraints for DS-form instructions

Michael Guralnik (1):
      RDMA/mlx5: Limit usage of over-sized mkeys from the MR cache

Michael Trimarchi (1):
      tty: serial: kgdboc: Fix 8250_* kgdb over serial

Mickaël Salaün (1):
      fs: Fix file_set_fowner LSM hook inconsistencies

Mika Westerberg (8):
      thunderbolt: Use tb_tunnel_dbg() where possible to make logging more consistent
      thunderbolt: Expose tb_tunnel_xxx() log macros to the rest of the driver
      thunderbolt: Use constants for path weight and priority
      thunderbolt: Use weight constants in tb_usb3_consumed_bandwidth()
      thunderbolt: Introduce tb_for_each_upstream_port_on_path()
      thunderbolt: Introduce tb_switch_depth()
      thunderbolt: Send uevent after asymmetric/symmetric switch
      thunderbolt: Fix NULL pointer dereference in tb_port_update_credits()

Mikhail Lobanov (2):
      RDMA/cxgb4: Added NULL check for lookup_atid
      drbd: Add NULL check for net_conf to prevent dereference in state validation

Mikulas Patocka (3):
      Revert "dm: requeue IO if mapping table not yet available"
      dm-verity: restart or panic on an I/O error
      Revert: "dm-verity: restart or panic on an I/O error"

Ming Lei (3):
      ublk: move zone report data out of request pdu
      nbd: fix race between timeout and normal completion
      lib/sbitmap: define swap_lock as raw_spinlock_t

Miquel Raynal (2):
      mtd: rawnand: mtk: Factorize out the logic cleaning mtk chips
      mtd: rawnand: mtk: Fix init error path

Mirsad Todorovac (1):
      mtd: slram: insert break after errors in parsing the map

Namhyung Kim (4):
      perf mem: Free the allocated sort string, fixing a leak
      perf annotate: Split branch stack cycles info from 'struct annotation'
      perf annotate: Move some source code related fields from 'struct annotation' to 'struct annotated_source'
      perf ui/browser/annotate: Use global annotation_options

Namjae Jeon (2):
      ksmbd: allow write with FILE_APPEND_DATA
      ksmbd: handle caseless file creation

Nick Morrow (1):
      wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c

Nikita Zhandarovich (4):
      drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets
      f2fs: fix several potential integer overflows in file offsets
      f2fs: prevent possible int overflow in dir_block_index()
      f2fs: avoid potential int overflow in sanity_check_area_boundary()

Niklas Cassel (1):
      ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data

Nishanth Menon (1):
      cpufreq: ti-cpufreq: Introduce quirks to handle syscon fails appropriately

Nuno Sa (1):
      Input: adp5588-keys - fix check on return code

Ojaswin Mujoo (1):
      ext4: check stripe size compatibility on remount as well

Olaf Hering (1):
      mount: handle OOM on mnt_warn_timestamp_expiry

Oleg Nesterov (1):
      bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()

Oliver Neukum (5):
      usbnet: fix cyclical race on disconnect with work queue
      USB: appledisplay: close race between probe and completion handler
      USB: misc: cypress_cy7c63: check for short transfer
      USB: class: CDC-ACM: fix race between get_serial and set_serial
      USB: misc: yurex: fix race between read and write

P Praneesh (2):
      wifi: ath12k: fix BSS chan info request WMI command
      wifi: ath12k: match WMI BSS chan info structure with firmware definition

Pablo Neira Ayuso (5):
      netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire
      netfilter: nf_tables: reject element expiration with no timeout
      netfilter: nf_tables: reject expiration higher than timeout
      netfilter: nf_tables: remove annotation to access set timeout while holding lock
      netfilter: nf_tables: use rcu chain hook list iterator from netlink dump path

Paolo Bonzini (1):
      Documentation: KVM: fix warning in "make htmldocs"

Patrisious Haddad (1):
      IB/core: Fix ib_cache_setup_one error flow cleanup

Pavan Kumar Paluri (1):
      crypto: ccp - Properly unregister /dev/sev on sev PLATFORM_STATUS failure

Pawel Laszczak (2):
      usb: cdnsp: Fix incorrect usb_request status
      usb: xhci: fix loss of data on Cadence xHC

Peng Fan (7):
      clk: imx: composite-8m: Enable gate clk with mcore_booted
      clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
      clk: imx: imx8qxp: Parent should be initialized earlier than the clock
      remoteproc: imx_rproc: Correct ddr alias for i.MX8M
      remoteproc: imx_rproc: Initialize workqueue earlier
      pinctrl: ti: iodelay: Use scope based of_node_put() cleanups
      dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95

Pengfei Li (1):
      clk: imx: fracn-gppll: fix fractional part of PLL getting lost

Peter Chiu (3):
      wifi: mt76: mt7996: use hweight16 to get correct tx antenna
      wifi: mt76: mt7996: fix traffic delay when switching back to working channel
      wifi: mt76: mt7996: fix wmm set of station interface to 3

Phil Sutter (1):
      netfilter: nf_tables: Keep deleted flowtable hooks until after RCU

Pieterjan Camerlynck (1):
      leds: leds-pca995x: Add support for NXP PCA9956B

Ping-Ke Shih (1):
      wifi: mac80211: don't use rate mask for offchannel TX either

Qingqing Zhou (1):
      arm64: dts: qcom: sa8775p: Mark APPS and PCIe SMMUs as DMA coherent

Qiu-ji Chen (1):
      drbd: Fix atomicity violation in drbd_uuid_set_bm()

Qiuxu Zhuo (1):
      EDAC/igen6: Fix conversion of system address to physical memory address

Qu Wenruo (2):
      btrfs: tree-checker: fix the wrong output of data backref objectid
      btrfs: subpage: fix the bitmap dump which can cause bitmap corruption

Raghavendra K T (1):
      sched/numa: Move up the access pid reset logic

Riyan Dhiman (1):
      block: fix potential invalid pointer dereference in blk_add_partition

Rob Herring (1):
      pinctrl: Use device_get_match_data()

Rob Herring (Arm) (1):
      ASoC: tas2781: Use of_property_read_reg()

Robin Chen (1):
      drm/amd/display: Round calculated vtotal

Robin Murphy (6):
      perf/arm-cmn: Rework DTC counters (again)
      perf/arm-cmn: Improve debugfs pretty-printing for large configs
      perf/arm-cmn: Refactor node ID handling. Again.
      perf/arm-cmn: Fix CCLA register offset
      perf/arm-cmn: Ensure dtm_idx is big enough
      perf/arm-cmn: Fail DTC counter allocation correctly

Roman Smirnov (2):
      Revert "media: tuners: fix error return code of hybrid_tuner_request_state()"
      KEYS: prevent NULL pointer dereference in find_asymmetric_key()

Ryusuke Konishi (3):
      nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()
      nilfs2: determine empty node blocks as corrupted
      nilfs2: fix potential oob read in nilfs_btree_check_delete()

Samasth Norway Ananda (1):
      x86/PCI: Check pcie_find_root_port() return for NULL

Sean Anderson (5):
      PCI: xilinx-nwl: Fix register misspelling
      PCI: xilinx-nwl: Clean up clock on probe failure/removal
      net: xilinx: axienet: Schedule NAPI in two steps
      net: xilinx: axienet: Fix packet counting
      PCI: xilinx-nwl: Fix off-by-one in INTx IRQ handler

Sean Christopherson (3):
      KVM: x86: Enforce x2APIC's must-be-zero reserved ICR bits
      KVM: x86: Move x2APIC ICR helper above kvm_apic_write_nodecode()
      KVM: Use dedicated mutex to protect kvm_usage_count to avoid deadlock

Sebastien Laveze (1):
      clk: imx: imx6ul: fix default parent for enet*_ref_sel

Serge Semin (1):
      EDAC/synopsys: Fix ECC status and IRQ control race condition

Shengjiu Wang (1):
      clk: imx: clk-audiomix: Correct parent clock for earc_phy and audpll

Sherry Yang (1):
      drm/msm: fix %s null argument error

Shu Han (1):
      mm: call the security_mmap_file() LSM hook in remap_file_pages()

Shubhrajyoti Datta (1):
      EDAC/synopsys: Fix error injection on Zynq UltraScale+

Siddharth Vadapalli (1):
      PCI: dra7xx: Fix threaded IRQ request for "dra7xx-pcie-main" IRQ

Simon Horman (1):
      netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS

Snehal Koukuntla (1):
      KVM: arm64: Add memory length checks and remove inline in do_ffa_mem_xfer

Song Liu (1):
      bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0

Srinivasan Shanmugam (1):
      drm/amd/display: Add null check for set_output_gamma in dcn30_set_output_transfer_func

Stefan Mätje (1):
      can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD

Stefan Wahren (1):
      drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get

Su Hui (1):
      net: tipc: avoid possible garbage value

Suzuki K Poulose (1):
      coresight: tmc: sg: Do not leak sg_table

Syed Nayyar Waris (1):
      lib/bitmap: add bitmap_{read,write}()

Takashi Sakamoto (1):
      firewire: core: correct range of block for case of switch statement

Thadeu Lima de Souza Cascardo (2):
      ext4: return error on ext4_find_inline_entry
      ext4: avoid OOB when system.data xattr changes underneath the filesystem

Thomas Weißschuh (2):
      net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
      ACPI: sysfs: validate return type of _STR method

Tianchen Ding (1):
      sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy

Toke Høiland-Jørgensen (1):
      wifi: ath9k: Remove error checks when creating debugfs entries

Tomas Marek (1):
      usb: dwc2: drd: fix clock gating on USB role switch

Tommy Huang (1):
      i2c: aspeed: Update the stop sw state when the bus recovery occurs

Tony Ambardar (25):
      selftests/bpf: Fix error linking uprobe_multi on mips
      selftests/bpf: Fix wrong binary in Makefile log output
      tools/runqslower: Fix LDFLAGS and add LDLIBS support
      selftests/bpf: Use pid_t consistently in test_progs.c
      selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
      selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl libc
      selftests/bpf: Drop unneeded error.h includes
      selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c
      selftests/bpf: Fix missing UINT_MAX definitions in benchmarks
      selftests/bpf: Fix missing BUILD_BUG_ON() declaration
      selftests/bpf: Fix include of <sys/fcntl.h>
      selftests/bpf: Fix compiling parse_tcp_hdr_opt.c with musl-libc
      selftests/bpf: Fix compiling kfree_skb.c with musl-libc
      selftests/bpf: Fix compiling flow_dissector.c with musl-libc
      selftests/bpf: Fix compiling tcp_rtt.c with musl-libc
      selftests/bpf: Fix compiling core_reloc.c with musl-libc
      selftests/bpf: Fix errors compiling lwt_redirect.c with musl libc
      selftests/bpf: Fix errors compiling decap_sanity.c with musl libc
      selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc
      selftests/bpf: Fix arg parsing in veristat, test_progs
      selftests/bpf: Fix error compiling test_lru_map.c
      selftests/bpf: Fix C++ compile error from missing _Bool type
      selftests/bpf: Fix redefinition errors compiling lwt_reroute.c
      selftests/bpf: Fix compile if backtrace support missing in libc
      selftests/bpf: Fix error compiling tc_redirect.c with musl libc

Tushar Vyavahare (1):
      selftests/bpf: Implement get_hw_ring_size function to retrieve current and max interface size

Uwe Kleine-König (1):
      pinctrl: ti: ti-iodelay: Convert to platform remove callback returning void

VanGiang Nguyen (1):
      padata: use integer wrap around to prevent deadlock on seq_nr overflow

Varadarajan Narayanan (1):
      clk: qcom: ipq5332: Register gcc_qdss_tsctr_clk_src

Vasileios Amoiridis (1):
      iio: chemical: bme680: Fix read/write ops to device by adding mutexes

Vitaliy Shevtsov (1):
      RDMA/irdma: fix error message in irdma_modify_qp_roce()

Vladimir Lypak (4):
      drm/msm/a5xx: disable preemption in submits by default
      drm/msm/a5xx: properly clear preemption records on resume
      drm/msm/a5xx: fix races in preemption evaluation stage
      drm/msm/a5xx: workaround early ring-buffer emptiness check

Wang Jianzheng (1):
      pinctrl: mvebu: Fix devinit_dove_pinctrl_probe function

WangYuli (1):
      drm/amd/amdgpu: Properly tune the size of struct

Weili Qian (3):
      crypto: hisilicon/hpre - mask cluster timeout error
      crypto: hisilicon/qm - reset device before enabling it
      crypto: hisilicon/qm - inject error before stopping queue

Wenbo Li (1):
      virtio_net: Fix mismatched buf address when unmapping for small packets

Werner Sembach (4):
      Input: i8042 - add TUXEDO Stellaris 16 Gen5 AMD to i8042 quirk table
      Input: i8042 - add TUXEDO Stellaris 15 Slim Gen6 AMD to i8042 quirk table
      Input: i8042 - add another board name for TUXEDO Stellaris Gen5 AMD line
      ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Wolfram Sang (1):
      ipmi: docs: don't advertise deprecated sysfs entries

Xin Li (1):
      x86/idtentry: Incorporate definitions/declarations of the FRED entries

Yanfei Xu (1):
      cxl/pci: Fix to record only non-zero ranges

Yang Jihong (2):
      perf sched timehist: Fix missing free of session in perf_sched__timehist()
      perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time

Yang Yingliang (1):
      pinctrl: single: fix missing error code in pcs_probe()

Yanteng Si (1):
      net: stmmac: dwmac-loongson: Init ref and PTP clocks rate

Ye Li (1):
      clk: imx: composite-7ulp: Check the PCC present bit

Yeongjin Gil (2):
      f2fs: Create COW inode from parent dentry for atomic write
      f2fs: compress: don't redirty sparse cluster during {,de}compress

Yicong Yang (3):
      drivers/perf: hisi_pcie: Record hardware counts correctly
      drivers/perf: hisi_pcie: Fix TLP headers bandwidth counting
      perf stat: Display iostat headers correctly

Yonghong Song (4):
      selftests/bpf: Replace CHECK with ASSERT_* in ns_current_pid_tgid test
      selftests/bpf: Refactor out some functions in ns_current_pid_tgid test
      selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test
      selftests/bpf: Fix flaky selftest lwt_redirect/lwt_reroute

Yosry Ahmed (1):
      x86/mm: Use IPIs to synchronize LAM enablement

Youssef Samir (1):
      net: qrtr: Update packets cloning when broadcasting

Yu Kuai (5):
      block, bfq: fix possible UAF for bfqq->bic with merge chain
      block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()
      block, bfq: don't break merge chain in bfq_split_bfqq()
      block, bfq: fix uaf for accessing waker_bfqq after splitting
      block, bfq: fix procress reference leakage for bfqq in merge chain

Yuesong Li (1):
      drivers:drm:exynos_drm_gsc:Fix wrong assignment in gsc_bind()

Yujie Liu (1):
      sched/numa: Fix the vma scan starving issue

Yunfei Dong (3):
      media: mediatek: vcodec: Fix H264 multi stateless decoder smatch warning
      media: mediatek: vcodec: Fix VP8 stateless decoder smatch warning
      media: mediatek: vcodec: Fix H264 stateless decoder smatch warning

Yuntao Liu (3):
      ALSA: hda: cs35l41: fix module autoloading
      hwmon: (ntc_thermistor) fix module autoloading
      clk: starfive: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage

Zack Rusin (1):
      drm/vmwgfx: Prevent unmapping active read buffers

Zhang Changzhong (1):
      can: j1939: use correct function name in comment

Zhen Lei (1):
      debugobjects: Fix conditions in fill_pool()

Zhiguo Niu (1):
      lockdep: fix deadlock issue between lockdep and rcu

Zhipeng Wang (1):
      clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

Zhu Yanjun (1):
      RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency

Zijun Hu (1):
      driver core: Fix error handling in driver API device_rename()

tangbin (1):
      ASoC: loongson: fix error release

wenglianfa (2):
      RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08
      RDMA/hns: Fix the overflow risk of hem_list_calc_ba_range()

yangerkun (1):
      ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard


