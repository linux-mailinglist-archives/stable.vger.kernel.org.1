Return-Path: <stable+bounces-58115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D39282B8
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 09:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EF22881EB
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E214535B;
	Fri,  5 Jul 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eQAl2/T1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002E144D31;
	Fri,  5 Jul 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720164653; cv=none; b=IEsWzMM9Q//mPW7sCKv2qWeGx+yUJajthvzL1FETR1Qzf5YqSc0Sb4KknNij4p1DHOuSsaoFoPVIob1RTzLkKmr+LHNGiTN6oH6Esvi6kul5Gwp4ipPDNPL3NV10P9IK/wS7bVVZNWNWZgc4K/Xq5yYhTtLcyGYzUb45+olZrZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720164653; c=relaxed/simple;
	bh=Xu8ZNhToZHM9VoNe71dhd8c78Nyqa11fV9TRAdC31wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MisYrS0FBBZXFVq775RhGzhQkyOOKzqT3TZKD62M0HCVqHHIohsyjVCJs4CHPMXVLXrz++k4TaCF1wYOPGO1bFSIbb6COoWAMVwsiKHO9/ZalTePIPYZCeTAloQ2y+rUJz8jslhYBWj0wc0vkqAzwf1rolBbuvpVZctOLTIYaXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eQAl2/T1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B6EC116B1;
	Fri,  5 Jul 2024 07:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720164653;
	bh=Xu8ZNhToZHM9VoNe71dhd8c78Nyqa11fV9TRAdC31wo=;
	h=From:To:Cc:Subject:Date:From;
	b=eQAl2/T1Eys8oG8vg8unaIeILcPfvljTzrRBbjZHD//ylflB2YLuKaT7jQFePXjfM
	 coYATLOqfhPjD0u+Q2p7ELSoYQ2AHRa0NQsHgLrr6jTplJAvOB3R7ux5cPZWEdQoGV
	 ibdmSFBMBE+4Nw2UthiXdh6iVEvlC/veQ5x/r+7M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.162
Date: Fri,  5 Jul 2024 09:30:36 +0200
Message-ID: <2024070536-regulator-thriving-2390@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.162 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml |    2 
 Makefile                                                             |    7 
 arch/arm/boot/dts/exynos4210-smdkv310.dts                            |    2 
 arch/arm/boot/dts/exynos4412-origen.dts                              |    2 
 arch/arm/boot/dts/exynos4412-smdk4412.dts                            |    2 
 arch/arm/boot/dts/rk3066a.dtsi                                       |    1 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                         |    2 
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts                    |    4 
 arch/arm64/boot/dts/rockchip/rk3368.dtsi                             |    3 
 arch/arm64/include/asm/kvm_host.h                                    |    1 
 arch/arm64/include/asm/unistd32.h                                    |    2 
 arch/arm64/kvm/arm.c                                                 |    6 
 arch/arm64/kvm/vgic/vgic-v3.c                                        |    2 
 arch/arm64/kvm/vgic/vgic-v4.c                                        |    8 
 arch/csky/include/uapi/asm/unistd.h                                  |    1 
 arch/hexagon/include/asm/syscalls.h                                  |    6 
 arch/hexagon/include/uapi/asm/unistd.h                               |    1 
 arch/hexagon/kernel/syscalltab.c                                     |    7 
 arch/mips/bmips/setup.c                                              |    3 
 arch/mips/kernel/syscalls/syscall_n32.tbl                            |    2 
 arch/mips/kernel/syscalls/syscall_o32.tbl                            |    2 
 arch/mips/pci/ops-rc32434.c                                          |    4 
 arch/mips/pci/pcie-octeon.c                                          |    6 
 arch/parisc/Kconfig                                                  |    1 
 arch/parisc/kernel/sys_parisc32.c                                    |    9 
 arch/parisc/kernel/syscalls/syscall.tbl                              |    6 
 arch/powerpc/include/asm/fadump-internal.h                           |    5 
 arch/powerpc/include/asm/hvcall.h                                    |    8 
 arch/powerpc/include/asm/io.h                                        |   24 
 arch/powerpc/include/asm/uaccess.h                                   |   15 
 arch/powerpc/kernel/fadump.c                                         |    2 
 arch/powerpc/kernel/syscalls/syscall.tbl                             |    2 
 arch/riscv/mm/init.c                                                 |   58 --
 arch/s390/kernel/syscalls/syscall.tbl                                |    2 
 arch/sh/kernel/sys_sh32.c                                            |   11 
 arch/sh/kernel/syscalls/syscall.tbl                                  |    3 
 arch/sparc/kernel/sys32.S                                            |  221 --------
 arch/sparc/kernel/syscalls/syscall.tbl                               |    8 
 arch/x86/entry/syscalls/syscall_32.tbl                               |    2 
 arch/x86/include/asm/cpu_device_id.h                                 |   98 +++
 arch/x86/include/asm/efi.h                                           |   11 
 arch/x86/kernel/amd_nb.c                                             |    9 
 arch/x86/kernel/cpu/match.c                                          |    4 
 arch/x86/kernel/fpu/core.c                                           |    4 
 arch/x86/kernel/kprobes/core.c                                       |   11 
 arch/x86/kernel/time.c                                               |   20 
 arch/x86/kvm/x86.c                                                   |    9 
 arch/x86/platform/efi/Makefile                                       |    3 
 arch/x86/platform/efi/efi.c                                          |    8 
 arch/x86/platform/efi/memmap.c                                       |  249 +++++++++
 block/ioctl.c                                                        |    2 
 crypto/ecdh.c                                                        |    2 
 drivers/acpi/acpica/exregion.c                                       |   23 
 drivers/acpi/video_detect.c                                          |    8 
 drivers/acpi/x86/utils.c                                             |   23 
 drivers/ata/ahci.c                                                   |   17 
 drivers/ata/libata-core.c                                            |    8 
 drivers/base/core.c                                                  |    3 
 drivers/block/null_blk/zoned.c                                       |    2 
 drivers/bluetooth/ath3k.c                                            |   25 
 drivers/bluetooth/btqca.c                                            |  186 +++++-
 drivers/bluetooth/btqca.h                                            |   36 -
 drivers/bluetooth/hci_qca.c                                          |  266 +++++++---
 drivers/clk/sifive/sifive-prci.c                                     |    8 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                           |    4 
 drivers/dma/dma-axi-dmac.c                                           |    2 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                       |    6 
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h                                |    1 
 drivers/dma/idxd/irq.c                                               |    4 
 drivers/dma/ioat/init.c                                              |   75 +-
 drivers/dma/ioat/registers.h                                         |    7 
 drivers/firmware/efi/fdtparams.c                                     |    4 
 drivers/firmware/efi/memmap.c                                        |  239 --------
 drivers/gpio/Kconfig                                                 |    2 
 drivers/gpio/gpio-davinci.c                                          |    5 
 drivers/gpio/gpio-tqmx86.c                                           |   46 -
 drivers/gpio/gpiolib-cdev.c                                          |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                             |   18 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c            |  144 ++---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c          |    6 
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c                            |    2 
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c           |    2 
 drivers/gpu/drm/bridge/panel.c                                       |    7 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                             |    7 
 drivers/gpu/drm/exynos/exynos_hdmi.c                                 |    7 
 drivers/gpu/drm/i915/display/intel_dp.c                              |    4 
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c                          |   16 
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c                         |    1 
 drivers/gpu/drm/lima/lima_bcast.c                                    |   12 
 drivers/gpu/drm/lima/lima_bcast.h                                    |    3 
 drivers/gpu/drm/lima/lima_gp.c                                       |    8 
 drivers/gpu/drm/lima/lima_pp.c                                       |   18 
 drivers/gpu/drm/lima/lima_sched.c                                    |    7 
 drivers/gpu/drm/lima/lima_sched.h                                    |    1 
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c                            |    6 
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c                        |    6 
 drivers/gpu/drm/panel/panel-simple.c                                 |    1 
 drivers/gpu/drm/radeon/radeon.h                                      |    1 
 drivers/gpu/drm/radeon/radeon_display.c                              |    8 
 drivers/gpu/drm/radeon/sumo_dpm.c                                    |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                                  |    7 
 drivers/greybus/interface.c                                          |    1 
 drivers/hid/hid-core.c                                               |    1 
 drivers/hid/hid-ids.h                                                |    1 
 drivers/hid/hid-logitech-dj.c                                        |    4 
 drivers/hid/hid-multitouch.c                                         |    6 
 drivers/hwtracing/intel_th/pci.c                                     |   25 
 drivers/i2c/busses/i2c-at91-slave.c                                  |    3 
 drivers/i2c/busses/i2c-designware-slave.c                            |    2 
 drivers/i2c/busses/i2c-ocores.c                                      |    2 
 drivers/i2c/i2c-core-acpi.c                                          |   30 -
 drivers/i2c/i2c-core-base.c                                          |   98 +++
 drivers/i2c/i2c-core-of.c                                            |   66 --
 drivers/i2c/i2c-slave-testunit.c                                     |    5 
 drivers/iio/accel/Kconfig                                            |    2 
 drivers/iio/accel/mxc4005.c                                          |   68 ++
 drivers/iio/adc/ad7266.c                                             |    2 
 drivers/iio/adc/ad9467.c                                             |    4 
 drivers/iio/chemical/bme680.h                                        |    2 
 drivers/iio/chemical/bme680_core.c                                   |   62 ++
 drivers/iio/dac/ad5592r-base.c                                       |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                    |    4 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                     |    4 
 drivers/infiniband/core/restrack.c                                   |   51 -
 drivers/infiniband/hw/mlx5/srq.c                                     |   13 
 drivers/input/input.c                                                |  105 +++
 drivers/input/touchscreen/ili210x.c                                  |    4 
 drivers/iommu/amd/amd_iommu_types.h                                  |   24 
 drivers/iommu/amd/init.c                                             |   55 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                          |    2 
 drivers/md/bcache/bset.c                                             |   44 -
 drivers/md/bcache/bset.h                                             |   28 -
 drivers/md/bcache/btree.c                                            |   40 -
 drivers/md/bcache/super.c                                            |    5 
 drivers/md/bcache/sysfs.c                                            |    2 
 drivers/md/bcache/writeback.c                                        |   10 
 drivers/media/dvb-core/dvbdev.c                                      |    2 
 drivers/misc/mei/pci-me.c                                            |    4 
 drivers/misc/pvpanic/pvpanic-mmio.c                                  |   59 --
 drivers/misc/pvpanic/pvpanic-pci.c                                   |   80 ---
 drivers/misc/pvpanic/pvpanic.c                                       |   90 ++-
 drivers/misc/pvpanic/pvpanic.h                                       |   10 
 drivers/misc/vmw_vmci/vmci_event.c                                   |    6 
 drivers/mmc/host/davinci_mmc.c                                       |    6 
 drivers/mmc/host/sdhci-pci-core.c                                    |   11 
 drivers/mmc/host/sdhci.c                                             |   25 
 drivers/mtd/parsers/redboot.c                                        |    2 
 drivers/net/dsa/microchip/ksz9477.c                                  |    7 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                            |    5 
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c                    |   11 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                     |   14 
 drivers/net/ethernet/google/gve/gve.h                                |   13 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                         |   76 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                      |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h                      |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c              |   21 
 drivers/net/ethernet/ibm/ibmvnic.c                                   |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                  |   33 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c               |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                    |    3 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                      |    4 
 drivers/net/ethernet/qualcomm/qca_debug.c                            |    6 
 drivers/net/ethernet/qualcomm/qca_spi.c                              |   16 
 drivers/net/ethernet/qualcomm/qca_spi.h                              |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c                |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                      |   55 +-
 drivers/net/phy/micrel.c                                             |    1 
 drivers/net/phy/sfp.c                                                |    3 
 drivers/net/usb/ax88179_178a.c                                       |    6 
 drivers/net/usb/rtl8150.c                                            |    3 
 drivers/net/virtio_net.c                                             |   12 
 drivers/net/vxlan/vxlan_core.c                                       |    4 
 drivers/net/wireless/ath/ath.h                                       |    6 
 drivers/net/wireless/ath/ath10k/Kconfig                              |    1 
 drivers/net/wireless/ath/ath9k/main.c                                |    3 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                         |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                          |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h                          |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                        |    4 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c                 |   19 
 drivers/net/wireless/realtek/rtlwifi/wifi.h                          |    1 
 drivers/of/of_reserved_mem.c                                         |    9 
 drivers/pci/controller/pcie-rockchip-ep.c                            |    6 
 drivers/pci/pci.c                                                    |   12 
 drivers/pinctrl/core.c                                               |    2 
 drivers/pinctrl/pinctrl-rockchip.c                                   |   68 ++
 drivers/pinctrl/pinctrl-rockchip.h                                   |    1 
 drivers/platform/x86/dell/dell-smbios-base.c                         |   91 +--
 drivers/power/supply/cros_usbpd-charger.c                            |   11 
 drivers/ptp/ptp_chardev.c                                            |    3 
 drivers/ptp/ptp_sysfs.c                                              |    3 
 drivers/pwm/pwm-stm32.c                                              |    3 
 drivers/regulator/bd71815-regulator.c                                |    2 
 drivers/regulator/core.c                                             |    1 
 drivers/scsi/mpi3mr/mpi3mr.h                                         |    1 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                      |   67 ++
 drivers/scsi/mpt3sas/mpt3sas_base.c                                  |   19 
 drivers/scsi/mpt3sas/mpt3sas_base.h                                  |    3 
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                                   |    4 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                                 |   25 
 drivers/scsi/qedi/qedi_debugfs.c                                     |   12 
 drivers/scsi/scsi_transport_sas.c                                    |   29 +
 drivers/soc/ti/ti_sci_pm_domains.c                                   |   20 
 drivers/soc/ti/wkup_m3_ipc.c                                         |    7 
 drivers/spmi/hisi-spmi-controller.c                                  |    1 
 drivers/tty/serial/8250/8250_exar.c                                  |   42 +
 drivers/tty/serial/8250/8250_omap.c                                  |   22 
 drivers/tty/serial/8250/8250_pxa.c                                   |    1 
 drivers/tty/serial/imx.c                                             |    7 
 drivers/tty/serial/mcf.c                                             |    2 
 drivers/tty/serial/sc16is7xx.c                                       |   25 
 drivers/tty/serial/stm32-usart.c                                     |  206 +++++--
 drivers/tty/serial/stm32-usart.h                                     |   12 
 drivers/usb/atm/cxacru.c                                             |   14 
 drivers/usb/class/cdc-wdm.c                                          |    4 
 drivers/usb/dwc3/core.c                                              |    6 
 drivers/usb/gadget/function/f_fs.c                                   |    9 
 drivers/usb/gadget/function/f_printer.c                              |   40 +
 drivers/usb/host/xhci-pci.c                                          |    7 
 drivers/usb/host/xhci-ring.c                                         |   59 +-
 drivers/usb/host/xhci.h                                              |    1 
 drivers/usb/misc/uss720.c                                            |   20 
 drivers/usb/musb/da8xx.c                                             |    8 
 drivers/usb/storage/alauda.c                                         |    9 
 drivers/usb/typec/tcpm/tcpm.c                                        |    1 
 drivers/vdpa/vdpa_user/vduse_dev.c                                   |   14 
 fs/btrfs/block-group.c                                               |   11 
 fs/btrfs/disk-io.c                                                   |   10 
 fs/cifs/cifsfs.c                                                     |    2 
 fs/cifs/smb2transport.c                                              |    2 
 fs/f2fs/super.c                                                      |    2 
 fs/jfs/xattr.c                                                       |    4 
 fs/ksmbd/mgmt/share_config.c                                         |    6 
 fs/nfs/read.c                                                        |    4 
 fs/nfsd/nfsfh.c                                                      |    4 
 fs/nilfs2/dir.c                                                      |   59 +-
 fs/nilfs2/segment.c                                                  |    3 
 fs/ocfs2/aops.c                                                      |    5 
 fs/ocfs2/file.c                                                      |    2 
 fs/ocfs2/journal.c                                                   |   17 
 fs/ocfs2/journal.h                                                   |    2 
 fs/ocfs2/namei.c                                                     |    2 
 fs/ocfs2/ocfs2_trace.h                                               |    2 
 fs/open.c                                                            |    4 
 fs/proc/vmcore.c                                                     |    2 
 fs/udf/udftime.c                                                     |   11 
 include/kvm/arm_vgic.h                                               |    2 
 include/linux/cma.h                                                  |    9 
 include/linux/compat.h                                               |    2 
 include/linux/efi.h                                                  |   10 
 include/linux/filter.h                                               |    5 
 include/linux/i2c.h                                                  |   24 
 include/linux/iommu.h                                                |    2 
 include/linux/kcov.h                                                 |    2 
 include/linux/mdio.h                                                 |   12 
 include/linux/mod_devicetable.h                                      |    2 
 include/linux/nvme.h                                                 |    4 
 include/linux/pci.h                                                  |    9 
 include/linux/skbuff.h                                               |    2 
 include/linux/syscalls.h                                             |    8 
 include/net/bluetooth/hci_core.h                                     |   36 +
 include/net/inet_connection_sock.h                                   |   10 
 include/net/netfilter/nf_tables.h                                    |    5 
 include/net/request_sock.h                                           |    2 
 include/net/sock.h                                                   |   16 
 include/net/tcp.h                                                    |    2 
 include/scsi/scsi_transport_sas.h                                    |    2 
 include/trace/events/qdisc.h                                         |    4 
 include/uapi/asm-generic/hugetlb_encode.h                            |   26 
 include/uapi/asm-generic/unistd.h                                    |    2 
 kernel/bpf/core.c                                                    |    4 
 kernel/bpf/trampoline.c                                              |   20 
 kernel/bpf/verifier.c                                                |    8 
 kernel/cpu.c                                                         |    8 
 kernel/dma/contiguous.c                                              |    4 
 kernel/events/core.c                                                 |   13 
 kernel/gcov/gcc_4_7.c                                                |    4 
 kernel/gen_kheaders.sh                                               |    9 
 kernel/kcov.c                                                        |    1 
 kernel/kprobes.c                                                     |    8 
 kernel/padata.c                                                      |    8 
 kernel/pid_namespace.c                                               |    1 
 kernel/rcu/rcutorture.c                                              |   16 
 kernel/sys_ni.c                                                      |    2 
 kernel/time/tick-common.c                                            |   42 -
 kernel/trace/Kconfig                                                 |    4 
 kernel/trace/ftrace.c                                                |   71 ++
 kernel/trace/preemptirq_delay_test.c                                 |    1 
 mm/cma.c                                                             |   20 
 mm/memory-failure.c                                                  |    7 
 net/batman-adv/originator.c                                          |   29 +
 net/bluetooth/l2cap_core.c                                           |    8 
 net/bpf/test_run.c                                                   |    6 
 net/can/j1939/main.c                                                 |    6 
 net/can/j1939/transport.c                                            |   21 
 net/core/drop_monitor.c                                              |   20 
 net/core/filter.c                                                    |    3 
 net/core/net_namespace.c                                             |    9 
 net/core/netpoll.c                                                   |    2 
 net/core/skbuff.c                                                    |   24 
 net/core/sock.c                                                      |   20 
 net/core/sock_map.c                                                  |   16 
 net/core/xdp.c                                                       |    4 
 net/dccp/ipv4.c                                                      |    7 
 net/dccp/ipv6.c                                                      |    7 
 net/ieee802154/socket.c                                              |    4 
 net/ipv4/af_inet.c                                                   |   23 
 net/ipv4/cipso_ipv4.c                                                |   12 
 net/ipv4/inet_connection_sock.c                                      |   22 
 net/ipv4/raw.c                                                       |    2 
 net/ipv4/tcp.c                                                       |   16 
 net/ipv4/tcp_input.c                                                 |   50 +
 net/ipv4/tcp_minisocks.c                                             |    5 
 net/ipv6/af_inet6.c                                                  |   24 
 net/ipv6/ip6_fib.c                                                   |    6 
 net/ipv6/ipv6_sockglue.c                                             |   17 
 net/ipv6/route.c                                                     |    9 
 net/ipv6/seg6_iptunnel.c                                             |   14 
 net/ipv6/seg6_local.c                                                |    8 
 net/ipv6/tcp_ipv6.c                                                  |    9 
 net/ipv6/xfrm6_policy.c                                              |    8 
 net/iucv/iucv.c                                                      |   26 
 net/mac80211/he.c                                                    |   10 
 net/mac80211/mesh_pathtbl.c                                          |   13 
 net/mac80211/sta_info.c                                              |    4 
 net/mptcp/pm_netlink.c                                               |   21 
 net/mptcp/protocol.c                                                 |    1 
 net/ncsi/internal.h                                                  |    2 
 net/ncsi/ncsi-manage.c                                               |   93 +--
 net/ncsi/ncsi-rsp.c                                                  |    4 
 net/netfilter/ipset/ip_set_core.c                                    |   92 +--
 net/netfilter/ipset/ip_set_list_set.c                                |   30 -
 net/netfilter/nf_tables_api.c                                        |    8 
 net/netfilter/nft_lookup.c                                           |    3 
 net/netlink/af_netlink.c                                             |    4 
 net/netrom/nr_timer.c                                                |    3 
 net/packet/af_packet.c                                               |   30 -
 net/sched/act_api.c                                                  |   66 +-
 net/sched/act_ct.c                                                   |   21 
 net/sched/sch_multiq.c                                               |    2 
 net/sched/sch_taprio.c                                               |   15 
 net/sctp/socket.c                                                    |    5 
 net/smc/af_smc.c                                                     |    2 
 net/sunrpc/auth_gss/auth_gss.c                                       |    4 
 net/tipc/node.c                                                      |    1 
 net/unix/af_unix.c                                                   |  113 ++--
 net/unix/diag.c                                                      |   12 
 net/wireless/pmsr.c                                                  |    8 
 net/wireless/util.c                                                  |    7 
 net/xdp/xsk.c                                                        |    4 
 scripts/Makefile.dtbinst                                             |    2 
 sound/pci/hda/patch_realtek.c                                        |    1 
 sound/soc/fsl/fsl-asoc-card.c                                        |    3 
 sound/synth/emux/soundfont.c                                         |   17 
 tools/include/asm-generic/hugetlb_encode.h                           |   26 
 tools/perf/Documentation/perf-script.txt                             |    7 
 tools/perf/builtin-script.c                                          |   24 
 tools/testing/selftests/arm64/tags/tags_test.c                       |    4 
 tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c              |   26 
 tools/testing/selftests/bpf/test_tc_tunnel.sh                        |   13 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc     |    3 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                      |    5 
 tools/testing/selftests/vm/compaction_test.c                         |  103 ++-
 363 files changed, 3866 insertions(+), 2534 deletions(-)

Adam Miotk (1):
      drm/bridge/panel: Fix runtime warning on panel bridge release

Adrian Hunter (3):
      perf script: Show also errors for --insn-trace option
      mmc: sdhci: Do not invert write-protect twice
      mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()

Akhmat Karakotov (1):
      tcp: Use BPF timeout setting for SYN ACK RTO

Alan Stern (1):
      USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

Aleksandr Aprelkov (1):
      iommu/arm-smmu-v3: Free MSIs in case of ENOMEM

Aleksandr Mishin (2):
      liquidio: Adjust a NULL pointer handling path in lio_vf_rep_copy_packet
      gpio: davinci: Validate the obtained number of IRQs

Aleksandr Nogikh (1):
      kcov: don't lose track of remote references during softirqs

Alessandro Carminati (Red Hat) (1):
      selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh

Alex Bee (1):
      arm64: dts: rockchip: Add sound-dai-cells for RK3368

Alex Deucher (2):
      drm/radeon: fix UBSAN warning in kv_dpm.c
      drm/amdgpu: fix UBSAN warning in kv_dpm.c

Alex Henrie (1):
      usb: misc: uss720: check for incompatible versions of the Belkin F5U002

Alexander Shishkin (5):
      intel_th: pci: Add Granite Rapids support
      intel_th: pci: Add Granite Rapids SOC support
      intel_th: pci: Add Sapphire Rapids SOC support
      intel_th: pci: Add Meteor Lake-S support
      intel_th: pci: Add Lunar Lake support

Alexander Sverdlin (1):
      iio: accel: fxls8962af: select IIO_BUFFER & IIO_KFIFO_BUF

Alexey Kodanev (1):
      drm/amd/display: drop unnecessary NULL checks in debugfs

Amjad Ouled-Ameur (1):
      drm/komeda: check for error-valued pointer

Andrew Davis (1):
      soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer message

Andy Shevchenko (2):
      pvpanic: Keep single style across modules
      pvpanic: Indentation fixes here and there

Anton Protopopov (1):
      bpf: Add a check for struct bpf_fib_lookup size

Ard Biesheuvel (3):
      efi: memmap: Move manipulation routines into x86 arch tree
      efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on all architectures
      efi/x86: Free EFI memory map only when installing a new one.

Armin Wolf (1):
      platform/x86: dell-smbios: Fix wrong token data in sysfs

Arnd Bergmann (11):
      wifi: ath9k: work around memset overflow warning
      sparc: fix old compat_sys_select()
      sparc: fix compat recv/recvfrom syscalls
      parisc: use correct compat recv/recvfrom syscalls
      parisc: use generic sys_fanotify_mark implementation
      sh: rework sync_file_range ABI
      csky, hexagon: fix broken sys_sync_file_range
      hexagon: fix fadvise64_64 calling conventions
      ftruncate: pass a signed offset
      syscalls: fix compat_sys_io_pgetevents_time64 usage
      syscalls: fix sys_fanotify_mark prototype

Biju Das (1):
      regulator: core: Fix modpost error "regulator_get_regmap" undefined

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power

Bjorn Helgaas (2):
      dmaengine: ioat: Drop redundant pci_enable_pcie_error_reporting()
      dmaengine: ioat: use PCI core macros for PCIe Capability

Boris Burkov (1):
      btrfs: retry block group reclaim without infinite loop

Breno Leitao (2):
      scsi: mpt3sas: Avoid test/set_bit() operating in non-allocated memory
      netpoll: Fix race condition in netpoll_owner_active

Changbin Du (1):
      perf: script: add raw|disasm arguments to --insn-trace option

Chen Hanxiao (1):
      SUNRPC: return proper error from gss_wrap_req_priv

Chenghai Huang (1):
      crypto: hisilicon/sec - Fix memory leak for sec resource release

Chris Wilson (2):
      drm/i915/gt: Only kick the signal worker if there's been an update
      drm/i915/gt: Disarm breadcrumbs if engines are already idle

Christian Marangi (1):
      mips: bmips: BCM6358: make sure CBR is correctly set

Christophe Leroy (1):
      bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()

Csókás, Bence (1):
      net: sfp: Always call `sfp_sm_mod_remove()` on remove

Damien Le Moal (2):
      null_blk: Print correct max open zones limit in null_init_zoned_dev()
      scsi: mpi3mr: Fix ATA NCQ priority support

Dan Carpenter (3):
      Bluetooth: qca: Fix error code in qca_read_fw_build_info()
      ptp: fix integer overflow in max_vclocks_store
      usb: musb: da8xx: fix a resource leak in probe()

Daniel Borkmann (1):
      vxlan: Fix regression when dropping packets due to invalid src addresses

Daniil Dulov (1):
      xdp: Remove WARN() from __xdp_reg_mem_model()

David Awogbemila (1):
      gve: Add RX context.

David Hildenbrand (1):
      cma: factor out minimum alignment requirement

David Lechner (1):
      iio: adc: ad9467: fix scan type sign

David Ruth (1):
      net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()

Dawei Li (2):
      net/iucv: Avoid explicit cpumask var allocation on stack
      net/dpaa2: Avoid explicit cpumask var allocation on stack

DelphineCCChiu (1):
      net/ncsi: Fix the multi thread manner of NCSI driver

Denis Arefev (1):
      mtd: partitions: redboot: Added conversion of operands to a larger type

Dev Jain (2):
      selftests/mm: compaction_test: fix incorrect write of zero to nr_hugepages
      selftests/mm: compaction_test: fix bogus test success on Aarch64

Dirk Behme (1):
      drivers: core: synchronize really_probe() and dev_uevent()

Dmitry Baryshkov (1):
      wifi: ath10k: fix QCOM_RPROC_COMMON dependency

Dmitry Torokhov (1):
      Input: try trimming too long modalias strings

Doug Brown (1):
      serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level

Dragan Simic (1):
      kbuild: Install dtb files as 0644 in Makefile.dtbinst

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on N14AP7

Elinor Montmasson (1):
      ASoC: fsl-asoc-card: set priv->pdev before using it

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't read past the mfuart notifcation

Enguerrand de Ribaucourt (1):
      net: phy: micrel: add Microchip KSZ 9477 to the device table

Enzo Matsumiya (1):
      smb: client: fix deadlock in smb2_find_smb_tcon()

Eric Dumazet (14):
      ipv6: sr: block BH in seg6_output_core() and seg6_input_core()
      net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP
      net: inline sock_prot_inuse_add()
      net: drop nopreempt requirement on sock_prot_inuse_add()
      af_unix: annotate lockless accesses to sk->sk_err
      ipv6: fix possible race in __fib6_drop_pcpu_from()
      tcp: fix race in tcp_v6_syn_recv_sock()
      batman-adv: bypass empty buckets in batadv_purge_orig_ref()
      af_packet: avoid a false positive warning in packet_setsockopt()
      ipv6: prevent possible NULL deref in fib6_nh_init()
      ipv6: prevent possible NULL dereference in rt6_probe()
      xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()
      tcp: clear tp->retrans_stamp in tcp_rcv_fastopen_synack()
      ipv6: annotate some data-races around sk->sk_prot

Erick Archer (1):
      drm/radeon/radeon_display: Decrease the size of allocated memory

Erico Nunes (2):
      drm/lima: add mask irq callback to gp and pp
      drm/lima: mask irqs in timeout path before hard reset

Erwan Le Ray (1):
      serial: stm32: rework RX over DMA

Esben Haabendal (1):
      serial: imx: Introduce timeout when waiting on transmitter empty

FUKAUMI Naoki (1):
      arm64: dts: rockchip: fix PMIC interrupt pin on ROCK Pi E

Fernando Yang (1):
      iio: adc: ad7266: Fix variable checking bug

Filipe Manana (1):
      btrfs: fix leak of qgroup extent records after transaction abort

Frank Li (1):
      arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc

Frank van der Linden (1):
      mm/cma: drop incorrect alignment check in cma_init_reserved_mem

Gal Pressman (1):
      net/mlx5e: Fix features validation check for tunneled UDP (non-VXLAN) packets

Gavrilov Ilia (1):
      netrom: Fix a memory leak in nr_heartbeat_expiry()

George Shen (1):
      drm/amd/display: Handle Y carry-over in VCP X.Y calculation

Greg Kroah-Hartman (2):
      jfs: xattr: fix buffer overflow for invalid xattr
      Linux 5.15.162

Gregor Herburger (1):
      gpio: tqmx86: fix typo in Kconfig label

Grygorii Tertychnyi (1):
      i2c: ocores: set IACK bit after core is enabled

Hagar Gamal Halim Hemdan (1):
      vmci: prevent speculation leaks by sanitizing event in event_deliver()

Hagar Hemdan (1):
      pinctrl: fix deadlock in create_pinctrl() when handling -EPROBE_DEFER

Haifeng Xu (1):
      perf/core: Fix missing wakeup when waiting for context reference

Hamish Martin (1):
      i2c: acpi: Unbind mux adapters before delete

Hangyu Hua (1):
      net: sched: sch_multiq: fix possible OOB write in multiq_tune()

Hannes Reinecke (1):
      nvme: fixup comment for nvme RDMA Provider Type

Hans de Goede (1):
      iio: accel: mxc4005: Reset chip on probe() and resume()

Hector Martin (1):
      xhci: Handle TD clearing for multiple streams case

Heng Qi (1):
      virtio_net: checksum offloading handling fix

Herbert Xu (1):
      padata: Disable BH when taking works lock on MT path

Hersen Wu (1):
      drm/amd/display: Fix incorrect DSC instance for MST

Huang-Huang Bao (4):
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO3-B pins
      pinctrl: rockchip: use dedicated pinctrl type for RK3328
      pinctrl: rockchip: fix pinmux reset in rockchip_pmx_set

Hugo Villeneuve (2):
      serial: sc16is7xx: replace hardcoded divisor value with BIT() macro
      serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using prescaler

Ian Forbes (1):
      drm/vmwgfx: 3D disabled should not effect STDU memory limits

Ignat Korchagin (1):
      net: do not leave a dangling sk pointer, when socket creation fails

Ilpo Järvinen (2):
      MIPS: Routerboard 532: Fix vendor retry check code
      mmc: sdhci-pci: Convert PCIBIOS_* return codes to errnos

Jan Kara (1):
      ocfs2: fix DIO failure due to insufficient transaction credits

Jani Nikula (2):
      drm/exynos/vidi: fix memory leak in .get_modes()
      drm/i915/mso: using joiner is not possible with eDP MSO

Janusz Krzysztofik (1):
      drm/i915/gt: Fix potential UAF by revoke of fence registers

Jason Xing (1):
      tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB

Jean Delvare (2):
      i2c: at91: Fix the functionality flags of the slave-only interface
      i2c: designware: Fix the functionality flags of the slave-only interface

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: delete unneeded update watermark call

Jean-Michel Hautbois (1):
      tty: mcf: MCF54418 has 10 UARTS

Jeff Johnson (1):
      tracing: Add MODULE_DESCRIPTION() to preemptirq_delay_test

Jianguo Wu (1):
      seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and End.DX6 behaviors

Jiapeng Chong (1):
      drm/amd/display: Clean up some inconsistent indenting

Jie Wang (1):
      net: hns3: add cond_resched() to hns3 ring buffer init process

Jiri Olsa (1):
      bpf: Set run context for rawtp test_run callback

Jisheng Zhang (1):
      riscv: mm: init: try best to use IS_ENABLED(CONFIG_64BIT) instead of #ifdef

Joachim Vandersmissen (1):
      crypto: ecdh - explicitly zeroize private_key

Joao Pinto (1):
      Avoid hw_desc array overrun in dw-axi-dmac

Johan Hovold (2):
      Bluetooth: qca: fix info leak when fetching fw build id
      Bluetooth: qca: fix info leak when fetching board id

Johan Jonker (1):
      ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node

Johannes Berg (1):
      wifi: iwlwifi: mvm: revert gen2 TX A-MPDU size to 64

John Keeping (2):
      usb: gadget: f_fs: use io_data->status consistently
      Input: ili210x - fix ili251x_read_touch_data() return value

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve link status logs

José Expósito (1):
      HID: logitech-dj: Fix memory leak in logi_dj_recv_switch_to_dj_mode()

Jozsef Kadlecsik (2):
      netfilter: ipset: Fix race between namespace cleanup and gc in the list:set type
      netfilter: ipset: Fix suspicious rcu_dereference_protected()

Julia Zhang (1):
      drm/amdgpu: avoid using null object of framebuffer

Justin Stitt (1):
      block/ioctl: prefer different overflow check

Kalle Niemi (1):
      regulator: bd71815: fix ramp values

Karol Kolacinski (1):
      ptp: Fix error message on failed pin verification

Kees Cook (1):
      rtlwifi: rtl8192de: Style clean-ups

Kent Gibson (1):
      gpiolib: cdev: Disallow reconfiguration without direction (uAPI v1)

Krzysztof Kozlowski (5):
      Bluetooth: hci_qca: mark OF related data as maybe unused
      dt-bindings: i2c: google,cros-ec-i2c-tunnel: correct path to i2c-controller schema
      ARM: dts: samsung: smdkv310: fix keypad no-autorepeat
      ARM: dts: samsung: exynos4412-origen: fix keypad no-autorepeat
      ARM: dts: samsung: smdk4412: fix keypad no-autorepeat

Kuangyi Chiang (2):
      xhci: Apply reset resume quirk to Etron EJ188 xHCI host
      xhci: Apply broken streams quirk to Etron EJ188 xHCI host

Kun(llfl) (1):
      iommu/amd: Fix sysfs leak in iommu init

Kuniyuki Iwashima (15):
      af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
      af_unix: Annodate data-races around sk->sk_state for writers.
      af_unix: Annotate data-race of sk->sk_state in unix_inq_len().
      af_unix: Annotate data-races around sk->sk_state in unix_write_space() and poll().
      af_unix: Annotate data-race of sk->sk_state in unix_stream_connect().
      af_unix: Annotate data-races around sk->sk_state in sendmsg() and recvmsg().
      af_unix: Annotate data-race of sk->sk_state in unix_stream_read_skb().
      af_unix: Annotate data-races around sk->sk_state in UNIX_DIAG.
      af_unix: Annotate data-race of net->unx.sysctl_max_dgram_qlen.
      af_unix: Use unix_recvq_full_lockless() in unix_stream_connect().
      af_unix: Use skb_queue_empty_lockless() in unix_release_sock().
      af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
      af_unix: Annotate data-race of sk->sk_shutdown in sk_diag_fill().
      ipv6: Fix data races around sk->sk_prot.
      tcp: Fix data races around icsk->icsk_af_ops.

Kunwu Chan (1):
      kselftest: arm64: Add a null pointer check

Kyle Tso (1):
      usb: typec: tcpm: Ignore received Hard Reset in TOGGLING state

Laurent Pinchart (1):
      drm/panel: ilitek-ili9881c: Fix warning with GPIO controllers that sleep

Li RongQing (1):
      dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list

Lin Ma (1):
      wifi: cfg80211: pmsr: use correct nla_get_uX functions

Lingbo Kong (1):
      wifi: mac80211: correctly parse Spatial Reuse Parameter Set element

Linus Torvalds (1):
      x86: stop playing stack games in profile_pc()

Liu Ying (1):
      drm/panel: simple: Add missing display timing flags for KOE TX26D202VM0BWA

Liu Zixian (1):
      efi: Correct comment on efi_memmap_alloc

Lu Baolu (1):
      iommu: Return right value in iommu_sva_bind_device()

Luca Weiss (1):
      Bluetooth: btqca: Add WCN3988 support

Luiz Augusto von Dentz (2):
      skbuff: introduce skb_pull_data
      Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ

Ma Ke (2):
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_ld_modes
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_hd_modes

Manish Rangankar (1):
      scsi: qedi: Fix crash while reading debugfs attribute

Marc Ferland (1):
      iio: dac: ad5592r: fix temperature channel scaling value

Marc Zyngier (1):
      KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemption

Marek Szyprowski (1):
      drm/exynos: hdmi: report safe 640x480 mode as a fallback when no EDID found

Mario Limonciello (3):
      PCI/PM: Avoid D3cold for HP Pavilion 17 PC/1972 PCIe Ports
      ACPI: x86: utils: Add Picasso to the list for forcing StorageD3Enable
      ACPI: x86: Force StorageD3Enable on more products

Martin Leung (1):
      drm/amd/display: revert Exit idle optimizations before HDCP execution

Masahiro Yamada (1):
      Revert "kheaders: substituting --sort in archive creation"

Masami Hiramatsu (Google) (1):
      tracing: Build event generation tests only as modules

Mathias Nyman (1):
      xhci: Set correct transferred length for cancelled bulk transfers

Matthew Mirvish (1):
      bcache: fix variable length array abuse in btree_iter

Matthew Wilcox (Oracle) (3):
      nilfs2: Remove check for PageError
      nilfs2: return the mapped address from nilfs_get_page()
      nfs: Leave pages in the pagecache if readpage failed

Matthias Goergens (1):
      hugetlb_encode.h: fix undefined behaviour (34 << 26)

Matthias Maennich (1):
      kheaders: explicitly define file modes for archived headers

Matthias Schiffer (1):
      gpio: tqmx86: store IRQ trigger type and unmask status separately

Maxime Coquelin (2):
      vduse: validate block features only with block devices
      vduse: Temporarily fail if control queue feature requested

Meng Li (1):
      usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock

Miaohe Lin (1):
      mm/huge_memory: don't unpoison huge_zero_folio

Michael Ellerman (2):
      powerpc/uaccess: Fix build errors seen with GCC 13/14
      powerpc/io: Avoid clang null pointer arithmetic warnings

Min-Hua Chen (1):
      Bluetooth: btqca: use le32_to_cpu for ver.soc_id

Miri Korenblit (1):
      wifi: iwlwifi: mvm: check n_ssids before accessing the ssids

Muhammad Usama Anjum (1):
      selftests/mm: conform test to TAP format output

Nam Cao (1):
      riscv: fix overlap of allocated page and PTR_ERR

Nandor Kracser (1):
      ksmbd: ignore trailing slashes in share paths

Nathan Chancellor (1):
      kbuild: Remove support for Clang's ThinLTO caching

Nathan Lynch (1):
      powerpc/pseries: Enforce hcall result buffer validity and size

Naveen Naidu (1):
      PCI: Add PCI_ERROR_RESPONSE and related definitions

Neal Cardwell (1):
      tcp: fix tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TFO

Neil Armstrong (1):
      Bluetooth: qca: use switch case for soc type behavior

Nicholas Kazlauskas (1):
      drm/amd/display: Exit idle optimizations before HDCP execution

Nick Child (1):
      ibmvnic: Free any outstanding tx skbs during scrq reset

Nicolas Escande (1):
      wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

Nikita Shubin (4):
      dmaengine: ioatdma: Fix leaking on version mismatch
      dmaengine: ioatdma: Fix error path in ioat3_dma_probe()
      dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
      dmaengine: ioatdma: Fix missing kmem_cache_destroy()

Nikita Zhandarovich (2):
      HID: core: remove unnecessary WARN_ON() in implement()
      usb: atm: cxacru: fix endpoint checking in cxacru_bind()

Niklas Cassel (2):
      ata: ahci: Clean up sysfs file on error
      ata: libata-core: Fix double free on error

Nuno Sa (1):
      dmaengine: axi-dmac: fix possible race in remove()

Oleg Nesterov (2):
      tick/nohz_full: Don't abuse smp_call_function_single() in tick_setup_device()
      zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING

Oleksij Rempel (3):
      net: stmmac: Assign configured channel value to EXTTS event
      net: can: j1939: recover socket queue on CAN bus error during BAM transmission
      net: can: j1939: enhanced error handling for tightly received RTS messages in xtp_rx_rts_session_new

Oliver Neukum (3):
      net: usb: rtl8150 fix unintiatilzed variables in rtl8150_get_link_ksettings
      usb: gadget: printer: SS+ support
      usb: gadget: printer: fix races against disable

Ondrej Mosnacek (1):
      cipso: fix total option length computation

Oswald Buddenhagen (1):
      ALSA: emux: improve patch ioctl data validation

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fully validate NFT_DATA_VALUE on store to data registers

Paolo Abeni (1):
      mptcp: ensure snd_una is properly initialized on connect

Parker Newman (1):
      serial: exar: adding missing CTI and Exar PCI ids

Patrisious Haddad (1):
      RDMA/mlx5: Add check for srq max_sge attribute

Paul E. McKenney (1):
      rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment

Pavan Chebbi (1):
      bnxt_en: Restore PTP tx_avail count in case of skb_pad() error

Pedro Tammela (1):
      net/sched: act_api: rely on rcu in tcf_idr_check_alloc

Peter Delevoryas (1):
      net/ncsi: Simplify Kconfig/dts control flow

Peter Oberparleiter (1):
      gcov: add support for GCC 14

Peter Zijlstra (1):
      x86/ibt,ftrace: Search for __fentry__ location

Petr Pavlu (1):
      net/ipv6: Fix the RT cache flush via sysctl using a previous delay

Qing Wang (1):
      dmaengine: ioat: switch from 'pci_' to 'dma_' API

Raju Rangoju (1):
      ACPICA: Revert "ACPICA: avoid Info: mapping multiple BARs. Your kernel is fine."

Rao Shoaib (1):
      af_unix: Read with MSG_PEEK loops if the first unread byte is OOB

Remi Pommarel (2):
      wifi: mac80211: Fix deadlock in ieee80211_sta_ps_deliver_wakeup()
      wifi: cfg80211: Lock wiphy in cfg80211_get_station

Ricardo Ribalda (1):
      media: dvbdev: Initialize sbuf

Rick Wertenbroek (1):
      PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id

Rik van Riel (1):
      fs/proc: fix softlockup in __read_vmcore

Roman Smirnov (1):
      udf: udftime: prevent overflow in udf_disk_stamp_to_time()

Russell King (Oracle) (2):
      i2c: add fwnode APIs
      net: mdio: add helpers to extract clause 45 regad and devad fields

Ryusuke Konishi (2):
      nilfs2: fix nilfs_empty_dir() misjudgment and long loop on I/O errors
      nilfs2: fix potential kernel bug due to lack of writeback flag waiting

Samuel Holland (1):
      clk: sifive: Do not register clkdevs for PRCI clocks

Sean Christopherson (1):
      KVM: x86: Always sync PIR to IRR prior to scanning I/O APIC routes

Sean O'Brien (1):
      HID: Add quirk for Logitech Casa touchpad

Shahar S Matityahu (1):
      wifi: iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef

Shichao Lai (1):
      usb-storage: alauda: Check whether the media is initialized

Shigeru Yoshida (1):
      net: can: j1939: Initialize unused data in j1939_send_one()

Sicong Huang (1):
      greybus: Fix use-after-free bug in gb_interface_release due to race condition.

Simon Horman (1):
      octeontx2-pf: Add error handling to VLAN unoffload handling

Songyang Li (1):
      MIPS: Octeon: Add PCIe link status check

Stefan Wahren (1):
      qca_spi: Make interrupt remembering atomic

Steve French (1):
      cifs: fix typo in module parameter enable_gcm_256

Steven Rostedt (Google) (1):
      tracing/selftests: Fix kprobe event name test for .isra. functions

Su Yue (2):
      ocfs2: use coarse time for new created files
      ocfs2: fix races between hole punching and AIO+DIO

Subbaraya Sundeep (1):
      octeontx2-af: Always allocate PF entries from low prioriy zone

Sven Eckelmann (1):
      batman-adv: Don't accept TT entries for out-of-spec VIDs

Taehee Yoo (1):
      ionic: fix use after netif_napi_del()

Takashi Iwai (1):
      ACPI: video: Add backlight=native quirk for Lenovo Slim 7 16ARH7

Thadeu Lima de Souza Cascardo (1):
      sock_map: avoid race between sock_map_close and sk_psock_put

Thomas Weißschuh (2):
      misc/pvpanic: deduplicate common code
      misc/pvpanic-pci: register attributes via pci_driver

Tim Jiang (1):
      Bluetooth: qca: add support for QCA2066

Tomas Winkler (1):
      mei: me: release irq in mei_me_pci_resume error path

Tomi Valkeinen (1):
      pmdomain: ti-sci: Fix duplicate PD referrals

Tony Luck (2):
      x86/cpu/vfm: Add new macros to work with (vendor/family/model) values
      x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL

Tristram Ha (1):
      net: dsa: microchip: fix initial port flush problem

Trond Myklebust (1):
      knfsd: LOOKUP can return an illegal error value

Tzung-Bi Shih (1):
      power: supply: cros_usbpd: provide ID table for avoiding fallback match

Udit Kumar (2):
      serial: 8250_omap: Implementation of Errata i2310
      serial: 8250_omap: Fix Errata i2310 with RX FIFO level check

Uri Arev (1):
      Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl

Uros Bizjak (1):
      x86/fpu: Fix AMD X86_BUG_FXSAVE_LEAK fixup

Uwe Kleine-König (2):
      mmc: davinci: Don't strip remove function when driver is builtin
      pwm: stm32: Refuse too small period requests

Vamshi Gajjela (1):
      spmi: hisi-spmi-controller: Do not override device identifier

Vasant Hegde (1):
      iommu/amd: Introduce pci segment structure

Vasileios Amoiridis (4):
      iio: chemical: bme680: Fix pressure value output
      iio: chemical: bme680: Fix calibration data variable
      iio: chemical: bme680: Fix overflows in compensate() functions
      iio: chemical: bme680: Fix sensor data read operation

Vlad Buslov (1):
      net/sched: act_ct: set 'net' pointer when creating new nf_flow_table

Wander Lairson Costa (1):
      drop_monitor: replace spin_lock by raw_spin_lock

Wenchao Hao (1):
      RDMA/restrack: Fix potential invalid address access

Wesley Cheng (1):
      usb: gadget: f_fs: Fix race between aio_cancel() and AIO request complete

Wolfram Sang (2):
      i2c: testunit: don't erase registers after STOP
      i2c: testunit: discard write requests while old command is running

Xiaolei Wang (2):
      net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters
      net: stmmac: No need to calculate speed divider when offload is disabled

Xin Long (2):
      tipc: force a dst refcount before doing decryption
      sched: act_ct: add netns into the key of tcf_ct_flow_table

Yangtao Li (1):
      mmc: davinci_mmc: Convert to platform remove callback returning void

Yazen Ghannam (1):
      x86/amd_nb: Check for invalid SMN reads

Yonghong Song (1):
      selftests/bpf: Fix flaky test btf_map_in_map/lookup_update

Yonglong Liu (1):
      net: hns3: fix kernel crash problem in concurrent scenario

YonglongLi (2):
      mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
      mptcp: pm: update add_addr counters after connect

Yue Haibing (1):
      netns: Make get_net_ns() handle zero refcount net

Yunlei He (1):
      f2fs: remove clear SB_INLINECRYPT flag in default_options

Yunseong Kim (1):
      tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset()

Yuntao Wang (1):
      cpu/hotplug: Fix dynstate assignment in __cpuhp_setup_state_cpuslocked()

Zheng Yejian (1):
      ftrace: Fix possible use-after-free issue in ftrace_location()

Zheng Zhi Yuan (1):
      drivers: fix typo in firmware/efi/memmap.c

Ziwei Xiao (1):
      gve: Clear napi->skb before dev_kfree_skb_any()

Zqiang (2):
      rcutorture: Make stall-tasks directly exit when rcutorture tests end
      rcutorture: Fix invalid context warning when enable srcu barrier testing

luoxuanqiang (1):
      Fix race for duplicate reqsk on identical SYN

ye xingchen (1):
      platform/x86: dell-smbios-base: Use sysfs_emit()


