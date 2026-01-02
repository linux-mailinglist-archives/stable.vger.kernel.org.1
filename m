Return-Path: <stable+bounces-204467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A4CEE7C0
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 13:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6247B30038C1
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5037A2F3621;
	Fri,  2 Jan 2026 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eBFB5lL3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3894184;
	Fri,  2 Jan 2026 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356307; cv=none; b=kffFzURfE1MJN6sb8yuJIrKZCautAFNmXHGgf7InSVW7QjVXine2z3VWgfBQ6sKaUEEG1ZTn5Wzd8wjFk8HbXQ1uzI9tsJ8JyOlybU4LKp/ky2sxvG7QqPuuc2ETK7lVRBR2Qihj4gcNlqtAgI6KshlXjRk6OKfWzBYQIlGigzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356307; c=relaxed/simple;
	bh=afnQGQeIF/nB1HEgE+5xXz9JDKJ7jnvRLFLAQZzZq28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cbGPFDcoKPlra2EYznU27qaoUMn4rOnuZybjZz7d3zxbIHH4VZf4lrwk3WQ9Wfk+Mhczez/wfZSapUKOhVY3ogDk1yd+QdV9Np70yjCFPf3IqPt701UWbGKk2V0Qy64AfnURoVizU9bBNK931onPl3fdWTgOa3xnTrUhHqmpQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eBFB5lL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85095C116B1;
	Fri,  2 Jan 2026 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767356306;
	bh=afnQGQeIF/nB1HEgE+5xXz9JDKJ7jnvRLFLAQZzZq28=;
	h=From:To:Cc:Subject:Date:From;
	b=eBFB5lL3hbdAVmhjQbxtyGGj+zDjBg3XZCnO36FaYVdt178TBjESIh2f895EJPaoR
	 SLWiQwzK7FB4b9XVfa3xRxeWuD2Iv8BGfaNwYMXM9GQWOaIgMukxDbEhGrNajNs/Dj
	 4zqQafKShVfMlplBMHaESEeIZg2CHRzqqqhvJTMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.3
Date: Fri,  2 Jan 2026 13:18:20 +0100
Message-ID: <2026010221-acts-basically-fbfc@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.3 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml                           |    2 
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml                       |    5 
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml                     |    3 
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml                       |    5 
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml                       |    5 
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml                       |    5 
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml                       |    5 
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml                       |    5 
 Documentation/devicetree/bindings/slimbus/slimbus.yaml                            |   16 
 Makefile                                                                          |    2 
 arch/arm/boot/dts/microchip/sama5d2.dtsi                                          |   10 
 arch/arm/boot/dts/microchip/sama7d65.dtsi                                         |    6 
 arch/arm/boot/dts/microchip/sama7g5.dtsi                                          |    4 
 arch/arm64/boot/dts/mediatek/Makefile                                             |    2 
 arch/arm64/crypto/ghash-ce-glue.c                                                 |    2 
 arch/arm64/kernel/process.c                                                       |    1 
 arch/arm64/net/bpf_jit_comp.c                                                     |    2 
 arch/mips/kernel/ftrace.c                                                         |   25 
 arch/mips/sgi-ip22/ip22-gio.c                                                     |    3 
 arch/powerpc/boot/addnote.c                                                       |    7 
 arch/powerpc/include/asm/crash_reserve.h                                          |    8 
 arch/powerpc/kernel/btext.c                                                       |    3 
 arch/powerpc/kexec/core_64.c                                                      |   19 
 arch/riscv/crypto/Kconfig                                                         |   12 
 arch/s390/include/uapi/asm/ipl.h                                                  |    1 
 arch/s390/kernel/ipl.c                                                            |   48 
 arch/um/kernel/process.c                                                          |    4 
 arch/um/kernel/um_arch.c                                                          |    2 
 arch/x86/events/amd/core.c                                                        |    7 
 arch/x86/include/asm/bug.h                                                        |    2 
 arch/x86/include/asm/irq_remapping.h                                              |    7 
 arch/x86/include/asm/kvm_host.h                                                   |    1 
 arch/x86/include/asm/ptrace.h                                                     |   20 
 arch/x86/kernel/cpu/mce/threshold.c                                               |    3 
 arch/x86/kernel/cpu/microcode/core.c                                              |    2 
 arch/x86/kernel/fpu/xstate.c                                                      |    4 
 arch/x86/kernel/irq.c                                                             |   23 
 arch/x86/kvm/cpuid.c                                                              |   11 
 arch/x86/kvm/lapic.c                                                              |   32 
 arch/x86/kvm/svm/nested.c                                                         |    6 
 arch/x86/kvm/svm/svm.c                                                            |   44 
 arch/x86/kvm/svm/svm.h                                                            |    7 
 arch/x86/kvm/vmx/nested.c                                                         |    3 
 arch/x86/kvm/vmx/tdx.c                                                            |   56 
 arch/x86/kvm/vmx/tdx.h                                                            |    1 
 arch/x86/kvm/x86.c                                                                |   34 
 arch/x86/xen/enlighten_pv.c                                                       |    2 
 block/bfq-iosched.c                                                               |    2 
 block/blk-mq-sched.c                                                              |  117 +
 block/blk-mq-sched.h                                                              |   40 
 block/blk-mq.c                                                                    |   50 
 block/blk-sysfs.c                                                                 |   28 
 block/blk-wbt.c                                                                   |   20 
 block/blk-wbt.h                                                                   |    5 
 block/blk-zoned.c                                                                 |   42 
 block/blk.h                                                                       |    7 
 block/elevator.c                                                                  |   84 -
 block/elevator.h                                                                  |   27 
 block/genhd.c                                                                     |    2 
 crypto/af_alg.c                                                                   |    5 
 crypto/algif_hash.c                                                               |    3 
 crypto/algif_rng.c                                                                |    3 
 crypto/scatterwalk.c                                                              |   97 +
 drivers/acpi/acpi_pcc.c                                                           |    2 
 drivers/acpi/acpica/nswalk.c                                                      |    9 
 drivers/acpi/cppc_acpi.c                                                          |    3 
 drivers/acpi/fan.h                                                                |   33 
 drivers/acpi/fan_hwmon.c                                                          |   10 
 drivers/acpi/property.c                                                           |    8 
 drivers/amba/tegra-ahb.c                                                          |    1 
 drivers/android/binder/process.rs                                                 |    8 
 drivers/base/power/runtime.c                                                      |   22 
 drivers/block/floppy.c                                                            |    2 
 drivers/block/rnbd/rnbd-clt.c                                                     |   13 
 drivers/block/rnbd/rnbd-clt.h                                                     |    2 
 drivers/block/ublk_drv.c                                                          |  139 +-
 drivers/block/zloop.c                                                             |   12 
 drivers/bluetooth/btusb.c                                                         |   11 
 drivers/bus/ti-sysc.c                                                             |   11 
 drivers/char/applicom.c                                                           |    5 
 drivers/char/ipmi/ipmi_msghandler.c                                               |   20 
 drivers/char/tpm/tpm-chip.c                                                       |    1 
 drivers/char/tpm/tpm1-cmd.c                                                       |    5 
 drivers/char/tpm/tpm2-cmd.c                                                       |   34 
 drivers/char/tpm/tpm2-sessions.c                                                  |  194 ++-
 drivers/clk/keystone/syscon-clk.c                                                 |    2 
 drivers/clk/mvebu/cp110-system-controller.c                                       |   20 
 drivers/clk/qcom/dispcc-sm7150.c                                                  |    2 
 drivers/cpufreq/cpufreq-dt-platdev.c                                              |    1 
 drivers/cpufreq/cpufreq-nforce2.c                                                 |    3 
 drivers/cpufreq/s5pv210-cpufreq.c                                                 |    6 
 drivers/cpuidle/governors/menu.c                                                  |    9 
 drivers/cpuidle/governors/teo.c                                                   |    7 
 drivers/crypto/caam/caamrng.c                                                     |    4 
 drivers/crypto/ccp/sp-pci.c                                                       |   19 
 drivers/firmware/efi/efi.c                                                        |    3 
 drivers/firmware/imx/imx-scu-irq.c                                                |    4 
 drivers/gpio/gpio-loongson-64bit.c                                                |   10 
 drivers/gpio/gpio-regmap.c                                                        |    2 
 drivers/gpio/gpiolib-acpi-quirks.c                                                |   22 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                        |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                       |   59 
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c                                  |    2 
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c                    |    8 
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c                  |    8 
 drivers/gpu/drm/drm_displayid.c                                                   |   19 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                             |   18 
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c                                         |    4 
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c                                     |    2 
 drivers/gpu/drm/tests/drm_atomic_state_test.c                                     |   40 
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c                                |  143 ++
 drivers/gpu/drm/xe/xe_device.c                                                    |    2 
 drivers/gpu/drm/xe/xe_exec.c                                                      |    3 
 drivers/gpu/drm/xe/xe_gt.c                                                        |    7 
 drivers/gpu/drm/xe/xe_gt_freq.c                                                   |    4 
 drivers/gpu/drm/xe/xe_gt_idle.c                                                   |    8 
 drivers/gpu/drm/xe/xe_heci_gsc.c                                                  |    4 
 drivers/gpu/drm/xe/xe_oa.c                                                        |   10 
 drivers/gpu/drm/xe/xe_svm.h                                                       |    2 
 drivers/gpu/drm/xe/xe_vm.c                                                        |    3 
 drivers/gpu/drm/xe/xe_wa.c                                                        |    8 
 drivers/gpu/drm/xe/xe_wa_oob.rules                                                |    1 
 drivers/hid/hid-input.c                                                           |   18 
 drivers/hwmon/dell-smm-hwmon.c                                                    |    9 
 drivers/hwmon/emc2305.c                                                           |    8 
 drivers/hwmon/ibmpex.c                                                            |    9 
 drivers/hwmon/ltc4282.c                                                           |    9 
 drivers/hwmon/max16065.c                                                          |    7 
 drivers/hwmon/max6697.c                                                           |    2 
 drivers/hwmon/tmp401.c                                                            |    2 
 drivers/hwmon/w83791d.c                                                           |   17 
 drivers/hwmon/w83l786ng.c                                                         |   26 
 drivers/hwtracing/intel_th/core.c                                                 |   20 
 drivers/i2c/busses/i2c-amd-mp2-pci.c                                              |    5 
 drivers/i2c/busses/i2c-designware-core.h                                          |    1 
 drivers/i2c/busses/i2c-designware-master.c                                        |    7 
 drivers/iio/adc/ti_am335x_adc.c                                                   |    2 
 drivers/input/joystick/xpad.c                                                     |    5 
 drivers/input/keyboard/lkkbd.c                                                    |    5 
 drivers/input/mouse/alps.c                                                        |    1 
 drivers/input/serio/i8042-acpipnpio.h                                             |    7 
 drivers/input/touchscreen/apple_z2.c                                              |    4 
 drivers/input/touchscreen/ti_am335x_tsc.c                                         |    2 
 drivers/interconnect/qcom/sdx75.c                                                 |   26 
 drivers/interconnect/qcom/sdx75.h                                                 |    2 
 drivers/iommu/amd/init.c                                                          |   23 
 drivers/iommu/intel/irq_remapping.c                                               |    8 
 drivers/iommu/iommufd/selftest.c                                                  |    8 
 drivers/iommu/mtk_iommu.c                                                         |   25 
 drivers/md/dm-pcache/cache.c                                                      |    8 
 drivers/md/dm-pcache/cache_segment.c                                              |    8 
 drivers/media/platform/qcom/iris/iris_vb2.c                                       |    8 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                                  |    3 
 drivers/media/usb/dvb-usb/dtv5100.c                                               |    5 
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c                                           |    2 
 drivers/misc/mei/Kconfig                                                          |    2 
 drivers/misc/mei/main.c                                                           |    1 
 drivers/mmc/host/Kconfig                                                          |    4 
 drivers/mmc/host/sdhci-msm.c                                                      |   27 
 drivers/mmc/host/sdhci-of-arasan.c                                                |    2 
 drivers/net/can/usb/gs_usb.c                                                      |    2 
 drivers/net/ethernet/broadcom/b44.c                                               |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                                     |    3 
 drivers/net/ethernet/freescale/enetc/enetc.c                                      |    3 
 drivers/net/ethernet/freescale/fec_main.c                                         |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                           |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c                            |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c                         |    4 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c                                 |    5 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c                          |   97 +
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h                          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c                          |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                                 |    1 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                        |    6 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c                                |   48 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h                                |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                                 |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c                               |   11 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                                    |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c                                 |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c                             |   27 
 drivers/net/ethernet/realtek/r8169_main.c                                         |    5 
 drivers/net/ethernet/ti/Kconfig                                                   |    3 
 drivers/net/ipvlan/ipvlan_core.c                                                  |    3 
 drivers/net/phy/marvell-88q2xxx.c                                                 |    2 
 drivers/net/phy/realtek/realtek_main.c                                            |  112 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c                            |   14 
 drivers/net/wireless/mediatek/mt76/eeprom.c                                       |   37 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                                   |    2 
 drivers/net/wireless/realtek/rtl8xxxu/core.c                                      |    7 
 drivers/nfc/pn533/usb.c                                                           |    2 
 drivers/nvme/host/fabrics.c                                                       |    2 
 drivers/nvme/host/fc.c                                                            |    6 
 drivers/of/fdt.c                                                                  |    2 
 drivers/parisc/gsc.c                                                              |    4 
 drivers/perf/arm_cspmu/arm_cspmu.c                                                |    4 
 drivers/phy/broadcom/phy-bcm63xx-usbh.c                                           |    6 
 drivers/phy/samsung/phy-exynos5-usbdrd.c                                          |    2 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                           |   71 -
 drivers/platform/chrome/cros_ec_ishtp.c                                           |    1 
 drivers/platform/x86/intel/chtwc_int33fe.c                                        |   29 
 drivers/platform/x86/intel/hid.c                                                  |   12 
 drivers/platform/x86/lenovo/wmi-gamezone.c                                        |   17 
 drivers/pwm/pwm-rzg2l-gpt.c                                                       |   15 
 drivers/rpmsg/qcom_glink_native.c                                                 |    8 
 drivers/s390/block/dasd_eckd.c                                                    |    8 
 drivers/scsi/aic94xx/aic94xx_init.c                                               |    3 
 drivers/scsi/lpfc/lpfc_els.c                                                      |   36 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                                  |    4 
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h                                               |    1 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                                   |    2 
 drivers/scsi/qla2xxx/qla_def.h                                                    |    1 
 drivers/scsi/qla2xxx/qla_gbl.h                                                    |    2 
 drivers/scsi/qla2xxx/qla_isr.c                                                    |   32 
 drivers/scsi/qla2xxx/qla_mbx.c                                                    |    2 
 drivers/scsi/qla2xxx/qla_mid.c                                                    |    4 
 drivers/scsi/qla2xxx/qla_os.c                                                     |   14 
 drivers/scsi/scsi_debug.c                                                         |    2 
 drivers/scsi/smartpqi/smartpqi_init.c                                             |    4 
 drivers/soc/amlogic/meson-canvas.c                                                |    5 
 drivers/soc/apple/mailbox.c                                                       |   15 
 drivers/soc/qcom/ocmem.c                                                          |    2 
 drivers/soc/qcom/qcom-pbs.c                                                       |    2 
 drivers/soc/samsung/exynos-pmu.c                                                  |    2 
 drivers/soc/tegra/fuse/fuse-tegra.c                                               |    2 
 drivers/spi/Kconfig                                                               |   19 
 drivers/spi/Makefile                                                              |    2 
 drivers/spi/spi-cadence-quadspi.c                                                 |    4 
 drivers/spi/spi-fsl-spi.c                                                         |    2 
 drivers/spi/spi-microchip-core.c                                                  |  625 ---------
 drivers/spi/spi-mpfs.c                                                            |  627 ++++++++++
 drivers/target/target_core_transport.c                                            |    1 
 drivers/tty/serial/serial_base_bus.c                                              |   11 
 drivers/tty/serial/sh-sci.c                                                       |    2 
 drivers/tty/serial/sprd_serial.c                                                  |    6 
 drivers/tty/serial/xilinx_uartps.c                                                |   14 
 drivers/ufs/core/ufshcd.c                                                         |    5 
 drivers/ufs/host/ufs-mediatek.c                                                   |    5 
 drivers/usb/dwc3/dwc3-of-simple.c                                                 |    7 
 drivers/usb/dwc3/gadget.c                                                         |    2 
 drivers/usb/dwc3/host.c                                                           |    2 
 drivers/usb/gadget/function/f_fs.c                                                |   53 
 drivers/usb/gadget/udc/lpc32xx_udc.c                                              |   21 
 drivers/usb/host/ohci-nxp.c                                                       |    2 
 drivers/usb/host/xhci-dbgtty.c                                                    |    2 
 drivers/usb/host/xhci-hub.c                                                       |    2 
 drivers/usb/host/xhci-ring.c                                                      |   27 
 drivers/usb/phy/phy-fsl-usb.c                                                     |    1 
 drivers/usb/phy/phy-isp1301.c                                                     |    7 
 drivers/usb/renesas_usbhs/pipe.c                                                  |    2 
 drivers/usb/storage/unusual_uas.h                                                 |    2 
 drivers/usb/typec/altmodes/displayport.c                                          |    8 
 drivers/usb/typec/ucsi/Kconfig                                                    |    1 
 drivers/usb/typec/ucsi/ucsi.c                                                     |    6 
 drivers/usb/usbip/vhci_hcd.c                                                      |    6 
 drivers/vdpa/octeon_ep/octep_vdpa_main.c                                          |    1 
 drivers/vfio/device_cdev.c                                                        |    2 
 drivers/vhost/vsock.c                                                             |   15 
 drivers/watchdog/via_wdt.c                                                        |    1 
 fs/btrfs/file.c                                                                   |    3 
 fs/btrfs/inode.c                                                                  |    1 
 fs/btrfs/ioctl.c                                                                  |    4 
 fs/btrfs/scrub.c                                                                  |    5 
 fs/btrfs/tree-log.c                                                               |   46 
 fs/btrfs/volumes.c                                                                |    1 
 fs/exfat/file.c                                                                   |    5 
 fs/exfat/super.c                                                                  |   19 
 fs/ext4/ialloc.c                                                                  |    1 
 fs/ext4/inode.c                                                                   |    1 
 fs/ext4/ioctl.c                                                                   |    4 
 fs/ext4/mballoc.c                                                                 |    2 
 fs/ext4/orphan.c                                                                  |    4 
 fs/ext4/super.c                                                                   |    6 
 fs/ext4/xattr.c                                                                   |    6 
 fs/f2fs/compress.c                                                                |    5 
 fs/f2fs/data.c                                                                    |   17 
 fs/f2fs/extent_cache.c                                                            |    5 
 fs/f2fs/f2fs.h                                                                    |   13 
 fs/f2fs/file.c                                                                    |   12 
 fs/f2fs/gc.c                                                                      |    2 
 fs/f2fs/namei.c                                                                   |    6 
 fs/f2fs/recovery.c                                                                |   20 
 fs/f2fs/segment.c                                                                 |    9 
 fs/f2fs/segment.h                                                                 |    8 
 fs/f2fs/super.c                                                                   |  116 -
 fs/f2fs/xattr.c                                                                   |   32 
 fs/f2fs/xattr.h                                                                   |   10 
 fs/fuse/dev.c                                                                     |    2 
 fs/fuse/dev_uring.c                                                               |    6 
 fs/fuse/file.c                                                                    |   37 
 fs/fuse/fuse_dev_i.h                                                              |    1 
 fs/gfs2/glops.c                                                                   |    3 
 fs/gfs2/lops.c                                                                    |    2 
 fs/gfs2/quota.c                                                                   |    2 
 fs/gfs2/super.c                                                                   |    4 
 fs/hfsplus/bnode.c                                                                |    4 
 fs/hfsplus/dir.c                                                                  |    7 
 fs/hfsplus/hfsplus_fs.h                                                           |    2 
 fs/hfsplus/inode.c                                                                |   41 
 fs/hfsplus/super.c                                                                |   87 -
 fs/iomap/buffered-io.c                                                            |   41 
 fs/jbd2/journal.c                                                                 |   20 
 fs/jbd2/transaction.c                                                             |    2 
 fs/libfs.c                                                                        |   50 
 fs/nfsd/blocklayout.c                                                             |    3 
 fs/nfsd/export.c                                                                  |    2 
 fs/nfsd/nfs4xdr.c                                                                 |    5 
 fs/nfsd/nfsd.h                                                                    |    8 
 fs/nfsd/nfssvc.c                                                                  |    5 
 fs/nfsd/vfs.h                                                                     |    3 
 fs/notify/fsnotify.c                                                              |    9 
 fs/ntfs3/file.c                                                                   |   14 
 fs/ntfs3/ntfs_fs.h                                                                |    9 
 fs/ntfs3/run.c                                                                    |    6 
 fs/ntfs3/super.c                                                                  |    5 
 fs/ocfs2/suballoc.c                                                               |   10 
 fs/smb/client/fs_context.c                                                        |    2 
 fs/smb/server/mgmt/tree_connect.c                                                 |   18 
 fs/smb/server/mgmt/tree_connect.h                                                 |    1 
 fs/smb/server/mgmt/user_session.c                                                 |    4 
 fs/smb/server/smb2pdu.c                                                           |   16 
 fs/smb/server/vfs.c                                                               |    5 
 fs/smb/server/vfs_cache.c                                                         |   88 -
 fs/super.c                                                                        |    2 
 fs/xfs/libxfs/xfs_sb.c                                                            |   15 
 fs/xfs/scrub/attr_repair.c                                                        |    2 
 fs/xfs/xfs_attr_item.c                                                            |    2 
 fs/xfs/xfs_buf_item.c                                                             |    1 
 fs/xfs/xfs_qm.c                                                                   |    5 
 fs/xfs/xfs_rtalloc.c                                                              |   14 
 include/crypto/scatterwalk.h                                                      |   52 
 include/dt-bindings/clock/qcom,mmcc-sdm660.h                                      |    1 
 include/linux/blkdev.h                                                            |    2 
 include/linux/crash_reserve.h                                                     |    6 
 include/linux/dma-mapping.h                                                       |    2 
 include/linux/fs.h                                                                |    2 
 include/linux/jbd2.h                                                              |    6 
 include/linux/ksm.h                                                               |    4 
 include/linux/platform_data/x86/intel_pmc_ipc.h                                   |    4 
 include/linux/reset.h                                                             |    1 
 include/linux/slab.h                                                              |    7 
 include/linux/tpm.h                                                               |   21 
 include/media/v4l2-mem2mem.h                                                      |    3 
 include/net/inet_frag.h                                                           |   18 
 include/net/ipv6_frag.h                                                           |    9 
 include/sound/soc.h                                                               |    1 
 include/trace/events/tlb.h                                                        |    5 
 include/uapi/drm/xe_drm.h                                                         |    1 
 include/uapi/linux/mptcp.h                                                        |    1 
 io_uring/io_uring.c                                                               |    3 
 io_uring/openclose.c                                                              |    2 
 io_uring/poll.c                                                                   |    9 
 io_uring/rsrc.c                                                                   |   13 
 kernel/bpf/dmabuf_iter.c                                                          |   56 
 kernel/cgroup/rstat.c                                                             |   13 
 kernel/crash_reserve.c                                                            |    3 
 kernel/kallsyms.c                                                                 |    5 
 kernel/livepatch/core.c                                                           |    8 
 kernel/printk/internal.h                                                          |    8 
 kernel/printk/nbcon.c                                                             |    9 
 kernel/printk/printk.c                                                            |   83 +
 kernel/sched/cpudeadline.c                                                        |   34 
 kernel/sched/cpudeadline.h                                                        |    4 
 kernel/sched/deadline.c                                                           |    8 
 kernel/sched/ext.c                                                                |   62 
 kernel/sched/fair.c                                                               |   19 
 kernel/scs.c                                                                      |    2 
 kernel/trace/bpf_trace.c                                                          |    2 
 kernel/trace/trace_events.c                                                       |    2 
 kernel/trace/trace_events_synth.c                                                 |    1 
 lib/crypto/Kconfig                                                                |    9 
 lib/crypto/riscv/.gitignore                                                       |    2 
 lib/crypto/riscv/chacha-riscv64-zvkb.S                                            |    5 
 lib/crypto/x86/blake2s-core.S                                                     |    4 
 mm/huge_memory.c                                                                  |    2 
 mm/ksm.c                                                                          |   20 
 mm/shmem.c                                                                        |   18 
 mm/slab.h                                                                         |    1 
 mm/slab_common.c                                                                  |   52 
 mm/slub.c                                                                         |   57 
 net/caif/cffrml.c                                                                 |    9 
 net/can/j1939/socket.c                                                            |    6 
 net/ceph/osdmap.c                                                                 |  116 -
 net/ethtool/ioctl.c                                                               |   30 
 net/handshake/request.c                                                           |    8 
 net/hsr/hsr_forward.c                                                             |    2 
 net/ipv4/inet_fragment.c                                                          |   55 
 net/ipv4/ip_fragment.c                                                            |   22 
 net/mptcp/pm_netlink.c                                                            |    3 
 net/mptcp/protocol.c                                                              |   22 
 net/netfilter/ipvs/ip_vs_xmit.c                                                   |    3 
 net/netfilter/nf_conncount.c                                                      |   25 
 net/netfilter/nf_nat_core.c                                                       |   14 
 net/netfilter/nf_tables_api.c                                                     |   11 
 net/netrom/nr_out.c                                                               |    4 
 net/openvswitch/flow_netlink.c                                                    |   13 
 net/sched/sch_ets.c                                                               |    6 
 net/sunrpc/auth_gss/svcauth_gss.c                                                 |    3 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                                                 |    7 
 net/wireless/core.c                                                               |    1 
 net/wireless/core.h                                                               |    1 
 net/wireless/mlme.c                                                               |   19 
 net/wireless/util.c                                                               |   23 
 rust/helpers/dma.c                                                                |   21 
 rust/kernel/devres.rs                                                             |   18 
 rust/kernel/drm/gem/mod.rs                                                        |    2 
 rust/kernel/io.rs                                                                 |   26 
 rust/kernel/io/resource.rs                                                        |   13 
 samples/rust/rust_driver_pci.rs                                                   |    2 
 scripts/Makefile.modinst                                                          |    2 
 scripts/faddr2line                                                                |   13 
 scripts/lib/kdoc/kdoc_parser.py                                                   |    7 
 security/keys/trusted-keys/trusted_tpm2.c                                         |   35 
 sound/hda/codecs/realtek/alc269.c                                                 |   11 
 sound/pcmcia/pdaudiocf/pdaudiocf.c                                                |    8 
 sound/pcmcia/vx/vxpocket.c                                                        |    8 
 sound/soc/codecs/ak4458.c                                                         |    4 
 sound/soc/fsl/fsl_sai.c                                                           |   10 
 sound/soc/sdca/sdca_asoc.c                                                        |   34 
 sound/soc/soc-ops.c                                                               |   84 +
 sound/soc/sof/ipc4-topology.c                                                     |   24 
 sound/usb/mixer_us16x08.c                                                         |   20 
 tools/lib/perf/cpumap.c                                                           |   10 
 tools/testing/ktest/config-bisect.pl                                              |    4 
 tools/testing/nvdimm/test/nfit.c                                                  |    7 
 tools/testing/selftests/iommu/iommufd.c                                           |    8 
 tools/testing/selftests/kvm/Makefile                                              |    2 
 tools/testing/selftests/kvm/rseq_test.c                                           |    1 
 tools/testing/selftests/net/af_unix/Makefile                                      |    7 
 tools/testing/selftests/net/lib/ksft.h                                            |    6 
 tools/testing/selftests/net/mptcp/pm_netlink.sh                                   |    4 
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c                                     |   11 
 tools/testing/selftests/net/netfilter/conntrack_clash.sh                          |    9 
 tools/testing/selftests/net/netfilter/conntrack_reverse_clash.c                   |   13 
 tools/testing/selftests/net/netfilter/conntrack_reverse_clash.sh                  |    2 
 tools/testing/selftests/net/netfilter/packetdrill/conntrack_syn_challenge_ack.pkt |    2 
 tools/testing/selftests/net/tfo.c                                                 |    3 
 tools/testing/selftests/ublk/kublk.h                                              |   12 
 tools/tracing/rtla/src/timerlat.bpf.c                                             |    3 
 virt/kvm/kvm_main.c                                                               |    4 
 442 files changed, 4588 insertions(+), 2460 deletions(-)

Aboorva Devarajan (1):
      cpuidle: menu: Use residency threshold in polling state override decisions

Al Viro (2):
      shmem: fix recovery on rename failures
      functionfs: fix the open/removal races

Alex Deucher (2):
      drm/amdgpu: fix a job->pasid access race in gpu recovery
      drm/amd/display: Use GFP_ATOMIC in dc_create_plane_state()

Alexander Stein (1):
      serial: core: Fix serial device initialization

Alexey Minnekhanov (1):
      dt-bindings: clock: mmcc-sdm660: Add missing MDSS reset

Alexey Simakov (2):
      broadcom: b44: prevent uninitialized value usage
      hwmon: (tmp401) fix overflow caused by default conversion rate value

Alexey Velichayshiy (1):
      gfs2: fix freeze error handling

Alice Ryhl (4):
      rust_binder: avoid mem::take on delivered_deaths
      rust: io: define ResourceSize as resource_size_t
      rust: io: move ResourceSize to top-level io module
      rust: io: add typedef for phys_addr_t

Alison Schofield (1):
      tools/testing/nvdimm: Use per-DIMM device handle

Alok Tiwari (1):
      drm/msm/a6xx: move preempt_prepare_postamble after error check

Amir Goldstein (1):
      fsnotify: do not generate ACCESS/MODIFY events on child for special files

Andreas Gruenbacher (3):
      gfs2: fix remote evict for read-only filesystems
      gfs2: Fix "gfs2: Switch to wait_event in gfs2_quotad"
      gfs2: Fix use of bio_chain

Andrew Jeffery (1):
      dt-bindings: mmc: sdhci-of-aspeed: Switch ref to sdhci-common.yaml

Andrey Vatoropin (1):
      scsi: target: Reset t_task_cdb pointer in error case

André Draszik (1):
      phy: exynos5-usbdrd: fix clock prepare imbalance

Andy Shevchenko (2):
      serial: core: Restore sysfs fwnode information
      nfsd: Mark variable __maybe_unused to avoid W=1 build break

Antheas Kapenekakis (1):
      ALSA: hda/realtek: Add Asus quirk for TAS amplifiers

Anurag Dutta (1):
      spi: cadence-quadspi: Fix clock disable on probe failure path

Ard Biesheuvel (1):
      efi: Add missing static initializer for efi_mm::cpus_allowed_lock

Armin Wolf (1):
      ACPI: fan: Workaround for 64-bit firmware bug

Arnd Bergmann (3):
      net: ti: icssg-prueth: add PTP_1588_CLOCK_OPTIONAL dependency
      drm/xe: fix drm_gpusvm_init() arguments
      usb: typec: ucsi: huawei-gaokin: add DRM dependency

Ashutosh Dixit (1):
      drm/xe/oa: Always set OAG_OAGLBCTXCTRL_COUNTER_RESUME

Askar Safin (1):
      gpiolib: acpi: Add quirk for Dell Precision 7780

Avadhut Naik (1):
      x86/mce: Do not clear bank's poll bit in mce_poll_banks on AMD SMCA systems

Baokun Li (1):
      ext4: align max orphan file size with e2fsprogs limit

Bart Van Assche (1):
      block: Remove queue freezing from several sysfs store callbacks

Bartosz Golaszewski (1):
      platform/x86: intel: chtwc_int33fe: don't dereference swnode args

Ben Collins (1):
      powerpc/addnote: Fix overflow on 32-bit builds

Bernd Schubert (2):
      fuse: Always flush the page cache before FOPEN_DIRECT_IO write
      fuse: Invalidate the page cache after FOPEN_DIRECT_IO write

Biju Das (1):
      pwm: rzg2l-gpt: Allow checking period_tick cache value only if sibling channel is enabled

Bitterblue Smith (1):
      wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU, RTL8723AU

Byungchul Park (1):
      jbd2: use a weaker annotation in journal handling

Caleb Sander Mateos (1):
      ublk: clean up user copy references on ublk server exit

Chancel Liu (1):
      ASoC: fsl_sai: Constrain sample rates from audio PLLs only in master mode

Chandrakanth Patil (1):
      scsi: mpi3mr: Read missing IOCFacts flag for reply queue full overflow

Chao Yu (8):
      f2fs: fix to avoid updating compression context during writeback
      f2fs: fix to avoid potential deadlock
      f2fs: fix to propagate error from f2fs_enable_checkpoint()
      f2fs: fix to avoid updating zero-sized extent in extent cache
      f2fs: use global inline_xattr_slab instead of per-sb slab cache
      f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
      f2fs: fix to not account invalid blocks in get_left_section_blocks()
      f2fs: fix return value of f2fs_recover_fsync_data()

Charles Mirabile (1):
      lib/crypto: riscv: Add poly1305-core.S to .gitignore

Chen Changcheng (2):
      usb: usb-storage: No additional quirks need to be added to the EL-R12 optical drive.
      usb: usb-storage: Maintain minimal modifications to the bcdDevice range.

ChenXiaoSong (1):
      smb/server: fix return value of smb2_ioctl()

Cheng Ding (1):
      fuse: missing copy_finish in fuse-over-io-uring argument copies

Chia-Lin Kao (AceLan) (1):
      platform/x86/intel/hid: Add Dell Pro Rugged 10/12 tablet to VGBS DMI quirks

Chingbin Li (1):
      Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV

Chris Lu (2):
      Bluetooth: btusb: MT7922: Add VID/PID 0489/e170
      Bluetooth: btusb: MT7920: Add VID/PID 0489/e135

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Max Gen10 AMD to i8042 quirk table

Christoph Hellwig (3):
      xfs: don't leak a locked dquot when xfs_dquot_attach_buf fails
      xfs: fix the zoned RT growfs check for zone alignment
      xfs: validate that zoned RT devices are zone aligned

Christophe JAILLET (1):
      spi: mpfs: Fix an error handling path in mpfs_spi_probe()

Christophe Leroy (1):
      spi: fsl-cpm: Check length parity before switching to 16 bit mode

Chuck Lever (3):
      NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
      NFSD: NFSv4 file creation neglects setting ACL
      NFSD: Clear TIME_DELEG in the suppattr_exclcreat bitmap

Claudiu Beznea (2):
      serial: sh-sci: Check that the DMA cookie is valid
      pinctrl: renesas: rzg2l: Fix ISEL restore on resume

Colin Ian King (1):
      media: pvrusb2: Fix incorrect variable used in trace message

Cosmin Ratiu (2):
      net/mlx5e: Avoid unregistering PSP twice
      net/mlx5e: Don't include PSP in the hard MTU calculations

Cryolitia PukNgae (1):
      ACPICA: Avoid walking the Namespace if start_node is NULL

Dai Ngo (1):
      NFSD: use correct reservation type in nfsd4_scsi_fence_client

Damien Le Moal (3):
      zloop: fail zone append operations that are targeting full zones
      zloop: make the write pointer of full zones invalid
      block: freeze queue when updating zone resources

Dan Carpenter (2):
      nfc: pn533: Fix error code in pn533_acr122_poweron_rdr()
      block: rnbd-clt: Fix signedness bug in init_dev()

Daniel Wagner (1):
      nvme-fc: don't hold rport lock when putting ctrl

Darrick J. Wong (2):
      xfs: fix stupid compiler warning
      xfs: fix a UAF problem in xattr repair

David Strahan (1):
      scsi: smartpqi: Add support for Hurray Data new controller PCI device

Deepanshu Kartikey (3):
      btrfs: fix memory leak of fs_devices in degraded seed device path
      f2fs: invalidate dentry cache on failed whiteout creation
      mm/slub: reset KASAN tag in defer_free() before accessing freed memory

Denis Sergeev (1):
      hwmon: (dell-smm) Limit fan multiplier to avoid overflow

Derek J. Clark (1):
      platform/x86: wmi-gamezone: Add Legion Go 2 Quirks

Dmitry Skorodumov (1):
      ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()

Dongli Zhang (1):
      KVM: nVMX: Immediately refresh APICv controls as needed on nested VM-Exit

Dongsheng Yang (1):
      dm-pcache: advance slot index before writing slot

Doug Berger (1):
      sched/deadline: only set free_cpus for online runqueues

Duoming Zhou (2):
      Input: alps - fix use-after-free bugs caused by dev3_register_work
      usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal

Encrow Thorne (1):
      reset: fix BIT macro reference

Eric Biggers (4):
      lib/crypto: x86/blake2s: Fix 32-bit arg treated as 64-bit
      crypto: scatterwalk - Fix memcpy_sglist() to always succeed
      crypto: arm64/ghash - Fix incorrect output from ghash-neon
      lib/crypto: riscv: Depend on RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS

FUJITA Tomonori (1):
      rust: dma: add helpers for architectures without CONFIG_HAS_DMA

Fedor Pchelkin (2):
      ext4: fix string copying in parse_apply_sb_mount_options()
      ext4: check if mount_opts is NUL-terminated in ext4_ioctl_set_tune_sb()

Fernando Fernandez Mancera (1):
      netfilter: nf_conncount: fix leaked ct in error paths

Filipe Manana (3):
      btrfs: do not skip logging new dentries when logging a new name
      btrfs: fix changeset leak on mmap write after failure to reserve metadata
      btrfs: don't log conflicting inode if it's a dir moved in the current transaction

Finn Thain (1):
      powerpc: Add reloc_offset() to font bitmap pointer used for bootx_printf()

Florian Westphal (3):
      selftests: netfilter: prefer xfail in case race wasn't triggered
      netfilter: nf_nat: remove bogus direction check
      selftests: netfilter: packetdrill: avoid failure on HZ=100 kernel

Gal Pressman (1):
      ethtool: Avoid overflowing userspace buffer on stats query

Gavin Shan (1):
      KVM: selftests: Add missing "break" in rseq_test's param parsing

George Kennedy (1):
      perf/x86/amd: Check event before enable to avoid GPF

Gerd Bayer (1):
      net/mlx5: Fix double unregister of HCA_PORTS component

Gongwei Li (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE

Greg Kroah-Hartman (1):
      Linux 6.18.3

Gregory CLEMENT (1):
      MIPS: ftrace: Fix memory corruption when kernel is located beyond 32 bits

Guangshuo Li (1):
      crypto: caam - Add check for kcalloc() in test_len()

Guenter Roeck (3):
      selftest: af_unix: Support compilers without flex-array-member-not-at-end support
      selftests: net: Fix build warnings
      selftests: net: tfo: Fix build warning

Gui-Dong Han (3):
      hwmon: (max16065) Use local variable to avoid TOCTOU
      hwmon: (w83791d) Convert macros to functions to avoid TOCTOU
      hwmon: (w83l786ng) Convert macros to functions to avoid TOCTOU

Haibo Chen (1):
      ext4: clear i_state_flags when alloc inode

Hal Feng (1):
      cpufreq: dt-platdev: Add JH7110S SOC to the allowlist

Hans de Goede (2):
      wifi: brcmfmac: Add DMI nvram filename quirk for Acer A1 840 tablet
      dma-mapping: Fix DMA_BIT_MASK() macro being broken

Haotian Zhang (2):
      ALSA: vxpocket: Fix resource leak in vxpocket_probe error path
      ALSA: pcmcia: Fix resource leak in snd_pdacf_probe error path

Haoxiang Li (4):
      MIPS: Fix a reference leak bug in ip22_check_gio()
      usb: typec: altmodes/displayport: Drop the device reference in dp_altmode_probe()
      usb: renesas_usbhs: Fix a resource leak in usbhs_pipe_malloc()
      xfs: fix a memory leak in xfs_buf_item_init()

Harry Yoo (1):
      mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction

Helge Deller (1):
      parisc: Do not reprogram affinitiy on ASP chip

Hongyu Xie (1):
      usb: xhci: limit run_graceperiod for only usb 3.0 devices

Ian Rogers (1):
      libperf cpumap: Fix perf_cpu_map__max for an empty/NULL map

Ido Schimmel (3):
      mlxsw: spectrum_router: Fix possible neighbour reference count leak
      mlxsw: spectrum_router: Fix neighbour use-after-free
      mlxsw: spectrum_mr: Fix use-after-free when updating multicast route stats

Ilya Dryomov (1):
      libceph: make decode_pool() more resilient against corrupted osdmaps

Ilya Maximets (1):
      net: openvswitch: fix middle attribute validation in push_nsh() action

Ivan Galkin (1):
      net: phy: RTL8211FVD: Restore disabling of PHY-mode EEE

Jagmeet Randhawa (1):
      drm/xe: Increase TDF timeout

Jakub Kicinski (3):
      inet: frags: avoid theoretical race in ip_frag_reinit()
      inet: frags: add inet_frag_queue_flush()
      inet: frags: flush pending skbs in fqdir_pre_exit()

Jamal Hadi Salim (1):
      net/sched: ets: Always remove class from active list before deleting in ets_qdisc_change

Jan Maslak (1):
      drm/xe: Restore engine registers before restarting schedulers after GT reset

Jan Prusakowski (1):
      f2fs: ensure node page reads complete before f2fs_put_super() finishes

Jani Nikula (1):
      drm/displayid: pass iter to drm_find_displayid_extension()

Jared Kangas (1):
      mmc: sdhci-esdhc-imx: add alternate ARCH_S32 dependency to Kconfig

Jarkko Sakkinen (4):
      KEYS: trusted: Fix a memory leak in tpm2_load_cmd
      tpm: Cap the number of PCR banks
      tpm2-sessions: Fix out of range indexing in name_size
      tpm2-sessions: Fix tpm2_read_public range checks

Jason Gunthorpe (2):
      iommufd/selftest: Make it clearer to gcc that the access is not out of bounds
      iommufd/selftest: Check for overflow in IOMMU_TEST_OP_ADD_RESERVED

Jens Axboe (2):
      io_uring/poll: correctly handle io_poll_add() return value on update
      io_uring: fix min_wait wakeups for SQPOLL

Jens Reidel (1):
      clk: qcom: dispcc-sm7150: Fix dispcc_mdss_pclk0_clk_src

Jeongjun Park (2):
      media: dvb-usb: dtv5100: fix out-of-bounds in dtv5100_i2c_msg()
      media: vidtv: initialize local pointers upon transfer of memory ownership

Jian Shen (3):
      net: hns3: using the num_tqps in the vf driver to apply for resources
      net: hns3: using the num_tqps to check whether tqp_index is out of range when vf get ring info from mbx
      net: hns3: add VLAN id validation before using

Jianbo Liu (2):
      net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init
      net/mlx5e: Trigger neighbor resolution for unresolved destinations

Jianpeng Chang (1):
      arm64: kdump: Fix elfcorehdr overlap caused by reserved memory processing reorder

Jim Mattson (2):
      KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN
      KVM: SVM: Mark VMCB_PERM_MAP as dirty on nested VMRUN

Jinhui Guo (3):
      ipmi: Fix the race between __scan_channels() and deliver_response()
      ipmi: Fix __scan_channels() failing to rescan channels
      i2c: designware: Disable SMBus interrupts to prevent storms from mis-configured firmware

Joanne Koong (5):
      iomap: adjust read range correctly for non-block-aligned positions
      iomap: account for unaligned end offsets when truncating read range
      io_uring/rsrc: fix lost entries after cloned range
      fuse: fix io-uring list corruption for terminated non-committed requests
      fuse: fix readahead reclaim deadlock

Johan Hovold (13):
      clk: keystone: syscon-clk: fix regmap leak on probe failure
      phy: broadcom: bcm63xx-usbh: fix section mismatches
      usb: ohci-nxp: fix device leak on probe failure
      usb: phy: isp1301: fix non-OF device reference imbalance
      usb: gadget: lpc32xx_udc: fix clock imbalance in error path
      amba: tegra-ahb: Fix device leak on SMMU enable
      soc: samsung: exynos-pmu: fix device leak on regmap lookup
      soc: qcom: pbs: fix device leak on lookup
      soc: qcom: ocmem: fix device leak on lookup
      soc: apple: mailbox: fix device leak on lookup
      soc: amlogic: canvas: fix device leak on lookup
      hwmon: (max6697) fix regmap leak on probe failure
      iommu/mediatek: fix use-after-free on probe deferral

Johannes Berg (3):
      wifi: cfg80211: stop radar detection in cfg80211_leave()
      wifi: cfg80211: use cfg80211_leave() in iftype change
      um: init cpu_tasks[] earlier

John Garry (1):
      scsi: scsi_debug: Fix atomic write enable module param description

John Ogness (3):
      printk: Avoid scheduling irq_work on suspend
      printk: Allow printk_trigger_flush() to flush all types
      printk: Avoid irq_work for printk_deferred() on suspend

Josef Bacik (1):
      btrfs: don't rewrite ret from inode_permission

Joshua Rogers (4):
      svcrdma: bound check rq_pages index in inline path
      svcrdma: return 0 on success from svc_rdma_copy_inline_range
      svcrdma: use rc_pageoff for memcpy byte offset
      SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf

Josua Mayer (1):
      clk: mvebu: cp110 add CLK_IGNORE_UNUSED to pcie_x10, pcie_x11 & pcie_x4

José Expósito (3):
      drm/tests: hdmi: Handle drm_kunit_helper_enable_crtc_connector() returning EDEADLK
      drm/tests: Handle EDEADLK in drm_test_check_valid_clones()
      drm/tests: Handle EDEADLK in set_up_atomic_state()

Juergen Gross (1):
      x86/xen: Fix sparse warning in enlighten_pv.c

Junjie Cao (1):
      Input: ti_am335x_tsc - fix off-by-one error in wire_order validation

Junrui Luo (3):
      caif: fix integer underflow in cffrml_receive()
      hwmon: (ibmpex) fix use-after-free in high/low store
      scsi: aic94xx: fix use-after-free in device removal path

Junxiao Chang (2):
      drm/me/gsc: mei interrupt top half should be in irq disabled context
      mei: gsc: add dependency on Xe driver

Justin Tee (2):
      scsi: lpfc: Fix reusing an ndlp that is marked NLP_DROPPED during FLOGI
      nvme-fabrics: add ENOKEY to no retry criteria for authentication failures

Karina Yankevich (1):
      ext4: xattr: fix null pointer deref in ext4_raw_inode()

Kartik Rajput (1):
      soc/tegra: fuse: Do not register SoC device on ACPI boot

Konstantin Komarov (3):
      fs/ntfs3: Support timestamps prior to epoch
      fs/ntfs3: check for shutdown in fsync
      fs/ntfs3: fix mount failure for sparse runs in run_unpack()

Krzysztof Kozlowski (7):
      dt-bindings: PCI: qcom,pcie-sc7280: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8150: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8250: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8350: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8450: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8550: Add missing required power-domains and resets

Laurent Pinchart (1):
      media: v4l2-mem2mem: Fix outdated documentation

Li Chen (1):
      block: rate-limit capacity change info log

Li Qiang (1):
      via_wdt: fix critical boot hang due to unnamed resource allocation

Lizhi Xu (1):
      usbip: Fix locking bug in RT-enabled kernels

Lyude Paul (1):
      rust/drm/gem: Fix missing header in `Object` rustdoc

Ma Ke (5):
      perf: arm_cspmu: fix error handling in arm_cspmu_impl_unregister()
      USB: lpc32xx_udc: Fix error handling in probe
      intel_th: Fix error handling in intel_th_output_open
      mei: Fix error handling in mei_register
      i2c: amd-mp2: fix reference leak in MP2 PCI device

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_open(): fix error handling

Marijn Suijten (1):
      drm/panel: sony-td4353-jdi: Enable prepare_prev_first

Mario Limonciello (1):
      Revert "drm/amd/display: Fix pbn to kbps Conversion"

Mario Limonciello (AMD) (1):
      crypto: ccp - Add support for PCI device 0x115A

Mark Brown (1):
      arm64/gcs: Flush the GCS locking state on exec

Mark Pearson (1):
      usb: typec: ucsi: Handle incorrect num_connectors capability

Marko Turk (1):
      samples: rust: fix endianness issue in rust_driver_pci

Matthias Schiffer (1):
      ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx

Matthieu Baerts (NGI0) (2):
      mptcp: pm: ignore unknown endpoint flags
      selftests: mptcp: pm: ensure unknown flags are ignored

Mauro Carvalho Chehab (1):
      scripts: kdoc_parser.py: warn about Python version only once

Max Chou (1):
      Bluetooth: btusb: Add new VID/PID 0x0489/0xE12F for RTL8852BE-VT

Maxim Levitsky (1):
      KVM: x86: Don't clear async #PF queue when CR0.PG is disabled (e.g. on #SMI)

Miaoqian Lin (3):
      usb: dwc3: of-simple: fix clock resource leak in dwc3_of_simple_probe
      cpufreq: nforce2: fix reference count leak in nforce2
      virtio: vdpa: Fix reference count leak in octep_sriov_enable()

Michael Chan (1):
      bnxt_en: Fix XDP_TX path

Michal Pecio (1):
      usb: xhci: Don't unchain link TRBs on quirky HCs

Mikhail Malyshev (1):
      kbuild: Use objtree for module signing key path

Ming Lei (6):
      selftests: ublk: fix overflow in ublk_queue_auto_zc_fallback()
      block: fix race between wbt_enable_default and IO submission
      ublk: add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg()
      ublk: add `union ublk_io_buf` with improved naming
      ublk: refactor auto buffer register in ublk_dispatch_req()
      ublk: fix deadlock when reading partition table

Minseong Kim (1):
      Input: lkkbd - disable pending work before freeing device

Moshe Shemesh (3):
      net/mlx5: make enable_mpesw idempotent
      net/mlx5: fw reset, clear reset requested on drain_fw_reset
      net/mlx5: Drain firmware reset in shutdown callback

Namjae Jeon (3):
      ksmbd: fix use-after-free in ksmbd_tree_connect_put under concurrency
      ksmbd: Fix refcount leak when invalid session is found on session lookup
      ksmbd: fix buffer validation by including null terminator size in EA length

Neil Armstrong (1):
      drm/msm: adreno: fix deferencing ifpc_reglist when not declared

Nicolas Ferre (3):
      ARM: dts: microchip: sama5d2: fix spi flexcom fifo size to 32
      ARM: dts: microchip: sama7d65: fix uart fifo size to 32
      ARM: dts: microchip: sama7g5: fix uart fifo size to 32

Nilay Shroff (4):
      block: unify elevator tags and type xarrays into struct elv_change_ctx
      block: move elevator tags into struct elevator_resources
      block: introduce alloc_sched_data and free_sched_data elevator methods
      block: use {alloc|free}_sched data methods

Nuno Sá (1):
      hwmon: (ltc4282): Fix reset_history file permissions

Nysal Jan K.A. (1):
      powerpc/kexec: Enable SMT before waking offline CPUs

Ondrej Mosnacek (1):
      bpf, arm64: Do not audit capability check in do_jit()

Pablo Neira Ayuso (1):
      netfilter: nf_tables: remove redundant chain validation on register store

Pankaj Raghav (1):
      scripts/faddr2line: Fix "Argument list too long" error

Paolo Abeni (2):
      mptcp: schedule rtx timer only after pushing data
      mptcp: avoid deadlock on fallback while reinjecting

Pedro Demarchi Gomes (1):
      ntfs: set dummy blocksize to read boot_block when mounting

Pei Xiao (3):
      iio: adc: ti_am335x_adc: Limit step_avg to valid range for gcc complains
      hwmon: (emc2305) fix device node refcount leak in error path
      hwmon: (emc2305) fix double put in emc2305_probe_childs_from_dt

Peng Fan (1):
      firmware: imx: scu-irq: Init workqueue before request mbox channel

Pengjie Zhang (2):
      ACPI: PCC: Fix race condition by removing static qualifier
      ACPI: CPPC: Fix missing PCC check for guaranteed_perf

Peter Ujfalusi (2):
      ASoC: SOF: ipc4-topology: Prefer 32-bit DMIC blobs for 8-bit formats as well
      ASoC: SOF: ipc4-topology: Convert FLOAT to S32 during blob selection

Peter Wang (1):
      scsi: ufs: host: mediatek: Fix shutdown/suspend race condition

Peter Zijlstra (3):
      sched/fair: Revert max_newidle_lb_cost bump
      x86/ptrace: Always inline trivial accessors
      x86/bug: Fix old GCC compile fails

Ping Cheng (1):
      HID: input: map HID_GD_Z to ABS_DISTANCE for stylus/pen

Prajna Rajendra Kumar (1):
      spi: microchip: rename driver file and internal identifiers

Prithvi Tambewagh (2):
      io_uring: fix filename leak in __io_openat_prep()
      ocfs2: fix kernel BUG in ocfs2_find_victim_chain

Qianchang Zhao (2):
      ksmbd: vfs: fix race on m_flags in vfs_cache
      ksmbd: skip lock-range check on equal size to avoid size==0 underflow

Qu Wenruo (2):
      btrfs: fix a potential path leak in print_data_reloc_error()
      btrfs: scrub: always update btrfs_scrub_progress::last_physical

Quan Zhou (1):
      wifi: mt76: mt792x: fix wifi init fail by setting MCU_RUNNING after CLC load

Rafael J. Wysocki (3):
      fs: PM: Fix reverse check in filesystems_freeze_callback()
      cpuidle: governors: teo: Drop misguided target residency check
      PM: runtime: Do not clear needs_force_resume with enabled runtime PM

Raghavendra Rao Ananta (1):
      vfio: Fix ksize arg while copying user struct in vfio_df_ioctl_bind_iommufd()

Raviteja Laggyshetty (1):
      interconnect: qcom: sdx75: Drop QPIC interconnect and BCM nodes

Ray Wu (2):
      drm/amd/display: Fix scratch registers offsets for DCN35
      drm/amd/display: Fix scratch registers offsets for DCN351

Rene Rebe (1):
      floppy: fix for PAGE_SIZE != 4KB

René Rebe (1):
      r8169: fix RTL8117 Wake-on-Lan in DASH mode

Rob Herring (Arm) (1):
      arm64: dts: mediatek: Apply mt8395-radxa DT overlay at build time

Sai Krishna Potthuri (1):
      mmc: sdhci-of-arasan: Increase CD stable timeout to 2 seconds

Sairaj Kodilkar (1):
      amd/iommu: Preserve domain ids inside the kdump kernel

Sakari Ailus (1):
      ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint() only

Sanjay Govind (1):
      Input: xpad - add support for CRKD Guitars

Sarthak Garg (1):
      mmc: sdhci-msm: Avoid early clock doubling during HS400 transition

Sasha Finkelstein (1):
      Input: apple_z2 - fix reading incorrect reports after exiting sleep

Scott Mayhew (1):
      net/handshake: duplicate handshake cancellations leak socket

Sean Christopherson (7):
      KVM: Disallow toggling KVM_MEM_GUEST_MEMFD on an existing memslot
      KVM: x86: WARN if hrtimer callback for periodic APIC timer fires with period=0
      KVM: selftests: Forcefully override ARCH from x86_64 to x86
      KVM: TDX: Explicitly set user-return MSRs that *may* be clobbered by the TDX-Module
      KVM: nSVM: Set exit_code_hi to -1 when synthesizing SVM_EXIT_ERR (failed VMRUN)
      KVM: nSVM: Clear exit_code_hi in VMCB when synthesizing nested VM-Exits
      KVM: x86: Apply runtime updates to current CPUID during KVM_SET_CPUID{,2}

Seunghwan Baek (1):
      scsi: ufs: core: Add ufshcd_update_evt_hist() for UFS suspend error

Shakeel Butt (1):
      cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated

Shardul Bankar (1):
      nfsd: fix memory leak in nfsd_create_serv error paths

Shaurya Rane (1):
      net/hsr: fix NULL pointer dereference in prp_get_untagged_frame()

Shay Drory (3):
      net/mlx5: fw_tracer, Validate format string parameters
      net/mlx5: fw_tracer, Handle escaped percent properly
      net/mlx5: Serialize firmware reset with devlink

Shengjiu Wang (1):
      ASoC: ak4458: remove the reset operation in probe and remove

Shipei Qu (1):
      ALSA: usb-mixer: us16x08: validate meter packet indices

Shivani Agarwal (1):
      crypto: af_alg - zero initialize memory allocated via sock_kmalloc

Shuai Zhang (1):
      Bluetooth: btusb: add new custom firmwares

Shuhao Fu (1):
      cpufreq: s5pv210: fix refcount leak

Shuicheng Lin (3):
      drm/xe: Fix freq kobject leak on sysfs_create_files failure
      drm/xe: Limit num_syncs to prevent oversized allocations
      drm/xe/oa: Limit num_syncs to prevent oversized allocations

Shuming Fan (1):
      ASoC: SDCA: support Q7.8 volume format

Shuran Liu (1):
      bpf: Fix verifier assumptions of bpf_d_path's output buffer

Slavin Liu (1):
      ipvs: fix ipv4 null-ptr-deref in route error path

Song Liu (1):
      livepatch: Match old_sympos 0 and 1 in klp_find_func()

Sourabh Jain (1):
      crash: let architecture decide crash memory export to iomem_resource

Srinivas Kandagatla (2):
      dt-bindings: slimbus: fix warning from example
      rpmsg: glink: fix rpmsg device leak

Stefan Binding (1):
      ASoC: ops: fix snd_soc_get_volsw for sx controls

Stefan Haberland (1):
      s390/dasd: Fix gendisk parent after copy pair swap

Stefano Garzarella (1):
      vhost/vsock: improve RCU read sections around vhost_vsock_get()

Steven Rostedt (3):
      ktest.pl: Fix uninitialized var in config-bisect.pl
      tracing: Do not register unsupported perf events
      tracing: Fix fixed array of synthetic event

Sven Eckelmann (Plasma Cloud) (1):
      wifi: mt76: Fix DTS power-limits on little endian systems

Sven Schnelle (1):
      s390/ipl: Clear SBP flag when bootprog is set

T.J. Mercier (1):
      bpf: Fix truncated dmabuf iterator reads

Tal Zussman (1):
      x86/mm/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum in <trace/events/tlb.h>

Tejun Heo (3):
      sched_ext: Factor out local_dsq_post_enq() from dispatch_enqueue()
      sched_ext: Fix bypass depth leak on scx_enable() failure
      sched_ext: Fix missing post-enqueue handling in move_local_task_to_local_dsq()

Tetsuo Handa (3):
      hfsplus: Verify inode mode when loading from disk
      can: j1939: make j1939_sk_bind() fail if device is no longer registered
      jbd2: use a per-journal lock_class_key for jbd2_trans_commit_key

Thomas Fourier (1):
      block: rnbd-clt: Fix leaked ID in init_dev()

Thomas Gleixner (1):
      x86/msi: Make irq_retrigger() functional for posted MSI

Thorsten Blum (1):
      net: phy: marvell-88q2xxx: Fix clamped value in mv88q2xxx_hwmon_write

Tianchu Chen (1):
      char: applicom: fix NULL pointer dereference in ac_ioctl

Tomas Glozar (1):
      rtla/timerlat_bpf: Stop tracing on user latency

Tony Battersby (4):
      scsi: qla2xxx: Fix lost interrupts with qlini_mode=disabled
      scsi: qla2xxx: Fix initiator mode with qlini_mode=exclusive
      scsi: qla2xxx: Use reinit_completion on mbx_intr_comp
      scsi: Revert "scsi: qla2xxx: Perform lockless command completion in abort path"

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_ishtp: Fix UAF after unbinding driver

Udipto Goswami (1):
      usb: dwc3: keep susphy enabled during exit to avoid controller faults

Viacheslav Dubeyko (3):
      hfsplus: fix volume corruption issue for generic/070
      hfsplus: fix volume corruption issue for generic/073
      hfsplus: fix volume corruption issue for generic/101

Victor Nogueira (1):
      net/sched: ets: Remove drr class from the active list if it changes to strict

Vinay Belgaumkar (1):
      drm/xe: Apply Wa_14020316580 in xe_gt_idle_enable_pg()

Vivian Wang (1):
      lib/crypto: riscv/chacha: Avoid s0/fp register

Vladimir Oltean (5):
      net: phy: realtek: eliminate priv->phycr2 variable
      net: phy: realtek: eliminate has_phycr2 variable
      net: phy: realtek: allow CLKOUT to be disabled on RTL8211F(D)(I)-VD-CG
      net: phy: realtek: eliminate priv->phycr1 variable
      net: phy: realtek: create rtl8211f_config_phy_eee() helper

Wang Liang (1):
      netrom: Fix memory leak in nr_sendmsg()

Wangao Wang (1):
      media: iris: Add sanity check for stop streaming

Wanpeng Li (1):
      KVM: Fix last_boosted_vcpu index assignment bug

Wei Fang (2):
      net: fec: ERR007885 Workaround for XDP TX path
      net: enetc: do not transmit redirected XDP frames when the link is down

Wei Yang (1):
      mm/huge_memory: add pmd folio to ds_queue in do_huge_zero_wp_pmd()

Wenhua Lin (1):
      serial: sprd: Return -EPROBE_DEFER when uart clock is not ready

Wentao Guan (1):
      gpio: regmap: Fix memleak in error path in gpio_regmap_register()

Xi Ruoyao (1):
      gpio: loongson: Switch 2K2000/3000 GPIO to BYTE_CTRL_MODE

Xiaole He (2):
      f2fs: fix age extent cache insertion skip on counter overflow
      f2fs: fix uninitialized one_time_gc in victim_sel_policy

Yang Chenzhi (1):
      hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create

Ye Bin (1):
      jbd2: fix the inconsistency between checksum and data in memory for journal sb

Yongjian Sun (1):
      ext4: fix incorrect group number assertion in mb_check_buddy

Yongxin Liu (2):
      platform/x86: intel_pmc_ipc: fix ACPI buffer memory leak
      x86/fpu: Fix FPU state core dump truncation on CPUs with no extended xfeatures

Yosry Ahmed (2):
      KVM: nSVM: Avoid incorrect injection of SVM_EXIT_CR0_SEL_WRITE
      KVM: nSVM: Propagate SVM_EXIT_CR0_SEL_WRITE correctly for LMSW emulation

Yu Peng (1):
      x86/microcode: Mark early_parse_cmdline() as __init

Yuezhang Mo (2):
      exfat: fix remount failure in different process environments
      exfat: zero out post-EOF page cache on file extension

Zheng Yejian (1):
      kallsyms: Fix wrong "big" kernel symbol type read from procfs

Zhichi Lin (1):
      scs: fix a wrong parameter in __scs_magic

Zilin Guan (1):
      cifs: Fix memory and information leak in smb3_reconfigure()

Zqiang (1):
      sched_ext: Fix the memleak for sch->helper objects

caoping (1):
      net/handshake: restore destructor on submit failure

fuqiang wang (2):
      KVM: x86: Explicitly set new periodic hrtimer expiration in apic_timer_fn()
      KVM: x86: Fix VM hard lockup after prolonged inactivity with periodic HV timer

huang-jl (1):
      io_uring: fix nr_segs calculation in io_import_kbuf

j.turek (1):
      serial: xilinx_uartps: fix rs485 delay_rts_after_send

xu xin (1):
      mm/ksm: fix exec/fork inheritance support for prctl

Łukasz Bartosik (1):
      xhci: dbgtty: fix device unregister: fixup


