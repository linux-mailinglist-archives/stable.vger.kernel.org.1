Return-Path: <stable+bounces-151396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7DBACDE87
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC41898878
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7EA28F950;
	Wed,  4 Jun 2025 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sY53joT4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6E28F53F;
	Wed,  4 Jun 2025 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042434; cv=none; b=LctZKONaLT/ERmGrCZgJLiRlFMphyYTCsPJuC/ju9pTuZ+Sc7d3VkuNg20t41pUfdvXwq7sMhmwJhOgwrUJDF+uiQBjHM+5hrjUBiJpI3ZT8bcc97/t3PqRJ5JG4uX54CVZOgZv4mgdD2VCEDjAWiNgZO8YI2tIBh9gmLqysJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042434; c=relaxed/simple;
	bh=qAuqGJ6n0PXxXmEWJzzaRYWljesroHgVB8cYB5nmskM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mifoZxl64dqff0Eb7P59CDSHE9swl5pRv9fAZbYnUBMnYHMiAYnbHosOiTVwL974RgVz9xydans9gujjvpmFMrt6R4LcZalWLU6HuA6WXvCFljp82/d2Rpxc8oe2hBqNcA1S5oRruggMLze+fYLMDUT5bAWEr0MXPUd6xiH0by0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sY53joT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5033C4CEE7;
	Wed,  4 Jun 2025 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749042434;
	bh=qAuqGJ6n0PXxXmEWJzzaRYWljesroHgVB8cYB5nmskM=;
	h=From:To:Cc:Subject:Date:From;
	b=sY53joT4gMgPLdIs+6p3ggdMiBS2nPBTgbTYyugk0qgIL819nn3y1lTuRzBCKzI9T
	 pk2rp7UxI0iNkCys9BEasanO84xGVU7tvs2IzSddkCuaQrkrvrc1PV3NMLc9Ov4eS9
	 rk/GT8sajlzPoBHIGvNWkHysJ40ucWOAy3iGEBPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.141
Date: Wed,  4 Jun 2025 15:07:09 +0200
Message-ID: <2025060410-directory-replace-61df@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.141 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                |    2 
 Documentation/driver-api/serial/driver.rst                     |    2 
 Documentation/hwmon/dell-smm-hwmon.rst                         |   14 
 Makefile                                                       |   14 
 arch/arm/boot/dts/tegra114.dtsi                                |    2 
 arch/arm/mach-at91/pm.c                                        |   21 
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts        |   38 
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts         |   14 
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi          |   22 
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi                 |    2 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                           |    2 
 arch/arm64/include/asm/cputype.h                               |    2 
 arch/arm64/include/asm/pgtable.h                               |    3 
 arch/arm64/kernel/proton-pack.c                                |    1 
 arch/mips/include/asm/ftrace.h                                 |   16 
 arch/mips/kernel/pm-cps.c                                      |   30 
 arch/powerpc/kernel/prom_init.c                                |    4 
 arch/powerpc/perf/core-book3s.c                                |   20 
 arch/powerpc/perf/isa207-common.c                              |    4 
 arch/um/Makefile                                               |    1 
 arch/um/kernel/mem.c                                           |    1 
 arch/x86/boot/genimage.sh                                      |    5 
 arch/x86/events/amd/ibs.c                                      |    3 
 arch/x86/include/asm/nmi.h                                     |    2 
 arch/x86/include/asm/perf_event.h                              |    1 
 arch/x86/kernel/cpu/bugs.c                                     |   10 
 arch/x86/kernel/nmi.c                                          |   42 
 arch/x86/kernel/reboot.c                                       |   10 
 arch/x86/mm/init.c                                             |    9 
 arch/x86/mm/init_64.c                                          |   15 
 arch/x86/mm/kaslr.c                                            |   10 
 arch/x86/um/os-Linux/mcontext.c                                |    3 
 crypto/algif_hash.c                                            |    4 
 crypto/lzo-rle.c                                               |    2 
 crypto/lzo.c                                                   |    2 
 drivers/acpi/Kconfig                                           |    2 
 drivers/acpi/hed.c                                             |    7 
 drivers/auxdisplay/charlcd.c                                   |    5 
 drivers/auxdisplay/charlcd.h                                   |    5 
 drivers/auxdisplay/hd44780.c                                   |    2 
 drivers/auxdisplay/lcd2s.c                                     |    2 
 drivers/auxdisplay/panel.c                                     |    2 
 drivers/clk/imx/clk-imx8mp.c                                   |  151 ++
 drivers/clk/qcom/camcc-sm8250.c                                |   56 
 drivers/clk/qcom/clk-alpha-pll.c                               |   52 
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c                           |   44 
 drivers/clk/sunxi-ng/ccu_mp.h                                  |   22 
 drivers/clocksource/mips-gic-timer.c                           |    6 
 drivers/cpufreq/tegra186-cpufreq.c                             |    7 
 drivers/cpuidle/governors/menu.c                               |   13 
 drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c           |    7 
 drivers/dma/idxd/cdev.c                                        |  128 +
 drivers/dma/idxd/idxd.h                                        |    7 
 drivers/dma/idxd/init.c                                        |    2 
 drivers/dma/idxd/sysfs.c                                       |    1 
 drivers/edac/ie31200_edac.c                                    |   28 
 drivers/firmware/arm_ffa/bus.c                                 |    1 
 drivers/fpga/altera-cvp.c                                      |    2 
 drivers/gpio/gpio-pca953x.c                                    |  114 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                    |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                        |    7 
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c                       |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                       |   16 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |    7 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |   20 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |   13 
 drivers/gpu/drm/amd/display/dc/core/dc.c                       |    1 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c               |   11 
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c        |   42 
 drivers/gpu/drm/ast/ast_mode.c                                 |   10 
 drivers/gpu/drm/drm_atomic_helper.c                            |   28 
 drivers/gpu/drm/drm_edid.c                                     |    1 
 drivers/gpu/drm/mediatek/mtk_dpi.c                             |    5 
 drivers/gpu/drm/panel/panel-edp.c                              |    1 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                   |    6 
 drivers/hid/hid-ids.h                                          |    4 
 drivers/hid/hid-quirks.c                                       |    2 
 drivers/hid/usbhid/usbkbd.c                                    |    2 
 drivers/hwmon/dell-smm-hwmon.c                                 |    5 
 drivers/hwmon/gpio-fan.c                                       |   16 
 drivers/hwmon/xgene-hwmon.c                                    |    2 
 drivers/i2c/busses/i2c-pxa.c                                   |    5 
 drivers/i2c/busses/i2c-qup.c                                   |   36 
 drivers/i3c/master/svc-i3c-master.c                            |    4 
 drivers/infiniband/core/umem.c                                 |   36 
 drivers/infiniband/core/uverbs_cmd.c                           |  144 +-
 drivers/infiniband/core/verbs.c                                |   11 
 drivers/iommu/amd/io_pgtable_v2.c                              |    2 
 drivers/iommu/dma-iommu.c                                      |   28 
 drivers/leds/rgb/leds-pwm-multicolor.c                         |    5 
 drivers/mailbox/mailbox.c                                      |    7 
 drivers/md/dm-cache-target.c                                   |   24 
 drivers/md/dm-table.c                                          |    4 
 drivers/md/dm.c                                                |    8 
 drivers/media/i2c/adv7180.c                                    |   34 
 drivers/media/platform/qcom/camss/camss-csid.c                 |   60 
 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c       |    3 
 drivers/media/test-drivers/vivid/vivid-kthread-cap.c           |   11 
 drivers/media/test-drivers/vivid/vivid-kthread-out.c           |   11 
 drivers/media/test-drivers/vivid/vivid-kthread-touch.c         |   11 
 drivers/media/test-drivers/vivid/vivid-sdr-cap.c               |   11 
 drivers/media/usb/cx231xx/cx231xx-417.c                        |    2 
 drivers/media/usb/uvc/uvc_v4l2.c                               |    6 
 drivers/mmc/host/dw_mmc-exynos.c                               |   41 
 drivers/mmc/host/sdhci-pci-core.c                              |    6 
 drivers/mmc/host/sdhci.c                                       |    9 
 drivers/net/bonding/bond_main.c                                |    2 
 drivers/net/can/c_can/c_can_platform.c                         |    2 
 drivers/net/can/slcan/slcan-core.c                             |   26 
 drivers/net/ethernet/apm/xgene-v2/main.c                       |    4 
 drivers/net/ethernet/freescale/enetc/enetc.c                   |   16 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                   |    3 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                  |    1 
 drivers/net/ethernet/marvell/octeontx2/Kconfig                 |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c          |   24 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c        |   11 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c             |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h             |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c       |  130 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h       |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c           |   18 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c         |   49 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h         |    7 
 drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c            |    2 
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c                |   22 
 drivers/net/ethernet/mellanox/mlx4/alloc.c                     |    6 
 drivers/net/ethernet/mellanox/mlx4/en_tx.c                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c               |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c          |    3 
 drivers/net/ethernet/mellanox/mlx5/core/events.c               |   11 
 drivers/net/ethernet/mellanox/mlx5/core/health.c               |    1 
 drivers/net/ethernet/microchip/lan743x_main.c                  |   19 
 drivers/net/ethernet/microsoft/mana/gdma_main.c                |    2 
 drivers/net/ethernet/realtek/r8169_main.c                      |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c              |    2 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                       |    2 
 drivers/net/ethernet/ti/cpsw_new.c                             |    1 
 drivers/net/ieee802154/ca8210.c                                |    9 
 drivers/net/phy/phylink.c                                      |    2 
 drivers/net/usb/r8152.c                                        |    1 
 drivers/net/vxlan/vxlan_core.c                                 |   36 
 drivers/net/wireless/ath/ath9k/init.c                          |    4 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                  |    2 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c          |   17 
 drivers/net/wireless/realtek/rtw88/main.c                      |   40 
 drivers/net/wireless/realtek/rtw88/reg.h                       |    3 
 drivers/net/wireless/realtek/rtw88/rtw8822b.c                  |   14 
 drivers/net/wireless/realtek/rtw88/util.c                      |    3 
 drivers/net/wireless/realtek/rtw89/fw.c                        |    2 
 drivers/net/wireless/realtek/rtw89/regd.c                      |    2 
 drivers/net/wireless/realtek/rtw89/ser.c                       |    4 
 drivers/nvdimm/label.c                                         |    3 
 drivers/nvme/host/pci.c                                        |    2 
 drivers/nvme/target/tcp.c                                      |    3 
 drivers/pci/Kconfig                                            |    6 
 drivers/pci/controller/dwc/pcie-designware-ep.c                |    2 
 drivers/pci/controller/pcie-brcmstb.c                          |    5 
 drivers/pci/controller/vmd.c                                   |   20 
 drivers/pci/setup-bus.c                                        |    6 
 drivers/perf/arm-cmn.c                                         |   10 
 drivers/phy/phy-core.c                                         |    7 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                       |  143 +-
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c                         |   44 
 drivers/pinctrl/devicetree.c                                   |   10 
 drivers/pinctrl/meson/pinctrl-meson.c                          |    2 
 drivers/pinctrl/tegra/pinctrl-tegra.c                          |   59 
 drivers/pinctrl/tegra/pinctrl-tegra.h                          |    6 
 drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c |    2 
 drivers/platform/x86/fujitsu-laptop.c                          |   33 
 drivers/platform/x86/thinkpad_acpi.c                           |    7 
 drivers/regulator/ad5398.c                                     |   12 
 drivers/remoteproc/qcom_wcnss.c                                |   34 
 drivers/rtc/rtc-ds1307.c                                       |    4 
 drivers/rtc/rtc-rv3032.c                                       |    2 
 drivers/s390/crypto/vfio_ap_ops.c                              |   72 -
 drivers/scsi/lpfc/lpfc_hbadisc.c                               |   17 
 drivers/scsi/lpfc/lpfc_init.c                                  |    2 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                |    3 
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                             |   12 
 drivers/scsi/st.c                                              |   29 
 drivers/scsi/st.h                                              |    2 
 drivers/soc/apple/rtkit-internal.h                             |    1 
 drivers/soc/apple/rtkit.c                                      |   58 
 drivers/soc/imx/gpcv2.c                                        |    2 
 drivers/soc/ti/k3-socinfo.c                                    |   13 
 drivers/spi/spi-fsl-dspi.c                                     |   46 
 drivers/spi/spi-sun4i.c                                        |    5 
 drivers/spi/spi-zynqmp-gqspi.c                                 |   20 
 drivers/target/iscsi/iscsi_target.c                            |    2 
 drivers/thermal/qoriq_thermal.c                                |   13 
 drivers/thunderbolt/retimer.c                                  |    8 
 drivers/tty/serial/8250/8250_port.c                            |    2 
 drivers/tty/serial/atmel_serial.c                              |    2 
 drivers/tty/serial/imx.c                                       |    2 
 drivers/tty/serial/serial_mctrl_gpio.c                         |   34 
 drivers/tty/serial/serial_mctrl_gpio.h                         |   17 
 drivers/tty/serial/sh-sci.c                                    |   98 +
 drivers/tty/serial/stm32-usart.c                               |    2 
 drivers/vfio/pci/vfio_pci_config.c                             |    3 
 drivers/vfio/pci/vfio_pci_core.c                               |   10 
 drivers/vfio/pci/vfio_pci_intrs.c                              |    2 
 drivers/video/fbdev/core/bitblit.c                             |    5 
 drivers/video/fbdev/core/fbcon.c                               |   10 
 drivers/video/fbdev/core/fbcon.h                               |   38 
 drivers/video/fbdev/core/fbcon_ccw.c                           |    5 
 drivers/video/fbdev/core/fbcon_cw.c                            |    5 
 drivers/video/fbdev/core/fbcon_ud.c                            |    5 
 drivers/video/fbdev/core/tileblit.c                            |   45 
 drivers/video/fbdev/fsl-diu-fb.c                               |    1 
 drivers/virtio/virtio_ring.c                                   |    2 
 drivers/xen/platform-pci.c                                     |    4 
 drivers/xen/xenbus/xenbus_probe.c                              |   14 
 fs/btrfs/block-group.c                                         |   18 
 fs/btrfs/discard.c                                             |   34 
 fs/btrfs/disk-io.c                                             |   28 
 fs/btrfs/extent_io.c                                           |    7 
 fs/btrfs/relocation.c                                          |    6 
 fs/btrfs/send.c                                                |    6 
 fs/coredump.c                                                  |   81 +
 fs/dlm/lowcomms.c                                              |    4 
 fs/ext4/balloc.c                                               |    4 
 fs/ext4/super.c                                                |   12 
 fs/fuse/dir.c                                                  |    2 
 fs/gfs2/glock.c                                                |   11 
 fs/namespace.c                                                 |    6 
 fs/nfs/client.c                                                |    2 
 fs/nfs/delegation.c                                            |    3 
 fs/nfs/dir.c                                                   |   15 
 fs/nfs/filelayout/filelayoutdev.c                              |    6 
 fs/nfs/flexfilelayout/flexfilelayout.c                         |    1 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                      |    6 
 fs/nfs/inode.c                                                 |    2 
 fs/nfs/internal.h                                              |    5 
 fs/nfs/nfs3proc.c                                              |    2 
 fs/nfs/nfs4proc.c                                              |    9 
 fs/nfs/nfs4state.c                                             |   10 
 fs/nfs/pnfs.h                                                  |    4 
 fs/nfs/pnfs_nfs.c                                              |    9 
 fs/orangefs/inode.c                                            |    7 
 fs/smb/client/cifsproto.h                                      |    3 
 fs/smb/client/connect.c                                        |   30 
 fs/smb/client/link.c                                           |    8 
 fs/smb/client/readdir.c                                        |    7 
 fs/smb/client/smb1ops.c                                        |    7 
 fs/smb/client/smb2file.c                                       |   11 
 fs/smb/client/smb2ops.c                                        |    3 
 fs/smb/client/transport.c                                      |    2 
 fs/smb/server/vfs.c                                            |   14 
 include/drm/drm_atomic.h                                       |   23 
 include/linux/coredump.h                                       |    1 
 include/linux/dma-mapping.h                                    |   12 
 include/linux/hrtimer.h                                        |    1 
 include/linux/ipv6.h                                           |    1 
 include/linux/lzo.h                                            |    8 
 include/linux/mlx4/device.h                                    |    2 
 include/linux/msi.h                                            |   33 
 include/linux/nfs_fs_sb.h                                      |   12 
 include/linux/perf_event.h                                     |    8 
 include/linux/pid.h                                            |    1 
 include/linux/rcupdate.h                                       |    2 
 include/linux/rcutree.h                                        |    2 
 include/linux/trace.h                                          |    4 
 include/linux/trace_seq.h                                      |    8 
 include/linux/usb/r8152.h                                      |    1 
 include/net/af_unix.h                                          |   48 
 include/net/scm.h                                              |   11 
 include/net/xfrm.h                                             |    1 
 include/rdma/uverbs_std_types.h                                |    2 
 include/sound/hda_codec.h                                      |    1 
 include/sound/pcm.h                                            |    2 
 include/trace/events/btrfs.h                                   |    2 
 io_uring/fdinfo.c                                              |    4 
 io_uring/io_uring.c                                            |    1 
 kernel/bpf/hashtab.c                                           |    2 
 kernel/bpf/syscall.c                                           |    4 
 kernel/cgroup/cgroup.c                                         |    2 
 kernel/events/core.c                                           |   33 
 kernel/events/hw_breakpoint.c                                  |    5 
 kernel/events/ring_buffer.c                                    |    1 
 kernel/fork.c                                                  |   98 +
 kernel/padata.c                                                |    3 
 kernel/pid.c                                                   |   19 
 kernel/rcu/tree_plugin.h                                       |   22 
 kernel/softirq.c                                               |   18 
 kernel/time/hrtimer.c                                          |  103 +
 kernel/time/posix-timers.c                                     |    1 
 kernel/time/timer_list.c                                       |    4 
 kernel/trace/trace.c                                           |   11 
 kernel/trace/trace.h                                           |   16 
 lib/dynamic_queue_limits.c                                     |    2 
 lib/lzo/Makefile                                               |    2 
 lib/lzo/lzo1x_compress.c                                       |  102 +
 lib/lzo/lzo1x_compress_safe.c                                  |   18 
 mm/memcontrol.c                                                |    6 
 mm/page_alloc.c                                                |    8 
 net/Makefile                                                   |    2 
 net/bluetooth/l2cap_core.c                                     |   15 
 net/bridge/br_nf_core.c                                        |    7 
 net/bridge/br_private.h                                        |    1 
 net/can/bcm.c                                                  |   79 -
 net/core/pktgen.c                                              |   13 
 net/core/scm.c                                                 |   17 
 net/ipv4/esp4.c                                                |   49 
 net/ipv4/fib_frontend.c                                        |   18 
 net/ipv4/fib_rules.c                                           |    4 
 net/ipv4/fib_trie.c                                            |   22 
 net/ipv4/inet_hashtables.c                                     |   37 
 net/ipv4/tcp_input.c                                           |   56 
 net/ipv6/esp6.c                                                |   49 
 net/ipv6/fib6_rules.c                                          |    4 
 net/ipv6/ip6_output.c                                          |    9 
 net/llc/af_llc.c                                               |    8 
 net/mac80211/mlme.c                                            |    4 
 net/netfilter/nf_conntrack_standalone.c                        |   12 
 net/sched/sch_hfsc.c                                           |   15 
 net/smc/smc_pnet.c                                             |    8 
 net/sunrpc/clnt.c                                              |    3 
 net/sunrpc/rpcb_clnt.c                                         |    5 
 net/sunrpc/sched.c                                             |    2 
 net/tipc/crypto.c                                              |    5 
 net/unix/Kconfig                                               |   11 
 net/unix/Makefile                                              |    2 
 net/unix/af_unix.c                                             |  120 +
 net/unix/garbage.c                                             |  691 ++++++----
 net/unix/scm.c                                                 |  154 --
 net/unix/scm.h                                                 |   10 
 net/xfrm/xfrm_policy.c                                         |    3 
 net/xfrm/xfrm_state.c                                          |    6 
 samples/bpf/Makefile                                           |    2 
 scripts/config                                                 |   26 
 scripts/kconfig/merge_config.sh                                |    4 
 security/smack/smackfs.c                                       |    4 
 sound/core/oss/pcm_oss.c                                       |    3 
 sound/core/pcm_native.c                                        |   11 
 sound/core/seq/seq_clientmgr.c                                 |    5 
 sound/core/seq/seq_memory.c                                    |    1 
 sound/pci/hda/hda_beep.c                                       |   15 
 sound/pci/hda/patch_realtek.c                                  |   77 +
 sound/soc/codecs/mt6359-accdet.h                               |    9 
 sound/soc/codecs/pcm3168a.c                                    |    6 
 sound/soc/codecs/tas2764.c                                     |   53 
 sound/soc/fsl/imx-card.c                                       |    2 
 sound/soc/intel/boards/bytcr_rt5640.c                          |   13 
 sound/soc/qcom/sm8250.c                                        |    3 
 sound/soc/soc-dai.c                                            |    8 
 sound/soc/soc-ops.c                                            |   29 
 sound/soc/sunxi/sun4i-codec.c                                  |   53 
 tools/bpf/bpftool/common.c                                     |    3 
 tools/build/Makefile.build                                     |    6 
 tools/lib/bpf/libbpf.c                                         |    2 
 tools/objtool/check.c                                          |   11 
 tools/testing/kunit/qemu_configs/x86_64.py                     |    4 
 tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c          |    1 
 tools/testing/selftests/net/gro.sh                             |    3 
 354 files changed, 4184 insertions(+), 1986 deletions(-)

Aaron Kling (1):
      cpufreq: tegra186: Share policy per cluster

Ahmad Fatoum (2):
      clk: imx8mp: inform CCF of maximum frequency of clocks
      pmdomain: imx: gpcv2: use proper helper for property detection

Al Viro (1):
      __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock

Aleksander Jan Bajkowski (1):
      r8152: add vendor/device ID pair for Dell Alienware AW1022z

Alessandro Grassi (1):
      spi: spi-sun4i: fix early activation

Alex Deucher (1):
      drm/amd/display/dm: drop hw_support check in amdgpu_dm_i2c_xfer()

Alex Williamson (1):
      vfio/pci: Handle INTx IRQ_NOTCONNECTED

Alexander Mikhalitsyn (1):
      af_unix: Kconfig: make CONFIG_UNIX bool

Alexander Stein (1):
      hwmon: (gpio-fan) Add missing mutex locks

Alexander Sverdlin (1):
      net: ethernet: ti: cpsw_new: populate netdev of_node

Alexandre Belloni (2):
      rtc: rv3032: fix EERD location
      rtc: ds1307: stop disabling alarms on probe

Alexei Lazar (1):
      net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB

Alexey Klimov (1):
      ASoC: qcom: sm8250: explicitly set format in sm8250_be_hw_params_fixup()

Alexis Lothoré (1):
      serial: mctrl_gpio: split disable_ms into sync and no_sync APIs

Alice Guo (1):
      thermal/drivers/qoriq: Power down TMU on system suspend

Alistair Francis (1):
      nvmet-tcp: don't restore null sk_state_change

Alok Tiwari (1):
      arm64: dts: qcom: sm8350: Fix typo in pil_camera_mem node

Andre Przywara (1):
      clk: sunxi-ng: d1: Add missing divider for MMC mod clocks

Andreas Gruenbacher (1):
      gfs2: Check for empty queue in run_queue

Andreas Schwab (1):
      powerpc/prom_init: Fixup missing #size-cells on PowerBook6,7

Andrew Davis (1):
      soc: ti: k3-socinfo: Do not use syscon helper to build regmap

Andrey Vatoropin (1):
      hwmon: (xgene-hwmon) use appropriate type for the latency value

Andy Shevchenko (6):
      gpio: pca953x: Add missing header(s)
      gpio: pca953x: Split pca953x_restore_context() and pca953x_save_context()
      gpio: pca953x: Simplify code with cleanup helpers
      tracing: Mark binary printing functions with __printf() attribute
      auxdisplay: charlcd: Partially revert "Move hwidth and bwidth to struct hd44780_common"
      ieee802154: ca8210: Use proper setters and getters for bitwise types

Andy Yan (1):
      drm/rockchip: vop2: Add uv swap for cluster window

AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_dpi: Add checks for reg_h_fre_con existence

Ankur Arora (3):
      rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
      rcu: handle unstable rdp in rcu_read_unlock_strict()
      rcu: fix header guard for rcu_all_qs()

Anthony Krowiak (1):
      s390/vfio-ap: Fix no AP queue sharing allowed message written to kernel log

Arnd Bergmann (2):
      net: xgene-v2: remove incorrect ACPI_PTR annotation
      EDAC/ie31200: work around false positive build warning

Artur Weber (1):
      pinctrl: bcm281xx: Use "unsigned int" instead of bare "unsigned"

Athira Rajeev (1):
      arch/powerpc/perf: Check the instruction type before creating sample with perf_mem_data_src

Balbir Singh (2):
      x86/kaslr: Reduce KASLR entropy on most x86 systems
      x86/mm/init: Handle the special case of device private pages in add_pages(), to not increase max_pfn and trigger dma_addressing_limited() bounce buffers bounce buffers

Baokun Li (1):
      ext4: reject the 'data_err=abort' option in nojournal mode

Benjamin Berg (1):
      um: Store full CSGSFS and SS register from mcontext

Bibo Mao (1):
      MIPS: Use arch specific syscall name match function

Bitterblue Smith (5):
      wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
      wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
      wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
      wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
      wifi: rtw88: Don't use static local variable in rtw8822b_set_tx_power_index_by_rate

Bogdan-Gabriel Roman (1):
      spi: spi-fsl-dspi: Halt the module after a new message transfer

Boris Burkov (2):
      btrfs: make btrfs_discard_workfn() block_group ref explicit
      btrfs: check folio mapping after unlock in relocate_one_folio()

Brandon Kammerdiener (1):
      bpf: fix possible endless loop in BPF map iteration

Brendan Jackman (1):
      kunit: tool: Use qboot on QEMU x86_64

Breno Leitao (2):
      x86/bugs: Make spectre user default depend on MITIGATION_SPECTRE_V2
      memcg: always call cond_resched() after fn()

Carlos Sanchez (1):
      can: slcan: allow reception of short error messages

Cezary Rojewski (1):
      ASoC: codecs: pcm3168a: Allow for 24-bit in provider mode

Chenyuan Yang (1):
      ASoC: imx-card: Adjust over allocation of memory in imx_card_parse_of()

Choong Yong Liang (1):
      net: phylink: use pl->link_interface in phylink_expects_phy()

Christian Brauner (4):
      coredump: fix error handling for replace_fd()
      pid: add pidfd_prepare()
      fork: use pidfd_prepare()
      coredump: hand a pidfd to the usermode coredump helper

Christian Göttsche (1):
      ext4: reorder capability check last

Claudiu Beznea (5):
      phy: renesas: rcar-gen3-usb2: Add support to initialize the bus
      phy: renesas: rcar-gen3-usb2: Move IRQ request in probe
      phy: renesas: rcar-gen3-usb2: Lock around hardware registers and driver data
      phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off
      serial: sh-sci: Update the suspend/resume support

Cong Wang (1):
      sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()

Dan Carpenter (1):
      pinctrl: tegra: Fix off by one in tegra_pinctrl_get_group()

Daniel Gomez (1):
      kconfig: merge_config: use an empty file as initfile

Dave Jiang (2):
      dmaengine: idxd: add per DSA wq workqueue for processing cr faults
      dmaengine: idxd: Fix ->poll() return value

Depeng Shao (1):
      media: qcom: camss: csid: Only add TPG v4l2 ctrl if TPG hardware is available

Diogo Ivo (1):
      arm64: tegra: p2597: Fix gpio for vdd-1v8-dis regulator

Dmitry Baryshkov (1):
      phy: core: don't require set_mode() callback for phy_get_mode() to work

Dmitry Bogdanov (1):
      scsi: target: iscsi: Fix timeout on deleted connection

Dominik Grzegorzek (1):
      padata: do not leak refcount in reorder_work

Douglas Anderson (1):
      drm/panel-edp: Add Starry 116KHD024006

Ed Burcher (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14ASP10

Emanuele Ghidoli (1):
      gpio: pca953x: fix IRQ storm on system wake up

Eric Dumazet (2):
      posix-timers: Add cond_resched() to posix_timer_add() search loop
      tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()

Eric Woudstra (1):
      net: ethernet: mtk_ppe_offload: Allow QinQ, double ETH_P_8021Q only

Erick Shepherd (2):
      mmc: host: Wait for Vdd to settle on card power off
      mmc: sdhci: Disable SD card clock before changing parameters

Felix Kuehling (1):
      drm/amdgpu: Allow P2P access through XGMI

Fenghua Yu (1):
      dmaengine: idxd: add idxd_copy_cr() to copy user completion record during page fault handling

Filipe Manana (3):
      btrfs: fix non-empty delayed iputs list on unmount due to async workers
      btrfs: get zone unusable bytes while holding lock at btrfs_reclaim_bgs_work()
      btrfs: send: return -ENAMETOOLONG when attempting a path that is too long

Frank Li (2):
      PCI: dwc: ep: Ensure proper iteration over outbound map windows
      i3c: master: svc: Flush FIFO before sending Dynamic Address Assignment(DAA)

Frederic Weisbecker (1):
      hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING

Frediano Ziglio (1):
      xen: Add support for XenServer 6.1 platform device

Geert Uytterhoeven (1):
      serial: sh-sci: Save and restore more registers

Geetha sowjanya (1):
      octeontx2-af: Fix APR entry mapping based on APR_LMT_CFG

Goldwyn Rodrigues (1):
      btrfs: correct the order of prelim_ref arguments in btrfs__prelim_ref

Greg Kroah-Hartman (1):
      Linux 6.1.141

Guangguan Wang (1):
      net/smc: use the correct ndev to find pnetid by pnetid table

Hangbin Liu (1):
      bonding: report duplicate MAC address in all situations

Hans Verkuil (2):
      media: cx231xx: set device_caps for 417
      media: test-drivers: vivid: don't call schedule in loop

Haoran Jiang (1):
      samples/bpf: Fix compilation failure for samples/bpf on LoongArch Fedora

Harshit Mogalapalli (1):
      dmaengine: idxd: Fix passing freed memory in idxd_cdev_open()

Hector Martin (4):
      soc: apple: rtkit: Implement OSLog buffers properly
      ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG
      ASoC: tas2764: Mark SW_RESET as volatile
      ASoC: tas2764: Power up/down amp on mute ops

Heiner Kallweit (1):
      r8169: don't scan PHY addresses > 0

Heming Zhao (1):
      dlm: make tcp still work in multi-link env

Herbert Xu (1):
      crypto: lzo - Fix compression buffer overrun

Ian Rogers (1):
      tools/build: Don't pass test log files to linker

Ido Schimmel (2):
      vxlan: Annotate FDB data races
      bridge: netfilter: Fix forwarding of fragmented packets

Ihor Solodrai (1):
      selftests/bpf: Mitigate sockmap_ktls disconnect_after_delete failure

Ilia Gavrilov (1):
      llc: fix data loss when reading from a socket in llc_ui_recvmsg()

Ilpo Järvinen (2):
      tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
      PCI: Fix old_size lower bound in calculate_iosize() too

Ilya Guterman (1):
      nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro

Isaac Scott (1):
      regulator: ad5398: Add device tree support

Ivan Pravdin (1):
      crypto: algif_hash - fix double free in hash_accept

Jacob Keller (1):
      ice: fix vf->num_mac count with port representors

Jakub Kicinski (1):
      eth: mlx4: don't try to complete XDP frames in netpoll

Janne Grunau (1):
      soc: apple: rtkit: Use high prio work queue

Jason Andryuk (1):
      xenbus: Allow PVH dom0 a non-local xenstore

Jason Gunthorpe (1):
      genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of iommu_cookie

Jeff Layton (1):
      nfs: don't share pNFS DS connections between net namespaces

Jens Axboe (1):
      io_uring/fdinfo: annotate racy sq/cq head/tail reads

Jernej Skrabec (1):
      Revert "arm64: dts: allwinner: h6: Use RSB for AXP805 PMIC connection"

Jessica Zhang (1):
      drm: Add valid clones check

Jiang Liu (1):
      drm/amdgpu: reset psp->cmd to NULL after releasing the buffer

Jing Su (1):
      dql: Fix dql->limit value when reset.

Jing Zhou (1):
      drm/amd/display: Guard against setting dispclk low for dcn31x

Jinliang Zheng (1):
      dm: fix unconditional IO throttle caused by REQ_PREFLUSH

Jinqian Yang (1):
      arm64: Add support for HIP09 Spectre-BHB mitigation

Johannes Berg (3):
      wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
      wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
      wifi: iwlwifi: add support for Killer on MTL

John Chau (1):
      platform/x86: thinkpad_acpi: Support also NEC Lavie X1475JAS

Jordan Crouse (1):
      clk: qcom: camcc-sm8250: Use clk_rcg2_shared_ops for some RCGs

Josh Poimboeuf (1):
      objtool: Properly disable uaccess validation

Justin Tee (2):
      scsi: lpfc: Handle duplicate D_IDs in ndlp search-by D_ID routine
      scsi: lpfc: Free phba irq in lpfc_sli4_enable_msi() when pci_irq_vector() fails

Kai Mäkisara (3):
      scsi: st: Tighten the page format heuristics with MODE SELECT
      scsi: st: ERASE does not change tape location
      scsi: st: Restore some drive settings after reset

Kaustabh Chakraborty (1):
      mmc: dw_mmc: add exynos7870 DW MMC support

Kees Cook (1):
      net/mlx4_core: Avoid impossible mlx4_db_alloc() order value

Kevin Krakauer (1):
      selftests/net: have `gro.sh -t` return a correct exit code

Konstantin Andreev (1):
      smack: recognize ipv4 CIPSO w/o categories

Konstantin Taranov (1):
      net/mana: fix warning in the writer of client oob

Krzysztof Kozlowski (2):
      can: c_can: Use of_property_present() to test existence of DT property
      clk: qcom: clk-alpha-pll: Do not use random stack value for recalc rate

Kuhanh Murugasen Krishnan (1):
      fpga: altera-cvp: Increase credit timeout

Kuninori Morimoto (1):
      ASoC: soc-dai: check return value at snd_soc_dai_set_tdm_slot()

Kuniyuki Iwashima (26):
      ipv4: fib: Move fib_valid_key_len() to rtm_to_fib_config().
      ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().
      af_unix: Return struct unix_sock from unix_get_socket().
      af_unix: Run GC on only one CPU.
      af_unix: Try to run GC async.
      af_unix: Replace BUG_ON() with WARN_ON_ONCE().
      af_unix: Remove io_uring code for GC.
      af_unix: Remove CONFIG_UNIX_SCM.
      af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
      af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
      af_unix: Link struct unix_edge when queuing skb.
      af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
      af_unix: Iterate all vertices by DFS.
      af_unix: Detect Strongly Connected Components.
      af_unix: Save listener for embryo socket.
      af_unix: Fix up unix_edge.successor for embryo socket.
      af_unix: Save O(n) setup of Tarjan's algo.
      af_unix: Skip GC if no cycle exists.
      af_unix: Avoid Tarjan's algorithm if unnecessary.
      af_unix: Assign a unique index to SCC.
      af_unix: Detect dead SCC.
      af_unix: Replace garbage collection algorithm.
      af_unix: Remove lock dance in unix_peek_fds().
      af_unix: Try not to hold unix_gc_lock during accept().
      af_unix: Don't access successor in unix_del_edges() during GC.
      af_unix: Add dead flag to struct scm_fp_list.

Kurt Borja (1):
      hwmon: (dell-smm) Increment the number of fans

Larisa Grigore (2):
      spi: spi-fsl-dspi: restrict register range for regmap access
      spi: spi-fsl-dspi: Reset SR flags before sending a new message

Li Bin (1):
      ARM: at91: pm: fix at91_suspend_finish for ZQ calibration

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix not checking l2cap_chan security level

Maciej S. Szmigiero (1):
      ALSA: hda/realtek: Enable PC beep passthrough for HP EliteBook 855 G7

Maher Sanalla (1):
      RDMA/uverbs: Propagate errors from rdma_lookup_get_uobject()

Marek Szyprowski (1):
      dma-mapping: avoid potential unused data compilation warning

Mario Limonciello (1):
      Revert "drm/amd: Keep display off while going into S4"

Mark Harmstone (1):
      btrfs: avoid linker error in btrfs_find_create_tree_block()

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Ignore battery threshold change event notification

Markus Elfring (1):
      media: c8sectpfe: Call of_node_put(i2c_bus) only once in c8sectpfe_probe()

Martin Blumenstingl (1):
      pinctrl: meson: define the pull up/down resistor value as 60 kOhm

Martin Povišer (1):
      ASoC: ops: Enforce platform maximum on initial value

Masahiro Yamada (1):
      um: let 'make clean' properly clean underlying SUBARCH as well

Matt Johnston (1):
      fuse: Return EPERM rather than ENOSYS from link()

Matthew Wilcox (Oracle) (1):
      orangefs: Do not truncate file size

Matti Lehtimäki (2):
      remoteproc: qcom_wcnss: Handle platforms with only single power domain
      remoteproc: qcom_wcnss: Fix on platforms without fallback regulators

Michael Margolin (1):
      RDMA/core: Fix best page size finding when it can cross SG entries

Michal Luczaj (1):
      af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS

Michal Swiatkowski (1):
      ice: count combined queues using Rx/Tx count

Mika Westerberg (1):
      thunderbolt: Do not add non-active NVM if NVM upgrade is disabled for retimer

Mikulas Patocka (1):
      dm: restrict dm device size to 2^63-512 bytes

Milton Barrera (1):
      HID: quirks: Add ADATA XPG alpha wireless mouse support

Ming-Hung Tsai (1):
      dm cache: prevent BUG_ON by blocking retries on failed device resumes

Moshe Shemesh (1):
      net/mlx5: Avoid report two health errors on same syndrome

Mykyta Yatsenko (1):
      bpf: Return prog btf_id without capable check

Namjae Jeon (1):
      ksmbd: fix stream write failure

Nandakumar Edamana (1):
      libbpf: Fix out-of-bound read

Nathan Chancellor (2):
      kbuild: Disable -Wdefault-const-init-unsafe
      i3c: master: svc: Fix implicit fallthrough in svc_i3c_master_ibi_work()

Nicolas Bouchinet (1):
      netfilter: conntrack: Bound nf_conntrack sysctl writes

Niklas Söderlund (1):
      media: adv7180: Disable test-pattern control on adv7180

Nir Lichtman (1):
      x86/build: Fix broken copy command in genimage.sh when making isoimage

Nishanth Menon (1):
      net: ethernet: ti: am65-cpsw: Lower random mac address error print to info

Nícolas F. R. A. Prado (1):
      ASoC: mediatek: mt6359: Add stub for mt6359_accdet_enable_jack_detect

Oliver Hartkopp (2):
      can: bcm: add locking for bcm_op runtime updates
      can: bcm: add missing rcu read protection for procfs content

Pali Rohár (4):
      cifs: Add fallback for SMB2 CREATE without FILE_READ_ATTRIBUTES
      cifs: Fix querying and creating MF symlinks over SMB1
      cifs: Fix negotiate retry functionality
      cifs: Fix establishing NetBIOS session for SMB2+ connection

Paul Burton (2):
      MIPS: pm-cps: Use per-CPU variables as per-CPU, not per-core
      clocksource: mips-gic-timer: Enable counter when CPUs start

Paul Chaignon (1):
      xfrm: Sanitize marks before insert

Paul Kocialkowski (1):
      net: dwmac-sun8i: Use parsed internal PHY address instead of 1

Pavel Begunkov (1):
      io_uring: fix overflow resched cqe reordering

Pedro Tammela (1):
      net_sched: hfsc: Address reentrant enqueue adding class to eltree twice

Peter Seiderer (2):
      net: pktgen: fix mpls maximum labels list parsing
      net: pktgen: fix access outside of user given buffer in pktgen_thread_write()

Peter Zijlstra (Intel) (1):
      perf: Avoid the read if the count is already updated

Petr Machata (1):
      vxlan: Join / leave MC group after remote changes

Philip Redkin (1):
      x86/mm: Check return value from memblock_phys_alloc_range()

Philip Yang (1):
      drm/amdkfd: KFD release_work possible circular locking

Ping-Ke Shih (2):
      wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
      wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet

Prathamesh Shete (1):
      pinctrl-tegra: Restore SFSEL bit when freeing pins

Qu Wenruo (1):
      btrfs: run btrfs_error_commit_super() early

Rafael J. Wysocki (1):
      cpuidle: menu: Avoid discarding useful information

Ranjan Kumar (1):
      scsi: mpi3mr: Add level check to control event logging

Ratheesh Kannoth (4):
      octeontx2-pf: Add support for page pool
      octeontx2-pf: fix page_pool creation fail for rings > 32k
      octeontx2-pf: Fix page pool cache index corruption.
      octeontx2-pf: Fix page pool frag allocation warning

Ravi Bangoria (1):
      perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt

Ricardo Ribalda (1):
      media: uvcvideo: Add sanity check to uvc_ioctl_xu_ctrl_map

Robert Richter (1):
      libnvdimm/labels: Fix divide error in nd_label_data_init()

Robin Murphy (2):
      perf/arm-cmn: Fix REQ2/SNP2 mixup
      perf/arm-cmn: Initialise cmn->cpu earlier

Roger Pau Monne (1):
      PCI: vmd: Disable MSI remapping bypass under Xen

Rosen Penev (1):
      wifi: ath9k: return by of_get_mac_address

Ryan Roberts (1):
      arm64/mm: Check PUD_TYPE_TABLE in pud_bad()

Ryan Walklin (1):
      ASoC: sun4i-codec: support hp-det-gpios property

Ryo Takakura (1):
      lockdep: Fix wait context check on softirq for PREEMPT_RT

Sabrina Dubroca (1):
      espintcp: remove encap socket caching to avoid reference leak

Saket Kumar Bhaskar (1):
      perf/hw_breakpoint: Return EOPNOTSUPP for unsupported breakpoint type

Sean Anderson (1):
      spi: zynqmp-gqspi: Always acknowledge interrupts

Seyediman Seyedarab (1):
      kbuild: fix argument parsing in scripts/config

Shahar Shitrit (2):
      net/mlx5: Modify LSB bitmask in temperature event to include only the first bit
      net/mlx5: Apply rate-limiting to high temperature warning

Shashank Gupta (1):
      crypto: octeontx2 - suppress auth failure screaming due to negative tests

Shigeru Yoshida (1):
      af_unix: Fix uninit-value in __unix_walk_scc()

Shivasharan S (1):
      scsi: mpt3sas: Send a diag reset if target reset fails

Shiwu Zhang (1):
      drm/amdgpu: enlarge the VBIOS binary size limit

Shixiong Ou (1):
      fbdev: fsl-diu-fb: add missing device_remove_file()

Simona Vetter (1):
      drm/atomic: clarify the rules around drm_atomic_state->allow_modeset

Soeren Moch (1):
      wifi: rtl8xxxu: retry firmware download on error

Stanimir Varbanov (2):
      PCI: brcmstb: Expand inbound window size up to 64GB
      PCI: brcmstb: Add a softdep to MIP MSI-X driver

Stanley Chu (1):
      i3c: master: svc: Fix missing STOP for master request

Stephan Gerhold (1):
      i2c: qup: Vote for interconnect bandwidth to DRAM

Subbaraya Sundeep (1):
      octeontx2-af: Set LMT_ENA bit for APR table entries

Suman Ghosh (1):
      octeontx2-pf: Add AF_XDP non-zero copy support

Svyatoslav Ryhel (1):
      ARM: tegra: Switch DSI-B clock parent to PLLD on Tegra114

Takashi Iwai (4):
      ALSA: seq: Improve data consistency at polling
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Acer Aspire SW3-013
      ALSA: hda/realtek: Add quirk for HP Spectre x360 15-df1xxx
      ALSA: pcm: Fix race of buffer access at PCM OSS layer

Thangaraj Samynathan (1):
      net: lan743x: Restore SGMII CTRL register on resume

Thomas Weißschuh (1):
      timer_list: Don't use %pK through printk()

Thomas Zimmermann (1):
      drm/ast: Find VBIOS mode from regular display size

Tianyang Zhang (1):
      mm/page_alloc.c: avoid infinite retries caused by cpuset race

Tiwei Bie (1):
      um: Update min_low_pfn to match changes in uml_reserved

Tom Chung (1):
      drm/amd/display: Initial psr_version with correct setting

Trond Myklebust (8):
      NFSv4: Check for delegation validity in nfs_start_delegation_return_locked()
      NFS: Don't allow waiting for exiting tasks
      SUNRPC: Don't allow waiting for exiting tasks
      NFSv4: Treat ENETUNREACH errors as fatal for state recovery
      SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
      SUNRPC: rpcbind should never reset the port to the value '0'
      pNFS/flexfiles: Report ENETDOWN as a connection error
      NFS: Avoid flushing data while holding directory locks in nfs_rename()

Tudor Ambarus (1):
      mailbox: use error ret code of of_parse_phandle_with_args()

Valentin Caron (1):
      pinctrl: devicetree: do not goto err when probing hogs in pinctrl_dt_to_map

Valtteri Koskivuori (1):
      platform/x86: fujitsu-laptop: Support Lifebook S2110 hotkeys

Vasant Hegde (1):
      iommu/amd/pgtbl_v2: Improve error handling

Victor Lu (1):
      drm/amdgpu: Do not program AGP BAR regs under SRIOV in gfxhub_v1_0.c

Viktor Malik (1):
      bpftool: Fix readlink usage in get_fd_type

Vinicius Costa Gomes (1):
      dmaengine: idxd: Fix allowing write() from different address spaces

Viresh Kumar (1):
      firmware: arm_ffa: Set dma_mask for ffa devices

Vitalii Mordan (1):
      i2c: pxa: fix call balance of i2c->clk handling routines

Vladimir Moskovkin (1):
      platform/x86: dell-wmi-sysman: Avoid buffer overflow in current_password_store()

Vladimir Oltean (1):
      net: enetc: refactor bulk flipping of RX buffers to separate function

Waiman Long (1):
      x86/nmi: Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()

Wang Liang (1):
      net/tipc: fix slab-use-after-free Read in tipc_aead_encrypt_done

Wang Zhaolong (2):
      smb: client: Fix use-after-free in cifs_fill_dirent
      smb: client: Reset all search buffer pointers when releasing buffer

Willem de Bruijn (1):
      ipv6: save dontfrag in cork

William Tu (2):
      net/mlx5e: set the tx_queue_len for pfifo_fast
      net/mlx5e: reduce rep rxq depth to 256 for ECPF

Xiaofei Tan (1):
      ACPI: HED: Always initialize before evged

Yihan Zhu (1):
      drm/amd/display: handle max_downscale_src_width fail check

Yuanjun Gong (1):
      leds: pwm-multicolor: Add check for fwnode_property_read_u32

Zhikai Zhai (1):
      drm/amd/display: calculate the remain segments for all pipes

Zhongqiu Han (1):
      virtio_ring: Fix data race by tagging event_triggered as racy for KCSAN

Zsolt Kajtar (2):
      fbcon: Use correct erase colour for clearing in fbcon
      fbdev: core: tileblit: Implement missing margin clearing for tileblit

feijuan.li (1):
      drm/edid: fixed the bug that hdr metadata was not reset

gaoxu (1):
      cgroup: Fix compilation issue due to cgroup_mutex not being exported

junan (1):
      HID: usbkbd: Fix the bit shift number for LED_KANA


