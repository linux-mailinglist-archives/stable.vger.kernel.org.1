Return-Path: <stable+bounces-187907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857EFBEE809
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 17:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C4F3AE95E
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BD52EB87B;
	Sun, 19 Oct 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDvCNKZb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A12EB5BA;
	Sun, 19 Oct 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886133; cv=none; b=WcVz9WMzUfQXQQw5oINjdrEbeymXDMa0H8tkh9AwNILmvlKQUxXsl65UHWjYhXrJwsZwgSr/d2f2Nl0Nwca3KtgI1R+sOeY94nEIVq7HZQF+T7PvVC6ae/JfSKfnPb7Ns1lEQiyc2ixuKK94Rn+MXQvkVEjKQZhinAmPuk2kKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886133; c=relaxed/simple;
	bh=XnXVqVSQLHLfg6Ai085C/KkJvSLEBIqMnbV4Nu5RFO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r3fk2Sw6BKNwU5GEAcFgtZYOHAtUO2l/B7G9H9hz11mGTH4dbtkEjFmKaj6EmFIAO36RrtU8cqqB19SGYMyDQj8A8Z3xKduMWDoCgtHJ1P7MpnxwicXsMkAp+p/lfla4dEQzJb8nuxZ0jLpXGZlLUf8k4q1W2w2y49AcqpwYv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDvCNKZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1A3C116D0;
	Sun, 19 Oct 2025 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760886130;
	bh=XnXVqVSQLHLfg6Ai085C/KkJvSLEBIqMnbV4Nu5RFO0=;
	h=From:To:Cc:Subject:Date:From;
	b=dDvCNKZbQcdk86p3djwCaxcg+43X2OvStYlCixTmeX5IA8EB7kKQy1TN7TU/LyMfv
	 5WkSi94AbkS1R7t9/ToW/2CZs1wQ8Y91lZj2y0WOFN8YUG6l3ernD7CKhr2AC9sRaY
	 thxhJMfPy984OyGL4yvWP3kArM1hNmuf6hsFp2KU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.4
Date: Sun, 19 Oct 2025 17:02:02 +0200
Message-ID: <2025101903-resample-impeach-822d@gregkh>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.4 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                   |    3 
 Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml |   15 
 Makefile                                                          |    2 
 arch/arm/mach-omap2/am33xx-restart.c                              |   36 
 arch/arm/mach-omap2/pm33xx-core.c                                 |    6 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/msm8939.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/qcs615.dtsi                              |    6 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                              |    4 
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi                      |    2 
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                         |    2 
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi                             |    2 
 arch/arm64/include/asm/ftrace.h                                   |    1 
 arch/arm64/kernel/cpufeature.c                                    |   10 
 arch/arm64/kernel/mte.c                                           |    2 
 arch/arm64/kernel/pi/map_kernel.c                                 |    6 
 arch/arm64/kernel/probes/kprobes.c                                |   12 
 arch/arm64/kernel/setup.c                                         |    4 
 arch/arm64/kvm/hyp/nvhe/mem_protect.c                             |    9 
 arch/arm64/kvm/mmu.c                                              |    9 
 arch/arm64/mm/init.c                                              |    2 
 arch/arm64/mm/mmu.c                                               |   14 
 arch/loongarch/Makefile                                           |    4 
 arch/loongarch/kernel/setup.c                                     |    1 
 arch/parisc/include/uapi/asm/ioctls.h                             |    8 
 arch/parisc/lib/memcpy.c                                          |    1 
 arch/powerpc/platforms/powernv/pci-ioda.c                         |    2 
 arch/powerpc/platforms/pseries/msi.c                              |    2 
 arch/s390/Makefile                                                |    1 
 arch/s390/include/asm/pgtable.h                                   |   22 
 arch/s390/kernel/vmlinux.lds.S                                    |   54 -
 arch/s390/mm/gmap_helpers.c                                       |   12 
 arch/s390/mm/pgtable.c                                            |   23 
 arch/sparc/kernel/of_device_32.c                                  |    1 
 arch/sparc/kernel/of_device_64.c                                  |    1 
 arch/sparc/mm/hugetlbpage.c                                       |   20 
 arch/x86/entry/entry_64_fred.S                                    |    2 
 arch/x86/include/asm/kvm_host.h                                   |    1 
 arch/x86/include/asm/msr-index.h                                  |    1 
 arch/x86/kernel/kvm.c                                             |   21 
 arch/x86/kernel/umip.c                                            |   15 
 arch/x86/kvm/pmu.c                                                |    5 
 arch/x86/kvm/svm/pmu.c                                            |    1 
 arch/x86/kvm/svm/sev.c                                            |   10 
 arch/x86/kvm/svm/svm.c                                            |   25 
 arch/x86/kvm/svm/svm.h                                            |    2 
 arch/x86/kvm/vmx/tdx.c                                            |   10 
 arch/x86/kvm/x86.c                                                |    8 
 arch/xtensa/platforms/iss/simdisk.c                               |    6 
 block/blk-crypto-fallback.c                                       |    3 
 crypto/essiv.c                                                    |   14 
 crypto/skcipher.c                                                 |    2 
 drivers/acpi/acpi_dbg.c                                           |   26 
 drivers/acpi/acpi_tad.c                                           |    3 
 drivers/acpi/acpica/acdebug.h                                     |    2 
 drivers/acpi/acpica/evglock.c                                     |    4 
 drivers/acpi/battery.c                                            |   43 
 drivers/acpi/property.c                                           |  137 +-
 drivers/base/base.h                                               |    9 
 drivers/base/core.c                                               |    2 
 drivers/base/power/main.c                                         |   24 
 drivers/base/power/runtime.c                                      |    3 
 drivers/block/loop.c                                              |    8 
 drivers/bus/mhi/ep/main.c                                         |   37 
 drivers/bus/mhi/host/init.c                                       |    5 
 drivers/cdx/cdx_msi.c                                             |    1 
 drivers/char/ipmi/ipmi_kcs_sm.c                                   |   16 
 drivers/char/ipmi/ipmi_msghandler.c                               |  484 ++++------
 drivers/char/tpm/tpm_tis_core.c                                   |    4 
 drivers/clk/Kconfig                                               |    1 
 drivers/clk/at91/clk-peripheral.c                                 |    7 
 drivers/clk/mediatek/clk-mt8195-infra_ao.c                        |    2 
 drivers/clk/mediatek/clk-mux.c                                    |    4 
 drivers/clk/nxp/clk-lpc18xx-cgu.c                                 |   20 
 drivers/clk/qcom/Kconfig                                          |    2 
 drivers/clk/qcom/common.c                                         |    4 
 drivers/clk/qcom/tcsrcc-x1e80100.c                                |    4 
 drivers/clk/renesas/r9a08g045-cpg.c                               |    3 
 drivers/clk/renesas/renesas-cpg-mssr.c                            |    7 
 drivers/clk/samsung/clk-exynos990.c                               |   52 -
 drivers/clk/tegra/clk-bpmp.c                                      |    2 
 drivers/clk/thead/clk-th1520-ap.c                                 |  394 ++++----
 drivers/clocksource/clps711x-timer.c                              |   23 
 drivers/cpufreq/cppc_cpufreq.c                                    |   14 
 drivers/cpufreq/cpufreq-dt.c                                      |    2 
 drivers/cpufreq/imx6q-cpufreq.c                                   |    2 
 drivers/cpufreq/intel_pstate.c                                    |    8 
 drivers/cpufreq/mediatek-cpufreq-hw.c                             |    2 
 drivers/cpufreq/rcpufreq_dt.rs                                    |    2 
 drivers/cpufreq/scmi-cpufreq.c                                    |    2 
 drivers/cpufreq/scpi-cpufreq.c                                    |    2 
 drivers/cpufreq/spear-cpufreq.c                                   |    2 
 drivers/cpufreq/tegra186-cpufreq.c                                |    8 
 drivers/crypto/aspeed/aspeed-hace-crypto.c                        |    2 
 drivers/crypto/atmel-tdes.c                                       |    2 
 drivers/crypto/rockchip/rk3288_crypto_ahash.c                     |    2 
 drivers/firmware/arm_scmi/quirks.c                                |   15 
 drivers/firmware/meson/meson_sm.c                                 |    7 
 drivers/firmware/samsung/exynos-acpm-pmic.c                       |   25 
 drivers/gpio/gpio-mpfs.c                                          |    2 
 drivers/gpio/gpio-wcd934x.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                  |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |    4 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c                |   21 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h                |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c              |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c              |    6 
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c            |    4 
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c    |    4 
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c    |   16 
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c  |   17 
 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c    |   16 
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c                      |   10 
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h              |    7 
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h        |    2 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c                        |   36 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                             |   28 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h                             |    6 
 drivers/gpu/drm/nouveau/nouveau_bo.c                              |    2 
 drivers/gpu/drm/panthor/panthor_drv.c                             |   11 
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c                   |    5 
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h              |    8 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                           |   17 
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c                        |    6 
 drivers/gpu/drm/xe/xe_hw_engine_group.c                           |    6 
 drivers/gpu/drm/xe/xe_pm.c                                        |    2 
 drivers/gpu/drm/xe/xe_query.c                                     |   15 
 drivers/hv/mshv_common.c                                          |    2 
 drivers/hv/mshv_root_main.c                                       |    3 
 drivers/i3c/master.c                                              |    2 
 drivers/iio/adc/pac1934.c                                         |   20 
 drivers/iio/adc/xilinx-ams.c                                      |   47 
 drivers/iio/dac/ad5360.c                                          |    2 
 drivers/iio/dac/ad5421.c                                          |    2 
 drivers/iio/frequency/adf4350.c                                   |   20 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c                  |   39 
 drivers/iommu/intel/iommu.c                                       |    2 
 drivers/irqchip/irq-sifive-plic.c                                 |    6 
 drivers/mailbox/mtk-cmdq-mailbox.c                                |   12 
 drivers/mailbox/zynqmp-ipi-mailbox.c                              |   24 
 drivers/md/md-linear.c                                            |    1 
 drivers/md/raid0.c                                                |    4 
 drivers/md/raid1.c                                                |    4 
 drivers/md/raid10.c                                               |    8 
 drivers/md/raid5.c                                                |    2 
 drivers/media/cec/usb/extron-da-hd-4k-plus/Makefile               |    6 
 drivers/media/i2c/mt9p031.c                                       |    4 
 drivers/media/i2c/mt9v111.c                                       |    2 
 drivers/media/mc/mc-devnode.c                                     |    6 
 drivers/media/mc/mc-entity.c                                      |    2 
 drivers/media/pci/cx18/cx18-queue.c                               |   13 
 drivers/media/pci/ivtv/ivtv-irq.c                                 |    2 
 drivers/media/pci/ivtv/ivtv-yuv.c                                 |    8 
 drivers/media/pci/mgb4/mgb4_trigger.c                             |    2 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c              |    3 
 drivers/media/platform/qcom/iris/iris_buffer.c                    |   31 
 drivers/media/platform/qcom/iris/iris_buffer.h                    |    1 
 drivers/media/platform/qcom/iris/iris_core.c                      |   10 
 drivers/media/platform/qcom/iris/iris_firmware.c                  |   15 
 drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c          |   45 
 drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c         |    4 
 drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c         |    5 
 drivers/media/platform/qcom/iris/iris_state.c                     |    5 
 drivers/media/platform/qcom/iris/iris_state.h                     |    1 
 drivers/media/platform/qcom/iris/iris_vb2.c                       |    8 
 drivers/media/platform/qcom/iris/iris_vdec.c                      |    2 
 drivers/media/platform/qcom/iris/iris_vidc.c                      |    1 
 drivers/media/platform/qcom/iris/iris_vpu3x.c                     |   32 
 drivers/media/platform/qcom/iris/iris_vpu_common.c                |    2 
 drivers/media/platform/qcom/venus/firmware.c                      |    8 
 drivers/media/platform/qcom/venus/pm_helpers.c                    |    9 
 drivers/media/platform/renesas/vsp1/vsp1_vspx.c                   |    1 
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c           |   35 
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c             |    9 
 drivers/media/rc/lirc_dev.c                                       |    9 
 drivers/media/test-drivers/vivid/vivid-cec.c                      |   12 
 drivers/media/usb/uvc/uvc_ctrl.c                                  |    3 
 drivers/memory/samsung/exynos-srom.c                              |   10 
 drivers/memory/stm32_omm.c                                        |    2 
 drivers/mmc/core/sdio.c                                           |    6 
 drivers/mmc/host/mmc_spi.c                                        |    2 
 drivers/mtd/nand/raw/fsmc_nand.c                                  |    6 
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                        |   14 
 drivers/net/ethernet/airoha/airoha_eth.c                          |    4 
 drivers/net/ethernet/airoha/airoha_regs.h                         |    3 
 drivers/net/ethernet/freescale/fsl_pq_mdio.c                      |    2 
 drivers/net/ethernet/intel/ice/ice_adapter.c                      |   10 
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c          |   38 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c       |   32 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                 |    5 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c        |   18 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c               |    5 
 drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c          |   12 
 drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c               |   10 
 drivers/net/ethernet/mscc/ocelot_stats.c                          |    2 
 drivers/net/mdio/mdio-i2c.c                                       |   39 
 drivers/net/pse-pd/tps23881.c                                     |    2 
 drivers/net/usb/lan78xx.c                                         |   11 
 drivers/net/wireless/ath/ath11k/core.c                            |    6 
 drivers/net/wireless/ath/ath11k/hal.c                             |   16 
 drivers/net/wireless/ath/ath11k/hal.h                             |    1 
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c                  |    6 
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c                   |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c                   |    3 
 drivers/net/wireless/realtek/rtw89/core.c                         |   39 
 drivers/net/wireless/realtek/rtw89/core.h                         |    3 
 drivers/net/wireless/realtek/rtw89/pci.c                          |    2 
 drivers/nvme/host/pci.c                                           |    2 
 drivers/of/unittest.c                                             |    1 
 drivers/pci/bus.c                                                 |   14 
 drivers/pci/controller/cadence/pci-j721e.c                        |   26 
 drivers/pci/controller/dwc/pci-keystone.c                         |    4 
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                       |    2 
 drivers/pci/controller/dwc/pcie-tegra194.c                        |   32 
 drivers/pci/controller/pci-tegra.c                                |   27 
 drivers/pci/controller/pcie-rcar-host.c                           |   40 
 drivers/pci/controller/pcie-xilinx-nwl.c                          |    7 
 drivers/pci/iov.c                                                 |    5 
 drivers/pci/pci-driver.c                                          |    1 
 drivers/pci/pci-sysfs.c                                           |   20 
 drivers/pci/pcie/aer.c                                            |   12 
 drivers/pci/pcie/err.c                                            |    8 
 drivers/pci/probe.c                                               |   19 
 drivers/pci/remove.c                                              |    2 
 drivers/pci/setup-bus.c                                           |   37 
 drivers/perf/arm-cmn.c                                            |    9 
 drivers/pinctrl/samsung/pinctrl-samsung.h                         |    4 
 drivers/power/supply/max77976_charger.c                           |   12 
 drivers/pwm/core.c                                                |    2 
 drivers/pwm/pwm-berlin.c                                          |    4 
 drivers/rtc/interface.c                                           |   27 
 drivers/rtc/rtc-isl12022.c                                        |    1 
 drivers/rtc/rtc-optee.c                                           |    1 
 drivers/rtc/rtc-x1205.c                                           |    2 
 drivers/s390/block/dasd.c                                         |   17 
 drivers/s390/cio/device.c                                         |   37 
 drivers/s390/cio/ioasm.c                                          |    7 
 drivers/scsi/hpsa.c                                               |   21 
 drivers/scsi/mvsas/mv_init.c                                      |    2 
 drivers/scsi/sd.c                                                 |   50 -
 drivers/spi/spi-cadence-quadspi.c                                 |   18 
 drivers/staging/media/ipu7/ipu7-isys-video.c                      |    1 
 drivers/ufs/core/ufs-sysfs.c                                      |    2 
 drivers/ufs/core/ufs-sysfs.h                                      |    1 
 drivers/ufs/core/ufshcd.c                                         |    2 
 drivers/video/fbdev/core/fb_cmdline.c                             |    2 
 drivers/xen/events/events_base.c                                  |   37 
 drivers/xen/manage.c                                              |   14 
 fs/attr.c                                                         |   44 
 fs/btrfs/export.c                                                 |    8 
 fs/btrfs/extent_io.c                                              |   14 
 fs/cramfs/inode.c                                                 |   11 
 fs/eventpoll.c                                                    |  139 --
 fs/ext4/ext4.h                                                    |    2 
 fs/ext4/fsmap.c                                                   |   14 
 fs/ext4/indirect.c                                                |    2 
 fs/ext4/inode.c                                                   |   45 
 fs/ext4/move_extent.c                                             |    2 
 fs/ext4/orphan.c                                                  |   17 
 fs/ext4/super.c                                                   |   26 
 fs/ext4/xattr.c                                                   |   19 
 fs/file.c                                                         |    5 
 fs/fs-writeback.c                                                 |   32 
 fs/fsopen.c                                                       |   70 -
 fs/fuse/dev.c                                                     |    2 
 fs/fuse/file.c                                                    |    8 
 fs/iomap/buffered-io.c                                            |   15 
 fs/iomap/direct-io.c                                              |    3 
 fs/minix/inode.c                                                  |    8 
 fs/namei.c                                                        |    8 
 fs/namespace.c                                                    |  110 +-
 fs/nfsd/export.c                                                  |   82 +
 fs/nfsd/export.h                                                  |    3 
 fs/nfsd/lockd.c                                                   |   15 
 fs/nfsd/nfs4proc.c                                                |   33 
 fs/nfsd/nfs4state.c                                               |   44 
 fs/nfsd/nfs4xdr.c                                                 |    5 
 fs/nfsd/nfsfh.c                                                   |   24 
 fs/nfsd/state.h                                                   |    8 
 fs/nfsd/vfs.c                                                     |    2 
 fs/nsfs.c                                                         |    4 
 fs/ntfs3/bitmap.c                                                 |    1 
 fs/pidfs.c                                                        |    2 
 fs/quota/dquot.c                                                  |   10 
 fs/read_write.c                                                   |   14 
 fs/smb/client/dir.c                                               |    1 
 fs/smb/client/smb1ops.c                                           |   62 +
 fs/smb/client/smb2inode.c                                         |   22 
 fs/smb/client/smb2ops.c                                           |   10 
 fs/squashfs/inode.c                                               |   24 
 fs/xfs/scrub/reap.c                                               |    9 
 include/acpi/acpixf.h                                             |    6 
 include/asm-generic/io.h                                          |   98 +-
 include/asm-generic/vmlinux.lds.h                                 |    2 
 include/linux/cpufreq.h                                           |    3 
 include/linux/fs.h                                                |   15 
 include/linux/iio/frequency/adf4350.h                             |    2 
 include/linux/ksm.h                                               |    8 
 include/linux/memcontrol.h                                        |   26 
 include/linux/mm.h                                                |   22 
 include/linux/pm_runtime.h                                        |   56 -
 include/linux/rseq.h                                              |   11 
 include/linux/sunrpc/svc_xprt.h                                   |    3 
 include/media/v4l2-subdev.h                                       |   30 
 include/trace/events/dma.h                                        |    1 
 init/main.c                                                       |   12 
 io_uring/zcrx.c                                                   |    1 
 kernel/bpf/inode.c                                                |    4 
 kernel/fork.c                                                     |    2 
 kernel/kexec_handover.c                                           |    2 
 kernel/padata.c                                                   |    6 
 kernel/pid.c                                                      |    2 
 kernel/power/energy_model.c                                       |   11 
 kernel/power/hibernate.c                                          |    6 
 kernel/rseq.c                                                     |   10 
 kernel/sched/deadline.c                                           |   73 +
 kernel/sys.c                                                      |   22 
 lib/genalloc.c                                                    |    5 
 mm/damon/lru_sort.c                                               |    2 
 mm/damon/vaddr.c                                                  |    8 
 mm/huge_memory.c                                                  |   15 
 mm/hugetlb.c                                                      |    3 
 mm/memcontrol.c                                                   |    7 
 mm/migrate.c                                                      |   23 
 mm/page_alloc.c                                                   |    2 
 mm/slab.h                                                         |    8 
 mm/slub.c                                                         |    3 
 mm/util.c                                                         |    3 
 net/bridge/br_vlan.c                                              |    2 
 net/core/filter.c                                                 |    2 
 net/core/page_pool.c                                              |   76 +
 net/ipv4/tcp.c                                                    |    5 
 net/ipv4/tcp_input.c                                              |    1 
 net/mptcp/ctrl.c                                                  |    2 
 net/mptcp/pm.c                                                    |    7 
 net/mptcp/pm_kernel.c                                             |   50 +
 net/mptcp/protocol.h                                              |    8 
 net/netfilter/nft_objref.c                                        |   39 
 net/sctp/sm_make_chunk.c                                          |    3 
 net/sctp/sm_statefuns.c                                           |    6 
 net/sunrpc/svc_xprt.c                                             |   13 
 net/sunrpc/svcsock.c                                              |    2 
 net/xdp/xsk_queue.h                                               |   45 
 rust/kernel/cpufreq.rs                                            |    7 
 scripts/Makefile.vmlinux                                          |   51 -
 scripts/mksysmap                                                  |    3 
 security/keys/trusted-keys/trusted_tpm1.c                         |    7 
 sound/soc/sof/intel/hda-pcm.c                                     |   29 
 sound/soc/sof/intel/hda-stream.c                                  |   29 
 sound/soc/sof/ipc4-topology.c                                     |    9 
 sound/soc/sof/ipc4-topology.h                                     |    7 
 tools/build/feature/Makefile                                      |    4 
 tools/lib/perf/include/perf/event.h                               |    1 
 tools/perf/Makefile.perf                                          |    2 
 tools/perf/builtin-trace.c                                        |    4 
 tools/perf/perf.h                                                 |    2 
 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json   |   10 
 tools/perf/tests/perf-record.c                                    |    4 
 tools/perf/tests/shell/amd-ibs-swfilt.sh                          |   51 -
 tools/perf/tests/shell/record_lbr.sh                              |   26 
 tools/perf/tests/shell/stat+event_uniquifying.sh                  |  109 +-
 tools/perf/tests/shell/trace_btf_enum.sh                          |   11 
 tools/perf/util/arm-spe.c                                         |    6 
 tools/perf/util/bpf-filter.c                                      |    8 
 tools/perf/util/bpf_counter.c                                     |   26 
 tools/perf/util/bpf_counter_cgroup.c                              |    3 
 tools/perf/util/bpf_skel/kwork_top.bpf.c                          |    2 
 tools/perf/util/build-id.c                                        |    7 
 tools/perf/util/disasm.c                                          |    7 
 tools/perf/util/drm_pmu.c                                         |    4 
 tools/perf/util/evsel.c                                           |   42 
 tools/perf/util/lzma.c                                            |    2 
 tools/perf/util/parse-events.c                                    |  116 +-
 tools/perf/util/session.c                                         |    2 
 tools/perf/util/setup.py                                          |    5 
 tools/perf/util/zlib.c                                            |    2 
 tools/power/acpi/tools/acpidump/apfiles.c                         |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                   |   11 
 tools/testing/selftests/net/netfilter/nf_nat_edemux.sh            |   58 -
 tools/testing/selftests/net/netfilter/nft_fib.sh                  |   13 
 tools/testing/selftests/net/ovpn/ovpn-cli.c                       |    2 
 tools/testing/selftests/rseq/rseq.c                               |    8 
 384 files changed, 3685 insertions(+), 2233 deletions(-)

Aaron Kling (1):
      cpufreq: tegra186: Set target frequency for all cpus in policy

Abel Vesa (1):
      clk: qcom: tcsrcc-x1e80100: Set the bi_tcxo as parent to eDP refclk

Abinash Singh (1):
      scsi: sd: Fix build warning in sd_revalidate_disk()

Adam Xue (1):
      bus: mhi: host: Do not use uninitialized 'dev' pointer in mhi_init_irq_setup()

Ahmed Salem (2):
      ACPICA: acpidump: drop ACPI_NONSTRING attribute from file_name
      ACPICA: Debugger: drop ACPI_NONSTRING attribute from name_seg

Ahmet Eray Karadag (1):
      ext4: guard against EA inode refcount underflow in xattr update

Akhil P Oommen (1):
      drm/msm/a6xx: Fix PDC sleep sequence

Al Viro (1):
      mnt_ns_tree_remove(): DTRT if mnt_ns had never been added to mnt_ns_list

Aleksa Sarai (1):
      fscontext: do not consume log entries when returning -EMSGSIZE

Aleksandar Gerasimovski (1):
      iio/adc/pac1934: fix channel disable configuration

Aleksandrs Vinarskis (1):
      arm64: dts: qcom: x1e80100-pmics: Disable pm8010 by default

Alex Deucher (1):
      drm/amdgpu: Add additional DCE6 SCL registers

Alexander Lobakin (1):
      xsk: Harden userspace-supplied xdp_desc validation

Alexander Sverdlin (1):
      ARM: AM33xx: Implement TI advisory 1.0.36 (EMU0/EMU1 pins state on reset)

Alexandr Sapozhnikov (1):
      net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()

Alexey Gladkov (1):
      s390: vmlinux.lds.S: Reorder sections

Alok Tiwari (1):
      clk: nxp: Fix pll0 rate check condition in LPC18xx CGU driver

Amir Mohammad Jahangirzad (1):
      ACPI: debug: fix signedness issues in read/write helpers

Anderson Nascimento (1):
      btrfs: avoid potential out-of-bounds in btrfs_encode_fh()

AngeloGioacchino Del Regno (1):
      clk: mediatek: mt8195-infra_ao: Fix parent for infra_ao_hdmi_26m

Anthony Yznaga (1):
      sparc64: fix hugetlb for sun4u

Ard Biesheuvel (1):
      drm/amd/display: Fix unsafe uses of kernel mode FPU

Arnd Bergmann (2):
      clk: npcm: select CONFIG_AUXILIARY_BUS
      media: s5p-mfc: remove an unused/uninitialized variable

Askar Safin (1):
      openat2: don't trigger automounts with RESOLVE_NO_XDEV

Baokun Li (1):
      ext4: add ext4_sb_bread_nofail() helper function for ext4_free_branches()

Bartosz Golaszewski (1):
      gpio: wcd934x: mark the GPIO controller as sleeping

Ben Horgan (1):
      KVM: arm64: Fix debug checking for np-guests using huge mappings

Bhanu Seshu Kumar Valluri (1):
      net: usb: lan78xx: Fix lost EEPROM read timeout error(-ETIMEDOUT) in lan78xx_read_raw_eeprom

Bharath SM (1):
      smb client: fix bug with newly created file in cached dir

Bingbu Cao (1):
      media: staging/ipu7: fix isys device runtime PM usage in firmware closing

Brian Masney (2):
      clk: at91: peripheral: fix return value
      clk: nxp: lpc18xx-cgu: convert from round_rate() to determine_rate()

Brian Norris (2):
      PM: runtime: Update kerneldoc return codes
      PCI/sysfs: Ensure devices are powered for config reads

Carolina Jubran (2):
      net/mlx5: Prevent tunnel mode conflicts between FDB and NIC IPsec tables
      net/mlx5e: Prevent tunnel reformat when tunnel mode not allowed

Catalin Marinas (1):
      arm64: mte: Do not flag the zero page as PG_mte_tagged

Chen-Yu Tsai (1):
      clk: mediatek: clk-mux: Do not pass flags to clk_mux_determine_rate_flags()

Christian Brauner (5):
      statmount: don't call path_put() under namespace semaphore
      listmount: don't call path_put() under namespace semaphore
      nsfs: validate extensible ioctls
      pidfs: validate extensible ioctls
      mount: handle NULL values in mnt_ns_release()

Christian Loehle (1):
      PM: EM: Fix late boot with holes in CPU topology

Christophe Leroy (1):
      perf: Completely remove possibility to override MAX_NR_CPUS

Claudiu Beznea (1):
      clk: renesas: r9a08g045: Add MSTOP for GPIO

Clément Le Goffic (1):
      rtc: optee: fix memory leak on driver removal

Colin Ian King (1):
      pwm: Fix incorrect variable used in error message

Conor Dooley (1):
      gpio: mpfs: fix setting gpio direction to output

Corey Minyard (3):
      ipmi: Rework user message limit handling
      ipmi:msghandler:Change seq_lock to a mutex
      Revert "ipmi: fix msg stack when IPMI is disconnected"

Dan Carpenter (2):
      clk: qcom: common: Fix NULL vs IS_ERR() check in qcom_cc_icc_register()
      net/mlx4: prevent potential use after free in mlx4_en_do_uc_filter()

Daniel Borkmann (1):
      bpf: Fix metadata_dst leak __bpf_redirect_neigh_v{4,6}

Daniel Lee (1):
      scsi: ufs: sysfs: Make HID attributes visible

Daniel Machon (1):
      net: sparx5/lan969x: fix flooding configuration on bridge join/leave

Daniel Tang (1):
      ACPI: TAD: Add missing sysfs_remove_group() for ACPI_TAD_RT

Darrick J. Wong (3):
      fuse: fix livelock in synchronous file put from fuseblk workers
      xfs: use deferred intent items for reaping crosslinked blocks
      iomap: error out on file IO when there is no inline_data buffer

David Lechner (1):
      media: pci: mg4b: fix uninitialized iio scan data

Deepanshu Kartikey (1):
      ext4: validate ea_ino and size in check_xattrs

Denzeel Oliva (3):
      clk: samsung: exynos990: Use PLL_CON0 for PLL parent muxes
      clk: samsung: exynos990: Fix CMU_TOP mux/div bit widths
      clk: samsung: exynos990: Replace bogus divs with fixed-factor clocks

Desnes Nunes (1):
      media: uvcvideo: Avoid variable shadowing in uvc_ctrl_cleanup_fh

Dikshita Agarwal (11):
      media: iris: vpu3x: Add MNoC low power handshake during hardware power-off
      media: iris: Fix port streaming handling
      media: iris: Fix buffer count reporting in internal buffer check
      media: iris: Allow substate transition to load resources during output streaming
      media: iris: Always destroy internal buffers on firmware release response
      media: iris: Simplify session stop logic by relying on vb2 checks
      media: iris: Update vbuf flags before v4l2_m2m_buf_done
      media: iris: Send dummy buffer address for all codecs during drain
      media: iris: Fix missing LAST flag handling during drain
      media: iris: Fix format check for CAPTURE plane in try_fmt
      media: iris: Allow stop on firmware only if start was issued.

Donet Tom (1):
      mm/ksm: fix incorrect KSM counter handling in mm_struct during fork

Duoming Zhou (2):
      scsi: mvsas: Fix use-after-free bugs in mvs_work_queue
      net: mscc: ocelot: Fix use-after-free caused by cyclic delayed work

Dzmitry Sankouski (1):
      power: supply: max77976_charger: fix constant current reporting

Edward Adam Davis (1):
      media: mc: Clear minor number before put device

Eric Biggers (2):
      KEYS: trusted_tpm1: Compare HMAC values in constant time
      sctp: Fix MAC comparison to be constant-time

Eric Dumazet (1):
      tcp: take care of zero tp->window_clamp in tcp_set_rcvlowat()

Eric Woudstra (1):
      bridge: br_vlan_fill_forward_path_pvid: use br_vlan_group_rcu()

Erick Karanja (1):
      net: fsl_pq_mdio: Fix device node reference leak in fsl_pq_mdio_probe

Esben Haabendal (3):
      rtc: isl12022: Fix initial enable_irq/disable_irq balance
      rtc: interface: Ensure alarm irq is enabled when UIE is enabled
      rtc: interface: Fix long-standing race when setting alarm

Fangzhi Zuo (1):
      drm/amd/display: Enable Dynamic DTBCLK Switch

Fedor Pchelkin (2):
      clk: tegra: do not overallocate memory for bpmp clocks
      wifi: rtw89: avoid possible TX wait initialization race

Feng Yang (1):
      tracing: Fix the bug where bpf_get_stackid returns -EFAULT on the ARM64

Fernando Fernandez Mancera (1):
      netfilter: nft_objref: validate objref and objrefmap expressions

Finn Thain (1):
      fbdev: Fix logic error in "offb" name match

Florian Westphal (2):
      selftests: netfilter: nft_fib.sh: fix spurious test failures
      selftests: netfilter: query conntrack state to check for port clash resolution

Fuad Tabba (1):
      KVM: arm64: Fix page leak in user_mem_abort()

Fushuai Wang (2):
      perf trace: Fix IS_ERR() vs NULL check bug
      cifs: Fix copy_to_iter return value check

Gautam Gala (1):
      KVM: s390: Fix to clear PTE when discarding a swapped page

Georg Gottleuber (1):
      nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk

Greg Kroah-Hartman (1):
      Linux 6.17.4

Guenter Roeck (1):
      ipmi: Fix handling of messages with provided receive message pointer

Gunnar Kudrjavets (1):
      tpm_tis: Fix incorrect arguments in tpm_tis_probe_irq_single

GuoHan Zhao (1):
      perf drm_pmu: Fix fd_dir leaks in for_each_drm_fdinfo_in_dir()

Hans Verkuil (2):
      media: i2c: mt9p031: fix mbus code initialization
      media: vivid: fix disappearing <Vendor Command With ID> messages

Haotian Zhang (1):
      ice: ice_adapter: release xa entry on adapter allocation failure

Haoxiang Li (1):
      fs/ntfs3: Fix a resource leak bug in wnd_extend()

Harini T (4):
      mailbox: zynqmp-ipi: Remove redundant mbox_controller_unregister() call
      mailbox: zynqmp-ipi: Remove dev.parent check in zynqmp_ipi_free_mboxes
      mailbox: zynqmp-ipi: Fix out-of-bounds access in mailbox cleanup loop
      mailbox: zynqmp-ipi: Fix SGI cleanup on unbind

Harshit Agarwal (1):
      sched/deadline: Fix race in push_dl_task()

Heiko Carstens (2):
      s390/cio/ioasm: Fix __xsch() condition code handling
      s390: Add -Wno-pointer-sign to KBUILD_CFLAGS_DECOMPRESSOR

Herbert Xu (1):
      crypto: essiv - Check ssize for decryption and in-place encryption

Hou Wenlong (2):
      KVM: x86: Add helper to retrieve current value of user return MSR
      KVM: SVM: Re-load current, not host, TSC_AUX on #VMEXIT from SEV-ES guest

Huacai Chen (4):
      LoongArch: Fix build error for LTO with LLVM-18
      LoongArch: Init acpi_gbl_use_global_lock to false
      init: handle bootloader identifier in kernel parameters
      ACPICA: Allow to skip Global Lock initialization

Ian Forbes (2):
      drm/vmwgfx: Fix Use-after-free in validation
      drm/vmwgfx: Fix copy-paste typo in validation

Ian Rogers (14):
      perf disasm: Avoid undefined behavior in incrementing NULL
      perf test trace_btf_enum: Skip if permissions are insufficient
      perf evsel: Avoid container_of on a NULL leader
      libperf event: Ensure tracing data is multiple of 8 sized
      perf parse-events: Handle fake PMUs in CPU terms
      perf test: AMD IBS swfilt skip kernel tests if paranoia is >1
      perf test shell lbr: Avoid failures with perf event paranoia
      perf test: Don't leak workload gopipe in PERF_RECORD_*
      perf evsel: Fix uniquification when PMU given without suffix
      perf test: Avoid uncore_imc/clockticks in uniquification test
      perf evsel: Ensure the fallback message is always written to
      perf build-id: Ensure snprintf string is empty when size is 0
      perf bpf-filter: Fix opts declaration on older libbpfs
      perf bpf_counter: Fix handling of cpumap fixing hybrid

Icenowy Zheng (2):
      clk: thead: th1520-ap: describe gate clocks with clk_gate
      clk: thead: th1520-ap: fix parent of padctrl0 clock

Ilkka Koskinen (1):
      perf vendor events arm64 AmpereOneX: Fix typo - should be l1d_cache_access_prefetches

Ilpo Järvinen (2):
      PCI: Ensure relaxed tail alignment does not increase min_align
      PCI: Fix failure detection during resource resize

Jaehoon Kim (2):
      s390/dasd: enforce dma_alignment to ensure proper buffer validation
      s390/dasd: Return BLK_STS_INVAL for EINVAL from do_dasd_request

Jai Luthra (2):
      media: ti: j721e-csi2rx: Use devm_of_platform_populate
      media: ti: j721e-csi2rx: Fix source subdev link creation

Jan Kara (5):
      ext4: fail unaligned direct IO write with EINVAL
      ext4: verify orphan file size is not too big
      ext4: free orphan info with kvfree
      writeback: Avoid softlockup when switching many inodes
      writeback: Avoid excessively long inode switching times

Jani Nurminen (1):
      PCI: xilinx-nwl: Fix ECAM programming

Jann Horn (1):
      drm/panthor: Fix memory leak in panthor_ioctl_group_create()

Jarkko Nikula (1):
      i3c: Fix default I2C adapter timeout value

Jason Andryuk (3):
      xen/events: Cleanup find_virq() return codes
      xen/events: Return -EEXIST for bound VIRQs
      xen/events: Update virq_to_irq on migration

Jason-JH Lin (1):
      mailbox: mtk-cmdq: Remove pm_runtime APIs from cmdq_mbox_send_data()

Jeff Layton (7):
      nfsd: fix assignment of ia_ctime.tv_nsec on delegated mtime update
      nfsd: ignore ATTR_DELEG when checking ia_valid before notify_change()
      vfs: add ATTR_CTIME_SET flag
      nfsd: use ATTR_CTIME_SET for delegated ctime updates
      nfsd: track original timestamps in nfs4_delegation
      nfsd: fix SETATTR updates for delegated timestamps
      nfsd: fix timestamp updates in CB_GETATTR

Jesse Agate (1):
      drm/amd/display: Incorrect Mirror Cositing

Jisheng Zhang (1):
      pwm: berlin: Fix wrong register in suspend/resume

Johan Hovold (6):
      firmware: arm_scmi: quirk: Prevent writes to string constants
      firmware: meson_sm: fix device leak at probe
      lib/genalloc: fix device leak in of_gen_pool_get()
      PCI/pwrctrl: Fix device leak at registration
      PCI/pwrctrl: Fix device and OF node leak at bus scan
      PCI/pwrctrl: Fix device leak at device stop

John David Anglin (1):
      parisc: Remove spurious if statement from raw_copy_from_user()

Judith Mendez (1):
      arm64: dts: ti: k3-am62p: Fix supported hardware for 1GHz OPP

KaFai Wan (1):
      bpf: Avoid RCU context warning when unpinning htab with internal structs

Kaustabh Chakraborty (1):
      drm/exynos: exynos7_drm_decon: remove ctx->suspended

Krzysztof Kozlowski (2):
      pinctrl: samsung: Drop unused S3C24xx driver data
      media: iris: Call correct power off callback in cleanup path

Kuniyuki Iwashima (1):
      tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().

Lance Yang (2):
      mm/thp: fix MTE tag mismatch when replacing zero-filled subpages
      mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping zero-filled mTHP subpage to shared zeropage

Laurent Pinchart (2):
      media: mc: Fix MUST_CONNECT handling for pads with no links
      media: vsp1: Export missing vsp1_isp_free_buffer symbol

Leo Yan (5):
      perf arm_spe: Correct setting remote access
      perf arm_spe: Correct memory level for remote access
      perf session: Fix handling when buffer exceeds 2 GiB
      tools build: Align warning options with perf
      perf python: split Clang options when invoking Popen

Li Chen (1):
      loop: fix backing file reference leak on validation error

Li RongQing (1):
      mm/hugetlb: early exit from hugetlb_pages_alloc_boot() when max_huge_pages=0

Lichen Liu (1):
      fs: Add 'initramfs_options' to set initramfs mount options

Linus Walleij (1):
      mtd: rawnand: fsmc: Default to autodetect buswidth

Lorenzo Bianconi (1):
      net: airoha: Fix loopback mode configuration for GDM2 port

Lu Baolu (1):
      iommu/vt-d: PRS isn't usable if PDS isn't supported

Lucas Zampieri (1):
      irqchip/sifive-plic: Avoid interrupt ID 0 handling during suspend/resume

Lukas Bulwahn (1):
      clk: qcom: Select the intended config in QCS_DISPCC_615

Lukas Wunner (3):
      xen/manage: Fix suspend error path
      PCI/ERR: Fix uevent on failure to recover
      PCI/AER: Support errors introduced by PCIe r6.0

Ma Ke (3):
      media: lirc: Fix error handling in lirc_register()
      of: unittest: Fix device reference count leak in of_unittest_pci_node_verify
      sparc: fix error handling in scan_one_device()

Maarten Zanders (1):
      mtd: nand: raw: gpmi: fix clocks when CONFIG_PM=N

Marek Marczykowski-Górecki (1):
      xen: take system_transition_mutex on suspend

Marek Vasut (5):
      drm/rcar-du: dsi: Fix 1/2/3 lane support
      PCI: tegra: Convert struct tegra_msi mask_lock into raw spinlock
      PCI: rcar-gen4: Fix PHY initialization
      PCI: rcar-host: Drop PMSR spinlock
      PCI: rcar-host: Convert struct rcar_msi mask_lock into raw spinlock

Mario Limonciello (AMD) (1):
      PM: hibernate: Fix hybrid-sleep

Masahiro Yamada (2):
      kbuild: always create intermediate vmlinux.unstripped
      kbuild: keep .modinfo section in vmlinux.unstripped

Matthew Auld (1):
      drm/xe/uapi: loosen used tracking restriction

Matthieu Baerts (NGI0) (3):
      mptcp: pm: in-kernel: usable client side with C-flag
      mptcp: reset blackhole on success with non-loopback ifaces
      selftests: mptcp: join: validate C-flag + def limit

Maxime Chevallier (1):
      net: mdio: mdio-i2c: Hold the i2c bus lock during smbus transactions

Miaoqian Lin (4):
      ARM: OMAP2+: pm33xx-core: ix device node reference leaks in amx3_idle_init
      cdx: Fix device node reference leak in cdx_msi_domain_init
      xtensa: simdisk: add input size check in proc_write_simdisk
      wifi: iwlwifi: Fix dentry reference leak in iwl_mld_add_link_debugfs

Michael Hennerich (2):
      iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE
      iio: frequency: adf4350: Fix prescaler usage.

Michael Riesch (1):
      dt-bindings: phy: rockchip-inno-csi-dphy: make power-domains non-required

Michal Wilczynski (1):
      clk: thead: Correct parent for DPU pixel clocks

Miklos Szeredi (2):
      fuse: fix possibly missing fuse_copy_finish() call in fuse_notify()
      copy_file_range: limit size if in compat mode

Muhammad Usama Anjum (1):
      wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again

Nam Cao (3):
      eventpoll: Replace rwlock with spinlock
      powerpc/powernv/pci: Fix underflow and leak issue
      powerpc/pseries/msi: Fix potential underflow and leak issue

Nathan Chancellor (3):
      kbuild: Restore pattern to avoid stripping .rela.dyn from vmlinux
      kbuild: Add '.rel.*' strip pattern for vmlinux
      s390/vmlinux.lds.S: Move .vmlinux.info to end of allocatable sections

Neil Armstrong (1):
      media: iris: fix module removal if firmware download failed

Nick Morrow (2):
      wifi: mt76: mt7925u: Add VID/PID for Netgear A9000
      wifi: mt76: mt7921u: Add VID/PID for Netgear A7500

Niklas Cassel (2):
      PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()
      PCI: tegra194: Reset BARs when running in PCIe endpoint mode

Niklas Schnelle (2):
      PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV
      PCI/AER: Fix missing uevent on recovery when a reset is requested

Nícolas F. R. A. Prado (1):
      media: platform: mtk-mdp3: Add missing MT8188 compatible to comp_dt_ids

Ojaswin Mujoo (1):
      ext4: correctly handle queries for metadata mappings

Oleg Nesterov (1):
      kernel/sys.c: fix the racy usage of task_lock(tsk->group_leader) in sys_prlimit64() paths

Olga Kornievskaia (2):
      nfsd: unregister with rpcbind when deleting a transport
      nfsd: nfserr_jukebox in nlm_fopen should lead to a retry

Omar Sandoval (1):
      arm64: map [_text, _stext) virtual address range non-executable+read-only

Pali Rohár (1):
      cifs: Query EA $LXMOD in cifs_query_path_info() for WSL reparse points

Patrice Chotard (1):
      memory: stm32_omm: Fix req2ack update test

Paulo Alcantara (1):
      smb: client: fix missing timestamp updates after utime(2)

Pavel Begunkov (1):
      io_uring/zcrx: increment fallback loop src offset

Peter Ujfalusi (4):
      ASoC: SOF: ipc4-topology: Correct the minimum host DMA buffer size
      ASoC: SOF: ipc4-topology: Account for different ChainDMA host buffer size
      ASoC: SOF: Intel: hda-pcm: Place the constraint on period time instead of buffer time
      ASoC: SOF: Intel: Read the LLP via the associated Link DMA channel

Petr Tesarik (1):
      dma-mapping: fix direction in dma_alloc direction traces

Philip Yang (1):
      drm/amdkfd: Fix kfd process ref leaking when userptr unmapping

Phillip Lougher (2):
      Squashfs: add additional inode sanity checking
      Squashfs: reject negative file sizes in squashfs_read_inode()

Pin-yen Lin (1):
      PM: sleep: Do not wait on SYNC_STATE_ONLY device links

Pratyush Yadav (3):
      kho: only fill kimage if KHO is finalized
      spi: cadence-quadspi: Flush posted register writes before INDAC access
      spi: cadence-quadspi: Flush posted register writes before DAC access

Qianfeng Rong (3):
      media: i2c: mt9v111: fix incorrect type for ret
      iio: dac: ad5360: use int type to store negative error codes
      iio: dac: ad5421: use int type to store negative error codes

Qu Wenruo (1):
      btrfs: fix the incorrect max_bytes value for find_lock_delalloc_range()

Raag Jadav (1):
      drm/xe/i2c: Don't rely on d3cold.allowed flag in system PM path

Rafael J. Wysocki (11):
      cpufreq: Make drivers using CPUFREQ_ETERNAL specify transition latency
      PM: core: Annotate loops walking device links as _srcu
      PM: core: Add two macros for walking device links
      ACPI: property: Fix buffer properties extraction for subnodes
      ACPI: battery: Add synchronization between interface updates
      cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition delay
      cpufreq: intel_pstate: Fix object lifecycle issue in update_qos_request()
      PM: hibernate: Restrict GFP mask in power_down()
      ACPI: property: Disregard references in data-only subnode lists
      ACPI: property: Add code comments explaining what is going on
      ACPI: property: Do not pass NULL handles to acpi_attach_data()

Randy Dunlap (1):
      media: cec: extron-da-hd-4k-plus: drop external-module make commands

Renjiang Han (1):
      media: venus: pm_helpers: add fallback for the opp-table

Rex Chen (2):
      mmc: core: SPI mode remove cmd7
      mmc: mmc_spi: multiple block read remove read crc ack

Rob Herring (Arm) (1):
      rtc: x1205: Fix Xicor X1205 vendor prefix

Robin Murphy (1):
      perf/arm-cmn: Fix CMN S3 DTM offset

Ryan Roberts (1):
      fsnotify: pass correct offset to fsnotify_mmap_perm()

Sam James (1):
      parisc: don't reference obsolete termio struct for TC* constants

Santhosh Kumar K (1):
      spi: cadence-quadspi: Fix cqspi_setup_flash()

Scott Mayhew (1):
      nfsd: decouple the xprtsec policy check from check_nfsd_access()

Sean Anderson (2):
      iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK
      iio: xilinx-ams: Unmask interrupts after updating alarms

Sean Christopherson (6):
      KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2
      mshv: Handle NEED_RESCHED_LAZY before transferring to guest
      x86/kvm: Force legacy PCI hole to UC when overriding MTRRs for TDX/SNP
      rseq/selftests: Use weak symbol reference, not definition, to link with glibc
      x86/umip: Check that the instruction opcode is at least two bytes
      x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT aliases)

Sean Nyekjaer (3):
      iio: imu: inv_icm42600: Simplify pm_runtime setup
      iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in resume
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended

SeongJae Park (2):
      mm/damon/vaddr: do not repeat pte_offset_map_lock() until success
      mm/damon/lru_sort: use param_ctx for damon_attrs staging

Shakeel Butt (1):
      memcg: skip cgroup_file_notify if spinning is not allowed

Shashank A P (1):
      fs: quota: create dedicated workqueue for quota_release_work

Shuhao Fu (1):
      drm/nouveau: fix bad ret code in nouveau_bo_move_prep

Shuicheng Lin (1):
      drm/xe/hw_engine_group: Fix double write lock release in error path

Siddharth Vadapalli (3):
      PCI: j721e: Fix module autoloading
      PCI: j721e: Fix programming sequence of "strap" settings
      PCI: keystone: Use devm_request_irq() to free "ks-pcie-error-irq" on exit

Sidharth Seela (1):
      selftest: net: ovpn: Fix uninit return values

Simon Schuster (1):
      copy_sighand: Handle architectures where sizeof(unsigned long) < sizeof(u64)

Stephan Gerhold (5):
      arm64: dts: qcom: msm8916: Add missing MDSS reset
      arm64: dts: qcom: msm8939: Add missing MDSS reset
      arm64: dts: qcom: sdm845: Fix slimbam num-channels/ees
      media: venus: firmware: Use correct reset sequence for IRIS2
      media: iris: Fix firmware reference leak and unmap memory after load

Sumit Kumar (1):
      bus: mhi: ep: Fix chained transfer handling in read path

Suren Baghdasaryan (2):
      slab: prevent warnings when slab obj_exts vector allocation fails
      slab: mark slab->obj_exts allocation failures unconditionally

T Pratham (1):
      crypto: skcipher - Fix reqsize handling

Tetsuo Handa (2):
      minixfs: Verify inode mode when loading from disk
      cramfs: Verify inode mode when loading from disk

Thadeu Lima de Souza Cascardo (1):
      mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH allocations

Theodore Ts'o (1):
      ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()

Thomas Fourier (5):
      media: cx18: Add missing check after DMA map
      media: pci: ivtv: Add missing check after DMA map
      crypto: aspeed - Fix dma_unmap_sg() direction
      crypto: atmel - Fix dma_unmap_sg() direction
      crypto: rockchip - Fix dma_unmap_sg() nents value

Thomas Gleixner (1):
      rseq: Protect event mask against membarrier IPI

Thomas Weißschuh (1):
      fs: always return zero on success from replace_fd()

Thomas Wismer (1):
      net: pse-pd: tps23881: Fix current measurement scaling

Thorsten Blum (2):
      scsi: hpsa: Fix potential memory leak in hpsa_big_passthru_ioctl()
      NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()

Tiezhu Yang (1):
      LoongArch: Add cflag -fno-isolate-erroneous-paths-dereference

Timur Kristóf (4):
      drm/amd/display: Add missing DCE6 SCL_HORZ_FILTER_INIT* SRIs
      drm/amd/display: Properly clear SCL_*_FILTER_CONTROL on DCE6
      drm/amd/display: Properly disable scaling on DCE6
      drm/amd/display: Disable scaling on DCE6 for now

Toke Høiland-Jørgensen (1):
      page_pool: Fix PP_MAGIC_MASK to avoid crashing on some 32-bit arches

Tomi Valkeinen (1):
      media: v4l2-subdev: Fix alloc failure check in v4l2_subdev_call_state_try()

Tony Lindgren (1):
      KVM: TDX: Fix uninitialized error code for __tdx_bringup()

Tudor Ambarus (1):
      firmware: exynos-acpm: fix PMIC returned errno

Varad Gautam (1):
      asm-generic/io.h: Skip trace helpers if rwmmio events are disabled

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am62a-main: Fix main padcfg length

Vidya Sagar (1):
      PCI: tegra194: Handle errors in BPMP response

Viken Dadhaniya (1):
      arm64: dts: qcom: qcs615: add missing dt property in QUP SEs

Vincent Minet (1):
      perf tools: Fix arm64 libjvmti build by generating unistd_64.h

Vineeth Vijayan (1):
      s390/cio: Update purge function to unregister the unused subchannels

Xiao Liang (1):
      padata: Reset next CPU when reorder sequence wraps around

Xin Li (Intel) (1):
      x86/fred: Remove ENDBR64 from FRED entry points

Yang Shi (1):
      arm64: kprobes: call set_memory_rox() for kprobe page

Yongjian Sun (1):
      ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()

Yu Kuai (2):
      blk-crypto: fix missing blktrace bio split events
      md: fix mssing blktrace bio split events

Yuan CHen (1):
      clk: renesas: cpg-mssr: Fix memory leak in cpg_mssr_reserved_init()

Yunseong Kim (1):
      perf util: Fix compression checks returning -1 as bool

Zack Rusin (1):
      drm/vmwgfx: Fix a null-ptr access in the cursor snooper

Zhang Yi (1):
      ext4: fix an off-by-one issue during moving extents

Zhen Ni (2):
      clocksource/drivers/clps711x: Fix resource leaks in error paths
      memory: samsung: exynos-srom: Fix of_iomap leak in exynos_srom_probe

gaoxiang17 (1):
      pid: Add a judgment for ns null in pid_nr_ns


