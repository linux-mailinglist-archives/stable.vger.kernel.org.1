Return-Path: <stable+bounces-191615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A950FC1AEED
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 14:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA8CD34783B
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037F6350D77;
	Wed, 29 Oct 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o0WvHZ2w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10DF350D74;
	Wed, 29 Oct 2025 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745281; cv=none; b=Km82ehenSGYSbFuwwi8vV4KEzPni3VXhSQwgR53RoO5WA4iwAYbSGnPfjAQUK1F/crMlAxGMfQ9mMiTsHpuDEZe8Tql8IM+LRt4mp0m6UObZ9vrauba4UDrElIofWHC4L/nXxzkNdrCJVtQjojuMd+52UWFxLyeMT6B+4rbpJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745281; c=relaxed/simple;
	bh=kz6XDEOxLCf8wM+DxcRQDd9Raubm/Bma2Ow5uvqqHuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nl7+9q8VlI1FH6i7y7PFrG65jJdwX34lIRnpKe9asm/KcdG3W3SfhPmwyLchotHQVij75rNbNTpYYg2WlnGP1MMLNAT5TFtWGyTkI1uw301IYC8KpcJqlpiy6X+/k3pvhclOHj1u/cGTk4NBjXSzmUKKo6hTI3NmdAQ4Tcn7d0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o0WvHZ2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3575C4CEFD;
	Wed, 29 Oct 2025 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761745281;
	bh=kz6XDEOxLCf8wM+DxcRQDd9Raubm/Bma2Ow5uvqqHuE=;
	h=From:To:Cc:Subject:Date:From;
	b=o0WvHZ2wNuPUuTyhH+PKzyHdZCc0E/7PGZOMnRzvkx2t6Kis9Xi0MP5U4/PFyy8eb
	 2fdX9nAQ1/BAOYEtK+nRbdqfnu5R8bv0ffAZmVkBxuPtGaHAOPjwNErbamO6kbpc0X
	 reA+NdzNQiytS+gbXX+GEEsi2WQmQ3nk3r8It8Wc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.246
Date: Wed, 29 Oct 2025 14:41:13 +0100
Message-ID: <2025102914-tuesday-pamphlet-f3e2@gregkh>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.246 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-pci                               |    9 
 Documentation/admin-guide/kernel-parameters.txt                       |    3 
 Documentation/arm64/silicon-errata.rst                                |    2 
 Documentation/trace/histogram-design.rst                              |    4 
 Makefile                                                              |    2 
 arch/arm/mach-omap2/pm33xx-core.c                                     |    6 
 arch/arm/mm/pageattr.c                                                |    6 
 arch/arm64/Kconfig                                                    |    1 
 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts                       |    2 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                  |    4 
 arch/arm64/include/asm/cputype.h                                      |    2 
 arch/arm64/include/asm/pgtable.h                                      |    3 
 arch/arm64/kernel/cpu_errata.c                                        |    1 
 arch/arm64/kernel/cpufeature.c                                        |   10 
 arch/arm64/kernel/mte.c                                               |    3 
 arch/m68k/include/asm/bitops.h                                        |   25 
 arch/mips/mti-malta/malta-setup.c                                     |    2 
 arch/parisc/include/uapi/asm/ioctls.h                                 |    8 
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
 block/blk-crypto-fallback.c                                           |    3 
 block/blk-mq-sysfs.c                                                  |    6 
 block/blk-settings.c                                                  |    3 
 crypto/essiv.c                                                        |   14 
 crypto/rng.c                                                          |    8 
 drivers/acpi/acpi_dbg.c                                               |   26 
 drivers/acpi/acpi_tad.c                                               |    3 
 drivers/acpi/nfit/core.c                                              |    2 
 drivers/acpi/processor_idle.c                                         |    3 
 drivers/android/binder.c                                              |   11 
 drivers/base/arch_topology.c                                          |    2 
 drivers/base/node.c                                                   |    4 
 drivers/base/power/main.c                                             |   14 
 drivers/base/power/runtime.c                                          |   44 +
 drivers/base/regmap/regmap.c                                          |    2 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                       |    3 
 drivers/bus/mhi/host/init.c                                           |    5 
 drivers/char/hw_random/ks-sa-rng.c                                    |    4 
 drivers/char/tpm/tpm_tis_core.c                                       |    4 
 drivers/clk/at91/clk-peripheral.c                                     |    7 
 drivers/clk/nxp/clk-lpc18xx-cgu.c                                     |   20 
 drivers/clocksource/clps711x-timer.c                                  |   23 
 drivers/cpufreq/intel_pstate.c                                        |    8 
 drivers/cpuidle/governors/menu.c                                      |   21 
 drivers/crypto/atmel-tdes.c                                           |    2 
 drivers/crypto/rockchip/rk3288_crypto_ahash.c                         |    3 
 drivers/dma/ioat/dma.c                                                |   12 
 drivers/edac/sb_edac.c                                                |    4 
 drivers/edac/skx_common.h                                             |    1 
 drivers/firmware/meson/meson_sm.c                                     |    7 
 drivers/gpio/gpio-wcd934x.c                                           |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                      |    5 
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c                                 |    7 
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                                 |    7 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                 |   29 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                     |    5 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c                    |   21 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h                    |    4 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c                   |    2 
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h                  |    7 
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h            |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h                    |   14 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                   |    3 
 drivers/gpu/drm/arm/display/include/malidp_utils.h                    |    2 
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c            |   24 
 drivers/gpu/drm/drm_color_mgmt.c                                      |    2 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c                            |   36 -
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                 |    6 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                  |    2 
 drivers/gpu/drm/radeon/evergreen_cs.c                                 |    2 
 drivers/gpu/drm/radeon/r600_cs.c                                      |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c                            |    4 
 drivers/hid/hid-mcp2221.c                                             |    4 
 drivers/hid/hid-multitouch.c                                          |   27 -
 drivers/hwmon/adt7475.c                                               |   24 
 drivers/i2c/busses/i2c-designware-platdrv.c                           |    1 
 drivers/i2c/busses/i2c-mt65xx.c                                       |   17 
 drivers/iio/dac/ad5360.c                                              |    2 
 drivers/iio/dac/ad5421.c                                              |    2 
 drivers/iio/frequency/adf4350.c                                       |   20 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                     |    5 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c                      |   39 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                      |    5 
 drivers/iio/inkern.c                                                  |    2 
 drivers/infiniband/core/addr.c                                        |   10 
 drivers/infiniband/core/cm.c                                          |    4 
 drivers/infiniband/core/sa_query.c                                    |    6 
 drivers/infiniband/sw/siw/siw_verbs.c                                 |   25 
 drivers/input/misc/uinput.c                                           |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                              |    2 
 drivers/input/touchscreen/cyttsp4_core.c                              |    2 
 drivers/mailbox/zynqmp-ipi-mailbox.c                                  |    7 
 drivers/md/dm-integrity.c                                             |    8 
 drivers/md/dm.c                                                       |    7 
 drivers/media/dvb-frontends/stv0367_priv.h                            |    3 
 drivers/media/i2c/mt9v111.c                                           |    2 
 drivers/media/i2c/rj54n1cb0c.c                                        |    9 
 drivers/media/i2c/tc358743.c                                          |    4 
 drivers/media/mc/mc-devnode.c                                         |    6 
 drivers/media/pci/b2c2/flexcop-pci.c                                  |    2 
 drivers/media/pci/cx18/cx18-queue.c                                   |   12 
 drivers/media/pci/ivtv/ivtv-driver.c                                  |    2 
 drivers/media/pci/ivtv/ivtv-irq.c                                     |    2 
 drivers/media/pci/ivtv/ivtv-queue.c                                   |   18 
 drivers/media/pci/ivtv/ivtv-streams.c                                 |   22 
 drivers/media/pci/ivtv/ivtv-udma.c                                    |   27 -
 drivers/media/pci/ivtv/ivtv-yuv.c                                     |   24 
 drivers/media/pci/ivtv/ivtvfb.c                                       |    6 
 drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c                       |   35 -
 drivers/media/rc/imon.c                                               |   27 -
 drivers/media/rc/lirc_dev.c                                           |   15 
 drivers/media/rc/rc-main.c                                            |    6 
 drivers/media/tuners/xc5000.c                                         |   41 -
 drivers/memory/samsung/exynos-srom.c                                  |   10 
 drivers/mfd/intel_soc_pmic_chtdc_ti.c                                 |    5 
 drivers/mfd/vexpress-sysreg.c                                         |    6 
 drivers/misc/genwqe/card_ddcb.c                                       |    2 
 drivers/misc/mei/hw-me-regs.h                                         |    2 
 drivers/misc/mei/pci-me.c                                             |    2 
 drivers/mmc/core/sdio.c                                               |    6 
 drivers/most/most_usb.c                                               |   13 
 drivers/mtd/nand/raw/fsmc_nand.c                                      |    6 
 drivers/net/bonding/bond_main.c                                       |   40 -
 drivers/net/ethernet/amazon/ena/ena_ethtool.c                         |    5 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                              |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                             |    1 
 drivers/net/ethernet/broadcom/tg3.c                                   |    5 
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c                       |   18 
 drivers/net/ethernet/dlink/dl2k.c                                     |   30 -
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                      |    3 
 drivers/net/ethernet/freescale/enetc/enetc.h                          |    2 
 drivers/net/ethernet/freescale/fsl_pq_mdio.c                          |    2 
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h              |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                     |   17 
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c                  |    2 
 drivers/net/ethernet/realtek/r8169_main.c                             |    5 
 drivers/net/ethernet/renesas/ravb_main.c                              |    8 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                     |    2 
 drivers/net/fjes/fjes_main.c                                          |    4 
 drivers/net/usb/aqc111.c                                              |    2 
 drivers/net/usb/lan78xx.c                                             |   42 +
 drivers/net/usb/r8152.c                                               |    2 
 drivers/net/usb/rndis_host.c                                          |    2 
 drivers/net/usb/rtl8150.c                                             |   15 
 drivers/net/wireless/ath/ath11k/core.c                                |    6 
 drivers/net/wireless/ath/ath11k/hal.c                                 |   16 
 drivers/net/wireless/ath/ath11k/hal.h                                 |    1 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                       |    7 
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c                       |    2 
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c                        |    8 
 drivers/net/wireless/ralink/rt2x00/rt2400pci.h                        |    2 
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c                        |    8 
 drivers/net/wireless/ralink/rt2x00/rt2500pci.h                        |    2 
 drivers/net/wireless/ralink/rt2x00/rt2500usb.c                        |    8 
 drivers/net/wireless/ralink/rt2x00/rt2500usb.h                        |    2 
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c                        |   36 -
 drivers/net/wireless/ralink/rt2x00/rt2800lib.h                        |    8 
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c                        |    6 
 drivers/net/wireless/ralink/rt2x00/rt61pci.c                          |    4 
 drivers/net/wireless/ralink/rt2x00/rt61pci.h                          |    2 
 drivers/net/wireless/ralink/rt2x00/rt73usb.c                          |    4 
 drivers/net/wireless/ralink/rt2x00/rt73usb.h                          |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c                   |    1 
 drivers/nfc/pn544/i2c.c                                               |    2 
 drivers/pci/controller/cadence/pci-j721e.c                            |   25 
 drivers/pci/controller/dwc/pci-keystone.c                             |    4 
 drivers/pci/controller/dwc/pcie-tegra194.c                            |   22 
 drivers/pci/controller/pci-tegra.c                                    |    2 
 drivers/pci/iov.c                                                     |    5 
 drivers/pci/pci-driver.c                                              |    1 
 drivers/pci/pci-label.c                                               |   10 
 drivers/pci/pci-sysfs.c                                               |   98 ++-
 drivers/pci/pcie/aer.c                                                |   12 
 drivers/pci/pcie/err.c                                                |    8 
 drivers/perf/arm_spe_pmu.c                                            |    3 
 drivers/pinctrl/meson/pinctrl-meson-gxl.c                             |   10 
 drivers/pinctrl/pinmux.c                                              |    2 
 drivers/pinctrl/renesas/pinctrl.c                                     |    3 
 drivers/platform/x86/sony-laptop.c                                    |    1 
 drivers/pps/kapi.c                                                    |    5 
 drivers/pps/pps.c                                                     |    5 
 drivers/pwm/pwm-berlin.c                                              |    4 
 drivers/pwm/pwm-tiehrpwm.c                                            |    4 
 drivers/remoteproc/qcom_q6v5.c                                        |    3 
 drivers/rtc/interface.c                                               |   27 +
 drivers/rtc/rtc-x1205.c                                               |    2 
 drivers/scsi/hpsa.c                                                   |   21 
 drivers/scsi/isci/init.c                                              |    6 
 drivers/scsi/mpt3sas/mpt3sas_transport.c                              |    8 
 drivers/scsi/mvsas/mv_defs.h                                          |    1 
 drivers/scsi/mvsas/mv_init.c                                          |   13 
 drivers/scsi/mvsas/mv_sas.c                                           |   42 -
 drivers/scsi/mvsas/mv_sas.h                                           |    8 
 drivers/scsi/myrs.c                                                   |    8 
 drivers/scsi/pm8001/pm8001_sas.c                                      |    9 
 drivers/soc/qcom/rpmh-rsc.c                                           |    7 
 drivers/spi/spi-cadence-quadspi.c                                     |    5 
 drivers/staging/axis-fifo/axis-fifo.c                                 |   32 -
 drivers/staging/comedi/comedi_buf.c                                   |    2 
 drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h |    5 
 drivers/target/target_core_configfs.c                                 |    2 
 drivers/tty/serial/8250/8250_exar.c                                   |   11 
 drivers/tty/serial/Kconfig                                            |    2 
 drivers/tty/serial/max310x.c                                          |    2 
 drivers/uio/uio_hv_generic.c                                          |    7 
 drivers/usb/core/quirks.c                                             |    2 
 drivers/usb/gadget/configfs.c                                         |    2 
 drivers/usb/gadget/legacy/raw_gadget.c                                |    2 
 drivers/usb/host/max3421-hcd.c                                        |    2 
 drivers/usb/host/xhci-dbgcap.c                                        |    9 
 drivers/usb/phy/phy-twl6030-usb.c                                     |    3 
 drivers/usb/serial/option.c                                           |   16 
 drivers/usb/usbip/vhci_hcd.c                                          |   22 
 drivers/watchdog/mpc8xxx_wdt.c                                        |    2 
 drivers/xen/events/events_base.c                                      |   20 
 drivers/xen/manage.c                                                  |    3 
 fs/btrfs/ctree.h                                                      |    2 
 fs/btrfs/export.c                                                     |    8 
 fs/btrfs/extent_io.c                                                  |    1 
 fs/btrfs/file-item.c                                                  |    1 
 fs/btrfs/misc.h                                                       |    2 
 fs/btrfs/raid56.c                                                     |    1 
 fs/btrfs/tree-checker.c                                               |    2 
 fs/cramfs/inode.c                                                     |   11 
 fs/dax.c                                                              |   54 +-
 fs/dcache.c                                                           |    2 
 fs/dlm/lockspace.c                                                    |    2 
 fs/erofs/zdata.h                                                      |    2 
 fs/exec.c                                                             |    2 
 fs/ext2/balloc.c                                                      |    2 
 fs/ext4/ext4.h                                                        |    2 
 fs/ext4/fsmap.c                                                       |   14 
 fs/ext4/inode.c                                                       |   18 
 fs/ext4/super.c                                                       |   10 
 fs/ext4/xattr.c                                                       |   15 
 fs/file.c                                                             |    5 
 fs/fsopen.c                                                           |   70 +-
 fs/fuse/file.c                                                        |    8 
 fs/hfs/bfind.c                                                        |    8 
 fs/hfs/brec.c                                                         |   27 -
 fs/hfs/mdb.c                                                          |    2 
 fs/hfsplus/bfind.c                                                    |    8 
 fs/hfsplus/bnode.c                                                    |   41 -
 fs/hfsplus/btree.c                                                    |    6 
 fs/hfsplus/hfsplus_fs.h                                               |   42 +
 fs/hfsplus/super.c                                                    |   25 
 fs/hfsplus/unicode.c                                                  |   24 
 fs/iomap/apply.c                                                      |   74 ++
 fs/iomap/trace.h                                                      |   37 +
 fs/jbd2/transaction.c                                                 |   13 
 fs/minix/inode.c                                                      |    8 
 fs/namei.c                                                            |    8 
 fs/namespace.c                                                        |   11 
 fs/nfs/nfs4proc.c                                                     |    2 
 fs/nfsd/blocklayout.c                                                 |    5 
 fs/nfsd/blocklayoutxdr.c                                              |    7 
 fs/nfsd/flexfilelayout.c                                              |    8 
 fs/nfsd/flexfilelayoutxdr.c                                           |    3 
 fs/nfsd/lockd.c                                                       |   15 
 fs/nfsd/nfs4layouts.c                                                 |    1 
 fs/nfsd/nfs4proc.c                                                    |   36 -
 fs/nfsd/nfs4xdr.c                                                     |   14 
 fs/nfsd/xdr4.h                                                        |   36 +
 fs/ocfs2/move_extents.c                                               |    5 
 fs/ocfs2/stack_user.c                                                 |    1 
 fs/squashfs/inode.c                                                   |   31 +
 fs/squashfs/squashfs_fs_i.h                                           |    2 
 fs/udf/inode.c                                                        |   12 
 fs/ufs/util.h                                                         |    6 
 include/linux/cleanup.h                                               |  171 ++++++
 include/linux/compiler-clang.h                                        |    9 
 include/linux/compiler.h                                              |   15 
 include/linux/compiler_attributes.h                                   |    6 
 include/linux/device.h                                                |   10 
 include/linux/file.h                                                  |    6 
 include/linux/iio/frequency/adf4350.h                                 |    2 
 include/linux/iomap.h                                                 |   56 ++
 include/linux/irqflags.h                                              |    7 
 include/linux/minmax.h                                                |  267 +++++++---
 include/linux/mutex.h                                                 |    4 
 include/linux/netdevice.h                                             |    9 
 include/linux/overflow.h                                              |    1 
 include/linux/percpu.h                                                |    4 
 include/linux/pm_runtime.h                                            |    4 
 include/linux/preempt.h                                               |    5 
 include/linux/rcupdate.h                                              |    3 
 include/linux/rwsem.h                                                 |    9 
 include/linux/sched/task.h                                            |    2 
 include/linux/slab.h                                                  |    3 
 include/linux/spinlock.h                                              |   32 +
 include/linux/srcu.h                                                  |    5 
 include/linux/trace_events.h                                          |    2 
 include/net/ip_tunnels.h                                              |   15 
 include/net/rtnetlink.h                                               |   16 
 include/scsi/libsas.h                                                 |   18 
 include/trace/events/filelock.h                                       |    3 
 include/uapi/linux/netlink.h                                          |    1 
 init/main.c                                                           |   14 
 kernel/fork.c                                                         |    2 
 kernel/padata.c                                                       |    6 
 kernel/pid.c                                                          |    2 
 kernel/sched/fair.c                                                   |   38 -
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
 mm/zsmalloc.c                                                         |    1 
 net/9p/trans_fd.c                                                     |    8 
 net/bluetooth/mgmt.c                                                  |   10 
 net/core/filter.c                                                     |   18 
 net/core/rtnetlink.c                                                  |   87 ++-
 net/ipv4/ip_tunnel.c                                                  |   14 
 net/ipv4/proc.c                                                       |    2 
 net/ipv4/tcp.c                                                        |    9 
 net/ipv4/tcp_input.c                                                  |    1 
 net/ipv4/tcp_output.c                                                 |   19 
 net/ipv4/udp.c                                                        |   16 
 net/ipv6/ip6_tunnel.c                                                 |    3 
 net/ipv6/proc.c                                                       |    2 
 net/netfilter/ipset/ip_set_hash_gen.h                                 |    8 
 net/netfilter/ipvs/ip_vs_ftp.c                                        |    4 
 net/netfilter/nf_nat_core.c                                           |    6 
 net/sctp/inqueue.c                                                    |   13 
 net/sctp/sm_make_chunk.c                                              |    3 
 net/sctp/sm_statefuns.c                                               |    6 
 net/tipc/core.h                                                       |    2 
 net/tipc/link.c                                                       |   10 
 net/tls/tls_main.c                                                    |    7 
 net/tls/tls_sw.c                                                      |   13 
 net/vmw_vsock/af_vsock.c                                              |   38 -
 scripts/checkpatch.pl                                                 |    2 
 security/keys/trusted-keys/trusted_tpm1.c                             |    7 
 sound/firewire/amdtp-stream.h                                         |    2 
 sound/pci/lx6464es/lx_core.c                                          |    4 
 sound/soc/codecs/wcd934x.c                                            |   30 -
 sound/soc/intel/boards/bytcht_es8316.c                                |   20 
 sound/soc/intel/boards/bytcr_rt5640.c                                 |    7 
 sound/soc/intel/boards/bytcr_rt5651.c                                 |   26 
 tools/build/feature/Makefile                                          |    4 
 tools/lib/bpf/libbpf.c                                                |   10 
 tools/lib/perf/include/perf/event.h                                   |    1 
 tools/lib/subcmd/help.c                                               |    3 
 tools/perf/util/lzma.c                                                |    2 
 tools/perf/util/session.c                                             |    2 
 tools/perf/util/zlib.c                                                |    2 
 tools/testing/selftests/arm64/pauth/exec_target.c                     |    7 
 tools/testing/selftests/rseq/rseq.c                                   |    8 
 tools/testing/selftests/watchdog/watchdog-test.c                      |    6 
 372 files changed, 2798 insertions(+), 1320 deletions(-)

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

Alexander Aring (1):
      dlm: check for defined force value in dlm_lockspace_release

Alexander Usyskin (1):
      mei: me: add wildcat lake P DID

Alexandr Sapozhnikov (1):
      net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()

Alexey Simakov (2):
      tg3: prevent use of uninitialized remote_adv and local_adv variables
      sctp: avoid NULL dereference when chunk data buffer is missing

Alice Ryhl (1):
      binder: remove "invalid inc weak" check

Alok Tiwari (2):
      PCI: tegra: Fix devm_kcalloc() argument order for port->phys allocation
      clk: nxp: Fix pll0 rate check condition in LPC18xx CGU driver

Amir Mohammad Jahangirzad (1):
      ACPI: debug: fix signedness issues in read/write helpers

Anderson Nascimento (1):
      btrfs: avoid potential out-of-bounds in btrfs_encode_fh()

Andrey Konovalov (1):
      usb: raw-gadget: do not limit transfer length

Andy Shevchenko (4):
      gpio: wcd934x: Remove duplicate assignment of of_gpio_n_cells
      mfd: intel_soc_pmic_chtdc_ti: Drop unneeded assignment for cache_type
      minmax: deduplicate __unconst_integer_typeof()
      minmax: fix header inclusions

AngeloGioacchino Del Regno (1):
      arm64: dts: mediatek: mt8516-pumpkin: Fix machine compatible

Anthony Iliopoulos (1):
      NFSv4.1: fix backchannel max_resp_sz verification check

Anthony Yznaga (1):
      sparc64: fix hugetlb for sun4u

Arnaud Lecomte (1):
      hid: fix I2C read buffer overflow in raw_event() for mcp2221

Arnd Bergmann (1):
      media: s5p-mfc: remove an unused/uninitialized variable

Askar Safin (1):
      openat2: don't trigger automounts with RESOLVE_NO_XDEV

Bagas Sanjaya (1):
      Documentation: trace: historgram-design: Separate sched_waking histogram section heading and the following diagram

Bala-Vignesh-Reddy (1):
      selftests: arm64: Check fread return value in exec_target

Barry Song (1):
      sched/fair: Trivial correction of the newidle_balance() comment

Bart Van Assche (1):
      overflow, tracing: Define the is_signed_type() macro once

Bartosz Golaszewski (3):
      mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_data()
      pinctrl: check the return value of pinmux_ops::get_function_name()
      gpio: wcd934x: mark the GPIO controller as sleeping

Bence Csókás (1):
      PM: runtime: Add new devm functions

Benjamin Tissoires (1):
      HID: multitouch: fix sticky fingers

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

Christoph Hellwig (2):
      iomap: add the new iomap_iter model
      fsdax: switch dax_iomap_rw to use iomap_iter

Christophe JAILLET (1):
      media: pci/ivtv: switch from 'pci_' to 'dma_' API

Christophe Leroy (1):
      watchdog: mpc8xxx_wdt: Reload the watchdog timer when enabling the watchdog

Chuck Lever (1):
      NFSD: Define a proc_layoutcommit for the FlexFiles layout type

Colin Ian King (2):
      misc: genwqe: Fix incorrect cmd field being reported in error
      ACPI: NFIT: Fix incorrect ndr_desc being reportedin dev_err message

Cristian Ciocaltea (1):
      usb: vhci-hcd: Prevent suspending virtually attached devices

Da Xue (1):
      pinctrl: meson-gxl: add missing i2c_d pinmux

Dan Carpenter (5):
      usb: host: max3421-hcd: Fix error pointer dereference in probe cleanup
      serial: max310x: Add error checking in probe()
      ocfs2: fix double free in user_cluster_connect()
      net/mlx4: prevent potential use after free in mlx4_en_do_uc_filter()
      mm/slab: make __free(kfree) accept error pointers

Daniel Borkmann (1):
      bpf: Fix metadata_dst leak __bpf_redirect_neigh_v{4,6}

Daniel Tang (1):
      ACPI: TAD: Add missing sysfs_remove_group() for ACPI_TAD_RT

Darrick J. Wong (1):
      fuse: fix livelock in synchronous file put from fuseblk workers

David Laight (11):
      minmax: allow min()/max()/clamp() if the arguments have the same signedness.
      minmax: fix indentation of __cmp_once() and __clamp_once()
      minmax: allow comparisons of 'int' against 'unsigned char/short'
      minmax: relax check to allow comparison between unsigned arguments and signed constants
      minmax.h: add whitespace around operators and after commas
      minmax.h: update some comments
      minmax.h: reduce the #define expansion of min(), max() and clamp()
      minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
      minmax.h: move all the clamp() definitions after the min/max() ones
      minmax.h: simplify the variants of clamp()
      minmax.h: remove some #defines that are only expanded once

David Lechner (1):
      iio: imu: inv_icm42600: use = { } instead of memset()

Deepanshu Kartikey (3):
      ext4: detect invalid INLINE_DATA + EXTENTS flag combination
      ocfs2: clear extent cache after moving/defragmenting extents
      comedi: fix divide-by-zero in comedi_buf_munge()

Dmitry Safonov (1):
      net/ip6_tunnel: Prevent perpetual tunnel growth

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
      sctp: Fix MAC comparison to be constant-time
      KEYS: trusted_tpm1: Compare HMAC values in constant time

Eric Dumazet (2):
      tcp: fix __tcp_close() to only send RST when required
      tcp: fix tcp_tso_should_defer() vs large RTT

Erick Karanja (1):
      net: fsl_pq_mdio: Fix device node reference leak in fsl_pq_mdio_probe

Esben Haabendal (2):
      rtc: interface: Ensure alarm irq is enabled when UIE is enabled
      rtc: interface: Fix long-standing race when setting alarm

Florian Eckert (1):
      serial: 8250_exar: add support for Advantech 2 port card with Device ID 0x0018

Geert Uytterhoeven (2):
      regmap: Remove superfluous check for !config in __regmap_init()
      m68k: bitops: Fix find_*_bit() signatures

Gianfranco Trad (1):
      udf: fix uninit-value use in udf_get_fileshortad

Greg Kroah-Hartman (1):
      Linux 5.10.246

Gui-Dong Han (1):
      drm/amdgpu: use atomic functions with memory barriers for vm fault info

Gunnar Kudrjavets (1):
      tpm_tis: Fix incorrect arguments in tpm_tis_probe_irq_single

Hans de Goede (3):
      iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
      mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
      mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag

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

Huang Ying (1):
      arm64, mm: avoid always making PTE dirty in pte_mkwrite()

Huisong Li (1):
      ACPI: processor: idle: Fix memory leak when register cpuidle device failed

Håkon Bugge (1):
      RDMA/cm: Rate limit destroy CM ID timeout error message

I Viswanath (2):
      net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
      net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset

Ian Forbes (1):
      drm/vmwgfx: Fix Use-after-free in validation

Ian Rogers (1):
      libperf event: Ensure tracing data is multiple of 8 sized

Igor Artemiev (1):
      drm/amd/display: Fix potential null dereference

Ingo Molnar (1):
      sched/balancing: Rename newidle_balance() => sched_balance_newidle()

Ioana Ciornei (1):
      dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx path

Jakub Kicinski (2):
      Revert "net/mlx5e: Update and set Xon/Xoff upon MTU set"
      net: usb: use eth_hw_addr_set() instead of ether_addr_copy()

Jan Kara (1):
      vfs: Don't leak disconnected dentries on umount

Jason A. Donenfeld (3):
      minmax: sanity check constant bounds when clamping
      minmax: clamp more efficiently by avoiding extra comparison
      wifi: rt2x00: use explicitly signed or unsigned types

Jason Andryuk (2):
      xen/events: Cleanup find_virq() return codes
      xen/events: Update virq_to_irq on migration

Jeff Layton (1):
      filelock: add FL_RECLAIM to show_fl_flags() macro

Jisheng Zhang (1):
      pwm: berlin: Fix wrong register in suspend/resume

Johan Hovold (2):
      firmware: meson_sm: fix device leak at probe
      lib/genalloc: fix device leak in of_gen_pool_get()

Johannes Thumshirn (1):
      btrfs: remove duplicated in_range() macro

Johannes Wiesböck (1):
      rtnetlink: Allow deleting FDB entries in user namespace

John Garry (3):
      scsi: libsas: Add sas_task_find_rq()
      scsi: mvsas: Delete mvs_tag_init()
      scsi: mvsas: Use sas_task_find_rq() for tagging

Kaushlendra Kumar (1):
      arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()

Kaustabh Chakraborty (1):
      drm/exynos: exynos7_drm_decon: remove ctx->suspended

Kohei Enju (2):
      nfp: fix RSS hash key size when RSS is not supported
      net: ena: return 0 in ena_get_rxfh_key_size() when RSS hash key is not configurable

Krzysztof Kozlowski (1):
      ASoC: codecs: wcd934x: Simplify with dev_err_probe

Krzysztof Wilczyński (1):
      PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions

Kunihiko Hayashi (1):
      i2c: designware: Add disabling clocks when probe fails

Kuniyuki Iwashima (2):
      udp: Fix memory accounting leak.
      tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().

LI Qingwu (1):
      USB: serial: option: add Telit FN920C04 ECM compositions

Lad Prabhakar (1):
      net: ravb: Ensure memory write completes before ringing TX doorbell

Larshin Sergey (2):
      media: rc: fix races with imon_disconnect()
      fs: udf: fix OOB read in lengthAllocDescs handling

Leilk.Liu (1):
      i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD

Leo Yan (3):
      perf: arm_spe: Prevent overflow in PERF_IDX2OFF()
      perf session: Fix handling when buffer exceeds 2 GiB
      tools build: Align warning options with perf

Li Jinlin (1):
      fsdax: Fix infinite loop in dax_iomap_rw()

Li Nan (1):
      blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unregister_hctx

Lichen Liu (1):
      fs: Add 'initramfs_options' to set initramfs mount options

Linmao Li (1):
      r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H

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

Luiz Augusto von Dentz (1):
      Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO

Lukas Wunner (3):
      xen/manage: Fix suspend error path
      PCI/ERR: Fix uevent on failure to recover
      PCI/AER: Support errors introduced by PCIe r6.0

Ma Ke (3):
      sparc: fix error handling in scan_one_device()
      ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()
      media: lirc: Fix error handling in lirc_register()

Maciej W. Rozycki (1):
      MIPS: Malta: Fix keyboard resource preventing i8042 driver from registering

Marek Vasut (1):
      Input: atmel_mxt_ts - allow reset GPIO to sleep

Mark Rutland (2):
      arm64: cputype: Add Neoverse-V3AE definitions
      arm64: errata: Apply workarounds for Neoverse-V3AE

Mathias Nyman (1):
      xhci: dbc: enable back DbC in resume if it was enabled before suspend

Matthew Wilcox (Oracle) (1):
      minmax: add in_range() macro

Maximilian Luz (1):
      PCI: Add sysfs attribute for device power state

Miaoqian Lin (1):
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
      net: usb: rtl8150: Fix frame padding

Mikhail Kobuk (1):
      media: pci: ivtv: Add check for DMA map result

Mikulas Patocka (1):
      dm-integrity: limit MAX_TAG_SIZE to 255

Muhammad Usama Anjum (1):
      wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again

Nalivayko Sergey (1):
      net/9p: fix double req put in p9_fd_cancelled

Naman Jain (1):
      uio_hv_generic: Let userspace take care of interrupt mask

Nathan Chancellor (1):
      lib/crypto/curve25519-hacl64: Disable KASAN with clang-17 and older

Niklas Cassel (2):
      scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod
      PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()

Niklas Schnelle (2):
      PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV
      PCI/AER: Fix missing uevent on recovery when a reset is requested

Nikolay Aleksandrov (7):
      net: rtnetlink: add msg kind names
      net: rtnetlink: add helper to extract msg type's kind
      net: rtnetlink: use BIT for flag values
      net: netlink: add NLM_F_BULK delete request modifier
      net: rtnetlink: add bulk delete support flag
      net: add ndo_fdb_del_bulk
      net: rtnetlink: add NLM_F_BULK support to rtnl_fdb_del

Nishanth Menon (1):
      hwrng: ks-sa - fix division by zero in ks_sa_rng_init

Ojaswin Mujoo (1):
      ext4: correctly handle queries for metadata mappings

Oleksij Rempel (1):
      net: usb: lan78xx: Add error handling to lan78xx_init_mac_address

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

Qianfeng Rong (6):
      block: use int to store blk_stack_limits() return value
      pinctrl: renesas: Use int type to store negative error codes
      ALSA: lx_core: use int type to store negative error codes
      media: i2c: mt9v111: fix incorrect type for ret
      iio: dac: ad5360: use int type to store negative error codes
      iio: dac: ad5421: use int type to store negative error codes

Rafael J. Wysocki (4):
      driver core/PM: Set power.no_callbacks along with power.no_pm
      PM: sleep: core: Clear power.must_resume in noirq suspend error path
      cpufreq: intel_pstate: Fix object lifecycle issue in update_qos_request()
      Revert "cpuidle: menu: Avoid discarding useful information"

Raju Rangoju (1):
      amd-xgbe: Avoid spurious link down messages during interface toggle

Randy Dunlap (1):
      ALSA: firewire: amdtp-stream: fix enum kernel-doc warnings

Ranjan Kumar (1):
      scsi: mpt3sas: Fix crash in transport port remove by using ioc_info()

Raphael Gallais-Pou (1):
      serial: stm32: allow selecting console when the driver is module

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RG255C

Renjun Wang (1):
      USB: serial: option: add UNISOC UIS7720

Rex Chen (1):
      mmc: core: SPI mode remove cmd7

Ricardo Ribalda (1):
      media: tunner: xc5000: Refactor firmware load

Rob Herring (Arm) (1):
      rtc: x1205: Fix Xicor X1205 vendor prefix

Roman Li (1):
      drm/amd/display: Remove redundant safeguards for dmub-srv destroy()

Sabrina Dubroca (2):
      tls: always set record_type in tls_process_cmsg
      tls: don't rely on tx_work during send()

Salah Triki (1):
      bus: fsl-mc: Check return value of platform_get_resource()

Sam James (1):
      parisc: don't reference obsolete termio struct for TC* constants

Sean Christopherson (4):
      rseq/selftests: Use weak symbol reference, not definition, to link with glibc
      x86/umip: Check that the instruction opcode is at least two bytes
      x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT aliases)
      KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O

Sean Nyekjaer (3):
      iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in resume
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
      iio: imu: inv_icm42600: Simplify pm_runtime setup

Sergey Bashirov (3):
      NFSD: Rework encoding and decoding of nfsd4_deviceid
      NFSD: Minor cleanup in layoutcommit processing
      NFSD: Fix last write offset handling in layoutcommit

Shuhao Fu (1):
      drm/nouveau: fix bad ret code in nouveau_bo_move_prep

Siddharth Vadapalli (2):
      PCI: keystone: Use devm_request_irq() to free "ks-pcie-error-irq" on exit
      PCI: j721e: Fix programming sequence of "strap" settings

Simon Schuster (1):
      copy_sighand: Handle architectures where sizeof(unsigned long) < sizeof(u64)

Slavin Liu (1):
      ipvs: Defer ip_vs_ftp unregister during netns cleanup

Sneh Mankad (1):
      soc: qcom: rpmh-rsc: Unconditionally clear _TRIGGER bit for TCS

Stefan Kerkmann (1):
      wifi: mwifiex: send world regulatory domain to driver

Stefano Garzarella (1):
      vsock: fix lock inversion in vsock_assign_transport()

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

Theodore Ts'o (1):
      ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()

Thomas Fourier (5):
      scsi: myrs: Fix dma_alloc_coherent() error check
      crypto: atmel - Fix dma_unmap_sg() direction
      media: pci: ivtv: Add missing check after DMA map
      media: cx18: Add missing check after DMA map
      crypto: rockchip - Fix dma_unmap_sg() nents value

Thomas Weißschuh (1):
      fs: always return zero on success from replace_fd()

Thorsten Blum (2):
      scsi: hpsa: Fix potential memory leak in hpsa_big_passthru_ioctl()
      NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()

Tim Guttzeit (1):
      usb/core/quirks: Add Huawei ME906S to wakeup quirk

Timur Kristóf (5):
      drm/amdgpu: Power up UVD 3 for FW validation (v2)
      drm/amd/display: Add missing DCE6 SCL_HORZ_FILTER_INIT* SRIs
      drm/amd/display: Properly clear SCL_*_FILTER_CONTROL on DCE6
      drm/amd/display: Properly disable scaling on DCE6
      drm/amd/powerplay: Fix CIK shutdown temperature

Tonghao Zhang (1):
      net: bonding: fix possible peer notify event loss or dup issue

Uros Bizjak (1):
      x86/vdso: Fix output operand size of RDPID

Uwe Kleine-König (1):
      pwm: tiehrpwm: Fix corner case in clock divisor calculation

Viacheslav Dubeyko (6):
      hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()
      hfs: clear offset and space out of valid records in b-tree node
      hfs: make proper initalization of struct hfs_find_data
      hfsplus: fix KMSAN uninit-value issue in __hfsplus_ext_cache_extent()
      hfsplus: fix KMSAN uninit-value issue in hfsplus_delete_cat()
      hfs: fix KMSAN uninit-value issue in hfs_find_set_zero_bits()

Victoria Votokina (2):
      most: usb: Fix use-after-free in hdm_disconnect
      most: usb: hdm_probe: Fix calling put_device() before device initialization

Vidya Sagar (1):
      PCI: tegra194: Handle errors in BPMP response

Vincent Guittot (1):
      sched/fair: Fix pelt lost idle time detection

Vlad Dumitrescu (1):
      IB/sa: Fix sa_local_svc_timeout_ms read race

Wang Haoran (1):
      scsi: target: target_core_configfs: Add length check to avoid buffer overflow

Wang Liang (1):
      pps: fix warning in pps_register_cdev when register device fail

Wei Fang (1):
      net: enetc: correct the value of ENETC_RXB_TRUESIZE

William Wu (1):
      usb: gadget: configfs: Correctly set use_os_string at bind

Xiao Liang (1):
      padata: Reset next CPU when reorder sequence wraps around

Xiaowei Li (1):
      USB: serial: option: add SIMCom 8230C compositions

Xichao Zhao (2):
      usb: phy: twl6030: Fix incorrect type for ret
      exec: Fix incorrect type for ret

Yang Chenzhi (1):
      hfs: validate record offset in hfsplus_bmap_alloc

Yang Shi (1):
      mm: hugetlb: avoid soft lockup when mprotect to large memory area

Yangtao Li (1):
      hfsplus: return EIO when type of hidden directory mismatch in hfsplus_fill_super()

Yeounsu Moon (2):
      net: dlink: handle copy_thresh allocation failure
      net: dlink: handle dma_map_single() failure properly

Yongjian Sun (1):
      ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()

Yu Kuai (1):
      blk-crypto: fix missing blktrace bio split events

Yuan Chen (1):
      tracing: Fix race condition in kprobe initialization causing NULL pointer dereference

Yuezhang Mo (1):
      dax: skip read lock assertion for read-only filesystems

Yunseong Kim (1):
      perf util: Fix compression checks returning -1 as bool

Yureka Lilian (1):
      libbpf: Fix reuse of DEVMAP

Zhang Shurong (1):
      media: rj54n1cb0c: Fix memleak in rj54n1_probe()

Zhang Yi (1):
      jbd2: ensure that all ongoing I/O complete before freeing blocks

Zhen Ni (4):
      netfilter: ipset: Remove unused htable_bits in macro ahash_region
      Input: uinput - zero-initialize uinput_ff_upload_compat to avoid info leak
      clocksource/drivers/clps711x: Fix resource leaks in error paths
      memory: samsung: exynos-srom: Fix of_iomap leak in exynos_srom_probe

Zheng Qixing (1):
      dm: fix NULL pointer dereference in __dm_suspend()

Zhengchao Shao (1):
      net: rtnetlink: fix module reference count leak issue in rtnetlink_rcv_msg

gaoxiang17 (1):
      pid: Add a judgment for ns null in pid_nr_ns

hupu (1):
      perf subcmd: avoid crash in exclude_cmds when excludes is empty

keliu (1):
      media: rc: Directly use ida_free()


