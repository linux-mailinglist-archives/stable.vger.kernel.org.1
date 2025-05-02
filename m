Return-Path: <stable+bounces-139446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C761AA6A8E
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F74B7B1254
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30D41F4CB6;
	Fri,  2 May 2025 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UvUp32Ao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF31EDA2C;
	Fri,  2 May 2025 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166101; cv=none; b=hHOHwTDZvptK6GyAWnyG+coqGO3aga32TlcO8Xp94aibukmIVRrQ+N9BTY6aCYvaDlZsyL00+Y7p0cLJ35Hq7ZkgKZGrgfIVy8L1U/gWojoZNgMbZH9NBf9V2/0Hr4e0Tj8NNYjdWuvyM8I6h1zfU5LVt/7Hy0c3fyepishCzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166101; c=relaxed/simple;
	bh=eVt+ZttT6fYx2tM6TVkNOgranTZfX0FjPWG8TctqZCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LXwqxe+mBIZcyFdQHeAxCdUWSDjq0rV7WP2QQh2eA2bhFogjj8zs5UxsuEmbMmi/RHOrEdCCfa5oXp1MjE7wCNYVmkYhyqp/ELL9RP100Tu+9IxQV62b6vR6wcTQCrr3DY0HFS4lqFSIHKdMXmUY/9VGVSilycn544XncFT7d58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UvUp32Ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BED4C4CEE4;
	Fri,  2 May 2025 06:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746166101;
	bh=eVt+ZttT6fYx2tM6TVkNOgranTZfX0FjPWG8TctqZCs=;
	h=From:To:Cc:Subject:Date:From;
	b=UvUp32Ao5tIi07KPcOAFuRaKOrjyY143/qKp4nu7GOUleRXilPOOEEL6cw5PDRNdf
	 xTE/Sa7k2d6FYEPKS+RRVoyatBTrEpCSm0tipGly9JFNtFmLgl2JGXuY5QASqFv6cg
	 IvxWPTzsAUvWiOY9wRNo/8Iz2bZm4C4w+N7nJhGo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.14.5
Date: Fri,  2 May 2025 08:07:47 +0200
Message-ID: <2025050248-omega-penalty-1b03@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.14.5 kernel.

All users of the 6.14 kernel series must upgrade.

The updated 6.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                |    2 
 Documentation/bpf/bpf_devel_QA.rst                             |    8 
 Documentation/trace/debugging.rst                              |    2 
 Makefile                                                       |    3 
 arch/arm/crypto/Kconfig                                        |   10 
 arch/arm64/crypto/Kconfig                                      |    6 
 arch/loongarch/Kconfig                                         |    1 
 arch/loongarch/include/asm/fpu.h                               |   39 
 arch/loongarch/include/asm/lbt.h                               |   10 
 arch/loongarch/include/asm/ptrace.h                            |    4 
 arch/loongarch/kernel/fpu.S                                    |    6 
 arch/loongarch/kernel/lbt.S                                    |    4 
 arch/loongarch/kernel/signal.c                                 |   21 
 arch/loongarch/kernel/traps.c                                  |   20 
 arch/loongarch/kvm/intc/ipi.c                                  |    4 
 arch/loongarch/kvm/main.c                                      |    4 
 arch/loongarch/kvm/vcpu.c                                      |    8 
 arch/loongarch/mm/hugetlbpage.c                                |    2 
 arch/loongarch/mm/init.c                                       |    3 
 arch/mips/crypto/Kconfig                                       |    7 
 arch/mips/include/asm/mips-cm.h                                |   22 
 arch/mips/kernel/mips-cm.c                                     |   14 
 arch/parisc/kernel/pdt.c                                       |    2 
 arch/powerpc/crypto/Kconfig                                    |    7 
 arch/riscv/crypto/Kconfig                                      |    1 
 arch/riscv/include/asm/alternative-macros.h                    |   19 
 arch/riscv/include/asm/cacheflush.h                            |   15 
 arch/riscv/include/asm/ftrace.h                                |    2 
 arch/riscv/include/asm/ptrace.h                                |   18 
 arch/riscv/kernel/probes/uprobes.c                             |   10 
 arch/s390/crypto/Kconfig                                       |    3 
 arch/s390/kvm/intercept.c                                      |    2 
 arch/s390/kvm/interrupt.c                                      |    8 
 arch/s390/kvm/kvm-s390.c                                       |   10 
 arch/s390/kvm/trace-s390.h                                     |    4 
 arch/um/include/linux/time-internal.h                          |    2 
 arch/um/kernel/skas/syscall.c                                  |   11 
 arch/x86/crypto/Kconfig                                        |   11 
 arch/x86/entry/entry.S                                         |    2 
 arch/x86/events/core.c                                         |    2 
 arch/x86/include/asm/intel-family.h                            |    2 
 arch/x86/include/asm/pgalloc.h                                 |   19 
 arch/x86/kernel/cpu/bugs.c                                     |   30 
 arch/x86/kernel/i8253.c                                        |    3 
 arch/x86/kernel/machine_kexec_32.c                             |    4 
 arch/x86/kvm/svm/avic.c                                        |   60 
 arch/x86/kvm/vmx/posted_intr.c                                 |   28 
 arch/x86/kvm/x86.c                                             |   20 
 arch/x86/lib/x86-opcode-map.txt                                |    4 
 arch/x86/mm/pgtable.c                                          |    4 
 arch/x86/mm/tlb.c                                              |    6 
 arch/x86/pci/xen.c                                             |    8 
 arch/x86/platform/efi/efi_64.c                                 |    4 
 arch/x86/xen/enlighten_pvh.c                                   |   19 
 block/bdev.c                                                   |   22 
 block/blk-cgroup.c                                             |    2 
 block/blk-settings.c                                           |    8 
 block/blk.h                                                    |    3 
 block/fops.c                                                   |    2 
 crypto/Kconfig                                                 |    3 
 crypto/crypto_null.c                                           |   39 
 crypto/ecc.c                                                   |    2 
 crypto/ecdsa-p1363.c                                           |    2 
 crypto/ecdsa-x962.c                                            |    4 
 drivers/acpi/ec.c                                              |   28 
 drivers/acpi/pptt.c                                            |    4 
 drivers/android/binder.c                                       |    2 
 drivers/ata/libata-scsi.c                                      |   25 
 drivers/base/base.h                                            |   17 
 drivers/base/bus.c                                             |    2 
 drivers/base/core.c                                            |   38 
 drivers/base/dd.c                                              |    7 
 drivers/block/ublk_drv.c                                       |  214 +-
 drivers/char/misc.c                                            |    2 
 drivers/char/virtio_console.c                                  |    7 
 drivers/clk/clk.c                                              |    4 
 drivers/clk/renesas/rzv2h-cpg.c                                |   12 
 drivers/comedi/drivers/jr3_pci.c                               |    2 
 drivers/cpufreq/Kconfig.arm                                    |   20 
 drivers/cpufreq/apple-soc-cpufreq.c                            |   10 
 drivers/cpufreq/cppc_cpufreq.c                                 |    2 
 drivers/cpufreq/scmi-cpufreq.c                                 |   10 
 drivers/cpufreq/scpi-cpufreq.c                                 |   13 
 drivers/cpufreq/sun50i-cpufreq-nvmem.c                         |   18 
 drivers/crypto/atmel-sha204a.c                                 |    6 
 drivers/crypto/ccp/sp-pci.c                                    |    1 
 drivers/cxl/core/regs.c                                        |    4 
 drivers/dma-buf/udmabuf.c                                      |    2 
 drivers/dma/bcm2835-dma.c                                      |    2 
 drivers/dma/dmatest.c                                          |    6 
 drivers/firmware/stratix10-svc.c                               |   14 
 drivers/gpio/gpiolib-of.c                                      |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                        |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                        |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                        |   19 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                         |    8 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                         |   12 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                         |    6 
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c                         |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                         |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c                         |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c                         |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                      |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c      |    2 
 drivers/gpu/drm/meson/meson_drv.c                              |    2 
 drivers/gpu/drm/meson/meson_drv.h                              |    2 
 drivers/gpu/drm/meson/meson_encoder_hdmi.c                     |   29 
 drivers/gpu/drm/meson/meson_vclk.c                             |  195 +
 drivers/gpu/drm/meson/meson_vclk.h                             |   13 
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c               |    4 
 drivers/gpu/drm/xe/regs/xe_gt_regs.h                           |    4 
 drivers/gpu/drm/xe/tests/xe_rtp_test.c                         |    2 
 drivers/gpu/drm/xe/xe_gt.c                                     |    4 
 drivers/gpu/drm/xe/xe_gt_debugfs.c                             |   11 
 drivers/gpu/drm/xe/xe_gt_types.h                               |   10 
 drivers/gpu/drm/xe/xe_hw_engine.c                              |   18 
 drivers/gpu/drm/xe/xe_reg_whitelist.c                          |    4 
 drivers/gpu/drm/xe/xe_rtp.c                                    |    6 
 drivers/gpu/drm/xe/xe_rtp.h                                    |    2 
 drivers/gpu/drm/xe/xe_tuning.c                                 |   71 
 drivers/gpu/drm/xe/xe_tuning.h                                 |    3 
 drivers/gpu/drm/xe/xe_wa.c                                     |   22 
 drivers/gpu/drm/xe/xe_wa_oob.rules                             |    2 
 drivers/i3c/master/svc-i3c-master.c                            |   17 
 drivers/iio/adc/ad4695.c                                       |   34 
 drivers/iio/adc/ad7768-1.c                                     |    5 
 drivers/infiniband/hw/qib/qib_fs.c                             |    1 
 drivers/iommu/amd/iommu.c                                      |    2 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c            |    2 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                    |    4 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h                    |    1 
 drivers/iommu/iommu.c                                          |    3 
 drivers/irqchip/irq-gic-v2m.c                                  |    2 
 drivers/irqchip/irq-renesas-rzv2h.c                            |   91 
 drivers/mailbox/pcc.c                                          |   15 
 drivers/mcb/mcb-parse.c                                        |    2 
 drivers/md/raid1.c                                             |   26 
 drivers/media/i2c/Kconfig                                      |    1 
 drivers/media/i2c/imx214.c                                     |  978 ++++------
 drivers/media/i2c/ov08x40.c                                    |   56 
 drivers/misc/lkdtm/perms.c                                     |   14 
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c                |    8 
 drivers/misc/mei/hw-me-regs.h                                  |    1 
 drivers/misc/mei/pci-me.c                                      |    1 
 drivers/misc/mei/vsc-tp.c                                      |   26 
 drivers/mmc/host/sdhci-msm.c                                   |    2 
 drivers/net/dsa/mt7530.c                                       |    6 
 drivers/net/ethernet/amd/pds_core/adminq.c                     |   36 
 drivers/net/ethernet/amd/pds_core/auxbus.c                     |    3 
 drivers/net/ethernet/amd/pds_core/core.c                       |    9 
 drivers/net/ethernet/amd/pds_core/core.h                       |    4 
 drivers/net/ethernet/amd/pds_core/devlink.c                    |    4 
 drivers/net/ethernet/freescale/enetc/enetc.c                   |   45 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                    |   24 
 drivers/net/ethernet/mediatek/mtk_eth_soc.h                    |   10 
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c           |   26 
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c            |   18 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h                |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c           |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c          |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c              |   62 
 drivers/net/ethernet/sun/niu.c                                 |    2 
 drivers/net/phy/dp83822.c                                      |   40 
 drivers/net/phy/microchip.c                                    |   46 
 drivers/net/phy/phy_device.c                                   |   53 
 drivers/net/phy/phy_led_triggers.c                             |   23 
 drivers/net/phy/phylink.c                                      |  164 +
 drivers/net/virtio_net.c                                       |  125 -
 drivers/net/vmxnet3/vmxnet3_xdp.c                              |    2 
 drivers/net/xen-netfront.c                                     |   17 
 drivers/ntb/hw/amd/ntb_hw_amd.c                                |    1 
 drivers/ntb/hw/idt/ntb_hw_idt.c                                |   18 
 drivers/nvme/host/core.c                                       |    9 
 drivers/nvme/host/multipath.c                                  |    2 
 drivers/nvme/target/core.c                                     |    3 
 drivers/nvme/target/fc.c                                       |   25 
 drivers/nvme/target/pci-epf.c                                  |   14 
 drivers/of/resolver.c                                          |   37 
 drivers/pci/msi/msi.c                                          |   38 
 drivers/phy/rockchip/phy-rockchip-usbdp.c                      |    1 
 drivers/pinctrl/pinctrl-mcp23s08.c                             |   23 
 drivers/pinctrl/renesas/pinctrl-rza2.c                         |    3 
 drivers/platform/x86/x86-android-tablets/dmi.c                 |   14 
 drivers/platform/x86/x86-android-tablets/other.c               |  124 -
 drivers/platform/x86/x86-android-tablets/x86-android-tablets.h |    3 
 drivers/pwm/core.c                                             |   13 
 drivers/pwm/pwm-axi-pwmgen.c                                   |   10 
 drivers/regulator/rk808-regulator.c                            |    4 
 drivers/rtc/rtc-pcf85063.c                                     |   19 
 drivers/s390/char/sclp_con.c                                   |   17 
 drivers/s390/char/sclp_tty.c                                   |   12 
 drivers/scsi/hisi_sas/hisi_sas_main.c                          |   20 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                |    2 
 drivers/scsi/pm8001/pm8001_sas.c                               |    1 
 drivers/scsi/scsi.c                                            |   36 
 drivers/scsi/scsi_lib.c                                        |    6 
 drivers/soc/qcom/ice.c                                         |   48 
 drivers/spi/spi-imx.c                                          |    5 
 drivers/spi/spi-tegra210-quad.c                                |    6 
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c           |   10 
 drivers/thunderbolt/tb.c                                       |   16 
 drivers/tty/serial/msm_serial.c                                |    6 
 drivers/tty/serial/sifive.c                                    |    6 
 drivers/tty/vt/selection.c                                     |    5 
 drivers/ufs/core/ufs-mcq.c                                     |   12 
 drivers/ufs/core/ufshcd.c                                      |    2 
 drivers/ufs/host/ufs-exynos.c                                  |   44 
 drivers/ufs/host/ufs-exynos.h                                  |    1 
 drivers/ufs/host/ufs-qcom.c                                    |    2 
 drivers/usb/cdns3/cdns3-gadget.c                               |    2 
 drivers/usb/chipidea/ci_hdrc_imx.c                             |   44 
 drivers/usb/class/cdc-wdm.c                                    |   21 
 drivers/usb/core/quirks.c                                      |    9 
 drivers/usb/dwc3/dwc3-pci.c                                    |   10 
 drivers/usb/dwc3/dwc3-xilinx.c                                 |    4 
 drivers/usb/dwc3/gadget.c                                      |   28 
 drivers/usb/gadget/udc/aspeed-vhub/dev.c                       |    3 
 drivers/usb/host/max3421-hcd.c                                 |    7 
 drivers/usb/host/ohci-pci.c                                    |   23 
 drivers/usb/host/xhci-hub.c                                    |   30 
 drivers/usb/host/xhci-mvebu.c                                  |   10 
 drivers/usb/host/xhci-mvebu.h                                  |    6 
 drivers/usb/host/xhci-plat.c                                   |    2 
 drivers/usb/host/xhci-ring.c                                   |   75 
 drivers/usb/host/xhci.c                                        |    4 
 drivers/usb/host/xhci.h                                        |    4 
 drivers/usb/serial/ftdi_sio.c                                  |    2 
 drivers/usb/serial/ftdi_sio_ids.h                              |    5 
 drivers/usb/serial/option.c                                    |    3 
 drivers/usb/serial/usb-serial-simple.c                         |    7 
 drivers/usb/storage/unusual_uas.h                              |    7 
 drivers/usb/typec/class.c                                      |   24 
 drivers/usb/typec/class.h                                      |    1 
 drivers/usb/typec/ucsi/cros_ec_ucsi.c                          |    5 
 drivers/usb/typec/ucsi/ucsi.c                                  |   19 
 drivers/usb/typec/ucsi/ucsi.h                                  |    6 
 drivers/usb/typec/ucsi/ucsi_acpi.c                             |    5 
 drivers/usb/typec/ucsi/ucsi_ccg.c                              |   67 
 drivers/vhost/scsi.c                                           |   80 
 drivers/virtio/virtio_pci_modern.c                             |    4 
 drivers/xen/Kconfig                                            |    2 
 fs/btrfs/file.c                                                |    9 
 fs/btrfs/zoned.c                                               |    1 
 fs/ceph/inode.c                                                |    2 
 fs/ext4/block_validity.c                                       |    5 
 fs/ext4/inode.c                                                |    7 
 fs/iomap/buffered-io.c                                         |    2 
 fs/namespace.c                                                 |   69 
 fs/netfs/main.c                                                |    4 
 fs/ntfs3/file.c                                                |   20 
 fs/smb/client/sess.c                                           |   60 
 fs/smb/client/smb1ops.c                                        |   36 
 fs/smb/server/vfs_cache.c                                      |    8 
 fs/splice.c                                                    |    2 
 fs/xattr.c                                                     |    4 
 include/linux/blkdev.h                                         |    4 
 include/linux/energy_model.h                                   |   12 
 include/linux/math.h                                           |   12 
 include/linux/msi.h                                            |    3 
 include/linux/pci.h                                            |    2 
 include/linux/phy.h                                            |    4 
 include/linux/phylink.h                                        |    4 
 include/net/netfilter/nft_fib.h                                |   21 
 include/soc/qcom/ice.h                                         |    2 
 include/uapi/linux/virtio_pci.h                                |    1 
 init/Kconfig                                                   |    2 
 io_uring/io_uring.c                                            |   15 
 io_uring/refs.h                                                |    7 
 kernel/bpf/bpf_cgrp_storage.c                                  |   11 
 kernel/bpf/hashtab.c                                           |    6 
 kernel/bpf/preload/bpf_preload_kern.c                          |    1 
 kernel/bpf/syscall.c                                           |    6 
 kernel/bpf/verifier.c                                          |   32 
 kernel/cgroup/cgroup.c                                         |   29 
 kernel/cgroup/cpuset-internal.h                                |    1 
 kernel/cgroup/cpuset.c                                         |   14 
 kernel/dma/contiguous.c                                        |    3 
 kernel/events/core.c                                           |    6 
 kernel/irq/msi.c                                               |    2 
 kernel/panic.c                                                 |    6 
 kernel/power/energy_model.c                                    |   47 
 kernel/sched/ext.c                                             |    4 
 kernel/sched/fair.c                                            |    4 
 kernel/time/tick-common.c                                      |   22 
 kernel/trace/bpf_trace.c                                       |    7 
 kernel/trace/trace.c                                           |   10 
 lib/Kconfig.ubsan                                              |    1 
 lib/crypto/Kconfig                                             |   37 
 lib/test_ubsan.c                                               |   18 
 mm/vmscan.c                                                    |    7 
 net/9p/client.c                                                |   30 
 net/9p/trans_fd.c                                              |   17 
 net/core/lwtunnel.c                                            |   26 
 net/core/selftests.c                                           |   18 
 net/ipv4/netfilter/nft_fib_ipv4.c                              |   11 
 net/ipv6/netfilter/nft_fib_ipv6.c                              |   19 
 net/mptcp/pm_userspace.c                                       |    6 
 net/sched/sch_hfsc.c                                           |   23 
 net/tipc/monitor.c                                             |    3 
 rust/Makefile                                                  |    8 
 rust/kernel/firmware.rs                                        |    8 
 scripts/Makefile.lib                                           |    2 
 scripts/Makefile.vmlinux                                       |    4 
 sound/soc/codecs/aw88081.c                                     |   10 
 sound/soc/codecs/wcd934x.c                                     |    2 
 sound/soc/fsl/fsl_asrc_dma.c                                   |   15 
 sound/virtio/virtio_pcm.c                                      |   21 
 tools/arch/x86/lib/x86-opcode-map.txt                          |    4 
 tools/bpf/bpftool/prog.c                                       |    1 
 tools/objtool/check.c                                          |   36 
 tools/testing/selftests/bpf/cap_helpers.c                      |    8 
 tools/testing/selftests/bpf/cap_helpers.h                      |    1 
 tools/testing/selftests/bpf/network_helpers.c                  |   33 
 tools/testing/selftests/bpf/prog_tests/verifier.c              |    4 
 tools/testing/selftests/bpf/test_loader.c                      |    6 
 tools/testing/selftests/mincore/mincore_selftest.c             |    3 
 tools/testing/selftests/pcie_bwctrl/Makefile                   |    3 
 tools/testing/selftests/ublk/test_stripe_04.sh                 |   24 
 323 files changed, 3670 insertions(+), 2042 deletions(-)

Adam Xue (1):
      USB: serial: option: add Sierra Wireless EM9291

Al Viro (2):
      fix a couple of races in MNT_TREE_BENEATH handling by do_move_mount()
      qibfs: fix _another_ leak

Alexander Stein (1):
      usb: host: max3421-hcd: Add missing spi_device_id table

Alexander Usyskin (1):
      mei: me: add panther lake H DID

Alexei Starovoitov (2):
      bpf: Add namespace to BPF internal symbols
      bpf: Fix deadlock between rcu_tasks_trace and event_mutex.

Alexey Nepomnyashih (1):
      xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()

Alexis Lothore (1):
      net: stmmac: fix dwmac1000 ptp timestamp status offset

Alexis Lothoré (1):
      net: stmmac: fix multiplication overflow when reading timestamp

Amery Hung (1):
      selftests/bpf: Fix stdout race condition in traffic monitor

Anastasia Kovaleva (1):
      scsi: core: Clear flags for scsi_cmnd that did not complete

Andre Przywara (1):
      cpufreq: sun50i: prevent out-of-bounds access

Andrei Kuchynski (2):
      usb: typec: class: Fix NULL pointer access
      usb: typec: class: Invalidate USB device pointers on partner unregistration

Andrew Jones (1):
      riscv: Provide all alternative macros all the time

André Apitzsch (6):
      media: i2c: imx214: Use subdev active state
      media: i2c: imx214: Simplify with dev_err_probe()
      media: i2c: imx214: Convert to CCI register access helpers
      media: i2c: imx214: Replace register addresses with macros
      media: i2c: imx214: Check number of lanes from device tree
      media: i2c: imx214: Fix link frequency validation

Andy Shevchenko (3):
      usb: dwc3: gadget: Refactor loop to avoid NULL endpoints
      usb: dwc3: gadget: Avoid using reserved endpoints on Intel Merrifield
      gpiolib: of: Move Atmel HSMCI quirk up out of the regulator comment

Andy Yan (1):
      phy: rockchip: usbdp: Avoid call hpd_event_trigger in dp_phy_init

Arnd Bergmann (2):
      dma/contiguous: avoid warning about unused size_bytes
      ntb: reduce stack usage in idt_scan_mws

Basavaraj Natikar (1):
      ntb_hw_amd: Add NTB PCI ID for new gen CPU

Benjamin Berg (1):
      um: work around sched_yield not yielding in time-travel mode

Bibo Mao (2):
      LoongArch: KVM: Fully clear some CSRs when VM reboot
      LoongArch: KVM: Fix PMU pass-through issue if VM exits to host finally

Biju Das (4):
      irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
      irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
      irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
      clk: renesas: rzv2h: Adjust for CPG_BUS_m_MSTOP starting from m = 1

Björn Töpel (2):
      riscv: Replace function-like macro by static inline function
      riscv: uprobes: Add missing fence.i after building the XOL buffer

Bo-Cun Chen (1):
      net: ethernet: mtk_eth_soc: net: revise NETSYSv3 hardware configuration

Breno Leitao (3):
      sched_ext: Use kvzalloc for large exit_dump allocation
      spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
      spi: tegra210-quad: add rate limiting and simplify timeout error message

Brett Creeley (3):
      pds_core: Prevent possible adminq overflow/stuck condition
      pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
      pds_core: Remove unnecessary check in pds_client_adminq_cmd()

Bui Quang Minh (1):
      virtio-net: disable delayed refill when pausing rx

Caleb Sander Mateos (1):
      ublk: remove unused cmd argument to ublk_dispatch_req()

Carlos Llamas (1):
      binder: fix offset calculation in debug log

Charlie Jenkins (1):
      riscv: tracing: Fix __write_overflow_field in ftrace_partial_regs()

Chenyuan Yang (4):
      scsi: ufs: mcq: Add NULL check in ufshcd_mcq_abort()
      scsi: ufs: core: Add NULL check in ufshcd_mcq_compl_pending_transfer()
      pinctrl: renesas: rza2: Fix potential NULL pointer dereference
      usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()

Christian Hewitt (1):
      Revert "drm/meson: vclk: fix calculation of 59.94 fractional rates"

Christian König (1):
      drm/amdgpu: use a dummy owner for sysfs triggered cleaner shaders v4

Christian Schrefl (1):
      rust: firmware: Use `ffi::c_char` type in `FwFunc`

Christoph Hellwig (4):
      block: never reduce ra_pages in blk_apply_bdi_limits
      block: move blkdev_{get,put} _no_open prototypes out of blkdev.h
      block: remove the backing_inode variable in bdev_statx
      block: don't autoload drivers on stat

Cong Wang (2):
      net_sched: hfsc: Fix a UAF vulnerability in class handling
      net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too

Craig Hesling (1):
      USB: serial: simple: add OWON HDS200 series oscilloscope support

Damien Le Moal (5):
      ata: libata-scsi: Improve CDL control
      ata: libata-scsi: Fix ata_mselect_control_ata_feature() return type
      ata: libata-scsi: Fix ata_msense_control_ata_feature()
      scsi: Improve CDL control
      nvmet: pci-epf: cleanup link state management

Dan Carpenter (2):
      usb: typec: class: Unlocked on error in typec_register_partner()
      media: i2c: imx214: Fix uninitialized variable in imx214_set_ctrl()

Daniel Borkmann (1):
      vmxnet3: Fix malformed packet sizing in vmxnet3_process_xdp

Daniel Golle (1):
      net: dsa: mt7530: sync driver-specific behavior of MT7531 variants

Daniel Jurgens (1):
      virtio_pci: Use self group type for cap commands

Daniel Wagner (2):
      nvmet-fc: take tgtport reference only once
      nvmet-fc: put ref when assoc->del_work is already scheduled

Dave Penkler (1):
      staging: gpib: Use min for calculating transfer length

David Howells (1):
      ceph: Fix incorrect flush end position calculation

Devaraj Rangasamy (1):
      crypto: ccp - Add support for PCI device 0x1134

Dimitri Fedrau (3):
      net: phy: Add helper for getting tx amplitude gain
      net: phy: dp83822: Add support for changing the transmit amplitude voltage
      net: phy: dp83822: fix transmit amplitude if CONFIG_OF_MDIO not defined

Dmitry Baryshkov (2):
      usb: typec: ucsi: return CCI and message from sync_control callback
      usb: typec: ucsi: ccg: move command quirks to ucsi_ccg_sync_control()

Dmitry Mastykin (1):
      pinctrl: mcp23s08: Get rid of spurious level interrupts

Dmitry Torokhov (3):
      Revert "drivers: core: synchronize really_probe() and dev_uevent()"
      driver core: introduce device_set_driver() helper
      driver core: fix potential NULL pointer dereference in dev_uevent()

Dominique Martinet (1):
      9p/net: fix improper handling of bogus negative read/write replies

Dongli Zhang (2):
      vhost-scsi: Fix vhost_scsi_send_bad_target()
      vhost-scsi: Fix vhost_scsi_send_status()

Edward Adam Davis (1):
      fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size

Emily Deng (1):
      drm/amdkfd: sriov doesn't support per queue reset

Fedor Pchelkin (3):
      usb: chipidea: ci_hdrc_imx: fix usbmisc handling
      usb: chipidea: ci_hdrc_imx: fix call balance of regulator routines
      usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error handling

Feng Yang (1):
      selftests/bpf: Fix cap_enable_effective() return code

Fernando Fernandez Mancera (1):
      x86/i8253: Call clockevent_i8253_disable() with interrupts disabled

Fiona Klute (1):
      net: phy: microchip: force IRQ polling mode for lan88xx

Florian Westphal (1):
      netfilter: fib: avoid lookup if socket is available

Frode Isaksen (1):
      usb: dwc3: gadget: check that event count does not exceed event buffer length

Gabriel Shahrouzi (1):
      perf/core: Fix WARN_ON(!ctx) in __free_event() for partial init

Gou Hao (1):
      iomap: skip unnecessary ifs_block_is_uptodate check

Greg Kroah-Hartman (1):
      Linux 6.14.5

Gregory CLEMENT (1):
      MIPS: cm: Detect CM quirks from device tree

Günther Noack (1):
      tty: Require CAP_SYS_ADMIN for all usages of TIOCL_SELMOUSEREPORT

Halil Pasic (1):
      virtio_console: fix missing byte order handling for cols and rows

Hannes Reinecke (3):
      nvme: requeue namespace scan on missed AENs
      nvme: re-read ANA log page after ns scan completes
      nvme: fixup scan failure for non-ANA multipath controllers

Hans de Goede (5):
      media: ov08x40: Move ov08x40_identify_module() function up
      media: ov08x40: Add missing ov08x40_identify_module() call on stream-start
      mei: vsc: Fix fortify-panic caused by invalid counted_by() use
      platform/x86: x86-android-tablets: Add "9v" to Vexia EDU ATLA 10 tablet symbols
      platform/x86: x86-android-tablets: Add Vexia Edu Atla 10 tablet 5V data

Haoxiang Li (3):
      mcb: fix a double free bug in chameleon_parse_gdd()
      s390/sclp: Add check for get_zeroed_page()
      s390/tty: Fix a potential memory leak bug

Heiko Stuebner (1):
      clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()

Henry Martin (5):
      cpufreq: apple-soc: Fix null-ptr-deref in apple_soc_cpufreq_get_rate()
      cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
      cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()
      net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
      net/mlx5: Move ttc allocation after switch case to prevent leaks

Herbert Xu (4):
      crypto: lib/Kconfig - Fix lib built-in failure when arch is modular
      crypto: null - Use spin lock instead of mutex
      crypto: lib/Kconfig - Hide arch options from user
      crypto: Kconfig - Select LIB generic option

Huacai Chen (1):
      USB: OHCI: Add quirk for LS7A OHCI controller (rev 0x02)

Hugo Villeneuve (1):
      drm: panel: jd9365da: fix reset signal polarity in unprepare

Huisong Li (1):
      mailbox: pcc: Fix the possible race in updation of chan_in_use flag

Ian Abbott (1):
      comedi: jr3_pci: Fix synchronous deletion of timer

Ignacio Encinas (1):
      9p/trans_fd: mark concurrent read and writes to p9_conn->err

Igor Pylypiv (1):
      scsi: pm80xx: Set phy_attached to zero when device is gone

Ilpo Järvinen (1):
      selftests/pcie_bwctrl: Fix test progs list

Jan Kara (1):
      fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and getxattrat(2)

Jason Andryuk (1):
      xen: Change xen-acpi-processor dom0 dependency

Jay Cornwall (1):
      drm/amdgpu: Increase KIQ invalidate_tlbs timeout

Jean-Marc Eurin (1):
      ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls

Jens Axboe (1):
      io_uring: fix 'sync' handling of io_fallback_tw()

Jinjiang Tu (1):
      mm/vmscan: don't try to reclaim hwpoison folio

Joe Damato (2):
      virtio-net: Refactor napi_enable paths
      virtio-net: Refactor napi_disable paths

Johan Hovold (1):
      cpufreq: fix compile-test defaults

Johannes Schneider (1):
      net: dp83822: Fix OF_MDIO config check

Johannes Thumshirn (1):
      btrfs: zoned: return EIO on RAID1 block group write pointer mismatch

John Stultz (1):
      sound/virtio: Fix cancel_sync warnings on uninitialized work_structs

Jonathan Cameron (1):
      iio: adc: ad7768-1: Move setting of val a bit later to avoid unnecessary return value check

Jonathan Currier (2):
      PCI/MSI: Add an option to write MSIX ENTRY_DATA before any reads
      net/niu: Niu requires MSIX ENTRY_DATA fields touch before entry reads

Josh Poimboeuf (11):
      objtool: Silence more KCOV warnings
      objtool, panic: Disable SMAP in __stack_chk_fail()
      objtool, ASoC: codecs: wcd934x: Remove potential undefined behavior in wcd934x_slim_irq_handler()
      objtool, regulator: rk808: Remove potential undefined behavior in rk806_set_mode_dcdc()
      objtool, lkdtm: Obfuscate the do_nothing() pointer
      objtool: Stop UNRET validation on UD2
      x86/bugs: Use SBPB in write_ibpb() if applicable
      x86/bugs: Don't fill RSB on VMEXIT with eIBRS+retpoline
      x86/bugs: Don't fill RSB on context switch with eIBRS
      objtool: Ignore end-of-section jumps for KCOV/GCOV
      objtool: Silence more KCOV warnings, part 2

Juergen Gross (1):
      x86/mm: Fix _pgd_alloc() for Xen PV mode

Julia Filipchuk (1):
      drm/xe/xe3lpg: Apply Wa_14022293748, Wa_22019794406

Justin Iurman (1):
      net: lwtunnel: disable BHs when required

Kirill A. Shutemov (1):
      x86/insn: Fix CTEST instruction decoding

Krzysztof Kozlowski (1):
      cpufreq: Do not enable by default during compile testing

Li RongQing (1):
      PM: EM: use kfree_rcu() to simplify the code

Lijo Lazar (1):
      drm/amdgpu: Use the right function for hdp flush

Lizhi Xu (1):
      fs/ntfs3: Keep write operations atomic

Lucas De Marchi (1):
      drm/xe/rtp: Drop sentinels from arg to xe_rtp_process_to_sr()

Luis Chamberlain (1):
      bdev: use bdev_io_min() for statx block size

Lukas Stockmann (1):
      rtc: pcf85063: do a SW reset if POR failed

Lukas Wunner (1):
      crypto: ecdsa - Harden against integer overflows in DIV_ROUND_UP()

Luo Gengkun (1):
      perf/x86: Fix non-sampling (counting) events on certain x86 platforms

Mahesh Rao (1):
      firmware: stratix10-svc: Add of_platform_default_populate()

Marc Zyngier (1):
      cpufreq: cppc: Fix invalid return value in .get() callback

Marek Behún (1):
      crypto: atmel-sha204a - Set hwrng quality to lowest possible

Mario Limonciello (3):
      drm/amd/display: Fix ACPI edid parsing on some Lenovo systems
      ACPI: EC: Set ec_no_wakeup for Lenovo Go S
      drm/amd: Forbid suspending into non-default suspend states

Martin Blumenstingl (1):
      drm/meson: use unsigned long long / Hz for frequency types

Martin KaFai Lau (1):
      bpf: Only fails the busy counter check in bpf_cgrp_storage_get if it creates storage

Mat Martineau (1):
      mptcp: pm: Defer freeing of MPTCP userspace path manager entries

Mathias Nyman (2):
      xhci: Limit time spent with xHC interrupts disabled during bus resume
      xhci: Handle spurious events on Etron host isoc enpoints

Meir Elisha (1):
      md/raid1: Add check for missing source disk in process_checks()

Miao Li (2):
      usb: quirks: add DELAY_INIT quirk for Silicon Motion Flash Drive
      usb: quirks: Add delay init quirk for SanDisk 3.2Gen1 Flash Drive

Michael Ehrenreich (1):
      USB: serial: ftdi_sio: add support for Abacus Electrics Optical Probe

Michal Pecio (5):
      usb: xhci: Fix invalid pointer dereference in Etron workaround
      usb: xhci: Complete 'error mid TD' transfers when handling Missed Service
      usb: xhci: Fix isochronous Ring Underrun/Overrun event handling
      usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running
      usb: xhci: Fix Short Packet handling rework ignoring errors

Miguel Ojeda (1):
      rust: kbuild: skip `--remap-path-prefix` for `rustdoc`

Mika Westerberg (1):
      thunderbolt: Scan retimers after device router has been enumerated

Mike Christie (1):
      vhost-scsi: Add better resource allocation failure handling

Mike Looijmans (1):
      usb: dwc3: xilinx: Prevent spike in reset signal

Ming Lei (7):
      ublk: comment on ubq->canceling handling in ublk_queue_rq()
      ublk: implement ->queue_rqs()
      ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
      selftests: ublk: fix test_stripe_04
      ublk: add ublk_force_abort_dev()
      ublk: rely on ->canceling for dealing with ublk_nosrv_dev_should_queue_io
      ublk: don't fail request for recovery & reissue in case of ubq->canceling

Ming Wang (1):
      LoongArch: Return NULL from huge_pte_offset() for invalid PMD

Mostafa Saleh (1):
      ubsan: Fix panic from test_ubsan_out_of_bounds

Namjae Jeon (1):
      ksmbd: fix WARNING "do not call blocking ops when !TASK_RUNNING"

Nathan Chancellor (1):
      lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP

Nicolin Chen (1):
      iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations

Niranjana Vishwanathapura (1):
      drm/xe: Ensure fixed_slice_mode gets set after ccs_mode change

Nirmoy Das (1):
      drm/xe/ptl: Apply Wa_14023061436

Ojaswin Mujoo (1):
      ext4: make block validity check resistent to sb bh corruption

Oleg Nesterov (1):
      sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP

Oleksij Rempel (1):
      net: selftests: initialize TCP header and skb payload with zero

Oliver Neukum (6):
      USB: storage: quirk for ADATA Portable HDD CH94
      USB: VLI disk crashes if LPM is used
      USB: wdm: handle IO errors in wdm_wwan_port_start
      USB: wdm: close race between wdm_open and wdm_wwan_port_stop
      USB: wdm: wdm_wwan_port_tx_complete mutex in atomic context
      USB: wdm: add annotation

Omar Sandoval (1):
      sched/eevdf: Fix se->slice being set to U64_MAX and resulting crash

Pali Rohár (2):
      cifs: Fix encoding of SMB1 Session Setup Kerberos Request in non-UNICODE mode
      cifs: Fix querying of WSL CHR and BLK reparse points over SMB1

Pavel Begunkov (1):
      io_uring: always do atomic put from iowq

Peter Griffin (4):
      scsi: ufs: exynos: Ensure pre_link() executes before exynos_ufs_phy_init()
      scsi: ufs: exynos: Enable PRDT pre-fetching with UFSHCD_CAP_CRYPTO
      scsi: ufs: exynos: Move phy calls to .exit() callback
      scsi: ufs: exynos: gs101: Put UFS device in reset on .suspend()

Petr Tesarik (1):
      LoongArch: Remove a bogus reference to ZONE_DMA

Pi Xiange (1):
      x86/cpu: Add CPU model number for Bartlett Lake CPUs with Raptor Cove cores

Qingfang Deng (1):
      net: phy: leds: fix memory leak

Qiuxu Zhuo (1):
      selftests/mincore: Allow read-ahead pages to reach the end of the file

Qu Wenruo (1):
      btrfs: avoid page_lockend underflow in btrfs_punch_hole_lock_range()

Rafael J. Wysocki (1):
      PM: EM: Address RCU-related sparse warnings

Ralph Siemsen (1):
      usb: cdns3: Fix deadlock when using NCM gadget

Ranjan Kumar (1):
      scsi: mpi3mr: Fix pending I/O counter

Rengarajan S (2):
      misc: microchip: pci1xxxx: Fix Kernel panic during IRQ handler registration
      misc: microchip: pci1xxxx: Fix incorrect IRQ status handling during ack

Richard Weinberger (1):
      nvmet: fix out-of-bounds access in nvmet_enable_port

Rob Herring (Arm) (1):
      of: resolver: Simplify of_resolve_phandles() using __free()

Robin Murphy (1):
      iommu: Clear iommu-dma ops on cleanup

Roger Pau Monne (2):
      PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag
      x86/xen: disable CPU idle and frequency drivers for PVH dom0

Roman Li (2):
      drm/amd/display: Fix gpu reset in multidisplay config
      drm/amd/display: Force full update in gpu reset

Russell King (Oracle) (8):
      net: phylink: force link down on major_config failure
      net: phylink: fix suspend/resume with WoL enabled and link down
      net: stmmac: simplify phylink_suspend() and phylink_resume() calls
      net: phylink: add phylink_prepare_resume()
      net: stmmac: address non-LPI resume failures properly
      net: stmmac: socfpga: remove phy_resume() call
      net: phylink: add functions to block/unblock rx clock stop
      net: stmmac: block PHY RXC clock-stop

Ryo Takakura (1):
      serial: sifive: lock port in startup()/shutdown() callbacks

Sean Christopherson (5):
      iommu/amd: Return an error if vCPU affinity is set for non-vCPU IRTE
      KVM: SVM: Allocate IR data using atomic allocation
      KVM: x86: Explicitly treat routing entry type changes as changes
      KVM: x86: Reset IRTE to host control if *new* route isn't postable
      KVM: x86: Take irqfds.lock when adding/deleting IRQ bypass producer

Sebastian Andrzej Siewior (1):
      timekeeping: Add a lockdep override in tick_freeze()

Sergiu Cuciurean (1):
      iio: adc: ad7768-1: Fix conversion result sign

Sewon Nam (1):
      bpf: bpftool: Setting error code in do_loader()

Shannon Nelson (1):
      pds_core: make wait_context part of q_info

Shengjiu Wang (1):
      ASoC: fsl_asrc_dma: get codec or cpu dai from backend

Smita Koralahalli (1):
      cxl/core/regs.c: Skip Memory Space Enable check for RCD and RCH Ports

Song Liu (1):
      netfs: Only create /proc/fs/netfs with CONFIG_PROC_FS

Stanley Chu (1):
      i3c: master: svc: Add support for Nuvoton npcm845 i3c

Stefan Wahren (1):
      dmaengine: bcm2835-dma: fix warning when CONFIG_PM=n

Stephan Gerhold (1):
      serial: msm: Configure correct working mode before starting earlycon

Steven Rostedt (1):
      tracing: Enforce the persistent ring buffer to be page aligned

Sudeep Holla (1):
      mailbox: pcc: Always clear the platform ack interrupt first

Suzuki K Poulose (1):
      irqchip/gic-v2m: Prevent use after free of gicv2m_get_fwnode()

T.J. Mercier (2):
      cgroup/cpuset-v1: Add missing support for cpuset_v2_mode
      splice: remove duplicate noinline from pipe_clear_nowait

Tamura Dai (1):
      spi: spi-imx: Add check for spi_imx_setupxfer()

Tejas Upadhyay (1):
      drm/xe/xe3lpg: Add Wa_13012615864

Thadeu Lima de Souza Cascardo (1):
      char: misc: register chrdev region with all possible minors

Thomas Bogendoerfer (1):
      MIPS: cm: Fix warning if MIPS_CM is disabled

Thomas Gleixner (1):
      PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends

Thomas Weißschuh (3):
      kbuild, rust: use -fremap-path-prefix to make paths relative
      KVM: s390: Don't use %pK through tracepoints
      KVM: s390: Don't use %pK through debug printing

Théo Lebrun (1):
      usb: host: xhci-plat: mvebu: use ->quirks instead of ->init_quirk() func

Tiezhu Yang (3):
      LoongArch: Make regs_irqs_disabled() more clear
      LoongArch: Make do_xyz() exception handlers more robust
      LoongArch: Handle fp, lsx, lasx and lbt assembly symbols

Trevor Gamblin (1):
      iio: adc: ad4695: make ad4695_exit_conversion_mode() more robust

Tudor Ambarus (3):
      soc: qcom: ice: introduce devm_of_qcom_ice_get
      mmc: sdhci-msm: fix dev reference leaked through of_qcom_ice_get
      scsi: ufs: qcom: fix dev reference leaked through of_qcom_ice_get

Tung Nguyen (1):
      tipc: fix NULL pointer dereference in tipc_mon_reinit_self()

Tvrtko Ursulin (1):
      drm/xe: Add performance tunings to debugfs

Uday Shankar (2):
      ublk: remove io_cmds list in ublk_queue
      nvme: multipath: fix return value of nvme_available_path

Uwe Kleine-König (2):
      pwm: Let pwm_set_waveform() succeed even if lowlevel driver rounded up
      pwm: axi-pwmgen: Let .round_waveform_tohw() signal when request was rounded up

Vinicius Costa Gomes (1):
      dmaengine: dmatest: Fix dmatest waiting less when interrupted

Vladimir Oltean (3):
      net: enetc: register XDP RX queues with frag_size
      net: enetc: refactor bulk flipping of RX buffers to separate function
      net: enetc: fix frame corruption on bpf_xdp_adjust_head/tail() and XDP_PASS

Waiman Long (1):
      cgroup/cpuset: Don't allow creation of local partition over a remote one

Weidong Wang (1):
      ASoC: codecs: Add of_match_table for aw888081 driver

Xi Ruoyao (1):
      kbuild: add dependency from vmlinux to sorttable

Xiaogang Chen (1):
      udmabuf: fix a buf size overflow issue during udmabuf creation

Xingui Yang (1):
      scsi: hisi_sas: Fix I/O errors caused by hardware port ID changes

Yafang Shao (1):
      bpf: Reject attaching fexit/fmod_ret to __noreturn functions

Yonghong Song (1):
      bpf: Fix kmemleak warning for percpu hashmap

Yu-Chun Lin (1):
      parisc: PDT: Fix missing prototype warning

Yuli Wang (1):
      LoongArch: Select ARCH_USE_MEMTEST

Yulong Han (1):
      LoongArch: KVM: Fix multiple typos of KVM code

Zijun Hu (1):
      of: resolver: Fix device node refcount leakage in of_resolve_phandles()


