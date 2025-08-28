Return-Path: <stable+bounces-176626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3D1B3A24D
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C447C1012
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BA0314A7A;
	Thu, 28 Aug 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNXEIE9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F6314A80;
	Thu, 28 Aug 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392012; cv=none; b=mbdfl5ugUmpmeKNKVu6n4jNzSCy3rJAVWprukbbUswE1f1xnNv1ewBbi0ya7bOCgjq8wdUj4L25/ctvQiVUOihebNWt2EfZGXG3pr9xZZzt68x393+hVPf04bgcRdaMNAp08Ke0E3q1UYqiSHeFpIKZsklWTbYeezKzHtdHmOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392012; c=relaxed/simple;
	bh=mTyAtN3m8FL9on9Zsy/eSEFneawPN97EIVHQHJPvjaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PjjibQabSzs4g4tWk3xTuzptWW166H9UZvU8doG5/oZZpWCyI7VGVqnP+2w1V6ZrAUkexHGC+ILDYtGETUgRZwNw6rNBxIWITgs7EXx9c7WNZLYeltz89XbwDN6QkHgAOUZE7PDhmUImE5lSHXoUflm6vBjy9ML2eO8zr4DMT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KNXEIE9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A484BC4CEEB;
	Thu, 28 Aug 2025 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756392012;
	bh=mTyAtN3m8FL9on9Zsy/eSEFneawPN97EIVHQHJPvjaM=;
	h=From:To:Cc:Subject:Date:From;
	b=KNXEIE9rGehAos1w/Ygn5mjsqZl1BJO86niRL/HW4WytZn6j2SnN74tOBdSdy2IZ0
	 fKgZiyZryQ30dV0RdrcIta0IpV0y6B0GWIaazrB1A9WccZo0S3qIcRL86bOKvWBz/z
	 0in1GNyjCo5k+mayooxUHm2uxjn89HQG/0nbOwiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.103
Date: Thu, 28 Aug 2025 16:39:55 +0200
Message-ID: <2025082855-perennial-slaw-c07a@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.103 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml      |    2 
 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml |    2 
 Documentation/filesystems/fscrypt.rst                                     |   37 -
 Documentation/firmware-guide/acpi/i2c-muxes.rst                           |    8 
 Documentation/networking/bonding.rst                                      |   12 
 Documentation/networking/mptcp-sysctl.rst                                 |    2 
 Documentation/power/runtime_pm.rst                                        |    5 
 Makefile                                                                  |    4 
 arch/arm/include/asm/topology.h                                           |    1 
 arch/arm/mach-rockchip/platsmp.c                                          |   15 
 arch/arm/mach-tegra/reset.c                                               |    2 
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                                  |    1 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                                |   12 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                   |    4 
 arch/arm64/boot/dts/ti/k3-pinctrl.h                                       |   15 
 arch/arm64/include/asm/acpi.h                                             |    2 
 arch/arm64/include/asm/topology.h                                         |    1 
 arch/arm64/kernel/fpsimd.c                                                |    4 
 arch/arm64/kernel/topology.c                                              |   26 
 arch/arm64/kernel/traps.c                                                 |    1 
 arch/arm64/mm/fault.c                                                     |    1 
 arch/arm64/mm/ptdump_debugfs.c                                            |    3 
 arch/loongarch/kernel/module-sections.c                                   |   36 -
 arch/loongarch/net/bpf_jit.c                                              |   21 
 arch/m68k/kernel/head.S                                                   |   31 
 arch/mips/crypto/chacha-core.S                                            |   20 
 arch/mips/include/asm/vpe.h                                               |    8 
 arch/mips/kernel/process.c                                                |   16 
 arch/mips/lantiq/falcon/sysctrl.c                                         |   23 
 arch/parisc/Makefile                                                      |    6 
 arch/parisc/include/asm/pgtable.h                                         |    7 
 arch/parisc/include/asm/special_insns.h                                   |   28 
 arch/parisc/include/asm/uaccess.h                                         |   21 
 arch/parisc/kernel/cache.c                                                |    6 
 arch/parisc/kernel/entry.S                                                |   17 
 arch/parisc/kernel/syscall.S                                              |   30 
 arch/parisc/lib/memcpy.c                                                  |   19 
 arch/parisc/mm/fault.c                                                    |    4 
 arch/powerpc/boot/Makefile                                                |    1 
 arch/powerpc/include/asm/floppy.h                                         |    5 
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c                             |    6 
 arch/riscv/include/asm/topology.h                                         |    1 
 arch/s390/hypfs/hypfs_dbfs.c                                              |   19 
 arch/s390/include/asm/timex.h                                             |   13 
 arch/s390/kernel/time.c                                                   |    2 
 arch/s390/mm/dump_pagetables.c                                            |    2 
 arch/s390/mm/pgalloc.c                                                    |    5 
 arch/um/include/asm/thread_info.h                                         |    4 
 arch/um/kernel/process.c                                                  |   20 
 arch/x86/include/asm/kvm-x86-ops.h                                        |    2 
 arch/x86/include/asm/kvm_host.h                                           |   22 
 arch/x86/include/asm/msr-index.h                                          |    1 
 arch/x86/include/asm/xen/hypercall.h                                      |    5 
 arch/x86/kernel/cpu/bugs.c                                                |    5 
 arch/x86/kernel/cpu/hygon.c                                               |    3 
 arch/x86/kvm/hyperv.c                                                     |    3 
 arch/x86/kvm/lapic.c                                                      |   19 
 arch/x86/kvm/lapic.h                                                      |    1 
 arch/x86/kvm/svm/svm.c                                                    |   42 -
 arch/x86/kvm/svm/vmenter.S                                                |    9 
 arch/x86/kvm/trace.h                                                      |    9 
 arch/x86/kvm/vmx/nested.c                                                 |   26 
 arch/x86/kvm/vmx/pmu_intel.c                                              |    8 
 arch/x86/kvm/vmx/vmx.c                                                    |  164 ++--
 arch/x86/kvm/vmx/vmx.h                                                    |   31 
 arch/x86/kvm/x86.c                                                        |   46 -
 block/blk-core.c                                                          |   26 
 block/blk-settings.c                                                      |    2 
 crypto/jitterentropy-kcapi.c                                              |    9 
 drivers/acpi/acpi_processor.c                                             |    2 
 drivers/acpi/apei/ghes.c                                                  |   13 
 drivers/acpi/pfr_update.c                                                 |    2 
 drivers/acpi/prmt.c                                                       |   26 
 drivers/acpi/processor_perflib.c                                          |   11 
 drivers/ata/Kconfig                                                       |   35 
 drivers/ata/libata-sata.c                                                 |    5 
 drivers/ata/libata-scsi.c                                                 |   58 -
 drivers/base/arch_topology.c                                              |   69 +
 drivers/base/power/runtime.c                                              |   59 +
 drivers/block/drbd/drbd_receiver.c                                        |    6 
 drivers/block/loop.c                                                      |   38 -
 drivers/block/sunvdc.c                                                    |    4 
 drivers/bus/mhi/host/boot.c                                               |    8 
 drivers/bus/mhi/host/internal.h                                           |    4 
 drivers/bus/mhi/host/main.c                                               |   12 
 drivers/cdx/controller/cdx_rpmsg.c                                        |    3 
 drivers/char/ipmi/ipmi_msghandler.c                                       |    8 
 drivers/char/ipmi/ipmi_watchdog.c                                         |   59 +
 drivers/char/misc.c                                                       |    4 
 drivers/clk/qcom/gcc-ipq5018.c                                            |    2 
 drivers/clk/tegra/clk-periph.c                                            |    4 
 drivers/comedi/comedi_fops.c                                              |   36 -
 drivers/comedi/comedi_internal.h                                          |    1 
 drivers/comedi/drivers.c                                                  |   36 -
 drivers/comedi/drivers/pcl726.c                                           |    3 
 drivers/cpufreq/armada-8k-cpufreq.c                                       |    2 
 drivers/cpufreq/cppc_cpufreq.c                                            |    2 
 drivers/cpufreq/cpufreq.c                                                 |   12 
 drivers/cpuidle/governors/menu.c                                          |   96 --
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                               |    8 
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h                      |    1 
 drivers/crypto/intel/qat/qat_common/adf_init.c                            |    1 
 drivers/crypto/intel/qat/qat_common/adf_isr.c                             |    5 
 drivers/crypto/intel/qat/qat_common/qat_algs.c                            |   12 
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c                       |   16 
 drivers/devfreq/governor_userspace.c                                      |    6 
 drivers/dma/stm32-dma.c                                                   |    2 
 drivers/edac/synopsys_edac.c                                              |   97 +-
 drivers/firmware/tegra/Kconfig                                            |    5 
 drivers/fpga/zynq-fpga.c                                                  |   10 
 drivers/gpio/gpio-mlxbf2.c                                                |    2 
 drivers/gpio/gpio-mlxbf3.c                                                |   54 -
 drivers/gpio/gpio-tps65912.c                                              |    7 
 drivers/gpio/gpio-virtio.c                                                |    9 
 drivers/gpio/gpio-wcd934x.c                                               |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                                   |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                    |    6 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c                                 |   57 -
 drivers/gpu/drm/amd/amdkfd/kfd_module.c                                   |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                         |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                    |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c                     |    6 
 drivers/gpu/drm/amd/display/dc/bios/command_table.c                       |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c                          |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c               |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c            |   40 -
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c              |   31 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                        |   11 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                           |    3 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c                       |    3 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                 |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c                          |   37 -
 drivers/gpu/drm/display/drm_dp_helper.c                                   |    2 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c                           |    4 
 drivers/gpu/drm/i915/intel_runtime_pm.c                                   |    5 
 drivers/gpu/drm/msm/msm_gem.c                                             |    3 
 drivers/gpu/drm/msm/msm_gem.h                                             |    6 
 drivers/gpu/drm/nouveau/nvif/vmm.c                                        |    3 
 drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi.c                          |    3 
 drivers/gpu/drm/ttm/ttm_pool.c                                            |    8 
 drivers/gpu/drm/ttm/ttm_resource.c                                        |    3 
 drivers/hid/hid-apple.c                                                   |   13 
 drivers/hid/hid-magicmouse.c                                              |   56 +
 drivers/hwmon/emc2305.c                                                   |   10 
 drivers/hwmon/gsc-hwmon.c                                                 |    4 
 drivers/i2c/i2c-core-acpi.c                                               |    1 
 drivers/i3c/internals.h                                                   |    1 
 drivers/i3c/master.c                                                      |    4 
 drivers/idle/intel_idle.c                                                 |    2 
 drivers/iio/adc/ad7768-1.c                                                |   23 
 drivers/iio/adc/ad_sigma_delta.c                                          |    6 
 drivers/iio/imu/bno055/bno055.c                                           |   11 
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                               |    8 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                         |   33 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c                        |   22 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h                        |   10 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c                          |    6 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                          |   43 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c                          |   12 
 drivers/iio/light/as73211.c                                               |    2 
 drivers/iio/pressure/bmp280-core.c                                        |    9 
 drivers/iio/proximity/isl29501.c                                          |   16 
 drivers/iio/temperature/maxim_thermocouple.c                              |   26 
 drivers/infiniband/core/nldev.c                                           |   22 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                  |    8 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                                  |   30 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                                  |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                 |    2 
 drivers/infiniband/hw/erdma/erdma_verbs.c                                 |    4 
 drivers/infiniband/hw/hfi1/affinity.c                                     |   44 -
 drivers/infiniband/sw/siw/siw_qp_tx.c                                     |    5 
 drivers/iommu/amd/init.c                                                  |    4 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                |    1 
 drivers/iommu/iommufd/io_pagetable.c                                      |   48 -
 drivers/leds/flash/leds-qcom-flash.c                                      |  178 ++++
 drivers/leds/leds-lp50xx.c                                                |   11 
 drivers/leds/trigger/ledtrig-netdev.c                                     |   16 
 drivers/md/dm-ps-historical-service-time.c                                |    4 
 drivers/md/dm-ps-queue-length.c                                           |    4 
 drivers/md/dm-ps-round-robin.c                                            |    4 
 drivers/md/dm-ps-service-time.c                                           |    4 
 drivers/md/dm-table.c                                                     |   10 
 drivers/md/dm-zoned-target.c                                              |    2 
 drivers/media/cec/usb/rainshadow/rainshadow-cec.c                         |    3 
 drivers/media/dvb-frontends/dib7000p.c                                    |    8 
 drivers/media/i2c/ccs/ccs-core.c                                          |    2 
 drivers/media/i2c/hi556.c                                                 |   26 
 drivers/media/i2c/ov2659.c                                                |    3 
 drivers/media/i2c/tc358743.c                                              |   86 +-
 drivers/media/pci/intel/ivsc/mei_ace.c                                    |    2 
 drivers/media/pci/intel/ivsc/mei_csi.c                                    |    2 
 drivers/media/platform/qcom/camss/camss.c                                 |    4 
 drivers/media/platform/qcom/venus/core.c                                  |    8 
 drivers/media/platform/qcom/venus/core.h                                  |    2 
 drivers/media/platform/qcom/venus/hfi_msgs.c                              |   83 +-
 drivers/media/platform/qcom/venus/hfi_venus.c                             |    5 
 drivers/media/platform/qcom/venus/vdec.c                                  |    5 
 drivers/media/platform/qcom/venus/venc.c                                  |    5 
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c                      |    9 
 drivers/media/test-drivers/vivid/vivid-ctrls.c                            |    3 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                          |    4 
 drivers/media/usb/gspca/vicam.c                                           |   10 
 drivers/media/usb/hdpvr/hdpvr-i2c.c                                       |    6 
 drivers/media/usb/usbtv/usbtv-video.c                                     |    4 
 drivers/media/usb/uvc/uvc_driver.c                                        |    3 
 drivers/media/usb/uvc/uvc_video.c                                         |   21 
 drivers/media/v4l2-core/v4l2-common.c                                     |    8 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                 |    1 
 drivers/memstick/core/memstick.c                                          |    1 
 drivers/memstick/host/rtsx_usb_ms.c                                       |    1 
 drivers/mfd/axp20x.c                                                      |    3 
 drivers/misc/cardreader/rtsx_usb.c                                        |   16 
 drivers/misc/mei/bus.c                                                    |    6 
 drivers/mmc/host/rtsx_usb_sdmmc.c                                         |    4 
 drivers/mmc/host/sdhci-msm.c                                              |   14 
 drivers/mmc/host/sdhci-pci-gli.c                                          |   35 
 drivers/most/core.c                                                       |    2 
 drivers/mtd/nand/raw/fsmc_nand.c                                          |    2 
 drivers/mtd/nand/raw/renesas-nand-controller.c                            |    6 
 drivers/mtd/nand/spi/core.c                                               |    5 
 drivers/mtd/spi-nor/swp.c                                                 |   19 
 drivers/net/bonding/bond_3ad.c                                            |  224 +++++-
 drivers/net/bonding/bond_main.c                                           |    1 
 drivers/net/bonding/bond_netlink.c                                        |   16 
 drivers/net/bonding/bond_options.c                                        |   29 
 drivers/net/dsa/b53/b53_common.c                                          |   65 +
 drivers/net/dsa/b53/b53_regs.h                                            |    2 
 drivers/net/ethernet/agere/et131x.c                                       |   36 +
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h                            |    2 
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c         |   39 +
 drivers/net/ethernet/atheros/ag71xx.c                                     |    9 
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c                         |    4 
 drivers/net/ethernet/emulex/benet/be_main.c                               |    8 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                            |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c                        |    4 
 drivers/net/ethernet/freescale/enetc/enetc_pf.c                           |   14 
 drivers/net/ethernet/freescale/fec_main.c                                 |   34 
 drivers/net/ethernet/freescale/gianfar_ethtool.c                          |    4 
 drivers/net/ethernet/google/gve/gve_adminq.c                              |    1 
 drivers/net/ethernet/google/gve/gve_main.c                                |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                                 |   14 
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c                              |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c                    |    4 
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c                           |    2 
 drivers/net/ethernet/mediatek/mtk_wed.c                                   |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c                  |   18 
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c                          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c                |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                            |    2 
 drivers/net/ethernet/mellanox/mlxsw/trap.h                                |    1 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                           |    7 
 drivers/net/ethernet/ti/icssg/icss_iep.c                                  |   26 
 drivers/net/hyperv/hyperv_net.h                                           |    3 
 drivers/net/hyperv/netvsc_drv.c                                           |   29 
 drivers/net/ipa/ipa_smp2p.c                                               |    2 
 drivers/net/phy/micrel.c                                                  |   12 
 drivers/net/phy/mscc/mscc.h                                               |   12 
 drivers/net/phy/mscc/mscc_main.c                                          |   12 
 drivers/net/phy/mscc/mscc_ptp.c                                           |   49 +
 drivers/net/phy/smsc.c                                                    |    1 
 drivers/net/ppp/ppp_generic.c                                             |   17 
 drivers/net/thunderbolt/main.c                                            |   21 
 drivers/net/usb/asix_devices.c                                            |    1 
 drivers/net/usb/cdc_ncm.c                                                 |   20 
 drivers/net/wireless/ath/ath11k/ce.c                                      |    3 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                   |    3 
 drivers/net/wireless/ath/ath11k/hal.c                                     |   33 
 drivers/net/wireless/ath/ath12k/ce.c                                      |    3 
 drivers/net/wireless/ath/ath12k/dp.c                                      |    3 
 drivers/net/wireless/ath/ath12k/hal.c                                     |   38 -
 drivers/net/wireless/ath/ath12k/hw.c                                      |    2 
 drivers/net/wireless/ath/ath12k/wmi.c                                     |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c            |    2 
 drivers/net/wireless/intel/iwlegacy/4965-mac.c                            |    5 
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c                               |    2 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                               |    7 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                               |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                             |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                           |   25 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                |   23 
 drivers/net/wireless/realtek/rtw89/core.c                                 |    3 
 drivers/net/wireless/realtek/rtw89/fw.c                                   |    9 
 drivers/net/wireless/realtek/rtw89/fw.h                                   |    2 
 drivers/net/wireless/realtek/rtw89/mac.c                                  |   19 
 drivers/net/wireless/realtek/rtw89/reg.h                                  |    1 
 drivers/net/xen-netfront.c                                                |    5 
 drivers/nvme/host/pci.c                                                   |   24 
 drivers/pci/controller/dwc/pci-imx6.c                                     |    7 
 drivers/pci/controller/pcie-rockchip-host.c                               |   49 -
 drivers/pci/controller/pcie-rockchip.h                                    |   11 
 drivers/pci/endpoint/pci-ep-cfs.c                                         |    1 
 drivers/pci/endpoint/pci-epf-core.c                                       |    2 
 drivers/pci/pci-acpi.c                                                    |    4 
 drivers/pci/pci.c                                                         |   10 
 drivers/pci/probe.c                                                       |    2 
 drivers/perf/cxl_pmu.c                                                    |    2 
 drivers/phy/qualcomm/phy-qcom-m31.c                                       |   14 
 drivers/phy/rockchip/phy-rockchip-pcie.c                                  |    3 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                     |    1 
 drivers/platform/chrome/cros_ec.c                                         |    3 
 drivers/platform/chrome/cros_ec_typec.c                                   |    4 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                                 |    9 
 drivers/platform/x86/thinkpad_acpi.c                                      |    4 
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                                     |   10 
 drivers/power/supply/qcom_battmgr.c                                       |    2 
 drivers/pps/clients/pps-gpio.c                                            |    5 
 drivers/ptp/ptp_clock.c                                                   |    2 
 drivers/ptp/ptp_private.h                                                 |    5 
 drivers/ptp/ptp_vclock.c                                                  |    7 
 drivers/pwm/pwm-imx-tpm.c                                                 |    9 
 drivers/pwm/pwm-mediatek.c                                                |   71 +
 drivers/remoteproc/imx_rproc.c                                            |    4 
 drivers/reset/Kconfig                                                     |   10 
 drivers/rtc/rtc-ds1307.c                                                  |   15 
 drivers/s390/char/sclp.c                                                  |   11 
 drivers/scsi/aacraid/comminit.c                                           |    3 
 drivers/scsi/bfa/bfad_im.c                                                |    1 
 drivers/scsi/libiscsi.c                                                   |    3 
 drivers/scsi/lpfc/lpfc_debugfs.c                                          |    1 
 drivers/scsi/lpfc/lpfc_scsi.c                                             |    4 
 drivers/scsi/mpi3mr/mpi3mr.h                                              |    6 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                           |   17 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                           |   22 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                                      |   19 
 drivers/scsi/qla4xxx/ql4_os.c                                             |    2 
 drivers/scsi/scsi_scan.c                                                  |    2 
 drivers/scsi/scsi_transport_sas.c                                         |   60 +
 drivers/soc/qcom/mdt_loader.c                                             |   53 +
 drivers/soc/qcom/rpmh-rsc.c                                               |    2 
 drivers/soc/tegra/pmc.c                                                   |   51 -
 drivers/soundwire/amd_manager.c                                           |    6 
 drivers/soundwire/bus.c                                                   |    6 
 drivers/spi/spi-fsl-lpspi.c                                               |    8 
 drivers/staging/media/imx/imx-media-csc-scaler.c                          |    2 
 drivers/target/target_core_fabric_lib.c                                   |   63 +
 drivers/target/target_core_internal.h                                     |    4 
 drivers/target/target_core_pr.c                                           |   18 
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c                               |   43 -
 drivers/thermal/thermal_sysfs.c                                           |    9 
 drivers/thunderbolt/domain.c                                              |    2 
 drivers/tty/serial/8250/8250_port.c                                       |    3 
 drivers/tty/vt/defkeymap.c_shipped                                        |  112 +++
 drivers/tty/vt/keyboard.c                                                 |    2 
 drivers/ufs/core/ufshcd-priv.h                                            |    2 
 drivers/ufs/host/ufs-exynos.c                                             |    4 
 drivers/ufs/host/ufshcd-pci.c                                             |   42 +
 drivers/usb/atm/cxacru.c                                                  |  106 +-
 drivers/usb/class/cdc-acm.c                                               |   11 
 drivers/usb/core/config.c                                                 |   10 
 drivers/usb/core/hcd.c                                                    |    8 
 drivers/usb/core/quirks.c                                                 |    1 
 drivers/usb/core/urb.c                                                    |    2 
 drivers/usb/dwc3/dwc3-imx8mp.c                                            |    6 
 drivers/usb/dwc3/dwc3-meson-g12a.c                                        |    3 
 drivers/usb/dwc3/dwc3-pci.c                                               |    2 
 drivers/usb/dwc3/ep0.c                                                    |   20 
 drivers/usb/dwc3/gadget.c                                                 |   19 
 drivers/usb/gadget/udc/renesas_usb3.c                                     |    1 
 drivers/usb/host/xhci-hub.c                                               |    3 
 drivers/usb/host/xhci-mem.c                                               |   24 
 drivers/usb/host/xhci-pci-renesas.c                                       |    7 
 drivers/usb/host/xhci-ring.c                                              |   19 
 drivers/usb/host/xhci.c                                                   |   27 
 drivers/usb/host/xhci.h                                                   |    3 
 drivers/usb/musb/omap2430.c                                               |   14 
 drivers/usb/storage/realtek_cr.c                                          |    2 
 drivers/usb/storage/unusual_devs.h                                        |   29 
 drivers/usb/typec/mux/intel_pmc_mux.c                                     |    2 
 drivers/usb/typec/tcpm/fusb302.c                                          |    8 
 drivers/usb/typec/tcpm/maxim_contaminant.c                                |   54 +
 drivers/usb/typec/tcpm/tcpci_maxim.h                                      |    1 
 drivers/usb/typec/ucsi/psy.c                                              |    2 
 drivers/usb/typec/ucsi/ucsi.c                                             |    1 
 drivers/usb/typec/ucsi/ucsi.h                                             |    7 
 drivers/vfio/pci/mlx5/cmd.c                                               |    4 
 drivers/vfio/vfio_iommu_type1.c                                           |    7 
 drivers/vhost/vhost.c                                                     |    3 
 drivers/vhost/vsock.c                                                     |    6 
 drivers/video/console/vgacon.c                                            |    2 
 drivers/video/fbdev/core/fbcon.c                                          |    9 
 drivers/video/fbdev/core/fbmem.c                                          |    3 
 drivers/virt/coco/efi_secret/efi_secret.c                                 |   10 
 drivers/watchdog/dw_wdt.c                                                 |    2 
 drivers/watchdog/iTCO_wdt.c                                               |    6 
 drivers/watchdog/sbsa_gwdt.c                                              |   50 +
 fs/btrfs/backref.c                                                        |    6 
 fs/btrfs/block-group.c                                                    |   61 +
 fs/btrfs/block-group.h                                                    |   11 
 fs/btrfs/block-rsv.c                                                      |    2 
 fs/btrfs/block-rsv.h                                                      |    2 
 fs/btrfs/btrfs_inode.h                                                    |    3 
 fs/btrfs/ctree.c                                                          |   24 
 fs/btrfs/ctree.h                                                          |    6 
 fs/btrfs/delayed-inode.c                                                  |   12 
 fs/btrfs/discard.c                                                        |    4 
 fs/btrfs/extent-tree.c                                                    |   33 
 fs/btrfs/file-item.c                                                      |    4 
 fs/btrfs/file-item.h                                                      |    2 
 fs/btrfs/free-space-tree.c                                                |   17 
 fs/btrfs/inode-item.c                                                     |   10 
 fs/btrfs/inode-item.h                                                     |    4 
 fs/btrfs/inode.c                                                          |   26 
 fs/btrfs/qgroup.c                                                         |   31 
 fs/btrfs/relocation.c                                                     |   19 
 fs/btrfs/send.c                                                           |  359 +++++-----
 fs/btrfs/space-info.c                                                     |   17 
 fs/btrfs/space-info.h                                                     |    6 
 fs/btrfs/tree-log.c                                                       |   72 +-
 fs/btrfs/tree-mod-log.c                                                   |   14 
 fs/btrfs/tree-mod-log.h                                                   |    6 
 fs/btrfs/zoned.c                                                          |   20 
 fs/btrfs/zoned.h                                                          |    4 
 fs/buffer.c                                                               |    2 
 fs/crypto/fscrypt_private.h                                               |   16 
 fs/crypto/hkdf.c                                                          |    2 
 fs/crypto/keysetup.c                                                      |    3 
 fs/crypto/keysetup_v1.c                                                   |    3 
 fs/eventpoll.c                                                            |   60 +
 fs/exfat/dir.c                                                            |   12 
 fs/exfat/fatent.c                                                         |   10 
 fs/exfat/namei.c                                                          |    5 
 fs/exfat/super.c                                                          |   32 
 fs/ext2/inode.c                                                           |   12 
 fs/ext4/fsmap.c                                                           |   23 
 fs/ext4/indirect.c                                                        |    4 
 fs/ext4/inline.c                                                          |   19 
 fs/ext4/inode.c                                                           |    2 
 fs/ext4/mballoc.c                                                         |   67 -
 fs/ext4/orphan.c                                                          |    5 
 fs/ext4/super.c                                                           |    8 
 fs/f2fs/file.c                                                            |   24 
 fs/f2fs/node.c                                                            |   10 
 fs/file.c                                                                 |   90 +-
 fs/gfs2/meta_io.c                                                         |    2 
 fs/hfs/bfind.c                                                            |    3 
 fs/hfs/bnode.c                                                            |   93 ++
 fs/hfs/btree.c                                                            |   57 +
 fs/hfs/extent.c                                                           |    2 
 fs/hfs/hfs_fs.h                                                           |    1 
 fs/hfsplus/bnode.c                                                        |   92 ++
 fs/hfsplus/unicode.c                                                      |    7 
 fs/hfsplus/xattr.c                                                        |    6 
 fs/hugetlbfs/inode.c                                                      |    2 
 fs/jbd2/checkpoint.c                                                      |    1 
 fs/jfs/file.c                                                             |    3 
 fs/jfs/inode.c                                                            |    2 
 fs/jfs/jfs_dmap.c                                                         |    6 
 fs/libfs.c                                                                |    4 
 fs/namespace.c                                                            |   34 
 fs/nfs/blocklayout/blocklayout.c                                          |    4 
 fs/nfs/blocklayout/dev.c                                                  |    5 
 fs/nfs/blocklayout/extent_tree.c                                          |   20 
 fs/nfs/client.c                                                           |   44 +
 fs/nfs/internal.h                                                         |    2 
 fs/nfs/nfs4client.c                                                       |   20 
 fs/nfs/nfs4proc.c                                                         |    2 
 fs/nfs/pnfs.c                                                             |   11 
 fs/nfsd/nfs4state.c                                                       |   34 
 fs/ntfs3/dir.c                                                            |    3 
 fs/ntfs3/inode.c                                                          |   31 
 fs/orangefs/orangefs-debugfs.c                                            |    2 
 fs/smb/client/cifssmb.c                                                   |   10 
 fs/smb/client/connect.c                                                   |   10 
 fs/smb/client/sess.c                                                      |    9 
 fs/smb/client/smb2ops.c                                                   |   11 
 fs/smb/client/smbdirect.c                                                 |   24 
 fs/smb/server/connection.c                                                |    3 
 fs/smb/server/connection.h                                                |    7 
 fs/smb/server/oplock.c                                                    |   13 
 fs/smb/server/smb2pdu.c                                                   |   16 
 fs/smb/server/transport_rdma.c                                            |    5 
 fs/smb/server/transport_rdma.h                                            |    4 
 fs/smb/server/transport_tcp.c                                             |   26 
 fs/squashfs/super.c                                                       |   14 
 fs/tracefs/inode.c                                                        |   11 
 fs/udf/super.c                                                            |   13 
 fs/xfs/xfs_itable.c                                                       |    6 
 include/linux/arch_topology.h                                             |    8 
 include/linux/blk_types.h                                                 |    6 
 include/linux/compiler.h                                                  |    8 
 include/linux/cpufreq.h                                                   |    1 
 include/linux/energy_model.h                                              |    6 
 include/linux/fs.h                                                        |    4 
 include/linux/hypervisor.h                                                |    3 
 include/linux/if_vlan.h                                                   |   21 
 include/linux/iosys-map.h                                                 |    7 
 include/linux/memfd.h                                                     |   14 
 include/linux/mm.h                                                        |   82 +-
 include/linux/pci.h                                                       |   10 
 include/linux/pm_runtime.h                                                |   18 
 include/linux/sched/topology.h                                            |    8 
 include/linux/skbuff.h                                                    |    8 
 include/linux/usb/cdc_ncm.h                                               |    1 
 include/linux/virtio_vsock.h                                              |    7 
 include/net/bond_3ad.h                                                    |    3 
 include/net/bond_options.h                                                |    1 
 include/net/bonding.h                                                     |   23 
 include/net/cfg80211.h                                                    |    2 
 include/net/mac80211.h                                                    |    2 
 include/net/neighbour.h                                                   |    1 
 include/net/net_namespace.h                                               |   16 
 include/net/sock.h                                                        |    1 
 include/trace/events/btrfs.h                                              |    6 
 include/trace/events/thp.h                                                |    2 
 include/uapi/linux/if_link.h                                              |    1 
 include/uapi/linux/in6.h                                                  |    4 
 include/uapi/linux/io_uring.h                                             |    2 
 include/uapi/linux/pfrut.h                                                |    1 
 io_uring/net.c                                                            |   19 
 kernel/bpf/verifier.c                                                     |    3 
 kernel/cgroup/cpuset.c                                                    |    2 
 kernel/fork.c                                                             |    2 
 kernel/module/main.c                                                      |   10 
 kernel/power/console.c                                                    |    7 
 kernel/rcu/tree.c                                                         |    2 
 kernel/rcu/tree.h                                                         |   14 
 kernel/rcu/tree_plugin.h                                                  |   44 -
 kernel/sched/cpufreq_schedutil.c                                          |   30 
 kernel/sched/fair.c                                                       |   19 
 kernel/trace/ftrace.c                                                     |   19 
 kernel/trace/trace.c                                                      |   33 
 kernel/trace/trace.h                                                      |   10 
 mm/debug_vm_pgtable.c                                                     |    9 
 mm/filemap.c                                                              |    2 
 mm/kmemleak.c                                                             |   10 
 mm/madvise.c                                                              |    2 
 mm/memfd.c                                                                |    2 
 mm/memory-failure.c                                                       |    8 
 mm/mmap.c                                                                 |   12 
 mm/ptdump.c                                                               |    2 
 mm/shmem.c                                                                |    2 
 net/bluetooth/hci_conn.c                                                  |    3 
 net/bluetooth/hci_event.c                                                 |    8 
 net/bluetooth/hci_sock.c                                                  |    2 
 net/bridge/br_multicast.c                                                 |   16 
 net/bridge/br_private.h                                                   |    2 
 net/core/dev.c                                                            |   12 
 net/core/neighbour.c                                                      |   12 
 net/core/net_namespace.c                                                  |    8 
 net/core/sock.c                                                           |   27 
 net/hsr/hsr_slave.c                                                       |    8 
 net/ipv4/netfilter/nf_reject_ipv4.c                                       |    6 
 net/ipv4/route.c                                                          |    1 
 net/ipv4/udp_offload.c                                                    |    2 
 net/ipv6/addrconf.c                                                       |    7 
 net/ipv6/mcast.c                                                          |   11 
 net/ipv6/netfilter/nf_reject_ipv6.c                                       |    5 
 net/ipv6/seg6_hmac.c                                                      |    6 
 net/mac80211/cfg.c                                                        |   12 
 net/mac80211/chan.c                                                       |    1 
 net/mac80211/mlme.c                                                       |    9 
 net/mac80211/rx.c                                                         |   12 
 net/mctp/af_mctp.c                                                        |   26 
 net/mptcp/options.c                                                       |    6 
 net/mptcp/pm_netlink.c                                                    |   19 
 net/mptcp/subflow.c                                                       |    5 
 net/ncsi/internal.h                                                       |    2 
 net/ncsi/ncsi-rsp.c                                                       |    1 
 net/netfilter/nf_conntrack_netlink.c                                      |   24 
 net/netlink/af_netlink.c                                                  |   12 
 net/rds/tcp.c                                                             |    8 
 net/sched/sch_cake.c                                                      |   14 
 net/sched/sch_ets.c                                                       |   36 -
 net/sched/sch_htb.c                                                       |    2 
 net/sctp/input.c                                                          |    2 
 net/smc/af_smc.c                                                          |    8 
 net/sunrpc/svcsock.c                                                      |    5 
 net/sunrpc/xprtsock.c                                                     |    8 
 net/tls/tls.h                                                             |    2 
 net/tls/tls_strp.c                                                        |   11 
 net/tls/tls_sw.c                                                          |   10 
 net/vmw_vsock/virtio_transport.c                                          |   14 
 net/wireless/mlme.c                                                       |    3 
 net/xfrm/xfrm_state.c                                                     |   72 +-
 scripts/kconfig/gconf.c                                                   |    8 
 scripts/kconfig/lxdialog/inputbox.c                                       |    6 
 scripts/kconfig/lxdialog/menubox.c                                        |    2 
 scripts/kconfig/nconf.c                                                   |    2 
 scripts/kconfig/nconf.gui.c                                               |    1 
 security/apparmor/file.c                                                  |    6 
 security/apparmor/include/lib.h                                           |    6 
 security/inode.c                                                          |    2 
 sound/core/pcm_native.c                                                   |   19 
 sound/hda/hdac_device.c                                                   |    2 
 sound/pci/hda/hda_codec.c                                                 |   42 -
 sound/pci/hda/patch_ca0132.c                                              |    2 
 sound/pci/hda/patch_realtek.c                                             |    4 
 sound/pci/intel8x0.c                                                      |    2 
 sound/soc/codecs/hdac_hdmi.c                                              |   10 
 sound/soc/codecs/rt5640.c                                                 |    5 
 sound/soc/fsl/fsl_sai.c                                                   |   20 
 sound/soc/intel/avs/core.c                                                |    3 
 sound/soc/qcom/lpass-platform.c                                           |   27 
 sound/soc/soc-core.c                                                      |    3 
 sound/soc/soc-dapm.c                                                      |    4 
 sound/usb/mixer_quirks.c                                                  |   14 
 sound/usb/stream.c                                                        |   25 
 sound/usb/validate.c                                                      |   14 
 tools/bpf/bpftool/main.c                                                  |    6 
 tools/include/nolibc/std.h                                                |    4 
 tools/include/nolibc/types.h                                              |    4 
 tools/include/uapi/linux/if_link.h                                        |    1 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c                   |    4 
 tools/scripts/Makefile.include                                            |    4 
 tools/testing/ktest/ktest.pl                                              |    5 
 tools/testing/selftests/arm64/fp/sve-ptrace.c                             |    3 
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c                     |   10 
 tools/testing/selftests/bpf/progs/verifier_unpriv.c                       |    2 
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc          |    2 
 tools/testing/selftests/futex/include/futextest.h                         |   11 
 tools/testing/selftests/memfd/memfd_test.c                                |   43 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh                           |    1 
 612 files changed, 6026 insertions(+), 2723 deletions(-)

Aahil Awatramani (1):
      bonding: Add independent control state machine

Aakash Kumar S (1):
      xfrm: Duplicate SPI Handling

Aaron Kling (1):
      ARM: tegra: Use I/O memcpy to write to IRAM

Aaron Plattner (1):
      watchdog: sbsa: Adjust keepalive timeout to avoid MediaTek WS0 race condition

Abel Vesa (1):
      power: supply: qcom_battmgr: Add lithium-polymer entry

Aditya Garg (2):
      HID: magicmouse: avoid setting up battery timer when not needed
      HID: apple: avoid setting up battery timer for devices without battery

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Fix default runtime and system PM levels

Al Viro (5):
      better lockdep annotations for simple_recursive_removal()
      fix locking in efi_secret_unlink()
      securityfs: don't pin dentries twice, once is enough...
      use uniform permission checks for all mount propagation changes
      alloc_fdtable(): change calling conventions.

Alex Deucher (1):
      drm/amdgpu: update mmhub 3.0.1 client id mappings

Alex Guo (2):
      media: dvb-frontends: dib7090p: fix null-ptr-deref in dib7090p_rw_on_apb()
      media: dvb-frontends: w7090p: fix null-ptr-deref in w7090p_tuner_write_serpar and w7090p_tuner_read_serpar

Alexander Kochetkov (1):
      ARM: rockchip: fix kernel hang during smp initialization

Alexander Sverdlin (1):
      arm64: dts: ti: k3-pinctrl: Enable Schmitt Trigger by default

Alexander Wilhelm (1):
      bus: mhi: host: Fix endianness of BHI vector table

Alexey Klimov (1):
      iommu/arm-smmu-qcom: Add SM6115 MDSS compatible

Alok Tiwari (6):
      net: ti: icss-iep: Fix incorrect type for return value in extts_enable()
      ALSA: intel8x0: Fix incorrect codec index usage in mixer for ICH4
      be2net: Use correct byte order and format string for TCP seq and ack_seq
      net: thunderx: Fix format-truncation warning in bgx_acpi_match_id()
      perf/cxlpmu: Remove unintended newline from IRQ name format string
      gve: Return error for unknown admin queue command

Amber Lin (1):
      drm/amdkfd: Destroy KFD debugfs after destroy KFD wq

Amelie Delaunay (1):
      dmaengine: stm32-dma: configure next sg only if there are more than 2 sgs

Amir Mohammad Jahangirzad (1):
      fs/orangefs: use snprintf() instead of sprintf()

Amit Sunil Dhamne (2):
      usb: typec: maxim_contaminant: re-enable cc toggle if cc is open and port is clean
      usb: typec: maxim_contaminant: disable low power mode when reading comparator values

Anantha Prabhu (1):
      RDMA/bnxt_re: Fix to initialize the PBL array

Andreas Dilger (1):
      ext4: check fast symlink for ea_inode correctly

Andrew Price (1):
      gfs2: Set .migrate_folio in gfs2_{rgrp,meta}_aops

André Draszik (1):
      scsi: ufs: exynos: Fix programming of HCI_UTRL_NEXUS_TYPE

Andy Shevchenko (2):
      Documentation: ACPI: Fix parent device references
      iio: imu: inv_icm42600: Convert to uXX and sXX integer types

Anshuman Khandual (1):
      mm/ptdump: take the memory hotplug lock inside ptdump_walk_pgd()

Anthoine Bourgeois (1):
      xen/netfront: Fix TX response spurious interrupts

Archana Patni (1):
      scsi: ufs: ufs-pci: Fix hibernate state transition for Intel MTL-like host controllers

Armen Ratner (1):
      net/mlx5e: Preserve shared buffer capacity during headroom updates

Arnaud Lecomte (1):
      jfs: upper bound check of tree index in dbAllocAG

Arnd Bergmann (1):
      RDMA/core: reduce stack using in nldev_stat_get_doit()

Artem Sadovnikov (1):
      vfio/mlx5: fix possible overflow in tracking max message size

Avraham Stern (1):
      wifi: iwlwifi: mvm: fix scan request validation

Baihan Li (1):
      drm/hisilicon/hibmc: fix the hibmc loaded failed bug

Baokun Li (4):
      ext4: fix zombie groups in average fragment size lists
      ext4: fix largest free orders lists corruption on mb_optimize_scan switch
      jbd2: prevent softlockup in jbd2_log_do_checkpoint()
      ext4: preserve SB_I_VERSION on remount

Bartosz Golaszewski (2):
      gpio: wcd934x: check the return value of regmap_update_bits()
      gpio: tps65912: check the return value of regmap_update_bits()

Benjamin Marzinski (1):
      dm-table: fix checking for rq stackable devices

Benson Leung (1):
      usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default

Bharat Bhushan (1):
      crypto: octeontx2 - add timeout for load_fvc completion poll

Biju Das (1):
      net: phy: micrel: Add ksz9131_resume()

Bingbu Cao (1):
      media: hi556: correct the test pattern configuration

Bitterblue Smith (3):
      wifi: rtw89: Lower the timeout in rtw89_fw_read_c2h_reg() for USB
      wifi: rtw89: Fix rtw89_mac_power_switch() for USB
      wifi: rtw89: Disable deep power saving for USB/SDIO

Bjorn Andersson (2):
      soc: qcom: mdt_loader: Actually use the e_phoff
      soc: qcom: mdt_loader: Ensure we don't read past the ELF header

Bjorn Helgaas (1):
      mmc: sdhci-pci-gli: Use PCI AER definitions, not hard-coded values

Boris Burkov (1):
      btrfs: fix ssd_spread overallocation

Boshi Yu (1):
      RDMA/erdma: Fix ignored return value of init_kernel_qp

Breno Leitao (5):
      ACPI: APEI: GHES: add TAINT_MACHINE_CHECK on GHES panic path
      arm64: Mark kernel as tainted on SAE and SError panic
      ptp: Use ratelimite for freerun error message
      ipmi: Use dev_warn_ratelimited() for incorrect message warnings
      mm/kmemleak: avoid deadlock by moving pr_warn() outside kmemleak_lock

Buday Csaba (1):
      net: phy: smsc: add proper reset flags for LAN8710A

Cezary Rojewski (1):
      ASoC: Intel: avs: Fix uninitialized pointer error in probe()

Chao Gao (1):
      KVM: nVMX: Defer SVI update to vmcs01 on EOI when L2 is active w/o VID

Chao Yu (1):
      f2fs: fix to avoid out-of-boundary access in dnode page

Charles Keepax (1):
      soundwire: Move handle_nested_irq outside of sdw_dev_lock

Cheick Traore (1):
      pinctrl: stm32: Manage irq affinity settings

Chen Yu (1):
      ACPI: pfr_update: Fix the driver update version check

Chen-Yu Tsai (1):
      mfd: axp20x: Set explicit ID for AXP313 regulator

Chenyuan Yang (1):
      drm/amd/display: Add null pointer check in mod_hdcp_hdcp1_create_session()

Chris Mason (1):
      sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails

Christian Loehle (1):
      cpuidle: menu: Remove iowait influence

Christoph Hellwig (2):
      block: reject invalid operation in submit_bio_noacct
      xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags

Christoph Paasch (1):
      mptcp: drop skb if MPTCP skb extension allocation fails

Christophe Leroy (1):
      ALSA: pcm: Rewrite recalculate_boundary() to avoid costly loop

Christopher Eby (1):
      ALSA: hda/realtek: Add Framework Laptop 13 (AMD Ryzen AI 300) to quirks

Corey Minyard (1):
      ipmi: Fix strcpy source and destination the same

Cristian Ciocaltea (1):
      ALSA: usb-audio: Avoid precedence issues in mixer_quirks macros

Cynthia Huang (1):
      selftests/futex: Define SYS_futex on 32-bit architectures with 64-bit time_t

D. Wythe (1):
      net/smc: fix UAF on smcsk after smc_listen_out()

Dai Ngo (1):
      NFSD: detect mismatch of file handle and delegation stateid in OPEN op

Damien Le Moal (9):
      ata: libata-sata: Disallow changing LPM state if not supported
      scsi: mpt3sas: Correctly handle ATA device errors
      scsi: mpi3mr: Correctly handle ATA device errors
      ata: libata-scsi: Fix ata_to_sense_error() status handling
      PCI: endpoint: Fix configfs group list head handling
      PCI: endpoint: Fix configfs group removal on driver teardown
      block: Make REQ_OP_ZONE_FINISH a write operation
      ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
      ata: libata-scsi: Return aborted command when missing sense and result TF

Dan Carpenter (5):
      cpufreq: armada-8k: Fix off by one in armada_8k_cpufreq_free_table()
      media: gspca: Add bounds checking to firmware parser
      soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()
      scsi: qla4xxx: Prevent a potential error pointer dereference
      ALSA: usb-audio: Fix size validation in convert_chmap_v3()

Daniel Golle (1):
      Revert "leds: trigger: netdev: Configure LED blink interval for HW offload"

Daniel Jurgens (1):
      net/mlx5: Base ECVF devlink port attrs from 0

Dave Stevenson (3):
      media: tc358743: Check I2C succeeded during probe
      media: tc358743: Return an appropriate colorspace from tc358743_set_fmt
      media: tc358743: Increase FIFO trigger level to 374

David Bauer (1):
      wifi: mt76: mt7915: mcu: re-init MCU before loading FW patch

David Collins (1):
      thermal/drivers/qcom-spmi-temp-alarm: Enable stage 2 shutdown when required

David Lechner (6):
      iio: adc: ad_sigma_delta: don't overallocate scan buffer
      iio: imu: bno055: fix OOB access of hw_xlate array
      iio: adc: ad_sigma_delta: change to buffer predisable
      iio: proximity: isl29501: fix buffered read on big-endian systems
      iio: temperature: maxim_thermocouple: use DMA-safe buffer for spi_read()
      iio: imu: inv_icm42600: use = { } instead of memset()

David Sterba (3):
      btrfs: move transaction aborts to the error site in add_block_group_free_space()
      btrfs: open code timespec64 in struct btrfs_inode
      btrfs: constify more pointer parameters

David Thompson (3):
      gpio: mlxbf2: use platform_get_irq_optional()
      Revert "gpio: mlxbf3: only get IRQ for device instance 0"
      gpio: mlxbf3: use platform_get_irq_optional()

Davide Caratti (1):
      net/sched: ets: use old 'nbands' while purging unused classes

Edward Adam Davis (2):
      jfs: Regular file corruption check
      comedi: pcl726: Prevent invalid irq number

Eliav Farber (1):
      pps: clients: gpio: fix interrupt handling order in remove path

Emanuele Ghidoli (1):
      arm64: dts: ti: k3-am62-verdin: Enable pull-ups on I2C buses

Emily Deng (1):
      drm/ttm: Should to return the evict error

Eric Biggers (4):
      thunderbolt: Fix copy+paste error in match_service_id()
      lib/crypto: mips/chacha: Fix clang build and remove unneeded byteswap
      ipv6: sr: Fix MAC comparison to be constant-time
      fscrypt: Don't use problematic non-inline crypto engines

Eric Dumazet (2):
      net: better track kernel sockets lifetime
      net_sched: sch_ets: implement lockless ets_dump()

Eric Work (1):
      net: atlantic: add set_power to fw_ops for atl2 to fix wol

Evgeniy Harchenko (1):
      ALSA: hda/realtek: Add support for HP EliteBook x360 830 G6 and EliteBook 830 G6

Fanhua Li (1):
      drm/nouveau/nvif: Fix potential memory leak in nvif_vmm_ctor().

Fedor Pchelkin (1):
      netlink: avoid infinite retry looping in netlink_unicast()

Fenglin Wu (1):
      leds: flash: leds-qcom-flash: Limit LED current based on thermal condition

Filipe Manana (14):
      btrfs: abort transaction during log replay if walk_log_tree() failed
      btrfs: clear dirty status from extent buffer on error at insert_new_root()
      btrfs: fix log tree replay failure due to file with 0 links and extents
      btrfs: don't ignore inode missing when replaying log tree
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

Florian Larysch (1):
      net: phy: micrel: fix KSZ8081/KSZ8091 cable test

Florian Westphal (2):
      netfilter: ctnetlink: fix refcount leak on table dump
      netfilter: nf_reject: don't leak dst refcount for loopback packets

Florin Leotescu (1):
      hwmon: (emc2305) Set initial PWM minimum value during probe based on thermal state

Frederic Weisbecker (1):
      rcu: Fix racy re-initialization of irq_work causing hangs

Gabor Juhos (1):
      mtd: spinand: propagate spinand_wait() errors from spinand_write_page()

Gabriel Totev (1):
      apparmor: shift ouid when mediating hard links in userns

Gal Pressman (2):
      net: vlan: Make is_vlan_dev() a stub when VLAN is not configured
      net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs

Gang Ba (1):
      drm/amdgpu: Avoid extra evict-restore process.

Gautham R. Shenoy (1):
      pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_stop()

Geliang Tang (2):
      mptcp: remove duplicate sk_reset_timer call
      mptcp: disable add_addr retransmission when timeout is 0

George Moussalem (1):
      clk: qcom: ipq5018: keep XO clock always on

Gerald Schaefer (1):
      s390/mm: Remove possible false-positive warning in pte_free_defer()

Geraldo Nascimento (3):
      phy: rockchip-pcie: Properly disable TEST_WRITE strobe signal
      PCI: rockchip: Use standard PCIe definitions
      PCI: rockchip: Set Target Link Speed to 5.0 GT/s before retraining

Giovanni Cabiddu (2):
      crypto: qat - lower priority for skcipher and aead algorithms
      crypto: qat - flush misc workqueue during device shutdown

Greg Kroah-Hartman (1):
      Linux 6.6.103

Gui-Dong Han (1):
      media: rainshadow-cec: fix TOCTOU race condition in rain_interrupt()

Haiyang Zhang (1):
      hv_netvsc: Fix panic during namespace deletion with VF

Hangbin Liu (2):
      bonding: update LACP activity flag after setting lacp_active
      bonding: send LACPDUs periodically in passive mode after receiving partner's LACPDU

Hans Verkuil (1):
      media: vivid: fix wrong pixel_array control size

Hans de Goede (2):
      mei: bus: Check for still connected devices in mei_cl_bus_dev_release()
      media: ivsc: Fix crash at shutdown due to missing mei_cldev_disable() calls

Haoran Jiang (1):
      LoongArch: BPF: Fix jump offset calculation in tailcall

Haoxiang Li (1):
      media: imx: fix a potential memory leak in imx_media_csc_scaler_device_init()

Harald Mommer (1):
      gpio: virtio: Fix config space reading.

Hari Chandrakanthan (1):
      wifi: mac80211: fix rx link assignment for non-MLO stations

Hari Kalavakunta (1):
      net: ncsi: Fix buffer overflow in fetching version id

Hariprasad Kelam (1):
      Octeontx2-af: Skip overlap check for SPI field

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Wildcat Lake

Heiner Kallweit (1):
      dpaa_eth: don't use fixed_phy_change_carrier

Helge Deller (1):
      Revert "vgacon: Add check for vc_origin address range in vgacon_scroll()"

Herton R. Krzesinski (1):
      mm/debug_vm_pgtable: clear page table entries at destroy_args()

Hiago De Franco (1):
      remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU

Hong Guan (1):
      arm64: dts: ti: k3-am62a7-sk: fix pinmux for main_uart1

Horatiu Vultur (1):
      phy: mscc: Fix timestamping for vsc8584

Hsin-Te Yuan (1):
      thermal: sysfs: Return ENODATA instead of EAGAIN for reads

Huacai Chen (1):
      PCI: Extend isolated function probing to LoongArch

Ian Abbott (3):
      comedi: fix race between polling and detaching
      comedi: Make insn_rw_emulate_bits() do insn->n samples
      comedi: Fix use of uninitialized memory in do_insn_ioctl() and do_insnlist_ioctl()

Ido Schimmel (1):
      mlxsw: spectrum: Forward packets with an IPv4 link-local source IP

Igor Pylypiv (1):
      ata: libata-scsi: Fix CDL control

Ihor Solodrai (1):
      bpf: Make reg_not_null() true for CONST_PTR_TO_MAP

Ilan Peer (1):
      wifi: cfg80211: Fix interface type validation

Ilya Bakoulin (1):
      drm/amd/display: Separate set_gsl from set_gsl_source_select

Imre Deak (1):
      drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS

Isaac J. Manjarres (4):
      mm: drop the assumption that VM_SHARED always implies writable
      mm: update memfd seal write check to include F_SEAL_WRITE
      mm: reinstate ability to map write-sealed memfd mappings read-only
      selftests/memfd: add test for mapping write-sealed memfd read-only

Jack Xiao (1):
      drm/amdgpu: fix incorrect vm flags to map bo

Jaegeuk Kim (1):
      f2fs: check the generic conditions first

Jakub Acs (1):
      net, hsr: reject HSR frame if skb can't hold tag

Jakub Kicinski (3):
      tls: handle data disappearing from under the TLS ULP
      uapi: in6: restore visibility of most IPv6 socket options
      tls: fix handling of zero-length records on the rx_list

Jakub Ramaseuski (1):
      net: gso: Forbid IPv6 TSO with extensions on devices with only IPV6_CSUM

Jan Beulich (1):
      compiler: remove __ADDRESSABLE_ASM{_STR,}() again

Jan Kara (2):
      loop: Avoid updating block size under exclusive owner
      udf: Verify partition map count

Jann Horn (1):
      eventpoll: Fix semi-unbounded recursion

Jason Gunthorpe (1):
      iommufd: Prevent ALIGN() overflow

Jason Wang (1):
      vhost: fail early when __vhost_add_used() fails

Jason Xing (1):
      ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc

Jay Chen (1):
      usb: xhci: Set avg_trb_len = 8 for EP0 during Address Device Command

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: change invalid data error to -EBUSY

Jeff Layton (1):
      nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()

Jens Axboe (1):
      io_uring/net: commit partial buffers on retry

Jeongjun Park (1):
      ptp: prevent possible ABBA deadlock in ptp_clock_freerun()

Jiasheng Jiang (1):
      scsi: lpfc: Remove redundant assignment to avoid memory leak

Jiayi Li (2):
      ACPI: processor: perflib: Fix initial _PPC limit application
      memstick: Fix deadlock by moving removing flag earlier

Jinjiang Tu (1):
      mm/memory-failure: fix infinite UCE for VM_PFNMAP pfn

Joel Fernandes (1):
      rcu: Fix rcu_read_unlock() deadloop due to IRQ work

Johan Adolfsson (1):
      leds: leds-lp50xx: Handle reg to get correct multi_index

Johan Hovold (15):
      net: gianfar: fix device leak when querying time stamp info
      net: enetc: fix device and OF node leak at probe
      net: mtk_eth_soc: fix device leak at probe
      net: ti: icss-iep: fix device and OF node leaks at probe
      net: dpaa: fix device leak when querying time stamp info
      usb: gadget: udc: renesas_usb3: fix device leak at unbind
      usb: musb: omap2430: fix device leak at unbind
      usb: dwc3: meson-g12a: fix device leaks at unbind
      wifi: ath12k: fix dest ring-buffer corruption
      wifi: ath12k: fix source ring-buffer corruption
      wifi: ath12k: fix dest ring-buffer corruption when ring is full
      wifi: ath11k: fix dest ring-buffer corruption
      wifi: ath11k: fix source ring-buffer corruption
      wifi: ath11k: fix dest ring-buffer corruption when ring is full
      usb: dwc3: imx8mp: fix device leak at unbind

Johannes Berg (2):
      wifi: cfg80211: reject HTC bit for management frames
      wifi: mac80211: don't complete management TX on SAE commit

Johannes Thumshirn (1):
      btrfs: zoned: use filesystem size not disk size for reclaim decision

John David Anglin (8):
      parisc: Check region is readable by user in raw_copy_from_user()
      parisc: Define and use set_pte_at()
      parisc: Drop WARN_ON_ONCE() from flush_cache_vmap
      parisc: Rename pte_needs_flush() to pte_needs_cache_flush() in cache.c
      parisc: Revise __get_user() to probe user read access
      parisc: Revise gateway LWS calls to probe user read access
      parisc: Try to fixup kernel exception in bad_area_nosemaphore path of do_page_fault()
      parisc: Update comments in make_insert_tlb

John Garry (2):
      scsi: aacraid: Stop using PCI_IRQ_AFFINITY
      block: avoid possible overflow for chunk_sectors check in blk_stack_limits()

Jon Hunter (1):
      soc/tegra: pmc: Ensure power-domains are in a known state

Jonas Rebmann (1):
      net: fec: allow disable coalescing

Jonathan Cameron (2):
      iio: light: as73211: Ensure buffer holes are zeroed
      iio: imu: inv_icm42600: switch timestamp type from int64_t __aligned(8) to aligned_s64

Jonathan Santos (1):
      iio: adc: ad7768-1: Ensure SYNC_IN pulse minimum timing requirement

Jordan Rhee (1):
      gve: prevent ethtool ops after shutdown

Jorge Marques (1):
      i3c: master: Initialize ret in i3c_i2c_notifier_call()

Jorge Ramirez-Ortiz (2):
      media: venus: hfi: explicitly release IRQ during teardown
      media: venus: protect against spurious interrupts during probe

Judith Mendez (1):
      arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support

Justin Tee (1):
      scsi: lpfc: Check for hdwq null ptr when cleaning up lpfc_vport structure

Kanglong Wang (1):
      LoongArch: Optimize module load time by optimizing PLT/GOT counting

Karthikeyan Kathirvel (1):
      wifi: ath12k: Decrement TID on RX peer frag setup error handling

Kashyap Desai (2):
      RDMA/bnxt_re: Fix to do SRQ armena by default
      RDMA/bnxt_re: Fix to remove workload check in SRQ limit path

Kathiravan Thirumoorthy (1):
      phy: qcom: phy-qcom-m31: Update IPQ5332 M31 USB phy initialization sequence

Kees Cook (3):
      arm64: Handle KCOV __init vs inline mismatches
      platform/x86: thinkpad_acpi: Handle KCOV __init vs inline mismatches
      iommu/amd: Avoid stack buffer overflow from kernel cmdline

Keith Busch (2):
      nvme-pci: try function level reset on init failure
      vfio/type1: conditional rescheduling while pinning

Krzysztof Hałasa (1):
      imx8m-blk-ctrl: set ISI panic write hurry level

Krzysztof Kozlowski (3):
      dt-bindings: display: sprd,sharkl3-dpu: Fix missing clocks constraints
      dt-bindings: display: sprd,sharkl3-dsi-host: Fix missing clocks constraints
      leds: flash: leds-qcom-flash: Fix registry access after re-bind

Kuen-Han Tsai (1):
      usb: dwc3: Ignore late xferNotReady event to prevent halt timeout

Kuninori Morimoto (1):
      ASoC: soc-dapm: set bias_level if snd_soc_dapm_set_bias_level() was successed

Kuniyuki Iwashima (2):
      ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in __ipv6_dev_mc_inc().
      net: Add net_passive_inc() and net_passive_dec().

Lad Prabhakar (1):
      drm: renesas: rz-du: mipi_dsi: Add min check for VCLK range

Laurentiu Mihalcea (1):
      pwm: imx-tpm: Reset counter if CMOD is 0

Len Brown (1):
      intel_idle: Allow loading ACPI tables for any family

Leon Romanovsky (1):
      net/mlx5e: Properly access RCU protected qdisc_sleeping variable

Liao Yuanhong (1):
      ext4: use kmalloc_array() for array space allocation

Lifeng Zheng (2):
      cpufreq: Exit governor when failed to start old governor
      PM / devfreq: governor: Replace sscanf() with kstrtoul() in set_freq_store()

Lizhi Xu (2):
      fs/ntfs3: Add sanity check for file name
      jfs: truncate good inode pages when hard link is 0

Lucy Thrun (1):
      ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control

Ludwig Disterhof (1):
      media: usbtv: Lock resolution while streaming

Lukas Wunner (1):
      PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports

Ma Ke (1):
      sunvdc: Balance device refcount in vdc_port_mpgroup_check

Mael GUERIN (1):
      USB: storage: Add unusual-devs entry for Novatek NTK96550-based camera

Manuel Andreas (1):
      KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush

Marek Szyprowski (1):
      zynq_fpga: use sgtable-based scatterlist wrappers

Marek Vasut (1):
      usb: renesas-xhci: Fix External ROM access timeouts

Mario Limonciello (8):
      platform/x86/amd: pmc: Add Lenovo Yoga 6 13ALC6 to pmc quirk list
      usb: xhci: Avoid showing warnings for dying controller
      usb: xhci: Avoid showing errors during surprise removal
      drm/amd: Allow printing VanGogh OD SCLK levels without setting dpm to manual
      drm/amd/display: Only finalize atomic_obj if it was initialized
      drm/amd/display: Avoid configuring PSR granularity if PSR-SU not supported
      drm/amd: Restore cached power limit during resume
      drm/amd/display: Avoid a NULL pointer dereference

Mark Brown (2):
      ASoC: hdac_hdmi: Rate limit logging on connection and disconnection
      kselftest/arm64: Specify SVE data when testing VL set in sve-ptrace

Markus Theil (1):
      crypto: jitter - fix intermediary handling

Masahiro Yamada (2):
      kconfig: gconf: avoid hardcoding model2 in on_treeview2_cursor_changed()
      kconfig: gconf: fix potential memory leak in renderer_edited()

Masami Hiramatsu (Google) (2):
      selftests: tracing: Use mutex_unlock for testing glob filter
      tracing: fprobe-event: Sanitize wildcard for fprobe event name

Mateusz Guzik (1):
      apparmor: use the condition in AA_BUG_FMT even with debug disabled

Matt Johnston (1):
      net: mctp: Prevent duplicate binds

Matthieu Baerts (NGI0) (2):
      mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
      selftests: mptcp: pm: check flush doesn't reset limits

Maulik Shah (1):
      soc: qcom: rpmh-rsc: Add RSC version 4 support

Maurizio Lombardi (1):
      scsi: target: core: Generate correct identifiers for PR OUT transport IDs

Maxim Levitsky (3):
      KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
      KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs
      KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the guest

Meagan Lloyd (2):
      rtc: ds1307: handle oscillator stop flag (OSF) for ds1341
      rtc: ds1307: remove clear of oscillator stop flag (OSF) in probe

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

Mikhail Lobanov (1):
      wifi: mac80211: check basic rates validity in sta_link_apply_parameters

Mikulas Patocka (1):
      dm-mpath: don't print the "loaded" message if registering fails

Mina Almasry (1):
      netmem: fix skb_frag_address_safe with unreadable skbs

Minhong He (1):
      ipv6: sr: validate HMAC algorithm ID in seg6_hmac_info_add

Miri Korenblit (1):
      wifi: iwlwifi: mvm: set gtk id also in older FWs

Myrrh Periwinkle (3):
      usb: typec: ucsi: Update power_supply on power role change
      vt: keyboard: Don't process Unicode characters in K_OFF mode
      vt: defkeymap: Map keycodes above 127 to K_HOLE

Namjae Jeon (1):
      ksmbd: extend the connection limiting mechanism to support IPv6

Naohiro Aota (3):
      btrfs: zoned: do not remove unwritten non-data block group
      btrfs: zoned: do not select metadata BG as finish target
      btrfs: zoned: fix write time activation failure for metadata block group

Nathan Chancellor (2):
      usb: atm: cxacru: Merge cxacru_upload_firmware() into cxacru_heavy_init()
      wifi: brcmsmac: Remove const from tbl_ptr parameter in wlc_lcnphy_common_read_table()

NeilBrown (1):
      smb/server: avoid deadlock when linking with ReplaceIfExists

Nicolas Dufresne (1):
      media: verisilicon: Fix AV1 decoder clock frequency

Nicolas Escande (1):
      neighbour: add support for NUD_PERMANENT proxy entries

Nicolin Chen (1):
      iommufd: Report unmapped bytes in the error path of iopt_unmap_iova_range

Niklas Söderlund (1):
      media: v4l2-common: Reduce warnings about missing V4L2_CID_LINK_FREQ control

Nitin Gote (1):
      iosys-map: Fix undefined behavior in iosys_map_clear()

Ojaswin Mujoo (2):
      ext4: fix fsmap end of range reporting with bigalloc
      ext4: fix reserved gdt blocks handling in fsmap

Oliver Neukum (3):
      usb: core: usb_submit_urb: downgrade type check
      net: usb: cdc-ncm: check for filtering capability
      cdc-acm: fix race between initial clearing halt and open

Oscar Maes (1):
      net: ipv4: fix incorrect MTU in broadcast routes

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg_collect

Pali Rohár (1):
      cifs: Fix calling CIFSFindFirst() for root path without msearch

Paul E. McKenney (1):
      rcu: Protect ->defer_qs_iw_pending from data race

Pauli Virtanen (1):
      Bluetooth: hci_event: fix MTU for BN == 0 in CIS Established

Pavel Begunkov (1):
      io_uring: don't use int for ABI

Pawan Gupta (1):
      x86/bugs: Avoid warning when overriding return thunk

Pedro Falcato (1):
      RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages

Pei Xiao (1):
      clk: tegra: periph: Fix error handling and resolve unsigned compare warning

Peter Oberparleiter (3):
      s390/sclp: Fix SCCB present check
      s390/hypfs: Avoid unnecessary ioctl registration in debugfs
      s390/hypfs: Enable limited access during lockdown

Peter Robinson (1):
      reset: brcmstb: Enable reset drivers for ARCH_BCM2835

Peter Ujfalusi (1):
      ASoC: core: Check for rtd == NULL in snd_soc_remove_pcm_runtime()

Petr Pavlu (1):
      module: Prevent silent truncation of module name in delete_module(2)

Phillip Lougher (1):
      squashfs: fix memory leak in squashfs_fill_super

Prashant Malani (1):
      cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag

Pu Lehui (1):
      tracing: Limit access to parser->buffer when trace_get_user failed

Purva Yeshi (1):
      md: dm-zoned-target: Initialize return variable r to avoid uninitialized use

Qingfang Deng (2):
      net: ethernet: mtk_ppe: add RCU lock around dev_fill_forward_path
      ppp: fix race conditions in ppp_fill_forward_path

Qu Wenruo (2):
      btrfs: do not allow relocation of partially dropped subvolumes
      btrfs: populate otime when logging an inode item

Rafael J. Wysocki (5):
      ACPI: processor: perflib: Move problematic pr->performance check
      cpuidle: governors: menu: Avoid using invalid recent intervals data
      PM: runtime: Clear power.needs_force_resume in pm_runtime_reinit()
      PM: runtime: Take active children into account in pm_runtime_get_if_in_use()
      cpuidle: governors: menu: Avoid selecting states with too much latency

Raj Kumar Bhagat (1):
      wifi: ath12k: Enable REO queue lookup table feature on QCN9274 hw2.0

Ramya Gnanasekar (1):
      wifi: mac80211: update radar_required in channel context after channel switch

Rand Deeb (1):
      wifi: iwlwifi: dvm: fix potential overflow in rs_fill_link_cmd()

Randy Dunlap (2):
      parisc: Makefile: fix a typo in palo.conf
      parisc: Makefile: explain that 64BIT requires both 32-bit and 64-bit compilers

Ranjan Kumar (4):
      scsi: Fix sas_user_scan() to handle wildcard and multi-channel scans
      scsi: mpi3mr: Fix race between config read submit and interrupt completion
      scsi: mpi3mr: Drop unnecessary volatile from __iomem pointers
      scsi: mpi3mr: Serialize admin queue BAR writes on 32-bit systems

Ricardo Ribalda (3):
      media: uvcvideo: Do not mark valid metadata as invalid
      media: venus: vdec: Clamp param smaller than 1fps and bigger than 240.
      media: venus: venc: Clamp param smaller than 1fps and bigger than 240

Richard Zhu (2):
      PCI: imx6: Delay link start until configfs 'start' written
      PCI: imx6: Add IMX8MM_EP and IMX8MP_EP fixed 256-byte BAR 4 in epc_features

Ricky Wu (1):
      misc: rtsx: usb: Ensure mmc child device is active when card is present

Rob Clark (1):
      drm/msm: use trylock for debugfs

Rong Zhang (1):
      fs/ntfs3: correctly create symlink for relative path

Sabrina Dubroca (1):
      udp: also consider secpath when evaluating ipsec use for checksumming

Sakari Ailus (2):
      media: v4l2-ctrls: Don't reset handler's error in v4l2_ctrl_handler_free()
      PM: runtime: Simplify pm_runtime_get_if_active() usage

Salah Triki (1):
      iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()

Sarah Newman (1):
      drbd: add missing kref_get in handle_write_conflicts

Sarika Sharma (2):
      wifi: ath12k: Correct tid cleanup when tid setup fails
      wifi: ath12k: Add memset and update default rate value in wmi tx completion

Sarthak Garg (1):
      mmc: sdhci-msm: Ensure SD card power isn't ON when card removed

Sasha Levin (1):
      fs: Prevent file descriptor table allocations exceeding INT_MAX

Sean Christopherson (15):
      KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN out of the STI shadow
      KVM: x86: Plumb in the vCPU to kvm_x86_ops.hwapic_isr_update()
      KVM: x86: Snapshot the host's DEBUGCTL in common x86
      KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs
      KVM: x86: Plumb "force_immediate_exit" into kvm_entry() tracepoint
      KVM: VMX: Re-enter guest in fastpath for "spurious" preemption timer exits
      KVM: VMX: Handle forced exit due to preemption timer in fastpath
      KVM: x86: Move handling of is_guest_mode() into fastpath exit handlers
      KVM: VMX: Handle KVM-induced preemption timer exits in fastpath for L2
      KVM: x86: Fully defer to vendor code to decide how to force immediate exit
      KVM: x86: Convert vcpu_run()'s immediate exit param into a generic bitmap
      KVM: x86: Drop kvm_x86_ops.set_dr6() in favor of a new KVM_RUN flag
      KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
      KVM: VMX: Extract checking of guest's DEBUGCTL into helper
      KVM: x86: Take irqfds.lock when adding/deleting IRQ bypass producer

Sebastian Ott (1):
      ACPI: processor: fix acpi_object initialization

Sebastian Reichel (2):
      watchdog: dw_wdt: Fix default timeout
      usb: typec: fusb302: cache PD RX state

Selvarasu Ganesan (1):
      usb: dwc3: Remove WARN_ON for device endpoint command timeouts

Sergey Bashirov (4):
      pNFS: Fix stripe mapping in block/scsi layout
      pNFS: Fix disk addr range check in block/scsi layout
      pNFS: Handle RPC size limit for layoutcommits
      pNFS: Fix uninited ptr deref in block/scsi layout

Sergey Shtylyov (1):
      Bluetooth: hci_conn: do return error from hci_enhanced_setup_sync()

Shankari Anand (1):
      kconfig: nconf: Ensure null termination where strncpy is used

Shannon Nelson (1):
      ionic: clean dbpage in de-init

Shengjiu Wang (1):
      ASoC: fsl_sai: replace regmap_write with regmap_update_bits

Shiji Yang (2):
      MIPS: vpe-mt: add missing prototypes for vpe_{alloc,start,stop,free}
      MIPS: lantiq: falcon: sysctrl: fix request memory check logic

Showrya M N (1):
      scsi: libiscsi: Initialize iscsi_conn->dd_data only if memory is allocated

Shuai Xue (1):
      ACPI: APEI: send SIGBUS to current task if synchronous memory error not recovered

Shubhrajyoti Datta (1):
      EDAC/synopsys: Clear the ECC counters on init

Shyam Prasad N (1):
      cifs: reset iface weights when we cannot find a candidate

Sravan Kumar Gundu (1):
      fbdev: Fix vmalloc out-of-bounds write in fast_imageblit

Srinivas Kandagatla (1):
      ASoC: qcom: use drvdata instead of component to keep id

Stanislaw Gruszka (1):
      wifi: iwlegacy: Check rate_idx range after addition

Stefan Metzmacher (3):
      smb: client: let send_done() cleanup before calling smbd_disconnect_rdma_connection()
      smb: client: don't wait for info->send_pending == 0 on error
      smb: server: split ksmbd_rdma_stop_listening() out of ksmbd_rdma_destroy()

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Clamp too high speed_hz

Steve French (1):
      smb3: fix for slab out of bounds on mount to ksmbd

Steven Rostedt (5):
      tracefs: Add d_delete to remove negative dentries
      powerpc/thp: tracing: Hide hugepage events under CONFIG_PPC_BOOK3S_64
      ktest.pl: Prevent recursion of default variable options
      ftrace: Also allocate and copy hash for reading of filter files
      tracing: Remove unneeded goto out logic

Su Hui (1):
      usb: xhci: print xhci->xhc_state when queue_command failed

Suchit Karunakaran (1):
      kconfig: lxdialog: replace strcpy() with strncpy() in inputbox.c

Sven Schnelle (2):
      s390/time: Use monotonic clock in get_cycles()
      s390/stp: Remove udelay from stp_sync_clock()

Takashi Iwai (5):
      ALSA: usb-audio: Validate UAC3 power domain descriptors, too
      ALSA: usb-audio: Validate UAC3 cluster segment descriptors
      ALSA: hda: Handle the jack polling always via a work
      ALSA: hda: Disable jack polling at shutdown
      ALSA: usb-audio: Use correct sub-type for UAC3 feature unit validation

Tetsuo Handa (1):
      hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()

Theodore Ts'o (2):
      ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
      ext4: don't try to clear the orphan_present feature block device is r/o

Thierry Reding (1):
      firmware: tegra: Fix IVC dependency problems

Thomas Fourier (8):
      et131x: Add missing check after DMA map
      net: ag71xx: Add missing check after DMA map
      (powerpc/512) Fix possible `dma_unmap_single()` on uninitialized pointer
      wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.
      powerpc: floppy: Add missing checks after DMA map
      wifi: rtlwifi: fix possible skb memory leak in _rtl_pci_init_one_rxdesc()
      mtd: rawnand: fsmc: Add missing check after DMA map
      mtd: rawnand: renesas: Add missing check after DMA map

Thomas Weißschuh (5):
      tools/nolibc: define time_t in terms of __kernel_old_time_t
      tools/build: Fix s390(x) cross-compilation with clang
      um: Re-evaluate thread flags repeatedly
      MIPS: Don't crash in stack_top() for tasks without ABI or vDSO
      kbuild: userprogs: use correct linker when mixing clang and GNU ld

Thorsten Blum (2):
      cdx: Fix off-by-one error in cdx_rpmsg_probe()
      usb: storage: realtek_cr: Use correct byte order for bcs->Residue

Tianxiang Peng (1):
      x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper

Tim Harvey (1):
      hwmon: (gsc-hwmon) fix fan pwm setpoint show functions

Timur Kristóf (6):
      drm/amd/display: Don't overwrite dce60_clk_mgr
      drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3
      drm/amd/display: Fix DP audio DTO1 clock source on DCE 6.
      drm/amd/display: Find first CRTC and its line time in dce110_fill_display_configs
      drm/amd/display: Fill display clock and vblank time in dce110_fill_display_configs
      drm/amd/display: Don't overclock DCE 6 by 15%

Tomasz Michalec (2):
      usb: typec: intel_pmc_mux: Defer probe if SCU IPC isn't present
      platform/chrome: cros_ec_typec: Defer probe on missing EC parent

Trond Myklebust (1):
      NFS: Fix the setting of capabilities when automounting a new filesystem

Tvrtko Ursulin (1):
      drm/ttm: Respect the shrinker core free target

Tzung-Bi Shih (1):
      platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()

Ulf Hansson (1):
      mmc: rtsx_usb_sdmmc: Fix error-path in sd_set_power_mode()

Uwe Kleine-König (2):
      pwm: mediatek: Handle hardware enable and clock enable separately
      pwm: mediatek: Fix duty and period setting

ValdikSS (1):
      igc: fix disabling L1.2 PCI-E link substate on I226 on init

Vasiliy Kovalev (1):
      ALSA: hda/realtek: Fix headset mic on HONOR BRB-X

Vedang Nagar (2):
      media: venus: Fix OOB read due to missing payload bound check
      media: venus: Add a check for packet size after reading from shared memory

Viacheslav Dubeyko (5):
      hfs: fix general protection fault in hfs_find_init()
      hfs: fix slab-out-of-bounds in hfs_bnode_read()
      hfsplus: fix slab-out-of-bounds in hfsplus_bnode_read()
      hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
      hfs: fix not erasing deleted b-tree node issue

Victor Shih (3):
      mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for consistency
      mmc: sdhci-pci-gli: Add a new function to simplify the code
      mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER

Vijendar Mukunda (1):
      soundwire: amd: serialize amd manager resume sequence during pm_prepare

Vincent Guittot (8):
      sched/topology: Add a new arch_scale_freq_ref() method
      cpufreq: Use the fixed and coherent frequency for scaling capacity
      cpufreq/schedutil: Use a fixed reference frequency
      energy_model: Use a fixed reference frequency
      cpufreq/cppc: Set the frequency used for computing the capacity
      arm64/amu: Use capacity_ref_freq() to set AMU ratio
      topology: Set capacity_freq_ref in all cases
      sched/fair: Fix frequency selection for non-invariant case

Vladimir Zapolskiy (1):
      media: qcom: camss: cleanup media device allocated resource on error path

Waiman Long (2):
      mm/kmemleak: avoid soft lockup in __kmemleak_do_cleanup()
      cgroup/cpuset: Use static_branch_enable_cpuslocked() on cpusets_insane_config_key

Wang Liang (1):
      net: bridge: fix soft lockup in br_multicast_query_expired()

Wang Zhaolong (2):
      smb: client: remove redundant lstrp update in negotiate protocol
      smb: client: fix netns refcount leak after net_passive changes

Wayne Lin (1):
      drm/amd/display: Avoid trying AUX transactions on disconnected ports

Wei Gao (1):
      ext2: Handle fiemap on empty files to prevent EINVAL

Weitao Wang (1):
      usb: xhci: Fix slot_id resource race conflict

Wen Chen (1):
      drm/amd/display: Fix 'failed to blank crtc!'

Will Deacon (4):
      vsock/virtio: Resize receive buffers so that each SKB fits in a 4K page
      vsock/virtio: Validate length in packet header before skb_put()
      vhost/vsock: Avoid allocating arbitrarily-sized SKBs
      KVM: arm64: Fix kernel BUG() due to bad backport of FPSIMD/SVE/SME fix

William Liu (2):
      net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit
      net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate

Willy Tarreau (1):
      tools/nolibc: fix spelling of FD_SETBITMASK in FD_* macros

Wolfram Sang (3):
      media: usb: hdpvr: disable zero-length read messages
      i3c: add missing include to internal header
      i3c: don't fail if GETHDRCAP is unsupported

Xin Long (1):
      sctp: linearize cloned gso packets in sctp_rcv

Xinxin Wan (1):
      ASoC: codecs: rt5640: Retry DEVICE_ID verification

Xinyu Liu (1):
      usb: core: config: Prevent OOB read in SS endpoint companion parsing

Xu Yang (2):
      net: usb: asix_devices: add phy_mask for ax88772 mdio bus
      usb: core: hcd: fix accessing unmapped memory in SINGLE_STEP_SET_FEATURE test

Xu Yilun (1):
      fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()

Yann E. MORIN (1):
      kconfig: lxdialog: fix 'space' to (de)select options

Ye Bin (1):
      fs/buffer: fix use-after-free when call bh_read() helper

Yonghong Song (1):
      selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size

Yongzhen Zhang (1):
      fbdev: fix potential buffer overflow in do_register_framebuffer()

Youngjun Lee (1):
      media: uvcvideo: Fix 1-byte out-of-bounds read in uvc_parse_format()

Youssef Samir (1):
      bus: mhi: host: Detect events pointing to unexpected TREs

Yuan Chen (1):
      bpftool: Fix JSON writer resource leak in version command

Yuezhang Mo (1):
      exfat: add cluster chain loop check for dir

Yuichiro Tsuji (1):
      net: usb: asix_devices: Fix PHY address mask in MDIO bus initialization

Yunhui Cui (1):
      serial: 8250: fix panic due to PSLVERR

Yury Norov [NVIDIA] (1):
      RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()

Zenm Chen (1):
      USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles

Zhang Shurong (1):
      media: ov2659: Fix memory leaks in ov2659_probe()

Zhang Yi (1):
      ext4: fix hole length calculation overflow in non-extent inodes

Zhiqi Song (1):
      crypto: hisilicon/hpre - fix dma unmap sequence

Zhu Qiyu (1):
      ACPI: PRM: Reduce unnecessary printing to avoid user confusion

Zijun Hu (2):
      char: misc: Fix improper and inaccurate error code returned by misc_init()
      Bluetooth: hci_sock: Reset cookie to zero in hci_sock_free_cookie()

Ziyan Fu (1):
      watchdog: iTCO_wdt: Report error if timeout configuration fails

Ziyan Xu (1):
      ksmbd: fix refcount leak causing resource not released

chenchangcheng (1):
      media: uvcvideo: Fix bandwidth issue for Alcor camera

fangzhong.zhou (1):
      i2c: Force DLL0945 touchpad i2c freq to 100khz

jackysliu (1):
      scsi: bfa: Double-free fix

tuhaowen (1):
      PM: sleep: console: Fix the black screen issue

zhangjianrong (2):
      net: thunderbolt: Enable end-to-end flow control also in transmit
      net: thunderbolt: Fix the parameter passing of tb_xdomain_enable_paths()/tb_xdomain_disable_paths()

Álvaro Fernández Rojas (5):
      net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
      net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
      net: dsa: b53: prevent DIS_LEARNING access on BCM5325
      net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
      net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325


