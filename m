Return-Path: <stable+bounces-176628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90907B3A256
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2167C3D24
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBBD314A91;
	Thu, 28 Aug 2025 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQSbgcWP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3A313E33;
	Thu, 28 Aug 2025 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392020; cv=none; b=A4ewt3y+ogMc6JNeDEMqJd7mAOevkWbMG2g8qNGhnR5fyhTugNolr1GFOXM5KRDZzdkYQHr1H9ERxnk33GQZWVjGRUWOXNuMoNpPvVbIAudVSY5NiFvwYGTJBL/lIrL4GVI9QRi8rhP2RTkf0qu9DJn6g3Xfr3oNcJTMLHI5Mu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392020; c=relaxed/simple;
	bh=Fek875J6WLMZFzH/zC32VBbAFoCsf2s0mQ6atK73DJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TpGKCWk43eALqzsJtIx5Kw9qs9gKqFXUWXqrIve+vu7G/Pdk8KBWrtGehI+mQKL5KIJBxdUfn+ZeiL4k00UEg82JptnIOGbW+UsHMwhfouI9LJq5G+w3ra+jurGYWgyTsoYvizLw3Pe4N5pg+/GYtcP/fRMqynl/QqScxNS+BrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQSbgcWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B336C4CEEB;
	Thu, 28 Aug 2025 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756392020;
	bh=Fek875J6WLMZFzH/zC32VBbAFoCsf2s0mQ6atK73DJk=;
	h=From:To:Cc:Subject:Date:From;
	b=RQSbgcWPNkPeZH6ZvbIgNbFGoheleFrDsxf85ivUb3pM1EFOvXce+gDGtfCqwSdHP
	 nyhg9yL+qGcGEJogbErcTfYzt+1w1w0TEmqkIZX0XQvEREyChGHtM5cYdIz71u7XGp
	 nlfk37WF60C+Z0UwqkInSrO9GZYMAg1FAOqEbPL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.44
Date: Thu, 28 Aug 2025 16:40:04 +0200
Message-ID: <2025082805-unusable-android-7d68@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.44 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml      |    2 
 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml |    2 
 Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml                   |    4 
 Documentation/networking/mptcp-sysctl.rst                                 |    2 
 Makefile                                                                  |    4 
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                              |    1 
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                                  |   36 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                                  |    1 
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi                           |    1 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                                |   12 
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts                            |    2 
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                                    |   24 
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi                          |    1 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                   |    7 
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                                   |    2 
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi                            |   24 
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                                   |    1 
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts                            |    1 
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi             |    1 
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                                     |    1 
 arch/arm64/boot/dts/ti/k3-pinctrl.h                                       |   15 
 arch/loongarch/kernel/module-sections.c                                   |   36 -
 arch/loongarch/kvm/vcpu.c                                                 |    8 
 arch/m68k/kernel/head.S                                                   |   31 
 arch/mips/crypto/chacha-core.S                                            |   20 
 arch/parisc/Makefile                                                      |    4 
 arch/parisc/include/asm/pgtable.h                                         |    7 
 arch/parisc/include/asm/special_insns.h                                   |   28 
 arch/parisc/include/asm/uaccess.h                                         |   21 
 arch/parisc/kernel/cache.c                                                |    6 
 arch/parisc/kernel/entry.S                                                |   17 
 arch/parisc/kernel/syscall.S                                              |   30 
 arch/parisc/lib/memcpy.c                                                  |   19 
 arch/parisc/mm/fault.c                                                    |    4 
 arch/powerpc/boot/Makefile                                                |    1 
 arch/s390/boot/vmem.c                                                     |    3 
 arch/s390/hypfs/hypfs_dbfs.c                                              |   19 
 arch/x86/coco/sev/shared.c                                                |    3 
 arch/x86/include/asm/xen/hypercall.h                                      |    5 
 arch/x86/kernel/cpu/hygon.c                                               |    3 
 arch/x86/kvm/mmu/mmu.c                                                    |   10 
 drivers/accel/habanalabs/gaudi2/gaudi2.c                                  |    2 
 drivers/acpi/pfr_update.c                                                 |    2 
 drivers/ata/Kconfig                                                       |   36 -
 drivers/ata/libata-scsi.c                                                 |   58 -
 drivers/base/power/runtime.c                                              |   27 
 drivers/bluetooth/btmtk.c                                                 |    7 
 drivers/bus/mhi/host/boot.c                                               |    8 
 drivers/bus/mhi/host/internal.h                                           |    4 
 drivers/bus/mhi/host/main.c                                               |   12 
 drivers/cdx/controller/cdx_rpmsg.c                                        |    3 
 drivers/comedi/comedi_fops.c                                              |    5 
 drivers/comedi/drivers.c                                                  |   23 
 drivers/comedi/drivers/pcl726.c                                           |    3 
 drivers/cpufreq/armada-8k-cpufreq.c                                       |    2 
 drivers/cpuidle/governors/menu.c                                          |  101 --
 drivers/crypto/caam/ctrl.c                                                |    5 
 drivers/crypto/caam/intern.h                                              |    1 
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h                      |    1 
 drivers/crypto/intel/qat/qat_common/adf_init.c                            |    1 
 drivers/crypto/intel/qat/qat_common/adf_isr.c                             |    5 
 drivers/crypto/intel/qat/qat_common/qat_algs.c                            |   12 
 drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h                        |  125 ++-
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c                       |   35 
 drivers/fpga/zynq-fpga.c                                                  |   10 
 drivers/gpu/drm/Kconfig                                                   |    5 
 drivers/gpu/drm/Makefile                                                  |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                             |   76 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                    |    6 
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c                                    |    2 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c                                 |   57 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c                                 |   34 
 drivers/gpu/drm/amd/amdgpu/soc15.c                                        |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_module.c                                   |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                         |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                    |   28 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c                 |    2 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c                         |    5 
 drivers/gpu/drm/amd/display/dc/bios/command_table.c                       |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c                          |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c               |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c            |   40 -
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c              |   31 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                  |   34 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c                       |    3 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                 |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c                      |   30 
 drivers/gpu/drm/display/drm_dp_helper.c                                   |    2 
 drivers/gpu/drm/drm_draw.c                                                |  155 ++++
 drivers/gpu/drm/drm_draw_internal.h                                       |   56 +
 drivers/gpu/drm/drm_format_helper.c                                       |  234 ++++--
 drivers/gpu/drm/drm_format_internal.h                                     |  127 +++
 drivers/gpu/drm/drm_panic.c                                               |  269 -------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c                           |    4 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h                           |   17 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c                           |   46 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c                          |   29 
 drivers/gpu/drm/i915/display/intel_tc.c                                   |   58 +
 drivers/gpu/drm/nouveau/nvif/vmm.c                                        |    3 
 drivers/gpu/drm/tests/drm_format_helper_test.c                            |  176 ++--
 drivers/gpu/drm/xe/Kconfig                                                |    1 
 drivers/hwmon/gsc-hwmon.c                                                 |    4 
 drivers/iio/adc/ad7173.c                                                  |    3 
 drivers/iio/adc/ad_sigma_delta.c                                          |    4 
 drivers/iio/imu/bno055/bno055.c                                           |   11 
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                               |    8 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                         |   33 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c                        |   22 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h                        |   10 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c                          |    6 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                          |   43 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c                          |   12 
 drivers/iio/light/adjd_s311.c                                             |    2 
 drivers/iio/light/as73211.c                                               |    4 
 drivers/iio/light/bh1745.c                                                |    2 
 drivers/iio/light/isl29125.c                                              |    2 
 drivers/iio/light/ltr501.c                                                |    2 
 drivers/iio/light/max44000.c                                              |    2 
 drivers/iio/light/rohm-bu27034.c                                          |    2 
 drivers/iio/light/rpr0521.c                                               |    2 
 drivers/iio/light/st_uvis25.h                                             |    2 
 drivers/iio/light/tcs3414.c                                               |    2 
 drivers/iio/light/tcs3472.c                                               |    2 
 drivers/iio/pressure/bmp280-core.c                                        |    9 
 drivers/iio/proximity/isl29501.c                                          |   16 
 drivers/iio/temperature/maxim_thermocouple.c                              |   26 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                  |    8 
 drivers/infiniband/hw/bnxt_re/main.c                                      |   23 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                                  |   30 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                                  |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                 |    2 
 drivers/infiniband/hw/erdma/erdma_verbs.c                                 |    4 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                |    6 
 drivers/infiniband/hw/hns/hns_roce_restrack.c                             |    9 
 drivers/infiniband/sw/rxe/rxe_net.c                                       |   29 
 drivers/infiniband/sw/rxe/rxe_qp.c                                        |    2 
 drivers/iommu/amd/init.c                                                  |    4 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                               |    2 
 drivers/md/dm-crypt.c                                                     |   49 +
 drivers/md/dm.c                                                           |   17 
 drivers/media/cec/usb/rainshadow/rainshadow-cec.c                         |    3 
 drivers/media/i2c/hi556.c                                                 |   26 
 drivers/media/i2c/mt9m114.c                                               |    8 
 drivers/media/i2c/ov2659.c                                                |    3 
 drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c                             |   12 
 drivers/media/pci/intel/ivsc/mei_ace.c                                    |    2 
 drivers/media/pci/intel/ivsc/mei_csi.c                                    |    2 
 drivers/media/platform/qcom/camss/camss.c                                 |    4 
 drivers/media/platform/qcom/venus/core.c                                  |   18 
 drivers/media/platform/qcom/venus/core.h                                  |    2 
 drivers/media/platform/qcom/venus/hfi_venus.c                             |    5 
 drivers/media/platform/qcom/venus/vdec.c                                  |    5 
 drivers/media/platform/qcom/venus/venc.c                                  |    5 
 drivers/media/platform/raspberrypi/pisp_be/Kconfig                        |    1 
 drivers/media/platform/raspberrypi/pisp_be/pisp_be.c                      |    5 
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c                      |    9 
 drivers/media/test-drivers/vivid/vivid-ctrls.c                            |    3 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                          |    4 
 drivers/media/usb/gspca/vicam.c                                           |   10 
 drivers/media/usb/usbtv/usbtv-video.c                                     |    4 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                 |    1 
 drivers/memstick/core/memstick.c                                          |    1 
 drivers/memstick/host/rtsx_usb_ms.c                                       |    1 
 drivers/mmc/host/sdhci-pci-gli.c                                          |   37 -
 drivers/mmc/host/sdhci_am654.c                                            |   18 
 drivers/most/core.c                                                       |    2 
 drivers/mtd/nand/raw/fsmc_nand.c                                          |    2 
 drivers/mtd/nand/raw/renesas-nand-controller.c                            |    6 
 drivers/mtd/nand/spi/core.c                                               |    5 
 drivers/mtd/spi-nor/swp.c                                                 |   19 
 drivers/net/bonding/bond_3ad.c                                            |   67 +
 drivers/net/bonding/bond_options.c                                        |    1 
 drivers/net/can/ti_hecc.c                                                 |    2 
 drivers/net/dsa/microchip/ksz_common.c                                    |    6 
 drivers/net/ethernet/google/gve/gve_main.c                                |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                                 |   14 
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c                              |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c                    |    4 
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c                           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h                        |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c                  |   18 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                        |   12 
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c                |    4 
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h                       |   87 ++
 drivers/net/ethernet/mellanox/mlx5/core/port.c                            |   40 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                            |    2 
 drivers/net/ethernet/mellanox/mlxsw/trap.h                                |    1 
 drivers/net/ethernet/microchip/lan865x/lan865x.c                          |   21 
 drivers/net/ethernet/realtek/rtase/rtase.h                                |    2 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                              |   72 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                         |    8 
 drivers/net/phy/mscc/mscc.h                                               |   12 
 drivers/net/phy/mscc/mscc_main.c                                          |   12 
 drivers/net/phy/mscc/mscc_ptp.c                                           |   49 +
 drivers/net/ppp/ppp_generic.c                                             |   17 
 drivers/net/usb/asix_devices.c                                            |    2 
 drivers/net/wireless/ath/ath11k/ce.c                                      |    3 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                   |    3 
 drivers/net/wireless/ath/ath11k/hal.c                                     |   33 
 drivers/net/wireless/ath/ath12k/ce.c                                      |    3 
 drivers/net/wireless/ath/ath12k/hal.c                                     |   38 -
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c            |    2 
 drivers/pci/controller/dwc/pci-imx6.c                                     |   32 
 drivers/pci/controller/pcie-rockchip-host.c                               |   49 -
 drivers/pci/controller/pcie-rockchip.h                                    |   11 
 drivers/pci/endpoint/pci-ep-cfs.c                                         |    1 
 drivers/pci/endpoint/pci-epf-core.c                                       |    2 
 drivers/pci/pcie/portdrv.c                                                |    2 
 drivers/phy/qualcomm/phy-qcom-m31.c                                       |   14 
 drivers/platform/chrome/cros_ec.c                                         |    3 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c       |    5 
 drivers/pwm/pwm-imx-tpm.c                                                 |    9 
 drivers/pwm/pwm-mediatek.c                                                |   71 +
 drivers/s390/char/sclp.c                                                  |   11 
 drivers/scsi/mpi3mr/mpi3mr.h                                              |    6 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                           |   17 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                           |    2 
 drivers/scsi/qla4xxx/ql4_os.c                                             |    2 
 drivers/scsi/scsi_lib.c                                                   |    3 
 drivers/soc/qcom/mdt_loader.c                                             |   43 +
 drivers/soc/tegra/pmc.c                                                   |   51 -
 drivers/spi/spi-fsl-lpspi.c                                               |    8 
 drivers/staging/media/imx/imx-media-csc-scaler.c                          |    2 
 drivers/tty/serial/8250/8250_port.c                                       |    3 
 drivers/tty/vt/defkeymap.c_shipped                                        |  112 +++
 drivers/tty/vt/keyboard.c                                                 |    2 
 drivers/ufs/host/ufs-exynos.c                                             |    4 
 drivers/ufs/host/ufshcd-pci.c                                             |   42 +
 drivers/usb/atm/cxacru.c                                                  |  106 +-
 drivers/usb/core/hcd.c                                                    |   20 
 drivers/usb/core/quirks.c                                                 |    1 
 drivers/usb/dwc3/dwc3-imx8mp.c                                            |    7 
 drivers/usb/dwc3/dwc3-meson-g12a.c                                        |    3 
 drivers/usb/dwc3/dwc3-pci.c                                               |    2 
 drivers/usb/dwc3/ep0.c                                                    |   20 
 drivers/usb/dwc3/gadget.c                                                 |   19 
 drivers/usb/gadget/udc/renesas_usb3.c                                     |    1 
 drivers/usb/host/xhci-hub.c                                               |    3 
 drivers/usb/host/xhci-mem.c                                               |   22 
 drivers/usb/host/xhci-pci-renesas.c                                       |    7 
 drivers/usb/host/xhci-ring.c                                              |    9 
 drivers/usb/host/xhci.c                                                   |   21 
 drivers/usb/host/xhci.h                                                   |    3 
 drivers/usb/musb/omap2430.c                                               |   14 
 drivers/usb/storage/realtek_cr.c                                          |    2 
 drivers/usb/storage/unusual_devs.h                                        |   29 
 drivers/usb/typec/class.c                                                 |    7 
 drivers/usb/typec/tcpm/fusb302.c                                          |   32 
 drivers/usb/typec/tcpm/maxim_contaminant.c                                |   58 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c                       |    3 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c                  |    3 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c                        |    4 
 drivers/usb/typec/tcpm/tcpci_maxim.h                                      |    1 
 drivers/usb/typec/tcpm/tcpm.c                                             |    7 
 drivers/vhost/vsock.c                                                     |    6 
 drivers/video/console/vgacon.c                                            |    2 
 fs/btrfs/block-group.c                                                    |   59 -
 fs/btrfs/ctree.c                                                          |    9 
 fs/btrfs/free-space-tree.c                                                |   17 
 fs/btrfs/qgroup.c                                                         |   38 -
 fs/btrfs/send.c                                                           |  359 +++++-----
 fs/btrfs/subpage.c                                                        |   19 
 fs/btrfs/super.c                                                          |   13 
 fs/btrfs/transaction.c                                                    |    1 
 fs/btrfs/zoned.c                                                          |   13 
 fs/buffer.c                                                               |    2 
 fs/debugfs/inode.c                                                        |   11 
 fs/ext4/fsmap.c                                                           |   23 
 fs/ext4/indirect.c                                                        |    4 
 fs/ext4/inode.c                                                           |    2 
 fs/ext4/orphan.c                                                          |    5 
 fs/ext4/super.c                                                           |    8 
 fs/f2fs/node.c                                                            |   10 
 fs/file.c                                                                 |   75 --
 fs/jbd2/checkpoint.c                                                      |    1 
 fs/namespace.c                                                            |   34 
 fs/netfs/write_collect.c                                                  |   10 
 fs/netfs/write_issue.c                                                    |    4 
 fs/nfs/pagelist.c                                                         |    9 
 fs/nfs/write.c                                                            |   29 
 fs/overlayfs/copy_up.c                                                    |    2 
 fs/smb/client/smb2ops.c                                                   |    2 
 fs/smb/server/connection.c                                                |    3 
 fs/smb/server/connection.h                                                |    7 
 fs/smb/server/oplock.c                                                    |   13 
 fs/smb/server/transport_rdma.c                                            |    5 
 fs/smb/server/transport_rdma.h                                            |    4 
 fs/smb/server/transport_tcp.c                                             |   26 
 fs/splice.c                                                               |    3 
 fs/squashfs/super.c                                                       |   14 
 fs/xfs/xfs_itable.c                                                       |    6 
 include/drm/drm_format_helper.h                                           |   12 
 include/linux/call_once.h                                                 |   47 -
 include/linux/compiler.h                                                  |    8 
 include/linux/iosys-map.h                                                 |    7 
 include/linux/iov_iter.h                                                  |   20 
 include/linux/kcov.h                                                      |   47 -
 include/linux/mlx5/mlx5_ifc.h                                             |   14 
 include/linux/mlx5/port.h                                                 |   85 --
 include/linux/netfs.h                                                     |    1 
 include/linux/nfs_page.h                                                  |    1 
 include/net/bond_3ad.h                                                    |    1 
 include/uapi/linux/pfrut.h                                                |    1 
 io_uring/futex.c                                                          |    3 
 io_uring/net.c                                                            |   27 
 kernel/cgroup/cpuset.c                                                    |    9 
 kernel/sched/ext.c                                                        |   18 
 kernel/trace/ftrace.c                                                     |   19 
 kernel/trace/trace.c                                                      |   34 
 kernel/trace/trace.h                                                      |   10 
 mm/damon/paddr.c                                                          |    4 
 mm/debug_vm_pgtable.c                                                     |    9 
 mm/filemap.c                                                              |    3 
 mm/memory-failure.c                                                       |    8 
 net/bluetooth/hci_conn.c                                                  |    3 
 net/bluetooth/hci_event.c                                                 |    8 
 net/bluetooth/hci_sync.c                                                  |   19 
 net/bridge/br_multicast.c                                                 |   16 
 net/bridge/br_private.h                                                   |    2 
 net/core/dev.c                                                            |   12 
 net/hsr/hsr_slave.c                                                       |    8 
 net/ipv4/netfilter/nf_reject_ipv4.c                                       |    6 
 net/ipv6/netfilter/nf_reject_ipv6.c                                       |    5 
 net/ipv6/seg6_hmac.c                                                      |    6 
 net/mptcp/options.c                                                       |    6 
 net/mptcp/pm_netlink.c                                                    |   19 
 net/sched/sch_cake.c                                                      |   14 
 net/sched/sch_htb.c                                                       |    2 
 net/smc/af_smc.c                                                          |    3 
 net/tls/tls_sw.c                                                          |    7 
 net/vmw_vsock/virtio_transport.c                                          |   12 
 rust/kernel/alloc/allocator.rs                                            |   30 
 rust/kernel/alloc/allocator_test.rs                                       |   11 
 security/apparmor/lsm.c                                                   |    4 
 sound/core/timer.c                                                        |    4 
 sound/pci/hda/patch_realtek.c                                             |    2 
 sound/soc/sof/amd/acp-loader.c                                            |    6 
 sound/usb/stream.c                                                        |    2 
 sound/usb/validate.c                                                      |    2 
 tools/testing/selftests/net/mptcp/pm_netlink.sh                           |    1 
 341 files changed, 3787 insertions(+), 2216 deletions(-)

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Fix default runtime and system PM levels

Al Viro (2):
      use uniform permission checks for all mount propagation changes
      alloc_fdtable(): change calling conventions.

Alex Deucher (4):
      drm/amdgpu/discovery: fix fw based ip discovery
      drm/amdgpu: update mmhub 3.0.1 client id mappings
      drm/amdgpu: update mmhub 4.1.0 client id mappings
      drm/amdgpu/swm14: Update power limit logic

Alexander Sverdlin (1):
      arm64: dts: ti: k3-pinctrl: Enable Schmitt Trigger by default

Alexander Wilhelm (1):
      bus: mhi: host: Fix endianness of BHI vector table

Alexei Lazar (1):
      net/mlx5e: Query FW for buffer ownership

Amber Lin (1):
      drm/amdkfd: Destroy KFD debugfs after destroy KFD wq

Amit Sunil Dhamne (2):
      usb: typec: maxim_contaminant: disable low power mode when reading comparator values
      usb: typec: maxim_contaminant: re-enable cc toggle if cc is open and port is clean

Anantha Prabhu (1):
      RDMA/bnxt_re: Fix to initialize the PBL array

Andrea Righi (2):
      sched/ext: Fix invalid task state transitions on class switch
      sched_ext: initialize built-in idle state before ops.init()

Andreas Dilger (1):
      ext4: check fast symlink for ea_inode correctly

André Draszik (1):
      scsi: ufs: exynos: Fix programming of HCI_UTRL_NEXUS_TYPE

Andy Shevchenko (1):
      iio: imu: inv_icm42600: Convert to uXX and sXX integer types

Archana Patni (1):
      scsi: ufs: ufs-pci: Fix hibernate state transition for Intel MTL-like host controllers

Armen Ratner (1):
      net/mlx5e: Preserve shared buffer capacity during headroom updates

Baihan Li (3):
      drm/hisilicon/hibmc: refactored struct hibmc_drm_private
      drm/hisilicon/hibmc: fix the i2c device resource leak when vdac init failed
      drm/hisilicon/hibmc: fix the hibmc loaded failed bug

Baokun Li (2):
      jbd2: prevent softlockup in jbd2_log_do_checkpoint()
      ext4: preserve SB_I_VERSION on remount

Bharat Bhushan (3):
      crypto: octeontx2 - Fix address alignment issue on ucode loading
      crypto: octeontx2 - Fix address alignment on CN10K A0/A1 and OcteonTX2
      crypto: octeontx2 - Fix address alignment on CN10KB and CN10KA-B0

Bibo Mao (1):
      LoongArch: KVM: Make function kvm_own_lbt() robust

Bingbu Cao (1):
      media: hi556: correct the test pattern configuration

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Ensure we don't read past the ELF header

Boris Burkov (2):
      btrfs: explicitly ref count block_group on new_bgs list
      btrfs: codify pattern for adding block_group to bg_list

Boshi Yu (1):
      RDMA/erdma: Fix ignored return value of init_kernel_qp

Chao Yu (1):
      f2fs: fix to avoid out-of-boundary access in dnode page

Charalampos Mitrodimas (1):
      debugfs: fix mount options not being applied

Chen Yu (1):
      ACPI: pfr_update: Fix the driver update version check

Chenyuan Yang (1):
      drm/amd/display: Add null pointer check in mod_hdcp_hdcp1_create_session()

Chi Zhiling (1):
      readahead: fix return value of page_cache_next_miss() when no hole is found

Christian Loehle (1):
      cpuidle: menu: Remove iowait influence

Christoph Hellwig (1):
      xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags

Christoph Paasch (1):
      mptcp: drop skb if MPTCP skb extension allocation fails

D. Wythe (1):
      net/smc: fix UAF on smcsk after smc_listen_out()

Damien Le Moal (7):
      ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
      dm: dm-crypt: Do not partially accept write BIOs with zoned targets
      dm: Check for forbidden splitting of zone write operations
      ata: libata-scsi: Fix ata_to_sense_error() status handling
      PCI: endpoint: Fix configfs group list head handling
      PCI: endpoint: Fix configfs group removal on driver teardown
      ata: libata-scsi: Return aborted command when missing sense and result TF

Dan Carpenter (5):
      cpufreq: armada-8k: Fix off by one in armada_8k_cpufreq_free_table()
      media: gspca: Add bounds checking to firmware parser
      soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()
      scsi: qla4xxx: Prevent a potential error pointer dereference
      ALSA: usb-audio: Fix size validation in convert_chmap_v3()

Daniel Jurgens (1):
      net/mlx5: Base ECVF devlink port attrs from 0

Danilo Krummrich (1):
      rust: alloc: replace aligned_size() with Kmalloc::aligned_layout()

David Howells (2):
      netfs: Fix unbuffered write error handling
      cifs: Fix oops due to uninitialised variable

David Lechner (6):
      iio: imu: bno055: fix OOB access of hw_xlate array
      iio: adc: ad_sigma_delta: change to buffer predisable
      iio: adc: ad7173: fix setting ODR in probe
      iio: proximity: isl29501: fix buffered read on big-endian systems
      iio: temperature: maxim_thermocouple: use DMA-safe buffer for spi_read()
      iio: imu: inv_icm42600: use = { } instead of memset()

David Sterba (2):
      btrfs: qgroup: drop unused parameter fs_info from __del_qgroup_rb()
      btrfs: move transaction aborts to the error site in add_block_group_free_space()

Dewei Meng (1):
      ALSA: timer: fix ida_free call while not allocated

Dominique Martinet (1):
      iov_iter: iterate_folioq: fix handling of offset >= folio size

Edward Adam Davis (1):
      comedi: pcl726: Prevent invalid irq number

Emanuele Ghidoli (1):
      arm64: dts: ti: k3-am62-verdin: Enable pull-ups on I2C buses

Eric Biggers (2):
      lib/crypto: mips/chacha: Fix clang build and remove unneeded byteswap
      ipv6: sr: Fix MAC comparison to be constant-time

Evgeniy Harchenko (1):
      ALSA: hda/realtek: Add support for HP EliteBook x360 830 G6 and EliteBook 830 G6

Fanhua Li (1):
      drm/nouveau/nvif: Fix potential memory leak in nvif_vmm_ctor().

Filipe Manana (10):
      btrfs: qgroup: fix race between quota disable and quota rescan ioctl
      btrfs: always abort transaction on failure to add block group to free space tree
      btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()
      btrfs: send: factor out common logic when sending xattrs
      btrfs: send: only use boolean variables at process_recorded_refs()
      btrfs: send: add and use helper to rename current inode when processing refs
      btrfs: send: keep the current inode's path cached
      btrfs: send: avoid path allocation for the current inode when issuing commands
      btrfs: send: use fallocate for hole punching with send stream v2
      btrfs: send: make fs_path_len() inline and constify its argument

Finn Thain (1):
      m68k: Fix lost column on framebuffer debug console

Florian Westphal (1):
      netfilter: nf_reject: don't leak dst refcount for loopback packets

Frank Li (1):
      PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support

Gabor Juhos (1):
      mtd: spinand: propagate spinand_wait() errors from spinand_write_page()

Gang Ba (1):
      drm/amdgpu: Avoid extra evict-restore process.

Geliang Tang (2):
      mptcp: remove duplicate sk_reset_timer call
      mptcp: disable add_addr retransmission when timeout is 0

Geraldo Nascimento (2):
      PCI: rockchip: Use standard PCIe definitions
      PCI: rockchip: Set Target Link Speed to 5.0 GT/s before retraining

Giovanni Cabiddu (2):
      crypto: qat - lower priority for skcipher and aead algorithms
      crypto: qat - flush misc workqueue during device shutdown

Greg Kroah-Hartman (2):
      Revert "can: ti_hecc: fix -Woverflow compiler warning"
      Linux 6.12.44

Gui-Dong Han (1):
      media: rainshadow-cec: fix TOCTOU race condition in rain_interrupt()

Hangbin Liu (2):
      bonding: update LACP activity flag after setting lacp_active
      bonding: send LACPDUs periodically in passive mode after receiving partner's LACPDU

Hans Verkuil (1):
      media: vivid: fix wrong pixel_array control size

Hans de Goede (1):
      media: ivsc: Fix crash at shutdown due to missing mei_cldev_disable() calls

Haoxiang Li (1):
      media: imx: fix a potential memory leak in imx_media_csc_scaler_device_init()

Hariprasad Kelam (1):
      Octeontx2-af: Skip overlap check for SPI field

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Wildcat Lake

Heiko Carstens (1):
      s390/mm: Do not map lowcore with identity mapping

Helge Deller (2):
      Revert "vgacon: Add check for vc_origin address range in vgacon_scroll()"
      apparmor: Fix 8-byte alignment for initial dfa blob streams

Herton R. Krzesinski (1):
      mm/debug_vm_pgtable: clear page table entries at destroy_args()

Hong Guan (1):
      arm64: dts: ti: k3-am62a7-sk: fix pinmux for main_uart1

Horatiu Vultur (1):
      phy: mscc: Fix timestamping for vsc8584

Ian Abbott (2):
      comedi: Make insn_rw_emulate_bits() do insn->n samples
      comedi: Fix use of uninitialized memory in do_insn_ioctl() and do_insnlist_ioctl()

Ido Schimmel (1):
      mlxsw: spectrum: Forward packets with an IPv4 link-local source IP

Igor Pylypiv (1):
      ata: libata-scsi: Fix CDL control

Imre Deak (3):
      drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS
      drm/i915/icl+/tc: Convert AUX powered WARN to a debug message
      drm/i915/icl+/tc: Cache the max lane count value

Jacopo Mondi (1):
      media: pisp_be: Fix pm_runtime underrun in probe

Jakub Acs (1):
      net, hsr: reject HSR frame if skb can't hold tag

Jakub Kicinski (1):
      tls: fix handling of zero-length records on the rx_list

Jakub Ramaseuski (1):
      net: gso: Forbid IPv6 TSO with extensions on devices with only IPV6_CSUM

Jan Beulich (1):
      compiler: remove __ADDRESSABLE_ASM{_STR,}() again

Jason Xing (1):
      ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: change invalid data error to -EBUSY

Jens Axboe (2):
      io_uring/net: commit partial buffers on retry
      io_uring/futex: ensure io_futex_wait() cleans up properly on failure

Jiande Lu (1):
      Bluetooth: btmtk: Fix wait_on_bit_timeout interruption during shutdown

Jiayi Li (1):
      memstick: Fix deadlock by moving removing flag earlier

Jinjiang Tu (1):
      mm/memory-failure: fix infinite UCE for VM_PFNMAP pfn

Jocelyn Falempe (1):
      drm/panic: Move drawing functions to drm_draw

Johan Hovold (10):
      usb: gadget: udc: renesas_usb3: fix device leak at unbind
      usb: musb: omap2430: fix device leak at unbind
      usb: dwc3: meson-g12a: fix device leaks at unbind
      usb: dwc3: imx8mp: fix device leak at unbind
      wifi: ath12k: fix dest ring-buffer corruption
      wifi: ath12k: fix source ring-buffer corruption
      wifi: ath12k: fix dest ring-buffer corruption when ring is full
      wifi: ath11k: fix dest ring-buffer corruption
      wifi: ath11k: fix source ring-buffer corruption
      wifi: ath11k: fix dest ring-buffer corruption when ring is full

John David Anglin (8):
      parisc: Check region is readable by user in raw_copy_from_user()
      parisc: Define and use set_pte_at()
      parisc: Drop WARN_ON_ONCE() from flush_cache_vmap
      parisc: Rename pte_needs_flush() to pte_needs_cache_flush() in cache.c
      parisc: Revise __get_user() to probe user read access
      parisc: Revise gateway LWS calls to probe user read access
      parisc: Try to fixup kernel exception in bad_area_nosemaphore path of do_page_fault()
      parisc: Update comments in make_insert_tlb

John Ernberg (1):
      crypto: caam - Prevent crash on suspend with iMX8QM / iMX8ULP

Jon Hunter (1):
      soc/tegra: pmc: Ensure power-domains are in a known state

Jonathan Cameron (3):
      iio: light: Use aligned_s64 instead of open coding alignment.
      iio: light: as73211: Ensure buffer holes are zeroed
      iio: imu: inv_icm42600: switch timestamp type from int64_t __aligned(8) to aligned_s64

Jordan Rhee (1):
      gve: prevent ethtool ops after shutdown

Jorge Ramirez-Ortiz (2):
      media: venus: hfi: explicitly release IRQ during teardown
      media: venus: protect against spurious interrupts during probe

José Expósito (2):
      drm/tests: Fix endian warning
      drm/tests: Fix drm_test_fb_xrgb8888_to_xrgb2101010() on big-endian

Judith Mendez (6):
      arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support
      arm64: dts: ti: k3-am6*: Add boot phase flag to support MMC boot
      arm64: dts: ti: k3-am62*: Add non-removable flag for eMMC
      arm64: dts: ti: k3-am6*: Remove disable-wp for eMMC
      arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file
      mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1

Junxian Huang (1):
      RDMA/hns: Fix dip entries leak on devices newer than hip09

Justin Lai (1):
      rtase: Fix Rx descriptor CRC error bit definition

Kalesh AP (1):
      RDMA/bnxt_re: Fix a possible memory leak in the driver

Kanglong Wang (1):
      LoongArch: Optimize module load time by optimizing PLT/GOT counting

Kashyap Desai (2):
      RDMA/bnxt_re: Fix to do SRQ armena by default
      RDMA/bnxt_re: Fix to remove workload check in SRQ limit path

Kathiravan Thirumoorthy (1):
      phy: qcom: phy-qcom-m31: Update IPQ5332 M31 USB phy initialization sequence

Kees Cook (1):
      iommu/amd: Avoid stack buffer overflow from kernel cmdline

Keith Busch (1):
      kvm: retry nx_huge_page_recovery_thread creation

Kerem Karabay (1):
      drm/format-helper: Add conversion from XRGB8888 to BGR888

Konrad Dybcio (1):
      media: venus: Fix MSM8998 frequency table

Krzysztof Kozlowski (3):
      dt-bindings: display: sprd,sharkl3-dpu: Fix missing clocks constraints
      dt-bindings: display: sprd,sharkl3-dsi-host: Fix missing clocks constraints
      USB: typec: Use str_enable_disable-like helpers

Kuen-Han Tsai (1):
      usb: dwc3: Ignore late xferNotReady event to prevent halt timeout

Kyoji Ogasawara (3):
      btrfs: fix incorrect log message for nobarrier mount option
      btrfs: restore mount option info messages during mount
      btrfs: fix printing of mount info messages for NODATACOW/NODATASUM

Laurentiu Mihalcea (1):
      pwm: imx-tpm: Reset counter if CMOD is 0

Liao Yuanhong (1):
      ext4: use kmalloc_array() for array space allocation

Lijo Lazar (1):
      drm/amdgpu: Update external revid for GC v9.5.0

Ludwig Disterhof (1):
      media: usbtv: Lock resolution while streaming

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix scan state after PA Sync has been established

Lukas Wunner (1):
      PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix HSR and switch offload Enablement during firwmare reload.

Macpaul Lin (1):
      scsi: dt-bindings: mediatek,ufs: Add ufs-disable-mcq flag for UFS host

Mael GUERIN (1):
      USB: storage: Add unusual-devs entry for Novatek NTK96550-based camera

Marek Szyprowski (1):
      zynq_fpga: use sgtable-based scatterlist wrappers

Marek Vasut (1):
      usb: renesas-xhci: Fix External ROM access timeouts

Mario Limonciello (2):
      drm/amd: Restore cached power limit during resume
      drm/amd/display: Avoid a NULL pointer dereference

Masami Hiramatsu (Google) (1):
      tracing: fprobe-event: Sanitize wildcard for fprobe event name

Mathis Foerst (1):
      media: mt9m114: Fix deadlock in get_frame_interval/set_frame_interval

Matthieu Baerts (NGI0) (2):
      mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
      selftests: mptcp: pm: check flush doesn't reset limits

Miao Li (1):
      usb: quirks: Add DELAY_INIT quick for another SanDisk 3.2Gen1 Flash Drive

Miaoqian Lin (1):
      most: core: Drop device reference after usage in get_channel()

Michael Walle (1):
      mtd: spi-nor: Fix spi_nor_try_unlock_all()

Michal Suchanek (1):
      powerpc/boot: Fix build with gcc 15

Michel Dänzer (1):
      drm/amd/display: Add primary plane to commits for correct VRR handling

Miguel Ojeda (1):
      rust: alloc: fix `rusttest` by providing `Cmalloc::aligned_layout` too

Mike Christie (1):
      scsi: core: Fix command pass through retry regression

Minhong He (1):
      ipv6: sr: validate HMAC algorithm ID in seg6_hmac_info_add

Muhammad Usama Anjum (1):
      ASoC: SOF: amd: acp-loader: Use GFP_KERNEL for DMA allocations in resume context

Myrrh Periwinkle (2):
      vt: keyboard: Don't process Unicode characters in K_OFF mode
      vt: defkeymap: Map keycodes above 127 to K_HOLE

Namjae Jeon (1):
      ksmbd: extend the connection limiting mechanism to support IPv6

Naohiro Aota (3):
      btrfs: zoned: fix write time activation failure for metadata block group
      btrfs: zoned: requeue to unused block group list if zone finish failed
      btrfs: subpage: keep TOWRITE tag until folio is cleaned

Nathan Chancellor (3):
      usb: atm: cxacru: Merge cxacru_upload_firmware() into cxacru_heavy_init()
      wifi: brcmsmac: Remove const from tbl_ptr parameter in wlc_lcnphy_common_read_table()
      drm/amdgpu: Initialize data to NULL in imu_v12_0_program_rlc_ram()

NeilBrown (1):
      ovl: use I_MUTEX_PARENT when locking parent in ovl_create_temp()

Nicolas Dufresne (1):
      media: verisilicon: Fix AV1 decoder clock frequency

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters decrement

Nitin Gote (1):
      iosys-map: Fix undefined behavior in iosys_map_clear()

Ojaswin Mujoo (2):
      ext4: fix fsmap end of range reporting with bigalloc
      ext4: fix reserved gdt blocks handling in fsmap

Oren Sidi (1):
      net/mlx5: Add IFC bits and enums for buf_ownership

Parthiban Veerasooran (2):
      microchip: lan865x: fix missing netif_start_queue() call on device open
      microchip: lan865x: fix missing Timer Increment config for Rev.B0/B1

Pauli Virtanen (1):
      Bluetooth: hci_event: fix MTU for BN == 0 in CIS Established

Peter Griffin (1):
      arm64: dts: exynos: gs101: ufs: add dma-coherent property

Peter Oberparleiter (3):
      s390/sclp: Fix SCCB present check
      s390/hypfs: Avoid unnecessary ioctl registration in debugfs
      s390/hypfs: Enable limited access during lockdown

Peter Shkenev (1):
      drm/amdgpu: check if hubbub is NULL in debugfs/amdgpu_dm_capabilities

Phillip Lougher (1):
      squashfs: fix memory leak in squashfs_fill_super

Pu Lehui (1):
      tracing: Limit access to parser->buffer when trace_get_user failed

Qingfang Deng (2):
      net: ethernet: mtk_ppe: add RCU lock around dev_fill_forward_path
      ppp: fix race conditions in ppp_fill_forward_path

Rafael J. Wysocki (2):
      PM: runtime: Take active children into account in pm_runtime_get_if_in_use()
      cpuidle: governors: menu: Avoid selecting states with too much latency

Randy Dunlap (1):
      parisc: Makefile: explain that 64BIT requires both 32-bit and 64-bit compilers

Ranjan Kumar (3):
      scsi: mpi3mr: Fix race between config read submit and interrupt completion
      scsi: mpi3mr: Drop unnecessary volatile from __iomem pointers
      scsi: mpi3mr: Serialize admin queue BAR writes on 32-bit systems

Ricardo Ribalda (2):
      media: venus: vdec: Clamp param smaller than 1fps and bigger than 240.
      media: venus: venc: Clamp param smaller than 1fps and bigger than 240

Richard Zhu (4):
      PCI: imx6: Add IMX8MM_EP and IMX8MP_EP fixed 256-byte BAR 4 in epc_features
      PCI: imx6: Remove apps_reset toggling from imx_pcie_{assert/deassert}_core_reset
      PCI: imx6: Delay link start until configfs 'start' written
      PCI: imx6: Add IMX8MQ_EP third 64-bit BAR in epc_features

Sakari Ailus (2):
      media: ipu6: isys: Use correct pads for xlate_streams()
      media: v4l2-ctrls: Don't reset handler's error in v4l2_ctrl_handler_free()

Salah Triki (1):
      iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()

Sebastian Andrzej Siewior (1):
      kcov, usb: Don't disable interrupts in kcov_remote_start_usb_softirq()

Sebastian Reichel (1):
      usb: typec: fusb302: cache PD RX state

Selvarasu Ganesan (1):
      usb: dwc3: Remove WARN_ON for device endpoint command timeouts

SeongJae Park (1):
      mm/damon/ops-common: ignore migration request to invalid nodes

Sergey Shtylyov (1):
      Bluetooth: hci_conn: do return error from hci_enhanced_setup_sync()

Shahar Shitrit (1):
      net/mlx5: Relocate function declarations from port.h to mlx5_core.h

Simon Richter (1):
      Mark xe driver as BROKEN if kernel page size is not 4kB

Siyang Liu (1):
      drm/amd/display: fix a Null pointer dereference vulnerability

Srinivas Pandruvada (1):
      platform/x86/intel-uncore-freq: Check write blocked for ELC

Stefan Metzmacher (1):
      smb: server: split ksmbd_rdma_stop_listening() out of ksmbd_rdma_destroy()

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Clamp too high speed_hz

Steven Rostedt (2):
      ftrace: Also allocate and copy hash for reading of filter files
      tracing: Remove unneeded goto out logic

Suraj Gupta (1):
      net: xilinx: axienet: Fix RX skb ring management in DMAengine mode

Takashi Iwai (1):
      ALSA: usb-audio: Use correct sub-type for UAC3 feature unit validation

Theodore Ts'o (1):
      ext4: don't try to clear the orphan_present feature block device is r/o

Thomas Fourier (2):
      mtd: rawnand: fsmc: Add missing check after DMA map
      mtd: rawnand: renesas: Add missing check after DMA map

Thomas Weißschuh (1):
      kbuild: userprogs: use correct linker when mixing clang and GNU ld

Thomas Zimmermann (3):
      drm/format-helper: Move helpers for pixel conversion to header file
      drm/format-helper: Add generic conversion to 32-bit formats
      drm/tests: Do not use drm_fb_blit() in format-helper tests

Thorsten Blum (3):
      accel/habanalabs/gaudi2: Use kvfree() for memory allocated with kvcalloc()
      cdx: Fix off-by-one error in cdx_rpmsg_probe()
      usb: storage: realtek_cr: Use correct byte order for bcs->Residue

Tianxiang Peng (1):
      x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper

Tim Harvey (1):
      hwmon: (gsc-hwmon) fix fan pwm setpoint show functions

Timur Kristóf (7):
      drm/amd/display: Don't overwrite dce60_clk_mgr
      drm/amd/display: Don't overclock DCE 6 by 15%
      drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3
      drm/amd/display: Fix DP audio DTO1 clock source on DCE 6.
      drm/amd/display: Find first CRTC and its line time in dce110_fill_display_configs
      drm/amd/display: Fill display clock and vblank time in dce110_fill_display_configs
      drm/amd/display: Don't print errors for nonexistent connectors

Tom Chung (1):
      drm/amd/display: Fix Xorg desktop unresponsive on Replay panel

Tom Lendacky (1):
      x86/sev: Ensure SVSM reserved fields in a page validation entry are initialized to zero

Tristram Ha (1):
      net: dsa: microchip: Fix KSZ9477 HSR port setup issue

Trond Myklebust (1):
      NFS: Fix a race when updating an existing write

Tzung-Bi Shih (1):
      platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()

Uwe Kleine-König (2):
      pwm: mediatek: Handle hardware enable and clock enable separately
      pwm: mediatek: Fix duty and period setting

ValdikSS (1):
      igc: fix disabling L1.2 PCI-E link substate on I226 on init

Vedang Nagar (1):
      media: venus: Add a check for packet size after reading from shared memory

Victor Shih (3):
      mmc: sdhci-pci-gli: Add a new function to simplify the code
      mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
      mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for consistency

Vladimir Zapolskiy (1):
      media: qcom: camss: cleanup media device allocated resource on error path

Waiman Long (2):
      cgroup/cpuset: Use static_branch_enable_cpuslocked() on cpusets_insane_config_key
      cgroup/cpuset: Fix a partition error with CPU hotplug

Wang Liang (1):
      net: bridge: fix soft lockup in br_multicast_query_expired()

Weitao Wang (1):
      usb: xhci: Fix slot_id resource race conflict

Will Deacon (2):
      vsock/virtio: Validate length in packet header before skb_put()
      vhost/vsock: Avoid allocating arbitrarily-sized SKBs

William Liu (2):
      net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit
      net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate

Xaver Hugl (1):
      amdgpu/amdgpu_discovery: increase timeout limit for IFWI init

Xu Yang (1):
      usb: core: hcd: fix accessing unmapped memory in SINGLE_STEP_SET_FEATURE test

Xu Yilun (1):
      fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()

Yang Li (1):
      Bluetooth: hci_sync: Prevent unintended PA sync when SID is 0xFF

Ye Bin (1):
      fs/buffer: fix use-after-free when call bh_read() helper

Youssef Samir (1):
      bus: mhi: host: Detect events pointing to unexpected TREs

Yuichiro Tsuji (1):
      net: usb: asix_devices: Fix PHY address mask in MDIO bus initialization

Yunhui Cui (1):
      serial: 8250: fix panic due to PSLVERR

Zenm Chen (1):
      USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles

Zhang Shurong (1):
      media: ov2659: Fix memory leaks in ov2659_probe()

Zhang Yi (1):
      ext4: fix hole length calculation overflow in non-extent inodes

Zhu Yanjun (1):
      RDMA/rxe: Flush delayed SKBs while releasing RXE resources

Ziyan Xu (1):
      ksmbd: fix refcount leak causing resource not released

wenglianfa (1):
      RDMA/hns: Fix querying wrong SCC context for DIP algorithm


