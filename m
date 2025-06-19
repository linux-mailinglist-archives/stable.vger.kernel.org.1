Return-Path: <stable+bounces-154808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D2AE07CD
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 15:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7E73B0CEE
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45625CC5D;
	Thu, 19 Jun 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bas9zYXj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34A27F4D9;
	Thu, 19 Jun 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341047; cv=none; b=c4OMxsCL2Zoms+GYtd8SVBs+fcozJH8Ak9kmMyyfHEhYe6miO56W/KxZU9syotdwFdhH6x7bFL06A7/sbzmwp7KNyBITkCMbKOqWByJGQwOHxqV436wk3mAZaZ7l52ImUI5nsQRmvAykghYEAmG64XFr9A84PtnUgBzH+HH3nc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341047; c=relaxed/simple;
	bh=G9ivPRtLWCgInY1MZJy8TVGYkRb189PGsEsqHD5DDsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ncUZlenZraAj/H8bfZtwq1pF14ySKjZioPYMJQ3usjKsyz4fzEnlKETgwu86VhN5FVeMwzKBZMRZGS/RpQ9xk3QaXyZySt8gBhHWnECjAhuTaF8XOUgyQ59xFlANYIXRqCOe7obe2z4jIEHR4oOleDcvs+2L5cJFR9b0vOzifkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bas9zYXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1ECC4CEEA;
	Thu, 19 Jun 2025 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750341046;
	bh=G9ivPRtLWCgInY1MZJy8TVGYkRb189PGsEsqHD5DDsA=;
	h=From:To:Cc:Subject:Date:From;
	b=Bas9zYXjIF/lPVuavlweZ7VlIQHVdXCWtLvKp1P04X3q8rSuP66prtrwOh+DPT0TD
	 dglHzk1NMX+StmR/3vUtGSiCsxhn/xfLzcgUDpCHCDgUojgxuXpPrSTQehJGCMWH2G
	 Bw/VjkaymRvPpZU4nJLXK2mI0LWFfJYNq2gqjVes=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.34
Date: Thu, 19 Jun 2025 15:50:36 +0200
Message-ID: <2025061936-unaltered-document-bd7e@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.34 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml                  |   21 
 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml                |    8 
 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml                   |    8 
 Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml |   12 
 Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml                |    4 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                     |    2 
 Documentation/gpu/xe/index.rst                                             |    1 
 Documentation/gpu/xe/xe_gt_freq.rst                                        |   14 
 Makefile                                                                   |    2 
 arch/arm/boot/dts/microchip/at91sam9263ek.dts                              |    2 
 arch/arm/boot/dts/microchip/tny_a9263.dts                                  |    2 
 arch/arm/boot/dts/microchip/usb_a9263.dts                                  |    4 
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi                                   |   82 +-
 arch/arm/mach-aspeed/Kconfig                                               |    1 
 arch/arm64/Kconfig                                                         |    6 
 arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts                        |    1 
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi                       |    1 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts                        |    1 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi                       |    1 
 arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi                       |    1 
 arch/arm64/boot/dts/mediatek/mt6357.dtsi                                   |   10 
 arch/arm64/boot/dts/mediatek/mt6359.dtsi                                   |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                             |   10 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                                   |    4 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                                   |   50 -
 arch/arm64/boot/dts/nvidia/tegra186.dtsi                                   |   12 
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                                   |   12 
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi                             |    1 
 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi                           |   11 
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                                      |   16 
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts                 |    3 
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts                        |    2 
 arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts                        |    3 
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts                    |   16 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                       |    2 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                       |    6 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                       |   71 +-
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi                   |    2 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                                     |  299 +++++-----
 arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-ard-audio-da7212.dtso      |    2 
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts                        |    8 
 arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts                            |    1 
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi                        |    5 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                              |   15 
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts                      |    1 
 arch/arm64/configs/defconfig                                               |    3 
 arch/arm64/include/asm/esr.h                                               |   14 
 arch/arm64/include/asm/fpsimd.h                                            |    3 
 arch/arm64/kernel/entry-common.c                                           |   46 +
 arch/arm64/kernel/fpsimd.c                                                 |   36 -
 arch/arm64/xen/hypercall.S                                                 |   21 
 arch/m68k/mac/config.c                                                     |    2 
 arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts                     |    1 
 arch/powerpc/kernel/Makefile                                               |    2 
 arch/powerpc/kexec/crash.c                                                 |    5 
 arch/powerpc/platforms/book3s/vas-api.c                                    |    9 
 arch/powerpc/platforms/powernv/memtrace.c                                  |    8 
 arch/powerpc/platforms/pseries/iommu.c                                     |    2 
 arch/riscv/kernel/traps_misaligned.c                                       |    4 
 arch/riscv/kvm/vcpu_sbi.c                                                  |    4 
 arch/s390/net/bpf_jit_comp.c                                               |   12 
 arch/x86/events/amd/uncore.c                                               |   36 +
 arch/x86/include/asm/mwait.h                                               |    9 
 arch/x86/include/asm/sighandling.h                                         |   22 
 arch/x86/kernel/cpu/common.c                                               |   17 
 arch/x86/kernel/cpu/microcode/core.c                                       |    2 
 arch/x86/kernel/cpu/mtrr/generic.c                                         |    2 
 arch/x86/kernel/ioport.c                                                   |   13 
 arch/x86/kernel/irq.c                                                      |    2 
 arch/x86/kernel/process.c                                                  |   15 
 arch/x86/kernel/signal_32.c                                                |    4 
 arch/x86/kernel/signal_64.c                                                |    4 
 arch/x86/lib/x86-opcode-map.txt                                            |   50 -
 block/blk-zoned.c                                                          |    7 
 block/elevator.c                                                           |    3 
 crypto/api.c                                                               |   13 
 crypto/lrw.c                                                               |    4 
 crypto/xts.c                                                               |    4 
 drivers/acpi/acpica/exserial.c                                             |    6 
 drivers/acpi/apei/Kconfig                                                  |    1 
 drivers/acpi/apei/ghes.c                                                   |    2 
 drivers/acpi/cppc_acpi.c                                                   |    2 
 drivers/acpi/osi.c                                                         |    1 
 drivers/acpi/resource.c                                                    |    2 
 drivers/base/power/main.c                                                  |    3 
 drivers/block/brd.c                                                        |   11 
 drivers/block/loop.c                                                       |    8 
 drivers/bluetooth/btintel.c                                                |   10 
 drivers/bluetooth/btintel_pcie.c                                           |   31 -
 drivers/bluetooth/btintel_pcie.h                                           |   10 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                            |    6 
 drivers/clk/bcm/clk-raspberrypi.c                                          |    2 
 drivers/clk/qcom/camcc-sm6350.c                                            |   18 
 drivers/clk/qcom/dispcc-sm6350.c                                           |    3 
 drivers/clk/qcom/gcc-msm8939.c                                             |    4 
 drivers/clk/qcom/gcc-sm6350.c                                              |    6 
 drivers/clk/qcom/gpucc-sm6350.c                                            |    6 
 drivers/counter/interrupt-cnt.c                                            |    9 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c                        |    7 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c                          |   17 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c                          |   34 -
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h                               |    2 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c                        |    2 
 drivers/crypto/marvell/cesa/cipher.c                                       |    3 
 drivers/crypto/marvell/cesa/hash.c                                         |    2 
 drivers/dma/ti/k3-udma.c                                                   |    3 
 drivers/edac/i10nm_base.c                                                  |   35 -
 drivers/edac/skx_common.c                                                  |    1 
 drivers/edac/skx_common.h                                                  |   11 
 drivers/firmware/Kconfig                                                   |    1 
 drivers/firmware/arm_sdei.c                                                |   11 
 drivers/firmware/efi/libstub/efi-stub-helper.c                             |    1 
 drivers/firmware/psci/psci.c                                               |    4 
 drivers/fpga/tests/fpga-mgr-test.c                                         |    1 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                        |    8 
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c                                 |    6 
 drivers/gpu/drm/i915/display/intel_psr_regs.h                              |    4 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c                          |   19 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                     |   31 -
 drivers/gpu/drm/meson/meson_drv.c                                          |    2 
 drivers/gpu/drm/meson/meson_drv.h                                          |    2 
 drivers/gpu/drm/meson/meson_encoder_hdmi.c                                 |   29 
 drivers/gpu/drm/meson/meson_vclk.c                                         |  226 ++++---
 drivers/gpu/drm/meson/meson_vclk.h                                         |   13 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                      |    1 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h                     |   16 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h                    |   16 
 drivers/gpu/drm/panel/panel-samsung-sofef00.c                              |   34 -
 drivers/gpu/drm/panel/panel-simple.c                                       |    5 
 drivers/gpu/drm/panthor/panthor_mmu.c                                      |    1 
 drivers/gpu/drm/panthor/panthor_regs.h                                     |    4 
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c                              |   10 
 drivers/gpu/drm/tegra/rgb.c                                                |   14 
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c                                |   36 -
 drivers/gpu/drm/vkms/vkms_crtc.c                                           |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                                         |   10 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                                         |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                                    |   26 
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c                                   |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                                    |   34 -
 drivers/gpu/drm/xe/xe_gt_freq.c                                            |    2 
 drivers/gpu/drm/xe/xe_pci.c                                                |    1 
 drivers/hid/hid-hyperv.c                                                   |    4 
 drivers/hid/usbhid/hid-core.c                                              |   25 
 drivers/hwmon/asus-ec-sensors.c                                            |    4 
 drivers/hwtracing/coresight/coresight-catu.c                               |   27 
 drivers/hwtracing/coresight/coresight-catu.h                               |    1 
 drivers/hwtracing/coresight/coresight-config.h                             |    2 
 drivers/hwtracing/coresight/coresight-core.c                               |    6 
 drivers/hwtracing/coresight/coresight-cpu-debug.c                          |    3 
 drivers/hwtracing/coresight/coresight-funnel.c                             |    3 
 drivers/hwtracing/coresight/coresight-replicator.c                         |    3 
 drivers/hwtracing/coresight/coresight-stm.c                                |    2 
 drivers/hwtracing/coresight/coresight-syscfg.c                             |   49 +
 drivers/hwtracing/coresight/coresight-tmc-core.c                           |    2 
 drivers/hwtracing/coresight/coresight-tpiu.c                               |    2 
 drivers/iio/adc/ad7124.c                                                   |    4 
 drivers/iio/adc/mcp3911.c                                                  |   39 +
 drivers/iio/adc/pac1934.c                                                  |    2 
 drivers/iio/filter/admv8818.c                                              |  224 +++++--
 drivers/infiniband/core/cm.c                                               |   16 
 drivers/infiniband/core/cma.c                                              |    3 
 drivers/infiniband/hw/hns/hns_roce_ah.c                                    |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                 |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h                                 |    1 
 drivers/infiniband/hw/hns/hns_roce_main.c                                  |    1 
 drivers/infiniband/hw/hns/hns_roce_restrack.c                              |    1 
 drivers/infiniband/hw/mlx5/qpc.c                                           |   30 -
 drivers/input/rmi4/rmi_f34.c                                               |  135 ++--
 drivers/iommu/Kconfig                                                      |    1 
 drivers/iommu/iommu.c                                                      |    4 
 drivers/mailbox/imx-mailbox.c                                              |   21 
 drivers/mailbox/mtk-cmdq-mailbox.c                                         |   51 -
 drivers/md/dm-core.h                                                       |    1 
 drivers/md/dm-flakey.c                                                     |   70 +-
 drivers/md/dm-zone.c                                                       |   25 
 drivers/md/dm.c                                                            |   30 -
 drivers/media/platform/verisilicon/hantro_postproc.c                       |    4 
 drivers/mfd/exynos-lpass.c                                                 |    6 
 drivers/mfd/stmpe-spi.c                                                    |    2 
 drivers/misc/mei/vsc-tp.c                                                  |    4 
 drivers/misc/vmw_vmci/vmci_host.c                                          |   11 
 drivers/mmc/host/sdhci-of-dwcmshc.c                                        |   40 +
 drivers/mtd/nand/ecc-mxic.c                                                |    2 
 drivers/net/bonding/bond_main.c                                            |   25 
 drivers/net/dsa/b53/b53_common.c                                           |   37 -
 drivers/net/ethernet/google/gve/gve_main.c                                 |    2 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                               |    3 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                         |   11 
 drivers/net/ethernet/intel/ice/ice_main.c                                  |   47 +
 drivers/net/ethernet/intel/ice/ice_sched.c                                 |  181 ++++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c                                 |   18 
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c                        |    9 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                |   45 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                                |    8 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                            |    2 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h                            |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                           |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c                        |   22 
 drivers/net/ethernet/mediatek/mtk_star_emac.c                              |    4 
 drivers/net/ethernet/mellanox/mlx4/en_clock.c                              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                           |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c                   |   18 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h                   |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                            |   12 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                          |   21 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                          |    5 
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c     |    3 
 drivers/net/ethernet/microchip/lan743x_main.c                              |   15 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                      |    7 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h                      |    6 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c                       |   49 +
 drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c                 |    1 
 drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c                      |   21 
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c                           |    5 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                          |    5 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c                      |   11 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                           |    2 
 drivers/net/ethernet/ti/icssg/icssg_stats.c                                |    8 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                          |    6 
 drivers/net/macsec.c                                                       |   40 +
 drivers/net/netdevsim/netdev.c                                             |    3 
 drivers/net/phy/mdio_bus.c                                                 |   12 
 drivers/net/phy/mscc/mscc_ptp.c                                            |   20 
 drivers/net/phy/phy_device.c                                               |    4 
 drivers/net/usb/aqc111.c                                                   |   10 
 drivers/net/vmxnet3/vmxnet3_drv.c                                          |   26 
 drivers/net/wireguard/device.c                                             |    1 
 drivers/net/wireless/ath/ath10k/snoc.c                                     |    4 
 drivers/net/wireless/ath/ath11k/core.c                                     |   37 -
 drivers/net/wireless/ath/ath11k/core.h                                     |    4 
 drivers/net/wireless/ath/ath11k/debugfs.c                                  |  148 ----
 drivers/net/wireless/ath/ath11k/debugfs.h                                  |   10 
 drivers/net/wireless/ath/ath11k/mac.c                                      |   92 ++-
 drivers/net/wireless/ath/ath11k/mac.h                                      |    4 
 drivers/net/wireless/ath/ath11k/wmi.c                                      |   47 +
 drivers/net/wireless/ath/ath12k/core.c                                     |    8 
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c                        |    3 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                    |   54 -
 drivers/net/wireless/ath/ath12k/dp_tx.c                                    |    1 
 drivers/net/wireless/ath/ath12k/hal.c                                      |  103 +--
 drivers/net/wireless/ath/ath12k/hal.h                                      |   64 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h                                 |    3 
 drivers/net/wireless/ath/ath12k/hw.c                                       |   35 +
 drivers/net/wireless/ath/ath12k/hw.h                                       |   12 
 drivers/net/wireless/ath/ath12k/pci.c                                      |   12 
 drivers/net/wireless/ath/ath12k/pci.h                                      |    4 
 drivers/net/wireless/ath/ath12k/wmi.c                                      |    3 
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c                            |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                                |    2 
 drivers/net/wireless/marvell/mwifiex/11n.c                                 |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                           |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                            |   21 
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c                            |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                           |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                           |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                         |    3 
 drivers/net/wireless/realtek/rtw88/coex.c                                  |    2 
 drivers/net/wireless/realtek/rtw88/rtw8822c.c                              |    3 
 drivers/net/wireless/realtek/rtw88/sdio.c                                  |   10 
 drivers/net/wireless/realtek/rtw89/fw.c                                    |    2 
 drivers/net/wireless/realtek/rtw89/pci.c                                   |    2 
 drivers/net/wwan/mhi_wwan_mbim.c                                           |    9 
 drivers/net/wwan/t7xx/t7xx_netdev.c                                        |   11 
 drivers/nvme/host/constants.c                                              |    2 
 drivers/nvme/host/core.c                                                   |    1 
 drivers/nvme/host/pr.c                                                     |    2 
 drivers/nvme/target/core.c                                                 |    9 
 drivers/nvme/target/fcloop.c                                               |   31 -
 drivers/nvme/target/io-cmd-bdev.c                                          |    9 
 drivers/nvmem/zynqmp_nvmem.c                                               |    1 
 drivers/of/unittest.c                                                      |   10 
 drivers/pci/controller/cadence/pcie-cadence-host.c                         |   11 
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                                |    1 
 drivers/pci/controller/pcie-apple.c                                        |    4 
 drivers/pci/endpoint/pci-epf-core.c                                        |   22 
 drivers/pci/pci-acpi.c                                                     |   23 
 drivers/pci/pci.c                                                          |    2 
 drivers/pci/pcie/dpc.c                                                     |   68 +-
 drivers/perf/amlogic/meson_ddr_pmu_core.c                                  |    2 
 drivers/perf/arm-ni.c                                                      |   40 -
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                                    |    6 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                          |   13 
 drivers/pinctrl/pinctrl-at91.c                                             |    6 
 drivers/pinctrl/qcom/pinctrl-qcm2290.c                                     |    9 
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c                             |   52 -
 drivers/pinctrl/samsung/pinctrl-exynos.c                                   |  260 ++++----
 drivers/pinctrl/samsung/pinctrl-exynos.h                                   |    8 
 drivers/pinctrl/samsung/pinctrl-samsung.c                                  |   21 
 drivers/pinctrl/samsung/pinctrl-samsung.h                                  |    8 
 drivers/pmdomain/core.c                                                    |   35 +
 drivers/power/reset/at91-reset.c                                           |    5 
 drivers/ptp/ptp_private.h                                                  |   12 
 drivers/regulator/max20086-regulator.c                                     |    6 
 drivers/remoteproc/qcom_wcnss_iris.c                                       |    2 
 drivers/remoteproc/ti_k3_dsp_remoteproc.c                                  |    8 
 drivers/remoteproc/ti_k3_r5_remoteproc.c                                   |    8 
 drivers/rpmsg/qcom_smd.c                                                   |    2 
 drivers/rtc/rtc-loongson.c                                                 |    8 
 drivers/rtc/rtc-sh.c                                                       |   12 
 drivers/scsi/hisi_sas/hisi_sas_main.c                                      |   29 
 drivers/scsi/qedf/qedf_main.c                                              |    2 
 drivers/scsi/scsi_transport_iscsi.c                                        |   11 
 drivers/scsi/smartpqi/smartpqi_init.c                                      |    4 
 drivers/soc/aspeed/aspeed-lpc-snoop.c                                      |   17 
 drivers/soc/qcom/smp2p.c                                                   |    2 
 drivers/spi/spi-bcm63xx-hsspi.c                                            |    2 
 drivers/spi/spi-bcm63xx.c                                                  |    2 
 drivers/spi/spi-omap2-mcspi.c                                              |   30 -
 drivers/spi/spi-sh-msiof.c                                                 |   13 
 drivers/spi/spi-tegra210-quad.c                                            |   24 
 drivers/staging/media/rkvdec/rkvdec.c                                      |   10 
 drivers/thermal/mediatek/lvts_thermal.c                                    |   18 
 drivers/thunderbolt/usb4.c                                                 |    4 
 drivers/tty/serial/8250/8250_omap.c                                        |   25 
 drivers/tty/serial/milbeaut_usio.c                                         |    5 
 drivers/tty/serial/sh-sci.c                                                |   24 
 drivers/tty/vt/vt_ioctl.c                                                  |    2 
 drivers/ufs/core/ufs-mcq.c                                                 |    6 
 drivers/ufs/core/ufshcd.c                                                  |    7 
 drivers/ufs/host/ufs-qcom.c                                                |    5 
 drivers/usb/cdns3/cdnsp-gadget.c                                           |   21 
 drivers/usb/cdns3/cdnsp-gadget.h                                           |    4 
 drivers/usb/class/usbtmc.c                                                 |   17 
 drivers/usb/core/hub.c                                                     |   16 
 drivers/usb/core/usb-acpi.c                                                |    2 
 drivers/usb/gadget/function/f_hid.c                                        |   12 
 drivers/usb/gadget/udc/core.c                                              |    2 
 drivers/usb/misc/onboard_usb_dev.c                                         |  107 +++
 drivers/usb/renesas_usbhs/common.c                                         |   50 +
 drivers/usb/typec/bus.c                                                    |    2 
 drivers/usb/typec/tcpm/tcpci_maxim_core.c                                  |    3 
 drivers/usb/typec/tcpm/tcpm.c                                              |   91 ++-
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                             |   79 ++
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h                             |   14 
 drivers/vfio/vfio_iommu_type1.c                                            |    2 
 drivers/video/backlight/qcom-wled.c                                        |    6 
 drivers/video/fbdev/core/fbcvt.c                                           |    2 
 drivers/watchdog/exar_wdt.c                                                |    2 
 drivers/xen/balloon.c                                                      |   13 
 fs/9p/vfs_addr.c                                                           |    1 
 fs/btrfs/extent-io-tree.c                                                  |    6 
 fs/btrfs/inode.c                                                           |    7 
 fs/btrfs/scrub.c                                                           |   34 +
 fs/erofs/super.c                                                           |   49 +
 fs/f2fs/data.c                                                             |    4 
 fs/f2fs/f2fs.h                                                             |   10 
 fs/f2fs/gc.c                                                               |    3 
 fs/f2fs/namei.c                                                            |   10 
 fs/f2fs/segment.h                                                          |   45 -
 fs/f2fs/super.c                                                            |    4 
 fs/filesystems.c                                                           |   14 
 fs/gfs2/glock.c                                                            |    3 
 fs/gfs2/glops.c                                                            |    4 
 fs/gfs2/incore.h                                                           |    9 
 fs/gfs2/inode.c                                                            |    3 
 fs/gfs2/meta_io.c                                                          |    2 
 fs/gfs2/meta_io.h                                                          |    4 
 fs/gfs2/ops_fstype.c                                                       |   35 -
 fs/gfs2/super.c                                                            |   16 
 fs/gfs2/sys.c                                                              |    1 
 fs/kernfs/dir.c                                                            |    5 
 fs/kernfs/file.c                                                           |    3 
 fs/namespace.c                                                             |   25 
 fs/nfs/super.c                                                             |   19 
 fs/nilfs2/btree.c                                                          |    4 
 fs/nilfs2/direct.c                                                         |    3 
 fs/ntfs3/index.c                                                           |    8 
 fs/ntfs3/inode.c                                                           |    5 
 fs/ocfs2/quota_local.c                                                     |    2 
 fs/smb/client/cifssmb.c                                                    |   20 
 fs/squashfs/super.c                                                        |    5 
 fs/xfs/xfs_discard.c                                                       |   17 
 include/linux/arm_sdei.h                                                   |    4 
 include/linux/bio.h                                                        |    2 
 include/linux/bvec.h                                                       |    7 
 include/linux/coresight.h                                                  |    2 
 include/linux/hid.h                                                        |    3 
 include/linux/ieee80211.h                                                  |   79 ++
 include/linux/mdio.h                                                       |    5 
 include/linux/mlx5/driver.h                                                |    1 
 include/linux/mm.h                                                         |   58 +
 include/linux/nvme.h                                                       |    2 
 include/linux/overflow.h                                                   |   27 
 include/linux/pci-epf.h                                                    |    3 
 include/linux/phy.h                                                        |    5 
 include/linux/pm_domain.h                                                  |    7 
 include/linux/poison.h                                                     |    4 
 include/linux/virtio_vsock.h                                               |    1 
 include/net/bluetooth/hci_core.h                                           |    2 
 include/net/netfilter/nft_fib.h                                            |    9 
 include/net/page_pool/types.h                                              |    6 
 include/net/sock.h                                                         |    7 
 include/sound/hdaudio.h                                                    |    4 
 io_uring/fdinfo.c                                                          |   12 
 io_uring/io_uring.c                                                        |    4 
 io_uring/register.c                                                        |    7 
 io_uring/sqpoll.c                                                          |   43 -
 io_uring/sqpoll.h                                                          |    8 
 kernel/bpf/core.c                                                          |   29 
 kernel/events/core.c                                                       |   50 +
 kernel/power/energy_model.c                                                |    4 
 kernel/power/hibernate.c                                                   |    5 
 kernel/power/main.c                                                        |    3 
 kernel/power/power.h                                                       |    4 
 kernel/power/wakelock.c                                                    |    3 
 kernel/rcu/tree.c                                                          |   10 
 kernel/rcu/tree.h                                                          |    2 
 kernel/rcu/tree_stall.h                                                    |    4 
 kernel/sched/core.c                                                        |   12 
 kernel/time/posix-cpu-timers.c                                             |    9 
 kernel/trace/bpf_trace.c                                                   |    7 
 kernel/trace/ring_buffer.c                                                 |   41 -
 kernel/trace/trace.h                                                       |    8 
 kernel/trace/trace_events_hist.c                                           |  122 +++-
 kernel/trace/trace_events_trigger.c                                        |   20 
 lib/iov_iter.c                                                             |    2 
 lib/kunit/static_stub.c                                                    |    2 
 lib/usercopy_kunit.c                                                       |    1 
 mm/page_alloc.c                                                            |    8 
 net/bluetooth/eir.c                                                        |   17 
 net/bluetooth/eir.h                                                        |    2 
 net/bluetooth/hci_conn.c                                                   |    2 
 net/bluetooth/hci_core.c                                                   |   29 
 net/bluetooth/hci_event.c                                                  |   16 
 net/bluetooth/hci_sync.c                                                   |   74 ++
 net/bluetooth/iso.c                                                        |    9 
 net/bluetooth/l2cap_core.c                                                 |    3 
 net/bluetooth/mgmt.c                                                       |  140 ++--
 net/bluetooth/mgmt_util.c                                                  |   49 -
 net/bluetooth/mgmt_util.h                                                  |    8 
 net/bridge/netfilter/nf_conntrack_bridge.c                                 |   12 
 net/core/netmem_priv.h                                                     |   33 +
 net/core/page_pool.c                                                       |  108 ++-
 net/core/skbuff.c                                                          |   16 
 net/core/skmsg.c                                                           |   53 +
 net/core/sock.c                                                            |    8 
 net/core/xdp.c                                                             |    4 
 net/dsa/tag_brcm.c                                                         |    2 
 net/ipv4/netfilter/nft_fib_ipv4.c                                          |   11 
 net/ipv4/udp_offload.c                                                     |    5 
 net/ipv6/netfilter.c                                                       |   12 
 net/ipv6/netfilter/nft_fib_ipv6.c                                          |   17 
 net/ipv6/seg6_local.c                                                      |    6 
 net/mac80211/mlme.c                                                        |    7 
 net/mac80211/scan.c                                                        |   11 
 net/ncsi/internal.h                                                        |   21 
 net/ncsi/ncsi-pkt.h                                                        |   23 
 net/ncsi/ncsi-rsp.c                                                        |   21 
 net/netfilter/nf_nat_core.c                                                |   12 
 net/netfilter/nft_quota.c                                                  |   20 
 net/netfilter/nft_set_pipapo.c                                             |   58 +
 net/netfilter/nft_set_pipapo_avx2.c                                        |   21 
 net/netfilter/nft_tunnel.c                                                 |    8 
 net/netfilter/xt_TCPOPTSTRIP.c                                             |    4 
 net/netfilter/xt_mark.c                                                    |    2 
 net/netlabel/netlabel_kapi.c                                               |    5 
 net/openvswitch/flow.c                                                     |    2 
 net/sched/sch_ets.c                                                        |    2 
 net/sched/sch_prio.c                                                       |    2 
 net/sched/sch_red.c                                                        |    2 
 net/sched/sch_sfq.c                                                        |    5 
 net/sched/sch_tbf.c                                                        |    2 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                   |   14 
 net/tipc/crypto.c                                                          |    6 
 net/tls/tls_sw.c                                                           |   15 
 net/vmw_vsock/virtio_transport_common.c                                    |   26 
 net/wireless/scan.c                                                        |   18 
 net/xfrm/xfrm_device.c                                                     |    2 
 net/xfrm/xfrm_state.c                                                      |    2 
 rust/kernel/alloc/kvec.rs                                                  |    3 
 scripts/gcc-plugins/gcc-common.h                                           |   32 +
 scripts/gcc-plugins/randomize_layout_plugin.c                              |   40 -
 sound/core/seq_device.c                                                    |    2 
 sound/hda/hda_bus_type.c                                                   |    6 
 sound/pci/hda/hda_bind.c                                                   |    4 
 sound/pci/hda/patch_realtek.c                                              |   68 ++
 sound/soc/apple/mca.c                                                      |   23 
 sound/soc/codecs/hda.c                                                     |    4 
 sound/soc/codecs/tas2764.c                                                 |    2 
 sound/soc/intel/avs/debugfs.c                                              |    6 
 sound/soc/intel/avs/ipc.c                                                  |    4 
 sound/soc/mediatek/mt8195/mt8195-mt6359.c                                  |    4 
 sound/soc/sof/amd/pci-acp70.c                                              |    1 
 sound/soc/sof/ipc4-pcm.c                                                   |    3 
 sound/soc/ti/omap-hdmi.c                                                   |    7 
 sound/usb/implicit.c                                                       |    1 
 tools/arch/x86/kcpuid/kcpuid.c                                             |   47 -
 tools/arch/x86/lib/x86-opcode-map.txt                                      |   50 -
 tools/bpf/bpftool/cgroup.c                                                 |    2 
 tools/bpf/resolve_btfids/Makefile                                          |    2 
 tools/lib/bpf/bpf_core_read.h                                              |    6 
 tools/lib/bpf/libbpf.c                                                     |   48 -
 tools/lib/bpf/linker.c                                                     |    4 
 tools/lib/bpf/nlattr.c                                                     |   15 
 tools/objtool/check.c                                                      |    3 
 tools/perf/Makefile.config                                                 |    2 
 tools/perf/Makefile.perf                                                   |    3 
 tools/perf/builtin-record.c                                                |    2 
 tools/perf/builtin-trace.c                                                 |    9 
 tools/perf/scripts/python/exported-sql-viewer.py                           |    5 
 tools/perf/tests/switch-tracking.c                                         |    2 
 tools/perf/ui/browsers/hists.c                                             |    2 
 tools/perf/util/intel-pt.c                                                 |  205 ++++++
 tools/perf/util/machine.c                                                  |    6 
 tools/perf/util/symbol-minimal.c                                           |  160 ++---
 tools/perf/util/thread.c                                                   |    8 
 tools/perf/util/thread.h                                                   |    2 
 tools/power/x86/turbostat/turbostat.c                                      |   41 +
 tools/testing/selftests/Makefile                                           |    2 
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c                            |    6 
 tools/testing/selftests/bpf/test_loader.c                                  |   14 
 tools/testing/selftests/cpufreq/cpufreq.sh                                 |    3 
 tools/testing/selftests/seccomp/seccomp_bpf.c                              |   13 
 515 files changed, 5502 insertions(+), 3052 deletions(-)

Aaron Kling (2):
      arm64: tegra: Drop remaining serial clock-names and reset-names
      arm64: tegra: Add uartd serial alias for Jetson TX1 module

Adam Ford (5):
      arm64: dts: imx8mm-beacon: Fix RTC capacitive load
      arm64: dts: imx8mn-beacon: Fix RTC capacitive load
      arm64: dts: imx8mp-beacon: Fix RTC capacitive load
      arm64: dts: imx8mm-beacon: Set SAI5 MCLK direction to output for HDMI audio
      arm64: dts: imx8mn-beacon: Set SAI5 MCLK direction to output for HDMI audio

Adrian Hunter (2):
      perf intel-pt: Fix PEBS-via-PT data_src
      perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3

Ahmed S. Darwish (2):
      tools/x86/kcpuid: Fix error handling
      x86/cpu: Sanitize CPUID(0x80000000) output

Al Viro (3):
      path_overmount(): avoid false negatives
      fix propagation graph breakage by MOVE_MOUNT_SET_GROUP move_mount(2)
      do_change_type(): refuse to operate on unmounted/not ours mounts

Alexander Shiyan (1):
      power: reset: at91-reset: Optimize at91_reset()

Alexander Sverdlin (1):
      counter: interrupt-cnt: Protect enable/disable OPs with mutex

Alexei Safin (1):
      hwmon: (asus-ec-sensors) check sensor index in read_string()

Alexey Gladkov (1):
      mfd: stmpe-spi: Correct the name used in MODULE_DEVICE_TABLE

Alexey Kodanev (1):
      wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds

Alexey Minnekhanov (3):
      arm64: dts: qcom: sdm660-xiaomi-lavender: Add missing SD card detect GPIO
      arm64: dts: qcom: sdm660-lavender: Add missing USB phy supply
      arm64: dts: qcom: sda660-ifc6560: Fix dt-validate warning

Alexis Lothoré (2):
      net: stmmac: make sure that ptp_rate is not 0 before configuring timestamping
      net: stmmac: make sure that ptp_rate is not 0 before configuring EST

Alok Tiwari (3):
      gve: Fix RX_BUFFERS_POSTED stat to report per-queue fill_cnt
      gve: add missing NULL check for gve_alloc_pending_packet() in TX DQO
      scsi: iscsi: Fix incorrect error path labels for flashnode operations

Amir Tzin (1):
      net/mlx5: Fix ECVF vports unload on shutdown flow

Amit Sunil Dhamne (1):
      usb: typec: tcpm/tcpci_maxim: Fix bounds check in process_rx()

Anand Moon (1):
      perf/amlogic: Replace smp_processor_id() with raw_smp_processor_id() in meson_ddr_pmu_create()

Andre Przywara (1):
      dt-bindings: vendor-prefixes: Add Liontron name

Andreas Gruenbacher (2):
      gfs2: replace sd_aspace with sd_inode
      gfs2: gfs2_create_inode error handling fix

Andrew Cooper (1):
      x86/idle: Remove MFENCEs for X86_BUG_CLFLUSH_MONITOR in mwait_idle_with_hints() and prefer_mwait_c1_over_halt()

Andrew Price (1):
      gfs2: Don't clear sb->s_fs_info in gfs2_sys_fs_add

Andrey Vatoropin (1):
      fs/ntfs3: handle hdr_first_de() return value

Andy Shevchenko (1):
      pinctrl: at91: Fix possible out-of-boundary access

AngeloGioacchino Del Regno (5):
      thermal/drivers/mediatek/lvts: Fix debugfs unregister on failure
      drm/mediatek: mtk_drm_drv: Fix kobject put for mtk_mutex device ptr
      drm/mediatek: Fix kobject put for component sub-drivers
      drm/mediatek: mtk_drm_drv: Unbind secondary mmsys components on err
      arm64: dts: mediatek: mt8195: Reparent vdec1/2 and venc1 power domains

Annie Li (1):
      x86/microcode/AMD: Do not return error when microcode update is not necessary

Anton Protopopov (3):
      libbpf: Use proper errno value in linker
      bpf: Fix uninitialized values in BPF_{CORE,PROBE}_READ
      libbpf: Use proper errno value in nlattr

Anubhav Shelat (2):
      perf trace: Always print return value for syscalls returning a pid
      perf trace: Set errpid to false for rseq and set_robust_list

Armin Wolf (1):
      ACPI: OSI: Stop advertising support for "3.0 _SCP Extensions"

Arnaldo Carvalho de Melo (2):
      perf build: Warn when libdebuginfod devel files are not available
      perf ui browser hists: Set actions->thread before calling do_zoom_thread()

Arnd Bergmann (2):
      usb: misc: onboard_usb_dev: fix build warning for CONFIG_USB_ONBOARD_DEV_USB5744=n
      thermal/drivers/mediatek/lvts: Remove unused lvts_debugfs_exit

Badal Nilawar (1):
      drm/xe/d3cold: Set power state to D3Cold during s2idle/s3

Baochen Qiang (5):
      wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
      wifi: ath11k: don't use static variables in ath11k_debugfs_fw_stats_process()
      wifi: ath11k: don't wait when there is no vdev started
      wifi: ath11k: move some firmware stats related functions outside of debugfs
      wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition for WCN7850

Barnabás Czémán (1):
      soc: qcom: smp2p: Fix fallback to qcom,ipc parse

Benjamin Marzinski (5):
      dm: don't change md if dm_table_set_restrictions() fails
      dm: free table mempools if not used in __bind
      dm: fix dm_blk_report_zones
      dm-flakey: error all IOs when num_features is absent
      dm-flakey: make corrupting read bios work

Biju Das (2):
      drm: rcar-du: Fix memory leak in rcar_du_vsps_init()
      drm/tegra: rgb: Fix the unbound reference count

Bjorn Helgaas (2):
      PCI/DPC: Initialize aer_err_info before using it
      PCI/DPC: Log Error Source ID only when valid

Boris Brezillon (2):
      drm/panthor: Fix GPU_COHERENCY_ACE[_LITE] definitions
      drm/panthor: Update panthor_mmu::irq::mask when needed

Brian Pellegrino (1):
      iio: filter: admv8818: Support frequencies >= 2^32

Brian Vazquez (1):
      idpf: fix a race in txq wakeup

Bui Quang Minh (1):
      selftests: net: build net/lib dependency in all target

Caleb Connolly (1):
      ath10k: snoc: fix unbalanced IRQ enable in crash recovery

Carlos Fernandez (1):
      macsec: MACsec SCI assignment for ES = 0

Casey Connolly (1):
      drm/panel: samsung-sofef00: Drop s6e3fc2x01 support

Cezary Rojewski (3):
      ASoC: codecs: hda: Fix RPM usage count underflow
      ASoC: Intel: avs: Fix deadlock when the failing IPC is SET_D0IX
      ASoC: Intel: avs: Verify content returned by parse_int_array()

Chandrashekar Devegowda (2):
      Bluetooth: btintel_pcie: Increase the tx and rx descriptor count
      Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition

Chao Yu (4):
      f2fs: zone: fix to avoid inconsistence in between SIT and SSA
      f2fs: fix to do sanity check on sbi->total_valid_block_count
      f2fs: clean up w/ fscrypt_is_bounce_page()
      f2fs: fix to detect gcing page in f2fs_is_cp_guaranteed()

Charalampos Mitrodimas (1):
      net: tipc: fix refcount warning in tipc_aead_encrypt

Charles Han (1):
      drm/amd/pp: Fix potential NULL pointer dereference in atomctrl_initialize_mc_reg_table

Chenyuan Yang (2):
      phy: qcom-qmp-usb: Fix an NULL vs IS_ERR() bug
      usb: acpi: Prevent null pointer dereference in usb_acpi_add_usb4_devlink()

Chin-Yen Lee (1):
      wifi: rtw89: fix firmware scan delay unit for WiFi 6 chips

Chris Chiu (3):
      ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3315
      ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3247
      ALSA: hda/realtek - Add new HP ZBook laptop with micmute led fixup

Christian Brauner (1):
      gfs2: pass through holder from the VFS for freeze/thaw

Christoph Hellwig (1):
      block: don't use submit_bio_noacct_nocheck in blk_zone_wplug_bio_work

Christophe JAILLET (3):
      drm/bridge: lt9611uxc: Fix an error handling path in lt9611uxc_probe()
      mfd: exynos-lpass: Fix an error handling path in exynos_lpass_probe()
      mfd: exynos-lpass: Avoid calling exynos_lpass_disable() twice in exynos_lpass_remove()

Chuck Lever (1):
      svcrdma: Reduce the number of rdma_rw contexts per-QP

Chukun Pan (1):
      arm64: dts: rockchip: Move SHMEM memory to reserved memory on rk3588

Claudiu Beznea (1):
      serial: sh-sci: Move runtime PM enable to sci_probe_single()

Corentin Labbe (1):
      crypto: sun8i-ss - do not use sg_dma_len before calling DMA functions

Cosmin Ratiu (2):
      net/mlx5: Avoid using xso.real_dev unnecessarily
      xfrm: Use xdo.dev instead of xdo.real_dev

Cristian Ciocaltea (2):
      phy: rockchip: samsung-hdptx: Fix clock ratio setup
      phy: rockchip: samsung-hdptx: Do no set rk_hdptx_phy->rate in case of errors

Dan Carpenter (6):
      wifi: ath12k: Fix buffer overflow in debugfs
      of: unittest: Unlock on error in unittest_data_add()
      remoteproc: qcom_wcnss_iris: Add missing put_device() on error in probe
      rpmsg: qcom_smd: Fix uninitialized return variable in __qcom_smd_send()
      net/mlx4_en: Prevent potential integer overflow calculating Hz
      regulator: max20086: Fix refcount leak in max20086_parse_regulators_dt()

Daniel Wagner (1):
      nvmet-fcloop: access fcpreq only when holding reqlock

Daniele Palmas (1):
      net: wwan: mhi_wwan_mbim: use correct mux_id for multiplexing

Daniil Tatianin (1):
      ACPICA: exserial: don't forget to handle FFixedHW opregions for reading

Danilo Krummrich (1):
      rust: alloc: add missing invariant in Vec::set_len()

Dapeng Mi (1):
      perf record: Fix incorrect --user-regs comments

Dave Chinner (1):
      xfs: don't assume perags are initialised when trimming AGs

Dave Penkler (1):
      usb: usbtmc: Fix read_stb function and get_stb ioctl

David Heimann (1):
      ALSA: usb-audio: Add implicit feedback quirk for RODE AI-1

David Lechner (1):
      dt-bindings: pwm: adi,axi-pwmgen: Fix clocks

Detlev Casanova (1):
      media: verisilicon: Free post processor buffers on error

Di Shen (1):
      bpf: Revert "bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe attach logic"

Dmitry Antipov (3):
      wifi: rtw88: do not ignore hardware read error during DPK
      Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()
      ring-buffer: Fix buffer locking in ring_buffer_subbuf_order_set()

Dmitry Baryshkov (6):
      drm/msm/dpu: enable SmartDMA on SM8150
      drm/msm/dpu: enable SmartDMA on SC8180X
      ARM: dts: qcom: apq8064: add missing clocks to the timer node
      ARM: dts: qcom: apq8064 merge hw splinlock into corresponding syscon device
      ARM: dts: qcom: apq8064: move replicator out of soc node
      arm64: dts: qcom: qcm2290: fix (some) of QUP interconnects

Dmitry Torokhov (1):
      Input: synaptics-rmi - fix crash with unsupported versions of F34

Dong Chenchen (1):
      page_pool: Fix use-after-free in page_pool_recycle_in_ring

Dr. David Alan Gilbert (1):
      Bluetooth: MGMT: Remove unused mgmt_pending_find_data

Dzmitry Sankouski (4):
      arm64: dts: qcom: sdm845-starqltechn: remove wifi
      arm64: dts: qcom: sdm845-starqltechn: fix usb regulator mistake
      arm64: dts: qcom: sdm845-starqltechn: refactor node order
      arm64: dts: qcom: sdm845-starqltechn: remove excess reserved gpios

Easwar Hariharan (1):
      wifi: ath11k: convert timeouts to secs_to_jiffies()

Eddie James (1):
      powerpc/crash: Fix non-smp kexec preparation

Emil Tantilov (1):
      idpf: avoid mailbox timeout delays during reset

Eric Dumazet (6):
      net_sched: sch_sfq: fix a potential crash on gso_skb handling
      net_sched: prio: fix a race in prio_tune()
      net_sched: red: fix a race in __red_change()
      net_sched: tbf: fix a race in tbf_change()
      net_sched: ets: fix a race in ets_qdisc_change()
      calipso: unlock rcu before returning -EAFNOSUPPORT

Faicker Mo (1):
      net: openvswitch: Fix the dead loop of MPLS parse

Feng Yang (1):
      libbpf: Fix event name too long error

Fernando Fernandez Mancera (1):
      netfilter: nft_tunnel: fix geneve_opt dump

Filipe Manana (3):
      btrfs: fix invalid data space release when truncating block in NOCOW mode
      btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
      btrfs: exit after state split error at set_extent_bit()

Finn Thain (1):
      m68k: mac: Fix macintosh_config for Mac II

Florian Westphal (5):
      netfilter: xtables: support arpt_mark and ipv6 optstrip for iptables-nft only builds
      netfilter: nf_tables: nft_fib_ipv6: fix VRF ipv4/ipv6 result discrepancy
      netfilter: nf_tables: nft_fib: consistent l3mdev handling
      netfilter: nf_set_pipapo_avx2: fix initial map fill
      netfilter: nf_nat: also check reverse tuple to obtain clashing entry

Francesco Dolcini (1):
      Revert "wifi: mwifiex: Fix HT40 bandwidth issue."

Félix Piédallu (2):
      spi: omap2-mcspi: Disable multi mode when CS should be kept asserted after message
      spi: omap2-mcspi: Disable multi-mode when the previous message kept CS asserted

Gaurav Batra (1):
      powerpc/pseries/iommu: Fix kmemleak in TCE table userspace view

Gautham R. Shenoy (1):
      tools/power turbostat: Fix AMD package-energy reporting

Geert Uytterhoeven (1):
      spi: sh-msiof: Fix maximum DMA transfer size

Greg Kroah-Hartman (5):
      ALSA: core: fix up bus match const issues.
      net: phy: fix up const issues in to_mdio_device() and to_phy_device()
      USB: gadget: udc: fix const issue in gadget_match_driver()
      USB: typec: fix const issue in typec_match()
      Linux 6.12.34

Gustavo A. R. Silva (1):
      overflow: Fix direct struct member initialization in _DEFINE_FLEX()

Hangbin Liu (1):
      bonding: assign random address if device address is same as bond

Hans Zhang (2):
      efi/libstub: Describe missing 'out' parameter in efi_load_initrd
      PCI: cadence: Fix runtime atomic count underflow

Hans de Goede (1):
      mei: vsc: Cast tx_buf to (__be32 *) when passed to cpu_to_be32_array()

Haren Myneni (1):
      powerpc/vas: Return -EINVAL if the offset is non-zero in mmap()

Hari Kalavakunta (1):
      net: ncsi: Fix GCPS 64-bit member variables

Hariprasad Kelam (2):
      octeontx2-pf: QOS: Perform cache sync on send queue teardown
      octeontx2-pf: QOS: Refactor TC_HTB_LEAF_DEL_LAST callback

Hector Martin (2):
      ASoC: tas2764: Enable main IRQs
      PCI: apple: Use gpiod_set_value_cansleep in probe flow

Henry Martin (7):
      clk: bcm: rpi: Add NULL check in raspberrypi_clk_register()
      wifi: mt76: mt7996: Fix null-ptr-deref in mt7996_mmio_wed_init()
      wifi: mt76: mt7915: Fix null-ptr-deref in mt7915_mmio_wed_init()
      soc: aspeed: Add NULL check in aspeed_lpc_enable_snoop()
      backlight: pm8941: Add NULL check in wled_configure()
      dmaengine: ti: Add NULL check in udma_probe()
      serial: Fix potential null-ptr-deref in mlb_usio_probe()

Herbert Xu (5):
      crypto: marvell/cesa - Handle zero-length skcipher requests
      crypto: marvell/cesa - Avoid empty transfer descriptor
      crypto: lrw - Only add ecb if it is not already there
      crypto: xts - Only add ecb if it is not already there
      crypto: api - Redo lookup on EEXIST

Hongbo Li (1):
      erofs: fix file handle encoding for 64-bit NIDs

Hongbo Yao (2):
      perf: arm-ni: Unregister PMUs on probe failure
      perf: arm-ni: Fix missing platform_set_drvdata()

Horatiu Vultur (4):
      net: lan966x: Fix 1-step timestamping over ipv4 or ipv6
      net: phy: mscc: Fix memory leak when using one step timestamping
      net: phy: mscc: Stop clearing the the UDPv4 checksum for L2 frames
      net: lan966x: Make sure to insert the vlan tags also in host mode

Huajian Yang (1):
      netfilter: bridge: Move specific fragmented packet to slow_path instead of dropping it

Huang Yiwei (1):
      firmware: SDEI: Allow sdei initialization without ACPI_APEI_GHES

I Hsin Cheng (1):
      drm/meson: Use 1000ULL when operating with mode->clock

Ian Forbes (2):
      drm/vmwgfx: Add seqno waiter for sync_files
      drm/vmwgfx: Fix dumb buffer leak

Ian Rogers (3):
      perf symbol-minimal: Fix double free in filename__read_build_id
      perf symbol: Fix use-after-free in filename__read_build_id
      perf callchain: Always populate the addr_location map when adding IP

Ido Schimmel (1):
      seg6: Fix validation of nexthop addresses

Ilan Peer (1):
      wifi: iwlfiwi: mvm: Fix the rate reporting

Ilya Leoshkevich (1):
      s390/bpf: Store backchain even for leaf progs

Ioana Ciornei (1):
      bus: fsl-mc: fix double-free on mc_dev

Jack Morgenstein (1):
      RDMA/cma: Fix hang when cma_netevent_callback fails to queue_work

Jacob Moroni (1):
      IB/cm: use rwlock for MAD agent lock

Jaegeuk Kim (1):
      f2fs: clean up unnecessary indentation

Jakub Kicinski (1):
      net: drv: netdevsim: don't napi_complete() from netpoll

Jakub Raczynski (2):
      net/mdiobus: Fix potential out-of-bounds read/write access
      net/mdiobus: Fix potential out-of-bounds clause 45 read/write access

Jason Gunthorpe (1):
      iommu: Protect against overflow in iommu_pgsize()

Jason-JH Lin (1):
      mailbox: mtk-cmdq: Refine GCE_GCTL_VALUE setting

Jeongjun Park (1):
      ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()

Jerome Brunet (2):
      PCI: rcar-gen4: set ep BAR4 fixed size
      PCI: endpoint: Retain fixed-size BAR size as well as aligned size

Jesus Narvaez (2):
      drm/i915/guc: Check if expecting reply before decrementing outstanding_submission_g2h
      drm/i915/guc: Handle race condition where wakeref count drops below 0

Jianbo Liu (1):
      net/mlx5e: Fix leak of Geneve TLV option object

Jiaqing Zhao (1):
      x86/mtrr: Check if fixed-range MTRRs exist in mtrr_save_fixed_ranges()

Jiayuan Chen (5):
      bpf: fix ktls panic with sockmap
      bpf, sockmap: fix duplicated data transmission
      bpf, sockmap: Fix panic when calling skb_linearize
      ktls, sockmap: Fix missing uncharge operation
      bpf, sockmap: Avoid using sk_socket after free when sending

Jinjian Song (1):
      net: wwan: t7xx: Fix napi rx poll issue

Jiri Slaby (SUSE) (2):
      powerpc: do not build ppc_save_regs.o always
      tty: serial: 8250_omap: fix TX with DMA for am33xx

Joel Stanley (1):
      ARM: aspeed: Don't select SRAM

John Stultz (1):
      sched/core: Tweak wait_task_inactive() to force dequeue sched_delayed tasks

Jonas Gorski (4):
      net: dsa: b53: do not enable RGMII delay on bcm63xx
      net: dsa: b53: allow RGMII for bcm63xx RGMII ports
      net: dsa: b53: do not touch DLL_IQQD on bcm53115
      net: dsa: b53: fix untagged traffic sent via cpu tagged with VID 0

Jonas Karlman (1):
      media: rkvdec: Fix frame size enumeration

Jonathan Stroud (1):
      usb: misc: onboard_usb_dev: Fix usb5744 initialization sequence

Jonathan Wiepert (1):
      Use thread-safe function pointer in libbpf_print

Jouni Högander (1):
      drm/i915/psr: Fix using wrong mask in REG_FIELD_PREP

Julien Massot (3):
      ASoC: mediatek: mt8195: Set ETDM1/2 IN/OUT to COMP_DUMMY()
      arm64: dts: mt6359: Add missing 'compatible' property to regulators node
      arm64: dts: mt6359: Rename RTC node to match binding expectations

Junhao He (1):
      coresight: Fixes device's owner field for registered using coresight_init_driver()

Junxian Huang (1):
      RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h

KaFai Wan (1):
      bpf: Avoid __bpf_prog_ret0_warn when jit fails

Kailang Yang (1):
      ALSA: hda/realtek - Support mute led function for HP platform

Kees Cook (8):
      ASoC: SOF: ipc4-pcm: Adjust pipeline_list->pipelines allocation type
      watchdog: exar: Shorten identity name to fit correctly
      drm/vkms: Adjust vkms_state->active_planes allocation type
      scsi: qedf: Use designated initializer for struct qed_fcoe_cb_ops
      Bluetooth: btintel: Check dsbr size from EFI variable
      randstruct: gcc-plugin: Remove bogus void member
      randstruct: gcc-plugin: Fix attribute addition
      overflow: Introduce __DEFINE_FLEX for having no initializer

Keisuke Nishimura (1):
      drm/vmwgfx: Add error path for xa_store in vmw_bo_add_detached_resource

Keith Busch (2):
      nvme: fix command limits status code
      io_uring: consistently use rcu semantics with sqpoll thread

Kiran K (1):
      Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers

Konrad Dybcio (2):
      drm/msm/a6xx: Disable rgb565_predicator on Adreno 7c3
      arm64: dts: qcom: x1e80100-romulus: Keep L12B and L15B always on

Kornel Dulęba (1):
      arm64: Support ARM64_VA_BITS=52 when setting ARCH_MMAP_RND_BITS_MAX

Krzysztof Kozlowski (1):
      dt-bindings: pwm: Correct indentation and style in DTS example

Kuniyuki Iwashima (1):
      calipso: Don't call calipso functions for AF_INET sk.

Lachlan Hodges (1):
      wifi: cfg80211/mac80211: correctly parse S1G beacon optional elements

Lad Prabhakar (1):
      usb: renesas_usbhs: Reorder clock handling and power management in probe

Leo Yan (1):
      perf tests switch-tracking: Fix timestamp comparison

Li Lingfeng (2):
      nfs: clear SB_RDONLY before getting superblock
      nfs: ignore SB_RDONLY when remounting nfs

Li RongQing (1):
      vfio/type1: Fix error unwind in migration dirty bitmap allocation

Liu Dalin (1):
      rtc: loongson: Add missing alarm notifications for ACPI RTC events

Lizhi Xu (1):
      fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr

Longfang Liu (3):
      hisi_acc_vfio_pci: fix XQE dma address error
      hisi_acc_vfio_pci: add eq and aeq interruption restore
      hisi_acc_vfio_pci: bugfix live migration function without VF device driver

Lorenzo Bianconi (1):
      bpf: Allow XDP dev-bound programs to perform XDP_REDIRECT into maps

Luca Weiss (5):
      clk: qcom: camcc-sm6350: Add *_wait_val values for GDSCs
      clk: qcom: dispcc-sm6350: Add *_wait_val values for GDSCs
      clk: qcom: gcc-sm6350: Add *_wait_val values for GDSCs
      clk: qcom: gpucc-sm6350: Add *_wait_val values for GDSCs
      arm64: dts: qcom: sm8350: Reenable crypto & cryptobam

Luis Gerhorst (1):
      selftests/bpf: Fix caps for __xlated/jited_unpriv

Luiz Augusto von Dentz (8):
      Bluetooth: ISO: Fix not using SID from adv report
      Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION
      Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete
      Bluetooth: MGMT: Protect mgmt_pending list with its own lock
      Bluetooth: Fix NULL pointer deference on eir_get_service_data
      Bluetooth: hci_sync: Fix broadcast/PA when using an existing instance
      Bluetooth: eir: Fix possible crashes on eir_create_adv_data
      Bluetooth: MGMT: Fix sparse errors

Maharaja Kennadyrajan (1):
      wifi: ath12k: fix node corruption in ar->arvifs list

Marcus Folkesson (1):
      iio: adc: mcp3911: fix device dependent mappings for conversion result registers

Mario Limonciello (1):
      thunderbolt: Fix a logic error in wake on connect

Marius Cristea (1):
      iio: adc: PAC1934: fix typo in documentation link

Mark Brown (2):
      arm64/fpsimd: Discard stale CPU state when handling SME traps
      arm64/fpsimd: Don't corrupt FPMR when streaming mode changes

Mark Kettenis (1):
      arm64: dts: qcom: x1e80100: Mark usb_2 as dma-coherent

Mark Rutland (6):
      arm64/fpsimd: Avoid RES0 bits in the SME trap handler
      arm64/fpsimd: Avoid clobbering kernel FPSIMD state with SMSTOP
      arm64/fpsimd: Reset FPMR upon exec()
      arm64/fpsimd: Fix merging of FPSIMD state during signal return
      arm64/fpsimd: Avoid warning when sve_to_fpsimd() is unused
      arm64/fpsimd: Do not discard modified SVE state

Martin Blumenstingl (4):
      drm/meson: use unsigned long long / Hz for frequency types
      drm/meson: fix debug log statement when setting the HDMI clocks
      drm/meson: use vclk_freq instead of pixel_freq in debug print
      drm/meson: fix more rounding issues with 59.94Hz modes

Martin Povišer (1):
      ASoC: apple: mca: Constrain channels according to TDM mask

Masami Hiramatsu (Google) (1):
      x86/insn: Fix opcode map (!REX2) superscript tags

Mathias Nyman (1):
      usb: Flush altsetting 0 endpoints before reinitializating them after reset.

Matthew Wilcox (Oracle) (3):
      bio: Fix bio_first_folio() for SPARSEMEM without VMEMMAP
      block: Fix bvec_set_folio() for very large folios
      9p: Add a migrate_folio method

Maxime Ripard (1):
      drm/vc4: tests: Use return instead of assert

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix swapped TX stats for MII interfaces.

Miaoqian Lin (2):
      firmware: psci: Fix refcount leak in psci_dt_init
      tracing: Fix error handling in event_trigger_parse()

Michael Lo (1):
      wifi: mt76: mt7925: ensure all MCU commands wait for response

Michael Petlan (1):
      perf tests: Fix 'perf report' tests installation

Michael Walle (1):
      drm/panel-simple: fix the warnings for the Evervision VGG644804

Michal Koutný (1):
      kernfs: Relax constraint in draining guard

Michal Kubiak (3):
      ice: fix Tx scheduler error handling in XDP callback
      ice: create new Tx scheduler nodes for new queues only
      ice: fix rebuilding the Tx scheduler tree for large queue counts

Michal Luczaj (1):
      net: Fix TOCTOU issue in sk_is_readable()

Miguel Ojeda (1):
      objtool/rust: relax slice condition to cover more `noreturn` Rust functions

Mikhail Arkhipov (1):
      mtd: nand: ecc-mxic: Fix use of uninitialized variable ret

Ming Lei (2):
      loop: add file_start_write() and file_end_write()
      block: use q->elevator with ->elevator_lock held in elv_iosched_show()

Ming Yen Hsieh (2):
      wifi: mt76: mt7925: prevent multiple scan commands
      wifi: mt76: mt7925: refine the sniffer commnad

Mingcong Bai (1):
      ACPI: resource: fix a typo for MECHREVO in irq1_edge_low_force_override[]

Mirco Barone (1):
      wireguard: device: enable threaded NAPI

Moshe Shemesh (1):
      net/mlx5: Ensure fw pages are always allocated on same NUMA

Murad Masimov (1):
      ocfs2: fix possible memory leak in ocfs2_finish_quota_recovery

Namhyung Kim (1):
      perf trace: Fix leaks of 'struct thread' in set_filter_loop_pids()

Neil Armstrong (2):
      arm64: dts: qcom: sm8650: setup gpu thermal with higher temperatures
      arm64: dts: qcom: sm8650: add missing cpu-cfg interconnect path in the mdss node

Neill Kapron (1):
      selftests/seccomp: fix syscall_restart test for arm compat

Nicolas Frattaroli (1):
      mmc: sdhci-of-dwcmshc: add PD workaround on RK3576

Nicolas Pitre (1):
      vt: remove VT_RESIZE and VT_RESIZEX from vt_compat_ioctl()

Nikita Zhandarovich (1):
      net: usb: aqc111: fix error handling of usbnet read calls

Nitesh Shetty (1):
      iov_iter: use iov_offset for length calculation in iov_iter_aligned_bvec

Nitin Rawat (1):
      scsi: ufs: qcom: Prevent calling phy_exit() before phy_init()

Nylon Chen (1):
      riscv: misaligned: fix sleeping function called during misaligned access handling

Nícolas F. R. A. Prado (3):
      kselftest: cpufreq: Get rid of double suspend in rtcwake case
      arm64: dts: mediatek: mt6357: Drop regulator-fixed compatibles
      regulator: dt-bindings: mt6357: Drop fixed compatible requirement

Oleg Nesterov (1):
      posix-cpu-timers: fix race between handle_posix_cpu_timers() and posix_cpu_timer_del()

Oliver Neukum (1):
      net: usb: aqc111: debug info before sanitation

Ovidiu Panait (4):
      crypto: sun8i-ce-hash - fix error handling in sun8i_ce_hash_run()
      crypto: sun8i-ce-cipher - fix error handling in sun8i_ce_cipher_prepare()
      crypto: sun8i-ce - undo runtime PM changes during driver removal
      crypto: sun8i-ce - move fallback ahash_request to the end of the struct

P Praneesh (4):
      wifi: ath12k: Fix memory leak during vdev_id mismatch
      wifi: ath12k: Fix invalid memory access while forming 802.11 header
      wifi: ath12k: Add MSDU length validation for TKIP MIC error
      wifi: ath12k: refactor ath12k_hw_regs structure

Pablo Neira Ayuso (1):
      netfilter: nft_set_pipapo: prevent overflow in lookup table allocation

Pali Rohár (1):
      cifs: Fix validation of SMB1 query reparse point response

Patrisious Haddad (2):
      RDMA/mlx5: Fix error flow upon firmware failure for RQ destruction
      net/mlx5: Fix return value when searching for existing flow group

Pauli Virtanen (1):
      Bluetooth: hci_core: fix list_for_each_entry_rcu usage

Pawel Laszczak (2):
      usb: cdnsp: Fix issue with detecting command completion event
      usb: cdnsp: Fix issue with detecting USB 3.2 speed

Peng Fan (1):
      mailbox: imx: Fix TXDB_V2 sending

Penglei Jiang (1):
      io_uring: fix use-after-free of sq->thread in __io_uring_show_fdinfo()

Peter Chiu (1):
      wifi: mt76: mt7996: set EHT max ampdu length capability

Peter Griffin (3):
      pinctrl: samsung: refactor drvdata suspend & resume callbacks
      pinctrl: samsung: add dedicated SoC eint suspend/resume callbacks
      pinctrl: samsung: add gs101 specific eint suspend/resume callbacks

Peter Korsgaard (1):
      nvmem: zynqmp_nvmem: unbreak driver after cleanup

Peter Robinson (2):
      arm64: dts: rockchip: Add vcc-supply to SPI flash on rk3566-rock3c
      arm64: dts: rockchip: Update eMMC for NanoPi R5 series

Peter Zijlstra (2):
      sched: Fix trace_sched_switch(.prev_state)
      perf: Ensure bpf_perf_link path is properly serialized

Phillip Lougher (1):
      Squashfs: check return result of sb_min_blocksize

Pin-yen Lin (1):
      arm64: dts: mt8183: Add port node to mt8183.dtsi

Ping-Ke Shih (1):
      wifi: rtw89: pci: enlarge retry times of RX tag to 1000

Prasanth Babu Mantena (1):
      arm64: dts: ti: k3-j721e-common-proc-board: Enable OSPI1 on J721E

Qasim Ijaz (1):
      fpga: fix potential null pointer deref in fpga_mgr_test_img_load_sgt()

Qing Wang (1):
      perf/core: Fix broken throttling when max_samples_per_tick=1

Qiuxu Zhuo (2):
      EDAC/skx_common: Fix general protection fault
      EDAC/{skx_common,i10nm}: Fix the loss of saved RRL for HBM pseudo channel 0

Qu Wenruo (2):
      btrfs: scrub: update device stats when an error is detected
      btrfs: scrub: fix a wrong error type when metadata bytenr mismatches

Quentin Schulz (2):
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou
      net: stmmac: platform: guarantee uniqueness of bus_id

RD Babiera (1):
      usb: typec: tcpm: move tcpm_queue_vdm_unlocked to asynchronous work

Radim Krčmář (1):
      RISC-V: KVM: lock the correct mp_state during reset

Rafael J. Wysocki (2):
      PM: sleep: Print PM debug messages during hibernation
      PM: sleep: Fix power.is_suspended cleanup for direct-complete devices

Raj Kumar Bhagat (1):
      wifi: ath12k: fix cleanup path after mhi init

Rajat Soni (1):
      wifi: ath12k: fix memory leak in ath12k_service_ready_ext_event

Ramasamy Kaliappan (1):
      wifi: ath12k: Fix the QoS control field offset to build QoS header

Ramya Gnanasekar (1):
      wifi: ath12k: Fix WMI tag for EHT rate in peer assoc

Ritesh Harjani (IBM) (1):
      powerpc/powernv/memtrace: Fix out of bounds issue in memtrace mmap

Rob Herring (Arm) (1):
      dt-bindings: soc: fsl,qman-fqd: Fix reserved-memory.yaml reference

Robert Malz (2):
      i40e: return false from i40e_reset_vf if reset is in progress
      i40e: retry VFLR handling if there is ongoing VF reset

Rodrigo Gobbi (1):
      wifi: ath11k: validate ath11k_crypto_mode on top of ath11k_core_qmi_firmware_ready

Rodrigo Vivi (1):
      drm/xe: Make xe_gt_freq part of the Documentation

Roger Pau Monne (1):
      xen/x86: fix initial memory balloon target

Rolf Eike Beer (1):
      iommu: remove duplicate selection of DMAR_TABLE

Ronak Doshi (1):
      vmxnet3: correctly report gso type for UDP tunnels

Ryusuke Konishi (1):
      nilfs2: do not propagate ENOENT error from nilfs_btree_propagate()

Saket Kumar Bhaskar (1):
      selftests/bpf: Fix bpf_nf selftest failure

Sam Winchenbach (3):
      iio: filter: admv8818: fix band 4, state 15
      iio: filter: admv8818: fix integer overflow
      iio: filter: admv8818: fix range calculation

Sandipan Das (2):
      perf/x86/amd/uncore: Remove unused 'struct amd_uncore_ctx::node' member
      perf/x86/amd/uncore: Prevent UMC counters from saturating

Sanjeev Yadav (1):
      scsi: core: ufs: Fix a hang in the error handler

Sarika Sharma (1):
      wifi: ath12k: fix invalid access to memory

Sean Christopherson (1):
      x86/irq: Ensure initial PIR loads are performed exactly once

Sergey Shtylyov (1):
      fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hperiod()

Shayne Chen (1):
      wifi: mt76: mt7996: fix RX buffer size of MCU event

Sheng Yong (1):
      erofs: avoid using multiple devices with different type

Shiming Cheng (1):
      net: fix udp gso skb_segment after pull from frag_list

Siddharth Vadapalli (2):
      remoteproc: k3-r5: Drop check performed in k3_r5_rproc_{mbox_callback/kick}
      remoteproc: k3-dsp: Drop check performed in k3_dsp_rproc_{mbox_callback/kick}

Stefan Binding (2):
      ALSA: hda/realtek: Add support for various HP Laptops using CS35L41 HDA
      ALSA: hda/realtek: Add support for HP Agusta using CS35L41 HDA

Stefano Garzarella (1):
      vsock/virtio: fix `rx_bytes` accounting for stream sockets

Stefano Stabellini (1):
      xen/arm: call uaccess_ttbr0_enable for dm_op hypercall

Stephan Gerhold (3):
      arm64: dts: qcom: sc8280xp-x13s: Drop duplicate DMIC supplies
      arm64: dts: qcom: x1e80100: Apply consistent critical thermal shutdown
      arm64: dts: qcom: x1e80100: Add GPU cooling

Steven Rostedt (4):
      tracing: Move histogram trigger variables from stack to per CPU structure
      tracing: Rename event_trigger_alloc() to trigger_data_alloc()
      ring-buffer: Do not trigger WARN_ON() due to a commit_overrun
      ring-buffer: Move cpus_read_lock() outside of buffer->mutex

Stone Zhang (1):
      wifi: ath11k: fix node corruption in ar->arvifs list

Su Hui (1):
      soc: aspeed: lpc: Fix impossible judgment condition

Suleiman Souhlal (1):
      tools/resolve_btfids: Fix build when cross compiling kernel with clang.

Suraj Gupta (1):
      net: xilinx: axienet: Fix Tx skb circular buffer occupancy check in dmaengine xmit

Tao Chen (3):
      bpf: Check link_create.flags parameter for multi_kprobe
      libbpf: Remove sample_period init in perf_buffer
      bpf: Fix WARN() in get_bpf_raw_tp_regs

Tengteng Yang (1):
      Fix sock_exceed_buf_limit not being triggered in __sk_mem_raise_allocated

Terry Junge (1):
      HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()

Terry Tritton (1):
      selftests/seccomp: fix negative_ENOSYS tracer tests on arm32

Thangaraj Samynathan (2):
      net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy
      net: lan743x: Fix PHY reset handling during initialization and WOL

Thomas Gleixner (1):
      x86/iopl: Cure TIF_IO_BITMAP inconsistencies

Thomas Weißschuh (1):
      kunit/usercopy: Disable u64 test on 32-bit SPARC

Thuan Nguyen (1):
      arm64: dts: renesas: white-hawk-ard-audio: Fix TPU0 groups

Toke Høiland-Jørgensen (3):
      page_pool: Move pp_magic check into helper functions
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool
      wifi: ath9k_htc: Abort software beacon handling if disabled

Tzung-Bi Shih (1):
      kunit: Fix wrong parameter to kunit_deactivate_static_stub()

Ulf Hansson (1):
      pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()

Uwe Kleine-König (2):
      iio: adc: ad7124: Fix 3dB filter frequency reading
      dt-bindings: pwm: adi,axi-pwmgen: Increase #pwm-cells to 3

Varadarajan Narayanan (1):
      arm64: dts: qcom: ipq9574: Fix USB vdd info

Vignesh Raman (1):
      arm64: defconfig: mediatek: enable PHY drivers

Vijendar Mukunda (1):
      ASoC: SOF: amd: add missing acp descriptor field

Viktor Malik (1):
      libbpf: Fix buffer overflow in bpf_object__init_prog

Vincent Knecht (1):
      clk: qcom: gcc-msm8939: Fix mclk0 & mclk1 for 24 MHz

Vishwaroop A (3):
      spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
      spi: tegra210-quad: remove redundant error handling code
      spi: tegra210-quad: modify chip select (CS) deactivation

WangYuli (1):
      MIPS: Loongson64: Add missing '#interrupt-cells' for loongson64c_ls7a

Wei Fang (1):
      net: phy: clear phydev->devlink when the link is deleted

Wentao Liang (1):
      nilfs2: add pointer check for nilfs_direct_propagate()

Wilfred Mallawa (1):
      PCI: Print the actual delay time in pci_bridge_wait_for_secondary_bus()

Wojciech Slenska (1):
      pinctrl: qcom: pinctrl-qcm2290: Add missing pins

Wolfram Sang (3):
      ARM: dts: at91: usb_a9263: fix GPIO for Dataflash chip select
      ARM: dts: at91: at91sam9263: fix NAND chip selects
      rtc: sh: assign correct interrupts with DT

Wupeng Ma (1):
      VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify

Xilin Wu (1):
      arm64: dts: qcom: sm8250: Fix CPU7 opp table

Xin Li (Intel) (1):
      x86/fred/signal: Prevent immediate repeat of single step trap on return from SIGTRAP handler

Yabin Cui (1):
      coresight: catu: Introduce refcount and spinlock for enabling/disabling

Yanqing Wang (1):
      driver: net: ethernet: mtk_star_emac: fix suspend/resume issue

Yaxiong Tian (1):
      PM: EM: Fix potential division-by-zero error in em_compute_costs()

Yeoreum Yun (1):
      coresight: prevent deactivate active config while enabling the config

Yevgeny Kliteynik (1):
      net/mlx5: HWS, fix missing ip_version handling in definer

Yi Zhang (1):
      scsi: smartpqi: Fix smp_processor_id() call trace for preemptible kernels

YiFei Zhu (1):
      bpftool: Fix regression of "bpftool cgroup tree" EINVAL on older kernels

Yihang Li (1):
      scsi: hisi_sas: Call I_T_nexus after soft reset for SATA disk

Yongliang Gao (1):
      rcu/cpu_stall_cputime: fix the hardirq count for x86 architecture

Yu Kuai (2):
      brd: fix aligned_sector from brd_do_discard()
      brd: fix discard end sector

Yunhui Cui (1):
      ACPI: CPPC: Fix NULL pointer dereference when nosmp is used

Yuuki NAGAO (1):
      ASoC: ti: omap-hdmi: Re-add dai_link->platform to fix card init

Zhe Qiao (1):
      PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()

Zhen XIN (2):
      wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
      wifi: rtw88: sdio: call rtw_sdio_indicate_tx_status unconditionally

Zhiguo Niu (2):
      f2fs: use d_inode(dentry) cleanup dentry->d_inode
      f2fs: fix to correct check conditions in f2fs_cross_rename

Zhongqiu Duan (1):
      netfilter: nft_quota: match correctly when the quota just depleted

Zijun Hu (2):
      PM: wakeup: Delete space in the end of string shown by pm_show_wakelocks()
      fs/filesystems: Fix potential unsigned integer underflow in fs_name()

ping.gao (1):
      scsi: ufs: mcq: Delete ufshcd_release_scsi_cmd() in ufshcd_mcq_abort()

yohan.joung (1):
      f2fs: prevent the current section from being selected as a victim during GC

Álvaro Fernández Rojas (3):
      spi: bcm63xx-spi: fix shared reset
      spi: bcm63xx-hsspi: fix shared reset
      net: dsa: tag_brcm: legacy: fix pskb_may_pull length


