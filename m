Return-Path: <stable+bounces-158766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E4AEB441
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 12:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B4C170DF0
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E725529B8DB;
	Fri, 27 Jun 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yvlhYmA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1B2989B6;
	Fri, 27 Jun 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019496; cv=none; b=Ac6AM1hFyvabq7CKabHikDDCc3vm138m/MPqLd5/T7ULqxbB11yMW1dnlI01KK7h3lr7hylEJXeaXAHIaU9OII9lDG6KvLcahYb+cV72fJpMSxa5tyjC3R8PAlN4YBGTeLhdKkDzM1KCnZURc8nXUGd1qA8G+EJhk2HtaW5KK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019496; c=relaxed/simple;
	bh=59yKkmHKHzTvVqB97//5M2vZb5P72XKwlSH8cosqitA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c+y2Z/fIdgSpjuHUr+JeTyrfPsyZFdjfkdEIJagijXlc5BO84yUd0U954q+orWX+H/15MfEsTuLCVeB5IFvYMeub77V8quUa2EwstzKpxpKYMp3OYsmsKZdEJD4y1Wm0reVhBfT0EMQvos1TfB6FKsrkyOrUC9vrJdUf/IXGDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yvlhYmA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19AAC4CEE3;
	Fri, 27 Jun 2025 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751019496;
	bh=59yKkmHKHzTvVqB97//5M2vZb5P72XKwlSH8cosqitA=;
	h=From:To:Cc:Subject:Date:From;
	b=yvlhYmA+VXxhxsY0rvjt/bwczlHkS7gfS8bCQbf0dbKDRTZN4nIfQT3Uzg0TAaTJS
	 oHXxizHIvSJAN3mwnbfRJDl9Yna7Z3z011MRNzdj0v/3zeWA/IEJeO0DIQSo8F//sJ
	 yBi0PpdWIFJe/F3WARaDwlusftIz4sPerxVILBLA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.186
Date: Fri, 27 Jun 2025 11:18:03 +0100
Message-ID: <2025062704-sectional-bonded-4df8@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.186 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt        |    7 
 Makefile                                               |    6 
 arch/arm/boot/dts/am335x-bone-common.dtsi              |    8 
 arch/arm/boot/dts/at91sam9263ek.dts                    |    2 
 arch/arm/boot/dts/qcom-apq8064.dtsi                    |   13 
 arch/arm/boot/dts/tny_a9263.dts                        |    2 
 arch/arm/boot/dts/usb_a9263.dts                        |    4 
 arch/arm/mach-omap2/clockdomain.h                      |    1 
 arch/arm/mach-omap2/clockdomains33xx_data.c            |    2 
 arch/arm/mach-omap2/cm33xx.c                           |   14 
 arch/arm/mach-omap2/pmic-cpcap.c                       |    6 
 arch/arm/mm/ioremap.c                                  |    4 
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi   |    1 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi   |    1 
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts    |    8 
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi               |   20 -
 arch/arm64/include/asm/cputype.h                       |    2 
 arch/arm64/include/asm/debug-monitors.h                |   12 
 arch/arm64/include/asm/insn-def.h                      |   14 
 arch/arm64/include/asm/insn.h                          |   81 +++++
 arch/arm64/include/asm/spectre.h                       |    3 
 arch/arm64/kernel/proton-pack.c                        |   21 +
 arch/arm64/kernel/ptrace.c                             |    2 
 arch/arm64/lib/insn.c                                  |  199 ++++++++++++-
 arch/arm64/net/bpf_jit.h                               |   11 
 arch/arm64/net/bpf_jit_comp.c                          |   58 +++
 arch/arm64/xen/hypercall.S                             |   21 +
 arch/m68k/mac/config.c                                 |    2 
 arch/mips/Makefile                                     |    6 
 arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts |    1 
 arch/mips/loongson2ef/Platform                         |    2 
 arch/mips/vdso/Makefile                                |    1 
 arch/nios2/include/asm/pgtable.h                       |   16 +
 arch/parisc/boot/compressed/Makefile                   |    1 
 arch/powerpc/kernel/eeh.c                              |    2 
 arch/powerpc/platforms/book3s/vas-api.c                |    9 
 arch/powerpc/platforms/powernv/memtrace.c              |    8 
 arch/powerpc/platforms/pseries/msi.c                   |    7 
 arch/s390/net/bpf_jit_comp.c                           |   12 
 arch/s390/pci/pci_mmio.c                               |    2 
 arch/x86/boot/compressed/Makefile                      |    2 
 arch/x86/kernel/cpu/bugs.c                             |   10 
 arch/x86/kernel/cpu/common.c                           |   17 -
 arch/x86/kernel/cpu/mtrr/generic.c                     |    2 
 arch/x86/kernel/ioport.c                               |   13 
 arch/x86/kernel/process.c                              |    6 
 block/Kconfig                                          |    8 
 block/bdev.c                                           |    2 
 crypto/lrw.c                                           |    4 
 crypto/xts.c                                           |    4 
 drivers/acpi/acpica/dsutils.c                          |    9 
 drivers/acpi/acpica/psobject.c                         |   52 +--
 drivers/acpi/acpica/utprint.c                          |    7 
 drivers/acpi/apei/Kconfig                              |    1 
 drivers/acpi/apei/ghes.c                               |    2 
 drivers/acpi/battery.c                                 |   19 +
 drivers/acpi/bus.c                                     |    6 
 drivers/acpi/osi.c                                     |    1 
 drivers/ata/pata_via.c                                 |    3 
 drivers/atm/atmtcp.c                                   |    4 
 drivers/base/power/domain.c                            |    2 
 drivers/base/power/main.c                              |    3 
 drivers/base/power/runtime.c                           |    2 
 drivers/base/swnode.c                                  |    2 
 drivers/block/aoe/aoedev.c                             |    8 
 drivers/bus/fsl-mc/fsl-mc-bus.c                        |    6 
 drivers/bus/fsl-mc/fsl-mc-uapi.c                       |    4 
 drivers/bus/fsl-mc/mc-io.c                             |   19 -
 drivers/bus/fsl-mc/mc-sys.c                            |    2 
 drivers/bus/mhi/host/pm.c                              |   18 +
 drivers/bus/ti-sysc.c                                  |   49 ---
 drivers/clk/bcm/clk-raspberrypi.c                      |    2 
 drivers/clk/meson/g12a.c                               |    1 
 drivers/clk/qcom/gcc-msm8939.c                         |    4 
 drivers/clk/qcom/gcc-sm6350.c                          |    6 
 drivers/clk/rockchip/clk-rk3036.c                      |    1 
 drivers/cpufreq/acpi-cpufreq.c                         |    2 
 drivers/cpufreq/cpufreq.c                              |    6 
 drivers/cpufreq/scmi-cpufreq.c                         |   36 ++
 drivers/cpufreq/tegra186-cpufreq.c                     |    7 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h           |    2 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    2 
 drivers/crypto/marvell/cesa/cesa.c                     |    2 
 drivers/crypto/marvell/cesa/cesa.h                     |    9 
 drivers/crypto/marvell/cesa/cipher.c                   |    3 
 drivers/crypto/marvell/cesa/hash.c                     |    2 
 drivers/crypto/marvell/cesa/tdma.c                     |   53 ++-
 drivers/dma-buf/udmabuf.c                              |    5 
 drivers/dma/ti/k3-udma.c                               |    3 
 drivers/edac/altera_edac.c                             |    6 
 drivers/edac/skx_common.c                              |    1 
 drivers/firmware/Kconfig                               |    1 
 drivers/firmware/arm_sdei.c                            |   11 
 drivers/firmware/psci/psci.c                           |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                 |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                  |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c                  |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                  |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                  |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |   18 -
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile          |    2 
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile          |    2 
 drivers/gpu/drm/amd/display/dc/dml/Makefile            |    3 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c    |    8 
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c     |    5 
 drivers/gpu/drm/bridge/analogix/anx7625.c              |    8 
 drivers/gpu/drm/meson/meson_drv.c                      |    2 
 drivers/gpu/drm/meson/meson_drv.h                      |    2 
 drivers/gpu/drm/meson/meson_encoder_hdmi.c             |   29 +
 drivers/gpu/drm/meson/meson_vclk.c                     |  226 ++++++++-------
 drivers/gpu/drm/meson/meson_vclk.h                     |   13 
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c                  |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |    3 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c             |    7 
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c                    |   14 
 drivers/gpu/drm/nouveau/nouveau_backlight.c            |    2 
 drivers/gpu/drm/rcar-du/rcar_du_kms.c                  |   10 
 drivers/gpu/drm/tegra/rgb.c                            |   14 
 drivers/gpu/drm/vkms/vkms_crtc.c                       |    2 
 drivers/hid/hid-hyperv.c                               |    5 
 drivers/hid/usbhid/hid-core.c                          |   25 -
 drivers/hwmon/occ/common.c                             |  249 +++++++----------
 drivers/i2c/busses/i2c-designware-slave.c              |    2 
 drivers/i2c/busses/i2c-npcm7xx.c                       |   12 
 drivers/iio/accel/fxls8962af-core.c                    |   15 -
 drivers/iio/adc/ad7124.c                               |    4 
 drivers/iio/adc/ad7606_spi.c                           |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c       |    8 
 drivers/infiniband/core/cm.c                           |   16 -
 drivers/infiniband/core/iwcm.c                         |   29 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c             |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h             |    1 
 drivers/infiniband/hw/hns/hns_roce_main.c              |    1 
 drivers/infiniband/hw/hns/hns_roce_restrack.c          |    1 
 drivers/infiniband/hw/mlx5/qpc.c                       |   30 +-
 drivers/input/misc/ims-pcu.c                           |    6 
 drivers/input/misc/sparcspkr.c                         |   22 +
 drivers/input/rmi4/rmi_f34.c                           |  137 +++++----
 drivers/iommu/amd/iommu.c                              |    8 
 drivers/iommu/iommu.c                                  |    4 
 drivers/md/dm-raid1.c                                  |    5 
 drivers/media/common/videobuf2/videobuf2-dma-sg.c      |    4 
 drivers/media/i2c/ccs-pll.c                            |   23 +
 drivers/media/i2c/imx334.c                             |   18 +
 drivers/media/i2c/ov8856.c                             |    9 
 drivers/media/i2c/tc358743.c                           |    4 
 drivers/media/platform/exynos4-is/fimc-is-regs.c       |    1 
 drivers/media/platform/qcom/venus/core.c               |   16 -
 drivers/media/platform/ti-vpe/cal-video.c              |    4 
 drivers/media/test-drivers/vidtv/vidtv_channel.c       |    2 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c       |    2 
 drivers/media/usb/dvb-usb/cxusb.c                      |    3 
 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c         |    7 
 drivers/media/usb/uvc/uvc_ctrl.c                       |   23 +
 drivers/media/usb/uvc/uvc_driver.c                     |   27 +
 drivers/media/v4l2-core/v4l2-dev.c                     |   14 
 drivers/mfd/exynos-lpass.c                             |    1 
 drivers/mfd/stmpe-spi.c                                |    2 
 drivers/misc/vmw_vmci/vmci_host.c                      |   11 
 drivers/mtd/nand/raw/sunxi_nand.c                      |    2 
 drivers/net/can/m_can/tcan4x5x-core.c                  |    9 
 drivers/net/ethernet/aquantia/atlantic/aq_main.c       |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c        |    2 
 drivers/net/ethernet/cadence/macb_main.c               |    6 
 drivers/net/ethernet/dlink/dl2k.c                      |   14 
 drivers/net/ethernet/dlink/dl2k.h                      |    2 
 drivers/net/ethernet/emulex/benet/be_cmds.c            |    2 
 drivers/net/ethernet/google/gve/gve_main.c             |    2 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c           |    3 
 drivers/net/ethernet/intel/i40e/i40e_common.c          |    7 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c     |   11 
 drivers/net/ethernet/intel/ice/ice_arfs.c              |   48 +++
 drivers/net/ethernet/intel/ice/ice_sched.c             |   11 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c     |    9 
 drivers/net/ethernet/mediatek/mtk_star_emac.c          |    4 
 drivers/net/ethernet/mellanox/mlx4/en_clock.c          |    2 
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c        |    1 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c      |    5 
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c        |   18 -
 drivers/net/ethernet/microchip/lan743x_main.c          |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c  |   11 
 drivers/net/macsec.c                                   |   40 ++
 drivers/net/phy/mdio_bus.c                             |   16 -
 drivers/net/phy/mscc/mscc_ptp.c                        |    4 
 drivers/net/usb/aqc111.c                               |   10 
 drivers/net/usb/ch9200.c                               |    7 
 drivers/net/vmxnet3/vmxnet3_drv.c                      |   26 +
 drivers/net/vxlan/vxlan_core.c                         |    8 
 drivers/net/wireguard/device.c                         |    1 
 drivers/net/wireless/ath/ath10k/snoc.c                 |    4 
 drivers/net/wireless/ath/ath11k/core.c                 |    8 
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c        |    3 
 drivers/net/wireless/ath/carl9170/usb.c                |   19 -
 drivers/net/wireless/intersil/p54/fwio.c               |    2 
 drivers/net/wireless/intersil/p54/p54.h                |    1 
 drivers/net/wireless/intersil/p54/txrx.c               |   13 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c        |    2 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c   |   13 
 drivers/net/wireless/realtek/rtlwifi/pci.c             |   10 
 drivers/net/wireless/realtek/rtw88/coex.c              |    2 
 drivers/net/wireless/realtek/rtw88/rtw8822c.c          |    3 
 drivers/nvme/target/fcloop.c                           |   31 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c       |    5 
 drivers/pci/controller/cadence/pcie-cadence-host.c     |   11 
 drivers/pci/controller/dwc/pcie-dw-rockchip.c          |    2 
 drivers/pci/pci.c                                      |    3 
 drivers/pci/pcie/dpc.c                                 |    2 
 drivers/pci/quirks.c                                   |   23 +
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c            |   35 +-
 drivers/pinctrl/pinctrl-at91.c                         |    6 
 drivers/pinctrl/pinctrl-mcp23s08.c                     |    8 
 drivers/platform/x86/dell/dell_rbu.c                   |    6 
 drivers/power/reset/at91-reset.c                       |    5 
 drivers/power/supply/bq27xxx_battery.c                 |    2 
 drivers/power/supply/bq27xxx_battery_i2c.c             |   13 
 drivers/ptp/ptp_private.h                              |   12 
 drivers/rapidio/rio_cm.c                               |    3 
 drivers/regulator/max14577-regulator.c                 |    5 
 drivers/remoteproc/qcom_wcnss_iris.c                   |    2 
 drivers/remoteproc/remoteproc_core.c                   |    6 
 drivers/rpmsg/qcom_smd.c                               |    2 
 drivers/rtc/class.c                                    |    2 
 drivers/rtc/lib.c                                      |   24 +
 drivers/rtc/rtc-sh.c                                   |   12 
 drivers/s390/scsi/zfcp_sysfs.c                         |    2 
 drivers/scsi/elx/efct/efct_hw.c                        |    5 
 drivers/scsi/lpfc/lpfc_hbadisc.c                       |    2 
 drivers/scsi/lpfc/lpfc_sli.c                           |    4 
 drivers/scsi/qedf/qedf_main.c                          |    2 
 drivers/scsi/scsi_transport_iscsi.c                    |   11 
 drivers/scsi/storvsc_drv.c                             |   10 
 drivers/scsi/ufs/ufshcd.c                              |    7 
 drivers/soc/aspeed/aspeed-lpc-snoop.c                  |   17 -
 drivers/soc/ti/omap_prm.c                              |    8 
 drivers/spi/spi-bcm63xx-hsspi.c                        |    2 
 drivers/spi/spi-bcm63xx.c                              |    2 
 drivers/spi/spi-sh-msiof.c                             |   13 
 drivers/staging/iio/impedance-analyzer/ad5933.c        |    2 
 drivers/staging/media/rkvdec/rkvdec.c                  |   24 +
 drivers/tee/tee_core.c                                 |   11 
 drivers/thermal/qcom/tsens.c                           |   10 
 drivers/thunderbolt/ctl.c                              |    5 
 drivers/tty/serial/milbeaut_usio.c                     |    5 
 drivers/tty/serial/sh-sci.c                            |   97 +++++-
 drivers/tty/vt/vt_ioctl.c                              |    2 
 drivers/uio/uio_hv_generic.c                           |    4 
 drivers/usb/cdns3/cdnsp-gadget.c                       |   21 +
 drivers/usb/cdns3/cdnsp-gadget.h                       |    4 
 drivers/usb/class/usbtmc.c                             |   21 -
 drivers/usb/core/hub.c                                 |   16 -
 drivers/usb/core/quirks.c                              |    3 
 drivers/usb/gadget/function/f_hid.c                    |   12 
 drivers/usb/renesas_usbhs/common.c                     |   50 ++-
 drivers/usb/serial/pl2303.c                            |    2 
 drivers/usb/storage/unusual_uas.h                      |    7 
 drivers/usb/typec/tcpm/tcpci_maxim.c                   |    3 
 drivers/vfio/vfio_iommu_type1.c                        |    2 
 drivers/video/backlight/qcom-wled.c                    |    6 
 drivers/video/console/vgacon.c                         |    2 
 drivers/video/fbdev/core/fbcvt.c                       |    2 
 drivers/video/fbdev/core/fbmem.c                       |    4 
 drivers/watchdog/da9052_wdt.c                          |    1 
 fs/configfs/dir.c                                      |    2 
 fs/exfat/nls.c                                         |    1 
 fs/ext4/ext4.h                                         |    8 
 fs/ext4/extents.c                                      |   39 +-
 fs/ext4/file.c                                         |    7 
 fs/ext4/inline.c                                       |    2 
 fs/ext4/inode.c                                        |    3 
 fs/ext4/ioctl.c                                        |    8 
 fs/ext4/super.c                                        |   15 -
 fs/f2fs/data.c                                         |    4 
 fs/f2fs/f2fs.h                                         |   10 
 fs/f2fs/namei.c                                        |   19 -
 fs/f2fs/super.c                                        |   12 
 fs/filesystems.c                                       |   14 
 fs/gfs2/inode.c                                        |    3 
 fs/gfs2/lock_dlm.c                                     |    3 
 fs/jbd2/transaction.c                                  |    5 
 fs/jffs2/erase.c                                       |    4 
 fs/jffs2/scan.c                                        |    4 
 fs/jffs2/summary.c                                     |    7 
 fs/jfs/jfs_discard.c                                   |    3 
 fs/jfs/jfs_dtree.c                                     |   18 +
 fs/namespace.c                                         |    6 
 fs/nfs/super.c                                         |   19 +
 fs/nfsd/nfs4proc.c                                     |    3 
 fs/nfsd/nfssvc.c                                       |    6 
 fs/nilfs2/btree.c                                      |    4 
 fs/nilfs2/direct.c                                     |    3 
 fs/ntfs3/index.c                                       |    8 
 fs/ocfs2/quota_local.c                                 |    2 
 fs/squashfs/super.c                                    |    5 
 fs/xfs/xfs_inode.c                                     |   15 -
 include/acpi/actypes.h                                 |    2 
 include/linux/arm_sdei.h                               |    4 
 include/linux/atmdev.h                                 |    6 
 include/linux/hid.h                                    |    3 
 include/linux/hugetlb.h                                |    3 
 include/linux/mlx5/driver.h                            |    1 
 include/linux/mm.h                                     |    3 
 include/linux/mm_types.h                               |    3 
 include/net/checksum.h                                 |    2 
 include/net/sock.h                                     |    7 
 include/trace/events/erofs.h                           |   18 -
 include/uapi/linux/bpf.h                               |    2 
 include/uapi/linux/videodev2.h                         |   12 
 ipc/shm.c                                              |    5 
 kernel/bpf/core.c                                      |    2 
 kernel/events/core.c                                   |   57 +++
 kernel/exit.c                                          |   17 -
 kernel/power/wakelock.c                                |    3 
 kernel/time/clocksource.c                              |    2 
 kernel/time/posix-cpu-timers.c                         |    9 
 kernel/trace/bpf_trace.c                               |    2 
 kernel/trace/ftrace.c                                  |   10 
 kernel/trace/trace.c                                   |    2 
 lib/Kconfig                                            |    1 
 mm/huge_memory.c                                       |    2 
 mm/hugetlb.c                                           |   81 +++--
 mm/mmap.c                                              |    8 
 mm/page-writeback.c                                    |    2 
 net/atm/common.c                                       |    1 
 net/atm/lec.c                                          |   12 
 net/atm/raw.c                                          |    2 
 net/bluetooth/l2cap_core.c                             |    3 
 net/bridge/br_multicast.c                              |   77 ++++-
 net/bridge/netfilter/nf_conntrack_bridge.c             |   12 
 net/core/filter.c                                      |    5 
 net/core/skmsg.c                                       |   25 +
 net/core/sock.c                                        |    4 
 net/core/utils.c                                       |    4 
 net/dsa/tag_brcm.c                                     |    2 
 net/ipv4/route.c                                       |    4 
 net/ipv4/tcp_input.c                                   |   63 ++--
 net/ipv6/calipso.c                                     |    8 
 net/ipv6/ila/ila_common.c                              |    6 
 net/ipv6/netfilter.c                                   |   12 
 net/ipv6/netfilter/nft_fib_ipv6.c                      |   13 
 net/ipv6/seg6_local.c                                  |    6 
 net/mac80211/mesh_hwmp.c                               |    6 
 net/mpls/af_mpls.c                                     |    4 
 net/ncsi/internal.h                                    |   21 -
 net/ncsi/ncsi-pkt.h                                    |   23 -
 net/ncsi/ncsi-rsp.c                                    |   21 -
 net/netfilter/nft_quota.c                              |   20 -
 net/netfilter/nft_set_pipapo_avx2.c                    |   21 +
 net/netfilter/nft_tunnel.c                             |    8 
 net/netlabel/netlabel_kapi.c                           |    5 
 net/nfc/nci/uart.c                                     |    8 
 net/openvswitch/flow.c                                 |    2 
 net/sched/sch_ets.c                                    |   10 
 net/sched/sch_prio.c                                   |    2 
 net/sched/sch_red.c                                    |    2 
 net/sched/sch_sfq.c                                    |  119 +++++---
 net/sched/sch_tbf.c                                    |    2 
 net/sctp/socket.c                                      |    3 
 net/sunrpc/cache.c                                     |   17 -
 net/tipc/crypto.c                                      |    8 
 net/tipc/udp_media.c                                   |    4 
 net/tls/tls_sw.c                                       |    7 
 scripts/Kconfig.include                                |    2 
 scripts/Makefile.clang                                 |    3 
 scripts/Makefile.compiler                              |    8 
 scripts/as-version.sh                                  |    2 
 security/selinux/xfrm.c                                |    2 
 sound/pci/hda/hda_intel.c                              |    2 
 sound/pci/hda/patch_realtek.c                          |    1 
 sound/soc/codecs/tas2770.c                             |   30 +-
 sound/soc/meson/meson-card-utils.c                     |    2 
 sound/soc/qcom/sdm845.c                                |    4 
 sound/soc/tegra/tegra210_ahub.c                        |    2 
 sound/usb/implicit.c                                   |    1 
 sound/usb/mixer_maps.c                                 |   12 
 tools/include/uapi/linux/bpf.h                         |    2 
 tools/lib/bpf/bpf_core_read.h                          |    6 
 tools/lib/bpf/btf.c                                    |   16 +
 tools/lib/bpf/libbpf.c                                 |    2 
 tools/lib/bpf/linker.c                                 |    4 
 tools/lib/bpf/nlattr.c                                 |   15 -
 tools/perf/Makefile.config                             |    2 
 tools/perf/builtin-record.c                            |    2 
 tools/perf/scripts/python/exported-sql-viewer.py       |    5 
 tools/perf/tests/switch-tracking.c                     |    2 
 tools/perf/ui/browsers/hists.c                         |    2 
 tools/testing/selftests/seccomp/seccomp_bpf.c          |    7 
 tools/testing/selftests/x86/Makefile                   |    2 
 tools/testing/selftests/x86/sigtrap_loop.c             |  101 ++++++
 usr/include/Makefile                                   |    2 
 391 files changed, 3112 insertions(+), 1409 deletions(-)

Adam Ford (2):
      arm64: dts: imx8mm-beacon: Fix RTC capacitive load
      arm64: dts: imx8mn-beacon: Fix RTC capacitive load

Aditya Dutt (1):
      jfs: fix array-index-out-of-bounds read in add_missing_indices

Adrian Hunter (1):
      perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3

Ahmed S. Darwish (1):
      x86/cpu: Sanitize CPUID(0x80000000) output

Ahmed Salem (1):
      ACPICA: Avoid sequence overread in call to strncmp()

Akhil P Oommen (1):
      drm/msm/a6xx: Increase HFI response timeout

Al Viro (2):
      fix propagation graph breakage by MOVE_MOUNT_SET_GROUP move_mount(2)
      do_change_type(): refuse to operate on unmounted/not ours mounts

Alan Maguire (1):
      libbpf: Add identical pointer detection to btf_dedup_is_equiv()

Alex Deucher (5):
      drm/amdgpu/gfx6: fix CSIB handling
      drm/amdgpu/gfx10: fix CSIB handling
      drm/amdgpu/gfx7: fix CSIB handling
      drm/amdgpu/gfx8: fix CSIB handling
      drm/amdgpu/gfx9: fix CSIB handling

Alexander Aring (1):
      gfs2: move msleep to sleepable context

Alexander Shiyan (1):
      power: reset: at91-reset: Optimize at91_reset()

Alexander Sverdlin (1):
      Revert "bus: ti-sysc: Probe for l4_wkup and l4_cfg interconnect devices first"

Alexandre Mergnat (2):
      rtc: Make rtc_time64_to_tm() support dates before 1970
      rtc: Fix offset calculation for .start_secs < 0

Alexey Gladkov (1):
      mfd: stmpe-spi: Correct the name used in MODULE_DEVICE_TABLE

Alexey Kodanev (1):
      wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds

Alok Tiwari (4):
      gve: Fix RX_BUFFERS_POSTED stat to report per-queue fill_cnt
      gve: add missing NULL check for gve_alloc_pending_packet() in TX DQO
      scsi: iscsi: Fix incorrect error path labels for flashnode operations
      emulex/benet: correct command version selection in be_cmd_get_stats()

Amber Lin (1):
      drm/amdkfd: Set SDMA_RLCx_IB_CNTL/SWITCH_INSIDE_IB

Amit Sunil Dhamne (1):
      usb: typec: tcpm/tcpci_maxim: Fix bounds check in process_rx()

Andreas Gruenbacher (1):
      gfs2: gfs2_create_inode error handling fix

Andreas Kemnade (1):
      ARM: omap: pmic-cpcap: do not mess around without CPCAP or OMAP4

Andrew Lunn (1):
      net: mdio: C22 is now optional, EOPNOTSUPP if not provided

Andrew Morton (1):
      drivers/rapidio/rio_cm.c: prevent possible heap overwrite

Andrey Vatoropin (1):
      fs/ntfs3: handle hdr_first_de() return value

Andy Shevchenko (1):
      pinctrl: at91: Fix possible out-of-boundary access

Anton Protopopov (3):
      libbpf: Use proper errno value in linker
      bpf: Fix uninitialized values in BPF_{CORE,PROBE}_READ
      libbpf: Use proper errno value in nlattr

Armin Wolf (2):
      ACPI: OSI: Stop advertising support for "3.0 _SCP Extensions"
      ACPI: bus: Bail out if acpi_kobj registration fails

Arnaldo Carvalho de Melo (2):
      perf build: Warn when libdebuginfod devel files are not available
      perf ui browser hists: Set actions->thread before calling do_zoom_thread()

Arnd Bergmann (4):
      kbuild: hdrcheck: fix cross build with clang
      parisc: fix building with gcc-15
      hwmon: (occ) Rework attribute registration for stack usage
      hwmon: (occ) fix unaligned accesses

Artem Sadovnikov (1):
      jffs2: check that raw node were preallocated before writing summary

Ayushi Makhija (1):
      drm/bridge: anx7625: change the gpiod_set_value API

Benjamin Berg (1):
      wifi: mac80211: do not offer a mesh path if forwarding is disabled

Biju Das (2):
      drm: rcar-du: Fix memory leak in rcar_du_vsps_init()
      drm/tegra: rgb: Fix the unbound reference count

Bjorn Helgaas (1):
      PCI/DPC: Initialize aer_err_info before using it

Breno Leitao (1):
      Revert "x86/bugs: Make spectre user default depend on MITIGATION_SPECTRE_V2" on v6.6 and older

Brett Werling (1):
      can: tcan4x5x: fix power regulator retrieval during probe

Caleb Connolly (1):
      ath10k: snoc: fix unbalanced IRQ enable in crash recovery

Carlos Fernandez (1):
      macsec: MACsec SCI assignment for ES = 0

Chao Yu (4):
      f2fs: fix to do sanity check on sbi->total_valid_block_count
      f2fs: clean up w/ fscrypt_is_bounce_page()
      f2fs: fix to detect gcing page in f2fs_is_cp_guaranteed()
      f2fs: fix to do sanity check on sit_bitmap_size

Charalampos Mitrodimas (1):
      net: tipc: fix refcount warning in tipc_aead_encrypt

Charan Teja Kalla (1):
      PM: runtime: fix denying of auto suspend in pm_suspend_timer_fn()

Charles Han (1):
      drm/amd/pp: Fix potential NULL pointer dereference in atomctrl_initialize_mc_reg_table

Charles Yeh (1):
      USB: serial: pl2303: add new chip PL2303GC-Q20 and PL2303GT-2AB

Christian Lamparter (1):
      wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()

Christoph Hellwig (1):
      block: default BLOCK_LEGACY_AUTOLOAD to y

Christophe JAILLET (1):
      mfd: exynos-lpass: Avoid calling exynos_lpass_disable() twice in exynos_lpass_remove()

Claudiu Beznea (4):
      serial: sh-sci: Check if TX data was written to device in .tx_empty()
      serial: sh-sci: Move runtime PM enable to sci_probe_single()
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit
      serial: sh-sci: Increment the runtime usage counter for the earlycon device

Colin Foster (1):
      ARM: dts: am335x-bone-common: Increase MDIO reset deassert time

Cong Wang (1):
      sch_ets: make est_qlen_notify() idempotent

Corentin Labbe (1):
      crypto: sun8i-ss - do not use sg_dma_len before calling DMA functions

Da Xue (1):
      clk: meson-g12a: add missing fclk_div2 to spicc

Damon Ding (1):
      drm/bridge: analogix_dp: Add irq flag IRQF_NO_AUTOEN instead of calling disable_irq()

Dan Carpenter (5):
      remoteproc: qcom_wcnss_iris: Add missing put_device() on error in probe
      rpmsg: qcom_smd: Fix uninitialized return variable in __qcom_smd_send()
      net/mlx4_en: Prevent potential integer overflow calculating Hz
      pmdomain: core: Fix error checking in genpd_dev_pm_attach_by_id()
      Input: ims-pcu - check record size in ims_pcu_flash_firmware()

Daniel Wagner (2):
      nvmet-fcloop: access fcpreq only when holding reqlock
      scsi: lpfc: Use memcpy() for BIOS version

Dapeng Mi (1):
      perf record: Fix incorrect --user-regs comments

Darrick J. Wong (1):
      xfs: allow inode inactivation during a ro mount log recovery

Dave Penkler (2):
      usb: usbtmc: Fix timeout value in get_stb
      usb: usbtmc: Fix read_stb function and get_stb ioctl

David Heimann (1):
      ALSA: usb-audio: Add implicit feedback quirk for RODE AI-1

David Lechner (1):
      iio: adc: ad7606_spi: fix reg write value mask

Denis Arefev (1):
      media: vivid: Change the siize of the composing

Dexuan Cui (1):
      scsi: storvsc: Increase the timeouts to storvsc_timeout

Diederik de Haas (1):
      PCI: dw-rockchip: Fix PHY function call sequence in rockchip_pcie_phy_deinit()

Dmitry Antipov (2):
      wifi: rtw88: do not ignore hardware read error during DPK
      wifi: carl9170: do not ping device which has failed to load firmware

Dmitry Baryshkov (3):
      ARM: dts: qcom: apq8064 merge hw splinlock into corresponding syscon device
      drm/msm/hdmi: add runtime PM calls to DDC transfer function
      drm/msm/dpu: don't select single flush for active CTL blocks

Dmitry Torokhov (1):
      Input: synaptics-rmi - fix crash with unsupported versions of F34

Dylan Wolff (1):
      jfs: Fix null-ptr-deref in jfs_ioc_trim

Eddie James (1):
      hwmon: (occ) Add soft minimum power cap attribute

Edward Adam Davis (2):
      media: cxusb: no longer judge rbuf when the write fails
      media: vidtv: Terminating the subsequent process of initialization failure

Eric Dumazet (13):
      net_sched: sch_sfq: fix a potential crash on gso_skb handling
      net_sched: prio: fix a race in prio_tune()
      net_sched: red: fix a race in __red_change()
      net_sched: tbf: fix a race in tbf_change()
      net_sched: ets: fix a race in ets_qdisc_change()
      calipso: unlock rcu before returning -EAFNOSUPPORT
      tcp: always seek for minimal rtt in tcp_rcv_rtt_update()
      tcp: fix initial tp->rcvq_space.space value for passive TS enabled flows
      net: atm: add lec_mutex
      net: atm: fix /proc/net/atm/lec handling
      net_sched: sch_sfq: annotate data-races around q->perturb_period
      net_sched: sch_sfq: handle bigger packets
      net_sched: sch_sfq: reject invalid perturb period

Faicker Mo (1):
      net: openvswitch: Fix the dead loop of MPLS parse

Fedor Pchelkin (1):
      jffs2: check jffs2_prealloc_raw_node_refs() result in few other places

Fernando Fernandez Mancera (1):
      netfilter: nft_tunnel: fix geneve_opt dump

Finn Thain (1):
      m68k: mac: Fix macintosh_config for Mac II

Florian Westphal (2):
      netfilter: nf_tables: nft_fib_ipv6: fix VRF ipv4/ipv6 result discrepancy
      netfilter: nf_set_pipapo_avx2: fix initial map fill

GONG Ruiqi (1):
      vgacon: Add check for vc_origin address range in vgacon_scroll()

Gabor Juhos (6):
      pinctrl: armada-37xx: use correct OUTPUT_VAL register for GPIOs > 31
      pinctrl: armada-37xx: set GPIO output value before setting direction
      pinctrl: armada-37xx: propagate error from armada_37xx_pmx_set_by_name()
      pinctrl: armada-37xx: propagate error from armada_37xx_gpio_get_direction()
      pinctrl: armada-37xx: propagate error from armada_37xx_pmx_gpio_set_direction()
      pinctrl: armada-37xx: propagate error from armada_37xx_gpio_get()

Gabriel Shahrouzi (1):
      staging: iio: ad5933: Correct settling cycles encoding per datasheet

Gao Xiang (1):
      erofs: remove unused trace event erofs_destroy_inode

Gautam Menghani (1):
      powerpc/pseries/msi: Avoid reading PCI device registers in reduced power states

Gautham R. Shenoy (1):
      acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()

Gavin Guo (1):
      mm/huge_memory: fix dereferencing invalid pmd migration entry

Geert Uytterhoeven (2):
      spi: sh-msiof: Fix maximum DMA transfer size
      ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms

George Moussalem (1):
      thermal/drivers/qcom/tsens: Update conditions to strictly evaluate for IP v2+

Greg Kroah-Hartman (1):
      Linux 5.15.186

Guilherme G. Piccoli (1):
      clocksource: Fix the CPUs' choice in the watchdog per CPU verification

Haixia Qu (1):
      tipc: fix null-ptr-deref when acquiring remote ip of ethernet bearer

Hans Verkuil (1):
      media: tc358743: ignore video while HPD is low

Hans Zhang (1):
      PCI: cadence: Fix runtime atomic count underflow

Haren Myneni (1):
      powerpc/vas: Return -EINVAL if the offset is non-zero in mmap()

Hari Kalavakunta (1):
      net: ncsi: Fix GCPS 64-bit member variables

Hector Martin (1):
      ASoC: tas2770: Power cycle amp on ISENSE/VSENSE change

Heiko Carstens (1):
      s390/pci: Fix __pcilg_mio_inuser() inline assembly

Heiko Stuebner (1):
      clk: rockchip: rk3036: mark ddrphy as critical

Henk Vergonet (1):
      wifi: mt76: mt76x2: Add support for LiteOn WN4516R,WN4519R

Henry Martin (5):
      clk: bcm: rpi: Add NULL check in raspberrypi_clk_register()
      soc: aspeed: Add NULL check in aspeed_lpc_enable_snoop()
      backlight: pm8941: Add NULL check in wled_configure()
      dmaengine: ti: Add NULL check in udma_probe()
      serial: Fix potential null-ptr-deref in mlb_usio_probe()

Herbert Xu (5):
      crypto: marvell/cesa - Handle zero-length skcipher requests
      crypto: marvell/cesa - Avoid empty transfer descriptor
      crypto: lrw - Only add ecb if it is not already there
      crypto: xts - Only add ecb if it is not already there
      crypto: marvell/cesa - Do not chain submitted requests

Hongyu Xie (1):
      usb: storage: Ignore UAS driver for SanDisk 3.2 Gen2 storage device

Horatiu Vultur (1):
      net: phy: mscc: Stop clearing the the UDPv4 checksum for L2 frames

Hou Tao (2):
      arm64: move AARCH64_BREAK_FAULT into insn-def.h
      arm64: insn: add encoders for atomic operations

Huacai Chen (1):
      PCI: Add ACS quirk for Loongson PCIe

Huajian Yang (1):
      netfilter: bridge: Move specific fragmented packet to slow_path instead of dropping it

Huang Yiwei (1):
      firmware: SDEI: Allow sdei initialization without ACPI_APEI_GHES

I Hsin Cheng (1):
      drm/meson: Use 1000ULL when operating with mode->clock

Ido Schimmel (2):
      seg6: Fix validation of nexthop addresses
      vxlan: Do not treat dst cache initialization errors as fatal

Ilpo Järvinen (1):
      PCI: Fix lock symmetry in pci_slot_unlock()

Ilya Leoshkevich (1):
      s390/bpf: Store backchain even for leaf progs

Ioana Ciornei (2):
      bus: fsl-mc: fix double-free on mc_dev
      bus: fsl-mc: do not add a device-link for the UAPI used DPMCP device

Jacob Keller (1):
      drm/nouveau/bl: increase buffer size to avoid truncate warning

Jacob Moroni (1):
      IB/cm: use rwlock for MAD agent lock

Jaegeuk Kim (1):
      f2fs: prevent kernel warning due to negative i_nlink from corrupted image

Jakub Raczynski (1):
      net/mdiobus: Fix potential out-of-bounds read/write access

James Morse (6):
      arm64: insn: Add support for encoding DSB
      arm64: proton-pack: Expose whether the platform is mitigated by firmware
      arm64: proton-pack: Expose whether the branchy loop k value
      arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
      arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
      arm64: proton-pack: Add new CPUs 'k' values for branch mitigation

Jan Kara (3):
      ext4: fix calculation of credits for extent tree modification
      ext4: make 'abort' mount option handling standard
      ext4: avoid remount errors with 'abort' mount option

Jann Horn (3):
      tee: Prevent size calculation wraparound on 32-bit kernels
      mm/hugetlb: unshare page tables during VMA split, not before
      mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race

Jason Gunthorpe (1):
      iommu: Protect against overflow in iommu_pgsize()

Jason Xing (2):
      net: atlantic: generate software timestamp just before the doorbell
      net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag when getting ts info

Jeff Hugo (1):
      bus: mhi: host: Fix conflict between power_up and SYSERR

Jeongjun Park (3):
      ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()
      jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
      ipc: fix to protect IPCS lookups using RCU

Jerry Lv (1):
      power: supply: bq27xxx: Retrieve again when busy

Jiaqing Zhao (1):
      x86/mtrr: Check if fixed-range MTRRs exist in mtrr_save_fixed_ranges()

Jiayi Li (1):
      usb: quirks: Add NO_LPM quirk for SanDisk Extreme 55AE

Jiayuan Chen (4):
      bpf, sockmap: fix duplicated data transmission
      ktls, sockmap: Fix missing uncharge operation
      bpf, sockmap: Avoid using sk_socket after free when sending
      bpf, sockmap: Fix data lost during EAGAIN retries

Jinliang Zheng (1):
      mm: fix ratelimit_pages update error in dirty_ratio_handler()

Johan Hovold (1):
      media: ov8856: suppress probe deferral errors

Jon Hunter (1):
      Revert "cpufreq: tegra186: Share policy per cluster"

Jonas Karlman (1):
      media: rkvdec: Fix frame size enumeration

Jonathan Lane (1):
      ALSA: hda/realtek: enable headset mic on Latitude 5420 Rugged

Judith Mendez (2):
      arm64: dts: ti: k3-am65-main: Fix sdhci node properties
      arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0

Junxian Huang (1):
      RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h

Justin Sanders (1):
      aoe: clean device rq_list in aoedev_downdev()

Justin Tee (1):
      scsi: lpfc: Fix lpfc_check_sli_ndlp() handling for GEN_REQUEST64 commands

KaFai Wan (1):
      bpf: Avoid __bpf_prog_ret0_warn when jit fails

Kees Cook (2):
      drm/vkms: Adjust vkms_state->active_planes allocation type
      scsi: qedf: Use designated initializer for struct qed_fcoe_cb_ops

Khem Raj (1):
      mips: Add -std= flag specified in KBUILD_CFLAGS to vdso CFLAGS

Krishna Kumar (1):
      net: ice: Perform accurate aRFS flow match

Krzysztof Kozlowski (2):
      NFC: nci: uart: Set tty->disc_data only in success path
      drm/msm/dsi/dsi_phy_10nm: Fix missing initial VCO rate

Kuniyuki Iwashima (5):
      calipso: Don't call calipso functions for AF_INET sk.
      atm: Revert atm_account_tx() if copy_from_iter_full() fails.
      mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
      atm: atmtcp: Free invalid length skb in atmtcp_c_send().
      calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().

Kyungwook Boo (1):
      i40e: fix MMIO write access to an invalid page in i40e_clear_hw

Lad Prabhakar (1):
      usb: renesas_usbhs: Reorder clock handling and power management in probe

Laurentiu Tudor (1):
      bus: fsl-mc: increase MC_CMD_COMPLETION_TIMEOUT_MS value

Leo Yan (1):
      perf tests switch-tracking: Fix timestamp comparison

Li Lingfeng (3):
      nfs: clear SB_RDONLY before getting superblock
      nfs: ignore SB_RDONLY when remounting nfs
      nfsd: Initialize ssc before laundromat_work to prevent NULL dereference

Li RongQing (1):
      vfio/type1: Fix error unwind in migration dirty bitmap allocation

Liu Shixin (1):
      mm: hugetlb: independent PMD page table shared count

Liu Song (1):
      arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually

Loic Poulain (1):
      media: venus: Fix probe error handling

Long Li (3):
      uio_hv_generic: Use correct size for interrupt and monitor pages
      sunrpc: update nextcheck time when adding new cache entries
      sunrpc: fix race in cache cleanup causing stale nextcheck time

Luca Weiss (1):
      clk: qcom: gcc-sm6350: Add *_wait_val values for GDSCs

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION

Ma Ke (1):
      media: v4l2-dev: fix error handling in __video_register_device()

Marcus Folkesson (1):
      watchdog: da9052_wdt: respect TWDMIN

Marek Szyprowski (2):
      media: videobuf2: use sgtable-based scatterlist wrappers
      udmabuf: use sgtable-based scatterlist wrappers

Martin Blumenstingl (5):
      drm/meson: use unsigned long long / Hz for frequency types
      drm/meson: fix debug log statement when setting the HDMI clocks
      drm/meson: use vclk_freq instead of pixel_freq in debug print
      drm/meson: fix more rounding issues with 59.94Hz modes
      ASoC: meson: meson-card-utils: use of_property_present() for DT parsing

Masahiro Yamada (1):
      kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS

Mathias Nyman (1):
      usb: Flush altsetting 0 endpoints before reinitializating them after reset.

Miaoqian Lin (1):
      firmware: psci: Fix refcount leak in psci_dt_init

Michal Kubiak (1):
      ice: create new Tx scheduler nodes for new queues only

Michal Luczaj (1):
      net: Fix TOCTOU issue in sk_is_readable()

Mike Looijmans (1):
      pinctrl: mcp23s08: Reset all pins to input at probe

Mike Tipton (1):
      cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs

Mikulas Patocka (1):
      dm-mirror: fix a tiny race condition

Mingcong Bai (1):
      wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723

Mirco Barone (1):
      wireguard: device: enable threaded NAPI

Moon Yeounsu (1):
      net: dlink: add synchronization for stats update

Moshe Shemesh (1):
      net/mlx5: Ensure fw pages are always allocated on same NUMA

Murad Masimov (2):
      ocfs2: fix possible memory leak in ocfs2_finish_quota_recovery
      fbdev: Fix fb_set_var to prevent null-ptr-deref in fb_videomode_to_var

Namjae Jeon (1):
      exfat: fix double free in delayed_free

Narayana Murty N (1):
      powerpc/eeh: Fix missing PE bridge reconfiguration during VFIO EEH recovery

Nas Chung (2):
      media: uapi: v4l: Fix V4L2_TYPE_IS_OUTPUT condition
      media: uapi: v4l: Change V4L2_TYPE_IS_CAPTURE condition

Nathan Chancellor (7):
      MIPS: Move '-Wa,-msoft-float' check from as-option to cc-option
      MIPS: Prefer cc-option for additions to cflags
      drm/amd/display: Do not add '-mhard-float' to dml_ccflags for clang
      mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
      kbuild: Add CLANG_FLAGS to as-instr
      kbuild: Add KBUILD_CPPFLAGS to as-option invocation
      drm/amd/display: Do not add '-mhard-float' to dcn2{1,0}_resource.o for clang

Neal Cardwell (1):
      tcp: fix tcp_packet_delayed() for tcp_is_non_sack_preventing_reopen() behavior

NeilBrown (1):
      nfsd: nfsd4_spo_must_allow() must check this is a v4 compound request

Neill Kapron (1):
      selftests/seccomp: fix syscall_restart test for arm compat

Nick Desaulniers (2):
      x86/boot/compressed: prefer cc-option for CFLAGS additions
      kbuild: Update assembler calls to use proper flags and language target

Nicolas Dufresne (1):
      media: rkvdec: Initialize the m2m context before the controls

Nicolas Pitre (1):
      vt: remove VT_RESIZE and VT_RESIZEX from vt_compat_ioctl()

Nikita Zhandarovich (1):
      net: usb: aqc111: fix error handling of usbnet read calls

Niklas Cassel (1):
      PCI: cadence-ep: Correct PBA offset in .set_msix() callback

Niravkumar L Rabara (1):
      EDAC/altera: Use correct write width with the INTTEST register

Nishanth Menon (1):
      arm64: dts: ti: k3-am65-main: Drop deprecated ti,otap-del-sel property

Octavian Purdila (3):
      net_sched: sch_sfq: don't allow 1 packet limit
      net_sched: sch_sfq: use a temporary work area for validating configuration
      net_sched: sch_sfq: move the limit validation

Oleg Nesterov (1):
      posix-cpu-timers: fix race between handle_posix_cpu_timers() and posix_cpu_timer_del()

Oliver Neukum (1):
      net: usb: aqc111: debug info before sanitation

Ovidiu Panait (1):
      crypto: sun8i-ce - move fallback ahash_request to the end of the struct

Pan Taixi (1):
      tracing: Fix compilation warning on arm32

Patrisious Haddad (2):
      RDMA/mlx5: Fix error flow upon firmware failure for RQ destruction
      net/mlx5: Fix return value when searching for existing flow group

Paul Chaignon (2):
      net: Fix checksum update for ILA adj-transport
      bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE

Pawel Laszczak (2):
      usb: cdnsp: Fix issue with detecting command completion event
      usb: cdnsp: Fix issue with detecting USB 3.2 speed

Peter Marheine (1):
      ACPI: battery: negate current when discharging

Peter Oberparleiter (1):
      scsi: s390: zfcp: Ensure synchronous unit_add

Peter Zijlstra (2):
      perf: Ensure bpf_perf_link path is properly serialized
      perf: Fix sample vs do_exit()

Petr Malat (1):
      sctp: Do not wake readers in __sctp_write_space()

Phillip Lougher (1):
      Squashfs: check return result of sb_min_blocksize

Qasim Ijaz (1):
      net: ch9200: fix uninitialised access during mii_nway_restart

Qing Wang (1):
      perf/core: Fix broken throttling when max_samples_per_tick=1

Qiuxu Zhuo (1):
      EDAC/skx_common: Fix general protection fault

Quentin Schulz (2):
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou
      net: stmmac: platform: guarantee uniqueness of bus_id

Rafael J. Wysocki (1):
      PM: sleep: Fix power.is_suspended cleanup for direct-complete devices

Ricardo Ribalda (3):
      media: uvcvideo: Return the number of processed controls
      media: uvcvideo: Send control events for partial succeeds
      media: uvcvideo: Fix deferred probing error

Ritesh Harjani (IBM) (1):
      powerpc/powernv/memtrace: Fix out of bounds issue in memtrace mmap

Robert Malz (2):
      i40e: return false from i40e_reset_vf if reset is in progress
      i40e: retry VFLR handling if there is ongoing VF reset

Ronak Doshi (1):
      vmxnet3: correctly report gso type for UDP tunnels

Ross Stutterheim (1):
      ARM: 9447/1: arm/memremap: fix arch_memremap_can_ram_remap()

Ryusuke Konishi (1):
      nilfs2: do not propagate ENOENT error from nilfs_btree_propagate()

Sakari Ailus (5):
      media: ccs-pll: Start VT pre-PLL multiplier search from correct value
      media: ccs-pll: Start OP pre-PLL multiplier search from correct value
      media: ccs-pll: Correct the upper limit of maximum op_pre_pll_clk_div
      media: ccs-pll: Check for too high VT PLL multiplier in dual PLL case
      media: ccs-pll: Better validate VT PLL branch

Sanjeev Yadav (1):
      scsi: core: ufs: Fix a hang in the error handler

Sean Christopherson (1):
      iommu/amd: Ensure GA log notifier callbacks finish running before module unload

Sean Nyekjaer (3):
      iio: accel: fxls8962af: Fix temperature scan element sign
      iio: imu: inv_icm42600: Fix temperature calculation
      iio: accel: fxls8962af: Fix temperature calculation

Sebastian Andrzej Siewior (1):
      ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT

Sergey Senozhatsky (1):
      thunderbolt: Do not double dequeue a configuration request

Sergey Shtylyov (1):
      fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hperiod()

Sergio Perez Gonzalez (1):
      net: macb: Check return value of dma_set_mask_and_coherent()

Seunghun Han (2):
      ACPICA: fix acpi operand cache leak in dswstate.c
      ACPICA: fix acpi parse and parseext cache leaks

Shengyu Qu (1):
      ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board

Shin'ichiro Kawasaki (1):
      RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction

Shravan Chippa (1):
      media: i2c: imx334: update mode_3840x2160_regs array

Simon Horman (1):
      pldmfw: Select CRC32 when PLDMFW is selected

Simon Schuster (1):
      nios2: force update_mmu_cache on spurious tlb-permission--related pagefaults

Srinivasan Shanmugam (1):
      drm/amd/display: Add NULL pointer checks in dm_force_atomic_commit()

Stefano Stabellini (1):
      xen/arm: call uaccess_ttbr0_enable for dm_op hypercall

Stephen Smalley (1):
      selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len

Stone Zhang (1):
      wifi: ath11k: fix node corruption in ar->arvifs list

Stuart Hayes (2):
      platform/x86: dell_rbu: Fix list usage
      platform/x86: dell_rbu: Stop overwriting data buffer

Su Hui (1):
      soc: aspeed: lpc: Fix impossible judgment condition

Sukrut Bellary (2):
      pmdomain: ti: Fix STANDBY handling of PER power domain
      ARM: OMAP2+: Fix l4ls clk domain handling in STANDBY

Takashi Iwai (1):
      ALSA: hda/intel: Add Thinkpad E15 to PM deny list

Tali Perry (1):
      i2c: npcm: Add clock toggle recovery

Tan En De (1):
      i2c: designware: Invoke runtime suspend on quick slave re-registration

Tao Chen (1):
      bpf: Fix WARN() in get_bpf_raw_tp_regs

Tarang Raval (2):
      media: i2c: imx334: Enable runtime PM before sub-device registration
      media: i2c: imx334: Fix runtime PM handling in remove function

Tasos Sahanidis (1):
      ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330

Tengda Wu (1):
      arm64/ptrace: Fix stack-out-of-bounds read in regs_get_kernel_stack_nth()

Terry Junge (1):
      HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()

Thadeu Lima de Souza Cascardo (1):
      ext4: inline: fix len overflow in ext4_prepare_inline_data

Thangaraj Samynathan (1):
      net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy

Thomas Gleixner (1):
      x86/iopl: Cure TIF_IO_BITMAP inconsistencies

Thomas Weißschuh (1):
      kbuild: userprogs: fix bitsize and target detection on clang

Toke Høiland-Jørgensen (1):
      wifi: ath9k_htc: Abort software beacon handling if disabled

Tomi Valkeinen (1):
      media: ti: cal: Fix wrong goto on error path

Uwe Kleine-König (1):
      iio: adc: ad7124: Fix 3dB filter frequency reading

Viktor Malik (1):
      libbpf: Fix buffer overflow in bpf_object__init_prog

Vincent Knecht (1):
      clk: qcom: gcc-msm8939: Fix mclk0 & mclk1 for 24 MHz

Viresh Kumar (1):
      cpufreq: Force sync policy boost with global boost on sysfs update

Vitaliy Shevtsov (1):
      scsi: elx: efct: Fix memory leak in efct_hw_parse_filter()

Vladimir Oltean (1):
      ptp: fix breakage after ptp_vclock_in_use() rework

Wan Junjie (1):
      bus: fsl-mc: fix GET/SET_TAILDROP command ids

WangYuli (2):
      MIPS: Loongson64: Add missing '#interrupt-cells' for loongson64c_ls7a
      Input: sparcspkr - avoid unannotated fall-through

Wentao Liang (10):
      nilfs2: add pointer check for nilfs_direct_propagate()
      ASoC: qcom: sdm845: Add error handling in sdm845_slim_snd_hw_params()
      net/mlx5_core: Add error handling inmlx5_query_nic_vport_qkey_viol_cntr()
      net/mlx5: Add error handling in mlx5_query_nic_vport_node_guid()
      media: gspca: Add error handling for stv06xx_read_sensor()
      mtd: rawnand: sunxi: Add randomizer configuration in sunxi_nfc_hw_ecc_write_chunk
      mtd: nand: sunxi: Add randomizer configuration before randomizer enable
      regulator: max14577: Add error check for max14577_read_reg()
      media: platform: exynos4-is: Add hardware sync wait to fimc_is_hw_change_mode()
      octeontx2-pf: Add error log forcn10k_map_unmap_rq_policer()

Wolfram Sang (3):
      ARM: dts: at91: usb_a9263: fix GPIO for Dataflash chip select
      ARM: dts: at91: at91sam9263: fix NAND chip selects
      rtc: sh: assign correct interrupts with DT

Wupeng Ma (1):
      VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify

Xiaolei Wang (2):
      remoteproc: core: Cleanup acquired resources when rproc_handle_resources() fails in rproc_attach()
      remoteproc: core: Release rproc->clean_table after rproc_attach() fails

Xin Li (Intel) (1):
      selftests/x86: Add a test to detect infinite SIGTRAP handler loop

Yanqing Wang (1):
      driver: net: ethernet: mtk_star_emac: fix suspend/resume issue

Ye Bin (1):
      ftrace: Fix UAF when lookup kallsym after ftrace disabled

Yong Wang (1):
      net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions

Yuanjun Gong (1):
      ASoC: tegra210_ahub: Add check to of_device_get_match_data()

Zhang Yi (4):
      ext4: factor out ext4_get_maxbytes()
      ext4: ensure i_size is smaller than maxbytes
      ext4: ext4: unify EXT4_EX_NOCACHE|NOFAIL flags in ext4_ext_remove_space()
      ext4: prevent stale extent cache entries caused by concurrent get es_cache

Zhiguo Niu (2):
      f2fs: use d_inode(dentry) cleanup dentry->d_inode
      f2fs: fix to correct check conditions in f2fs_cross_rename

Zhongqiu Duan (1):
      netfilter: nft_quota: match correctly when the quota just depleted

Zijun Hu (5):
      PM: wakeup: Delete space in the end of string shown by pm_show_wakelocks()
      fs/filesystems: Fix potential unsigned integer underflow in fs_name()
      configfs: Do not override creating attribute file failure in populate_attrs()
      software node: Correct a OOB check in software_node_get_reference_args()
      sock: Correct error checking condition for (assign|release)_proto_idx()

Zilin Guan (1):
      tipc: use kfree_sensitive() for aead cleanup

gldrk (1):
      ACPICA: utilities: Fix overflow check in vsnprintf()

wangdicheng (1):
      ALSA: usb-audio: Rename ALSA kcontrol PCM and PCM1 for the KTMicro sound card

zhang songyi (1):
      Input: synaptics-rmi4 - convert to use sysfs_emit() APIs

Álvaro Fernández Rojas (3):
      spi: bcm63xx-spi: fix shared reset
      spi: bcm63xx-hsspi: fix shared reset
      net: dsa: tag_brcm: legacy: fix pskb_may_pull length


