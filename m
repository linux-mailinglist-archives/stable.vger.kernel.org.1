Return-Path: <stable+bounces-50219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF35F904F80
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 11:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE5328A915
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0AB16E885;
	Wed, 12 Jun 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WK/g2BmZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243FC16DED1;
	Wed, 12 Jun 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185445; cv=none; b=SQmnh1olelGUzUJi4hlg4EFyk2rtQe4WLd9+tUMhyMY0AI6OsJWKH4bObYH92w+nhXA1jh7brcOGR0AKhWY2L7uiforHjPxYTRjwtttfp/3spwzYMk9TDtUE9fRqbb1HJV2gh9dOQmpzIB77z2oh6TK8xkPOg+DyoT87oGwFJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185445; c=relaxed/simple;
	bh=U1BhorOz5agKTHkJdrAxmnA85ETzqhAcykczVHDTL0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qhx6i+kJSWKwPkVYIT8Xp8T3f7arVkoFi4ocXZefwDoFTItjZguy1LbaN4Z1qJ12twPFOGrN6IgSDlvH58cLt8bP59JWUgKFlR3B6Dv0mmjOOSOkz5XgwOVQifICvHMOVeg7rnjYQpTiL7jaAHUVs8bbd5Ko4E7hBpifa+OaWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WK/g2BmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9D5C4AF48;
	Wed, 12 Jun 2024 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718185445;
	bh=U1BhorOz5agKTHkJdrAxmnA85ETzqhAcykczVHDTL0A=;
	h=From:To:Cc:Subject:Date:From;
	b=WK/g2BmZh9uihfa/XRQU+4KarOZWmyQuydiozzKhI/wxpVKBOPqB11MSvDkT+xMZV
	 ZS31HbNFXL7QaiAHZ7lc0dGBxsAhmPV4I+xFGvnQ62auxxbDMR6oYOEGMQcdzOvBjM
	 gxToOdykgnZob63emq5wjT8/dGqL7oiSC0ecr5tU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.9.4
Date: Wed, 12 Jun 2024 11:43:59 +0200
Message-ID: <2024061258-squishier-canteen-6ba0@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.9.4 kernel.

All users of the 6.9 kernel series must upgrade.

The updated 6.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.9.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml               |    3 
 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml        |    1 
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml  |    1 
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml   |   16 
 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml      |    4 
 Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml |   92 ++--
 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml        |   52 --
 Documentation/driver-api/fpga/fpga-bridge.rst                          |    7 
 Documentation/driver-api/fpga/fpga-mgr.rst                             |   34 -
 Documentation/driver-api/fpga/fpga-region.rst                          |   13 
 Documentation/iio/adis16475.rst                                        |    8 
 Makefile                                                               |    2 
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi                              |   13 
 arch/arm64/include/asm/asm-bug.h                                       |    1 
 arch/arm64/kvm/arm.c                                                   |   50 ++
 arch/loongarch/include/asm/perf_event.h                                |    3 
 arch/microblaze/kernel/Makefile                                        |    1 
 arch/microblaze/kernel/cpu/cpuinfo-static.c                            |    2 
 arch/powerpc/include/asm/hvcall.h                                      |    2 
 arch/powerpc/include/asm/ppc-opcode.h                                  |    4 
 arch/powerpc/kvm/book3s_hv.c                                           |    2 
 arch/powerpc/kvm/book3s_hv_nestedv2.c                                  |    4 
 arch/powerpc/net/bpf_jit_comp32.c                                      |  137 +++++-
 arch/powerpc/platforms/pseries/lpar.c                                  |    6 
 arch/powerpc/platforms/pseries/lparcfg.c                               |   10 
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi         |   98 ----
 arch/riscv/include/asm/sbi.h                                           |    2 
 arch/riscv/kernel/cpu.c                                                |   40 +
 arch/riscv/kernel/cpu_ops_sbi.c                                        |    2 
 arch/riscv/kernel/cpu_ops_spinwait.c                                   |    3 
 arch/riscv/kernel/cpufeature.c                                         |   10 
 arch/riscv/kernel/smpboot.c                                            |    7 
 arch/riscv/kernel/stacktrace.c                                         |   20 
 arch/s390/boot/startup.c                                               |    1 
 arch/s390/include/asm/ftrace.h                                         |    8 
 arch/s390/include/asm/processor.h                                      |    1 
 arch/s390/include/asm/stacktrace.h                                     |   12 
 arch/s390/kernel/Makefile                                              |    2 
 arch/s390/kernel/asm-offsets.c                                         |    5 
 arch/s390/kernel/ipl.c                                                 |   10 
 arch/s390/kernel/perf_event.c                                          |   34 -
 arch/s390/kernel/setup.c                                               |    2 
 arch/s390/kernel/stacktrace.c                                          |  108 ++++-
 arch/s390/kernel/vdso.c                                                |   13 
 arch/s390/kernel/vdso32/Makefile                                       |    4 
 arch/s390/kernel/vdso64/Makefile                                       |    4 
 arch/s390/kernel/vdso64/vdso_user_wrapper.S                            |   19 
 arch/um/drivers/line.c                                                 |   14 
 arch/um/drivers/ubd_kern.c                                             |    4 
 arch/um/drivers/vector_kern.c                                          |    2 
 arch/um/include/asm/kasan.h                                            |    1 
 arch/um/include/asm/mmu.h                                              |    2 
 arch/um/include/asm/processor-generic.h                                |    1 
 arch/um/include/shared/kern_util.h                                     |    2 
 arch/um/include/shared/skas/mm_id.h                                    |    2 
 arch/um/os-Linux/mem.c                                                 |    1 
 arch/x86/Kconfig.debug                                                 |    5 
 arch/x86/include/asm/percpu.h                                          |   42 --
 arch/x86/kernel/apic/vector.c                                          |    9 
 arch/x86/kernel/cpu/common.c                                           |    3 
 arch/x86/kernel/cpu/cpu.h                                              |    2 
 arch/x86/kernel/cpu/intel.c                                            |   25 -
 arch/x86/kernel/cpu/topology.c                                         |   53 ++
 arch/x86/kvm/cpuid.c                                                   |   21 -
 arch/x86/pci/mmconfig-shared.c                                         |   40 +
 arch/x86/um/shared/sysdep/archsetjmp.h                                 |    7 
 arch/x86/xen/enlighten.c                                               |   33 +
 block/blk-cgroup.c                                                     |   87 +++-
 block/blk-settings.c                                                   |    2 
 drivers/base/base.h                                                    |    9 
 drivers/base/bus.c                                                     |    9 
 drivers/base/module.c                                                  |   42 +-
 drivers/block/null_blk/main.c                                          |   42 +-
 drivers/char/ppdev.c                                                   |   15 
 drivers/char/tpm/tpm_tis_spi_main.c                                    |    3 
 drivers/cxl/core/region.c                                              |    1 
 drivers/cxl/core/trace.h                                               |    4 
 drivers/dma-buf/sync_debug.c                                           |    4 
 drivers/dma/idma64.c                                                   |    4 
 drivers/dma/idxd/cdev.c                                                |    1 
 drivers/extcon/Kconfig                                                 |    3 
 drivers/firmware/dmi-id.c                                              |    7 
 drivers/firmware/efi/libstub/fdt.c                                     |    4 
 drivers/firmware/efi/libstub/x86-stub.c                                |   28 +
 drivers/fpga/fpga-bridge.c                                             |   57 +-
 drivers/fpga/fpga-mgr.c                                                |   82 ++--
 drivers/fpga/fpga-region.c                                             |   24 -
 drivers/gpio/gpiolib-acpi.c                                            |   19 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                             |   19 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                                |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c            |    3 
 drivers/gpu/drm/bridge/imx/Kconfig                                     |    4 
 drivers/gpu/drm/bridge/tc358775.c                                      |   21 -
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                                  |    1 
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                              |    6 
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c                            |    2 
 drivers/gpu/drm/i915/gt/intel_gt_types.h                               |    8 
 drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h                          |    6 
 drivers/gpu/drm/mediatek/mtk_dp.c                                      |    2 
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c                              |    7 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                  |    7 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c                   |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c                             |    9 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c                      |    4 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                     |   10 
 drivers/gpu/drm/nouveau/nouveau_abi16.c                                |    3 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                   |   44 --
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c                         |   16 
 drivers/gpu/drm/xe/xe_device.c                                         |   21 -
 drivers/gpu/drm/xe/xe_migrate.c                                        |   12 
 drivers/gpu/drm/xe/xe_pcode.c                                          |  115 +++--
 drivers/gpu/drm/xe/xe_pcode.h                                          |    6 
 drivers/gpu/drm/xe/xe_pm.c                                             |   36 +
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                                    |    7 
 drivers/hwmon/intel-m10-bmc-hwmon.c                                    |    2 
 drivers/hwmon/shtc1.c                                                  |    2 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                     |   29 -
 drivers/hwtracing/coresight/coresight-etm4x.h                          |   31 -
 drivers/hwtracing/stm/core.c                                           |   11 
 drivers/i2c/busses/i2c-cadence.c                                       |    1 
 drivers/i2c/busses/i2c-synquacer.c                                     |   20 
 drivers/i3c/master/svc-i3c-master.c                                    |    2 
 drivers/iio/adc/adi-axi-adc.c                                          |    4 
 drivers/iio/adc/pac1934.c                                              |    9 
 drivers/iio/adc/stm32-adc.c                                            |    1 
 drivers/iio/industrialio-core.c                                        |    6 
 drivers/iio/pressure/dps310.c                                          |   11 
 drivers/infiniband/core/addr.c                                         |   12 
 drivers/input/misc/ims-pcu.c                                           |    4 
 drivers/input/misc/pm8xxx-vibrator.c                                   |    7 
 drivers/input/mouse/cyapa.c                                            |   12 
 drivers/input/serio/ioc3kbd.c                                          |    7 
 drivers/interconnect/qcom/qcm2290.c                                    |    2 
 drivers/leds/leds-pwm.c                                                |    8 
 drivers/mailbox/mtk-cmdq-mailbox.c                                     |    2 
 drivers/media/cec/core/cec-adap.c                                      |   24 -
 drivers/media/cec/core/cec-api.c                                       |    5 
 drivers/media/i2c/ov2680.c                                             |   13 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c     |    4 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h     |    2 
 drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c           |    5 
 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig              |    1 
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c                  |    5 
 drivers/media/usb/b2c2/flexcop-usb.c                                   |    2 
 drivers/media/usb/stk1160/stk1160-video.c                              |   20 
 drivers/media/v4l2-core/v4l2-subdev.c                                  |   22 -
 drivers/misc/vmw_vmci/vmci_guest.c                                     |   10 
 drivers/mmc/host/sdhci_am654.c                                         |  168 ++++++--
 drivers/net/Makefile                                                   |    4 
 drivers/net/dsa/microchip/ksz_common.c                                 |    2 
 drivers/net/ethernet/amazon/ena/ena_com.c                              |   11 
 drivers/net/ethernet/cisco/enic/enic_main.c                            |   12 
 drivers/net/ethernet/freescale/fec_main.c                              |   10 
 drivers/net/ethernet/freescale/fec_ptp.c                               |   14 
 drivers/net/ethernet/intel/ice/ice_common.c                            |   10 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                           |   19 
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c                      |   11 
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c                         |   21 -
 drivers/net/ethernet/intel/idpf/idpf_lib.c                             |    1 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                            |   12 
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                            |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                          |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                          |   56 --
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                       |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h            |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c            |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h          |   17 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                        |    6 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                      |   12 
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c                       |   12 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c                    |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                  |    6 
 drivers/net/ethernet/ti/icssg/icssg_classifier.c                       |    2 
 drivers/net/ipvlan/ipvlan_core.c                                       |    4 
 drivers/net/netkit.c                                                   |   30 +
 drivers/net/phy/micrel.c                                               |   11 
 drivers/net/usb/smsc95xx.c                                             |   11 
 drivers/net/vrf.c                                                      |    4 
 drivers/net/vxlan/vxlan_core.c                                         |    2 
 drivers/nvme/host/core.c                                               |   17 
 drivers/nvme/host/multipath.c                                          |    3 
 drivers/nvme/host/nvme.h                                               |    1 
 drivers/nvme/target/configfs.c                                         |    8 
 drivers/pci/controller/dwc/pcie-designware-ep.c                        |  120 +++--
 drivers/pci/controller/dwc/pcie-tegra194.c                             |    3 
 drivers/pci/of_property.c                                              |    2 
 drivers/pci/pci.c                                                      |    2 
 drivers/pci/pcie/edr.c                                                 |   28 -
 drivers/perf/arm_dmc620_pmu.c                                          |    9 
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c                              |   54 ++
 drivers/pinctrl/qcom/pinctrl-sm7150.c                                  |   20 
 drivers/pinctrl/renesas/pfc-r8a779h0.c                                 |   24 -
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                |    2 
 drivers/platform/x86/intel/tpmi.c                                      |    7 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c    |    7 
 drivers/platform/x86/thinkpad_acpi.c                                   |    5 
 drivers/regulator/bd71828-regulator.c                                  |   58 --
 drivers/regulator/helpers.c                                            |   43 +-
 drivers/regulator/tps6287x-regulator.c                                 |    1 
 drivers/regulator/tps6594-regulator.c                                  |   16 
 drivers/s390/crypto/ap_bus.c                                           |    8 
 drivers/s390/net/qeth_core.h                                           |    9 
 drivers/scsi/sd.c                                                      |    4 
 drivers/soundwire/cadence_master.c                                     |    2 
 drivers/spi/spi-stm32.c                                                |   16 
 drivers/spi/spi.c                                                      |    4 
 drivers/spmi/spmi-pmic-arb.c                                           |   12 
 drivers/staging/greybus/arche-apb-ctrl.c                               |    1 
 drivers/staging/greybus/arche-platform.c                               |    9 
 drivers/staging/greybus/light.c                                        |    8 
 drivers/tty/serial/max3100.c                                           |   22 -
 drivers/tty/serial/sc16is7xx.c                                         |    2 
 drivers/tty/serial/sh-sci.c                                            |    5 
 drivers/usb/fotg210/fotg210-core.c                                     |    1 
 drivers/usb/gadget/function/u_audio.c                                  |   21 -
 drivers/usb/host/xhci-mem.c                                            |   22 -
 drivers/usb/host/xhci.h                                                |    6 
 drivers/usb/typec/ucsi/ucsi.c                                          |   21 -
 drivers/vfio/pci/vfio_pci_intrs.c                                      |    4 
 drivers/video/backlight/mp3309c.c                                      |    3 
 drivers/virtio/virtio_balloon.c                                        |   13 
 drivers/virtio/virtio_pci_common.c                                     |    4 
 drivers/watchdog/bd9576_wdt.c                                          |   12 
 drivers/watchdog/cpu5wdt.c                                             |    2 
 drivers/watchdog/sa1100_wdt.c                                          |    5 
 drivers/xen/xenbus/xenbus_probe.c                                      |   36 +
 fs/f2fs/data.c                                                         |   19 
 fs/f2fs/f2fs.h                                                         |   15 
 fs/f2fs/file.c                                                         |   92 ++--
 fs/f2fs/gc.c                                                           |    9 
 fs/f2fs/node.c                                                         |    2 
 fs/f2fs/segment.c                                                      |    2 
 fs/fuse/dev.c                                                          |    3 
 fs/netfs/buffered_write.c                                              |    2 
 fs/nfs/filelayout/filelayout.c                                         |    4 
 fs/nfs/fs_context.c                                                    |    9 
 fs/nfs/nfs4state.c                                                     |   12 
 fs/ntfs3/fslog.c                                                       |    3 
 fs/ntfs3/inode.c                                                       |   17 
 fs/ntfs3/ntfs.h                                                        |    2 
 fs/ocfs2/localalloc.c                                                  |   19 
 fs/ocfs2/reservations.c                                                |    2 
 fs/ocfs2/suballoc.c                                                    |    6 
 fs/overlayfs/dir.c                                                     |    3 
 fs/smb/client/cifsfs.c                                                 |   12 
 fs/smb/client/smb2ops.c                                                |    1 
 fs/udf/inode.c                                                         |   27 -
 include/linux/counter.h                                                |    1 
 include/linux/etherdevice.h                                            |    8 
 include/linux/fortify-string.h                                         |   22 -
 include/linux/fpga/fpga-bridge.h                                       |   10 
 include/linux/fpga/fpga-mgr.h                                          |   26 -
 include/linux/fpga/fpga-region.h                                       |   13 
 include/linux/mlx5/mlx5_ifc.h                                          |    4 
 include/linux/regulator/driver.h                                       |    3 
 include/linux/skbuff.h                                                 |    9 
 include/media/cec.h                                                    |    1 
 include/net/bluetooth/hci_core.h                                       |    3 
 include/net/dst_ops.h                                                  |    2 
 include/net/ip.h                                                       |    4 
 include/net/ip6_fib.h                                                  |    6 
 include/net/ip6_route.h                                                |   11 
 include/net/route.h                                                    |   11 
 include/net/sock.h                                                     |   13 
 include/sound/tas2781-dsp.h                                            |    7 
 include/uapi/drm/nouveau_drm.h                                         |    7 
 init/Kconfig                                                           |    4 
 kernel/bpf/verifier.c                                                  |   10 
 kernel/dma/map_benchmark.c                                             |   22 -
 kernel/gen_kheaders.sh                                                 |    7 
 kernel/irq/cpuhotplug.c                                                |   16 
 kernel/trace/rv/rv.c                                                   |    2 
 kernel/trace/trace_probe.c                                             |    4 
 lib/Kconfig.ubsan                                                      |    1 
 lib/strcat_kunit.c                                                     |   12 
 lib/string_kunit.c                                                     |  155 +++++++
 lib/strscpy_kunit.c                                                    |   51 +-
 net/atm/clip.c                                                         |    2 
 net/bluetooth/6lowpan.c                                                |    2 
 net/bluetooth/hci_event.c                                              |   58 +-
 net/bluetooth/iso.c                                                    |   94 +---
 net/core/dst_cache.c                                                   |    4 
 net/core/filter.c                                                      |    5 
 net/ethernet/eth.c                                                     |    4 
 net/ipv4/af_inet.c                                                     |    6 
 net/ipv4/devinet.c                                                     |    7 
 net/ipv4/icmp.c                                                        |   26 -
 net/ipv4/ip_input.c                                                    |    2 
 net/ipv4/ip_output.c                                                   |    8 
 net/ipv4/ip_tunnel.c                                                   |    2 
 net/ipv4/netfilter/nf_tproxy_ipv4.c                                    |    2 
 net/ipv4/route.c                                                       |   46 --
 net/ipv4/tcp_dctcp.c                                                   |   13 
 net/ipv4/udp.c                                                         |    2 
 net/ipv4/xfrm4_policy.c                                                |    2 
 net/ipv6/icmp.c                                                        |    8 
 net/ipv6/ila/ila_lwt.c                                                 |    4 
 net/ipv6/ip6_output.c                                                  |   18 
 net/ipv6/ip6mr.c                                                       |    2 
 net/ipv6/ndisc.c                                                       |    2 
 net/ipv6/ping.c                                                        |    2 
 net/ipv6/raw.c                                                         |    4 
 net/ipv6/route.c                                                       |   57 +-
 net/ipv6/seg6_hmac.c                                                   |   42 +-
 net/ipv6/seg6_iptunnel.c                                               |   11 
 net/ipv6/tcp_ipv6.c                                                    |    4 
 net/ipv6/udp.c                                                         |   11 
 net/ipv6/xfrm6_policy.c                                                |    2 
 net/l2tp/l2tp_ip.c                                                     |    2 
 net/l2tp/l2tp_ip6.c                                                    |    2 
 net/mpls/mpls_iptunnel.c                                               |    4 
 net/netfilter/ipset/ip_set_list_set.c                                  |    3 
 net/netfilter/ipvs/ip_vs_xmit.c                                        |   16 
 net/netfilter/nf_flow_table_core.c                                     |    8 
 net/netfilter/nf_flow_table_ip.c                                       |    8 
 net/netfilter/nfnetlink_queue.c                                        |    2 
 net/netfilter/nft_fib.c                                                |    8 
 net/netfilter/nft_payload.c                                            |   95 +++-
 net/netfilter/nft_rt.c                                                 |    4 
 net/nfc/nci/core.c                                                     |   18 
 net/openvswitch/actions.c                                              |    6 
 net/sched/sch_taprio.c                                                 |   14 
 net/sctp/ipv6.c                                                        |    2 
 net/sctp/protocol.c                                                    |    4 
 net/sunrpc/auth_gss/svcauth_gss.c                                      |    2 
 net/sunrpc/clnt.c                                                      |    1 
 net/sunrpc/xprtrdma/verbs.c                                            |    6 
 net/tipc/udp_media.c                                                   |    2 
 net/tls/tls_main.c                                                     |   10 
 net/unix/af_unix.c                                                     |   47 +-
 net/xfrm/xfrm_policy.c                                                 |   14 
 scripts/Makefile.vdsoinst                                              |    2 
 scripts/kconfig/symbol.c                                               |    6 
 sound/core/init.c                                                      |    9 
 sound/core/jack.c                                                      |   21 -
 sound/core/seq/seq_ump_convert.c                                       |   46 ++
 sound/pci/hda/cs35l56_hda.c                                            |    8 
 sound/pci/hda/hda_component.c                                          |   16 
 sound/pci/hda/hda_component.h                                          |    7 
 sound/pci/hda/hda_cs_dsp_ctl.c                                         |   47 +-
 sound/pci/hda/patch_realtek.c                                          |    5 
 sound/soc/amd/acp/acp-legacy-common.c                                  |   96 ++++
 sound/soc/amd/acp/acp-pci.c                                            |    9 
 sound/soc/amd/acp/amd.h                                                |   10 
 sound/soc/amd/acp/chip_offset_byte.h                                   |    1 
 sound/soc/codecs/cs42l43.c                                             |    5 
 sound/soc/codecs/rt715-sdca-sdw.c                                      |    4 
 sound/soc/codecs/tas2552.c                                             |   15 
 sound/soc/codecs/tas2781-fmwlib.c                                      |  109 +----
 sound/soc/codecs/tas2781-i2c.c                                         |    4 
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c                             |    4 
 sound/soc/sof/debug.c                                                  |   23 +
 tools/arch/x86/intel_sdsi/intel_sdsi.c                                 |   48 +-
 tools/bpf/resolve_btfids/main.c                                        |    2 
 tools/lib/subcmd/parse-options.c                                       |    8 
 tools/perf/Documentation/perf-list.txt                                 |    1 
 tools/perf/Makefile.perf                                               |    7 
 tools/perf/bench/inject-buildid.c                                      |    2 
 tools/perf/bench/uprobe.c                                              |    2 
 tools/perf/builtin-annotate.c                                          |    2 
 tools/perf/builtin-daemon.c                                            |    4 
 tools/perf/builtin-record.c                                            |    8 
 tools/perf/builtin-report.c                                            |    2 
 tools/perf/builtin-sched.c                                             |    7 
 tools/perf/pmu-events/arch/s390/cf_z16/transaction.json                |   28 -
 tools/perf/pmu-events/arch/s390/mapfile.csv                            |    2 
 tools/perf/tests/builtin-test.c                                        |   37 -
 tools/perf/tests/code-reading.c                                        |   10 
 tools/perf/tests/shell/test_arm_coresight.sh                           |    2 
 tools/perf/tests/workloads/datasym.c                                   |   16 
 tools/perf/ui/browser.c                                                |    6 
 tools/perf/ui/browser.h                                                |    2 
 tools/perf/util/annotate.c                                             |   19 
 tools/perf/util/dwarf-aux.c                                            |  202 ++++++----
 tools/perf/util/dwarf-aux.h                                            |   17 
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c                    |    2 
 tools/perf/util/intel-pt.c                                             |    2 
 tools/perf/util/machine.c                                              |    2 
 tools/perf/util/perf_event_attr_fprintf.c                              |   26 -
 tools/perf/util/pmu.c                                                  |  119 ++++-
 tools/perf/util/pmu.h                                                  |    7 
 tools/perf/util/probe-event.c                                          |    1 
 tools/perf/util/python.c                                               |   10 
 tools/perf/util/stat-display.c                                         |    3 
 tools/perf/util/symbol.c                                               |   49 +-
 tools/perf/util/thread.c                                               |   14 
 tools/testing/selftests/drivers/net/mlxsw/mlxsw_lib.sh                 |    2 
 tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh |    1 
 tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh   |    1 
 tools/testing/selftests/kselftest_harness.h                            |   11 
 tools/testing/selftests/mm/mdwe_test.c                                 |    1 
 tools/testing/selftests/net/amt.sh                                     |    8 
 tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh             |   53 --
 tools/testing/selftests/net/forwarding/ethtool_rmon.sh                 |    4 
 tools/testing/selftests/net/forwarding/lib.sh                          |  186 ++++-----
 tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh          |    2 
 tools/testing/selftests/net/lib.sh                                     |  114 +++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh                        |   16 
 tools/testing/selftests/net/mptcp/simult_flows.sh                      |   10 
 tools/testing/selftests/powerpc/dexcr/Makefile                         |    2 
 tools/testing/selftests/riscv/hwprobe/.gitignore                       |    2 
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json         |   44 ++
 403 files changed, 4026 insertions(+), 2421 deletions(-)

Aaron Conole (1):
      openvswitch: Set the skbuff pkt_type for proper pmtud support.

Adam Ford (1):
      drm/bridge: imx: Fix unmet depenency for PHY_FSL_SAMSUNG_HDMI_PHY

Adrian Hunter (2):
      perf record: Fix debug message placement for test consumption
      perf intel-pt: Fix unassigned instruction op (discovered by MemorySanitizer)

Aleksandr Mishin (1):
      drm/msm/dpu: Add callback function pointer check before its call

Alex Deucher (1):
      drm/amdgpu: Adjust logic in amdgpu_device_partner_bandwidth()

Alexander Egorenkov (2):
      s390/ipl: Fix incorrect initialization of len fields in nvme reipl block
      s390/ipl: Fix incorrect initialization of nvme dump block

Alexander Lobakin (1):
      idpf: don't enable NAPI and interrupts prior to allocating Rx buffers

Alexander Maltsev (1):
      netfilter: ipset: Add list flush to cancel_gc

Alexander Mikhalitsyn (1):
      ipv4: correctly iterate over the target netns in inet_dump_ifaddr()

Alison Schofield (1):
      cxl/trace: Correct DPA field masks for general_media & dram events

Andi Shyti (1):
      drm/i915/gt: Fix CCS id's calculation for CCS mode setting

Andrea Mayer (1):
      ipv6: sr: fix missing sk_buff release in seg6_input_core

Andrey Konovalov (1):
      kasan, fortify: properly rename memintrinsics

Andy Shevchenko (6):
      iio: core: Leave private pointer NULL when no private data supplied
      serial: max3100: Lock port->lock when calling uart_handle_cts_change()
      serial: max3100: Update uart_driver_registered on driver removal
      serial: max3100: Fix bitwise types
      usb: fotg210: Add missing kernel doc description
      spi: Don't mark message DMA mapped when no transfer in it is

Anshuman Khandual (1):
      coresight: etm4x: Fix unbalanced pm_runtime_enable()

Ard Biesheuvel (1):
      x86/efistub: Omit physical KASLR when memory reservations exist

Arnaldo Carvalho de Melo (1):
      perf probe: Add missing libgen.h header needed for using basename()

Arnd Bergmann (5):
      firmware: dmi-id: add a release callback function
      greybus: arche-ctrl: move device table to its right location
      module: don't ignore sysfs_create_link() failures
      Input: ims-pcu - fix printf string overflow
      drm/i915/guc: avoid FIELD_PREP warning

Bard Liao (1):
      ASoC: rt715-sdca-sdw: Fix wrong complete waiting in rt715_dev_resume()

Benjamin Coddington (1):
      NFSv4: Fixup smatch warning for ambiguous return

Benjamin Gray (1):
      selftests/powerpc/dexcr: Add -no-pie to hashchk tests

Bjorn Helgaas (1):
      x86/pci: Skip early E820 check for ECAM region

Carlos López (1):
      tracing/probes: fix error check in parse_btf_field()

Carolina Jubran (1):
      net/mlx5e: Use rx_missed_errors instead of rx_dropped for reporting buffer exhaustion

Chao Yu (12):
      f2fs: multidev: fix to recognize valid zero block address
      f2fs: fix to wait on page writeback in __clone_blkaddrs()
      f2fs: compress: fix to relocate check condition in f2fs_{release,reserve}_compress_blocks()
      f2fs: compress: fix to relocate check condition in f2fs_ioc_{,de}compress_file()
      f2fs: fix to relocate check condition in f2fs_fallocate()
      f2fs: fix to check pinfile flag in f2fs_move_file_range()
      f2fs: compress: fix to update i_compr_blocks correctly
      f2fs: compress: fix error path of inc_valid_block_count()
      f2fs: compress: fix to cover {reserve,release}_compress_blocks() w/ cp_rwsem lock
      f2fs: fix to release node block count in error path of f2fs_new_node_page()
      f2fs: compress: don't allow unaligned truncation on released compress inode
      f2fs: fix to add missing iput() in gc_data_segment()

Charles Keepax (1):
      ASoC: cs42l43: Only restrict 44.1kHz for the ASP

Charlie Jenkins (3):
      riscv: cpufeature: Fix thead vector hwcap removal
      riscv: cpufeature: Fix extension subset checking
      riscv: selftests: Add hwprobe binaries to .gitignore

Chen Ni (2):
      dmaengine: idma64: Add check for dma_set_max_seg_size
      watchdog: sa1100: Fix PTR_ERR_OR_ZERO() vs NULL check in sa1100dog_probe()

Chris Wulff (2):
      usb: gadget: u_audio: Fix race condition use of controls after free during gadget unbind.
      usb: gadget: u_audio: Clear uac pointer when freed.

Christoph Hellwig (2):
      sd: also set max_user_sectors when setting max_sectors
      block: stack max_user_sectors

Christophe JAILLET (3):
      VMCI: Fix an error handling path in vmci_guest_probe_device()
      i2c: synquacer: Fix an error handling path in synquacer_i2c_probe()
      KVM: PPC: Book3S HV nestedv2: Fix an error handling path in gs_msg_ops_kvmhv_nestedv2_config_fill_info()

Christophe Leroy (1):
      powerpc/bpf/32: Fix failing test_bpf tests

Chuck Lever (1):
      SUNRPC: Fix loop termination condition in gss_free_in_token_pages()

Dae R. Jeong (1):
      tls: fix missing memory barrier in tls_init

Daeho Jeong (1):
      f2fs: write missing last sum blk of file pinning section

Damien Le Moal (1):
      null_blk: Fix return value of nullb_device_power_store()

Dan Aloni (2):
      sunrpc: fix NFSACL RPC retry on soft mount
      rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL

Dan Carpenter (3):
      stm class: Fix a double free in stm_register_device()
      backlight: mp3309c: Fix signedness bug in mp3309c_parse_fwnode()
      media: stk1160: fix bounds checking in stk1160_copy_video()

Daniel Borkmann (2):
      netkit: Fix setting mac address in l2 mode
      netkit: Fix pkt_type override upon netkit pass verdict

Danila Tikhonov (1):
      pinctrl: qcom: pinctrl-sm7150: Fix sdc1 and ufs special pins regs

David E. Box (3):
      tools/arch/x86/intel_sdsi: Fix maximum meter bundle length
      tools/arch/x86/intel_sdsi: Fix meter_show display
      tools/arch/x86/intel_sdsi: Fix meter_certificate decoding

David Howells (3):
      netfs: Fix setting of BDP_ASYNC from iocb flags
      cifs: Set zero_point in the copy_file_range() and remap_file_range()
      cifs: Fix missing set of remote_i_size

David Stevens (1):
      virtio_balloon: Give the balloon its own wakeup source

Devyn Liu (1):
      gpiolib: acpi: Fix failed in acpi_gpiochip_find() by adding parent node match

Dmitry Baryshkov (6):
      usb: typec: ucsi: allow non-partner GET_PDOS for Qualcomm devices
      usb: typec: ucsi: always register a link to USB PD device
      usb: typec: ucsi: simplify partner's PD caps registration
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: fix x1e80100-gen3x2 schema
      dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: fix msm899[68] power-domains
      dt-bindings: phy: qcom,usb-snps-femto-v2: use correct fallback for sc8180x

Dongli Zhang (1):
      genirq/cpuhotplug, x86/vector: Prevent vector leak during CPU offline

Dongliang Mu (1):
      media: flexcop-usb: fix sanity check of bNumEndpoints

Duoming Zhou (3):
      PCI: of_property: Return error for int_map allocation failure
      watchdog: cpu5wdt.c: Fix use-after-free bug caused by cpu5wdt_trigger
      um: Fix return value in ubd_init()

Eric Dumazet (4):
      netfilter: nfnetlink_queue: acquire rcu_read_lock() in instance_destroy_rcu()
      ipv6: introduce dst_rt6_info() helper
      inet: introduce dst_rtable() helper
      net: fix __dst_negative_advice() race

Eric Garver (1):
      netfilter: nft_fib: allow from forward/input without iif selector

Ethan Adams (1):
      perf build: Fix out of tree build related to installation of sysreg-defs

Eugen Hristev (1):
      media: mediatek: vcodec: fix possible unbalanced PM counter

Fabio Estevam (3):
      media: ov2680: Clear the 'ret' variable on success
      media: ov2680: Allow probing if link-frequencies is absent
      media: ov2680: Do not fail if data-lanes property is absent

Fedor Pchelkin (3):
      dma-mapping: benchmark: fix up kthread-related error handling
      dma-mapping: benchmark: fix node id validation
      dma-mapping: benchmark: handle NUMA_NO_NODE correctly

Fenghua Yu (1):
      dmaengine: idxd: Avoid unnecessary destruction of file_ida

Fenglin Wu (1):
      Input: pm8xxx-vibrator - correct VIB_MAX_LEVELS calculation

Florian Fainelli (1):
      net: Always descend into dsa/ folder with CONFIG_NET_DSA enabled

Florian Westphal (1):
      netfilter: tproxy: bail out if IP has been disabled on the device

Frank Li (1):
      i3c: master: svc: change ENXIO to EAGAIN when IBI occurs during start frame

Friedrich Vock (1):
      bpf: Fix potential integer overflow in resolve_btfids

Gal Pressman (2):
      net/mlx5: Fix MTMP register capability offset in MCAM register
      net/mlx5e: Fix UDP GSO for encapsulated packets

Geert Uytterhoeven (3):
      dt-bindings: PCI: rcar-pci-host: Add missing IOMMU properties
      pinctrl: renesas: r8a779h0: Fix IRQ suffixes
      Revert "drm: Make drivers depends on DRM_DW_HDMI"

Geliang Tang (1):
      selftests: mptcp: add ms units for tc-netem delay

Gerald Loacker (3):
      drm/panel: sitronix-st7789v: fix timing for jt240mhqs_hwt_ek_e3 panel
      drm/panel: sitronix-st7789v: tweak timing for jt240mhqs_hwt_ek_e3 panel
      drm/panel: sitronix-st7789v: fix display size for jt240mhqs_hwt_ek_e3 panel

Gerd Hoffmann (1):
      KVM: x86: Don't advertise guest.MAXPHYADDR as host.MAXPHYADDR in CPUID

Greg Kroah-Hartman (1):
      Linux 6.9.4

Guenter Roeck (1):
      hwmon: (shtc1) Fix property misspelling

Hagar Hemdan (1):
      efi: libstub: only free priv.runtime_map when allocated

Hangbin Liu (2):
      ipv6: sr: fix memleak in seg6_hmac_init_algo
      selftests/net: use tc rule to filter the na packet

Hannah Peuckmann (2):
      riscv: dts: starfive: visionfive 2: Remove non-existing TDM hardware
      riscv: dts: starfive: visionfive 2: Remove non-existing I2S hardware

Hans Verkuil (4):
      media: cec: cec-adap: always cancel work in cec_transmit_msg_fh
      media: cec: cec-api: add locking in cec_release()
      media: cec: core: avoid recursive cec_claim_log_addrs
      media: cec: core: avoid confusing "transmit timed out" message

Hans de Goede (1):
      platform/x86: thinkpad_acpi: Take hotkey_mutex during hotkey_exit()

Harald Freudenberger (1):
      s390/ap: Fix bind complete udev event sent after each AP bus scan

Hariprasad Kelam (1):
      Octeontx2-pf: Free send queue buffers incase of leaf to inner

He Zhe (1):
      perf bench internals inject-build-id: Fix trap divide when collecting just one DSO

Heiko Carstens (6):
      s390/vdso: Use standard stack frame layout
      s390/stacktrace: Merge perf_callchain_user() and arch_stack_walk_user()
      s390/stacktrace: Skip first user stack frame
      s390/stacktrace: Improve detection of invalid instruction pointers
      s390/vdso: Introduce and use struct stack_frame_vdso_wrapper
      s390/stackstrace: Detect vdso stack frames

Henry Wang (1):
      drivers/xen: Improve the late XenStore init protocol

Himal Prasad Ghimiray (1):
      drm/xe: Change pcode timeout to 50msec while polling again

Horatiu Vultur (2):
      net: lan966x: Remove ptp traps in case the ptp is not enabled.
      net: micrel: Fix lan8841_config_intr after getting out of sleep mode

Hou Tao (2):
      fuse: set FR_PENDING atomically in fuse_resend()
      fuse: clear FR_SENT when re-adding requests into pending list

Hsin-Te Yuan (1):
      ASoC: mediatek: mt8192: fix register configuration for tdm

Huacai Chen (1):
      LoongArch: Fix callchain parse error with kernel tracepoint events again

Huai-Yuan Liu (1):
      ppdev: Add an error check in register_device

Hugo Villeneuve (1):
      serial: sc16is7xx: add proper sched.h include for sched_set_fifo()

Ian Rogers (15):
      perf record: Delete session after stopping sideband thread
      perf test: Use a single fd for the child process out/err
      perf bench uprobe: Remove lib64 from libc.so.6 binary path
      perf docs: Document bpf event modifier
      perf ui browser: Don't save pointer to stack memory
      perf annotate: Fix memory leak in annotated_source
      perf ui browser: Avoid SEGV on title
      perf report: Avoid SEGV in report__setup_sample_type()
      perf thread: Fixes to thread__new() related to initializing comm
      libsubcmd: Fix parse-options memory leak
      perf stat: Don't display metric header for non-leader uncore events
      perf tools: Use pmus to describe type from attribute
      perf tools: Add/use PMU reverse lookup from config to name
      perf pmu: Assume sysfs events are always the same case
      perf pmu: Count sys and cpuid JSON events separately

Ido Schimmel (1):
      ipv4: Fix address dump when IPv4 is disabled on an interface

Ilpo Järvinen (1):
      PCI: Wait for Link Training==0 before starting Link retrain

Iulia Tanasescu (1):
      Bluetooth: ISO: Handle PA sync when no BIGInfo reports are generated

Ivan Orlov (1):
      string_kunit: Add test cases for str*cmp functions

Jacob Keller (2):
      Revert "ixgbe: Manual AN-37 for troublesome link partners for X550 SFI"
      ice: fix accounting if a VLAN already exists

Jai Luthra (1):
      media: ti: j721e-csi2rx: Fix races while restarting DMA

Jakub Sitnicki (1):
      bpf: Allow delete from sockmap/sockhash only if update is allowed

James Clark (8):
      perf tests: Make "test data symbol" more robust on Neoverse N1
      perf tests: Apply attributes to all events in object code reading test
      perf map: Remove kernel map before updating start and end addresses
      perf test shell arm_coresight: Increase buffer size for Coresight basic tests
      perf dwarf-aux: Fix build with HAVE_DWARF_CFI_SUPPORT
      perf symbols: Remove map from list before updating addresses
      perf symbols: Update kcore map before merging in remaining symbols
      perf symbols: Fix ownership of string in dso__load_vmlinux()

Jason-JH.Lin (1):
      mailbox: mtk-cmdq: Fix pm_runtime_get_sync() warning in mbox shutdown

Jens Remus (2):
      s390/vdso: Generate unwind information for C modules
      s390/vdso: Create .build-id links for unstripped vdso files

Jiangfeng Xiao (1):
      arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY

Jiri Pirko (1):
      virtio: delete vq in vp_find_vqs_msix() when request_irq() fails

Johannes Berg (1):
      um: vector: fix bpfflash parameter evaluation

Jonathan Cameron (1):
      iio: adc: stm32: Fixing err code to not indicate success

Joseph Qi (1):
      ocfs2: correctly use ocfs2_find_next_zero_bit()

Judith Mendez (5):
      mmc: sdhci_am654: Add tuning algorithm for delay chain
      mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
      mmc: sdhci_am654: Add OTAP/ITAP delay enable
      mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
      mmc: sdhci_am654: Fix ITAPDLY for HS400 timing

Karel Balej (1):
      Input: ioc3kbd - add device table

Kees Cook (3):
      string: Prepare to merge strscpy_kunit.c into string_kunit.c
      string: Prepare to merge strcat KUnit tests into string_kunit.c
      ubsan: Restore dependency on ARCH_HAS_UBSAN

Keith Busch (2):
      nvme: fix multipath batched completion accounting
      nvme-multipath: fix io accounting on failover

Konrad Dybcio (2):
      interconnect: qcom: qcm2290: Fix mas_snoc_bimc QoS port assignment
      drm/msm/a6xx: Avoid a nullptr dereference when speedbin setting fails

Konstantin Komarov (3):
      fs/ntfs3: Check 'folio' pointer for NULL
      fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
      fs/ntfs3: Use variable length array instead of fixed size

Krzysztof Kozlowski (1):
      dt-bindings: PCI: rockchip,rk3399-pcie: Add missing maxItems to ep-gpios

Kuniyuki Iwashima (4):
      af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
      tcp: Fix shift-out-of-bounds in dctcp_update_alpha().
      af_unix: Annotate data-race around unix_sk(sk)->addr.
      af_unix: Read sk->sk_hash under bindlock during bind().

Kuppuswamy Sathyanarayanan (2):
      PCI/EDR: Align EDR_PORT_DPC_ENABLE_DSM with PCI Firmware r3.3
      PCI/EDR: Align EDR_PORT_LOCATE_DSM with PCI Firmware r3.3

Larysa Zaremba (2):
      ice: Interpret .set_channels() input differently
      idpf: Interpret .set_channels() input differently

Le Ma (1):
      drm/amdgpu: init microcode chip name from ip versions

Li Zhijian (1):
      cxl/region: Fix cxlr_pmem leaks

Luca Ceresoli (1):
      Revert "drm/bridge: ti-sn65dsi83: Fix enable error path"

Luke D. Jones (1):
      ALSA: hda/realtek: Adjust G814JZR to use SPI init for amp

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix start counter for ft1 filter

Maher Sanalla (1):
      net/mlx5: Lag, do bond only if slaves agree on roce state

Manivannan Sadhasivam (1):
      PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host

Marco Pagani (3):
      fpga: manager: add owner module and take its refcount
      fpga: bridge: add owner module and take its refcount
      fpga: region: add owner module and take its refcount

Marek Szyprowski (1):
      Input: cyapa - add missing input core locking to suspend/resume functions

Marijn Suijten (3):
      drm/msm/dsi: Print dual-DSI-adjusted pclk instead of original mode pclk
      drm/msm/dpu: Always flush the slave INTF on the CTL
      drm/msm/dpu: Allow configuring multiple active DSC blocks

Mario Limonciello (1):
      drm/amd/display: Enable colorspace property for MST connectors

Marius Cristea (1):
      iio: adc: PAC1934: fix accessing out of bounds array index

Markus Elfring (1):
      spmi: pmic-arb: Replace three IS_ERR() calls by null pointer checks in spmi_pmic_arb_probe()

Martin Kaiser (1):
      nfs: keep server info for remounts

Masahiro Yamada (2):
      x86/kconfig: Select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y
      kconfig: fix comparison to constant symbols, 'm', 'n'

Mathieu Othacehe (1):
      net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ8061

Matthew Brost (1):
      drm/xe: Only use reserved BCS instances for usm migrate exec queue

Matthew Bystrin (1):
      riscv: stacktrace: fixed walk_stackframe()

Matthew R. Ochs (1):
      tpm_tis_spi: Account for SPI header when allocating TPM SPI xfer buffer

Matthew Wilcox (Oracle) (1):
      udf: Convert udf_expand_file_adinicb() to use a folio

Matthieu Baerts (NGI0) (4):
      selftests: net: lib: set 'i' as local
      selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky
      selftests: mptcp: join: mark 'fastclose' tests as flaky
      selftests: mptcp: join: mark 'fail' tests as flaky

Matti Vaittinen (4):
      watchdog: bd9576: Drop "always-running" property
      regulator: bd71828: Don't overwrite runtime voltages
      regulator: pickable ranges: don't always cache vsel
      regulator: tps6287x: Force writing VSEL bit

Maxime Ripard (1):
      drm: Make drivers depends on DRM_DW_HDMI

Michael Walle (1):
      drm/bridge: tc358775: fix support for jeida-18 and jeida-24

Michal Simek (2):
      microblaze: Remove gcc flag for non existing early_printk.c file
      microblaze: Remove early printk call from cpuinfo-static.c

Miguel Ojeda (1):
      kheaders: use `command -v` to test for existence of `cpio`

Miklos Szeredi (1):
      ovl: remove upper umask handling from ovl_create_upper()

Ming Lei (2):
      blk-cgroup: fix list corruption from resetting io stat
      blk-cgroup: fix list corruption from reorder of WRITE ->lqueued

Mohamed Ahmed (1):
      drm/nouveau: use tile_mode and pte_kind for VM_BIND bo allocations

Namhyung Kim (6):
      perf annotate: Get rid of duplicate --group option item
      perf annotate: Fix annotation_calc_lines() to pass correct address to get_srcline()
      perf dwarf-aux: Check pointer offset when checking variables
      perf dwarf-aux: Add die_collect_vars()
      perf annotate: Fix segfault on sample histogram
      perf/arm-dmc620: Fix lockdep assert in ->event_init()

Nathan Lynch (1):
      powerpc/pseries/lparcfg: drop error message from guest name lookup

Neha Malcom Francis (1):
      regulator: tps6594-regulator: Correct multi-phase configuration

Neil Armstrong (2):
      phy: qcom: qmp-combo: fix sm8650 voltage swing table
      drm/meson: gate px_clk when setting rate

Niklas Neronin (1):
      usb: xhci: check if 'requested segments' exceeds ERST capacity

Nuno Sa (1):
      iio: adc: adi-axi-adc: only error out in major version mismatch

Olga Kornievskaia (1):
      pNFS/filelayout: fixup pNfs allocation modes

Oliver Upton (1):
      KVM: arm64: Destroy mpidr_data for 'late' vCPU creation

Pablo Neira Ayuso (2):
      netfilter: nft_payload: restore vlan q-in-q match support
      netfilter: nft_payload: skbuff vlan metadata mangle support

Paolo Abeni (1):
      net: relax socket state check at accept time.

Parthiban Veerasooran (1):
      net: usb: smsc95xx: fix changing LED_SEL bit value updated from EEPROM

Paul Barker (1):
      pinctrl: renesas: rzg2l: Limit 2.5V power supply to Ethernet interfaces

Paul Greenwalt (1):
      ice: fix 200G PHY types to link speed mapping

Peter Colberg (1):
      hwmon: (intel-m10-bmc-hwmon) Fix multiplier for N6000 board power sensor

Peter Ujfalusi (1):
      ASoC: SOF: debug: Handle cases when fw_lib_prefix is not set, NULL

Petr Machata (4):
      selftests: forwarding: Change inappropriate log_test_skip() calls
      selftests: forwarding: Have RET track kselftest framework constants
      selftests: forwarding: Convert log_test() to recognize RET values
      selftests: net: Unify code of busywait() and slowwait()

Pierre-Louis Bossart (1):
      soundwire: cadence: fix invalid PDI offset

Rafał Miłecki (1):
      dt-bindings: pinctrl: mediatek: mt7622: fix array properties

Rahul Rameshbabu (2):
      net/mlx5: Use mlx5_ipsec_rx_status_destroy to correctly delete status rules
      net/mlx5e: Fix IPsec tunnel mode offload feature check

Ramona Gradinariu (1):
      docs: iio: adis16475: fix device files tables

Randy Dunlap (3):
      counter: linux/counter.h: fix Excess kernel-doc description warning
      extcon: max8997: select IRQ_DOMAIN instead of depending on it
      media: sunxi: a83-mips-csi2: also select GENERIC_PHY

Riana Tauro (1):
      drm/xe: check pcode init status only on root gt of root tile

Richard Fitzgerald (3):
      ALSA: hda/cs_dsp_ctl: Use private_free for control cleanup
      ALSA: hda: hda_component: Initialize shared data during bind callback
      ALSA: hda: cs35l56: Fix lifetime of cs_dsp instance

Roberto Sassu (1):
      um: Add winch to winch_handlers before registering winch IRQ

Roded Zats (1):
      enic: Validate length of nl attributes in enic_set_vf_port

Rodrigo Vivi (1):
      drm/xe: Add dbg messages on the suspend resume functions.

Roger Pau Monne (1):
      xen/x86: add extra pages to unpopulated-alloc if available

Rui Miguel Silva (1):
      greybus: lights: check return of get_channel_from_mode

Ryosuke Yasuoka (2):
      nfc: nci: Fix uninit-value in nci_rx_work
      nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()

Sagi Grimberg (1):
      nvmet: fix ns enable/disable possible hang

Sai Pavan Boddu (1):
      i2c: cadence: Avoid fifo clear after start

Sakari Ailus (1):
      media: v4l: Don't turn on privacy LED if streamon fails

Samasth Norway Ananda (1):
      perf daemon: Fix file leak in daemon_session__control

Samuel Holland (1):
      riscv: Flush the instruction cache during SMP bringup

Sean Anderson (1):
      drm: zynqmp_dpsub: Always register bridge

Sergey Matyukevich (1):
      riscv: prevent pt_regs corruption for secondary idle threads

Shay Agroskin (1):
      net: ena: Fix redundant device NUMA node override

Shenghao Ding (3):
      ASoC: tas2781: Fix a warning reported by robot kernel test
      ASoC: tas2552: Add TX path for capturing AUDIO-OUT data
      ASoC: tas2781: Fix wrong loading calibrated data sequence

Shrikanth Hegde (1):
      powerpc/pseries: Add failure related checks for h_get_mpp and h_get_ppp

Srinivas Pandruvada (2):
      platform/x86/intel/tpmi: Handle error from tpmi_process_info()
      platform/x86/intel-uncore-freq: Don't present root domain on error

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix buffer size in gfx_v9_4_3_init_ cp_compute_microcode() and rlc_microcode()

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

Suzuki K Poulose (4):
      coresight: etm4x: Do not hardcode IOMEM access for register restore
      coresight: etm4x: Do not save/restore Data trace control registers
      coresight: etm4x: Safe access for TRCQCLTR
      coresight: etm4x: Fix access to resource selector registers

Sven Schnelle (2):
      s390/ftrace: Use unwinder instead of __builtin_return_address()
      s390/boot: Remove alt_stfle_fac_list from decompressor

Taehee Yoo (1):
      selftests: net: kill smcrouted in the cleanup logic in amt.sh

Takashi Iwai (6):
      ALSA: hda/realtek: Drop doubly quirk entry for 103c:8a2e
      ALSA: core: Remove debugfs at disconnection
      ALSA: seq: Fix missing bank setup between MIDI1/MIDI2 UMP conversion
      ALSA: seq: Don't clear bank selection at event -> UMP MIDI2 conversion
      ALSA: seq: Fix yet another spot for system message conversion
      ALSA: seq: ump: Fix swapped song position pointer data

Tao Su (2):
      Revert "selftests/harness: remove use of LINE_MAX"
      selftests/harness: use 1024 in place of LINE_MAX

Tariq Toukan (1):
      net/mlx5: Do not query MPIR on embedded CPU function

Tengfei Fan (1):
      dt-bindings: pinctrl: qcom: update functions to match with driver

Tetsuo Handa (1):
      dma-buf/sw-sync: don't enable IRQ from sync_print_obj()

Thomas Gleixner (2):
      x86/topology: Handle bogus ACPI tables correctly
      x86/topology/intel: Unlock CPUID before evaluating anything

Thomas Haemmerle (1):
      iio: pressure: dps310: support negative temperature values

Thomas Richter (2):
      perf report: Fix PAI counter names for s390 virtual machines
      perf stat: Do not fail on metrics on s390 z/VM systems

Tiwei Bie (3):
      um: Fix the -Wmissing-prototypes warning for __switch_mm
      um: Fix the -Wmissing-prototypes warning for get_thread_reg
      um: Fix the declaration of kasan_map_memory

Tristram Ha (1):
      net: dsa: microchip: fix RGMII error in KSZ DSA driver

Uros Bizjak (2):
      x86/percpu: Unify arch_raw_cpu_ptr() defines
      x86/percpu: Use __force to cast from __percpu address space

Uwe Kleine-König (3):
      leds: pwm: Disable PWM when going to suspend
      spi: stm32: Revert change that enabled controller before asserting CS
      spi: stm32: Don't warn about spurious interrupts

Vaibhav Jain (1):
      KVM: PPC: Book3S HV nestedv2: Cancel pending DEC exception

Vidya Sagar (1):
      PCI: tegra194: Fix probe path for Endpoint mode

Vijendar Mukunda (1):
      ASoC: amd: acp: fix for acp platform device creation failure

Vladimir Oltean (2):
      net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()
      net/sched: taprio: extend minimum interval restriction to entire cycle too

Waiman Long (1):
      blk-cgroup: Properly propagate the iostat update up the hierarchy

Wei Fang (1):
      net: fec: avoid lock evasion when reading pps_enable

Wojciech Macek (1):
      drm/mediatek: dp: Fix mtk_dp_aux_transfer return value

Wolfram Sang (1):
      serial: sh-sci: protect invalidating RXDMA on shutdown

Wu Bo (1):
      f2fs: fix block migration when section is not aligned to pow2

Xianwei Zhao (1):
      arm64: dts: meson: fix S4 power-controller node

Xiaolei Wang (1):
      net:fec: Add fec_enet_deinit()

Yang Jihong (1):
      perf sched timehist: Fix -g/--call-graph option failure

Yang Li (1):
      rv: Update rv_en(dis)able_monitor doc to match kernel-doc

Ye Bin (1):
      vfio/pci: fix potential memory leak in vfio_intx_enable()

Yoann Congal (1):
      printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled

Yu Kuai (1):
      null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'

Yue Haibing (1):
      ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound

Zan Dobersek (1):
      drm/msm/adreno: fix CP cycles stat retrieval on a7xx

Zhu Yanjun (1):
      null_blk: Fix the WARNING: modpost: missing MODULE_DESCRIPTION()


