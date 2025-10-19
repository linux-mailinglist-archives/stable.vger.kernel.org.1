Return-Path: <stable+bounces-187897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA1BEE73A
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05742402176
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E222173F;
	Sun, 19 Oct 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PO9up6y0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C541523A;
	Sun, 19 Oct 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760884694; cv=none; b=AZmKQSs6GmslpDa/1aT73rkcQvvhRZCjqLIz/JKpUrPvgoRPOSZrd1zPCiqM5SFUXKxQb4iCXcU4hyCsvDi9sZeO7WIzAG4zGepXeKwLuZV3iAzuvz3S5268Jh0wJ+MHnt5FjJXRhESmrnY3nLdHBLwzD/qkFXix1/n56TZMGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760884694; c=relaxed/simple;
	bh=hA9gJLEHgH0iwzFgUAAnJ35czjIVU+fpxmGf6ixEsCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I9Ptc1wMDMSlwWMWjaWbO6yIQLYtFqCMeW32k9ruBDQzQh3BeIrnYh4Ao6smssg7rRsM3yowK5aZxtMp7KTzgGBsjBef+Tr6szDzkvvucgA15HOAGa1Z9Slu0nZsA+pV1GG8EkrMFgvrZ5WAyHmGOuSJbZTr5ZnNH90WIkgDcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PO9up6y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A93C4CEE7;
	Sun, 19 Oct 2025 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760884694;
	bh=hA9gJLEHgH0iwzFgUAAnJ35czjIVU+fpxmGf6ixEsCY=;
	h=From:To:Cc:Subject:Date:From;
	b=PO9up6y08n/7prooz+Qns0jYmPoD3jaE1vILVngQUfeVe09HevYxDV/OLt352aLnT
	 dGzbRsICXn7AwY0qTOEVf3OF2hgTjxKyBtSl9l/Rea7Q5jRAxzTmt258WDmjlSt63k
	 QdLodLIIg0IPf5jjivIgrTW3wPukdiwmo++kkuHY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.195
Date: Sun, 19 Oct 2025 16:38:09 +0200
Message-ID: <2025101910-granny-unclamped-7b6b@gregkh>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.195 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                       |    3 
 Documentation/gpu/todo.rst                                            |   11 
 Documentation/trace/histogram-design.rst                              |    4 
 Makefile                                                              |    2 
 arch/arm/mach-at91/pm_suspend.S                                       |    4 
 arch/arm/mach-omap2/pm33xx-core.c                                     |    6 
 arch/arm/mm/pageattr.c                                                |    6 
 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts                       |    2 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                  |    4 
 arch/arm64/kernel/cpufeature.c                                        |   10 
 arch/arm64/kernel/fpsimd.c                                            |    8 
 arch/arm64/kernel/mte.c                                               |    3 
 arch/parisc/include/uapi/asm/ioctls.h                                 |    8 
 arch/powerpc/platforms/powernv/pci-ioda.c                             |    2 
 arch/powerpc/platforms/pseries/msi.c                                  |    2 
 arch/sparc/kernel/of_device_32.c                                      |    1 
 arch/sparc/kernel/of_device_64.c                                      |    1 
 arch/sparc/lib/M7memcpy.S                                             |   20 
 arch/sparc/lib/Memcpy_utils.S                                         |    9 
 arch/sparc/lib/NG4memcpy.S                                            |    2 
 arch/sparc/lib/NGmemcpy.S                                             |   29 -
 arch/sparc/lib/U1memcpy.S                                             |   19 
 arch/sparc/lib/U3memcpy.S                                             |    2 
 arch/sparc/mm/hugetlbpage.c                                           |   20 
 arch/um/drivers/mconsole_user.c                                       |    2 
 arch/x86/include/asm/segment.h                                        |    8 
 arch/x86/kernel/umip.c                                                |   15 
 arch/x86/kvm/emulate.c                                                |   11 
 arch/x86/kvm/kvm_emulate.h                                            |    2 
 arch/x86/kvm/x86.c                                                    |    9 
 arch/x86/mm/pgtable.c                                                 |    2 
 block/blk-mq-sysfs.c                                                  |    6 
 block/blk-settings.c                                                  |    3 
 crypto/essiv.c                                                        |   14 
 crypto/rng.c                                                          |    8 
 drivers/acpi/acpi_dbg.c                                               |   26 
 drivers/acpi/acpi_tad.c                                               |    3 
 drivers/acpi/nfit/core.c                                              |    2 
 drivers/acpi/processor_idle.c                                         |    3 
 drivers/base/node.c                                                   |    4 
 drivers/base/power/main.c                                             |   14 
 drivers/base/regmap/regmap.c                                          |    2 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                       |    3 
 drivers/bus/mhi/host/init.c                                           |    5 
 drivers/char/hw_random/ks-sa-rng.c                                    |    4 
 drivers/char/tpm/tpm_tis_core.c                                       |    4 
 drivers/clk/at91/clk-peripheral.c                                     |    7 
 drivers/clk/nxp/clk-lpc18xx-cgu.c                                     |   20 
 drivers/clocksource/clps711x-timer.c                                  |   23 
 drivers/cpufreq/intel_pstate.c                                        |    8 
 drivers/cpufreq/scmi-cpufreq.c                                        |   10 
 drivers/cpufreq/tegra186-cpufreq.c                                    |    8 
 drivers/crypto/atmel-tdes.c                                           |    2 
 drivers/dma/ioat/dma.c                                                |   12 
 drivers/edac/sb_edac.c                                                |    4 
 drivers/edac/skx_common.h                                             |    1 
 drivers/firmware/meson/Kconfig                                        |    2 
 drivers/firmware/meson/meson_sm.c                                     |    7 
 drivers/gpio/gpio-wcd934x.c                                           |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                   |    2 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                 |   29 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                  |    2 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c                    |   21 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h                    |    4 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c                   |    2 
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h                  |    7 
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h            |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h                    |   14 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c               |    2 
 drivers/gpu/drm/arm/display/include/malidp_utils.h                    |    2 
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c            |   24 
 drivers/gpu/drm/drm_color_mgmt.c                                      |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                 |    6 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                  |    2 
 drivers/gpu/drm/radeon/evergreen_cs.c                                 |    2 
 drivers/gpu/drm/radeon/r600_cs.c                                      |    4 
 drivers/gpu/drm/vmwgfx/Makefile                                       |    2 
 drivers/gpu/drm/vmwgfx/ttm_object.c                                   |   52 -
 drivers/gpu/drm/vmwgfx/ttm_object.h                                   |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c                            |   24 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                                   |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                                   |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                               |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.c                               |  199 +++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.h                               |   83 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c                            |   26 
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h                            |    7 
 drivers/hid/hid-mcp2221.c                                             |    4 
 drivers/hwmon/adt7475.c                                               |   24 
 drivers/hwtracing/coresight/coresight-trbe.c                          |    9 
 drivers/i2c/busses/i2c-designware-platdrv.c                           |    1 
 drivers/i2c/busses/i2c-mt65xx.c                                       |   17 
 drivers/i3c/master/svc-i3c-master.c                                   |    1 
 drivers/iio/dac/ad5360.c                                              |    2 
 drivers/iio/dac/ad5421.c                                              |    2 
 drivers/iio/frequency/adf4350.c                                       |   20 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c                      |    4 
 drivers/iio/inkern.c                                                  |    2 
 drivers/infiniband/core/addr.c                                        |   10 
 drivers/infiniband/core/cm.c                                          |    4 
 drivers/infiniband/core/sa_query.c                                    |    6 
 drivers/infiniband/sw/siw/siw_verbs.c                                 |   25 
 drivers/input/misc/uinput.c                                           |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                              |    2 
 drivers/input/touchscreen/cyttsp4_core.c                              |    2 
 drivers/iommu/amd/iommu.c                                             |    3 
 drivers/iommu/intel/iommu.c                                           |    2 
 drivers/irqchip/irq-sun6i-r.c                                         |    2 
 drivers/mailbox/zynqmp-ipi-mailbox.c                                  |    7 
 drivers/md/dm-integrity.c                                             |    6 
 drivers/md/dm.c                                                       |    7 
 drivers/media/dvb-frontends/stv0367_priv.h                            |    3 
 drivers/media/i2c/mt9v111.c                                           |    2 
 drivers/media/i2c/rj54n1cb0c.c                                        |    9 
 drivers/media/i2c/tc358743.c                                          |    4 
 drivers/media/mc/mc-devnode.c                                         |    6 
 drivers/media/pci/b2c2/flexcop-pci.c                                  |    2 
 drivers/media/pci/cobalt/cobalt-driver.c                              |    4 
 drivers/media/pci/cx18/cx18-driver.c                                  |    2 
 drivers/media/pci/cx18/cx18-queue.c                                   |   20 
 drivers/media/pci/cx18/cx18-streams.c                                 |   16 
 drivers/media/pci/ddbridge/ddbridge-main.c                            |    4 
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c                         |    2 
 drivers/media/pci/ivtv/ivtv-driver.c                                  |    2 
 drivers/media/pci/ivtv/ivtv-irq.c                                     |    2 
 drivers/media/pci/ivtv/ivtv-queue.c                                   |   18 
 drivers/media/pci/ivtv/ivtv-streams.c                                 |   22 
 drivers/media/pci/ivtv/ivtv-udma.c                                    |   27 -
 drivers/media/pci/ivtv/ivtv-yuv.c                                     |   24 
 drivers/media/pci/ivtv/ivtvfb.c                                       |    6 
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c                    |    2 
 drivers/media/pci/pluto2/pluto2.c                                     |   20 
 drivers/media/pci/pt1/pt1.c                                           |    2 
 drivers/media/pci/tw5864/tw5864-core.c                                |    2 
 drivers/media/rc/imon.c                                               |   27 -
 drivers/media/tuners/xc5000.c                                         |   41 -
 drivers/memory/samsung/exynos-srom.c                                  |   10 
 drivers/mfd/intel_soc_pmic_chtdc_ti.c                                 |    5 
 drivers/mfd/vexpress-sysreg.c                                         |    6 
 drivers/misc/genwqe/card_ddcb.c                                       |    2 
 drivers/mmc/core/sdio.c                                               |    6 
 drivers/mtd/nand/raw/fsmc_nand.c                                      |    6 
 drivers/net/ethernet/amazon/ena/ena_ethtool.c                         |    5 
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c                       |   18 
 drivers/net/ethernet/dlink/dl2k.c                                     |    7 
 drivers/net/ethernet/freescale/fsl_pq_mdio.c                          |    2 
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h              |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                     |   17 
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c                  |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                     |    2 
 drivers/net/fjes/fjes_main.c                                          |    4 
 drivers/net/usb/asix_devices.c                                        |   35 +
 drivers/net/usb/rtl8150.c                                             |    2 
 drivers/net/wireless/ath/ath10k/wmi.c                                 |   39 -
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                       |    7 
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c                       |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c                   |    1 
 drivers/nfc/pn544/i2c.c                                               |    2 
 drivers/nvme/host/pci.c                                               |    2 
 drivers/nvme/target/fc.c                                              |   19 
 drivers/pci/controller/dwc/pci-keystone.c                             |    4 
 drivers/pci/controller/dwc/pcie-tegra194.c                            |    4 
 drivers/pci/controller/pci-tegra.c                                    |    2 
 drivers/pci/iov.c                                                     |    5 
 drivers/pci/pci-driver.c                                              |    1 
 drivers/pci/pci-sysfs.c                                               |   20 
 drivers/pci/pcie/aer.c                                                |   12 
 drivers/pci/pcie/err.c                                                |    8 
 drivers/perf/arm_spe_pmu.c                                            |    3 
 drivers/pinctrl/meson/pinctrl-meson-gxl.c                             |   10 
 drivers/pinctrl/pinmux.c                                              |    2 
 drivers/pinctrl/renesas/pinctrl.c                                     |    3 
 drivers/platform/x86/intel/int3472/discrete.c                         |    3 
 drivers/platform/x86/intel/int3472/tps68470.c                         |    3 
 drivers/platform/x86/sony-laptop.c                                    |    1 
 drivers/pps/kapi.c                                                    |    5 
 drivers/pps/pps.c                                                     |    5 
 drivers/pwm/pwm-berlin.c                                              |    4 
 drivers/pwm/pwm-tiehrpwm.c                                            |    4 
 drivers/regulator/scmi-regulator.c                                    |    3 
 drivers/remoteproc/qcom_q6v5.c                                        |    3 
 drivers/rtc/interface.c                                               |   27 +
 drivers/rtc/rtc-x1205.c                                               |    2 
 drivers/s390/cio/device.c                                             |    2 
 drivers/scsi/hpsa.c                                                   |   21 
 drivers/scsi/isci/init.c                                              |    6 
 drivers/scsi/mpt3sas/mpt3sas_transport.c                              |    8 
 drivers/scsi/mvsas/mv_defs.h                                          |    1 
 drivers/scsi/mvsas/mv_init.c                                          |   13 
 drivers/scsi/mvsas/mv_sas.c                                           |   42 -
 drivers/scsi/mvsas/mv_sas.h                                           |    8 
 drivers/scsi/myrs.c                                                   |    8 
 drivers/scsi/pm8001/pm8001_sas.c                                      |    9 
 drivers/scsi/qla2xxx/qla_edif.c                                       |    4 
 drivers/scsi/qla2xxx/qla_init.c                                       |    4 
 drivers/soc/qcom/rpmh-rsc.c                                           |    7 
 drivers/spi/spi-cadence-quadspi.c                                     |    5 
 drivers/staging/axis-fifo/axis-fifo.c                                 |   32 -
 drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h |    5 
 drivers/target/target_core_configfs.c                                 |    2 
 drivers/thermal/qcom/Kconfig                                          |    3 
 drivers/thermal/qcom/lmh.c                                            |    2 
 drivers/tty/serial/Kconfig                                            |    2 
 drivers/uio/uio_hv_generic.c                                          |    7 
 drivers/usb/cdns3/cdnsp-pci.c                                         |    5 
 drivers/usb/gadget/configfs.c                                         |    2 
 drivers/usb/host/max3421-hcd.c                                        |    2 
 drivers/usb/host/xhci-ring.c                                          |   11 
 drivers/usb/phy/phy-twl6030-usb.c                                     |    3 
 drivers/usb/serial/option.c                                           |    6 
 drivers/usb/usbip/vhci_hcd.c                                          |   22 
 drivers/virt/acrn/ioreq.c                                             |    4 
 drivers/watchdog/mpc8xxx_wdt.c                                        |    2 
 drivers/xen/events/events_base.c                                      |   20 
 drivers/xen/manage.c                                                  |    3 
 fs/btrfs/export.c                                                     |    8 
 fs/btrfs/extent_io.c                                                  |   14 
 fs/btrfs/misc.h                                                       |    2 
 fs/btrfs/tree-checker.c                                               |    2 
 fs/cramfs/inode.c                                                     |   11 
 fs/erofs/zdata.h                                                      |    2 
 fs/ext2/balloc.c                                                      |    2 
 fs/ext4/ext4.h                                                        |   12 
 fs/ext4/file.c                                                        |    2 
 fs/ext4/fsmap.c                                                       |   14 
 fs/ext4/inode.c                                                       |   12 
 fs/ext4/orphan.c                                                      |   23 
 fs/ext4/super.c                                                       |    4 
 fs/ext4/xattr.c                                                       |   15 
 fs/file.c                                                             |    5 
 fs/fs-writeback.c                                                     |   32 -
 fs/fsopen.c                                                           |   70 +-
 fs/ksmbd/smb2pdu.c                                                    |    3 
 fs/minix/inode.c                                                      |    8 
 fs/namei.c                                                            |    8 
 fs/namespace.c                                                        |   11 
 fs/nfs/nfs4proc.c                                                     |    2 
 fs/nfsd/lockd.c                                                       |   15 
 fs/nfsd/nfs4proc.c                                                    |    2 
 fs/ntfs3/bitmap.c                                                     |    1 
 fs/ntfs3/run.c                                                        |   12 
 fs/ocfs2/stack_user.c                                                 |    1 
 fs/squashfs/inode.c                                                   |   31 +
 fs/squashfs/squashfs_fs_i.h                                           |    2 
 fs/udf/inode.c                                                        |    3 
 fs/ufs/util.h                                                         |    6 
 include/linux/cleanup.h                                               |  171 ++++++
 include/linux/compiler-clang.h                                        |    9 
 include/linux/compiler.h                                              |    9 
 include/linux/compiler_attributes.h                                   |    6 
 include/linux/device.h                                                |   10 
 include/linux/file.h                                                  |    6 
 include/linux/iio/frequency/adf4350.h                                 |    2 
 include/linux/irqflags.h                                              |    7 
 include/linux/minmax.h                                                |  264 +++++++---
 include/linux/mutex.h                                                 |    4 
 include/linux/percpu.h                                                |    4 
 include/linux/preempt.h                                               |   47 +
 include/linux/rcupdate.h                                              |    3 
 include/linux/rwsem.h                                                 |    8 
 include/linux/sched/task.h                                            |    2 
 include/linux/slab.h                                                  |    3 
 include/linux/spinlock.h                                              |   32 +
 include/linux/srcu.h                                                  |    5 
 include/scsi/libsas.h                                                 |   18 
 include/trace/events/filelock.h                                       |    3 
 init/main.c                                                           |   14 
 kernel/bpf/inode.c                                                    |    4 
 kernel/fork.c                                                         |    2 
 kernel/pid.c                                                          |    2 
 kernel/smp.c                                                          |   11 
 kernel/trace/preemptirq_delay_test.c                                  |    2 
 kernel/trace/trace_kprobe.c                                           |   11 
 kernel/trace/trace_probe.h                                            |    9 
 kernel/trace/trace_uprobe.c                                           |   12 
 lib/btree.c                                                           |    1 
 lib/crypto/Makefile                                                   |    4 
 lib/decompress_unlzma.c                                               |    2 
 lib/genalloc.c                                                        |    5 
 lib/logic_pio.c                                                       |    3 
 lib/vsprintf.c                                                        |    2 
 lib/zstd/zstd_internal.h                                              |    2 
 mm/hugetlb.c                                                          |    2 
 mm/page_alloc.c                                                       |    2 
 mm/zsmalloc.c                                                         |    1 
 net/9p/trans_fd.c                                                     |    8 
 net/bluetooth/mgmt.c                                                  |   10 
 net/bridge/br_vlan.c                                                  |    2 
 net/core/filter.c                                                     |   18 
 net/ipv4/proc.c                                                       |    2 
 net/ipv4/tcp.c                                                        |    9 
 net/ipv4/tcp_input.c                                                  |    1 
 net/ipv4/udp.c                                                        |   16 
 net/ipv6/proc.c                                                       |    2 
 net/mptcp/pm.c                                                        |    7 
 net/mptcp/pm_netlink.c                                                |   49 +
 net/mptcp/protocol.h                                                  |    8 
 net/netfilter/ipset/ip_set_hash_gen.h                                 |    8 
 net/netfilter/ipvs/ip_vs_ftp.c                                        |    4 
 net/netfilter/nf_nat_core.c                                           |    6 
 net/nfc/nci/ntf.c                                                     |  135 +++--
 net/sctp/sm_make_chunk.c                                              |    3 
 net/sctp/sm_statefuns.c                                               |    6 
 net/tipc/core.h                                                       |    2 
 net/tipc/link.c                                                       |   10 
 scripts/checkpatch.pl                                                 |    2 
 security/keys/trusted-keys/trusted_tpm1.c                             |    7 
 sound/pci/lx6464es/lx_core.c                                          |    4 
 sound/soc/codecs/wcd934x.c                                            |   30 -
 sound/soc/intel/boards/bytcht_es8316.c                                |   20 
 sound/soc/intel/boards/bytcr_rt5640.c                                 |    7 
 sound/soc/intel/boards/bytcr_rt5651.c                                 |   26 
 tools/build/feature/Makefile                                          |    4 
 tools/include/nolibc/std.h                                            |    2 
 tools/lib/bpf/libbpf.c                                                |   10 
 tools/lib/perf/include/perf/event.h                                   |    1 
 tools/lib/subcmd/help.c                                               |    3 
 tools/perf/tests/perf-record.c                                        |    4 
 tools/perf/util/evsel.c                                               |    2 
 tools/perf/util/lzma.c                                                |    2 
 tools/perf/util/session.c                                             |    2 
 tools/perf/util/zlib.c                                                |    2 
 tools/testing/nvdimm/test/ndtest.c                                    |   13 
 tools/testing/selftests/arm64/pauth/exec_target.c                     |    7 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                       |   10 
 tools/testing/selftests/rseq/rseq.c                                   |    8 
 tools/testing/selftests/vm/mremap_test.c                              |    2 
 tools/testing/selftests/watchdog/watchdog-test.c                      |    6 
 330 files changed, 2535 insertions(+), 1006 deletions(-)

Aaron Kling (1):
      cpufreq: tegra186: Set target frequency for all cpus in policy

Abdun Nihaal (1):
      wifi: mt76: fix potential memory leak in mt76_wmac_probe()

Adam Xue (1):
      bus: mhi: host: Do not use uninitialized 'dev' pointer in mhi_init_irq_setup()

Ahmet Eray Karadag (1):
      ext4: guard against EA inode refcount underflow in xattr update

Akhilesh Patil (1):
      selftests: watchdog: skip ping loop if WDIOF_KEEPALIVEPING not supported

Aleksa Sarai (1):
      fscontext: do not consume log entries when returning -EMSGSIZE

Alex Deucher (1):
      drm/amdgpu: Add additional DCE6 SCL registers

Alexandr Sapozhnikov (1):
      net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()

Alok Tiwari (2):
      PCI: tegra: Fix devm_kcalloc() argument order for port->phys allocation
      clk: nxp: Fix pll0 rate check condition in LPC18xx CGU driver

Amir Mohammad Jahangirzad (1):
      ACPI: debug: fix signedness issues in read/write helpers

Anderson Nascimento (1):
      btrfs: avoid potential out-of-bounds in btrfs_encode_fh()

Andy Shevchenko (3):
      gpio: wcd934x: Remove duplicate assignment of of_gpio_n_cells
      mfd: intel_soc_pmic_chtdc_ti: Drop unneeded assignment for cache_type
      minmax: deduplicate __unconst_integer_typeof()

AngeloGioacchino Del Regno (1):
      arm64: dts: mediatek: mt8516-pumpkin: Fix machine compatible

Anthony Iliopoulos (1):
      NFSv4.1: fix backchannel max_resp_sz verification check

Anthony Yznaga (1):
      sparc64: fix hugetlb for sun4u

Arnaud Lecomte (1):
      hid: fix I2C read buffer overflow in raw_event() for mcp2221

Askar Safin (1):
      openat2: don't trigger automounts with RESOLVE_NO_XDEV

Bagas Sanjaya (1):
      Documentation: trace: historgram-design: Separate sched_waking histogram section heading and the following diagram

Bala-Vignesh-Reddy (1):
      selftests: arm64: Check fread return value in exec_target

Baochen Qiang (1):
      wifi: ath10k: avoid unnecessary wait for service ready message

Bartosz Golaszewski (3):
      mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_data()
      pinctrl: check the return value of pinmux_ops::get_function_name()
      gpio: wcd934x: mark the GPIO controller as sleeping

Bernard Metzler (1):
      RDMA/siw: Always report immediate post SQ errors

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188

Brahmajit Das (1):
      drm/radeon/r600_cs: clean up of dead code in r600_cs

Brian Masney (2):
      clk: at91: peripheral: fix return value
      clk: nxp: lpc18xx-cgu: convert from round_rate() to determine_rate()

Brian Norris (1):
      PCI/sysfs: Ensure devices are powered for config reads

Catalin Marinas (1):
      arm64: mte: Do not flag the zero page as PG_mte_tagged

Christophe JAILLET (2):
      media: switch from 'pci_' to 'dma_' API
      media: pci/ivtv: switch from 'pci_' to 'dma_' API

Christophe Leroy (1):
      watchdog: mpc8xxx_wdt: Reload the watchdog timer when enabling the watchdog

Colin Ian King (2):
      misc: genwqe: Fix incorrect cmd field being reported in error
      ACPI: NFIT: Fix incorrect ndr_desc being reportedin dev_err message

Cristian Ciocaltea (1):
      usb: vhci-hcd: Prevent suspending virtually attached devices

Da Xue (1):
      pinctrl: meson-gxl: add missing i2c_d pinmux

Dan Carpenter (4):
      usb: host: max3421-hcd: Fix error pointer dereference in probe cleanup
      ocfs2: fix double free in user_cluster_connect()
      net/mlx4: prevent potential use after free in mlx4_en_do_uc_filter()
      mm/slab: make __free(kfree) accept error pointers

Daniel Borkmann (1):
      bpf: Fix metadata_dst leak __bpf_redirect_neigh_v{4,6}

Daniel Tang (1):
      ACPI: TAD: Add missing sysfs_remove_group() for ACPI_TAD_RT

Daniel Wagner (1):
      nvmet-fc: move lsop put work to nvmet_fc_ls_req_op

David Laight (8):
      minmax: fix indentation of __cmp_once() and __clamp_once()
      minmax.h: add whitespace around operators and after commas
      minmax.h: update some comments
      minmax.h: reduce the #define expansion of min(), max() and clamp()
      minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
      minmax.h: move all the clamp() definitions after the min/max() ones
      minmax.h: simplify the variants of clamp()
      minmax.h: remove some #defines that are only expanded once

Deepak Sharma (1):
      net: nfc: nci: Add parameter validation for packet data

Dmitry Baryshkov (2):
      thermal/drivers/qcom: Make LMH select QCOM_SCM
      thermal/drivers/qcom/lmh: Add missing IRQ includes

Donet Tom (2):
      drivers/base/node: handle error properly in register_one_node()
      drivers/base/node: fix double free in register_one_node()

Duoming Zhou (4):
      media: b2c2: Fix use-after-free causing by irq_check_work in flexcop_pci_remove
      media: tuner: xc5000: Fix use-after-free in xc5000_release
      media: i2c: tc358743: Fix use-after-free bugs caused by orphan timer in probe
      scsi: mvsas: Fix use-after-free bugs in mvs_work_queue

Edward Adam Davis (1):
      media: mc: Clear minor number before put device

Eric Biggers (2):
      KEYS: trusted_tpm1: Compare HMAC values in constant time
      sctp: Fix MAC comparison to be constant-time

Eric Dumazet (1):
      tcp: fix __tcp_close() to only send RST when required

Eric Woudstra (1):
      bridge: br_vlan_fill_forward_path_pvid: use br_vlan_group_rcu()

Erick Karanja (1):
      net: fsl_pq_mdio: Fix device node reference leak in fsl_pq_mdio_probe

Esben Haabendal (2):
      rtc: interface: Ensure alarm irq is enabled when UIE is enabled
      rtc: interface: Fix long-standing race when setting alarm

Florian Fainelli (1):
      cpufreq: scmi: Account for malformed DT in scmi_dev_used_by_cpus()

Geert Uytterhoeven (1):
      regmap: Remove superfluous check for !config in __regmap_init()

Georg Gottleuber (1):
      nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk

Greg Kroah-Hartman (1):
      Linux 5.15.195

Guangshuo Li (1):
      nvdimm: ndtest: Return -ENOMEM if devm_kcalloc() fails in ndtest_probe()

Gunnar Kudrjavets (1):
      tpm_tis: Fix incorrect arguments in tpm_tis_probe_irq_single

Hans de Goede (4):
      platform/x86: int3472: Check for adev == NULL
      iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
      mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
      mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag

Haoxiang Li (1):
      fs/ntfs3: Fix a resource leak bug in wnd_extend()

Harini T (2):
      mailbox: zynqmp-ipi: Remove redundant mbox_controller_unregister() call
      mailbox: zynqmp-ipi: Remove dev.parent check in zynqmp_ipi_free_mboxes

Herbert Xu (2):
      crypto: rng - Ensure set_ent is always present
      crypto: essiv - Check ssize for decryption and in-place encryption

Herve Codina (1):
      minmax: Introduce {min,max}_array()

Huacai Chen (1):
      init: handle bootloader identifier in kernel parameters

Huisong Li (1):
      ACPI: processor: idle: Fix memory leak when register cpuidle device failed

Håkon Bugge (1):
      RDMA/cm: Rate limit destroy CM ID timeout error message

I Viswanath (1):
      net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast

Ian Forbes (1):
      drm/vmwgfx: Fix Use-after-free in validation

Ian Rogers (3):
      perf evsel: Avoid container_of on a NULL leader
      libperf event: Ensure tracing data is multiple of 8 sized
      perf test: Don't leak workload gopipe in PERF_RECORD_*

Jakub Kicinski (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon MTU set"

Jan Kara (5):
      ext4: fix checks for orphan inodes
      ext4: verify orphan file size is not too big
      ext4: free orphan info with kvfree
      writeback: Avoid softlockup when switching many inodes
      writeback: Avoid excessively long inode switching times

Jason Andryuk (2):
      xen/events: Cleanup find_virq() return codes
      xen/events: Update virq_to_irq on migration

Jeff Layton (1):
      filelock: add FL_RECLAIM to show_fl_flags() macro

Jisheng Zhang (1):
      pwm: berlin: Fix wrong register in suspend/resume

Johan Hovold (3):
      firmware: firmware: meson-sm: fix compile-test default
      firmware: meson_sm: fix device leak at probe
      lib/genalloc: fix device leak in of_gen_pool_get()

John Garry (3):
      scsi: libsas: Add sas_task_find_rq()
      scsi: mvsas: Delete mvs_tag_init()
      scsi: mvsas: Use sas_task_find_rq() for tagging

KaFai Wan (1):
      bpf: Avoid RCU context warning when unpinning htab with internal structs

Kohei Enju (2):
      nfp: fix RSS hash key size when RSS is not supported
      net: ena: return 0 in ena_get_rxfh_key_size() when RSS hash key is not configurable

Krzysztof Kozlowski (1):
      ASoC: codecs: wcd934x: Simplify with dev_err_probe

Kunihiko Hayashi (1):
      i2c: designware: Add disabling clocks when probe fails

Kuniyuki Iwashima (2):
      udp: Fix memory accounting leak.
      tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().

Larshin Sergey (2):
      media: rc: fix races with imon_disconnect()
      fs: udf: fix OOB read in lengthAllocDescs handling

Leilk.Liu (1):
      i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD

Leo Yan (5):
      coresight: trbe: Prevent overflow in PERF_IDX2OFF()
      perf: arm_spe: Prevent overflow in PERF_IDX2OFF()
      coresight: trbe: Return NULL pointer for allocation failures
      perf session: Fix handling when buffer exceeds 2 GiB
      tools build: Align warning options with perf

Li Nan (1):
      blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unregister_hctx

Lichen Liu (1):
      fs: Add 'initramfs_options' to set initramfs mount options

Linus Torvalds (8):
      minmax: avoid overly complicated constant expressions in VM code
      minmax: add a few more MIN_T/MAX_T users
      minmax: simplify and clarify min_t()/max_t() implementation
      minmax: make generic MIN() and MAX() macros available everywhere
      minmax: don't use max() in situations that want a C constant expression
      minmax: simplify min()/max()/clamp() implementation
      minmax: improve macro expansion and type checking
      minmax: fix up min3() and max3() too

Linus Walleij (1):
      mtd: rawnand: fsmc: Default to autodetect buswidth

Lu Baolu (1):
      iommu/vt-d: PRS isn't usable if PDS isn't supported

Luiz Augusto von Dentz (1):
      Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO

Lukas Wunner (3):
      xen/manage: Fix suspend error path
      PCI/ERR: Fix uevent on failure to recover
      PCI/AER: Support errors introduced by PCIe r6.0

Ma Ke (2):
      sparc: fix error handling in scan_one_device()
      ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()

Marek Vasut (1):
      Input: atmel_mxt_ts - allow reset GPIO to sleep

Matthew Wilcox (Oracle) (1):
      minmax: add in_range() macro

Matthieu Baerts (NGI0) (2):
      mptcp: pm: in-kernel: usable client side with C-flag
      selftests: mptcp: join: validate C-flag + def limit

Matvey Kovalev (1):
      ksmbd: fix error code overwriting in smb2_get_info_filesystem()

Miaoqian Lin (2):
      usb: cdns3: cdnsp-pci: remove redundant pci_disable_device() call
      ARM: OMAP2+: pm33xx-core: ix device node reference leaks in amx3_idle_init

Michael Hennerich (2):
      iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE
      iio: frequency: adf4350: Fix prescaler usage.

Michael Karcher (5):
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
      sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
      sparc: fix accurate exception reporting in copy_to_user for Niagara 4
      sparc: fix accurate exception reporting in copy_{from,to}_user for M7

Michal Pecio (1):
      Revert "usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running"

Mikhail Kobuk (1):
      media: pci: ivtv: Add check for DMA map result

Mikulas Patocka (1):
      dm-integrity: limit MAX_TAG_SIZE to 255

Nalivayko Sergey (1):
      net/9p: fix double req put in p9_fd_cancelled

Nam Cao (2):
      powerpc/powernv/pci: Fix underflow and leak issue
      powerpc/pseries/msi: Fix potential underflow and leak issue

Naman Jain (1):
      uio_hv_generic: Let userspace take care of interrupt mask

Nathan Chancellor (1):
      lib/crypto/curve25519-hacl64: Disable KASAN with clang-17 and older

Nicolas Ferre (1):
      ARM: at91: pm: fix MCKx restore routine

Niklas Cassel (2):
      scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod
      PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()

Niklas Schnelle (2):
      PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV
      PCI/AER: Fix missing uevent on recovery when a reset is requested

Nishanth Menon (1):
      hwrng: ks-sa - fix division by zero in ks_sa_rng_init

Ojaswin Mujoo (1):
      ext4: correctly handle queries for metadata mappings

Oleksij Rempel (1):
      net: usb: asix: hold PM usage ref to avoid PM/MDIO + RTNL deadlock

Olga Kornievskaia (1):
      nfsd: nfserr_jukebox in nlm_fopen should lead to a retry

Ovidiu Panait (2):
      staging: axis-fifo: fix maximum TX packet length check
      staging: axis-fifo: flush RX FIFO on read errors

Parav Pandit (1):
      RDMA/core: Resolve MAC of next-hop device without ARP support

Paul Chaignon (1):
      bpf: Explicitly check accesses to bpf_sock_addr

Peter Zijlstra (1):
      locking: Introduce __cleanup() based infrastructure

Phillip Lougher (3):
      Squashfs: fix uninit-value in squashfs_get_parent
      Squashfs: add additional inode sanity checking
      Squashfs: reject negative file sizes in squashfs_read_inode()

Pratyush Yadav (2):
      spi: cadence-quadspi: Flush posted register writes before INDAC access
      spi: cadence-quadspi: Flush posted register writes before DAC access

Qianfeng Rong (10):
      regulator: scmi: Use int type to store negative error codes
      block: use int to store blk_stack_limits() return value
      pinctrl: renesas: Use int type to store negative error codes
      ALSA: lx_core: use int type to store negative error codes
      drm/amdkfd: Fix error code sign for EINVAL in svm_ioctl()
      scsi: qla2xxx: edif: Fix incorrect sign of error code
      scsi: qla2xxx: Fix incorrect sign of error code in START_SP_W_RETRIES()
      media: i2c: mt9v111: fix incorrect type for ret
      iio: dac: ad5360: use int type to store negative error codes
      iio: dac: ad5421: use int type to store negative error codes

Qu Wenruo (1):
      btrfs: fix the incorrect max_bytes value for find_lock_delalloc_range()

Rafael J. Wysocki (4):
      driver core/PM: Set power.no_callbacks along with power.no_pm
      PM: sleep: core: Clear power.must_resume in noirq suspend error path
      smp: Fix up and expand the smp_call_function_many() kerneldoc
      cpufreq: intel_pstate: Fix object lifecycle issue in update_qos_request()

Ranjan Kumar (1):
      scsi: mpt3sas: Fix crash in transport port remove by using ioc_info()

Raphael Gallais-Pou (1):
      serial: stm32: allow selecting console when the driver is module

Rex Chen (1):
      mmc: core: SPI mode remove cmd7

Ricardo Ribalda (1):
      media: tunner: xc5000: Refactor firmware load

Rob Herring (Arm) (1):
      rtc: x1205: Fix Xicor X1205 vendor prefix

Salah Triki (1):
      bus: fsl-mc: Check return value of platform_get_resource()

Sam James (1):
      parisc: don't reference obsolete termio struct for TC* constants

Sean Christopherson (4):
      rseq/selftests: Use weak symbol reference, not definition, to link with glibc
      x86/umip: Check that the instruction opcode is at least two bytes
      x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT aliases)
      KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O

Sean Nyekjaer (1):
      iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in resume

Shuhao Fu (1):
      drm/nouveau: fix bad ret code in nouveau_bo_move_prep

Siddharth Vadapalli (1):
      PCI: keystone: Use devm_request_irq() to free "ks-pcie-error-irq" on exit

Simon Schuster (1):
      copy_sighand: Handle architectures where sizeof(unsigned long) < sizeof(u64)

Slavin Liu (1):
      ipvs: Defer ip_vs_ftp unregister during netns cleanup

Sneh Mankad (1):
      soc: qcom: rpmh-rsc: Unconditionally clear _TRIGGER bit for TCS

Stanley Chu (1):
      i3c: master: svc: Recycle unused IBI slot

Stefan Kerkmann (1):
      wifi: mwifiex: send world regulatory domain to driver

Stephan Gerhold (3):
      remoteproc: qcom: q6v5: Avoid disabling handover IRQ twice
      arm64: dts: qcom: msm8916: Add missing MDSS reset
      arm64: dts: qcom: sdm845: Fix slimbam num-channels/ees

Takashi Iwai (3):
      ASoC: Intel: bytcht_es8316: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5640: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5651: Fix invalid quirk input mapping

Tetsuo Handa (2):
      minixfs: Verify inode mode when loading from disk
      cramfs: Verify inode mode when loading from disk

Thadeu Lima de Souza Cascardo (1):
      mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH allocations

Thomas Fourier (4):
      scsi: myrs: Fix dma_alloc_coherent() error check
      crypto: atmel - Fix dma_unmap_sg() direction
      media: cx18: Add missing check after DMA map
      media: pci: ivtv: Add missing check after DMA map

Thomas Weißschuh (1):
      fs: always return zero on success from replace_fd()

Thomas Zimmermann (1):
      drm/vmwgfx: Copy DRM hash-table code into driver

Thorsten Blum (2):
      scsi: hpsa: Fix potential memory leak in hpsa_big_passthru_ioctl()
      NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()

Timur Kristóf (4):
      drm/amdgpu: Power up UVD 3 for FW validation (v2)
      drm/amd/display: Add missing DCE6 SCL_HORZ_FILTER_INIT* SRIs
      drm/amd/display: Properly clear SCL_*_FILTER_CONTROL on DCE6
      drm/amd/display: Properly disable scaling on DCE6

Uros Bizjak (1):
      x86/vdso: Fix output operand size of RDPID

Uwe Kleine-König (1):
      pwm: tiehrpwm: Fix corner case in clock divisor calculation

Vasant Hegde (1):
      iommu/amd: Add map/unmap_pages() iommu_domain_ops callback support

Vineeth Vijayan (1):
      s390/cio: unregister the subchannel while purging

Vitaly Grigoryev (1):
      fs: ntfs3: Fix integer overflow in run_unpack()

Vlad Dumitrescu (1):
      IB/sa: Fix sa_local_svc_timeout_ms read race

Wang Haoran (1):
      scsi: target: target_core_configfs: Add length check to avoid buffer overflow

Wang Liang (1):
      pps: fix warning in pps_register_cdev when register device fail

Will Deacon (1):
      KVM: arm64: Fix softirq masking in FPSIMD register saving sequence

William Wu (1):
      usb: gadget: configfs: Correctly set use_os_string at bind

Xiaowei Li (1):
      USB: serial: option: add SIMCom 8230C compositions

Xichao Zhao (1):
      usb: phy: twl6030: Fix incorrect type for ret

Yang Shi (1):
      mm: hugetlb: avoid soft lockup when mprotect to large memory area

Yeounsu Moon (1):
      net: dlink: handle copy_thresh allocation failure

Yongjian Sun (1):
      ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()

Yuan Chen (1):
      tracing: Fix race condition in kprobe initialization causing NULL pointer dereference

Yunseong Kim (1):
      perf util: Fix compression checks returning -1 as bool

Yureka Lilian (1):
      libbpf: Fix reuse of DEVMAP

Zhang Shurong (1):
      media: rj54n1cb0c: Fix memleak in rj54n1_probe()

Zhen Ni (4):
      netfilter: ipset: Remove unused htable_bits in macro ahash_region
      Input: uinput - zero-initialize uinput_ff_upload_compat to avoid info leak
      clocksource/drivers/clps711x: Fix resource leaks in error paths
      memory: samsung: exynos-srom: Fix of_iomap leak in exynos_srom_probe

Zheng Qixing (1):
      dm: fix NULL pointer dereference in __dm_suspend()

Zhouyi Zhou (1):
      tools/nolibc: make time_t robust if __kernel_old_time_t is missing in host headers

gaoxiang17 (1):
      pid: Add a judgment for ns null in pid_nr_ns

hupu (1):
      perf subcmd: avoid crash in exclude_cmds when excludes is empty


