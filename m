Return-Path: <stable+bounces-196662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CCAC7FB48
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0203A35E4
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97D42F5492;
	Mon, 24 Nov 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m24Mat98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902924B28;
	Mon, 24 Nov 2025 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977655; cv=none; b=ph6GRp6YXzqgiRRLlNcAD9l9Gg+nS4UY2HXKLE/RXqGppoBQITqb3IXquO3exzo/E1USRVLTV0zGeF73HN4e775z4HG2dS91YP1K9UAIdg3/Ryu8n6YzYmm4GgOrfODUBsnc2M57wuCyWgOl7O7WOCeQpidhkATZgVyM5FPjjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977655; c=relaxed/simple;
	bh=IWkp7IoE159L+ptkYog8CM4HP7MDPkaEsNiZGAfpJcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oxNoZMVbZcejyy55b40d7E14rTboRBN/XPATT4qTyleqUAlDjWKSlS8F8dmMcpjWelGYx5rieNhmY3oOS1bOV2+ezlPVLu9t0FDhAzy8WkWZTZBB8A7eEQt+TIiI7iJiHo7jhSV9ImTXY2hgo+olrL5WKvafXDWkk8cvaaej2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m24Mat98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B3AC4CEF1;
	Mon, 24 Nov 2025 09:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763977654;
	bh=IWkp7IoE159L+ptkYog8CM4HP7MDPkaEsNiZGAfpJcE=;
	h=From:To:Cc:Subject:Date:From;
	b=m24Mat98LtExGmjaA0VtGyxJHWg7ihsBLByz8EGUTYRBG3saQ3RC4PSL/TQ5ZdGzQ
	 ZfQRA9WNHfHNmDyoEwiJZCMns+5W4IDDfs4WemgEa54xn4vpVvI31V+JulArOEvVEY
	 dBm3nMy34beGr7KFabafsUDp/zEL+sd0LCyKPHWk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.117
Date: Mon, 24 Nov 2025 10:47:29 +0100
Message-ID: <2025112429-cranberry-uncurious-d21f@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.117 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v2.rst                               |    9 
 MAINTAINERS                                                           |    1 
 Makefile                                                              |    2 
 arch/arc/include/asm/bitops.h                                         |    2 
 arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dts                |    4 
 arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts                       |    5 
 arch/arm/boot/dts/nxp/imx/imx51-zii-rdu1.dts                          |    4 
 arch/arm/crypto/Kconfig                                               |    2 
 arch/arm/mach-at91/pm_suspend.S                                       |    8 
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts                     |    2 
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts                     |    4 
 arch/loongarch/include/asm/hw_breakpoint.h                            |    4 
 arch/loongarch/include/asm/pgtable.h                                  |   11 
 arch/loongarch/kernel/traps.c                                         |    4 
 arch/mips/boot/dts/lantiq/danube.dtsi                                 |    6 
 arch/mips/boot/dts/lantiq/danube_easy50712.dts                        |    4 
 arch/mips/lantiq/xway/sysctrl.c                                       |    2 
 arch/powerpc/kernel/eeh_driver.c                                      |    2 
 arch/riscv/kernel/cpu-hotplug.c                                       |    1 
 arch/riscv/kernel/entry.S                                             |   18 
 arch/riscv/kernel/setup.c                                             |    7 
 arch/riscv/kernel/stacktrace.c                                        |   27 
 arch/riscv/mm/ptdump.c                                                |    2 
 arch/riscv/net/bpf_jit_comp64.c                                       |    5 
 arch/s390/Kconfig                                                     |    1 
 arch/s390/include/asm/pci.h                                           |    1 
 arch/s390/pci/pci_event.c                                             |    7 
 arch/s390/pci/pci_irq.c                                               |    9 
 arch/sparc/include/asm/elf_64.h                                       |    1 
 arch/sparc/include/asm/io_64.h                                        |    6 
 arch/sparc/kernel/module.c                                            |    1 
 arch/um/drivers/ssl.c                                                 |    5 
 arch/x86/entry/vsyscall/vsyscall_64.c                                 |   17 
 arch/x86/kernel/cpu/microcode/amd.c                                   |    3 
 arch/x86/kernel/fpu/core.c                                            |    3 
 arch/x86/kernel/kvm.c                                                 |   20 
 arch/x86/kvm/svm/svm.c                                                |    4 
 arch/x86/net/bpf_jit_comp.c                                           |    2 
 block/blk-cgroup.c                                                    |   23 
 drivers/accel/habanalabs/common/memory.c                              |    2 
 drivers/accel/habanalabs/gaudi/gaudi.c                                |   19 
 drivers/accel/habanalabs/gaudi2/gaudi2.c                              |   15 
 drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c                    |    2 
 drivers/acpi/acpi_video.c                                             |    4 
 drivers/acpi/acpica/dsmethod.c                                        |   10 
 drivers/acpi/button.c                                                 |    4 
 drivers/acpi/cppc_acpi.c                                              |    6 
 drivers/acpi/numa/hmat.c                                              |  322 +++++--
 drivers/acpi/numa/srat.c                                              |    2 
 drivers/acpi/prmt.c                                                   |   19 
 drivers/acpi/property.c                                               |   24 
 drivers/acpi/scan.c                                                   |    2 
 drivers/base/node.c                                                   |   18 
 drivers/base/regmap/regmap-slimbus.c                                  |    6 
 drivers/bluetooth/btmtksdio.c                                         |   12 
 drivers/bluetooth/btrtl.c                                             |    4 
 drivers/bluetooth/btusb.c                                             |   30 
 drivers/bluetooth/hci_bcsp.c                                          |    3 
 drivers/char/misc.c                                                   |   40 
 drivers/clk/at91/clk-master.c                                         |    3 
 drivers/clk/at91/clk-sam9x60-pll.c                                    |   75 -
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c                                  |   11 
 drivers/clk/ti/clk-33xx.c                                             |    2 
 drivers/clocksource/timer-vf-pit.c                                    |   22 
 drivers/cpufreq/longhaul.c                                            |    3 
 drivers/cpufreq/tegra186-cpufreq.c                                    |   27 
 drivers/cpuidle/cpuidle.c                                             |    8 
 drivers/cpuidle/governors/menu.c                                      |   73 -
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c                   |    1 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c                     |    5 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c                     |    2 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c                     |    1 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c                     |    1 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h                          |    2 
 drivers/crypto/aspeed/aspeed-acry.c                                   |    8 
 drivers/crypto/caam/ctrl.c                                            |    4 
 drivers/crypto/hisilicon/qm.c                                         |    2 
 drivers/crypto/intel/qat/qat_common/qat_uclo.c                        |    2 
 drivers/dma/dw-edma/dw-edma-core.c                                    |   22 
 drivers/dma/mv_xor.c                                                  |    4 
 drivers/dma/sh/shdma-base.c                                           |   25 
 drivers/dma/sh/shdmac.c                                               |   17 
 drivers/edac/altera_edac.c                                            |   22 
 drivers/extcon/extcon-adc-jack.c                                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c                        |   66 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                |   23 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                            |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                         |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                               |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c                              |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                               |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                               |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                              |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                              |   19 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                               |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                 |    9 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                  |   23 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                     |   14 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c            |   16 
 drivers/gpu/drm/amd/display/dc/core/dc.c                              |   19 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                     |   14 
 drivers/gpu/drm/amd/display/dc/dc_helper.c                            |    5 
 drivers/gpu/drm/amd/display/dc/dc_stream.h                            |    3 
 drivers/gpu/drm/amd/display/dc/dm_services.h                          |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c                |   20 
 drivers/gpu/drm/amd/display/dc/link/link_detection.c                  |    5 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c      |    9 
 drivers/gpu/drm/amd/display/include/dal_asic_id.h                     |    5 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                            |    5 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c                 |    2 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c              |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                     |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                    |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                                |    2 
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c                        |   12 
 drivers/gpu/drm/bridge/display-connector.c                            |    3 
 drivers/gpu/drm/drm_gem_atomic_helper.c                               |    6 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                              |    2 
 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.c                        |    4 
 drivers/gpu/drm/i915/i915_vma.c                                       |   16 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                |   10 
 drivers/gpu/drm/mediatek/mtk_drm_plane.c                              |   24 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                 |    5 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                 |    3 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c                             |   10 
 drivers/gpu/drm/nouveau/nvkm/core/enum.c                              |    2 
 drivers/gpu/drm/scheduler/sched_entity.c                              |   37 
 drivers/gpu/drm/tidss/tidss_crtc.c                                    |    7 
 drivers/gpu/drm/tidss/tidss_dispc.c                                   |   16 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                               |    5 
 drivers/hid/hid-asus.c                                                |    6 
 drivers/hid/hid-ids.h                                                 |    6 
 drivers/hid/hid-ntrig.c                                               |    7 
 drivers/hid/hid-quirks.c                                              |    2 
 drivers/hid/hid-uclogic-params.c                                      |    4 
 drivers/hid/i2c-hid/i2c-hid-acpi.c                                    |    8 
 drivers/hid/i2c-hid/i2c-hid-core.c                                    |   28 
 drivers/hid/i2c-hid/i2c-hid.h                                         |    2 
 drivers/hwmon/asus-ec-sensors.c                                       |    2 
 drivers/hwmon/dell-smm-hwmon.c                                        |    7 
 drivers/hwmon/k10temp.c                                               |   10 
 drivers/hwmon/sbtsi_temp.c                                            |   46 -
 drivers/hwmon/sy7636a-hwmon.c                                         |    1 
 drivers/iio/adc/imx93_adc.c                                           |   18 
 drivers/iio/adc/spear_adc.c                                           |    9 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                            |   11 
 drivers/infiniband/hw/hns/hns_roce_qp.c                               |    2 
 drivers/infiniband/hw/irdma/pble.c                                    |    2 
 drivers/infiniband/hw/irdma/verbs.c                                   |    4 
 drivers/infiniband/hw/irdma/verbs.h                                   |    8 
 drivers/iommu/amd/init.c                                              |   28 
 drivers/iommu/apple-dart.c                                            |    5 
 drivers/iommu/intel/debugfs.c                                         |   10 
 drivers/iommu/intel/perf.c                                            |   10 
 drivers/iommu/intel/perf.h                                            |    5 
 drivers/iommu/iommufd/io_pagetable.c                                  |   12 
 drivers/iommu/iommufd/ioas.c                                          |    4 
 drivers/irqchip/irq-gic-v2m.c                                         |   13 
 drivers/irqchip/irq-loongson-pch-lpc.c                                |    9 
 drivers/irqchip/irq-riscv-intc.c                                      |    3 
 drivers/irqchip/irq-sifive-plic.c                                     |    6 
 drivers/isdn/hardware/mISDN/hfcsusb.c                                 |   18 
 drivers/media/i2c/Kconfig                                             |    2 
 drivers/media/i2c/adv7180.c                                           |   48 -
 drivers/media/i2c/ir-kbd-i2c.c                                        |    6 
 drivers/media/i2c/og01a1b.c                                           |    6 
 drivers/media/i2c/ov08x40.c                                           |    2 
 drivers/media/pci/ivtv/ivtv-alsa-pcm.c                                |    2 
 drivers/media/pci/ivtv/ivtv-driver.h                                  |    3 
 drivers/media/pci/ivtv/ivtv-fileops.c                                 |   18 
 drivers/media/pci/ivtv/ivtv-irq.c                                     |    4 
 drivers/media/platform/amphion/vpu_v4l2.c                             |    7 
 drivers/media/platform/verisilicon/hantro_drv.c                       |    2 
 drivers/media/platform/verisilicon/hantro_v4l2.c                      |    6 
 drivers/media/rc/imon.c                                               |   61 -
 drivers/media/rc/redrat3.c                                            |    2 
 drivers/media/tuners/xc4000.c                                         |    8 
 drivers/media/tuners/xc5000.c                                         |   12 
 drivers/media/usb/uvc/uvc_driver.c                                    |   15 
 drivers/memstick/core/memstick.c                                      |    8 
 drivers/mfd/da9063-i2c.c                                              |   27 
 drivers/mfd/madera-core.c                                             |    4 
 drivers/mfd/stmpe-i2c.c                                               |    1 
 drivers/mfd/stmpe.c                                                   |    3 
 drivers/mmc/host/renesas_sdhi_core.c                                  |    6 
 drivers/mmc/host/sdhci-msm.c                                          |   15 
 drivers/mmc/host/sdhci-of-dwcmshc.c                                   |    2 
 drivers/mtd/nand/onenand/onenand_samsung.c                            |    2 
 drivers/net/dsa/b53/b53_common.c                                      |   15 
 drivers/net/dsa/b53/b53_regs.h                                        |    3 
 drivers/net/dsa/dsa_loop.c                                            |    9 
 drivers/net/dsa/microchip/ksz9477.c                                   |   98 +-
 drivers/net/dsa/microchip/ksz9477_reg.h                               |    3 
 drivers/net/dsa/microchip/ksz_common.c                                |    4 
 drivers/net/dsa/microchip/ksz_common.h                                |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                         |    4 
 drivers/net/ethernet/cadence/macb_main.c                              |    4 
 drivers/net/ethernet/freescale/fec_main.c                             |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c               |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c               |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h               |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_common.c                       |    5 
 drivers/net/ethernet/intel/fm10k/fm10k_common.h                       |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c                           |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c                           |    2 
 drivers/net/ethernet/intel/ice/ice_main.c                             |    2 
 drivers/net/ethernet/intel/ice/ice_trace.h                            |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                    |   33 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                  |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                       |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                    |   12 
 drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c              |   18 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                 |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h                 |    4 
 drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c            |    8 
 drivers/net/ethernet/microchip/sparx5/Kconfig                         |    2 
 drivers/net/ethernet/realtek/Kconfig                                  |    2 
 drivers/net/ethernet/realtek/r8169_main.c                             |    6 
 drivers/net/ethernet/renesas/sh_eth.c                                 |    4 
 drivers/net/ethernet/sfc/mae.c                                        |    4 
 drivers/net/ethernet/smsc/smsc911x.c                                  |   14 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                     |   23 
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                            |    3 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                          |    4 
 drivers/net/hamradio/6pack.c                                          |   57 -
 drivers/net/ipvlan/ipvlan_l3s.c                                       |    1 
 drivers/net/mdio/of_mdio.c                                            |    1 
 drivers/net/phy/dp83867.c                                             |    8 
 drivers/net/phy/fixed_phy.c                                           |    1 
 drivers/net/phy/marvell.c                                             |   39 
 drivers/net/phy/mdio_bus.c                                            |    5 
 drivers/net/phy/phy.c                                                 |   13 
 drivers/net/usb/asix_devices.c                                        |   12 
 drivers/net/usb/qmi_wwan.c                                            |    6 
 drivers/net/usb/usbnet.c                                              |    2 
 drivers/net/virtio_net.c                                              |   41 
 drivers/net/wireless/ath/ath10k/mac.c                                 |   12 
 drivers/net/wireless/ath/ath10k/wmi.c                                 |   40 
 drivers/net/wireless/ath/ath11k/core.c                                |   54 +
 drivers/net/wireless/ath/ath11k/wmi.c                                 |    3 
 drivers/net/wireless/ath/ath12k/dp.h                                  |    2 
 drivers/net/wireless/ath/ath12k/mac.c                                 |   34 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c           |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c                |   28 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h                |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                      |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                      |    1 
 drivers/net/wireless/realtek/rtw88/sdio.c                             |    4 
 drivers/net/wireless/virtual/mac80211_hwsim.c                         |    7 
 drivers/ntb/hw/epf/ntb_hw_epf.c                                       |  103 +-
 drivers/nvme/host/core.c                                              |    8 
 drivers/nvme/host/fc.c                                                |   10 
 drivers/nvme/target/fc.c                                              |   16 
 drivers/pci/controller/cadence/pcie-cadence-host.c                    |    2 
 drivers/pci/controller/cadence/pcie-cadence.c                         |    4 
 drivers/pci/controller/cadence/pcie-cadence.h                         |    6 
 drivers/pci/controller/dwc/pcie-designware.c                          |    4 
 drivers/pci/p2pdma.c                                                  |    2 
 drivers/pci/pci-driver.c                                              |    2 
 drivers/pci/pci.c                                                     |    5 
 drivers/pci/quirks.c                                                  |    3 
 drivers/phy/cadence/cdns-dphy.c                                       |    4 
 drivers/phy/renesas/r8a779f0-ether-serdes.c                           |   28 
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c                      |    5 
 drivers/pinctrl/pinctrl-keembay.c                                     |    7 
 drivers/pinctrl/pinctrl-single.c                                      |    4 
 drivers/pmdomain/apple/pmgr-pwrstate.c                                |    1 
 drivers/pmdomain/samsung/exynos-pm-domains.c                          |   11 
 drivers/power/supply/qcom_battmgr.c                                   |    8 
 drivers/power/supply/sbs-charger.c                                    |   16 
 drivers/ptp/ptp_clock.c                                               |   13 
 drivers/regulator/fixed.c                                             |    1 
 drivers/remoteproc/qcom_q6v5.c                                        |    5 
 drivers/remoteproc/wkup_m3_rproc.c                                    |    6 
 drivers/rtc/rtc-pcf2127.c                                             |   19 
 drivers/rtc/rtc-rx8025.c                                              |    2 
 drivers/scsi/libfc/fc_encode.h                                        |    2 
 drivers/scsi/lpfc/lpfc_debugfs.h                                      |    3 
 drivers/scsi/lpfc/lpfc_els.c                                          |    6 
 drivers/scsi/lpfc/lpfc_init.c                                         |    7 
 drivers/scsi/lpfc/lpfc_scsi.c                                         |   14 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                       |   10 
 drivers/scsi/mpt3sas/mpt3sas_transport.c                              |    3 
 drivers/scsi/pm8001/pm8001_ctl.c                                      |   24 
 drivers/scsi/pm8001/pm8001_init.c                                     |    1 
 drivers/scsi/pm8001/pm8001_sas.h                                      |    4 
 drivers/soc/aspeed/aspeed-socinfo.c                                   |    4 
 drivers/soc/qcom/smem.c                                               |    2 
 drivers/soc/tegra/fuse/fuse-tegra30.c                                 |  122 ++
 drivers/spi/spi-loopback-test.c                                       |   12 
 drivers/spi/spi-rpc-if.c                                              |    2 
 drivers/spi/spi.c                                                     |   10 
 drivers/tee/tee_core.c                                                |    2 
 drivers/thunderbolt/tb.c                                              |    2 
 drivers/ufs/core/ufshcd-crypto.c                                      |   34 
 drivers/ufs/core/ufshcd-crypto.h                                      |   36 
 drivers/ufs/core/ufshcd.c                                             |   25 
 drivers/ufs/host/ufs-mediatek.c                                       |  179 +++-
 drivers/ufs/host/ufshcd-pci.c                                         |   70 +
 drivers/usb/cdns3/cdnsp-gadget.c                                      |    8 
 drivers/usb/gadget/function/f_fs.c                                    |    8 
 drivers/usb/gadget/function/f_hid.c                                   |    4 
 drivers/usb/gadget/function/f_ncm.c                                   |    3 
 drivers/usb/host/xhci-plat.c                                          |    1 
 drivers/usb/mon/mon_bin.c                                             |   14 
 drivers/vfio/iova_bitmap.c                                            |    5 
 drivers/vfio/vfio_main.c                                              |    2 
 drivers/video/backlight/lp855x_bl.c                                   |    2 
 drivers/video/fbdev/aty/atyfb_base.c                                  |    8 
 drivers/video/fbdev/core/bitblit.c                                    |   33 
 drivers/video/fbdev/core/fbcon.c                                      |   19 
 drivers/video/fbdev/core/fbmem.c                                      |    1 
 drivers/video/fbdev/pvr2fb.c                                          |    2 
 drivers/video/fbdev/valkyriefb.c                                      |    2 
 drivers/watchdog/s3c2410_wdt.c                                        |   10 
 fs/9p/v9fs.c                                                          |    9 
 fs/btrfs/extent_io.c                                                  |    8 
 fs/btrfs/file.c                                                       |   10 
 fs/btrfs/scrub.c                                                      |    2 
 fs/btrfs/tree-log.c                                                   |    2 
 fs/ceph/dir.c                                                         |    3 
 fs/ceph/file.c                                                        |    6 
 fs/ceph/locks.c                                                       |    5 
 fs/exfat/fatent.c                                                     |   11 
 fs/ext4/fast_commit.c                                                 |    2 
 fs/ext4/xattr.c                                                       |    2 
 fs/f2fs/compress.c                                                    |    2 
 fs/f2fs/extent_cache.c                                                |    6 
 fs/fuse/inode.c                                                       |   11 
 fs/hpfs/namei.c                                                       |   18 
 fs/jfs/inode.c                                                        |    8 
 fs/jfs/jfs_txnmgr.c                                                   |    9 
 fs/nfs/nfs3client.c                                                   |   15 
 fs/nfs/nfs4client.c                                                   |   17 
 fs/nfs/nfs4proc.c                                                     |   15 
 fs/nfs/nfs4state.c                                                    |    3 
 fs/nfs/pnfs_nfs.c                                                     |   34 
 fs/nfs/sysfs.c                                                        |    1 
 fs/nfs/write.c                                                        |    3 
 fs/nfsd/nfs4proc.c                                                    |    7 
 fs/nfsd/nfs4state.c                                                   |    3 
 fs/ntfs3/inode.c                                                      |    1 
 fs/open.c                                                             |   10 
 fs/orangefs/xattr.c                                                   |   12 
 fs/proc/generic.c                                                     |   12 
 fs/smb/client/cached_dir.c                                            |   16 
 fs/smb/client/file.c                                                  |  115 ++
 fs/smb/client/fs_context.c                                            |    2 
 fs/smb/client/smb2inode.c                                             |    2 
 fs/smb/client/smb2ops.c                                               |    3 
 fs/smb/client/smb2pdu.c                                               |    7 
 fs/smb/client/transport.c                                             |   12 
 fs/smb/server/smb2pdu.c                                               |    2 
 fs/smb/server/transport_tcp.c                                         |   12 
 include/linux/blk_types.h                                             |   11 
 include/linux/cgroup.h                                                |    1 
 include/linux/compiler_types.h                                        |    5 
 include/linux/fbcon.h                                                 |    2 
 include/linux/filter.h                                                |   22 
 include/linux/map_benchmark.h                                         |    1 
 include/linux/memcontrol.h                                            |    8 
 include/linux/memory-tiers.h                                          |   39 
 include/linux/netpoll.h                                               |    1 
 include/linux/node.h                                                  |   26 
 include/linux/pci.h                                                   |    2 
 include/linux/shdma-base.h                                            |    2 
 include/linux/swap.h                                                  |    3 
 include/linux/vm_event_item.h                                         |    1 
 include/net/bluetooth/hci.h                                           |    1 
 include/net/bluetooth/hci_core.h                                      |    8 
 include/net/bluetooth/mgmt.h                                          |    2 
 include/net/cls_cgroup.h                                              |    2 
 include/net/gro.h                                                     |    3 
 include/net/nfc/nci_core.h                                            |    2 
 include/net/tc_act/tc_connmark.h                                      |    1 
 include/net/xdp.h                                                     |    5 
 include/ufs/ufs_quirks.h                                              |    3 
 include/ufs/ufshcd.h                                                  |   44 +
 include/ufs/ufshci.h                                                  |    4 
 kernel/bpf/helpers.c                                                  |    2 
 kernel/bpf/ringbuf.c                                                  |    2 
 kernel/bpf/verifier.c                                                 |    6 
 kernel/cgroup/cgroup.c                                                |   24 
 kernel/events/uprobes.c                                               |    7 
 kernel/futex/syscalls.c                                               |  106 +-
 kernel/gcov/gcc_4_7.c                                                 |    4 
 kernel/sched/fair.c                                                   |   15 
 kernel/trace/ftrace.c                                                 |    2 
 kernel/trace/trace_events_hist.c                                      |    6 
 lib/crypto/Makefile                                                   |    2 
 mm/filemap.c                                                          |   24 
 mm/memcontrol.c                                                       |  290 +++---
 mm/memory-tiers.c                                                     |  162 +++
 mm/memory.c                                                           |   24 
 mm/mm_init.c                                                          |    2 
 mm/page_io.c                                                          |    8 
 mm/percpu.c                                                           |    8 
 mm/secretmem.c                                                        |    2 
 mm/truncate.c                                                         |   27 
 mm/vmscan.c                                                           |    3 
 mm/vmstat.c                                                           |    1 
 mm/workingset.c                                                       |   54 -
 mm/zswap.c                                                            |    4 
 net/8021q/vlan.c                                                      |    2 
 net/bluetooth/6lowpan.c                                               |   97 +-
 net/bluetooth/hci_event.c                                             |   18 
 net/bluetooth/hci_sync.c                                              |   21 
 net/bluetooth/iso.c                                                   |    8 
 net/bluetooth/l2cap_core.c                                            |    1 
 net/bluetooth/mgmt.c                                                  |    7 
 net/bluetooth/rfcomm/tty.c                                            |   26 
 net/bluetooth/sco.c                                                   |    7 
 net/bridge/br.c                                                       |    5 
 net/bridge/br_forward.c                                               |    5 
 net/bridge/br_if.c                                                    |    1 
 net/bridge/br_input.c                                                 |    4 
 net/bridge/br_mst.c                                                   |   10 
 net/bridge/br_private.h                                               |   13 
 net/core/filter.c                                                     |    1 
 net/core/gro.c                                                        |    3 
 net/core/netpoll.c                                                    |   71 -
 net/core/page_pool.c                                                  |   12 
 net/core/skbuff.c                                                     |   10 
 net/core/sock.c                                                       |   15 
 net/dsa/dsa.c                                                         |    7 
 net/dsa/tag_brcm.c                                                    |   10 
 net/ethernet/eth.c                                                    |    5 
 net/handshake/tlshd.c                                                 |    1 
 net/hsr/hsr_device.c                                                  |    3 
 net/ipv4/esp4.c                                                       |    4 
 net/ipv4/netfilter/nf_reject_ipv4.c                                   |   25 
 net/ipv4/nexthop.c                                                    |    6 
 net/ipv4/route.c                                                      |    5 
 net/ipv4/udp_tunnel_nic.c                                             |    2 
 net/ipv6/addrconf.c                                                   |    4 
 net/ipv6/ah6.c                                                        |   50 -
 net/ipv6/esp6.c                                                       |    4 
 net/ipv6/netfilter/nf_reject_ipv6.c                                   |   30 
 net/ipv6/raw.c                                                        |    2 
 net/ipv6/udp.c                                                        |    2 
 net/mac80211/iface.c                                                  |   14 
 net/mac80211/mlme.c                                                   |    2 
 net/mac80211/rx.c                                                     |   10 
 net/mptcp/protocol.c                                                  |   54 -
 net/mptcp/protocol.h                                                  |    2 
 net/netfilter/nf_tables_api.c                                         |   30 
 net/rds/rds.h                                                         |    2 
 net/sched/act_bpf.c                                                   |    6 
 net/sched/act_connmark.c                                              |   30 
 net/sched/act_ife.c                                                   |   12 
 net/sched/cls_bpf.c                                                   |    6 
 net/sched/sch_generic.c                                               |   17 
 net/sctp/diag.c                                                       |   21 
 net/sctp/transport.c                                                  |   13 
 net/smc/smc_clc.c                                                     |    1 
 net/strparser/strparser.c                                             |    2 
 net/tipc/net.c                                                        |    2 
 net/unix/garbage.c                                                    |   14 
 net/xfrm/espintcp.c                                                   |    4 
 security/integrity/ima/ima_appraise.c                                 |   23 
 sound/drivers/serial-generic.c                                        |   12 
 sound/pci/hda/patch_realtek.c                                         |   17 
 sound/soc/codecs/cs4271.c                                             |   10 
 sound/soc/codecs/lpass-va-macro.c                                     |    2 
 sound/soc/codecs/max98090.c                                           |    6 
 sound/soc/codecs/tas2781-i2c.c                                        |    9 
 sound/soc/codecs/tlv320aic3x.c                                        |   32 
 sound/soc/fsl/fsl_sai.c                                               |    3 
 sound/soc/intel/avs/pcm.c                                             |    2 
 sound/soc/meson/aiu-encoder-i2s.c                                     |    9 
 sound/soc/qcom/qdsp6/q6asm.c                                          |    2 
 sound/soc/qcom/sc8280xp.c                                             |    3 
 sound/soc/stm/stm32_sai_sub.c                                         |    8 
 sound/usb/endpoint.c                                                  |    5 
 sound/usb/mixer.c                                                     |    9 
 sound/usb/mixer_s1810c.c                                              |   28 
 sound/usb/validate.c                                                  |    9 
 tools/bpf/bpftool/btf_dumper.c                                        |    2 
 tools/bpf/bpftool/prog.c                                              |    2 
 tools/include/linux/bitmap.h                                          |    1 
 tools/lib/bpf/bpf_tracing.h                                           |    2 
 tools/lib/thermal/Makefile                                            |    9 
 tools/perf/util/symbol.c                                              |    1 
 tools/power/cpupower/lib/cpuidle.c                                    |    5 
 tools/power/cpupower/lib/cpupower.c                                   |    2 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c       |   30 
 tools/testing/selftests/Makefile                                      |    2 
 tools/testing/selftests/bpf/test_lirc_mode2_user.c                    |    2 
 tools/testing/selftests/bpf/test_xsk.sh                               |    2 
 tools/testing/selftests/drivers/net/netdevsim/Makefile                |   21 
 tools/testing/selftests/drivers/net/netdevsim/settings                |    1 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc |    4 
 tools/testing/selftests/iommu/iommufd.c                               |    2 
 tools/testing/selftests/net/fcnal-test.sh                             |  432 +++++-----
 tools/testing/selftests/net/forwarding/local_termination.sh           |    2 
 tools/testing/selftests/net/gro.c                                     |  101 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.c                     |   18 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                    |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                       |   54 -
 tools/testing/selftests/net/psock_tpacket.c                           |    4 
 tools/testing/selftests/net/traceroute.sh                             |   13 
 tools/testing/selftests/user_events/perf_test.c                       |    2 
 usr/include/headers_check.pl                                          |    2 
 503 files changed, 4860 insertions(+), 2077 deletions(-)

Aaron Kling (1):
      cpufreq: tegra186: Initialize all cores to max frequencies

Abdun Nihaal (4):
      sfc: fix potential memory leak in efx_mae_process_mport()
      Bluetooth: btrtl: Fix memory leak in rtlbt_parse_firmware_v2()
      HID: uclogic: Fix potential memory leak in error path
      isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Adrian Hunter (3):
      scsi: ufs: ufs-pci: Fix S0ix/S3 for Intel controllers
      scsi: ufs: core: Add a quirk to suppress link_startup_again
      scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL

Akhil P Oommen (1):
      drm/msm/a6xx: Fix GMU firmware parser

Al Viro (3):
      allow finish_no_open(file, ERR_PTR(-E...))
      sparc64: fix prototypes of reads[bwl]()
      nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing

Albin Babu Varghese (1):
      fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds

Aleksander Jan Bajkowski (5):
      mips: lantiq: danube: add missing properties to cpu node
      mips: lantiq: danube: add model to EASY50712 dts
      mips: lantiq: danube: add missing device_type in pci node
      mips: lantiq: xway: sysctrl: rename stp clock
      mips: lantiq: danube: rename stp node on EASY50712 reference board

Alex Deucher (4):
      drm/amd/display: add more cyan skillfish devices
      drm/amd: add more cyan skillfish PCI ids
      drm/amdgpu: don't enable SMU on cyan skillfish
      drm/amdgpu: add support for cyan skillfish gpu_info

Alex Hung (1):
      drm/amd/display: Fix black screen with HDMI outputs

Alex Mastro (1):
      vfio: return -ENOTTY for unsupported device feature

Alexander Stein (2):
      mfd: stmpe: Remove IRQ domain upon removal
      mfd: stmpe-i2c: Add missing MODULE_LICENSE

Alexander Sverdlin (1):
      selftests: net: local_termination: Wait for interfaces to come up

Alexey Klimov (2):
      regmap: slimbus: fix bus_context pointer in regmap init calls
      ASoC: qcom: sc8280xp: explicitly set S16LE format in sc8280xp_be_hw_params_fixup()

Alice Chao (2):
      scsi: ufs: host: mediatek: Assign power mode userdata before FASTAUTO mode change
      scsi: ufs: host: mediatek: Fix invalid access in vccqx handling

Alistair Francis (1):
      nvme: Use non zero KATO for persistent discovery connections

Alok Tiwari (2):
      udp_tunnel: use netdev_warn() instead of netdev_WARN()
      scsi: libfc: Fix potential buffer overflow in fc_ct_ms_fill()

Amber Lin (1):
      drm/amdkfd: Tie UNMAP_LATENCY to queue_preemption

Amery Hung (1):
      bpf: Clear pfmemalloc flag when freeing all fragments

Amirreza Zarrabi (1):
      tee: allow a driver to allocate a tee_device without a pool

Anand Moon (1):
      arm64: dts: rockchip: Set correct pinctrl for I2S1 8ch TX on odroid-m1

Andreas Kemnade (1):
      hwmon: sy7636a: add alias

Andrew Davis (1):
      remoteproc: wkup_m3: Use devm_pm_runtime_enable() helper

Andrii Nakryiko (1):
      libbpf: Fix powerpc's stack register definition in bpf_tracing.h

André Draszik (1):
      pmdomain: samsung: plug potential memleak during probe

Ankit Khushwaha (1):
      selftests/user_events: fix type cast for write_index packed member in perf_test

Antheas Kapenekakis (1):
      HID: asus: add Z13 folio to generic group for multitouch to work

Anthony Iliopoulos (1):
      NFSv4.1: fix mount hang after CREATE_SESSION failure

Anton Blanchard (1):
      riscv: Improve exception and system call latency

Antonino Maniscalco (1):
      drm/msm: make sure to not queue up recovery more than once

Anubhav Singh (2):
      selftests/net: fix out-of-order delivery of FIN in gro:tcp test
      selftests/net: use destination options instead of hop-by-hop

Ariel D'Alessandro (1):
      drm/mediatek: Disable AFBC support on Mediatek DRM driver

Arkadiusz Bokowy (1):
      Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames

Armin Wolf (1):
      hwmon: (dell-smm) Add support for Dell OptiPlex 7040

Arnd Bergmann (1):
      mfd: madera: Work around false-positive -Wininitialized warning

Arseniy Krasnov (1):
      Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'

Ashish Kalra (1):
      iommu/amd: Skip enabling command/event buffers for kdump

Avadhut Naik (1):
      hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models

Baochen Qiang (1):
      Revert "wifi: ath10k: avoid unnecessary wait for service ready message"

Bart Van Assche (1):
      scsi: ufs: core: Disable timestamp functionality if not supported

Bartosz Golaszewski (1):
      pinctrl: keembay: release allocated memory in detach path

Ben Copeland (1):
      hwmon: (asus-ec-sensors) increase timeout for locking ACPI mutex

Benjamin Berg (1):
      wifi: mac80211: skip rate verification for not captured PSDUs

Benjamin Lin (1):
      wifi: mt76: mt7996: Temporarily disable EPCS

Biju Das (2):
      mmc: host: renesas_sdhi: Fix the actual clock
      spi: rpc-if: Add resume support for RZ/G3E

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Add Zen5 model 0x44, stepping 0x1 minrev

Brahmajit Das (1):
      net: intel: fm10k: Fix parameter idx set but not used

Breno Leitao (4):
      net: netpoll: Individualize the skb pool
      net: netpoll: flush skb pool during cleanup
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup
      memcg: fix data-race KCSAN bug in rstats

Bruno Thomsen (1):
      rtc: pcf2127: fix watchdog interrupt mask on pcf2131

Buday Csaba (1):
      net: mdio: fix resource leak in mdiobus_register_device()

Bui Quang Minh (1):
      virtio-net: fix received length check in big packets

Carolina Jubran (1):
      net/mlx5e: Don't query FEC statistics when FEC is disabled

Cen Zhang (1):
      Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue_once

Cezary Rojewski (1):
      ASoC: Intel: avs: Unprepare a stream when XRUN occurs

Chandrakanth Patil (1):
      scsi: mpi3mr: Fix controller init failure on fault during queue creation

Chang S. Bae (1):
      x86/fpu: Ensure XFD state on signal delivery

Chao Yu (1):
      f2fs: fix to avoid overflow while left shift operation

Charalampos Mitrodimas (1):
      net: ipv6: fix field-spanning memcpy warning in AH output

Chelsy Ratnawat (1):
      media: fix uninitialized symbol warnings

Chen Wang (1):
      PCI: cadence: Check for the existence of cdns_pcie::ops before using it

Chen Yufeng (1):
      usb: cdns3: gadget: Use-after-free during failed initialization and exit of cdnsp gadget

Chen-Yu Tsai (1):
      clk: sunxi-ng: sun6i-rtc: Add A523 specifics

Chenghao Duan (1):
      riscv: bpf: Fix uninitialized symbol 'retval_off'

Chi Zhang (1):
      pinctrl: single: fix bias pull up/down handling in pin_config_set

Chi Zhiling (1):
      exfat: limit log print for IO error

Chris Lu (1):
      Bluetooth: btmtksdio: Add pmctrl handling for BT closed state during reset

Christian Bruel (1):
      irqchip/gic-v2m: Handle Multiple MSI base IRQ Alignment

Christian König (1):
      drm/amdgpu: reject gang submissions under SRIOV

Christoph Paasch (1):
      net: When removing nexthops, don't call synchronize_net if it is not necessary

Christopher Ruehl (1):
      power: supply: qcom_battmgr: add OOI chemistry

Chuande Chen (1):
      hwmon: (sbtsi_temp) AMD CPU extended temperature range support

Chuang Wang (1):
      ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe

Chuck Lever (1):
      NFSD: Fix crash in nfsd4_read_release()

ChunHao Lin (1):
      r8169: set EEE speed down ratio to 1

Chunyan Zhang (1):
      riscv: stacktrace: Disable KASAN checks for non-current tasks

Clay King (1):
      drm/amd/display: ensure committing streams is seamless

Clément Léger (1):
      riscv: stacktrace: fix backtracing through exceptions

Coiby Xu (1):
      ima: don't clear IMA_DIGSIG flag when setting or removing non-IMA xattr

Colin Foster (1):
      smsc911x: add second read of EEPROM mac when possible corruption seen

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for MOONDROP Quark2

D. Wythe (1):
      net/smc: fix mismatch between CLC header and proposal

Damien Le Moal (2):
      block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
      block: make REQ_OP_ZONE_OPEN a write operation

Dan Carpenter (1):
      mtd: onenand: Pass correct pointer to IRQ handler

Daniel Lezcano (1):
      clocksource/drivers/vf-pit: Replace raw_readl/writel to readl/writel

Daniel Palmer (2):
      fbdev: atyfb: Check if pll_ops->init_pll failed
      eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP

Daniel Wagner (2):
      nvmet-fc: avoid scheduling association deletion twice
      nvme-fc: use lock accessing port_state and rport state

Danil Skrebenkov (1):
      RISC-V: clear hot-unplugged cores from all task mm_cpumasks to avoid rfence errors

Dave Jiang (8):
      base/node / acpi: Change 'node_hmem_attrs' to 'access_coordinates'
      acpi: numa: Create enum for memory_target access coordinates indexing
      acpi: numa: Add genport target allocation to the HMAT parsing
      acpi: Break out nesting for hmat_parse_locality()
      acpi: numa: Add setting of generic port system locality attributes
      base/node / ACPI: Enumerate node access class for 'struct access_coordinate'
      acpi/hmat: Fix lockdep warning for hmem_register_resource()
      ACPI: HMAT: Remove register of memory node for generic target

David Ahern (2):
      selftests: Disable dad for ipv6 in fcnal-test.sh
      selftests: Replace sleep with slowwait

David Francis (1):
      drm/amdgpu: Allow kfd CRIU with no buffer objects

David Howells (1):
      cifs: Fix uncached read into ITER_KVEC iterator

David Wei (1):
      netdevsim: add Makefile for selftests

Dennis Beier (1):
      cpufreq/longhaul: handle NULL policy in longhaul_exit

Devendra K Verma (1):
      dmaengine: dw-edma: Set status for callback_result

Dmitry Baryshkov (1):
      drm/bridge: display-connector: don't set OP_DETECT for DisplayPorts

Domenico Cerasuolo (1):
      mm: memcg: add per-memcg zswap writeback stat

Dragos Tatulea (2):
      page_pool: Clamp pool size to max 16K pages
      net/mlx5e: SHAMPO, Fix skb size check for 64K pages

Eduard Zingerman (1):
      bpf: account for current allocated stack depth in widen_imprecise_scalars()

Edward Adam Davis (1):
      cifs: client: fix memory leak in smb3_fs_context_parse_param

Emanuele Ghidoli (1):
      net: phy: dp83867: Disable EEE support as not implemented

Emil Dahl Juhl (1):
      tools: lib: thermal: don't preserve owner in install

Eric Biggers (6):
      lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN
      scsi: ufs: core: Add UFSHCD_QUIRK_CUSTOM_CRYPTO_PROFILE
      scsi: ufs: core: fold ufshcd_clear_keyslot() into its caller
      scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_CRYPTO_ENABLE
      scsi: ufs: core: Add fill_crypto_prdt variant op
      scsi: ufs: core: Add UFSHCD_QUIRK_KEYS_IN_PRDT

Eric Dumazet (7):
      net: call cond_resched() less often in __release_sock()
      ipv6: np->rxpmtu race annotation
      sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
      net_sched: act_connmark: use RCU in tcf_connmark_dump()
      net_sched: limit try_bulk_dequeue_skb() batches
      bpf: Add bpf_prog_run_data_pointers()
      netpoll: remove netpoll_srcu

Eric Huang (1):
      drm/amdkfd: fix vram allocation failure for a special case

Fabien Proriol (1):
      power: supply: sbs-charger: Support multiple devices

Farhan Ali (1):
      s390/pci: Restore IRQ unconditionally for the zPCI device

Felix Maurer (1):
      hsr: Fix supervision frame sending on HSRv0

Fenglin Wu (1):
      power: supply: qcom_battmgr: handle charging state change notifications

Filipe Manana (1):
      btrfs: do not update last_log_commit when logging inode due to a new name

Fiona Ebner (1):
      smb: client: transport: avoid reconnects triggered by pending task work

Florian Fuchs (1):
      fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS

Florian Westphal (1):
      netfilter: nf_reject: don't reply to icmp error messages

Forest Crossman (1):
      usb: mon: Increase BUFF_MAX to 64 MiB to support multi-MB URBs

Francisco Gutierrez (1):
      scsi: pm80xx: Fix race condition caused by static variables

Gal Pressman (5):
      net/mlx5e: Use extack in get module eeprom by page callback
      net/mlx5e: Fix return value in case of module EEPROM read error
      net/mlx5e: Fix maxrate wraparound in threshold between units
      net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps
      net/mlx5e: Fix potentially misleading debug message

Gaurav Jain (1):
      crypto: caam - double the entropy delay interval for retry

Gautham R. Shenoy (3):
      ACPI: CPPC: Check _CPC validity for only the online CPUs
      ACPI: CPPC: Perform fast check switch only for online CPUs
      ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs

Geert Uytterhoeven (1):
      kbuild: uapi: Strip comments before size type check

Geoffrey McRae (1):
      drm/amdkfd: return -ENOTTY for unsupported IOCTLs

Gerd Bayer (1):
      s390/pci: Avoid deadlock between PCI error recovery and mlx5 crdump

Gokul Sivakumar (1):
      wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode

Greg Kroah-Hartman (1):
      Linux 6.6.117

Haein Lee (1):
      ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd

Haibo Chen (1):
      iio: adc: imx93_adc: load calibrated values even calibration failed

Han Gao (1):
      riscv: acpi: avoid errors caused by probing DT devices when ACPI is used

Hangbin Liu (1):
      net: vlan: sync VLAN features with lower device

Hans de Goede (3):
      ACPI: scan: Add Intel CVS ACPI HIDs to acpi_ignore_dep_ids[]
      ACPICA: dispatcher: Use acpi_ds_clear_operands() in acpi_ds_call_control_method()
      spi: Try to get ACPI GPIO IRQ earlier

Hao Yao (1):
      media: ov08x40: Fix the horizontal flip control

Haotian Zhang (4):
      crypto: aspeed - fix double free caused by devm
      regulator: fixed: fix GPIO descriptor leak on register failure
      ASoC: cs4271: Fix regulator leak on probe failure
      ASoC: codecs: va-macro: fix resource leak in probe error path

Harikrishna Shenoy (1):
      phy: cadence: cdns-dphy: Enable lower resolutions in dphy

Hector Martin (1):
      iommu/apple-dart: Clear stream error indicator bits for T8110 DARTs

Heiko Carstens (1):
      s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP

Heiner Kallweit (1):
      net: phy: fixed_phy: let fixed_phy_unregister free the phy_device

Henrique Carvalho (3):
      smb: client: fix potential cfid UAF in smb2_query_info_compound
      smb: client: fix potential UAF in smb2_close_cached_fid()
      smb: client: fix cifs_pick_channel when channel needs reconnect

Horatiu Vultur (1):
      lan966x: Fix sleeping in atomic context

Hoyoung Seo (1):
      scsi: ufs: core: Include UTP error in INT_FATAL_ERRORS

Huacai Chen (2):
      LoongArch: Use correct accessor to read FWPC/MWPC
      LoongArch: Use physical addresses for CSR_MERRENTRY/CSR_TLBRENTRY

Huang Ying (3):
      memory tiering: add abstract distance calculation algorithms management
      acpi, hmat: refactor hmat_register_target_initiators()
      acpi, hmat: calculate abstract distance with HMAT

Ian Forbes (1):
      drm/vmwgfx: Validate command header size against SVGA_CMD_MAX_DATASIZE

Ian Rogers (1):
      tools bitmap: Add missing asm-generic/bitsperlong.h include

Ido Schimmel (2):
      bridge: Redirect to backup port when port is administratively down
      selftests: traceroute: Use require_command()

Ilan Peer (1):
      wifi: mac80211: Fix HE capabilities element check

Ilia Gavrilov (1):
      Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()

Inochi Amaoto (1):
      irqchip/sifive-plic: Respect mask state when setting affinity

Isaac J. Manjarres (1):
      mm/mm_init: fix hash table order logging in alloc_large_system_hash()

Ivan Pravdin (1):
      Bluetooth: bcsp: receive data only if registered

Jacob Moroni (3):
      RDMA/irdma: Fix SD index calculation
      RDMA/irdma: Remove unused struct irdma_cq fields
      RDMA/irdma: Set irdma_cq cq_num field during CQ create

Jakub Kicinski (3):
      selftests: net: replace sleeps in fcnal-test with waits
      page_pool: always add GFP_NOWARN for ATOMIC allocations
      selftests: netdevsim: set test timeout to 10 minutes

Janne Grunau (1):
      pmdomain: apple: Add "apple,t8103-pmgr-pwrstate"

Janusz Krzysztofik (1):
      drm/i915: Avoid lock inversion when pinning to GGTT on CHV/BXT+VTD

Jason Gunthorpe (2):
      iommufd: Make vfio_compat's unmap succeed if the range is already empty
      iommufd: Don't overflow during division for dirty tracking

Jayesh Choudhary (1):
      drm/tidss: Set crtc modesetting parameters with adjusted mode

Jens Kehne (1):
      mfd: da9063: Split chip variant reading in two bus transactions

Jens Reidel (1):
      soc: qcom: smem: Fix endian-unaware access of num_entries

Jerome Brunet (1):
      NTB: epf: Allow arbitrary BAR mapping

Jesse.Zhang (1):
      drm/amdgpu: Fix NULL pointer dereference in VRAM logic for APU devices

Jiawen Wu (1):
      net: libwx: fix device bus LAN ID

Jiayi Li (1):
      memstick: Add timeout to prevent indefinite waiting

Jihed Chaibi (1):
      ARM: dts: imx51-zii-rdu1: Fix audmux node names

Jijie Shao (1):
      net: hns3: return error code when function fails

Jiri Olsa (1):
      uprobe: Do not emulate/sstep original instruction when ip is changed

Johan Hovold (2):
      Bluetooth: rfcomm: fix modem control handling
      drm/mediatek: Fix device use-after-free on unbind

Johannes Berg (1):
      wifi: mac80211: reject address change while connecting

John Keeping (1):
      ALSA: serial-generic: remove shared static buffer

John Smith (2):
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Fiji
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Iceland

John Sperbeck (1):
      net: netpoll: ensure skb_pool list is always initialized

Jonas Gorski (4):
      net: dsa: tag_brcm: legacy: fix untagged rx on unbridged ports for bcm63xx
      net: dsa: b53: fix resetting speed and pause on forced link
      net: dsa: b53: fix enabling ip multicast
      net: dsa: b53: stop reading ARL entries if search is done

Josephine Pfeiffer (1):
      riscv: ptdump: use seq_puts() in pt_dump_seq_puts() macro

Joshua Rogers (2):
      smb: client: validate change notify buffer before copy
      ksmbd: close accepted socket when per-IP limit rejects connection

Joshua Watt (1):
      NFS4: Fix state renewals missing after boot

Josua Mayer (1):
      rtc: pcf2127: clear minute/second interrupt

Julian Sun (1):
      ext4: increase IO priority of fastcommit

Junjie Cao (1):
      fbdev: bitblit: bound-check glyph index in bit_putcs*

Junxian Huang (1):
      RDMA/hns: Fix wrong WQE data when QP wraps around

Juraj Šarinay (1):
      net: nfc: nci: Increase NCI_DATA_TIMEOUT to 3000 ms

Justin Tee (3):
      scsi: lpfc: Check return status of lpfc_reset_flush_io_context during TGT_RESET
      scsi: lpfc: Remove ndlp kref decrement clause for F_Port_Ctrl in lpfc_cleanup
      scsi: lpfc: Define size of debugfs entry for xri rebalancing

Kailang Yang (1):
      ALSA: hda/realtek: Audio disappears on HP 15-fc000 after warm boot again

Kalesh AP (1):
      bnxt_en: Fix a possible memory leak in bnxt_ptp_init

Karthi Kandasamy (1):
      drm/amd/display: Add AVI infoframe copy in copy_stream_update_to_stream

Karthik M (1):
      wifi: ath12k: free skb during idr cleanup callback

Kaushlendra Kumar (4):
      ACPI: button: Call input_free_device() on failing input device registration
      tools/cpupower: fix error return value in cpupower_write_sysfs()
      tools/cpupower: Fix incorrect size in cpuidle_state_disable()
      tools/power x86_energy_perf_policy: Fix incorrect fopen mode usage

Kees Cook (1):
      arc: Fix __fls() const-foldability via __builtin_clzl()

Kent Russell (1):
      drm/amdkfd: Handle lack of READ permissions in SVM mapping

Kirill A. Shutemov (1):
      x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall

Kiryl Shutsemau (2):
      mm/memory: do not populate page table entries beyond i_size
      mm/truncate: unmap large folio on split failure

Koakuma (1):
      sparc/module: Add R_SPARC_UA64 relocation handling

Konstantin Sinyuk (1):
      accel/habanalabs/gaudi2: read preboot status after recovering from dirty state

Krishna Kurapati (1):
      usb: xhci: plat: Facilitate using autosuspend for xhci plat devices

Krzysztof Kozlowski (4):
      extcon: adc-jack: Fix wakeup source leaks on device unbind
      drm/msm/dsi/phy: Toggle back buffer resync after preparing PLL
      drm/msm/dsi/phy_7nm: Fix missing initial VCO rate
      extcon: adc-jack: Cleanup wakeup source only if it was enabled

Kumar Kartikeya Dwivedi (1):
      bpf: Do not limit bpf_cgroup_from_id to current's namespace

Kuniyuki Iwashima (3):
      net: Call trace_sock_exceed_buf_limit() for memcg failure with SK_MEM_RECV.
      tipc: Fix use-after-free in tipc_mon_reinit_self().
      af_unix: Initialise scc_index in unix_add_edge().

Lance Yang (1):
      mm/secretmem: fix use-after-free race in fault handler

Laurent Pinchart (2):
      media: pci: ivtv: Don't create fake v4l2_fh
      media: amphion: Delete v4l2_fh synchronously in .release()

Len Brown (2):
      tools/power x86_energy_perf_policy: Enhance HWP enable
      tools/power x86_energy_perf_policy: Prefer driver HWP limits

Li RongQing (1):
      x86/kvm: Prefer native qspinlock for dedicated vCPUs irrespective of PV_UNHALT

Li Zhijian (1):
      mm/memory-tier: fix abstract distance calculation overflow

Lijo Lazar (2):
      drm/amd/pm: Use cached metrics data on aldebaran
      drm/amd/pm: Use cached metrics data on arcturus

Lizhi Xu (1):
      usbnet: Prevents free active kevent

Loic Poulain (2):
      wifi: ath10k: Fix memory leak on unsupported WMI command
      wifi: ath10k: Fix connection after GTK rekeying

Luiz Augusto von Dentz (4):
      Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00
      Bluetooth: ISO: Fix another instance of dst_type handling
      Bluetooth: hci_core: Fix tracking of periodic advertisement
      Bluetooth: SCO: Fix UAF on sco_conn_free

Lukas Wunner (1):
      thunderbolt: Use is_pciehp instead of is_hotplug_bridge

Manivannan Sadhasivam (1):
      scsi: ufs: core: Add a quirk for handling broken LSDBS field in controller capabilities register

Marcos Del Sol Vives (1):
      PCI: Disable MSI on RDC PCI to PCIe bridges

Mario Limonciello (2):
      PCI/PM: Skip resuming to D0 if device is disconnected
      drm/amd: Fix suspend failure with secure display TA

Mario Limonciello (AMD) (3):
      drm/amd: Avoid evicting resources at S5
      HID: i2c-hid: Resolve touchpad issues on Dell systems during S4
      x86/microcode/AMD: Add more known models to entry sign checking

Mark Pearson (1):
      wifi: ath11k: Add missing platform IDs for quirk table

Martin Willi (1):
      wifi: mac80211_hwsim: Limit destroy_on_close radio removal to netgroup

Masami Ichikawa (1):
      HID: hid-ntrig: Prevent memory leak in ntrig_report_version()

Matthias Schiffer (1):
      clk: ti: am33xx: keep WKUP_DEBUGSS_CLKCTRL enabled

Matthieu Baerts (NGI0) (3):
      selftests: mptcp: connect: fix fallback note due to OoO
      selftests: mptcp: join: rm: set backup flag
      selftests: mptcp: connect: trunc: read all recv data

Mehdi Djait (1):
      media: i2c: Kconfig: Ensure a dependency on HAVE_CLK for VIDEO_CAMERA_SENSOR

Miaoqian Lin (3):
      net: usb: asix_devices: Check return value of usbnet_get_endpoints
      fbdev: valkyriefb: Fix reference count leak in valkyriefb_init
      crypto: hisilicon/qm - Fix device reference leak in qm_get_qos_value

Michael Dege (1):
      phy: renesas: r8a779f0-ether-serdes: add new step added to latest datasheet

Michael Riesch (1):
      phy: rockchip: phy-rockchip-inno-csidphy: allow writes to grf register 0

Michael Strauss (1):
      drm/amd/display: Increase AUX Intra-Hop Done Max Wait Duration

Michal Hocko (1):
      mm, percpu: do not consider sleepable allocations atomic

Mike Marshall (1):
      orangefs: fix xattr related buffer overflow...

Miklos Szeredi (1):
      fuse: zero initialize inode private data

Ming Wang (1):
      irqchip/loongson-pch-lpc: Use legacy domain for PCH-LPC IRQ controller

Miroslav Lichvar (1):
      ptp: Limit time setting of PTP clocks

Moti Haimovski (1):
      accel/habanalabs: support mapping cb with vmalloc-backed coherent memory

Nai-Chen Cheng (1):
      selftests/Makefile: include $(INSTALL_DEP_TARGETS) in clean target to clean net/lib dependency

Namjae Jeon (1):
      ksmbd: use sock_create_kern interface to create kernel socket

Nate Karstens (1):
      strparser: Fix signed/unsigned mismatch bug

Nathan Chancellor (1):
      lib/crypto: curve25519-hacl64: Fix older clang KASAN workaround for GCC

Nhat Pham (1):
      cachestat: do not flush stats in recency check

Nick Hu (1):
      irqchip/riscv-intc: Add missing free() callback in riscv_intc_domain_ops

Nicolas Escande (1):
      wifi: ath11k: zero init info->status in wmi_process_mgmt_tx_comp()

Nicolas Ferre (2):
      ARM: at91: pm: save and restore ACR during PLL disable/enable
      clk: at91: clk-sam9x60-pll: force write to PLL_UPDT register

Niklas Cassel (1):
      PCI: dwc: Verify the single eDMA IRQ in dw_pcie_edma_irq_verify()

Niklas Schnelle (2):
      powerpc/eeh: Use result of error_detected() in uevent
      s390/pci: Use pci_uevent_ers() in PCI recovery

Niklas Söderlund (4):
      media: adv7180: Add missing lock in suspend callback
      media: adv7180: Do not write format to device in set_fmt
      media: adv7180: Only validate format in querystd
      net: sh_eth: Disable WoL if system can not suspend

Nikolay Aleksandrov (2):
      net: bridge: fix use-after-free due to MST port state bypass
      net: bridge: fix MST static key usage

Niravkumar L Rabara (2):
      EDAC/altera: Handle OCRAM ECC enable after warm reset
      EDAC/altera: Use INTTEST register for Ethernet and USB SBE injection

Nithyanantham Paramasivam (1):
      wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256

Noorain Eqbal (1):
      bpf: Sync pending IRQ work before freeing ring buffer

Oleg Makarenko (1):
      HID: quirks: Add ALWAYS_POLL quirk for VRS R295 steering wheel

Oleksij Rempel (2):
      net: stmmac: Correctly handle Rx checksum offload errors
      net: phy: clear link parameters on admin link down

Olga Kornievskaia (2):
      NFSv4: handle ERR_GRACE on delegation recalls
      NFSD: free copynotify stateid in nfs4_free_ol_stateid()

Olivier Moysan (1):
      ASoC: stm32: sai: manage context in set_sysclk callback

Ondrej Mosnacek (1):
      bpf: Do not audit capability check in do_jit()

Ovidiu Panait (1):
      crypto: sun8i-ce - remove channel timeout field

Owen Gu (1):
      usb: gadget: f_fs: Fix epfile null pointer access after ep enable.

Pablo Neira Ayuso (1):
      netfilter: nf_tables: reject duplicate device on updates

Pankaj Raghav (1):
      filemap: cap PTE range to be created to allowed zero fill in folio_map_range()

Paolo Abeni (4):
      mptcp: drop bogus optimization in __mptcp_check_push()
      mptcp: restore window probe
      mptcp: fix MSG_PEEK stream corruption
      net: allow small head cache usage with large MAX_SKB_FRAGS values

Paul Hsieh (1):
      drm/amd/display: update dpp/disp clock from smu clock table

Paul Kocialkowski (1):
      media: verisilicon: Explicitly disable selection api ioctls for decoders

Pauli Virtanen (5):
      Bluetooth: MGMT: cancel mesh send timer when hdev removed
      Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
      Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
      Bluetooth: L2CAP: export l2cap_chan_hold for modules

Peter Oberparleiter (1):
      gcov: add support for GCC 15

Peter Wang (5):
      scsi: ufs: host: mediatek: Fix auto-hibern8 timer configuration
      scsi: ufs: host: mediatek: Change reset sequence for improved stability
      scsi: ufs: host: mediatek: Enhance recovery on resume failure
      scsi: ufs: host: mediatek: Enhance recovery on hibernation exit failure
      scsi: ufs: host: mediatek: Disable auto-hibern8 during power mode changes

Peter Zijlstra (1):
      compiler_types: Move unused static inline functions warning to W=2

Petr Machata (1):
      net: bridge: Install FDB for bridge MAC on VLAN 0

Philipp Stanner (1):
      drm/sched: Fix race in drm_sched_entity_select_rq()

Pierre Gondois (1):
      sched/fair: Use all little CPUs for CPU-bound workloads

Pierre-Eric Pelloux-Prayer (1):
      drm/sched: Fix deadlock in drm_sched_entity_kill_jobs_cb

Ping-Ke Shih (1):
      wifi: rtw88: sdio: use indirect IO for device registers before power-on

Pranav Tyagi (1):
      futex: Don't leak robust_list pointer on exec race

Primoz Fiser (1):
      ASoC: tlv320aic3x: Fix class-D initialization for tlv320aic3007

Qendrim Maxhuni (1):
      net: usb: qmi_wwan: initialize MAC header offset in qmimux_rx_fixup

Qianfeng Rong (3):
      crypto: qat - use kcalloc() in qat_uclo_map_objs_from_mof()
      scsi: pm8001: Use int instead of u32 to store error codes
      media: redrat3: use int type to store negative error codes

Qingfang Deng (2):
      6pack: drop redundant locking and refcounting
      net: stmmac: Fix accessing freed irq affinity_hint

Qinxin Xia (1):
      dma-mapping: benchmark: Restore padding to ensure uABI remained consistent

Qu Wenruo (1):
      btrfs: ensure no dirty metadata is written back for an fs with errors

Quan Zhou (1):
      wifi: mt76: mt7921: Add 160MHz beamformee capability for mt7922 device

Quanmin Yan (1):
      fbcon: Set fb_display[i]->mode to NULL when the mode is released

Radhey Shyam Pandey (1):
      arm64: zynqmp: Revert usb node drive strength and slew rate for zcu106

Rafael J. Wysocki (3):
      cpuidle: governors: menu: Rearrange main loop in menu_select()
      cpuidle: governors: menu: Select polling state in some more cases
      cpuidle: Fail cpuidle device registration if there is one already

Rafał Miłecki (1):
      ARM: dts: BCM53573: Fix address of Luxul XAP-1440's Ethernet PHY

Randall P. Embry (2):
      9p: fix /sys/fs/9p/caches overwriting itself
      9p: sysfs_init: don't hardcode error to ENOMEM

Ranganath V N (2):
      net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
      net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak

Ranjan Kumar (1):
      scsi: mpt3sas: Add support for 22.5 Gbps SAS link rate

Raphael Pinsonneault-Thibeault (2):
      Bluetooth: hci_event: validate skb length for unknown CC opcode
      Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

Ricardo B. Marlière (2):
      selftests/bpf: Fix bpf_prog_detach2 usage in test_lirc_mode2
      selftests/bpf: Upon failures, exit with code 1 in test_xsk.sh

Ricardo Ribalda (1):
      media: uvcvideo: Use heuristic to find stream entity

Richard Gobert (1):
      selftests/net: fix GRO coalesce test and add ext header coalesce tests

Robert Marko (1):
      net: ethernet: microchip: sparx5: make it selectable for ARCH_LAN969X

Rodrigo Gobbi (1):
      iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sample before setting register

Rohan G Thomas (1):
      net: phy: marvell: Fix 88e1510 downshift counter errata

Rong Zhang (1):
      hwmon: (k10temp) Add device ID for Strix Halo

Rosen Penev (1):
      dmaengine: mv_xor: match alloc_wc and free_wc

Roy Vegard Ovesen (2):
      ALSA: usb-audio: fix control pipe direction
      ALSA: usb-audio: add mono main switch to Presonus S1824c

Ryan Chen (1):
      soc: aspeed: socinfo: Add AST27xx silicon IDs

Ryan Wanner (1):
      clk: at91: clk-master: Add check for divide by 3

Sabrina Dubroca (1):
      espintcp: fix skb leaks

Sakari Ailus (1):
      ACPI: property: Return present device nodes only on fwnode interface

Saket Dumbre (1):
      ACPICA: Update dsmethod.c to get rid of unused variable warning

Sangwook Shin (1):
      watchdog: s3c2410_wdt: Fix max_timeout being calculated larger

Sarthak Garg (1):
      mmc: sdhci-msm: Enable tuning for SDR50 mode for SD card

Sascha Hauer (1):
      tools: lib: thermal: use pkg-config to locate libnl3

Sathishkumar S (1):
      drm/amdgpu/jpeg: Hold pg_lock before jpeg poweroff

Scott Mayhew (1):
      NFS: check if suid/sgid was cleared after a write as needed

Seyediman Seyedarab (2):
      drm/nouveau: replace snprintf() with scnprintf() in nvkm_snprintbf()
      iommu/vt-d: Replace snprintf with scnprintf in dmar_latency_snapshot()

Shang song (Lenovo) (1):
      ACPI: PRM: Skip handlers with NULL handler_address or NULL VA

Sharique Mohammad (1):
      ASoC: max98090/91: fixed max98091 ALSA widget powering up/down

Shaurya Rane (1):
      jfs: fix uninitialized waitqueue in transaction manager

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT to 0x4

Shenghao Ding (1):
      ASoC: tas2781: fix getting the wrong device number

Shengjiu Wang (1):
      ASoC: fsl_sai: fix bit order for DSD format

Shuai Xue (1):
      acpi,srat: Fix incorrect device handle check for Generic Initiator

Shuhao Fu (1):
      smb: client: fix refcount leak in smb2_set_path_attr

Shyam Prasad N (1):
      cifs: stop writeback extension when change of size is detected

Srinivas Kandagatla (1):
      ASoC: qdsp6: q6asm: do not sleep while atomic

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix function header names in amdgpu_connectors.c

Stefan Wahren (1):
      ethernet: Extend device_get_mac_address() to use NVMEM

Stefan Wiehler (3):
      sctp: Hold RCU read lock while iterating over address list
      sctp: Prevent TOCTOU out-of-bounds write
      sctp: Hold sock lock while iterating over address list

Stephan Gerhold (1):
      remoteproc: qcom: q6v5: Avoid handling handover twice

Steven Rostedt (1):
      selftests/tracing: Run sample events to clear page cache events

Sungho Kim (1):
      PCI/P2PDMA: Fix incorrect pointer usage in devm_kfree() call

Svyatoslav Ryhel (4):
      soc/tegra: fuse: Add Tegra114 nvmem cells and fuse lookups
      ARM: tegra: transformer-20: add missing magnetometer interrupt
      ARM: tegra: transformer-20: fix audio-codec interrupt
      video: backlight: lp855x_bl: Set correct EPROM start for LP8556

Takashi Iwai (2):
      ALSA: usb-audio: Add validation of UAC2/UAC3 effect units
      ALSA: usb-audio: Fix potential overflow of PCM transfer buffer

Tetsuo Handa (3):
      media: imon: make send_packet() more robust
      ntfs3: pretend $Extend records as regular files
      jfs: Verify inode mode when loading from disk

Thadeu Lima de Souza Cascardo (1):
      char: misc: restrict the dynamic range to exclude reserved minors

Thomas Andreatta (1):
      dmaengine: sh: setup_xref error handling

Thomas Weißschuh (3):
      spi: loopback-test: Don't use %pK through printk
      bpf: Don't use %pK through printk
      ice: Don't use %pK through printk or tracepoints

Thomas Zimmermann (1):
      drm/sysfb: Do not dereference NULL pointer in plane reset

Théo Lebrun (1):
      net: macb: avoid dealing with endianness in macb_set_hwaddr()

Tianyang Zhang (1):
      LoongArch: Let {pte,pmd}_modify() record the status of _PAGE_DIRTY

Tiezhu Yang (1):
      net: stmmac: Check stmmac_hw_setup() in stmmac_resume()

Timur Kristóf (4):
      drm/amdgpu: Respect max pixel clock for HDMI and DVI-D (v2)
      drm/amd/display: Fix DVI-D/HDMI adapters
      drm/amd/display: Disable VRR on DCE 6
      drm/amd/pm: Disable MCLK switching on SI at high pixel clocks

Tiwei Bie (1):
      um: Fix help message for ssl-non-raw

Tom Stellard (1):
      bpftool: Fix -Wuninitialized-const-pointer warnings with clang >= 21

Tomer Tayar (1):
      accel/habanalabs: return ENOMEM if less than requested pages were pinned

Tomeu Vizoso (1):
      drm/etnaviv: fix flush sequence logic

Tomi Valkeinen (3):
      drm/tidss: Use the crtc_* timings when programming the HW
      drm/bridge: cdns-dsi: Fix REG_WAKEUP_TIME value
      drm/bridge: cdns-dsi: Don't fail on MIPI_DSI_MODE_VIDEO_BURST

Tristan Lobb (1):
      HID: quirks: avoid Cooler Master MM712 dongle wakeup bug

Tristram Ha (1):
      net: dsa: microchip: Fix reserved multicast address table programming

Trond Myklebust (4):
      pnfs: Fix TLS logic in _nfs4_pnfs_v4_ds_connect()
      NFS: enable nconnect for RDMA
      pnfs: Set transport security policy to RPC_XPRTSEC_NONE unless using TLS
      NFSv4: Fix an incorrect parameter when calling nfs4_call_sync()

Tvrtko Ursulin (1):
      drm/amdgpu: Use memdup_array_user in amdgpu_cs_wait_fences_ioctl

Ujwal Kundur (1):
      rds: Fix endianness annotation for RDS_MPATH_HASH

Umesh Nerlige Ramappa (1):
      drm/i915: Fix conversion between clock ticks and nanoseconds

Uwe Kleine-König (1):
      crypto: aspeed-acry - Convert to platform remove callback returning void

Valerio Setti (1):
      ASoC: meson: aiu-encoder-i2s: fix bit clock polarity

Vered Yavniely (1):
      accel/habanalabs/gaudi2: fix BMON disable configuration

Viacheslav Dubeyko (2):
      ceph: add checking of wait_for_completion_killable() return value
      ceph: refactor wake_up_bit() pattern of calling

Vincent Guittot (1):
      sched/pelt: Avoid underestimation of task utilization

Vladimir Oltean (1):
      net: dsa: improve shutdown sequence

Vladimir Riabchun (1):
      ftrace: Fix softlockup in ftrace_module_enable

Vladimir Zapolskiy (1):
      media: i2c: og01a1b: Specify monochrome media bus format instead of Bayer

Wake Liu (2):
      selftests/net: Replace non-standard __WORDSIZE with sizeof(long) * 8
      selftests/net: Ensure assert() triggers in psock_tpacket.c

Wang Liang (2):
      selftests: netdevsim: Fix ethtool-coalesce.sh fail by installing ethtool-common.sh
      net: fix NULL pointer dereference in l3mdev_l3_rcv

Wayne Lin (1):
      drm/amd/display: Enable mst when it's detected but yet to be initialized

Wei Fang (1):
      net: fec: correct rx_bytes statistic for the case SHIFT16 is set

Wei Yang (1):
      fs/proc: fix uaf in proc_readdir_de()

William Wu (1):
      usb: gadget: f_hid: Fix zero length packet transfer

Wonkon Kim (1):
      scsi: ufs: core: Initialize value of an attribute returned by uic cmd

Xin Hao (1):
      mm: memcg: add THP swap out info for anonymous reclaim

Xion Wang (1):
      char: Use list_del_init() in misc_deregister() to reinitialize list pointer

Xuan Zhuo (1):
      virtio-net: fix incorrect flags recording in big mode

Yafang Shao (1):
      net/cls_cgroup: Fix task_get_classid() during qdisc run

Yang Wang (1):
      drm/amd/pm: fix smu table id bound check issue in smu_cmn_update_table()

Yang Xiuwei (1):
      NFS: sysfs: fix leak when nfs_client kobject add fails

Yifan Zhang (1):
      amd/amdkfd: resolve a race in amdgpu_amdkfd_device_fini_sw

Yikang Yue (1):
      fs/hpfs: Fix error code for new_inode() failure in mkdir/create/mknod/symlink

Ying Huang (1):
      memory tiers: use default_dram_perf_ref_source in log message

Yosry Ahmed (7):
      KVM: SVM: Mark VMCB_LBR dirty when MSR_IA32_DEBUGCTLMSR is updated
      mm: memcg: change flush_next_time to flush_last_time
      mm: memcg: move vmstats structs definition above flushing code
      mm: memcg: make stats flushing threshold per-memcg
      mm: workingset: move the stats flush into workingset_test_recent()
      mm: memcg: restore subtree stats flushing
      mm: memcg: optimize parent iteration in memcg_rstat_updated()

Yu Kuai (1):
      blk-cgroup: fix possible deadlock while configuring policy

Yue Haibing (1):
      ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled

Yuhao Jiang (1):
      ACPI: video: Fix use-after-free in acpi_video_switch_brightness()

Yuta Hayama (1):
      rtc: rx8025: fix incorrect register reference

ZhangGuoDong (2):
      smb/server: fix possible memory leak in smb2_read()
      smb/server: fix possible refcount leak in smb2_sess_setup()

Zijun Hu (2):
      char: misc: Make misc_register() reentry for miscdevice who wants dynamic minor
      char: misc: Does not request module for miscdevice with dynamic minor

Zilin Guan (3):
      tracing: Fix memory leaks in create_field_var()
      net/handshake: Fix memory leak in tls_handshake_accept()
      btrfs: scrub: put bio after errors in scrub_raid56_parity_stripe()

austinchang (1):
      btrfs: mark dirty extent range for out of bound prealloc extents

chuguangqing (1):
      fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock

jingxian.li (1):
      Revert "perf dso: Add missed dso__put to dso__load_kcore"

raub camaioni (1):
      usb: gadget: f_ncm: Fix MAC assignment NCM ethernet

wangzijie (1):
      f2fs: fix infinite loop in __insert_extent_tree()

wenglianfa (1):
      RDMA/hns: Fix the modification of max_send_sge


