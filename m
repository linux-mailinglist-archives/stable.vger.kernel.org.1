Return-Path: <stable+bounces-210341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27158D3A88A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 13:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B16330210EF
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F42512E6;
	Mon, 19 Jan 2026 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vdAZGjQH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64871F5437;
	Mon, 19 Jan 2026 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825184; cv=none; b=b2AVb/N452lrQWJC149AWu+wZu6LLA8eCSL9Qge/WBjekNp0EFohM3DtWYV2LARLzSacu1kyU+fHwCstaMSnruRgoJuQMF2T4zUEgf6qaeNHeMz1bUzetz1OGXrtGbe7h4YpKSi/CxZkl3vMZvswClB14OY0MvUBVdPKDn1F3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825184; c=relaxed/simple;
	bh=oFnZFjyptJsfmGIt0Befew8v1/S8/p94U+EJkVqracY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rpyGgx0q3jr5PkX6JQVgEVcSsjI5VsB3UMQ7dNO1TCTFe4JVj7H/8ew+yj5cwgx/58lTcMpp8RSb5Ys7GumpsDUGUmh9U0RnXOhL+onGMcNbzJJdNyjd2DY/QQsqbXTBVcMJxc0TE2TXr5FDfj/o+ddmk7QMY8ipvAmwmehgjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vdAZGjQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6A8C19424;
	Mon, 19 Jan 2026 12:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768825184;
	bh=oFnZFjyptJsfmGIt0Befew8v1/S8/p94U+EJkVqracY=;
	h=From:To:Cc:Subject:Date:From;
	b=vdAZGjQH1NlzKxQsgWregB57cRPIh9we3sQPMTiuCrvabmlDb847bdM8cFjgNoSs5
	 ZBF7E5eRRIWExObFLw7sWfa7r4Cx5Qk6WhSS99nUZtFlhTfroU52L9WGKhVSqTHfZ5
	 on7CQSKxx/y1B9AQiG2yK2T0OQUYxIf14u93wHGU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.198
Date: Mon, 19 Jan 2026 13:19:39 +0100
Message-ID: <2026011939-angelic-slimy-b849@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.198 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml              |  134 ++++
 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt             |   70 --
 Documentation/filesystems/mount_api.rst                                  |    1 
 Documentation/process/2.Process.rst                                      |    6 
 Makefile                                                                 |    2 
 arch/alpha/include/uapi/asm/ioctls.h                                     |    8 
 arch/arm/Kconfig                                                         |    2 
 arch/arm/boot/dts/imx6q-ba16.dtsi                                        |    2 
 arch/arm/boot/dts/sama7g5.dtsi                                           |    4 
 arch/arm/include/asm/word-at-a-time.h                                    |   10 
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi                  |   11 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                             |    1 
 arch/arm64/kvm/Makefile                                                  |    3 
 arch/arm64/net/bpf_jit_comp.c                                            |    2 
 arch/csky/mm/fault.c                                                     |    4 
 arch/parisc/kernel/asm-offsets.c                                         |    2 
 arch/parisc/kernel/entry.S                                               |   16 
 arch/powerpc/boot/addnote.c                                              |    7 
 arch/powerpc/include/asm/book3s/64/mmu-hash.h                            |    1 
 arch/powerpc/kernel/entry_32.S                                           |   10 
 arch/powerpc/kernel/process.c                                            |    5 
 arch/powerpc/mm/book3s64/internal.h                                      |    1 
 arch/powerpc/mm/book3s64/mmu_context.c                                   |    2 
 arch/powerpc/mm/book3s64/slb.c                                           |   88 --
 arch/powerpc/mm/ptdump/hashpagetable.c                                   |    6 
 arch/powerpc/platforms/pseries/cmm.c                                     |    5 
 arch/s390/kernel/smp.c                                                   |    1 
 arch/x86/crypto/blake2s-core.S                                           |    4 
 arch/x86/events/core.c                                                   |    2 
 arch/x86/events/intel/core.c                                             |    4 
 arch/x86/include/asm/ptrace.h                                            |   20 
 arch/x86/include/asm/uaccess.h                                           |   10 
 arch/x86/kernel/dumpstack.c                                              |   35 -
 arch/x86/kernel/stacktrace.c                                             |    2 
 arch/x86/kernel/unwind_frame.c                                           |   11 
 arch/x86/kvm/lapic.c                                                     |   32 -
 arch/x86/kvm/svm/nested.c                                                |    5 
 arch/x86/kvm/svm/svm.c                                                   |   20 
 arch/x86/kvm/svm/svm.h                                                   |    7 
 arch/x86/kvm/vmx/nested.c                                                |    2 
 arch/x86/kvm/vmx/vmx.c                                                   |    2 
 arch/x86/kvm/vmx/vmx.h                                                   |    1 
 arch/x86/kvm/x86.c                                                       |    2 
 arch/x86/lib/usercopy.c                                                  |    2 
 block/blk-mq.c                                                           |   18 
 block/blk-throttle.c                                                     |   16 
 block/genhd.c                                                            |    2 
 crypto/af_alg.c                                                          |    5 
 crypto/algif_hash.c                                                      |    3 
 crypto/algif_rng.c                                                       |    3 
 crypto/asymmetric_keys/asymmetric_type.c                                 |   14 
 crypto/seqiv.c                                                           |    8 
 drivers/acpi/acpica/nswalk.c                                             |    9 
 drivers/acpi/apei/ghes.c                                                 |   16 
 drivers/acpi/cppc_acpi.c                                                 |    3 
 drivers/acpi/processor_core.c                                            |    2 
 drivers/acpi/property.c                                                  |    9 
 drivers/amba/tegra-ahb.c                                                 |    1 
 drivers/atm/he.c                                                         |    3 
 drivers/base/power/runtime.c                                             |   22 
 drivers/block/floppy.c                                                   |    2 
 drivers/block/nbd.c                                                      |   92 +-
 drivers/block/ps3disk.c                                                  |    4 
 drivers/bluetooth/btusb.c                                                |   14 
 drivers/bus/ti-sysc.c                                                    |   11 
 drivers/char/applicom.c                                                  |    5 
 drivers/char/ipmi/ipmi_msghandler.c                                      |   20 
 drivers/char/tpm/tpm-chip.c                                              |    1 
 drivers/char/tpm/tpm1-cmd.c                                              |    5 
 drivers/char/tpm/tpm2-cmd.c                                              |    8 
 drivers/char/virtio_console.c                                            |    2 
 drivers/clk/mvebu/cp110-system-controller.c                              |   20 
 drivers/clk/renesas/r9a06g032-clocks.c                                   |    7 
 drivers/comedi/comedi_fops.c                                             |   42 +
 drivers/comedi/drivers/c6xdigio.c                                        |   46 +
 drivers/comedi/drivers/multiq3.c                                         |    9 
 drivers/comedi/drivers/pcl818.c                                          |    5 
 drivers/counter/interrupt-cnt.c                                          |    3 
 drivers/cpufreq/cpufreq-nforce2.c                                        |    3 
 drivers/cpufreq/s5pv210-cpufreq.c                                        |    6 
 drivers/crypto/ccree/cc_buffer_mgr.c                                     |    6 
 drivers/crypto/hisilicon/qm.c                                            |   14 
 drivers/firewire/nosy.c                                                  |   10 
 drivers/firmware/arm_scmi/notify.c                                       |    1 
 drivers/firmware/efi/cper-arm.c                                          |   52 -
 drivers/firmware/efi/cper.c                                              |   60 +
 drivers/firmware/imx/imx-scu-irq.c                                       |   26 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                       |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c                         |    2 
 drivers/gpu/drm/gma500/framebuffer.c                                     |   42 -
 drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c                     |    4 
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c                            |    2 
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c                                |   23 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                              |    2 
 drivers/gpu/drm/nouveau/dispnv50/atom.h                                  |   13 
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                                  |    2 
 drivers/gpu/drm/panel/panel-visionox-rm69299.c                           |    2 
 drivers/gpu/drm/pl111/pl111_drv.c                                        |    2 
 drivers/gpu/drm/ttm/ttm_bo_vm.c                                          |    6 
 drivers/gpu/drm/vgem/vgem_fence.c                                        |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                                  |   17 
 drivers/gpu/host1x/syncpt.c                                              |    4 
 drivers/hid/hid-core.c                                                   |    7 
 drivers/hid/hid-elecom.c                                                 |    6 
 drivers/hid/hid-ids.h                                                    |    3 
 drivers/hid/hid-input.c                                                  |   18 
 drivers/hid/hid-logitech-dj.c                                            |   56 -
 drivers/hid/hid-quirks.c                                                 |   12 
 drivers/hwmon/max16065.c                                                 |    7 
 drivers/hwmon/w83791d.c                                                  |   17 
 drivers/hwmon/w83l786ng.c                                                |   26 
 drivers/hwtracing/coresight/coresight-core.c                             |   20 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                       |  270 ++++++--
 drivers/hwtracing/coresight/coresight-etm4x.h                            |    9 
 drivers/hwtracing/coresight/coresight-self-hosted-trace.h                |   31 +
 drivers/hwtracing/intel_th/core.c                                        |   20 
 drivers/i2c/busses/i2c-amd-mp2-pci.c                                     |    5 
 drivers/i3c/master.c                                                     |    8 
 drivers/i3c/master/svc-i3c-master.c                                      |   22 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                                  |   24 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c                           |   71 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c                             |   32 -
 drivers/infiniband/core/addr.c                                           |   33 -
 drivers/infiniband/core/cma.c                                            |    3 
 drivers/infiniband/core/device.c                                         |    5 
 drivers/infiniband/core/verbs.c                                          |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                 |    7 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                               |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                |    8 
 drivers/infiniband/hw/efa/efa_verbs.c                                    |    4 
 drivers/infiniband/hw/irdma/ctrl.c                                       |    3 
 drivers/infiniband/hw/irdma/pble.c                                       |    6 
 drivers/infiniband/hw/irdma/utils.c                                      |    3 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                   |    1 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                   |    2 
 drivers/input/serio/i8042-acpipnpio.h                                    |    7 
 drivers/input/touchscreen/ti_am335x_tsc.c                                |    2 
 drivers/iommu/amd/init.c                                                 |   28 
 drivers/iommu/apple-dart.c                                               |    2 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                               |   27 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                  |   10 
 drivers/iommu/exynos-iommu.c                                             |    9 
 drivers/iommu/ipmmu-vmsa.c                                               |    2 
 drivers/iommu/mtk_iommu.c                                                |    2 
 drivers/iommu/mtk_iommu_v1.c                                             |    2 
 drivers/iommu/omap-iommu.c                                               |    2 
 drivers/iommu/omap-iommu.h                                               |    2 
 drivers/iommu/sun50i-iommu.c                                             |    2 
 drivers/iommu/tegra-smmu.c                                               |    5 
 drivers/irqchip/qcom-irq-combiner.c                                      |    2 
 drivers/leds/flash/leds-aat1290.c                                        |    2 
 drivers/leds/led-class.c                                                 |    2 
 drivers/leds/leds-lp50xx.c                                               |   12 
 drivers/leds/leds-netxbig.c                                              |   36 -
 drivers/leds/leds-spi-byte.c                                             |   11 
 drivers/macintosh/mac_hid.c                                              |    3 
 drivers/md/dm-ebs-target.c                                               |    2 
 drivers/md/dm-log-writes.c                                               |    1 
 drivers/md/dm-raid.c                                                     |    2 
 drivers/media/cec/core/cec-core.c                                        |    1 
 drivers/media/i2c/adv7604.c                                              |    4 
 drivers/media/i2c/adv7842.c                                              |   11 
 drivers/media/i2c/msp3400-kthreads.c                                     |    2 
 drivers/media/i2c/tda1997x.c                                             |    1 
 drivers/media/platform/davinci/vpif_capture.c                            |    4 
 drivers/media/platform/exynos4-is/media-dev.c                            |   10 
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c                    |    4 
 drivers/media/platform/rcar_drif.c                                       |    1 
 drivers/media/rc/st_rc.c                                                 |    2 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                         |    3 
 drivers/media/usb/dvb-usb/dtv5100.c                                      |    5 
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c                                  |    2 
 drivers/mfd/altera-sysmgr.c                                              |    2 
 drivers/mfd/da9055-core.c                                                |    1 
 drivers/mfd/max77620.c                                                   |   15 
 drivers/mfd/mt6358-irq.c                                                 |    1 
 drivers/mfd/mt6397-irq.c                                                 |    1 
 drivers/misc/mei/hw-me-regs.h                                            |    2 
 drivers/misc/mei/pci-me.c                                                |    2 
 drivers/misc/vmw_balloon.c                                               |    3 
 drivers/mmc/core/bus.c                                                   |    9 
 drivers/mmc/core/bus.h                                                   |    3 
 drivers/mmc/core/mmc.c                                                   |   16 
 drivers/mmc/core/sd.c                                                    |   25 
 drivers/mmc/core/sdio.c                                                  |    5 
 drivers/mmc/core/sdio_bus.c                                              |    7 
 drivers/mmc/host/Kconfig                                                 |    4 
 drivers/mmc/host/sdhci-msm.c                                             |   27 
 drivers/mtd/lpddr/lpddr_cmds.c                                           |    8 
 drivers/net/dsa/b53/b53_common.c                                         |    3 
 drivers/net/ethernet/3com/3c59x.c                                        |    2 
 drivers/net/ethernet/broadcom/b44.c                                      |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                |   87 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c                         |    5 
 drivers/net/ethernet/freescale/enetc/enetc.h                             |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c               |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                  |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c                   |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c                |    4 
 drivers/net/ethernet/intel/e1000/e1000_main.c                            |   10 
 drivers/net/ethernet/intel/i40e/i40e.h                                   |   15 
 drivers/net/ethernet/intel/i40e/i40e_client.c                            |   20 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                           |   12 
 drivers/net/ethernet/intel/i40e/i40e_main.c                              |   15 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                              |   10 
 drivers/net/ethernet/intel/i40e/i40e_txrx.h                              |    2 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                       |    4 
 drivers/net/ethernet/intel/iavf/iavf_main.c                              |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c                |    8 
 drivers/net/ethernet/marvell/prestera/prestera_devlink.c                 |    2 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c                 |  122 +++
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h                 |    2 
 drivers/net/ethernet/mellanox/mlx5/core/port.c                           |    3 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c                        |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c                    |   17 
 drivers/net/ethernet/mscc/ocelot.c                                       |    6 
 drivers/net/ethernet/realtek/r8169_main.c                                |    5 
 drivers/net/ethernet/smsc/smc91x.c                                       |   10 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                        |    2 
 drivers/net/fjes/fjes_hw.c                                               |   12 
 drivers/net/ipvlan/ipvlan_core.c                                         |    3 
 drivers/net/mdio/mdio-aspeed.c                                           |   77 +-
 drivers/net/phy/mscc/mscc_main.c                                         |    6 
 drivers/net/team/team.c                                                  |    2 
 drivers/net/usb/asix_common.c                                            |    5 
 drivers/net/usb/pegasus.c                                                |    2 
 drivers/net/usb/rtl8150.c                                                |    2 
 drivers/net/usb/sr9700.c                                                 |    4 
 drivers/net/wireless/mediatek/mt76/eeprom.c                              |   37 -
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                          |    4 
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c                       |    9 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c                       |   27 
 drivers/net/wireless/st/cw1200/bh.c                                      |    6 
 drivers/nfc/pn533/usb.c                                                  |    2 
 drivers/nvme/host/fc.c                                                   |    6 
 drivers/parisc/gsc.c                                                     |    4 
 drivers/pci/controller/dwc/pci-keystone.c                                |    2 
 drivers/pci/controller/dwc/pcie-designware.h                             |    2 
 drivers/pci/controller/pcie-brcmstb.c                                    |   10 
 drivers/pci/pci-driver.c                                                 |    4 
 drivers/phy/broadcom/phy-bcm63xx-usbh.c                                  |    6 
 drivers/pinctrl/pinctrl-single.c                                         |   25 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                                 |    3 
 drivers/pinctrl/qcom/pinctrl-msm.c                                       |    2 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                    |    2 
 drivers/platform/chrome/cros_ec_ishtp.c                                  |    1 
 drivers/platform/x86/acer-wmi.c                                          |    4 
 drivers/platform/x86/asus-wmi.c                                          |    8 
 drivers/platform/x86/huawei-wmi.c                                        |    4 
 drivers/platform/x86/ibm_rtl.c                                           |    2 
 drivers/platform/x86/intel/hid.c                                         |   12 
 drivers/platform/x86/msi-laptop.c                                        |    3 
 drivers/power/supply/apm_power.c                                         |    3 
 drivers/power/supply/wm831x_power.c                                      |   10 
 drivers/powercap/powercap_sys.c                                          |   22 
 drivers/pwm/pwm-bcm2835.c                                                |   28 
 drivers/pwm/pwm-stm32.c                                                  |    3 
 drivers/regulator/core.c                                                 |   37 -
 drivers/remoteproc/qcom_q6v5_wcss.c                                      |    8 
 drivers/rpmsg/qcom_glink_native.c                                        |    8 
 drivers/s390/crypto/ap_bus.c                                             |    8 
 drivers/scsi/aic94xx/aic94xx_init.c                                      |    3 
 drivers/scsi/ipr.c                                                       |   28 
 drivers/scsi/libsas/sas_internal.h                                       |   14 
 drivers/scsi/qla2xxx/qla_def.h                                           |    1 
 drivers/scsi/qla2xxx/qla_gbl.h                                           |    2 
 drivers/scsi/qla2xxx/qla_isr.c                                           |   32 -
 drivers/scsi/qla2xxx/qla_mbx.c                                           |    2 
 drivers/scsi/qla2xxx/qla_mid.c                                           |    4 
 drivers/scsi/qla2xxx/qla_os.c                                            |   14 
 drivers/scsi/sg.c                                                        |   20 
 drivers/scsi/sim710.c                                                    |    2 
 drivers/scsi/stex.c                                                      |    1 
 drivers/soc/amlogic/meson-canvas.c                                       |    5 
 drivers/soc/qcom/ocmem.c                                                 |    2 
 drivers/spi/spi-fsl-spi.c                                                |    2 
 drivers/spi/spi-imx.c                                                    |   15 
 drivers/spi/spi-tegra210-quad.c                                          |  307 +++++++++-
 drivers/spi/spi-xilinx.c                                                 |    2 
 drivers/staging/fbtft/fbtft-core.c                                       |    4 
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c                        |   15 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                            |   13 
 drivers/target/target_core_configfs.c                                    |    1 
 drivers/target/target_core_transport.c                                   |    1 
 drivers/tty/serial/8250/8250_pci.c                                       |   37 +
 drivers/tty/serial/sprd_serial.c                                         |    6 
 drivers/uio/uio_fsl_elbc_gpcm.c                                          |    7 
 drivers/usb/core/message.c                                               |    2 
 drivers/usb/dwc2/platform.c                                              |   16 
 drivers/usb/dwc3/dwc3-of-simple.c                                        |    7 
 drivers/usb/dwc3/gadget.c                                                |    2 
 drivers/usb/dwc3/host.c                                                  |    2 
 drivers/usb/gadget/legacy/raw_gadget.c                                   |    3 
 drivers/usb/gadget/udc/core.c                                            |   17 
 drivers/usb/gadget/udc/lpc32xx_udc.c                                     |   20 
 drivers/usb/gadget/udc/tegra-xudc.c                                      |    6 
 drivers/usb/host/ohci-nxp.c                                              |   20 
 drivers/usb/host/xhci-dbgcap.h                                           |    1 
 drivers/usb/host/xhci-dbgtty.c                                           |   52 +
 drivers/usb/host/xhci-hub.c                                              |    2 
 drivers/usb/host/xhci-mem.c                                              |   10 
 drivers/usb/host/xhci-ring.c                                             |    8 
 drivers/usb/host/xhci.h                                                  |   16 
 drivers/usb/misc/chaoskey.c                                              |   16 
 drivers/usb/phy/phy-isp1301.c                                            |    7 
 drivers/usb/phy/phy.c                                                    |    4 
 drivers/usb/renesas_usbhs/pipe.c                                         |    2 
 drivers/usb/serial/belkin_sa.c                                           |   28 
 drivers/usb/serial/ftdi_sio.c                                            |   72 --
 drivers/usb/serial/kobil_sct.c                                           |   18 
 drivers/usb/serial/option.c                                              |   22 
 drivers/usb/storage/unusual_uas.h                                        |    2 
 drivers/usb/typec/ucsi/ucsi.c                                            |    6 
 drivers/usb/usbip/vhci_hcd.c                                             |    6 
 drivers/vdpa/vdpa.c                                                      |  231 +++++++
 drivers/vhost/vdpa.c                                                     |   10 
 drivers/vhost/vsock.c                                                    |   15 
 drivers/video/backlight/led_bl.c                                         |   18 
 drivers/video/fbdev/gbefb.c                                              |    5 
 drivers/video/fbdev/pxafb.c                                              |   12 
 drivers/video/fbdev/ssd1307fb.c                                          |    4 
 drivers/video/fbdev/tcx.c                                                |    2 
 drivers/virtio/virtio_balloon.c                                          |    4 
 drivers/virtio/virtio_vdpa.c                                             |    6 
 drivers/watchdog/via_wdt.c                                               |    1 
 drivers/watchdog/wdat_wdt.c                                              |   65 +-
 fs/bfs/inode.c                                                           |   19 
 fs/btrfs/ioctl.c                                                         |    4 
 fs/btrfs/scrub.c                                                         |    5 
 fs/btrfs/volumes.c                                                       |    1 
 fs/exfat/super.c                                                         |   19 
 fs/ext4/ext4.h                                                           |    1 
 fs/ext4/ialloc.c                                                         |    1 
 fs/ext4/inline.c                                                         |   14 
 fs/ext4/inode.c                                                          |    6 
 fs/ext4/mballoc.c                                                        |   58 +
 fs/ext4/move_extent.c                                                    |   18 
 fs/ext4/orphan.c                                                         |    4 
 fs/ext4/super.c                                                          |   65 +-
 fs/ext4/xattr.c                                                          |   38 -
 fs/ext4/xattr.h                                                          |   10 
 fs/f2fs/f2fs.h                                                           |    3 
 fs/f2fs/file.c                                                           |    3 
 fs/f2fs/namei.c                                                          |    6 
 fs/f2fs/recovery.c                                                       |    9 
 fs/f2fs/super.c                                                          |   53 +
 fs/f2fs/xattr.c                                                          |   32 -
 fs/f2fs/xattr.h                                                          |   10 
 fs/fuse/file.c                                                           |   26 
 fs/hfsplus/bnode.c                                                       |    4 
 fs/hfsplus/dir.c                                                         |    7 
 fs/hfsplus/inode.c                                                       |   32 -
 fs/jbd2/journal.c                                                        |   14 
 fs/jbd2/transaction.c                                                    |   21 
 fs/lockd/svc4proc.c                                                      |    4 
 fs/lockd/svclock.c                                                       |   21 
 fs/lockd/svcproc.c                                                       |    5 
 fs/locks.c                                                               |   13 
 fs/nfs/Kconfig                                                           |    1 
 fs/nfs/dir.c                                                             |  133 +++-
 fs/nfs/internal.h                                                        |    2 
 fs/nfs/namespace.c                                                       |   11 
 fs/nfs/nfs2xdr.c                                                         |   70 --
 fs/nfs/nfs3xdr.c                                                         |  108 ---
 fs/nfs/nfs4proc.c                                                        |   21 
 fs/nfs/nfs4trace.h                                                       |    1 
 fs/nfs/nfs4xdr.c                                                         |   44 +
 fs/nfs/pnfs.c                                                            |    1 
 fs/nfs/super.c                                                           |   26 
 fs/nfs_common/Makefile                                                   |    2 
 fs/nfs_common/common.c                                                   |   66 ++
 fs/nfsd/Kconfig                                                          |    1 
 fs/nfsd/blocklayout.c                                                    |    7 
 fs/nfsd/export.c                                                         |    2 
 fs/nfsd/netns.h                                                          |    2 
 fs/nfsd/nfs4proc.c                                                       |    2 
 fs/nfsd/nfs4state.c                                                      |   46 +
 fs/nfsd/nfs4xdr.c                                                        |    5 
 fs/nfsd/nfsctl.c                                                         |    3 
 fs/nfsd/nfsd.h                                                           |    1 
 fs/nfsd/state.h                                                          |    2 
 fs/nfsd/vfs.c                                                            |    2 
 fs/nls/nls_base.c                                                        |   27 
 fs/notify/fsnotify.c                                                     |    9 
 fs/ntfs3/frecord.c                                                       |   49 +
 fs/ntfs3/fsntfs.c                                                        |   18 
 fs/ntfs3/inode.c                                                         |    4 
 fs/ntfs3/namei.c                                                         |    2 
 fs/ntfs3/ntfs_fs.h                                                       |   12 
 fs/ntfs3/record.c                                                        |   22 
 fs/ntfs3/run.c                                                           |    6 
 fs/ntfs3/super.c                                                         |    2 
 fs/ocfs2/alloc.c                                                         |    1 
 fs/ocfs2/move_extents.c                                                  |    8 
 fs/ocfs2/suballoc.c                                                      |   10 
 fs/xfs/xfs_buf_item.c                                                    |    1 
 include/linux/balloon_compaction.h                                       |   65 --
 include/linux/blk_types.h                                                |    5 
 include/linux/compiler-clang.h                                           |   23 
 include/linux/compiler-gcc.h                                             |   14 
 include/linux/coresight.h                                                |    4 
 include/linux/cper.h                                                     |   12 
 include/linux/fs_context.h                                               |    1 
 include/linux/genalloc.h                                                 |    1 
 include/linux/ieee80211.h                                                |    4 
 include/linux/if_bridge.h                                                |    6 
 include/linux/netdevice.h                                                |    3 
 include/linux/nfs_common.h                                               |   16 
 include/linux/nfs_fs.h                                                   |    9 
 include/linux/nfs_fs_sb.h                                                |    2 
 include/linux/nfs_xdr.h                                                  |    2 
 include/linux/platform_data/lp855x.h                                     |    4 
 include/linux/rculist_nulls.h                                            |   59 +
 include/linux/security.h                                                 |    2 
 include/linux/tpm.h                                                      |    9 
 include/linux/usb/gadget.h                                               |    5 
 include/linux/vdpa.h                                                     |   22 
 include/linux/virtio_config.h                                            |    2 
 include/media/v4l2-mem2mem.h                                             |    3 
 include/net/netfilter/nf_conntrack_count.h                               |   16 
 include/net/sock.h                                                       |   13 
 include/net/xfrm.h                                                       |   13 
 include/sound/snd_wavefront.h                                            |    4 
 include/trace/misc/nfs.h                                                 |    3 
 include/uapi/linux/mptcp.h                                               |    1 
 include/uapi/linux/nfs.h                                                 |    1 
 include/uapi/linux/vdpa.h                                                |    6 
 include/uapi/sound/asound.h                                              |    2 
 io_uring/io_uring.c                                                      |    2 
 kernel/dma/pool.c                                                        |    2 
 kernel/livepatch/core.c                                                  |    8 
 kernel/locking/spinlock_debug.c                                          |    4 
 kernel/sched/cpudeadline.c                                               |   34 -
 kernel/sched/cpudeadline.h                                               |    4 
 kernel/sched/deadline.c                                                  |    8 
 kernel/scs.c                                                             |    2 
 kernel/trace/trace_events.c                                              |    2 
 lib/crypto/aes.c                                                         |    4 
 lib/idr.c                                                                |    2 
 lib/vsprintf.c                                                           |    6 
 mm/balloon_compaction.c                                                  |   15 
 mm/damon/core-test.h                                                     |   73 ++
 mm/damon/vaddr-test.h                                                    |   26 
 net/bridge/br_ioctl.c                                                    |   36 +
 net/bridge/br_private.h                                                  |    4 
 net/bridge/br_vlan_tunnel.c                                              |   11 
 net/caif/cffrml.c                                                        |    9 
 net/can/j1939/transport.c                                                |    2 
 net/ceph/messenger_v2.c                                                  |    2 
 net/ceph/mon_client.c                                                    |    2 
 net/ceph/osd_client.c                                                    |   11 
 net/ceph/osdmap.c                                                        |  140 ++--
 net/core/dev_ioctl.c                                                     |   15 
 net/core/page_pool.c                                                     |   16 
 net/core/sock.c                                                          |    7 
 net/ethtool/ioctl.c                                                      |  134 ++--
 net/hsr/hsr_forward.c                                                    |    2 
 net/ipv4/arp.c                                                           |    7 
 net/ipv4/fib_trie.c                                                      |    7 
 net/ipv4/inet_hashtables.c                                               |    8 
 net/ipv4/ip_output.c                                                     |    3 
 net/ipv4/ipcomp.c                                                        |    2 
 net/ipv4/ping.c                                                          |    4 
 net/ipv4/raw.c                                                           |    3 
 net/ipv6/calipso.c                                                       |    3 
 net/ipv6/ip6_gre.c                                                       |    9 
 net/ipv6/ip6_output.c                                                    |    3 
 net/ipv6/ipcomp6.c                                                       |    2 
 net/ipv6/xfrm6_tunnel.c                                                  |    2 
 net/key/af_key.c                                                         |    2 
 net/mac80211/rx.c                                                        |    5 
 net/mptcp/pm_netlink.c                                                   |    3 
 net/netfilter/ipvs/ip_vs_xmit.c                                          |    3 
 net/netfilter/nf_conncount.c                                             |  211 ++++--
 net/netfilter/nf_tables_api.c                                            |    3 
 net/netfilter/nft_connlimit.c                                            |   34 -
 net/netfilter/nft_flow_offload.c                                         |    9 
 net/netfilter/nft_synproxy.c                                             |    6 
 net/netfilter/xt_connlimit.c                                             |   14 
 net/netrom/nr_out.c                                                      |    4 
 net/nfc/core.c                                                           |    9 
 net/openvswitch/conntrack.c                                              |   16 
 net/openvswitch/flow_netlink.c                                           |   13 
 net/openvswitch/vport-netdev.c                                           |   17 
 net/rose/af_rose.c                                                       |    2 
 net/sched/sch_cake.c                                                     |   58 +
 net/sched/sch_ets.c                                                      |    6 
 net/sched/sch_qfq.c                                                      |    2 
 net/sctp/socket.c                                                        |    5 
 net/socket.c                                                             |   19 
 net/sunrpc/auth_gss/svcauth_gss.c                                        |    3 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                                        |    5 
 net/wireless/wext-core.c                                                 |    4 
 net/wireless/wext-priv.c                                                 |    4 
 net/xfrm/xfrm_ipcomp.c                                                   |    1 
 net/xfrm/xfrm_state.c                                                    |   41 -
 net/xfrm/xfrm_user.c                                                     |    2 
 scripts/Makefile.modinst                                                 |    2 
 security/integrity/ima/ima_policy.c                                      |    2 
 security/keys/trusted-keys/trusted_tpm2.c                                |    6 
 security/smack/smack_lsm.c                                               |   41 -
 sound/firewire/dice/dice-extension.c                                     |    4 
 sound/isa/wavefront/wavefront.c                                          |   61 +
 sound/isa/wavefront/wavefront_fx.c                                       |   36 -
 sound/isa/wavefront/wavefront_midi.c                                     |   17 
 sound/isa/wavefront/wavefront_synth.c                                    |  198 +++---
 sound/pcmcia/pdaudiocf/pdaudiocf.c                                       |    8 
 sound/pcmcia/vx/vxpocket.c                                               |    8 
 sound/soc/bcm/bcm63xx-pcm-whistler.c                                     |    4 
 sound/soc/codecs/ak4458.c                                                |   10 
 sound/soc/codecs/ak5558.c                                                |   10 
 sound/soc/fsl/fsl_sai.c                                                  |    3 
 sound/soc/fsl/fsl_xcvr.c                                                 |  199 ++++--
 sound/soc/fsl/fsl_xcvr.h                                                 |   28 
 sound/soc/intel/catpt/pcm.c                                              |    4 
 sound/soc/qcom/qdsp6/q6adm.c                                             |  146 ++--
 sound/soc/qcom/qdsp6/q6asm-dai.c                                         |    7 
 sound/soc/stm/stm32_i2s.c                                                |   62 --
 sound/soc/stm/stm32_sai.c                                                |   51 -
 sound/soc/stm/stm32_sai_sub.c                                            |   59 +
 sound/soc/stm/stm32_spdifrx.c                                            |   44 -
 sound/usb/mixer_us16x08.c                                                |   20 
 tools/perf/util/symbol.c                                                 |    4 
 tools/testing/ktest/config-bisect.pl                                     |    4 
 tools/testing/nvdimm/test/nfit.c                                         |    7 
 tools/testing/radix-tree/idr-test.c                                      |   21 
 tools/testing/selftests/bpf/prog_tests/perf_branches.c                   |   22 
 tools/testing/selftests/bpf/prog_tests/send_signal.c                     |    5 
 tools/testing/selftests/bpf/progs/test_perf_branches.c                   |    3 
 tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc |    5 
 tools/testing/selftests/net/test_vxlan_under_vrf.sh                      |    2 
 532 files changed, 5374 insertions(+), 2958 deletions(-)

Abdun Nihaal (3):
      wifi: cw1200: Fix potential memory leak in cw1200_bh_rx_helper()
      wifi: rtl818x: Fix potential memory leaks in rtl8180_init_rx_ring()
      fbdev: ssd1307fb: fix potential page leak in ssd1307fb_probe()

Ahelenia Ziemiańska (1):
      power: supply: apm_power: only unset own apm_get_power_status

Akhil P Oommen (1):
      drm/msm/a6xx: Fix out of bound IO access in a6xx_get_gmu_registers

Alan Stern (1):
      HID: core: Harden s32ton() against conversion to 0 bits

Alex Deucher (1):
      drm/amd/display: Use GFP_ATOMIC in dc_create_plane_state()

Alexander Potapenko (2):
      kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
      x86: kmsan: don't instrument stack walking functions

Alexander Stein (1):
      ASoC: fsl_sai: Add missing registers to cache default

Alexander Sverdlin (2):
      locking/spinlock/debug: Fix data-race in do_raw_write_lock
      counter: interrupt-cnt: Drop IRQF_NO_THREAD flag

Alexander Usyskin (1):
      mei: me: add nova lake point S DID

Alexandre Knecht (1):
      bridge: fix C-VLAN preservation in 802.1ad vlan_tunnel egress

Alexandru Gagniuc (1):
      remoteproc: qcom_q6v5_wcss: fix parsing of qcom,halt-regs

Alexei Starovoitov (1):
      selftests/bpf: Fix failure paths in send_signal test

Alexey Kodanev (1):
      net: stmmac: fix rx limit check in stmmac_rx_zc()

Alexey Nepomnyashih (1):
      ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()

Alexey Simakov (2):
      dm-raid: fix possible NULL dereference with undefined raid type
      broadcom: b44: prevent uninitialized value usage

Alison Schofield (1):
      tools/testing/nvdimm: Use per-DIMM device handle

Alok Tiwari (4):
      virtio_vdpa: fix misleading return in void function
      RDMA/bnxt_re: Fix incorrect BAR check in bnxt_qplib_map_creq_db()
      RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in post_send
      net: marvell: prestera: fix NULL dereference on devlink_alloc() failure

Alvaro Gamez Machado (1):
      spi: xilinx: increase number of retries before declaring stall

Amir Goldstein (1):
      fsnotify: do not generate ACCESS/MODIFY events on child for special files

Amitai Gottlieb (1):
      firmware: arm_scmi: Fix unused notifier-block in unregister

Andrea Righi (1):
      selftests: net: test_vxlan_under_vrf: fix HV connectivity test

Andres J Rosa (1):
      ALSA: uapi: Fix typo in asound.h comment

Andrew Morton (1):
      genalloc.h: fix htmldocs warning

Andrey Vatoropin (1):
      scsi: target: Reset t_task_cdb pointer in error case

Andrzej Hajda (1):
      drm/i915/selftests: fix subtraction overflow bug

Andy Shevchenko (3):
      lib/vsprintf: Check pointer before dereferencing in time_and_date()
      nfsd: Mark variable __maybe_unused to avoid W=1 build break
      pinctrl: qcom: lpass-lpi: Remove duplicate assignment of of_gpio_n_cells

Anshumali Gaur (1):
      octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"

Anton Khirnov (1):
      platform/x86: asus-wmi: use brightness_set_blocking() for kbd led

Armin Wolf (3):
      platform/x86: acer-wmi: Ignore backlight event
      fs/nls: Fix utf16 to utf8 conversion
      fs/nls: Fix inconsistency between utf8_to_utf32() and utf32_to_utf8()

Arnd Bergmann (1):
      x86: remove __range_not_ok()

Azeem Shaikh (1):
      leds: Replace all non-returning strlcpy with strscpy

Bagas Sanjaya (2):
      Documentation: process: Also mention Sasha Levin as stable tree maintainer
      net: bridge: Describe @tunnel_hash member in net_bridge_vlan_group struct

Baokun Li (1):
      ext4: align max orphan file size with e2fsprogs limit

Bart Van Assche (1):
      scsi: target: Do not write NUL characters into ASCII configfs output

Bartosz Golaszewski (1):
      pinctrl: qcom: lpass-lpi: mark the GPIO controller as sleeping

Ben Collins (1):
      powerpc/addnote: Fix overflow on 32-bit builds

Byungchul Park (1):
      jbd2: use a weaker annotation in journal handling

Cezary Rojewski (1):
      ASoC: Intel: catpt: Fix error path in hw_params()

Chancel Liu (1):
      ASoC: fsl_xcvr: Add support for i.MX93 platform

Chao Yu (5):
      f2fs: fix return value of f2fs_recover_fsync_data()
      f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
      f2fs: use global inline_xattr_slab instead of per-sb slab cache
      f2fs: fix to propagate error from f2fs_enable_checkpoint()
      f2fs: fix to avoid updating zero-sized extent in extent cache

Chen Changcheng (2):
      usb: usb-storage: No additional quirks need to be added to the EL-R12 optical drive.
      usb: usb-storage: Maintain minimal modifications to the bcdDevice range.

Chen Hanxiao (1):
      NFS: trace: show TIMEDOUT instead of 0x6e

Chia-Lin Kao (AceLan) (1):
      platform/x86/intel/hid: Add Dell Pro Rugged 10/12 tablet to VGBS DMI quirks

Christian Hitz (2):
      leds: leds-lp50xx: Allow LED 0 to be added to module bank
      leds: leds-lp50xx: LP5009 supports 3 modules for a total of 9 LEDs

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Max Gen10 AMD to i8042 quirk table

Christophe JAILLET (1):
      ASoC: stm32: sai: Use the devm_clk_get_optional() helper

Christophe Leroy (2):
      powerpc/32: Fix unpaired stwcx. on interrupt exit
      spi: fsl-cpm: Check length parity before switching to 16 bit mode

Chuck Lever (3):
      NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
      NFSD: NFSv4 file creation neglects setting ACL
      NFSD: Remove NFSERR_EAGAIN

Colin Ian King (1):
      media: pvrusb2: Fix incorrect variable used in trace message

Cong Zhang (1):
      blk-mq: Abort suspend when wakeup events are pending

Cryolitia PukNgae (1):
      ACPICA: Avoid walking the Namespace if start_node is NULL

Dai Ngo (1):
      NFSD: use correct reservation type in nfsd4_scsi_fence_client

Dan Carpenter (2):
      drm/amd/display: Fix logical vs bitwise bug in get_embedded_panel_info_v2_1()
      nfc: pn533: Fix error code in pn533_acr122_poweron_rdr()

Daniel Wagner (1):
      nvme-fc: don't hold rport lock when putting ctrl

Daniil Tatianin (2):
      net/ethtool/ioctl: remove if n_stats checks from ethtool_get_phy_stats
      net/ethtool/ioctl: split ethtool_get_phy_stats into multiple helpers

Dapeng Mi (1):
      perf/x86/intel: Correct large PEBS flag check

Dave Kleikamp (1):
      dma/pool: eliminate alloc_pages warning in atomic_pool_expand

David Hildenbrand (4):
      powerpc/pseries/cmm: call balloon_devinfo_init() also without CONFIG_BALLOON_COMPACTION
      mm/balloon_compaction: we cannot have isolated pages in the balloon list
      mm/balloon_compaction: convert balloon_page_delete() to balloon_page_finalize()
      powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages

Deepakkumar Karn (1):
      net: usb: rtl8150: fix memory leak on usb_submit_urb() failure

Deepanshu Kartikey (5):
      ext4: refresh inline data size before write operations
      btrfs: fix memory leak of fs_devices in degraded seed device path
      f2fs: invalidate dentry cache on failed whiteout creation
      net: usb: asix: validate PHY address before use
      net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write

Di Zhu (1):
      netdev: preserve NETIF_F_ALL_FOR_ALL across TSO updates

Diogo Ivo (1):
      usb: phy: Initialize struct usb_phy list_head

Dmitry Antipov (2):
      ocfs2: relax BUG() to ocfs2_error() in __ocfs2_move_extent()
      ocfs2: fix memory leak in ocfs2_merge_rec_left()

Dmitry Skorodumov (1):
      ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()

Donet Tom (1):
      powerpc/64s/slb: Fix SLB multihit issue during SLB preload

Dong Chenchen (1):
      page_pool: Fix use-after-free in page_pool_recycle_in_ring

Dongli Zhang (1):
      KVM: nVMX: Immediately refresh APICv controls as needed on nested VM-Exit

Doug Berger (1):
      sched/deadline: only set free_cpus for online runqueues

Duoming Zhou (3):
      media: TDA1997x: Remove redundant cancel_delayed_work in probe
      media: i2c: ADV7604: Remove redundant cancel_delayed_work in probe
      media: i2c: adv7842: Remove redundant cancel_delayed_work in probe

Edward Adam Davis (3):
      ntfs3: init run lock for extend inode
      fs/ntfs3: out1 also needs to put mi
      fs/ntfs3: Prevent memory leaks in add sub record

Eli Cohen (1):
      vdpa: Sync calls set/get config/status with cf_mutex

Eric Biggers (2):
      lib/crypto: x86/blake2s: Fix 32-bit arg treated as 64-bit
      lib/crypto: aes: Fix missing MMU protection for AES S-box

Eric Dumazet (3):
      ip6_gre: make ip6gre_header() robust
      wifi: avoid kernel-infoleak from struct iw_point
      arp: do not assume dev_hard_header() does not change skb->head

Eric Whitney (1):
      ext4: minor defrag code improvements

Ethan Nelson-Moore (1):
      net: usb: sr9700: fix incorrect command used to write single register

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE910C04 new compositions
      USB: serial: option: move Telit 0x10c7 composition in the right place

Fernando Fernandez Mancera (5):
      netfilter: nf_conncount: rework API to use sk_buff directly
      netfilter: nft_connlimit: update the count if add was skipped
      netfilter: nf_conncount: fix leaked ct in error paths
      netfilter: nft_synproxy: avoid possible data-race on update operation
      netfilter: nf_conncount: update last_gc only when GC has been performed

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member

Frank Li (1):
      i3c: fix refcount inconsistency in i3c_master_register

Gabor Juhos (1):
      regulator: core: disable supply if enabling main regulator fails

Gabriel Krisman Bertazi (1):
      ext4: fix error message when rejecting the default hash

Gal Pressman (2):
      ethtool: Avoid overflowing userspace buffer on stats query
      net/mlx5e: Don't print error message due to invalid module

Gongwei Li (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE

Gopi Krishna Menon (1):
      usb: raw-gadget: cap raw_io transfer length to KMALLOC_MAX_SIZE

Greg Kroah-Hartman (2):
      Revert "iommu/amd: Skip enabling command/event buffers for kdump"
      Linux 5.15.198

Gregory Herrero (1):
      i40e: validate ring_len parameter against hardware-specific values

Guangshuo Li (1):
      e1000: fix OOB in e1000_tbi_should_accept()

Gui-Dong Han (3):
      hwmon: (max16065) Use local variable to avoid TOCTOU
      hwmon: (w83791d) Convert macros to functions to avoid TOCTOU
      hwmon: (w83l786ng) Convert macros to functions to avoid TOCTOU

Guido Günther (1):
      drm/panel: visionox-rm69299: Don't clear all mode flags

Haibo Chen (2):
      ext4: clear i_state_flags when alloc inode
      arm64: dts: add off-on-delay-us for usdhc2 regulator

Hans de Goede (1):
      HID: logitech-dj: Remove duplicate error logging

Hao Chen (1):
      net: hns3: Align type of some variables with their print type

Haotian Zhang (18):
      pinctrl: stm32: fix hwspinlock resource leak in probe function
      mfd: da9055: Fix missing regmap_del_irq_chip() in error path
      scsi: stex: Fix reboot_notifier leak in probe error path
      clk: renesas: r9a06g032: Fix memory leak in error path
      ACPI: property: Fix fwnode refcount leak in acpi_fwnode_graph_parse_endpoint()
      scsi: sim710: Fix resource leak by adding missing ioport_unmap() calls
      leds: netxbig: Fix GPIO descriptor leak in error paths
      watchdog: wdat_wdt: Fix ACPI table leak in probe function
      mfd: mt6397-irq: Fix missing irq_domain_remove() in error path
      mfd: mt6358-irq: Fix missing irq_domain_remove() in error path
      crypto: ccree - Correctly handle return of sg_nents_for_len
      pinctrl: single: Fix incorrect type for error return variable
      ASoC: bcm: bcm63xx-pcm-whistler: Check return value of of_dma_configure()
      dm log-writes: Add missing set_freezable() for freezable kthread
      ALSA: vxpocket: Fix resource leak in vxpocket_probe error path
      ALSA: pcmcia: Fix resource leak in snd_pdacf_probe error path
      media: rc: st_rc: Fix reset control resource leak
      media: cec: Fix debugfs leak on bus_register() failure

Haotien Hsu (1):
      usb: gadget: tegra-xudc: Always reinitialize data toggle when clear halt

Haoxiang Li (5):
      usb: renesas_usbhs: Fix a resource leak in usbhs_pipe_malloc()
      fjes: Add missing iounmap in fjes_hw_init()
      nfsd: Drop the client reference in client_states_open()
      xfs: fix a memory leak in xfs_buf_item_init()
      media: mediatek: vcodec: Fix a reference leak in mtk_vcodec_fw_vpu_init()

Heiko Carstens (2):
      s390/smp: Fix fallback CPU detection
      s390/ap: Don't leak debug feature files if AP instructions are not available

Helge Deller (1):
      parisc: Do not reprogram affinitiy on ASP chip

Herbert Xu (1):
      crypto: seqiv - Do not use req->iv after crypto_aead_encrypt

Honggang LI (1):
      RDMA/rtrs: Fix clt_path::max_pages_per_mr calculation

Hongyu Xie (1):
      usb: xhci: limit run_graceperiod for only usb 3.0 devices

Horatiu Vultur (1):
      phy: mscc: Fix PTP for VSC8574 and VSC8572

Ian Abbott (1):
      comedi: c6xdigio: Fix invalid PNP driver unregistration

Ian Ray (1):
      ARM: dts: imx6q-ba16: fix RTC interrupt level

Ido Schimmel (3):
      mlxsw: spectrum_router: Fix neighbour use-after-free
      mlxsw: spectrum_mr: Fix use-after-free when updating multicast route stats
      ipv4: Fix reference count leak when using error routes with nexthop objects

Ilya Dryomov (4):
      libceph: make decode_pool() more resilient against corrupted osdmaps
      libceph: replace overzealous BUG_ON in osdmap_apply_incremental()
      libceph: return the handler error from mon_handle_auth_done()
      libceph: make calc_target() set t->paused, not just clear it

Ilya Maximets (1):
      net: openvswitch: fix middle attribute validation in push_nsh() action

Ivan Abramov (3):
      power: supply: wm831x: Check wm831x_set_bits() return value
      media: adv7842: Avoid possible out-of-bounds array accesses in adv7842_cp_log_status()
      media: msp3400: Avoid possible out-of-bounds array accesses in msp3400c_thread()

Ivan Stepchenko (1):
      mtd: lpddr_cmds: fix signed shifts in lpddr_cmds

Ivan Vecera (2):
      i40e: Refactor argument of several client notification functions
      i40e: Refactor argument of i40e_detect_recover_hung()

Jacky Chou (1):
      net: mdio: aspeed: add dummy read to avoid read-after-write issue

Jakub Kicinski (1):
      eth: bnxt: move and rename reset helpers

Jamal Hadi Salim (1):
      net/sched: ets: Always remove class from active list before deleting in ets_qdisc_change

Jang Ingyu (1):
      RDMA/core: Fix logic error in ib_get_gids_from_rdma_hdr()

Janusz Krzysztofik (1):
      drm/vgem-fence: Fix potential deadlock on release

Jared Kangas (1):
      mmc: sdhci-esdhc-imx: add alternate ARCH_S32 dependency to Kconfig

Jarkko Sakkinen (2):
      KEYS: trusted: Fix a memory leak in tpm2_load_cmd
      tpm: Cap the number of PCR banks

Jason Gunthorpe (2):
      RDMA/core: Check for the presence of LS_NLA_TYPE_DGID correctly
      RDMA/cm: Fix leaking the multicast GID table reference

Jason Yan (1):
      ext4: factor out ext4_hash_info_init()

Jay Liu (1):
      drm/mediatek: Fix CCORR mtk_ctm_s31_32_to_s1_n function issue

Jeongjun Park (2):
      media: dvb-usb: dtv5100: fix out-of-bounds in dtv5100_i2c_msg()
      media: vidtv: initialize local pointers upon transfer of memory ownership

Jerry Wu (1):
      net: mscc: ocelot: Fix crash when adding interface under a lag

Jia Ston (1):
      platform/x86: huawei-wmi: add keys for HONOR models

Jian Shen (3):
      net: hns3: using the num_tqps in the vf driver to apply for resources
      net: hns3: using the num_tqps to check whether tqp_index is out of range when vf get ring info from mbx
      net: hns3: add VLAN id validation before using

Jianglei Nie (1):
      staging: fbtft: core: fix potential memory leak in fbtft_probe_common()

Jim Mattson (1):
      KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN

Jim Quinlan (1):
      PCI: brcmstb: Fix disabling L0s capability

Jimmy Hu (1):
      usb: gadget: udc: fix use-after-free in usb_gadget_state_work

Jinhui Guo (2):
      ipmi: Fix the race between __scan_channels() and deliver_response()
      ipmi: Fix __scan_channels() failing to rescan channels

Jiri Pirko (1):
      team: fix check for port enabled in team_queue_override_port_prio_changed()

Jisheng Zhang (3):
      usb: dwc2: disable platform lowlevel hw resources during shutdown
      usb: dwc2: fix hang during shutdown if set as peripheral
      usb: dwc2: fix hang during suspend if set as peripheral

Joanne Koong (1):
      fuse: fix readahead reclaim deadlock

Johan Hovold (25):
      USB: serial: ftdi_sio: match on interface number for jtag
      USB: serial: belkin_sa: fix TIOCMBIS and TIOCMBIC
      USB: serial: kobil_sct: fix TIOCMBIS and TIOCMBIC
      irqchip/qcom-irq-combiner: Fix section mismatch
      phy: broadcom: bcm63xx-usbh: fix section mismatches
      usb: phy: isp1301: fix non-OF device reference imbalance
      amba: tegra-ahb: Fix device leak on SMMU enable
      soc: qcom: ocmem: fix device leak on lookup
      soc: amlogic: canvas: fix device leak on lookup
      ASoC: stm32: sai: fix device leak on probe
      iommu/apple-dart: fix device leak on of_xlate()
      iommu/exynos: fix device leak on of_xlate()
      iommu/ipmmu-vmsa: fix device leak on of_xlate()
      iommu/mediatek-v1: fix device leak on probe_device()
      iommu/mediatek: fix device leak on of_xlate()
      iommu/omap: fix device leaks on probe_device()
      iommu/sun50i: fix device leak on of_xlate()
      iommu/tegra: fix device leak on probe_device()
      mfd: altera-sysmgr: Fix device leak on sysmgr regmap lookup
      usb: ohci-nxp: fix device leak on probe failure
      media: vpif_capture: fix section mismatch
      iommu/qcom: fix device leak on of_xlate()
      ASoC: stm32: sai: fix clk prepare imbalance on probe failure
      ASoC: stm32: sai: fix OF node leak on probe
      usb: gadget: lpc32xx_udc: fix clock imbalance in error path

Jonas Gorski (1):
      net: dsa: b53: skip multicast entries for fdb_dump()

Jonathan Curley (1):
      NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_layout_stateid_invalid

Josef Bacik (1):
      btrfs: don't rewrite ret from inode_permission

Joshua Rogers (3):
      svcrdma: return 0 on success from svc_rdma_copy_inline_range
      svcrdma: bound check rq_pages index in inline path
      SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf

Josua Mayer (1):
      clk: mvebu: cp110 add CLK_IGNORE_UNUSED to pcie_x10, pcie_x11 & pcie_x4

Jouni Malinen (1):
      wifi: mac80211: Discard Beacon frames to non-broadcast address

Junjie Cao (1):
      Input: ti_am335x_tsc - fix off-by-one error in wire_order validation

Junrui Luo (6):
      ALSA: dice: fix buffer overflow in detect_stream_formats()
      caif: fix integer underflow in cffrml_receive()
      scsi: aic94xx: fix use-after-free in device removal path
      platform/x86: ibm_rtl: fix EBDA signature search pointer arithmetic
      ALSA: wavefront: Clear substream pointers on close
      ALSA: wavefront: Fix integer overflow in sample size validation

Justin Stitt (1):
      KVM: arm64: sys_regs: disable -Wuninitialized-const-pointer warning

Kai Song (1):
      drm/i915/selftests: Fix inconsistent IS_ERR and PTR_ERR

Kalesh AP (1):
      RDMA/bnxt_re: Fix to use correct page size for PDE table

Karina Yankevich (1):
      ext4: xattr: fix null pointer deref in ext4_raw_inode()

Kees Cook (1):
      compiler-gcc.h: Define __SANITIZE_ADDRESS__ under hwaddress sanitizer

Kemeng Shi (1):
      ext4: remove unused return value of __mb_check_buddy

Kohei Enju (1):
      iavf: fix off-by-one issues in iavf_config_rss_reg()

Konstantin Andreev (1):
      smack: fix bug: unprivileged task can create labels

Konstantin Komarov (5):
      fs/ntfs3: Remove unused mi_mark_free
      fs/ntfs3: Add new argument is_mft to ntfs_mark_rec_free
      fs/ntfs3: Make ni_ins_new_attr return error
      fs/ntfs3: Support timestamps prior to epoch
      fs/ntfs3: fix mount failure for sparse runs in run_unpack()

Krishna Yarlagadda (4):
      spi: tegra210-quad: use device_reset method
      spi: tegra210-quad: add new chips to compatible
      spi: tegra210-quad: combined sequence mode
      spi: tegra210-quad: Fix validate combined sequence

Krzysztof Czurylo (2):
      RDMA/irdma: Fix data race in irdma_sc_ccq_arm
      RDMA/irdma: Fix data race in irdma_free_pble

Krzysztof Kozlowski (1):
      mfd: max77620: Fix potential IRQ chip conflict when probing two devices

Kuninori Morimoto (1):
      ASoC: stm: Use dev_err_probe() helper

Kuniyuki Iwashima (1):
      sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().

Laibin Qiu (1):
      blk-throttle: Set BIO_THROTTLED when bio has been throttled

Laurent Pinchart (1):
      media: v4l2-mem2mem: Fix outdated documentation

Leo Yan (3):
      coresight: etm4x: Extract the trace unit controlling
      coresight: etm4x: Add context synchronization before enabling trace
      coresight: etm4x: Correct polling IDLE bit

Li Chen (1):
      block: rate-limit capacity change info log

Li Qiang (2):
      uio: uio_fsl_elbc_gpcm:: Add null pointer check to uio_fsl_elbc_gpcm_probe
      via_wdt: fix critical boot hang due to unnamed resource allocation

Liu Xinpeng (1):
      watchdog: wdat_wdt: Stop watchdog when uninstalling module

Liyuan Pang (1):
      ARM: 9464/1: fix input-only operand modification in load_unaligned_zeropad()

Lizhi Xu (2):
      usbip: Fix locking bug in RT-enabled kernels
      ext4: filesystems without casefold feature cannot be mounted with siphash

Long Li (1):
      macintosh/mac_hid: fix race condition in mac_hid_toggle_emumouse

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: introduce st_lsm6dsx_device_set_enable routine
      iio: imu: st_lsm6dsx: discard samples during filters settling time

Luca Ceresoli (1):
      backlight: led-bl: Add devlink to supplier LEDs

Lukas Wunner (1):
      PCI/PM: Reinstate clearing state_saved in legacy and !PM codepaths

Lyude Paul (1):
      drm/nouveau/dispnv50: Don't call drm_atomic_get_crtc_state() in prepare_fb

Ma Ke (4):
      RDMA/rtrs: server: Fix error handling in get_or_create_srv
      USB: lpc32xx_udc: Fix error handling in probe
      intel_th: Fix error handling in intel_th_output_open
      i2c: amd-mp2: fix reference leak in MP2 PCI device

Magne Bruno (1):
      serial: add support of CPCI cards

Mainak Sen (1):
      gpu: host1x: Fix race in syncpt alloc/free

Manivannan Sadhasivam (1):
      dt-bindings: PCI: amlogic: Fix the register name of the DBI region

Mans Rullgard (1):
      backlight: led_bl: Take led_access lock when required

Marek Szyprowski (1):
      media: samsung: exynos4-is: fix potential ABBA deadlock on init

Mark Pearson (1):
      usb: typec: ucsi: Handle incorrect num_connectors capability

Martin Nybo Andersen (1):
      kbuild: Use CRC32 and a 1MiB dictionary for XZ compressed modules

Mathias Nyman (1):
      xhci: dbgtty: use IDR to support several dbc instances.

Matt Bobrowski (2):
      selftests/bpf: skip test_perf_branches_hw() on unsupported platforms
      selftests/bpf: Improve reliability of test_perf_branches_no_hw()

Matthew Wilcox (Oracle) (1):
      idr: fix idr_alloc() returning an ID out of range

Matthias Schiffer (1):
      ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx

Matthieu Baerts (NGI0) (1):
      mptcp: pm: ignore unknown endpoint flags

Matthijs Kooijman (1):
      pinctrl: single: Fix PIN_CONFIG_BIAS_DISABLE handling

Mauro Carvalho Chehab (3):
      efi/cper: Add a new helper function to print bitmasks
      efi/cper: Adjust infopfx size to accept an extra space
      efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs

Maximilian Immanuel Brandtner (1):
      virtio_console: fix order of fields cols and rows

Miaohe Lin (1):
      mm/balloon_compaction: make balloon page compaction callbacks static

Miaoqian Lin (4):
      usb: dwc3: of-simple: fix clock resource leak in dwc3_of_simple_probe
      cpufreq: nforce2: fix reference count leak in nforce2
      media: renesas: rcar_drif: fix device node reference leak in rcar_drif_bond_enabled
      drm/pl111: Fix error handling in pl111_amba_probe

Michael Margolin (1):
      RDMA/efa: Remove possible negative shift

Michael S. Tsirkin (1):
      virtio: fix virtqueue_set_affinity() docs

Michal Pecio (1):
      usb: xhci: Apply the link chain quirk on NEC isoc endpoints

Michal Rábek (1):
      scsi: sg: Fix occasional bogus elapsed time that exceeds timeout

Michal Schmidt (1):
      RDMA/irdma: avoid invalid read in irdma_net_event

Mike Snitzer (1):
      nfs_common: factor out nfs_errtbl and nfs_stat_to_errno

Morduan Zang (1):
      efi/cper: Fix cper_bits_to_str buffer handling and return value

Namhyung Kim (1):
      perf tools: Fix split kallsyms DSO counting

Naoki Ueki (1):
      HID: elecom: Add support for ELECOM M-XT3URBK (018F)

Navaneeth K (2):
      staging: rtl8723bs: fix stack buffer overflow in OnAssocReq IE parsing
      staging: rtl8723bs: fix out-of-bounds read in OnBeacon ESR IE parsing

Neil Armstrong (1):
      dt-bindings: PCI: convert amlogic,meson-pcie.txt to dt-schema

NeilBrown (5):
      NFS: don't unhash dentry during unlink/rename
      lockd: fix vfs_test_lock() calls
      nfsd: provide locking for v4_end_grace
      NFS: unlink/rmdir shouldn't call d_delete() twice on ENOENT
      NFS: add barriers when testing for NFS_FSDATA_BLOCKED

Nicklas Bo Jensen (1):
      netfilter: nf_conncount: garbage collection is not skipped when jiffies wrap around

Nicolas Dufresne (1):
      media: verisilicon: Protect G2 HEVC decoder against invalid DPB index

Nicolas Ferre (1):
      ARM: dts: microchip: sama7g5: fix uart fifo size to 32

Nikita Zhandarovich (3):
      comedi: pcl818: fix null-ptr-deref in pcl818_ai_cancel()
      comedi: multiq3: sanitize config options in multiq3_attach()
      comedi: check device's attached status in compat ioctls

Niklas Neronin (1):
      usb: xhci: move link chain bit quirk checks into one helper function.

Oliver Neukum (1):
      usb: chaoskey: fix locking for O_NONBLOCK

Ondrej Mosnacek (2):
      fs_context: drop the unused lsm_flags member
      bpf, arm64: Do not audit capability check in do_jit()

Pablo Neira Ayuso (1):
      netfilter: flowtable: check for maximum number of encapsulations in bridge vlan

Parav Pandit (2):
      vdpa: Introduce and use vdpa device get, set config helpers
      vdpa: Introduce query of device config layout

Peng Fan (3):
      firmware: imx: scu-irq: fix OF node leak in
      firmware: imx: scu-irq: Init workqueue before request mbox channel
      firmware: imx: scu-irq: Set mu_resource_id before get handle

Pengjie Zhang (1):
      ACPI: CPPC: Fix missing PCC check for guaranteed_perf

Peter Zijlstra (1):
      x86/ptrace: Always inline trivial accessors

Petko Manolov (1):
      net: usb: pegasus: fix memory leak in update_eth_regs_async()

Ping Cheng (1):
      HID: input: map HID_GD_Z to ABS_DISTANCE for stylus/pen

Potin Lai (1):
      net: mdio: aspeed: move reg accessing part into separate functions

Praveen Talari (1):
      pinctrl: qcom: msm: Fix deadlock in pinmux configuration

Prithvi Tambewagh (2):
      ocfs2: fix kernel BUG in ocfs2_find_victim_chain
      io_uring: fix filename leak in __io_openat_prep()

Przemyslaw Korba (1):
      i40e: fix scheduling in set_rx_mode

Pwnverse (1):
      net: rose: fix invalid array index in rose_kill_by_device()

Qu Wenruo (1):
      btrfs: scrub: always update btrfs_scrub_progress::last_physical

Rafael J. Wysocki (1):
      PM: runtime: Do not clear needs_force_resume with enabled runtime PM

Randy Dunlap (1):
      backlight: lp855x: Fix lp855x.h kernel-doc warnings

Raphael Pinsonneault-Thibeault (2):
      ntfs3: fix uninit memory after failed mi_read in mi_format_new
      Bluetooth: btusb: revert use of devm_kzalloc in btusb

Rene Rebe (3):
      ps3disk: use memcpy_{from,to}_bvec index
      floppy: fix for PAGE_SIZE != 4KB
      fbdev: gbefb: fix to use physical address instead of dma address

René Rebe (4):
      ACPI: processor_core: fix map_x2apic_id for amd-pstate on am4
      fbdev: tcx.c fix mem_map to correct smem_start offset
      r8169: fix RTL8117 Wake-on-Lan in DASH mode
      HID: quirks: work around VID/PID conflict for appledisplay

Ria Thomas (1):
      wifi: ieee80211: correct FILS status codes

Ritesh Harjani (IBM) (1):
      powerpc/64s/ptdump: Fix kernel_hash_pagetable dump for ISA v3.00 HPTE format

Robert-Ionut Alexa (1):
      dpaa2-mac: bail if the dpmacs fwnode is not found

Robin Gong (1):
      spi: imx: keep dma request disabled before dma transfer setup

Sabrina Dubroca (4):
      xfrm: delete x->tunnel as we delete x
      Revert "xfrm: destroy xfrm_state synchronously on net exit path"
      xfrm: also call xfrm_state_delete_tunnel at destroy time for states that were never added
      xfrm: flush all states in xfrm_state_fini

Sakari Ailus (1):
      ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint() only

Sam James (1):
      alpha: don't reference obsolete termio struct for TC* constants

Sarthak Garg (1):
      mmc: sdhci-msm: Avoid early clock doubling during HS400 transition

Scott Mayhew (1):
      NFSv4: ensure the open stateid seqid doesn't go backwards

Sean Christopherson (4):
      KVM: x86: WARN if hrtimer callback for periodic APIC timer fires with period=0
      KVM: nSVM: Set exit_code_hi to -1 when synthesizing SVM_EXIT_ERR (failed VMRUN)
      KVM: nSVM: Clear exit_code_hi in VMCB when synthesizing nested VM-Exits
      KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS

Sean Nyekjaer (1):
      pwm: stm32: Always program polarity

Sebastian Andrzej Siewior (1):
      ARM: 9461/1: Disable HIGHPTE on PREEMPT_RT kernels

SeongJae Park (10):
      mm/damon/tests/vaddr-kunit: handle alloc failures in damon_test_split_evenly_fail()
      mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
      mm/damon/tests/vaddr-kunit: handle alloc failures on damon_test_split_evenly_succ()
      mm/damon/tests/core-kunit: handle allocation failures in damon_test_regions()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_at()
      mm/damon/tests/core-kunit: handle alloc failures on dasmon_test_merge_regions_of()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_merge_two()
      mm/damon/tests/core-kunit: handle memory failure from damon_test_target()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_regions_of()
      mm/damon/tests/core-kunit: handle memory alloc failure from damon_test_aggregate()

Sergey Bashirov (1):
      NFSD/blocklayout: Fix minlength check in proc_layoutget

Sergey Shtylyov (1):
      mmc: core: use sysfs_emit() instead of sprintf()

Seungjin Bae (2):
      USB: Fix descriptor count when handling invalid MBIM extended descriptor
      wifi: rtl818x: rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()

Shaurya Rane (1):
      net/hsr: fix NULL pointer dereference in prp_get_untagged_frame()

Shawn Lin (1):
      PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK definition

Shay Drory (3):
      net/mlx5: fw_tracer, Add support for unrecognized string
      net/mlx5: fw_tracer, Validate format string parameters
      net/mlx5: fw_tracer, Handle escaped percent properly

Shengjiu Wang (5):
      ASoC: fsl_xcvr: Add Counter registers
      ASoC: fsl_xcvr: clear the channel status control memory
      ASoC: ak4458: Disable regulator when error happens
      ASoC: ak5558: Disable regulator when error happens
      ASoC: fsl_xcvr: get channel status data when PHY is not exists

Shigeru Yoshida (2):
      ipv6: Fix potential uninit-value access in __ip6_make_skb()
      ipv4: Fix uninit-value access in __ip_make_skb()

Shipei Qu (1):
      ALSA: usb-mixer: us16x08: validate meter packet indices

Shivani Agarwal (1):
      crypto: af_alg - zero initialize memory allocated via sock_kmalloc

Shuhao Fu (1):
      cpufreq: s5pv210: fix refcount leak

Siddharth Vadapalli (1):
      PCI: keystone: Exit ks_pcie_probe() for invalid mode

Sidharth Seela (1):
      ntfs3: Fix uninit buffer allocated by __getname()

Simon Richter (1):
      drm/ttm: Avoid NULL pointer deref for evicted BOs

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W760

Slavin Liu (1):
      ipvs: fix ipv4 null-ptr-deref in route error path

Song Liu (1):
      livepatch: Match old_sympos 0 and 1 in klp_find_func()

Srijit Bose (1):
      bnxt_en: Fix potential data corruption with HW GRO/LRO

Srinivas Kandagatla (4):
      rpmsg: glink: fix rpmsg device leak
      ASoC: qcom: q6asm-dai: perform correct state check before closing
      ASoC: qcom: q6adm: the the copp device only during last instance
      ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.

Stanley Chu (1):
      i3c: master: svc: Prevent incomplete IBI transaction

Stefan Kalscheuer (1):
      leds: spi-byte: Use devm_led_classdev_register_ext()

Stefano Garzarella (1):
      vhost/vsock: improve RCU read sections around vhost_vsock_get()

Stephan Gerhold (1):
      iommu/arm-smmu-qcom: Enable use of all SMR groups when running bare-metal

Steven Rostedt (2):
      ktest.pl: Fix uninitialized var in config-bisect.pl
      tracing: Do not register unsupported perf events

Su Hui (1):
      net: ethtool: fix the error condition in ethtool_get_phy_stats_ethtool()

Sumeet Pawnikar (2):
      powercap: fix race condition in register_control_type()
      powercap: fix sscanf() error return value handling

Sun Ke (1):
      NFS: Fix missing unlock in nfs_unlink()

Suzuki K Poulose (2):
      coresight: etm4x: Save restore TRFCR_EL1
      coresight: etm4x: Use Trace Filtering controls dynamically

Sven Eckelmann (Plasma Cloud) (1):
      wifi: mt76: Fix DTS power-limits on little endian systems

Sven Schnelle (2):
      parisc: entry.S: fix space adjustment on interruption for 64-bit userspace
      parisc: entry: set W bit for !compat tasks in syscall_restore_rfi()

Takashi Iwai (1):
      ALSA: wavefront: Use standard print API

Tengda Wu (1):
      x86/dumpstack: Prevent KASAN false positive warnings in __show_regs()

Tetsuo Handa (3):
      bfs: Reconstruct file type when loading from disk
      hfsplus: Verify inode mode when loading from disk
      can: j1939: make j1939_session_activate() fail if device is no longer registered

Thadeu Lima de Souza Cascardo (1):
      net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.

Thomas Fourier (5):
      platform/x86: msi-laptop: add missing sysfs_remove_group()
      firewire: nosy: Fix dma_free_coherent() size
      RDMA/bnxt_re: fix dma_free_coherent() pointer
      atm: Fix dma_free_coherent() size
      net: 3com: 3c59x: fix possible null dereference in vortex_probe1()

Thomas Zimmermann (1):
      drm/gma500: Remove unused helper psb_fbdev_fb_setcolreg()

Thorsten Blum (2):
      crypto: asymmetric_keys - prevent overflow in asymmetric_key_generate_id
      fbdev: pxafb: Fix multiple clamped values in pxafb_adjust_timing

Tianchu Chen (1):
      char: applicom: fix NULL pointer dereference in ac_ioctl

Tim Harvey (1):
      arm64: dts: imx8mm-venice-gw72xx: remove unused sdhc1 pinctrl

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid needlessly taking the RTNL on vport destroy

Tom Rix (1):
      ethtool: use phydev variable

Tony Battersby (4):
      scsi: qla2xxx: Fix lost interrupts with qlini_mode=disabled
      scsi: qla2xxx: Fix initiator mode with qlini_mode=exclusive
      scsi: qla2xxx: Use reinit_completion on mbx_intr_comp
      scsi: Revert "scsi: qla2xxx: Perform lockless command completion in abort path"

Trond Myklebust (10):
      NFS: Label the dentry with a verifier in nfs_rmdir() and nfs_unlink()
      NFS: Avoid changing nlink when file removes and attribute updates race
      NFSv4: Add some support for case insensitive filesystems
      NFS: Fix the verifier for case sensitive filesystem in nfs_atomic_open()
      NFS: Initialise verifiers for visible dentries in nfs_atomic_open()
      Revert "nfs: ignore SB_RDONLY when remounting nfs"
      Revert "nfs: clear SB_RDONLY before getting superblock"
      Revert "nfs: ignore SB_RDONLY when mounting nfs"
      NFS: Automounted filesystems should inherit ro,noexec,nodev,sync flags
      NFS: Fix up the automount fs_context to use the correct cred

Tuo Li (1):
      libceph: make free_choose_arg_map() resilient to partial allocation

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_ishtp: Fix UAF after unbinding driver

Udipto Goswami (1):
      usb: dwc3: keep susphy enabled during exit to avoid controller faults

Uladzislau Rezki (Sony) (1):
      dm-ebs: Mark full buffer dirty even on partial write

Uwe Kleine-König (1):
      pwm: bcm2835: Make sure the channel is enabled after pwm_request()

Viacheslav Dubeyko (2):
      hfsplus: fix volume corruption issue for generic/070
      hfsplus: fix volume corruption issue for generic/073

Victor Nogueira (1):
      net/sched: ets: Remove drr class from the active list if it changes to strict

Vishwaroop A (3):
      spi: tegra210-quad: modify chip select (CS) deactivation
      spi: tegra210-quad: Fix timeout handling
      spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers

Wang Liang (1):
      netrom: Fix memory leak in nr_sendmsg()

Wei Fang (1):
      net: enetc: fix build warning when PAGE_SIZE is greater than 128K

Weiming Shi (1):
      net: sock: fix hardened usercopy panic in sock_recv_errqueue

Wen Xiong (1):
      scsi: ipr: Enable/disable IRQD_NO_BALANCING during reset

Wenhua Lin (1):
      serial: sprd: Return -EPROBE_DEFER when uart clock is not ready

Will Rosenberg (1):
      ipv6: BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()

William Tu (1):
      netfilter: nf_conncount: reduce unnecessary GC

Xiang Mei (2):
      net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop
      net/sched: sch_qfq: Fix NULL deref when deactivating inactive aggregate in qfq_reset

Xingui Yang (1):
      scsi: Revert "scsi: libsas: Fix exp-attached device scan after probe failure scanned in again after probe failed"

Xuanqiang Luo (2):
      rculist: Add hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
      inet: Avoid ehash lookup race in inet_ehash_insert()

Yang Chenzhi (1):
      hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create

Yang Li (1):
      csky: fix csky_cmpxchg_fixup not working

Ye Bin (4):
      jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted
      jbd2: fix the inconsistency between checksum and data in memory for journal sb
      ext4: introduce ITAIL helper
      ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

Yeoreum Yun (1):
      smc91x: fix broken irq-context in PREEMPT_RT

Yipeng Zou (1):
      selftests/ftrace: traceonoff_triggers: strip off names

Yongjian Sun (2):
      ext4: improve integrity checking in __mb_check_buddy by enhancing order-0 validation
      ext4: fix incorrect group number assertion in mb_check_buddy

Yosry Ahmed (1):
      KVM: nSVM: Propagate SVM_EXIT_CR0_SEL_WRITE correctly for LMSW emulation

Yu Kuai (2):
      nbd: clean up return value checking of sock_xmit()
      nbd: partition nbd_read_stat() into nbd_read_reply() and nbd_handle_reply()

Yuanfang Zhang (1):
      coresight-etm4x: add isb() before reading the TRCSTATR

Yuezhang Mo (1):
      exfat: fix remount failure in different process environments

Zack Rusin (1):
      drm/vmwgfx: Fix a null-ptr access in the cursor snooper

Zhang Yi (1):
      ext4: correct the checking of quota files before moving extents

Zhang Zekun (1):
      usb: ohci-nxp: Use helper function devm_clk_get_enabled()

Zhao Yipeng (1):
      ima: Handle error code returned by ima_filter_rule_match()

Zheng Qixing (2):
      nbd: defer config put in recv_work
      nbd: defer config unlock in nbd_genl_connect

Zhichi Lin (1):
      scs: fix a wrong parameter in __scs_magic

Zhu Yanjun (1):
      RDMA/core: Fix "KASAN: slab-use-after-free Read in ib_register_device" problem

Zilin Guan (2):
      mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()
      netfilter: nf_tables: fix memory leak in nf_tables_newrule()

fuqiang wang (2):
      KVM: x86: Explicitly set new periodic hrtimer expiration in apic_timer_fn()
      KVM: x86: Fix VM hard lockup after prolonged inactivity with periodic HV timer

nieweiqiang (1):
      crypto: hisilicon/qm - restore original qos values

shechenglong (1):
      block: fix comment for op_is_zone_mgmt() to include RESET_ALL

sparkhuang (1):
      regulator: core: Protect regulator_supply_alias_list with regulator_list_mutex

yuan.gao (1):
      inet: ping: Fix icmp out counting

ziming zhang (1):
      libceph: prevent potential out-of-bounds reads in handle_auth_done()

Łukasz Bartosik (1):
      xhci: dbgtty: fix device unregister


