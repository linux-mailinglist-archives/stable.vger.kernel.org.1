Return-Path: <stable+bounces-52315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA685909D51
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 14:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B53E281684
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 12:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7398E18F2D1;
	Sun, 16 Jun 2024 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KOQRnKj2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BA18F2C8;
	Sun, 16 Jun 2024 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718539460; cv=none; b=oMFdewot0jAydHpruG2c8UJn5AwDU6dDnJKql2h9SI6dUFaFcjFrNcSC7qNoWrQ4AVMQZ7OLdJjajWoZXDrW7y/EhZXCcOG4dz3XiLfD0LqtxZt29CY1L3wWUZYBKKvTpMzqHW5bvVZwdh/7h8dbza2q9IMV02l8M37U5nXl0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718539460; c=relaxed/simple;
	bh=cgryhmd+TGpRpQIIUhA6xnsAatiJ6O98TflKZMNppYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dONa5rjfZ+PbyGhiqxLHj9g0rcfUNuW2mNFov7tnofpZ/WnamMhFOf1YSk7uSWAV336np8Z4AZ8P8eBdPNA5GgHPDUsJCemMRP0qus+SudrWVio7Hn5bMmvVzzg3RjT6W9DgHMsc3wH5rFqL32k+4Fhquxc/YIcHYSyLYDhTUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KOQRnKj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED1EC2BBFC;
	Sun, 16 Jun 2024 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718539459;
	bh=cgryhmd+TGpRpQIIUhA6xnsAatiJ6O98TflKZMNppYE=;
	h=From:To:Cc:Subject:Date:From;
	b=KOQRnKj2EV3TmVA5n94mu0kfcSDl/s9XF9W9KlxhfPg6xoxwHEFvNrLDcGD6Ar9zv
	 v2AeRbk/M7ckLp4+sli7kdOifWBTJfwbcFOCkq9AZals4/HMzeB5l3bYgaeMuLBECa
	 6xmsmaR8ZkRmjrKnRN1rM8GkPZkj4x6hF6jEHctE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.161
Date: Sun, 16 Jun 2024 14:04:04 +0200
Message-ID: <2024061605-monkhood-baggage-db52@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.161 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml           |   18 
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml               |   14 
 Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml |   92 +-
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml                |    1 
 Documentation/devicetree/bindings/sound/rt5645.txt                     |    6 
 Documentation/driver-api/fpga/fpga-region.rst                          |   17 
 Documentation/networking/device_drivers/ethernet/amazon/ena.rst        |   32 
 Makefile                                                               |    2 
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi                         |    2 
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts                         |    4 
 arch/arm64/boot/dts/nvidia/tegra132.dtsi                               |    2 
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi                               |    2 
 arch/arm64/include/asm/asm-bug.h                                       |    1 
 arch/arm64/kvm/guest.c                                                 |    3 
 arch/m68k/kernel/entry.S                                               |    4 
 arch/m68k/mac/misc.c                                                   |   36 -
 arch/microblaze/kernel/Makefile                                        |    1 
 arch/microblaze/kernel/cpu/cpuinfo-static.c                            |    2 
 arch/parisc/kernel/parisc_ksyms.c                                      |    1 
 arch/powerpc/include/asm/hvcall.h                                      |    2 
 arch/powerpc/platforms/pseries/lpar.c                                  |    6 
 arch/powerpc/platforms/pseries/lparcfg.c                               |    6 
 arch/powerpc/sysdev/fsl_msi.c                                          |    2 
 arch/riscv/kernel/entry.S                                              |    3 
 arch/riscv/kernel/stacktrace.c                                         |   29 
 arch/s390/boot/startup.c                                               |    1 
 arch/s390/include/asm/cpacf.h                                          |  109 ++-
 arch/s390/kernel/ipl.c                                                 |   10 
 arch/s390/kernel/setup.c                                               |    2 
 arch/s390/kernel/vdso32/Makefile                                       |    5 
 arch/s390/kernel/vdso64/Makefile                                       |    6 
 arch/s390/net/bpf_jit_comp.c                                           |    8 
 arch/sh/kernel/kprobes.c                                               |    7 
 arch/sh/lib/checksum.S                                                 |   67 --
 arch/sparc/include/asm/smp_64.h                                        |    2 
 arch/sparc/include/uapi/asm/termbits.h                                 |   10 
 arch/sparc/include/uapi/asm/termios.h                                  |    9 
 arch/sparc/kernel/prom_64.c                                            |    4 
 arch/sparc/kernel/setup_64.c                                           |    1 
 arch/sparc/kernel/smp_64.c                                             |   14 
 arch/um/drivers/line.c                                                 |   14 
 arch/um/drivers/ubd_kern.c                                             |    4 
 arch/um/drivers/vector_kern.c                                          |    2 
 arch/um/include/asm/mmu.h                                              |    2 
 arch/um/include/shared/skas/mm_id.h                                    |    2 
 arch/x86/Kconfig.debug                                                 |    5 
 arch/x86/crypto/nh-avx2-x86_64.S                                       |    1 
 arch/x86/crypto/sha256-avx2-asm.S                                      |    1 
 arch/x86/crypto/sha512-avx2-asm.S                                      |    1 
 arch/x86/entry/vsyscall/vsyscall_64.c                                  |   28 
 arch/x86/include/asm/processor.h                                       |    1 
 arch/x86/kernel/apic/vector.c                                          |    9 
 arch/x86/kernel/tsc_sync.c                                             |    6 
 arch/x86/kvm/cpuid.c                                                   |   21 
 arch/x86/lib/x86-opcode-map.txt                                        |    2 
 arch/x86/mm/fault.c                                                    |   33 -
 arch/x86/purgatory/Makefile                                            |    3 
 arch/x86/tools/relocs.c                                                |    9 
 crypto/ecdsa.c                                                         |    3 
 crypto/ecrdsa.c                                                        |    1 
 drivers/accessibility/speakup/main.c                                   |    2 
 drivers/acpi/acpica/Makefile                                           |    1 
 drivers/acpi/resource.c                                                |   12 
 drivers/ata/pata_legacy.c                                              |    8 
 drivers/block/null_blk/main.c                                          |    3 
 drivers/char/ppdev.c                                                   |   21 
 drivers/clk/qcom/mmcc-msm8998.c                                        |    8 
 drivers/cpufreq/cppc_cpufreq.c                                         |   14 
 drivers/cpufreq/cpufreq.c                                              |   83 +-
 drivers/crypto/bcm/spu2.c                                              |    2 
 drivers/crypto/ccp/sp-platform.c                                       |   14 
 drivers/crypto/qat/qat_common/adf_aer.c                                |   19 
 drivers/dma-buf/sync_debug.c                                           |    4 
 drivers/dma/idma64.c                                                   |    4 
 drivers/edac/igen6_edac.c                                              |    4 
 drivers/extcon/Kconfig                                                 |    3 
 drivers/firmware/dmi-id.c                                              |    7 
 drivers/firmware/raspberrypi.c                                         |    7 
 drivers/fpga/dfl-fme-region.c                                          |   17 
 drivers/fpga/dfl.c                                                     |   12 
 drivers/fpga/fpga-region.c                                             |  129 +--
 drivers/fpga/of-fpga-region.c                                          |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c                       |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                             |    8 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                                 |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                               |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |    1 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c                 |    5 
 drivers/gpu/drm/amd/include/atomfirmware.h                             |   43 +
 drivers/gpu/drm/arm/malidp_mw.c                                        |    5 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c                    |    3 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                               |    6 
 drivers/gpu/drm/bridge/lontium-lt9611.c                                |    6 
 drivers/gpu/drm/bridge/tc358775.c                                      |   27 
 drivers/gpu/drm/drm_mipi_dsi.c                                         |    6 
 drivers/gpu/drm/drm_modeset_helper.c                                   |   19 
 drivers/gpu/drm/drm_probe_helper.c                                     |   15 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                                 |    3 
 drivers/gpu/drm/meson/meson_vclk.c                                     |    6 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c                   |    3 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                     |   10 
 drivers/gpu/drm/panel/panel-simple.c                                   |    3 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                         |    2 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                                |    5 
 drivers/hwmon/shtc1.c                                                  |    2 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                     |   65 -
 drivers/hwtracing/coresight/coresight-etm4x.h                          |   44 -
 drivers/hwtracing/intel_th/pci.c                                       |    5 
 drivers/hwtracing/stm/core.c                                           |   11 
 drivers/i3c/master/svc-i3c-master.c                                    |   16 
 drivers/iio/pressure/dps310.c                                          |   11 
 drivers/infiniband/hw/hns/hns_roce_hem.h                               |   12 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                             |    7 
 drivers/infiniband/hw/hns/hns_roce_main.c                              |    1 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                |   15 
 drivers/infiniband/hw/hns/hns_roce_srq.c                               |    6 
 drivers/infiniband/hw/mlx5/mr.c                                        |    3 
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c                              |    8 
 drivers/input/misc/ims-pcu.c                                           |    4 
 drivers/input/misc/pm8xxx-vibrator.c                                   |    7 
 drivers/input/mouse/cyapa.c                                            |   12 
 drivers/input/serio/ioc3kbd.c                                          |   13 
 drivers/irqchip/irq-alpine-msi.c                                       |    2 
 drivers/irqchip/irq-loongson-pch-msi.c                                 |    2 
 drivers/macintosh/via-macii.c                                          |   11 
 drivers/md/md-bitmap.c                                                 |    6 
 drivers/md/raid5.c                                                     |   15 
 drivers/media/cec/core/cec-adap.c                                      |  265 +++++---
 drivers/media/cec/core/cec-api.c                                       |   29 
 drivers/media/cec/core/cec-core.c                                      |    4 
 drivers/media/cec/core/cec-pin-priv.h                                  |   11 
 drivers/media/cec/core/cec-pin.c                                       |   23 
 drivers/media/cec/core/cec-priv.h                                      |   10 
 drivers/media/dvb-frontends/lgdt3306a.c                                |    5 
 drivers/media/dvb-frontends/mxl5xx.c                                   |   22 
 drivers/media/mc/mc-devnode.c                                          |    5 
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c                          |  146 ++--
 drivers/media/pci/ngene/ngene-core.c                                   |    4 
 drivers/media/radio/radio-shark2.c                                     |    2 
 drivers/media/usb/b2c2/flexcop-usb.c                                   |   12 
 drivers/media/usb/stk1160/stk1160-video.c                              |   20 
 drivers/media/v4l2-core/v4l2-dev.c                                     |    3 
 drivers/mmc/core/host.c                                                |    3 
 drivers/mmc/core/slot-gpio.c                                           |   20 
 drivers/mmc/host/sdhci-acpi.c                                          |   48 +
 drivers/mmc/host/sdhci_am654.c                                         |  205 ++++--
 drivers/mtd/mtdcore.c                                                  |    6 
 drivers/mtd/nand/raw/nand_hynix.c                                      |    2 
 drivers/net/Makefile                                                   |    4 
 drivers/net/dsa/mv88e6xxx/chip.c                                       |   50 +
 drivers/net/dsa/mv88e6xxx/chip.h                                       |    6 
 drivers/net/dsa/mv88e6xxx/global1.c                                    |   89 ++
 drivers/net/dsa/mv88e6xxx/global1.h                                    |    2 
 drivers/net/dsa/sja1105/sja1105_main.c                                 |    9 
 drivers/net/ethernet/amazon/ena/ena_admin_defs.h                       |   16 
 drivers/net/ethernet/amazon/ena/ena_com.c                              |  330 +++-------
 drivers/net/ethernet/amazon/ena/ena_com.h                              |   13 
 drivers/net/ethernet/amazon/ena/ena_eth_com.c                          |   49 -
 drivers/net/ethernet/amazon/ena/ena_eth_com.h                          |   15 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                           |  205 +++---
 drivers/net/ethernet/amazon/ena/ena_netdev.h                           |   13 
 drivers/net/ethernet/cisco/enic/enic_main.c                            |   12 
 drivers/net/ethernet/cortina/gemini.c                                  |   12 
 drivers/net/ethernet/freescale/fec_main.c                              |   10 
 drivers/net/ethernet/freescale/fec_ptp.c                               |   14 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                           |   19 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                          |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h          |   17 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                      |    2 
 drivers/net/ethernet/qlogic/qed/qed_main.c                             |    9 
 drivers/net/ethernet/realtek/r8169_main.c                              |    9 
 drivers/net/ethernet/smsc/smc91x.h                                     |    4 
 drivers/net/ethernet/sun/sungem.c                                      |   14 
 drivers/net/ipvlan/ipvlan_core.c                                       |    4 
 drivers/net/phy/micrel.c                                               |    1 
 drivers/net/usb/aqc111.c                                               |    8 
 drivers/net/usb/qmi_wwan.c                                             |    3 
 drivers/net/usb/smsc95xx.c                                             |   26 
 drivers/net/usb/sr9700.c                                               |   10 
 drivers/net/vxlan/vxlan_core.c                                         |    4 
 drivers/net/wireless/ath/ar5523/ar5523.c                               |   14 
 drivers/net/wireless/ath/ath10k/core.c                                 |    3 
 drivers/net/wireless/ath/ath10k/debugfs_sta.c                          |    2 
 drivers/net/wireless/ath/ath10k/hw.h                                   |    1 
 drivers/net/wireless/ath/ath10k/targaddrs.h                            |    3 
 drivers/net/wireless/ath/ath10k/wmi.c                                  |   26 
 drivers/net/wireless/ath/carl9170/usb.c                                |   32 
 drivers/net/wireless/marvell/mwl8k.c                                   |    2 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c                  |   26 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c                   |   21 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h                   |   79 --
 drivers/nvme/host/multipath.c                                          |    3 
 drivers/nvme/target/configfs.c                                         |    8 
 drivers/pci/controller/dwc/pcie-tegra194.c                             |    3 
 drivers/pci/pcie/edr.c                                                 |   28 
 drivers/pwm/pwm-sti.c                                                  |   48 -
 drivers/regulator/bd71828-regulator.c                                  |   58 -
 drivers/regulator/irq_helpers.c                                        |    3 
 drivers/regulator/vqmmc-ipq4019-regulator.c                            |    1 
 drivers/s390/cio/trace.h                                               |    2 
 drivers/s390/crypto/ap_bus.c                                           |    2 
 drivers/scsi/bfa/bfad_debugfs.c                                        |    4 
 drivers/scsi/hpsa.c                                                    |    2 
 drivers/scsi/libsas/sas_expander.c                                     |    3 
 drivers/scsi/qedf/qedf_debugfs.c                                       |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                         |    2 
 drivers/scsi/qla2xxx/qla_init.c                                        |    8 
 drivers/scsi/qla2xxx/qla_mr.c                                          |   20 
 drivers/scsi/ufs/cdns-pltfrm.c                                         |    2 
 drivers/scsi/ufs/ufs-qcom.c                                            |   13 
 drivers/scsi/ufs/ufs-qcom.h                                            |   21 
 drivers/scsi/ufs/ufshcd.c                                              |    4 
 drivers/soc/mediatek/mtk-cmdq-helper.c                                 |    5 
 drivers/soc/qcom/cmd-db.c                                              |   32 
 drivers/soc/qcom/rpmh-rsc.c                                            |    3 
 drivers/soundwire/cadence_master.c                                     |    2 
 drivers/spi/spi-stm32.c                                                |    2 
 drivers/spi/spi.c                                                      |    4 
 drivers/staging/greybus/arche-apb-ctrl.c                               |    1 
 drivers/staging/greybus/arche-platform.c                               |    9 
 drivers/staging/greybus/light.c                                        |    8 
 drivers/staging/media/atomisp/pci/sh_css.c                             |    1 
 drivers/thermal/qcom/lmh.c                                             |    3 
 drivers/thermal/qcom/tsens.c                                           |    2 
 drivers/tty/n_gsm.c                                                    |  140 ++--
 drivers/tty/serial/8250/8250_bcm7271.c                                 |  101 +--
 drivers/tty/serial/max3100.c                                           |   22 
 drivers/tty/serial/sc16is7xx.c                                         |    2 
 drivers/tty/serial/sh-sci.c                                            |    5 
 drivers/usb/gadget/function/u_audio.c                                  |    2 
 drivers/video/fbdev/Kconfig                                            |    4 
 drivers/video/fbdev/savage/savagefb_driver.c                           |    5 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                                 |    2 
 drivers/video/fbdev/sis/init301.c                                      |    3 
 drivers/virt/acrn/acrn_drv.h                                           |   10 
 drivers/virt/acrn/mm.c                                                 |   70 +-
 drivers/virtio/virtio_pci_common.c                                     |    4 
 drivers/watchdog/bd9576_wdt.c                                          |   59 -
 drivers/watchdog/rti_wdt.c                                             |   34 -
 fs/afs/mntpt.c                                                         |    5 
 fs/ecryptfs/keystore.c                                                 |    4 
 fs/eventpoll.c                                                         |   38 +
 fs/ext4/mballoc.c                                                      |  134 ++--
 fs/ext4/mballoc.h                                                      |    2 
 fs/ext4/namei.c                                                        |    2 
 fs/ext4/xattr.c                                                        |    4 
 fs/f2fs/checkpoint.c                                                   |    4 
 fs/f2fs/compress.c                                                     |    2 
 fs/f2fs/data.c                                                         |    8 
 fs/f2fs/extent_cache.c                                                 |    4 
 fs/f2fs/f2fs.h                                                         |   10 
 fs/f2fs/file.c                                                         |   85 +-
 fs/f2fs/inode.c                                                        |    6 
 fs/f2fs/namei.c                                                        |    2 
 fs/f2fs/node.c                                                         |    2 
 fs/f2fs/segment.c                                                      |    2 
 fs/gfs2/glock.c                                                        |    4 
 fs/gfs2/glops.c                                                        |    3 
 fs/gfs2/util.c                                                         |    1 
 fs/jffs2/xattr.c                                                       |    3 
 fs/nfs/callback.c                                                      |    2 
 fs/nfs/internal.h                                                      |    4 
 fs/nfs/nfs4proc.c                                                      |    2 
 fs/nfs/nfs4state.c                                                     |   12 
 fs/nfsd/nfs4proc.c                                                     |    3 
 fs/nilfs2/ioctl.c                                                      |    2 
 fs/nilfs2/segment.c                                                    |   63 +
 fs/ntfs3/dir.c                                                         |    1 
 fs/ntfs3/fslog.c                                                       |    3 
 fs/ntfs3/index.c                                                       |    6 
 fs/ntfs3/inode.c                                                       |    7 
 fs/ntfs3/ntfs.h                                                        |    2 
 fs/ntfs3/record.c                                                      |   11 
 fs/ntfs3/super.c                                                       |    2 
 fs/openpromfs/inode.c                                                  |    8 
 include/drm/drm_mipi_dsi.h                                             |    6 
 include/linux/dev_printk.h                                             |   25 
 include/linux/fpga/fpga-region.h                                       |   43 +
 include/linux/mmc/slot-gpio.h                                          |    1 
 include/linux/printk.h                                                 |    2 
 include/media/cec.h                                                    |   15 
 include/net/dst_ops.h                                                  |    2 
 include/net/inet6_hashtables.h                                         |   16 
 include/net/inet_hashtables.h                                          |   18 
 include/net/netfilter/nf_tables_core.h                                 |   10 
 include/net/sock.h                                                     |   13 
 include/soc/qcom/cmd-db.h                                              |   10 
 include/trace/events/asoc.h                                            |    2 
 include/uapi/linux/bpf.h                                               |    2 
 io_uring/io_uring.c                                                    |    2 
 kernel/bpf/verifier.c                                                  |   10 
 kernel/cgroup/cpuset.c                                                 |    2 
 kernel/debug/kdb/kdb_io.c                                              |   99 +--
 kernel/dma/map_benchmark.c                                             |    6 
 kernel/irq/cpuhotplug.c                                                |   16 
 kernel/sched/core.c                                                    |    2 
 kernel/sched/fair.c                                                    |   53 +
 kernel/sched/topology.c                                                |    2 
 kernel/softirq.c                                                       |   12 
 kernel/trace/ring_buffer.c                                             |    9 
 lib/slub_kunit.c                                                       |    2 
 net/9p/client.c                                                        |    2 
 net/core/dev.c                                                         |    3 
 net/dsa/tag_sja1105.c                                                  |   34 -
 net/ipv4/inet_hashtables.c                                             |   29 
 net/ipv4/netfilter/nf_tproxy_ipv4.c                                    |    2 
 net/ipv4/route.c                                                       |   22 
 net/ipv4/tcp_dctcp.c                                                   |   13 
 net/ipv4/tcp_ipv4.c                                                    |   13 
 net/ipv4/udp.c                                                         |   55 -
 net/ipv6/inet6_hashtables.c                                            |   27 
 net/ipv6/reassembly.c                                                  |    2 
 net/ipv6/route.c                                                       |   34 -
 net/ipv6/seg6.c                                                        |    5 
 net/ipv6/seg6_hmac.c                                                   |   42 -
 net/ipv6/seg6_iptunnel.c                                               |   11 
 net/ipv6/udp.c                                                         |   61 -
 net/mptcp/protocol.h                                                   |    3 
 net/mptcp/sockopt.c                                                    |  117 +++
 net/netfilter/nfnetlink_queue.c                                        |    2 
 net/netfilter/nft_payload.c                                            |  111 ++-
 net/netrom/nr_route.c                                                  |   19 
 net/nfc/nci/core.c                                                     |   17 
 net/openvswitch/actions.c                                              |    6 
 net/openvswitch/flow.c                                                 |    3 
 net/packet/af_packet.c                                                 |    3 
 net/qrtr/ns.c                                                          |   27 
 net/sunrpc/auth_gss/svcauth_gss.c                                      |   12 
 net/sunrpc/clnt.c                                                      |    1 
 net/sunrpc/svc.c                                                       |    2 
 net/sunrpc/svc_xprt.c                                                  |    4 
 net/sunrpc/xprtrdma/verbs.c                                            |    6 
 net/tls/tls_main.c                                                     |   10 
 net/unix/af_unix.c                                                     |   30 
 net/wireless/trace.h                                                   |    4 
 net/xfrm/xfrm_policy.c                                                 |   11 
 scripts/gdb/linux/constants.py.in                                      |   12 
 scripts/kconfig/symbol.c                                               |    6 
 sound/core/init.c                                                      |   11 
 sound/core/timer.c                                                     |   10 
 sound/soc/codecs/da7219-aad.c                                          |    6 
 sound/soc/codecs/rt5645.c                                              |   25 
 sound/soc/codecs/rt715-sdca.c                                          |    8 
 sound/soc/codecs/rt715-sdw.c                                           |    1 
 sound/soc/codecs/tas2552.c                                             |   15 
 sound/soc/intel/boards/bxt_da7219_max98357a.c                          |    1 
 sound/soc/intel/boards/bxt_rt298.c                                     |    1 
 sound/soc/intel/boards/glk_rt5682_max98357a.c                          |    2 
 sound/soc/intel/boards/kbl_da7219_max98357a.c                          |    1 
 sound/soc/intel/boards/kbl_da7219_max98927.c                           |    4 
 sound/soc/intel/boards/kbl_rt5660.c                                    |    1 
 sound/soc/intel/boards/kbl_rt5663_max98927.c                           |    2 
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c                    |    1 
 sound/soc/intel/boards/skl_hda_dsp_generic.c                           |    2 
 sound/soc/intel/boards/skl_nau88l25_max98357a.c                        |    1 
 sound/soc/intel/boards/skl_rt286.c                                     |    1 
 sound/soc/kirkwood/kirkwood-dma.c                                      |    3 
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c                             |    4 
 tools/arch/x86/lib/x86-opcode-map.txt                                  |    2 
 tools/bpf/resolve_btfids/main.c                                        |    2 
 tools/include/uapi/linux/bpf.h                                         |    2 
 tools/lib/subcmd/parse-options.c                                       |    8 
 tools/testing/selftests/bpf/test_sockmap.c                             |    2 
 tools/testing/selftests/filesystems/binderfs/Makefile                  |    2 
 tools/testing/selftests/kcmp/kcmp_test.c                               |    8 
 tools/testing/selftests/net/forwarding/bridge_igmp.sh                  |    6 
 tools/testing/selftests/net/forwarding/bridge_mld.sh                   |    6 
 tools/testing/selftests/resctrl/Makefile                               |    4 
 tools/testing/selftests/syscall_user_dispatch/sud_test.c               |   14 
 tools/tracing/latency/latency-collector.c                              |    8 
 370 files changed, 3703 insertions(+), 2418 deletions(-)

Aapo Vienamo (1):
      mtd: core: Report error if first mtd_otp_size() call fails in mtd_otp_nvmem_add()

Aaron Conole (1):
      openvswitch: Set the skbuff pkt_type for proper pmtud support.

Abel Vesa (1):
      scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW version major 5

Adrian Hunter (1):
      x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map

Akiva Goldberger (1):
      net/mlx5: Discard command completions in internal error

Al Viro (1):
      parisc: add missing export of __cmpxchg_u8()

Aleksandr Aprelkov (1):
      sunrpc: removed redundant procp check

Aleksandr Burakov (1):
      media: ngene: Add dvb_ca_en50221_init return value check

Aleksandr Mishin (6):
      crypto: bcm - Fix pointer arithmetic
      cppc_cpufreq: Fix possible null pointer dereference
      thermal/drivers/tsens: Fix null pointer dereference
      ASoC: kirkwood: Fix potential NULL dereference
      drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference
      drm: vc4: Fix possible null pointer dereference

Alexander Egorenkov (2):
      s390/ipl: Fix incorrect initialization of len fields in nvme reipl block
      s390/ipl: Fix incorrect initialization of nvme dump block

Alexander Shishkin (1):
      intel_th: pci: Add Meteor Lake-S CPU support

Andrea Mayer (1):
      ipv6: sr: fix missing sk_buff release in seg6_input_core

Andreas Gruenbacher (2):
      gfs2: Don't forget to complete delayed withdraw
      gfs2: Fix "ignore unlock failures after withdraw"

Andrew Halaney (7):
      scsi: ufs: qcom: Perform read back after writing reset bit
      scsi: ufs: qcom: Perform read back after writing REG_UFS_SYS1CLK_1US
      scsi: ufs: qcom: Perform read back after writing unipro mode
      scsi: ufs: qcom: Perform read back after writing CGC enable
      scsi: ufs: cdns-pltfrm: Perform read back after writing HCLKDIV
      scsi: ufs: core: Perform read back after disabling interrupts
      scsi: ufs: core: Perform read back after disabling UIC_COMMAND_COMPL

Andy Shevchenko (5):
      media: ipu3-cio2: Use temporary storage for struct device pointer
      serial: max3100: Lock port->lock when calling uart_handle_cts_change()
      serial: max3100: Update uart_driver_registered on driver removal
      serial: max3100: Fix bitwise types
      spi: Don't mark message DMA mapped when no transfer in it is

Anna Schumaker (1):
      NFS: Fix READ_PLUS when server doesn't support OP_READ_PLUS

Anshuman Khandual (1):
      coresight: etm4x: Fix unbalanced pm_runtime_enable()

Anton Protopopov (1):
      bpf: Pack struct bpf_fib_lookup

Ard Biesheuvel (1):
      x86/purgatory: Switch to the position-independent small code model

Armin Wolf (1):
      Revert "drm/amdgpu: init iommu after amdkfd device init"

Arnd Bergmann (10):
      nilfs2: fix out-of-range warning
      crypto: ccp - drop platform ifdef checks
      qed: avoid truncating work queue length
      ACPI: disable -Wstringop-truncation
      fbdev: shmobile: fix snprintf truncation
      powerpc/fsl-soc: hide unused const variable
      fbdev: sisfb: hide unused variables
      firmware: dmi-id: add a release callback function
      greybus: arche-ctrl: move device table to its right location
      Input: ims-pcu - fix printf string overflow

Arthur Kiyanovski (2):
      net: ena: Add capabilities field with support for ENI stats capability
      net: ena: Extract recurring driver reset code into a function

Azeem Shaikh (1):
      scsi: qla2xxx: Replace all non-returning strlcpy() with strscpy()

Baochen Qiang (1):
      wifi: ath10k: poll service ready message before failing

Baokun Li (2):
      ext4: set type of ac_groups_linear_remaining to __u32 to avoid overflow
      ext4: fix mb_cache_entry's e_refcnt leak in ext4_xattr_block_cache_find()

Benjamin Coddington (1):
      NFSv4: Fixup smatch warning for ambiguous return

Bitterblue Smith (3):
      wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
      wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
      wifi: rtlwifi: rtl8192de: Fix endianness issue in RX path

Bob Zhou (1):
      drm/amdgpu: add error handle to avoid out-of-bounds

Breno Leitao (1):
      af_unix: Fix data races in unix_release_sock/unix_stream_sendmsg

Brian Kubisiak (1):
      ecryptfs: Fix buffer size for tag 66 packet

Bui Quang Minh (2):
      scsi: bfa: Ensure the copied buf is NUL terminated
      scsi: qedf: Ensure the copied buf is NUL terminated

Cai Xinchen (1):
      fbdev: savage: Handle err return when savagefb_check_var failed

Carolina Jubran (1):
      net/mlx5e: Use rx_missed_errors instead of rx_dropped for reporting buffer exhaustion

Cezary Rojewski (1):
      ASoC: Intel: Disable route checks for Skylake boards

Chao Yu (9):
      f2fs: fix to wait on page writeback in __clone_blkaddrs()
      f2fs: compress: fix to relocate check condition in f2fs_{release,reserve}_compress_blocks()
      f2fs: compress: fix to relocate check condition in f2fs_ioc_{,de}compress_file()
      f2fs: fix to relocate check condition in f2fs_fallocate()
      f2fs: fix to check pinfile flag in f2fs_move_file_range()
      f2fs: compress: fix to cover {reserve,release}_compress_blocks() w/ cp_rwsem lock
      f2fs: fix to release node block count in error path of f2fs_new_node_page()
      f2fs: compress: don't allow unaligned truncation on released compress inode
      f2fs: fix to do sanity check on i_xattr_nid in sanity_check_inode()

Chen Ni (2):
      HID: intel-ish-hid: ipc: Add check for pci_alloc_irq_vectors
      dmaengine: idma64: Add check for dma_set_max_seg_size

Cheng Yu (1):
      sched/core: Fix incorrect initialization of the 'burst' parameter in cpu_max_write()

Chengchang Tang (4):
      RDMA/hns: Fix deadlock on SRQ async events.
      RDMA/hns: Fix GMV table pagesize
      RDMA/hns: Use complete parentheses in macros
      RDMA/hns: Modify the print level of CQE error

Chris Lew (1):
      net: qrtr: ns: Fix module refcnt

Chris Wulff (1):
      usb: gadget: u_audio: Clear uac pointer when freed.

Christian Hewitt (1):
      drm/meson: vclk: fix calculation of 59.94 fractional rates

Christoffer Sandberg (1):
      ACPI: resource: Do IRQ override on TongFang GXxHRXx and GMxHGxx

Christoph Hellwig (1):
      virt: acrn: stop using follow_pfn

Christophe JAILLET (1):
      ppdev: Remove usage of the deprecated ida_simple_xx() API

Chuck Lever (2):
      SUNRPC: Fix gss_free_in_token_pages()
      SUNRPC: Fix loop termination condition in gss_free_in_token_pages()

Chun-Kuang Hu (1):
      soc: mediatek: cmdq: Fix typo of CMDQ_JUMP_RELATIVE

Clément Léger (1):
      selftests: sud_test: return correct emulated syscall value on RISC-V

Dae R. Jeong (1):
      tls: fix missing memory barrier in tls_init

Dan Aloni (2):
      sunrpc: fix NFSACL RPC retry on soft mount
      rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL

Dan Carpenter (5):
      speakup: Fix sizeof() vs ARRAY_SIZE() bug
      wifi: mwl8k: initialize cmd->addr[] properly
      ext4: fix potential unnitialized variable
      stm class: Fix a double free in stm_register_device()
      media: stk1160: fix bounds checking in stk1160_copy_video()

Daniel Borkmann (1):
      vxlan: Fix regression when dropping packets due to invalid src addresses

Daniel J Blueman (1):
      x86/tsc: Trust initial offset in architectural TSC-adjust MSRs

Daniel Starke (2):
      tty: n_gsm: fix possible out-of-bounds in gsm0_receive()
      tty: n_gsm: fix missing receive state reset after mode switch

Daniel Thompson (5):
      kdb: Fix buffer overflow during tab-complete
      kdb: Use format-strings rather than '\0' injection in kdb_read()
      kdb: Fix console handling when editing and tab-completing commands
      kdb: Merge identical case statements in kdb_read()
      kdb: Use format-specifiers rather than memset() for padding in kdb_read()

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN920C04 compositions

David Arinzon (3):
      net: ena: Add dynamic recycling mechanism for rx buffers
      net: ena: Reduce lines with longer column width boundary
      net: ena: Fix DMA syncing in XDP path when SWIOTLB is on

David Hildenbrand (1):
      drivers/virt/acrn: fix PFNMAP PTE checks in acrn_vm_ram_map()

Derek Fang (2):
      ASoC: rt5645: Fix the electric noise due to the CBJ contacts floating
      ASoC: dt-bindings: rt5645: add cbj sleeve gpio property

Dmitry Baryshkov (2):
      wifi: ath10k: populate board data for WCN3990
      drm/mipi-dsi: use correct return type for the DSC functions

Dmitry Torokhov (1):
      watchdog: bd9576_wdt: switch to using devm_fwnode_gpiod_get()

Dongli Zhang (1):
      genirq/cpuhotplug, x86/vector: Prevent vector leak during CPU offline

Dongliang Mu (1):
      media: flexcop-usb: fix sanity check of bNumEndpoints

Doug Berger (1):
      serial: 8250_bcm7271: use default_mux_rate if possible

Duoming Zhou (1):
      um: Fix return value in ubd_init()

Edward Liaw (1):
      selftests/kcmp: remove unused open mode

Eric Biggers (3):
      crypto: x86/nh-avx2 - add missing vzeroupper
      crypto: x86/sha256-avx2 - add missing vzeroupper
      crypto: x86/sha512-avx2 - add missing vzeroupper

Eric Dumazet (9):
      tcp: avoid premature drops in tcp_add_backlog()
      net: give more chances to rcu in netdev_wait_allrefs_any()
      usb: aqc111: stop lying about skb->truesize
      net: usb: sr9700: stop lying about skb->truesize
      net: usb: smsc95xx: stop lying about skb->truesize
      netrom: fix possible dead-lock in nr_rt_ioctl()
      af_packet: do not call packet_read_pending() from tpacket_destruct_skb()
      netfilter: nfnetlink_queue: acquire rcu_read_lock() in instance_destroy_rcu()
      net: fix __dst_negative_advice() race

Eric Sandeen (1):
      openpromfs: finish conversion to the new mount API

Fabio Estevam (1):
      media: dt-bindings: ovti,ov2680: Fix the power supply names

Fabio M. De Francesco (1):
      f2fs: Delete f2fs_copy_page() and replace with memcpy_page()

Fedor Pchelkin (2):
      dma-mapping: benchmark: fix node id validation
      dma-mapping: benchmark: handle NUMA_NO_NODE correctly

Fenglin Wu (1):
      Input: pm8xxx-vibrator - correct VIB_MAX_LEVELS calculation

Finn Thain (2):
      macintosh/via-macii: Fix "BUG: sleeping function called from invalid context"
      m68k: mac: Fix reboot hang on Mac IIci

Florian Fainelli (2):
      net: Always descend into dsa/ folder with CONFIG_NET_DSA enabled
      scripts/gdb: fix SB_* constants parsing

Florian Westphal (2):
      netfilter: nft_payload: rebuild vlan header on h_proto access
      netfilter: tproxy: bail out if IP has been disabled on the device

Frank Li (1):
      i3c: master: svc: fix invalidate IBI type and miss call client IBI handler

Friedrich Vock (1):
      bpf: Fix potential integer overflow in resolve_btfids

Gabriel Krisman Bertazi (1):
      udp: Avoid call to compute_score on multiple sites

Gautam Menghani (1):
      selftests/kcmp: Make the test output consistent and clear

Geert Uytterhoeven (4):
      sh: kprobes: Merge arch_copy_kprobe() into arch_prepare_kprobe()
      printk: Let no_printk() use _printk()
      dev_printk: Add and use dev_no_printk()
      dt-bindings: PCI: rcar-pci-host: Add missing IOMMU properties

Geliang Tang (1):
      selftests/bpf: Fix umount cgroup2 error in test_sockmap

Gerd Hoffmann (1):
      KVM: x86: Don't advertise guest.MAXPHYADDR as host.MAXPHYADDR in CPUID

Greg Kroah-Hartman (1):
      Linux 5.15.161

Guenter Roeck (3):
      mm/slub, kunit: Use inverted data to corrupt kmem cache
      Revert "sh: Handle calling csum_partial with misaligned data"
      hwmon: (shtc1) Fix property misspelling

Guixiong Wei (1):
      x86/boot: Ignore relocations in .notes sections in walk_relocs() too

Guo Ren (1):
      riscv: stacktrace: Make walk_stackframe cross pt_regs frame

Hangbin Liu (4):
      ipv6: sr: add missing seg6_local_exit
      ipv6: sr: fix incorrect unregister order
      ipv6: sr: fix invalid unregister error path
      ipv6: sr: fix memleak in seg6_hmac_init_algo

Hans Verkuil (12):
      media: cec: cec-adap: always cancel work in cec_transmit_msg_fh
      media: cec: cec-api: add locking in cec_release()
      media: cec: call enable_adap on s_log_addrs
      media: cec: abort if the current transmit was canceled
      media: cec: correctly pass on reply results
      media: cec: use call_op and check for !unregistered
      media: cec-adap.c: drop activate_cnt, use state info instead
      media: cec: core: avoid recursive cec_claim_log_addrs
      media: cec: core: avoid confusing "transmit timed out" message
      media: cec: core: add adap_nb_transmit_canceled() callback
      media: mc: mark the media devnode as registered from the, start
      media: v4l2-core: hold videodev_lock until dev reg, finishes

Hans de Goede (4):
      mmc: core: Add mmc_gpiod_set_cd_config() function
      mmc: sdhci-acpi: Sort DMI quirks alphabetically
      mmc: sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not working
      mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A

Harald Freudenberger (3):
      s390/ap: Fix crash in AP internal function modify_bitmap()
      s390/cpacf: Split and rework cpacf query functions
      s390/cpacf: Make use of invalid opcode produce a link error

Heiko Carstens (1):
      s390/vdso: Use standard stack frame layout

Heiner Kallweit (1):
      Revert "r8169: don't try to disable interrupts if NAPI is, scheduled already"

Herbert Xu (1):
      crypto: qat - Fix ADF_DEV_RESET_SYNC memory leak

Himanshu Madhani (1):
      scsi: qla2xxx: Fix debugfs output for fw_resource_count

Hsin-Te Yuan (1):
      ASoC: mediatek: mt8192: fix register configuration for tdm

Huai-Yuan Liu (2):
      drm/arm/malidp: fix a possible null pointer dereference
      ppdev: Add an error check in register_device

Hugo Villeneuve (1):
      serial: sc16is7xx: add proper sched.h include for sched_set_fifo()

Hyeonggon Yoo (1):
      net: ena: Do not waste napi skb cache

Ian Rogers (1):
      libsubcmd: Fix parse-options memory leak

Igor Artemiev (1):
      wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class

Ilpo Järvinen (1):
      EDAC/igen6: Convert PCIBIOS_* return codes to errnos

Ilya Denisyev (1):
      jffs2: prevent xattr node from overflowing the eraseblock

Ilya Leoshkevich (1):
      s390/bpf: Emit a barrier for BPF_FETCH instructions

Ilya Maximets (1):
      net: openvswitch: fix overwriting ct original tuple for ICMPv6

Jack Yu (2):
      ASoC: rt715: add vendor clear control register
      ASoC: rt715-sdca: volume step modification

Jaegeuk Kim (1):
      f2fs: do not allow partial truncation on pinned file

Jakub Kicinski (1):
      eth: sungem: remove .ndo_poll_controller to avoid deadlocks

Jakub Sitnicki (1):
      bpf: Allow delete from sockmap/sockhash only if update is allowed

James Clark (2):
      coresight: no-op refactor to make INSTP0 check more idiomatic
      coresight: etm4x: Cleanup TRCIDR0 register accesses

Jan Kara (1):
      ext4: avoid excessive credit estimate in ext4_tmpfile()

Jens Remus (1):
      s390/vdso: Generate unwind information for C modules

Jiangfeng Xiao (1):
      arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY

Jinyoung CHOI (1):
      f2fs: fix typos in comments

Jiri Pirko (1):
      virtio: delete vq in vp_find_vqs_msix() when request_irq() fails

Johan Hovold (2):
      media: flexcop-usb: clean up endpoint sanity checks
      arm64: dts: qcom: qcs404: fix bluetooth device address

Johannes Berg (1):
      um: vector: fix bpfflash parameter evaluation

John Hubbard (2):
      selftests/binderfs: use the Makefile's rules, not Make's implicit rules
      selftests/resctrl: fix clang build failure: use LOCAL_HDRS

Jorge Ramirez-Ortiz (1):
      mmc: core: Do not force a retune before RPMB switch

Joshua Ashton (1):
      drm/amd/display: Set color_mgmt_changed to true on unsuspend

Judith Mendez (6):
      mmc: sdhci_am654: Add tuning algorithm for delay chain
      mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
      mmc: sdhci_am654: Add OTAP/ITAP delay enable
      mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
      mmc: sdhci_am654: Fix ITAPDLY for HS400 timing
      watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate a safety margin

Justin Green (1):
      drm/mediatek: Add 0 size check to mtk_drm_gem_obj

Karel Balej (1):
      Input: ioc3kbd - add device table

Kemeng Shi (4):
      ext4: simplify calculation of blkoff in ext4_mb_new_blocks_simple
      ext4: fix unit mismatch in ext4_mb_new_blocks_simple
      ext4: try all groups in ext4_mb_new_blocks_simple
      ext4: remove unused parameter from ext4_mb_new_blocks_simple()

Ken Milmore (1):
      r8169: Fix possible ring buffer corruption on fragmented Tx packets.

Konrad Dybcio (1):
      thermal/drivers/qcom/lmh: Check for SCM availability at probe

Konstantin Komarov (6):
      fs/ntfs3: Remove max link count info display during driver init
      fs/ntfs3: Taking DOS names into account during link counting
      fs/ntfs3: Fix case when index is reused during tree transformation
      fs/ntfs3: Break dir enumeration if directory contents error
      fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
      fs/ntfs3: Use variable length array instead of fixed size

Krzysztof Kozlowski (2):
      regulator: vqmmc-ipq4019: fix module autoloading
      arm64: tegra: Correct Tegra132 I2C alias

Kuniyuki Iwashima (2):
      af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
      tcp: Fix shift-out-of-bounds in dctcp_update_alpha().

Kuppuswamy Sathyanarayanan (2):
      PCI/EDR: Align EDR_PORT_DPC_ENABLE_DSM with PCI Firmware r3.3
      PCI/EDR: Align EDR_PORT_LOCATE_DSM with PCI Firmware r3.3

Lancelot SIX (1):
      drm/amdkfd: Flush the process wq before creating a kfd_process

Larysa Zaremba (1):
      ice: Interpret .set_channels() input differently

Laurent Pinchart (1):
      firmware: raspberrypi: Use correct device for DMA mappings

Len Baker (1):
      virt: acrn: Prefer array_size and struct_size over open coded arithmetic

Leon Romanovsky (1):
      RDMA/IPoIB: Fix format truncation compilation errors

Li Ma (1):
      drm/amdgpu/atomfirmware: add intergrated info v2.3 table

Linus Torvalds (2):
      x86/mm: Remove broken vsyscall emulation code from the page fault code
      epoll: be better about file lifetimes

Linus Walleij (1):
      net: ethernet: cortina: Locking fixes

Lorenz Bauer (2):
      net: export inet_lookup_reuseport and inet6_lookup_reuseport
      net: remove duplicate reuseport_lookup functions

Manivannan Sadhasivam (1):
      scsi: ufs: ufs-qcom: Fix the Qcom register name for offset 0xD0

Marc Dionne (1):
      afs: Don't cross .backup mountpoint from backup volume

Marc Gonzalez (1):
      clk: qcom: mmcc-msm8998: fix venus clock issue

Marc Zyngier (2):
      KVM: arm64: Fix AArch32 register narrowing on userspace write
      KVM: arm64: Allow AArch32 PSTATE.M to be restored as System mode

Marco Pagani (1):
      fpga: region: add owner module and take its refcount

Marek Szyprowski (1):
      Input: cyapa - add missing input core locking to suspend/resume functions

Marek Vasut (1):
      drm/panel: simple: Add missing Innolux G121X1-L03 format, flags, connector

Marijn Suijten (2):
      drm/msm/dsi: Print dual-DSI-adjusted pclk instead of original mode pclk
      drm/msm/dpu: Always flush the slave INTF on the CTL

Masahiro Yamada (2):
      x86/kconfig: Select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y
      kconfig: fix comparison to constant symbols, 'm', 'n'

Mathieu Othacehe (1):
      net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ8061

Matthew Bystrin (1):
      riscv: stacktrace: fixed walk_stackframe()

Matthias Schiffer (2):
      net: dsa: mv88e6xxx: Add support for model-specific pre- and post-reset handlers
      net: dsa: mv88e6xxx: Avoid EEPROM timeout without EEPROM on 88E6250-family switches

Matthieu Baerts (NGI0) (2):
      mptcp: SO_KEEPALIVE: fix getsockopt support
      mptcp: fix full TCP keep-alive support

Matti Vaittinen (3):
      regulator: irq_helpers: duplicate IRQ name
      watchdog: bd9576: Drop "always-running" property
      regulator: bd71828: Don't overwrite runtime voltages

Maulik Shah (1):
      soc: qcom: rpmh-rsc: Enhance check for VRM in-flight request

Maxim Korotkov (1):
      mtd: rawnand: hynix: fixed typo

Michael Schmitz (1):
      m68k: Fix spinlock race in kernel thread creation

Michael Walle (1):
      drm/bridge: tc358775: fix support for jeida-18 and jeida-24

Michal Simek (2):
      microblaze: Remove gcc flag for non existing early_printk.c file
      microblaze: Remove early printk call from cpuinfo-static.c

Mike Gilbert (1):
      sparc: move struct termio to asm/termios.h

Ming Lei (1):
      io_uring: fail NOP if non-zero op flags is passed in

Nathan Chancellor (1):
      media: mxl5xx: Move xpt structures off stack

Neil Armstrong (1):
      scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW major version > 5

NeilBrown (1):
      sunrpc: exclude from freezer when waiting for requests:

Nikita Zhandarovich (3):
      wifi: carl9170: add a proper sanity check for endpoints
      wifi: ar5523: enable proper endpoint verification
      net/9p: fix uninit-value in p9_client_rpc()

Nikolay Aleksandrov (1):
      selftests: net: bridge: increase IGMP/MLD exclude timeout membership interval

Nilay Shroff (1):
      nvme: find numa distance only if controller has valid numa id

Nícolas F. R. A. Prado (3):
      drm/bridge: lt8912b: Don't log an error when DSI host can't be found
      drm/bridge: lt9611: Don't log an error when DSI host can't be found
      drm/bridge: tc358775: Don't log an error when DSI host can't be found

Or Har-Toov (1):
      RDMA/mlx5: Adding remote atomic access flag to updatable flags

Pablo Neira Ayuso (4):
      netfilter: nft_payload: restore vlan q-in-q match support
      netfilter: nft_payload: move struct nft_payload_set definition where it belongs
      netfilter: nft_payload: rebuild vlan header when needed
      netfilter: nft_payload: skbuff vlan metadata mangle support

Parthiban Veerasooran (1):
      net: usb: smsc95xx: fix changing LED_SEL bit value updated from EEPROM

Peter Oberparleiter (1):
      s390/cio: fix tracepoint subchannel type field

Petr Pavlu (1):
      ring-buffer: Fix a race between readers and resize checks

Pierre-Louis Bossart (2):
      ASoC: da7219-aad: fix usage of device_get_named_child_node()
      soundwire: cadence: fix invalid PDI offset

Rafael J. Wysocki (3):
      cpufreq: Reorganize checks in cpufreq_offline()
      cpufreq: Split cpufreq_offline()
      cpufreq: Rearrange locking in cpufreq_remove_dev()

Rafał Miłecki (1):
      dt-bindings: pinctrl: mediatek: mt7622: fix array properties

Rahul Rameshbabu (1):
      net/mlx5e: Fix IPsec tunnel mode offload feature check

Randy Dunlap (2):
      fbdev: sh7760fb: allow modular build
      extcon: max8997: select IRQ_DOMAIN instead of depending on it

Ricardo Ribalda (1):
      media: radio-shark2: Avoid led_names truncations

Rob Herring (1):
      dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node

Roberto Sassu (1):
      um: Add winch to winch_handlers before registering winch IRQ

Roded Zats (1):
      enic: Validate length of nl attributes in enic_set_vf_port

Rui Miguel Silva (1):
      greybus: lights: check return of get_channel_from_mode

Russ Weight (1):
      fpga: region: Use standard dev_release for class driver

Ryosuke Yasuoka (2):
      nfc: nci: Fix uninit-value in nci_rx_work
      nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()

Ryusuke Konishi (3):
      nilfs2: fix unexpected freezing of nilfs_segctor_sync()
      nilfs2: fix potential hang in nilfs_detach_log_writer()
      nilfs2: fix use-after-free of timer for log writer thread

Sagi Grimberg (1):
      nvmet: fix ns enable/disable possible hang

Sakari Ailus (1):
      media: ipu3-cio2: Request IRQ earlier

Sam Ravnborg (1):
      sparc64: Fix number of online CPUs

Sergey Shtylyov (2):
      ata: pata_legacy: make legacy_exit() work again
      nfs: fix undefined behavior in nfs_block_bits()

Shay Agroskin (1):
      net: ena: Fix redundant device NUMA node override

Shenghao Ding (1):
      ASoC: tas2552: Add TX path for capturing AUDIO-OUT data

Shradha Gupta (2):
      drm: Check output polling initialized before disabling
      drm: Check polling initialized before enabling in drm_helper_probe_single_connector_modes

Shrikanth Hegde (2):
      sched/fair: Add EAS checks before updating root_domain::overutilized
      powerpc/pseries: Add failure related checks for h_get_mpp and h_get_ppp

Shuah Khan (1):
      tools/latency-collector: Fix -Wformat-security compile warns

Srinivasan Shanmugam (1):
      drm/amd/display: Fix potential index out of bounds in color transformation function

Stefan Berger (1):
      crypto: ecdsa - Fix module auto-load on add-key

Steven Rostedt (1):
      ASoC: tracing: Export SND_SOC_DAPM_DIR_OUT to its value

Su Hui (1):
      wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()

Sumanth Korikkar (2):
      s390/vdso: filter out mno-pic-data-is-text-relative cflag
      s390/vdso64: filter out munaligned-symbols flag for vdso

Suzuki K Poulose (4):
      coresight: etm4x: Do not hardcode IOMEM access for register restore
      coresight: etm4x: Do not save/restore Data trace control registers
      coresight: etm4x: Safe access for TRCQCLTR
      coresight: etm4x: Fix access to resource selector registers

Sven Schnelle (1):
      s390/boot: Remove alt_stfle_fac_list from decompressor

Takashi Iwai (3):
      ALSA: core: Fix NULL module pointer assignment at card init
      ALSA: Fix deadlocks with kctl removals at disconnection
      ALSA: timer: Set lower bound of start tick time

Tetsuo Handa (2):
      nfc: nci: Fix kcov check in nci_rx_work()
      dma-buf/sw-sync: don't enable IRQ from sync_print_obj()

Thomas Haemmerle (1):
      iio: pressure: dps310: support negative temperature values

Thorsten Blum (1):
      net: smc91x: Fix m68k kernel compilation for ColdFire CPU

Tiwei Bie (1):
      um: Fix the -Wmissing-prototypes warning for __switch_mm

Uwe Kleine-König (5):
      pwm: sti: Convert to platform remove callback returning void
      pwm: sti: Prepare removing pwm_chip from driver data
      pwm: sti: Simplify probe function using devm functions
      Input: ioc3kbd - convert to platform remove callback returning void
      spi: stm32: Don't warn about spurious interrupts

Vidya Sagar (1):
      PCI: tegra194: Fix probe path for Endpoint mode

Vignesh Raghavendra (1):
      mmc: sdhci_am654: Drop lookup for deprecated ti,otap-del-sel

Viresh Kumar (1):
      cpufreq: exit() callback is optional

Vitalii Bursov (1):
      sched/fair: Allow disabling sched_balance_newidle with sched_relax_domain_level

Vitaly Chikunov (1):
      crypto: ecrdsa - Fix module auto-load on add_key

Vladimir Oltean (2):
      net: dsa: sja1105: always enable the INCL_SRCPT option
      net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT

Wei Fang (1):
      net: fec: avoid lock evasion when reading pps_enable

Wolfram Sang (2):
      dt-bindings: PCI: rcar-pci-host: Add optional regulators
      serial: sh-sci: protect invalidating RXDMA on shutdown

Xiaolei Wang (1):
      net:fec: Add fec_enet_deinit()

Xingui Yang (1):
      scsi: libsas: Fix the failure of adding phy with zero-address to port

Yang Xiwen (1):
      arm64: dts: hi3798cv200: fix the size of GICR

Yangtao Li (1):
      f2fs: convert to use sbi directly

Yu Kuai (2):
      md: fix resync softlockup when bitmap size is less than array size
      md/raid5: fix deadlock that raid5d() wait for itself to clear MD_SB_CHANGE_PENDING

Yue Haibing (1):
      ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound

Yuri Karpov (1):
      scsi: hpsa: Fix allocation size for Scsi_Host private data

Zenghui Yu (2):
      irqchip/alpine-msi: Fix off-by-one in allocation error path
      irqchip/loongson-pch-msi: Fix off-by-one on allocation error path

Zhengchao Shao (1):
      RDMA/hns: Fix return value in hns_roce_map_mr_sg

Zheyu Ma (1):
      media: lgdt3306a: Add a check against null-pointer-def

Zhipeng Lu (1):
      media: atomisp: ssh_css: Fix a null-pointer dereference in load_video_binaries

Zhu Yanjun (2):
      null_blk: Fix missing mutex_destroy() at module removal
      null_blk: Fix the WARNING: modpost: missing MODULE_DESCRIPTION()

Zqiang (1):
      softirq: Fix suspicious RCU usage in __do_softirq()

gaoxingwang (1):
      net: ipv6: fix wrong start position when receive hop-by-hop fragment

xu xin (1):
      net/ipv6: Fix route deleting failure when metric equals 0


