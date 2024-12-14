Return-Path: <stable+bounces-104210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F379F20D6
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 22:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4361664E8
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 20:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A371B1D61;
	Sat, 14 Dec 2024 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KKeZzK/1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E81AF0A1;
	Sat, 14 Dec 2024 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734209961; cv=none; b=MwAojzUVn25nltyOfjhiHI505CNELbAhe6drEhfqUGmd6GQdDzsGtiMlDsrWLX2FtRfe0/B6UNdjsOjhh/M/8Agwb+DB9JDmPLM+UDuWVRhGksAJ8bOSAlsF9iUxLKzbwUJgdW/Rjuf5c0HIwyTa3aW4uN+mQUlNjQMop5uedP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734209961; c=relaxed/simple;
	bh=dWtYao56p9L2IUXmNMg1WYw8hdyPVxmquWdqMk/n4nY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gxr4qlaDnSSoSJefrX4hDA/iL7BBtXhYi90jxyuQdRSHGZONVCkkh1a13NXQ+DqY8F27z0whIg0P6geRDMSwhnGs/AZI8y4X3Cp25FV75VTENeaSzXASmkfNBvOCYIfJUl63Dd1JoxjksRio6zf4ZT82UirlVYQxbG7pJIQ01DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KKeZzK/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E675CC4CED1;
	Sat, 14 Dec 2024 20:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734209958;
	bh=dWtYao56p9L2IUXmNMg1WYw8hdyPVxmquWdqMk/n4nY=;
	h=From:To:Cc:Subject:Date:From;
	b=KKeZzK/1iuwIOpuGZi0ZWnl5eIWBS2KtEQYly4Hb24zGx4bPQgSIwpYw+uI3IkWVJ
	 Iqo5Tp6No0GKh1/DuTwk9wwVlZNjJKAlIkAw6z8+ZfBnI27jwT661PqMswcVjDL59W
	 +RJAJnCoK9PF5eCthJaJKKvg77wBvFlfU6TAsEX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.66
Date: Sat, 14 Dec 2024 21:59:12 +0100
Message-ID: <2024121413-embark-establish-6a88@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.66 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-pci                              |   11 
 Documentation/admin-guide/blockdev/zram.rst                          |    2 
 Documentation/netlink/specs/ethtool.yaml                             |    7 
 Makefile                                                             |    2 
 arch/arm64/kernel/ptrace.c                                           |    6 
 arch/arm64/kvm/arm.c                                                 |    2 
 arch/arm64/kvm/mmio.c                                                |   36 
 arch/arm64/mm/context.c                                              |    4 
 arch/loongarch/include/asm/hugetlb.h                                 |   10 
 arch/loongarch/mm/tlb.c                                              |    2 
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi                            |   73 
 arch/powerpc/kernel/prom_init.c                                      |   29 
 arch/powerpc/kernel/vdso/Makefile                                    |   36 
 arch/s390/kernel/perf_cpum_sf.c                                      |    4 
 arch/x86/events/amd/core.c                                           |   10 
 arch/x86/include/asm/pgtable_types.h                                 |    8 
 arch/x86/kernel/cpu/amd.c                                            |    2 
 arch/x86/kernel/relocate_kernel_64.S                                 |    8 
 arch/x86/kvm/mmu/mmu.c                                               |   10 
 arch/x86/kvm/mmu/paging_tmpl.h                                       |    5 
 arch/x86/mm/ident_map.c                                              |    6 
 arch/x86/mm/pti.c                                                    |    2 
 arch/x86/pci/acpi.c                                                  |  119 
 drivers/acpi/x86/utils.c                                             |   77 
 drivers/base/cacheinfo.c                                             |   14 
 drivers/base/core.c                                                  |   69 
 drivers/base/regmap/internal.h                                       |    1 
 drivers/base/regmap/regcache-maple.c                                 |    3 
 drivers/base/regmap/regmap.c                                         |   13 
 drivers/block/zram/Kconfig                                           |   11 
 drivers/block/zram/zram_drv.c                                        |   50 
 drivers/block/zram/zram_drv.h                                        |    2 
 drivers/bluetooth/btusb.c                                            |    4 
 drivers/clk/clk-en7523.c                                             |    4 
 drivers/clk/qcom/clk-rcg.h                                           |    1 
 drivers/clk/qcom/clk-rcg2.c                                          |   48 
 drivers/clk/qcom/clk-rpmh.c                                          |   13 
 drivers/clk/qcom/tcsrcc-sm8550.c                                     |   18 
 drivers/dma-buf/dma-fence-array.c                                    |   28 
 drivers/dma-buf/dma-fence-unwrap.c                                   |  126 
 drivers/gpio/gpio-grgpio.c                                           |   26 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                             |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                           |   48 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                              |    5 
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c                                |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                              |   30 
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c                               |   27 
 drivers/gpu/drm/bridge/ite-it6505.c                                  |   11 
 drivers/gpu/drm/display/drm_dp_dual_mode_helper.c                    |    4 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                        |   55 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                       |   18 
 drivers/gpu/drm/mcde/mcde_drv.c                                      |    1 
 drivers/gpu/drm/panel/panel-simple.c                                 |   28 
 drivers/gpu/drm/radeon/r600_cs.c                                     |    2 
 drivers/gpu/drm/scheduler/sched_main.c                               |    8 
 drivers/gpu/drm/sti/sti_mixer.c                                      |    2 
 drivers/gpu/drm/v3d/v3d_perfmon.c                                    |    2 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                       |    2 
 drivers/gpu/drm/vc4/vc4_hvs.c                                        |   11 
 drivers/hid/hid-core.c                                               |    5 
 drivers/hid/hid-generic.c                                            |    3 
 drivers/hid/hid-ids.h                                                |    1 
 drivers/hid/hid-magicmouse.c                                         |   56 
 drivers/hid/wacom_sys.c                                              |    3 
 drivers/hwmon/nct6775-platform.c                                     |    2 
 drivers/i3c/master.c                                                 |  193 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                |    2 
 drivers/i3c/master/svc-i3c-master.c                                  |  140 
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c               |    4 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                    |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                     |    2 
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c                        |    1 
 drivers/iio/light/ltr501.c                                           |    2 
 drivers/iio/magnetometer/yamaha-yas530.c                             |   13 
 drivers/infiniband/core/addr.c                                       |    6 
 drivers/iommu/arm/arm-smmu/arm-smmu.c                                |   11 
 drivers/leds/led-class.c                                             |   14 
 drivers/md/bcache/super.c                                            |    2 
 drivers/media/usb/cx231xx/cx231xx-cards.c                            |    2 
 drivers/media/usb/uvc/uvc_driver.c                                   |   20 
 drivers/misc/eeprom/eeprom_93cx6.c                                   |   10 
 drivers/mmc/core/bus.c                                               |    2 
 drivers/mmc/core/card.h                                              |    7 
 drivers/mmc/core/core.c                                              |    3 
 drivers/mmc/core/quirks.h                                            |    9 
 drivers/mmc/core/sd.c                                                |    2 
 drivers/mmc/host/mtk-sd.c                                            |   64 
 drivers/mmc/host/sdhci-esdhc-imx.c                                   |    6 
 drivers/mmc/host/sdhci-pci-core.c                                    |   72 
 drivers/mmc/host/sdhci-pci.h                                         |    1 
 drivers/net/can/c_can/c_can_main.c                                   |   26 
 drivers/net/can/dev/dev.c                                            |    2 
 drivers/net/can/ifi_canfd/ifi_canfd.c                                |   58 
 drivers/net/can/m_can/m_can.c                                        |   33 
 drivers/net/can/sja1000/sja1000.c                                    |   67 
 drivers/net/can/spi/hi311x.c                                         |   50 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c                        |   29 
 drivers/net/can/sun4i_can.c                                          |   22 
 drivers/net/can/usb/ems_usb.c                                        |   58 
 drivers/net/can/usb/f81604.c                                         |   10 
 drivers/net/can/usb/gs_usb.c                                         |   28 
 drivers/net/dsa/qca/qca8k-8xxx.c                                     |    2 
 drivers/net/ethernet/freescale/enetc/enetc.c                         |    3 
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c                     |    2 
 drivers/net/ethernet/freescale/fman/fman.c                           |    1 
 drivers/net/ethernet/freescale/fman/fman.h                           |    3 
 drivers/net/ethernet/freescale/fman/mac.c                            |    5 
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c                 |    2 
 drivers/net/ethernet/intel/igb/igb_main.c                            |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h                      |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                       |    2 
 drivers/net/ethernet/intel/ixgbevf/ipsec.c                           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c            |   13 
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c             |   12 
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h             |   17 
 drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c              |   20 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c         |   96 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c                  |    2 
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                            |    4 
 drivers/net/ethernet/realtek/r8169_main.c                            |   14 
 drivers/net/ethernet/rocker/rocker_main.c                            |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h                         |    5 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c                     |    5 
 drivers/net/geneve.c                                                 |    2 
 drivers/net/phy/sfp.c                                                |    3 
 drivers/net/virtio_net.c                                             |   12 
 drivers/net/vrf.c                                                    |    2 
 drivers/net/vxlan/vxlan_core.c                                       |    2 
 drivers/net/wireless/ath/ath5k/pci.c                                 |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c            |    2 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c                       |    8 
 drivers/net/wireless/realtek/rtw89/fw.c                              |    3 
 drivers/nvdimm/dax_devs.c                                            |    4 
 drivers/nvdimm/nd.h                                                  |    7 
 drivers/pci/controller/dwc/pcie-qcom.c                               |    1 
 drivers/pci/controller/vmd.c                                         |   17 
 drivers/pci/pci-sysfs.c                                              |   26 
 drivers/pci/pci.c                                                    |    2 
 drivers/pci/pci.h                                                    |    1 
 drivers/pci/probe.c                                                  |   30 
 drivers/pci/quirks.c                                                 |   15 
 drivers/pinctrl/core.c                                               |    3 
 drivers/pinctrl/core.h                                               |    1 
 drivers/pinctrl/freescale/Kconfig                                    |    2 
 drivers/pinctrl/pinmux.c                                             |  173 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                             |    2 
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                              |    1 
 drivers/platform/x86/asus-wmi.c                                      |  109 
 drivers/ptp/ptp_clock.c                                              |    3 
 drivers/rtc/rtc-cmos.c                                               |   31 
 drivers/s390/net/ism_drv.c                                           |   19 
 drivers/s390/net/qeth_core.h                                         |    4 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                               |    1 
 drivers/scsi/lpfc/lpfc_init.c                                        |    2 
 drivers/scsi/lpfc/lpfc_sli.c                                         |   41 
 drivers/scsi/qla2xxx/qla_attr.c                                      |    1 
 drivers/scsi/qla2xxx/qla_bsg.c                                       |  124 
 drivers/scsi/qla2xxx/qla_mid.c                                       |    1 
 drivers/scsi/qla2xxx/qla_os.c                                        |   15 
 drivers/scsi/scsi_debug.c                                            |    2 
 drivers/scsi/sg.c                                                    |    2 
 drivers/scsi/st.c                                                    |   31 
 drivers/soc/fsl/qe/qmc.c                                             |  141 
 drivers/soc/imx/soc-imx8m.c                                          |  107 
 drivers/spi/spi-fsl-lpspi.c                                          |    7 
 drivers/spi/spi-mpc52xx.c                                            |    1 
 drivers/thermal/qcom/tsens-v1.c                                      |   21 
 drivers/thermal/qcom/tsens.c                                         |    3 
 drivers/thermal/qcom/tsens.h                                         |    2 
 drivers/tty/serial/8250/8250_dw.c                                    |    5 
 drivers/tty/serial/amba-pl011.c                                      |   79 
 drivers/ufs/core/ufs-sysfs.c                                         |    6 
 drivers/ufs/core/ufs_bsg.c                                           |    2 
 drivers/ufs/core/ufshcd-priv.h                                       |    1 
 drivers/ufs/core/ufshcd.c                                            |   58 
 drivers/ufs/host/ufs-renesas.c                                       |    9 
 drivers/usb/chipidea/udc.c                                           |    2 
 drivers/usb/dwc3/core.h                                              |    1 
 drivers/usb/dwc3/ep0.c                                               |    7 
 drivers/usb/dwc3/gadget.c                                            |   89 
 drivers/usb/dwc3/gadget.h                                            |    1 
 drivers/usb/host/xhci-dbgcap.c                                       |  135 
 drivers/usb/host/xhci-dbgcap.h                                       |    2 
 drivers/usb/host/xhci-pci.c                                          |   21 
 drivers/usb/host/xhci-rcar.c                                         |    6 
 drivers/usb/host/xhci-ring.c                                         |   29 
 drivers/usb/host/xhci.c                                              |   19 
 drivers/usb/host/xhci.h                                              |    5 
 drivers/vfio/pci/mlx5/cmd.c                                          |   47 
 drivers/watchdog/apple_wdt.c                                         |    2 
 drivers/watchdog/iTCO_wdt.c                                          |   21 
 drivers/watchdog/mtk_wdt.c                                           |    6 
 drivers/watchdog/rti_wdt.c                                           |    3 
 drivers/watchdog/xilinx_wwdt.c                                       |   75 
 fs/btrfs/dev-replace.c                                               |    2 
 fs/btrfs/extent-tree.c                                               |    7 
 fs/btrfs/free-space-cache.c                                          |    4 
 fs/btrfs/free-space-cache.h                                          |    7 
 fs/btrfs/fs.h                                                        |    2 
 fs/btrfs/inode.c                                                     |    1 
 fs/btrfs/volumes.c                                                   |   50 
 fs/dlm/lock.c                                                        |   10 
 fs/eventpoll.c                                                       |    6 
 fs/f2fs/extent_cache.c                                               |   69 
 fs/f2fs/inode.c                                                      |    4 
 fs/f2fs/node.c                                                       |    7 
 fs/f2fs/segment.c                                                    |    9 
 fs/f2fs/super.c                                                      |   12 
 fs/gfs2/super.c                                                      |    2 
 fs/jffs2/compr_rtime.c                                               |    3 
 fs/jfs/jfs_dmap.c                                                    |    6 
 fs/jfs/jfs_dtree.c                                                   |   15 
 fs/nilfs2/dir.c                                                      |    2 
 fs/notify/fanotify/fanotify_user.c                                   |   85 
 fs/ntfs3/run.c                                                       |   40 
 fs/ocfs2/dlmglue.c                                                   |    1 
 fs/ocfs2/localalloc.c                                                |   19 
 fs/ocfs2/namei.c                                                     |    4 
 fs/smb/client/cifsproto.h                                            |    1 
 fs/smb/client/cifssmb.c                                              |    2 
 fs/smb/client/dfs.c                                                  |  188 
 fs/smb/client/inode.c                                                |   94 
 fs/smb/client/readdir.c                                              |   54 
 fs/smb/client/reparse.c                                              |   84 
 fs/smb/client/smb2inode.c                                            |    3 
 fs/smb/server/smb2pdu.c                                              |    6 
 fs/unicode/mkutf8data.c                                              |   70 
 fs/unicode/utf8data.c_shipped                                        | 6703 +++++-----
 include/drm/display/drm_dp_mst_helper.h                              |    7 
 include/linux/eeprom_93cx6.h                                         |   11 
 include/linux/eventpoll.h                                            |    2 
 include/linux/fanotify.h                                             |    1 
 include/linux/fwnode.h                                               |    2 
 include/linux/hid.h                                                  |    2 
 include/linux/i3c/master.h                                           |   33 
 include/linux/leds.h                                                 |    2 
 include/linux/mm_types.h                                             |    3 
 include/linux/mmc/card.h                                             |    1 
 include/linux/pci.h                                                  |    6 
 include/linux/platform_data/x86/asus-wmi.h                           |    1 
 include/linux/scatterlist.h                                          |    2 
 include/linux/sched.h                                                |    7 
 include/net/bluetooth/hci.h                                          |   14 
 include/net/bluetooth/hci_core.h                                     |   10 
 include/net/ip6_fib.h                                                |    6 
 include/net/ip6_route.h                                              |   11 
 include/net/netfilter/nf_tables_core.h                               |    1 
 include/net/smc.h                                                    |   28 
 include/sound/ump.h                                                  |   11 
 include/trace/events/sched.h                                         |   15 
 include/trace/trace_events.h                                         |   36 
 include/uapi/linux/fanotify.h                                        |    1 
 include/uapi/linux/sched/types.h                                     |    4 
 include/ufs/ufshcd.h                                                 |   19 
 io_uring/tctx.c                                                      |   13 
 kernel/bpf/devmap.c                                                  |    6 
 kernel/bpf/hashtab.c                                                 |   56 
 kernel/bpf/lpm_trie.c                                                |   55 
 kernel/bpf/syscall.c                                                 |   22 
 kernel/bpf/verifier.c                                                |    1 
 kernel/dma/debug.c                                                   |    8 
 kernel/kcsan/debugfs.c                                               |   74 
 kernel/sched/core.c                                                  |   23 
 kernel/sched/deadline.c                                              |  178 
 kernel/sched/fair.c                                                  |   98 
 kernel/sched/idle.c                                                  |    4 
 kernel/sched/rt.c                                                    |   21 
 kernel/sched/sched.h                                                 |   27 
 kernel/sched/stop_task.c                                             |   17 
 kernel/time/ntp.c                                                    |    2 
 kernel/trace/trace_clock.c                                           |    2 
 kernel/trace/trace_eprobe.c                                          |    5 
 kernel/trace/trace_syscalls.c                                        |   12 
 kernel/trace/tracing_map.c                                           |    6 
 lib/stackinit_kunit.c                                                |    1 
 mm/damon/vaddr-test.h                                                |    1 
 mm/damon/vaddr.c                                                     |    4 
 mm/kasan/report.c                                                    |    6 
 mm/mempolicy.c                                                       |  342 
 mm/page_alloc.c                                                      |   15 
 mm/swap.c                                                            |   20 
 net/bluetooth/6lowpan.c                                              |    2 
 net/bluetooth/hci_core.c                                             |   13 
 net/bluetooth/hci_event.c                                            |    7 
 net/bluetooth/hci_sync.c                                             |    9 
 net/bluetooth/l2cap_sock.c                                           |    1 
 net/bluetooth/rfcomm/sock.c                                          |   10 
 net/can/af_can.c                                                     |    1 
 net/can/j1939/transport.c                                            |    2 
 net/core/dst_cache.c                                                 |    2 
 net/core/filter.c                                                    |    2 
 net/core/link_watch.c                                                |    7 
 net/core/neighbour.c                                                 |    1 
 net/core/netpoll.c                                                   |    2 
 net/dccp/feat.c                                                      |    6 
 net/ethtool/bitset.c                                                 |   48 
 net/hsr/hsr_forward.c                                                |    2 
 net/ieee802154/socket.c                                              |   12 
 net/ipv4/af_inet.c                                                   |   22 
 net/ipv4/ip_output.c                                                 |   13 
 net/ipv4/ip_tunnel.c                                                 |    2 
 net/ipv4/tcp_bpf.c                                                   |   11 
 net/ipv6/af_inet6.c                                                  |   22 
 net/ipv6/icmp.c                                                      |    8 
 net/ipv6/ila/ila_lwt.c                                               |    4 
 net/ipv6/ip6_output.c                                                |   31 
 net/ipv6/ip6mr.c                                                     |    2 
 net/ipv6/ndisc.c                                                     |    2 
 net/ipv6/ping.c                                                      |    2 
 net/ipv6/raw.c                                                       |    4 
 net/ipv6/route.c                                                     |   34 
 net/ipv6/tcp_ipv6.c                                                  |    4 
 net/ipv6/udp.c                                                       |   11 
 net/ipv6/xfrm6_policy.c                                              |    2 
 net/l2tp/l2tp_ip6.c                                                  |    2 
 net/mpls/mpls_iptunnel.c                                             |    2 
 net/netfilter/ipset/ip_set_core.c                                    |    5 
 net/netfilter/ipvs/ip_vs_proto.c                                     |    4 
 net/netfilter/ipvs/ip_vs_xmit.c                                      |   14 
 net/netfilter/nf_flow_table_core.c                                   |    8 
 net/netfilter/nf_flow_table_ip.c                                     |    4 
 net/netfilter/nft_inner.c                                            |   57 
 net/netfilter/nft_rt.c                                               |    2 
 net/netfilter/nft_set_hash.c                                         |   16 
 net/netfilter/nft_socket.c                                           |    2 
 net/netfilter/xt_LED.c                                               |    4 
 net/packet/af_packet.c                                               |   12 
 net/sched/cls_flower.c                                               |    5 
 net/sched/sch_cbs.c                                                  |    2 
 net/sched/sch_tbf.c                                                  |   18 
 net/sctp/ipv6.c                                                      |    2 
 net/smc/af_smc.c                                                     |  226 
 net/smc/smc.h                                                        |    8 
 net/smc/smc_clc.c                                                    |  297 
 net/smc/smc_clc.h                                                    |   50 
 net/smc/smc_core.c                                                   |   98 
 net/smc/smc_core.h                                                   |   18 
 net/smc/smc_diag.c                                                   |    7 
 net/smc/smc_ism.c                                                    |   66 
 net/smc/smc_ism.h                                                    |   27 
 net/smc/smc_pnet.c                                                   |    4 
 net/tipc/udp_media.c                                                 |    2 
 net/vmw_vsock/af_vsock.c                                             |   70 
 net/xdp/xsk_buff_pool.c                                              |    5 
 net/xdp/xskmap.c                                                     |    2 
 net/xfrm/xfrm_policy.c                                               |    3 
 samples/bpf/test_cgrp2_sock.c                                        |    4 
 scripts/mod/modpost.c                                                |    2 
 scripts/setlocalversion                                              |   54 
 sound/core/seq/seq_ump_client.c                                      |  110 
 sound/core/ump.c                                                     |   77 
 sound/pci/hda/hda_auto_parser.c                                      |   61 
 sound/pci/hda/hda_local.h                                            |   28 
 sound/pci/hda/patch_analog.c                                         |    6 
 sound/pci/hda/patch_cirrus.c                                         |    8 
 sound/pci/hda/patch_conexant.c                                       |   36 
 sound/pci/hda/patch_cs8409-tables.c                                  |    2 
 sound/pci/hda/patch_cs8409.h                                         |    2 
 sound/pci/hda/patch_realtek.c                                        |   22 
 sound/pci/hda/patch_sigmatel.c                                       |   22 
 sound/pci/hda/patch_via.c                                            |    2 
 sound/soc/amd/yc/acp6x-mach.c                                        |   14 
 sound/soc/codecs/hdmi-codec.c                                        |  140 
 sound/soc/intel/avs/pcm.c                                            |    2 
 sound/soc/mediatek/mt8188/mt8188-mt6359.c                            |    4 
 sound/soc/sof/ipc3-topology.c                                        |   31 
 sound/usb/endpoint.c                                                 |   14 
 sound/usb/midi2.c                                                    |    2 
 sound/usb/mixer.c                                                    |   58 
 sound/usb/mixer_maps.c                                               |   10 
 sound/usb/quirks.c                                                   |   31 
 sound/usb/usbaudio.h                                                 |    4 
 tools/bpf/bpftool/prog.c                                             |   17 
 tools/scripts/Makefile.arch                                          |    4 
 tools/testing/selftests/arm64/fp/fp-stress.c                         |   15 
 tools/testing/selftests/arm64/pauth/pac.c                            |    3 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc |    2 
 tools/testing/selftests/hid/run-hid-tools-tests.sh                   |   16 
 tools/testing/selftests/resctrl/resctrl_val.c                        |    4 
 tools/testing/selftests/resctrl/resctrlfs.c                          |    2 
 tools/tracing/rtla/src/timerlat_top.c                                |    8 
 tools/tracing/rtla/src/utils.c                                       |    4 
 tools/tracing/rtla/src/utils.h                                       |    2 
 tools/verification/dot2/automata.py                                  |   18 
 384 files changed, 8897 insertions(+), 6157 deletions(-)

Abhishek Chauhan (1):
      net: stmmac: Programming sequence for VLAN packets with split header

Adrian Huang (1):
      sched/numa: fix memory leak due to the overwritten vma->numab_state

Ajay Kaher (1):
      ptp: Add error handling for adjfine callback in ptp_clock_adjtime

Aleksandr Mishin (1):
      fsl/fman: Validate cell-index value obtained from Device Tree

Alex Deucher (2):
      drm/amdgpu/hdp5.2: do a posting read when flushing HDP
      drm/amdgpu: rework resume handling for display (v2)

Alex Far (1):
      ASoC: amd: yc: fix internal mic on Redmi G 2022

Alexander Aring (1):
      dlm: fix possible lkb_resource null dereference

Alexander Kozhinov (1):
      can: gs_usb: add usb endpoint address detection at driver probe step

Alexander Sverdlin (1):
      watchdog: rti: of: honor timeout-sec property

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Fix return status of avs_pcm_hw_constraints_init()

Amir Goldstein (1):
      fanotify: allow reporting errors on failure to open fd

Amir Mohammadi (1):
      bpftool: fix potential NULL pointer dereferencing in prog_dump()

Amit Cohen (4):
      mlxsw: Add 'ipv4_5' flex key
      mlxsw: spectrum_acl_flex_keys: Add 'ipv4_5b' flex key
      mlxsw: Edit IPv6 key blocks to use one less block for multicast forwarding
      mlxsw: Mark high entropy key blocks

Andrew Lunn (1):
      dsa: qca8k: Use nested lock to avoid splat

Andrii Nakryiko (1):
      bpf: put bpf_link's program when link is safe to be deallocated

Andy Shevchenko (1):
      iio: light: ltr501: Add LTER0303 to the supported devices

Andy-ld Lu (2):
      mmc: mtk-sd: Fix error handle of probe function
      mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting

Anil Gurumurthy (1):
      scsi: qla2xxx: Supported speed displayed incorrectly for VPorts

Armin Wolf (3):
      platform/x86: asus-wmi: Fix inconsistent use of thermal policies
      platform/x86: asus-wmi: Ignore return value when writing thermal policy
      platform/x86: asus-wmi: Fix thermal profile initialization

Arnd Bergmann (1):
      serial: amba-pl011: fix build regression

Bard Liao (1):
      ASoC: SOF: ipc3-topology: Convert the topology pin index to ALH dai index

Barnabás Czémán (3):
      pinctrl: qcom-pmic-gpio: add support for PM8937
      pinctrl: qcom: spmi-mpp: Add PM8937 compatible
      thermal/drivers/qcom/tsens-v1: Add support for MSM8937 tsens

Bart Van Assche (2):
      scsi: ufs: core: Always initialize the UIC done completion
      scsi: ufs: core: Make DMA mask configuration more flexible

Bartosz Golaszewski (1):
      gpio: grgpio: use a helper variable to store the address of ofdev->dev

Basavaraj Natikar (1):
      xhci: Allow RPM on the USB controller (1022:43f7) by default

Benjamin Tissoires (1):
      HID: add per device quirk to force bind to hid-generic

Bibo Mao (1):
      LoongArch: Add architecture specific huge_pte_clear()

Björn Töpel (1):
      tools: Override makefile ARCH variable if defined, but empty

Boris Burkov (1):
      btrfs: do not clear read-only when adding sprout device

Brahmajit Das (1):
      drm/display: Fix building with GCC 15

Breno Leitao (2):
      perf/x86/amd: Warn only on new bits set
      netpoll: Use rcu_access_pointer() in __netpoll_setup

Callahan Kovacs (1):
      HID: magicmouse: Apple Magic Trackpad 2 USB-C driver support

Carlos Song (2):
      i3c: master: support to adjust first broadcast address speed
      i3c: master: svc: use slow speed for first broadcast address

Catalin Marinas (1):
      arm64: Ensure bits ASID[15:8] are masked out when the kernel uses 8-bit ASIDs

Chao Yu (3):
      f2fs: fix to drop all discards after creating snapshot on lvm device
      f2fs: print message if fscorrupted was found in f2fs_new_node_page()
      f2fs: fix to shrink read extent node in batches

Charles Han (1):
      gpio: grgpio: Add NULL check in grgpio_probe

Chen-Yu Tsai (1):
      drm/bridge: it6505: Fix inverted reset polarity

Christian Brauner (1):
      epoll: annotate racy check

Christian König (1):
      dma-buf: fix dma_fence_array_signaled v4

Christophe JAILLET (1):
      mlxsw: spectrum_acl_flex_keys: Constify struct mlxsw_afk_element_inst

Christophe Leroy (1):
      powerpc/vdso: Refactor CFLAGS for CVDSO build

Cosmin Tanislav (1):
      regmap: detach regmap from dev on regmap_exit

Cristian Ciocaltea (1):
      regmap: maple: Provide lockdep (sub)class for maple tree's internal lock

D. Wythe (1):
      net/smc: refactoring initialization of smc sock

Damien Le Moal (1):
      x86: Fix build regression with CONFIG_KEXEC_JUMP enabled

Dan Carpenter (1):
      ASoC: SOF: ipc3-topology: fix resource leaks in sof_ipc3_widget_setup_comp_dai()

Danil Pylaev (3):
      Bluetooth: Add new quirks for ATS2851
      Bluetooth: Support new quirks for ATS2851
      Bluetooth: Set quirks for ATS2851

Dario Binacchi (10):
      can: c_can: c_can_handle_bus_err(): update statistics if skb allocation fails
      can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL
      can: hi311x: hi3110_can_ist(): fix potential use-after-free
      can: m_can: m_can_handle_lec_err(): fix {rx,tx}_errors statistics
      can: ifi_canfd: ifi_canfd_handle_lec_err(): fix {rx,tx}_errors statistics
      can: hi311x: hi3110_can_ist(): fix {rx,tx}_errors statistics
      can: sja1000: sja1000_err(): fix {rx,tx}_errors statistics
      can: sun4i_can: sun4i_can_err(): fix {rx,tx}_errors statistics
      can: ems_usb: ems_usb_rx_err(): fix {rx,tx}_errors statistics
      can: f81604: f81604_handle_can_bus_errors(): fix {rx,tx}_errors statistics

Dave Stevenson (1):
      drm/vc4: hvs: Set AXI panic modes for the HVS

David Given (1):
      media: uvcvideo: Add a quirk for the Kaiweets KTI-W02 infrared camera

David Hildenbrand (1):
      mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM

David Woodhouse (2):
      x86/kexec: Restore GDT on return from ::preserve_context kexec
      x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables

Defa Li (1):
      i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock

Dmitry Antipov (3):
      netfilter: x_tables: fix LED ID check in led_tg_check()
      can: j1939: j1939_session_new(): fix skb reference counting
      rocker: fix link status detection in rocker_carrier_init()

Dmitry Baryshkov (3):
      clk: qcom: rcg2: add clk_rcg2_shared_floor_ops
      clk: qcom: rpmh: add support for SAR2130P
      clk: qcom: tcsrcc-sm8550: add SAR2130P support

Dmitry Perchanov (1):
      media: uvcvideo: RealSense D421 Depth module metadata

Dmitry Torokhov (1):
      rtc: cmos: avoid taking rtc_lock for extended period of time

Dom Cobley (1):
      drm/vc4: hdmi: Avoid log spam for audio start failure

Donald Hunter (1):
      netlink: specs: Add missing bitset attrs to ethtool spec

Elena Salomatkina (1):
      net/sched: cbs: Fix integer overflow in cbs_set_port_rate()

Eric Dumazet (4):
      net: hsr: avoid potential out-of-bound access in fill_frame_info()
      ipv6: introduce dst_rt6_info() helper
      geneve: do not assume mac header is set in geneve_xmit_skb()
      net: avoid potential UAF in default_operstate()

Esben Haabendal (1):
      pinctrl: freescale: fix COMPILE_TEST error with PINCTRL_IMX_SCU

Esther Shimanovich (1):
      PCI: Detect and trust built-in Thunderbolt chips

Filipe Manana (1):
      btrfs: fix missing snapshot drew unlock when root is dead during swap activation

Frank Li (9):
      i3c: master: add enable(disable) hot join in sys entry
      i3c: master: svc: add hot join support
      i3c: master: fix kernel-doc check warning
      i3c: master: svc: Modify enabled_events bit 7:0 to act as IBI enable counter
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_DESIRED
      i3c: master: Fix dynamic address leak when 'assigned-address' is present
      i3c: master: Remove i3c_dev_disable_ibi_locked(olddev) on device hotjoin
      i3c: master: svc: fix possible assignment of the same address to two devices

Fuad Tabba (1):
      KVM: arm64: Change kvm_handle_mmio_return() return polarity

Gabriele Monaco (1):
      verification/dot2: Improve dot parser robustness

Ghanshyam Agrawal (3):
      jfs: array-index-out-of-bounds fix in dtReadFirst
      jfs: fix shift-out-of-bounds in dbSplit
      jfs: fix array-index-out-of-bounds in jfs_readdir

Greg Kroah-Hartman (1):
      Linux 6.6.66

Gwendal Grignou (1):
      scsi: ufs: core: sysfs: Prevent div by zero

Hans de Goede (4):
      mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet
      ACPI: x86: Make UART skip quirks work on PCI UARTs without an UID
      ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 8 A1-840
      ACPI: x86: Clean up Asus entries in acpi_quirk_skip_dmi_ids[]

Haoyu Li (1):
      clk: en7523: Initialize num before accessing hws in en7523_register_clocks()

Hari Bathini (1):
      selftests/ftrace: adjust offset for kprobe syntax error test

Harini T (1):
      watchdog: xilinx_wwdt: Calculate max_hw_heartbeat_ms using clock frequency

Heiner Kallweit (1):
      r8169: don't apply UDP padding quirk on RTL8126A

Heming Zhao (1):
      ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"

Herve Codina (5):
      soc: fsl: cpm1: qmc: Fix blank line and spaces
      soc: fsl: cpm1: qmc: Re-order probe() operations
      soc: fsl: cpm1: qmc: Introduce qmc_init_resource() and its CPM1 version
      soc: fsl: cpm1: qmc: Introduce qmc_{init,exit}_xcc() and their CPM1 version
      soc: fsl: cpm1: qmc: Set the ret error code on platform_get_irq() failure

Hilda Wu (1):
      Bluetooth: btusb: Add RTL8852BE device 0489:e123 to device tables

Hou Tao (5):
      bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
      bpf: Remove unnecessary kfree(im_node) in lpm_trie_update_elem
      bpf: Handle in-place update for full LPM trie correctly
      bpf: Fix exact match conditions in trie_get_next_key()
      bpf: Call free_htab_elem() after htab_unlock_bucket()

Huacai Chen (1):
      LoongArch: Fix sleeping in atomic context for PREEMPT_RT

Hugh Dickins (1):
      mempolicy: fix migrate_pages(2) syscall return nr_failed

Ido Schimmel (1):
      mlxsw: spectrum_acl_flex_keys: Use correct key block on Spectrum-4

Ignat Korchagin (7):
      af_packet: avoid erroring out after sock_init_data() in packet_create()
      Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
      Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
      net: af_can: do not leave a dangling sk pointer in can_create()
      net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
      net: inet: do not leave a dangling sk pointer in inet_create()
      net: inet6: do not leave a dangling sk pointer in inet6_create()

Igor Artemiev (1):
      drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()

Imre Deak (3):
      drm/dp_mst: Fix MST sideband message body length check
      drm/dp_mst: Verify request type in the corresponding down message reply
      drm/dp_mst: Fix resetting msg rx state after topology removal

Ingo Molnar (2):
      sched/fair: Rename check_preempt_wakeup() to check_preempt_wakeup_fair()
      sched/fair: Rename check_preempt_curr() to wakeup_preempt()

Inochi Amaoto (1):
      serial: 8250_dw: Add Sophgo SG2044 quirk

Ivan Solodovnikov (1):
      dccp: Fix memory leak in dccp_feat_change_recv

Jacob Keller (2):
      ixgbevf: stop attempting IPSEC offload on Mailbox API 1.5
      ixgbe: downgrade logging of unsupported VF API version to debug

Jakob Hauser (1):
      iio: magnetometer: yas530: use signed integer type for clamp limits

Jakub Kicinski (1):
      net/neighbor: clear error in case strict check is not set

Jan Stancek (1):
      tools/rtla: fix collision with glibc sched_attr/sched_set_attr

Jared Kangas (1):
      kasan: make report_lock a raw spinlock

Jarkko Nikula (1):
      i3c: mipi-i3c-hci: Mask ring interrupts before ring stop request

Jean-Baptiste Maneyrol (1):
      iio: invensense: fix multiple odr switch when FIFO is off

Jens Axboe (1):
      io_uring/tctx: work around xa_store() allocation error issue

Jian-Hong Pan (1):
      PCI: vmd: Set devices to D0 before enabling PM L1 Substates

Jianbo Liu (1):
      net/mlx5e: Remove workaround to avoid syndrome for internal port

Jiapeng Chong (1):
      wifi: ipw2x00: libipw_rx_any(): fix bad alignment

Jinghao Jia (1):
      ipvs: fix UB due to uninitialized stack access in ip_vs_protocol_init()

Jiri Wiesner (1):
      net/ipv6: release expired exception dst cached in socket

Joaquín Ignacio Aramendía (3):
      drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model
      drm: panel-orientation-quirks: Add quirk for AYA NEO Founder edition
      drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK

Johannes Thumshirn (1):
      btrfs: don't take dev_replace rwsem on task already holding it

John Garry (1):
      scsi: scsi_debug: Fix hrtimer support for ndelay

Jonas Karlman (1):
      ASoC: hdmi-codec: reorder channel allocation list

Jordy Zomer (2):
      ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read
      ksmbd: fix Out-of-Bounds Write in ksmbd_vfs_stream_write

Justin Tee (1):
      scsi: lpfc: Call lpfc_sli4_queue_unset() in restart and rmmod paths

K Prateek Nayak (3):
      sched/core: Remove the unnecessary need_resched() check in nohz_csd_func()
      sched/fair: Check idle_cpu() before need_resched() to detect ilb CPU turning busy
      sched/core: Prevent wakeup of ksoftirqd during idle load balance

Kai Mäkisara (2):
      scsi: st: Don't modify unknown block number in MTIOCGET
      scsi: st: Add MTIOCGET and MTLOAD to ioctls allowed after device reset

Kartik Rajput (1):
      serial: amba-pl011: Fix RX stall when DMA is used

Kees Cook (2):
      lib: stackinit: hide never-taken branch from compiler
      smb: client: memcpy() with surrounding object base address

Keita Aihara (1):
      mmc: core: Add SD card quirk for broken poweroff notification

Keith Busch (1):
      PCI: Add 'reset_subordinate' to reset hierarchy below bridge

Kinsey Moore (1):
      jffs2: Prevent rtime decompress memory corruption

Kir Kolyshkin (1):
      sched/headers: Move 'struct sched_param' out of uapi, to work around glibc/musl breakage

Konstantin Komarov (1):
      fs/ntfs3: Fix case when unmarked clusters intersect with zone

Kory Maincent (1):
      ethtool: Fix wrong mod state in case of verbose and no_mask bitset

Kuan-Wei Chiu (1):
      tracing: Fix cmp_entries_dup() to respect sort() comparison rules

Kuangyi Chiang (3):
      xhci: Combine two if statements for Etron xHCI host
      xhci: Don't issue Reset Device command to Etron xHCI host
      xhci: Fix control transfer error on Etron xHCI host

Kuniyuki Iwashima (1):
      tipc: Fix use-after-free of kernel socket in cleanup_bearer().

Kuro Chung (1):
      drm/bridge: it6505: update usleep_range for RC circuit charge time

Lang Yu (1):
      drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr

Larysa Zaremba (1):
      xsk: always clear DMA mapping information when unmapping the pool

Levi Yun (1):
      dma-debug: fix a possible deadlock on radix_lock

Liao Chen (2):
      drm/bridge: it6505: Enable module autoloading
      drm/mcde: Enable module autoloading

Liequan Che (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again

Linus Torvalds (1):
      Revert "unicode: Don't special case ignorable code points"

Louis Leseur (1):
      net/qed: allow old cards not supporting "num_images" to work

Luca Stefani (1):
      btrfs: add cancellation points to trim loops

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet

Maciej Fijalkowski (2):
      bpf: fix OOB devmap writes when deleting elements
      xsk: fix OOB map writes when deleting elements

Manikandan Muralidharan (1):
      drm/panel: simple: Add Microchip AC69T88A LVDS Display panel

Marc Kleine-Budde (3):
      can: gs_usb: add VID/PID for Xylanta SAINT3 product family
      can: dev: can_set_termination(): allow sleeping GPIOs
      can: mcp251xfd: mcp251xfd_get_tef_len(): work around erratum DS80000789E 6.

Marcelo Dalmas (1):
      ntp: Remove invalid cast in time offset math

Marco Elver (1):
      kcsan: Turn report_filterlist_lock into a raw_spinlock

Marek Vasut (1):
      soc: imx8m: Probe the SoC driver as platform driver

Marie Ramlow (1):
      ALSA: usb-audio: add mixer mapping for Corsair HS80

Mark Brown (2):
      kselftest/arm64: Log fp-stress child startup errors to stdout
      kselftest/arm64: Don't leak pipe fds in pac.exec_sign_all()

Mark Rutland (1):
      arm64: ptrace: fix partial SETREGSET for NT_ARM_TAGGED_ADDR_CTRL

Martin Ottens (1):
      net/sched: tbf: correct backlog statistic for GSO packets

Masami Hiramatsu (Google) (1):
      tracing/eprobe: Fix to release eprobe when failed to add dyn_event

Mathias Nyman (2):
      xhci: remove XHCI_TRUST_TX_LENGTH quirk
      xhci: dbc: Fix STALL transfer event handling

Mathieu Desnoyers (1):
      tracing/ftrace: disable preemption in syscall probe

Maximilian Heyne (1):
      selftests: hid: fix typo and exit code

Maíra Canal (1):
      drm/v3d: Enable Performance Counters before clearing them

Mengyuan Lou (1):
      PCI: Add ACS quirk for Wangxun FF5xxx NICs

Michael Ellerman (1):
      powerpc/prom_init: Fixup missing powermac #size-cells

Michael Grzeschik (1):
      usb: dwc3: ep0: Don't reset resource alloc flag (including ep0)

Michal Luczaj (2):
      bpf, vsock: Fix poll() missing a queue
      bpf, vsock: Invoke proto::close on close()

Mohamed Ghanmi (1):
      platform/x86: asus-wmi: add support for vivobook fan profiles

Mukesh Ojha (2):
      pinmux: Use sequential access to access desc->pinmux data
      leds: class: Protect brightness_show() with led_cdev->led_access mutex

Nathan Chancellor (1):
      powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable mute and micmute LED on HP ProBook 430 G8

Nick Chan (1):
      watchdog: apple: Actually flush writes after requesting watchdog restart

Nihar Chaithanya (1):
      jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree

Nikolay Kuratov (1):
      KVM: x86/mmu: Ensure that kvm_release_pfn_clean() takes exact pfn from kvm_faultin_pfn()

Nirmal Patel (1):
      PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKUs

Norbert van Bolhuis (1):
      wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()

Nícolas F. R. A. Prado (1):
      ASoC: mediatek: mt8188-mt6359: Remove hardcoded dmic codec

Oleksandr Ocheretnyi (1):
      iTCO_wdt: mask NMI_NOW bit for update_no_reboot_bit() call

Oliver Upton (1):
      KVM: arm64: Don't retire aborted MMIO instruction

Pablo Neira Ayuso (3):
      netfilter: nft_socket: remove WARN_ON_ONCE on maximum cgroup level
      netfilter: nft_inner: incorrect percpu area handling under softirq
      netfilter: nft_set_hash: skip duplicated elements pending gc run

Parker Newman (1):
      misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle

Paulo Alcantara (1):
      smb: client: don't try following DFS links in cifs_tree_connect()

Pei Xiao (2):
      drm/sti: Add __iomem for mixer_dbg_mxn's parameter
      spi: mpc52xx: Add cancel_work_sync before module remove

Peng Fan (1):
      mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED

Peter Wang (1):
      scsi: ufs: core: Add missing post notify for power mode change

Peter Zijlstra (5):
      sched: Unify runtime accounting across classes
      sched: Remove vruntime from trace_sched_stat_runtime()
      sched: Unify more update_curr*()
      sched/deadline: Collect sched_dl_entity initialization
      sched/deadline: Move bandwidth accounting into {en,de}queue_dl_entity

Phil Sutter (1):
      netfilter: ipset: Hold module reference while requesting a module

Philipp Stanner (1):
      drm/sched: memset() 'job' in drm_sched_job_init()

Ping-Ke Shih (1):
      wifi: rtw89: check return value of ieee80211_probereq_get() for RNR

Pratyush Brahma (1):
      iommu/arm-smmu: Defer probe of clients after smmu device bound

Prike Liang (2):
      drm/amdgpu: Dereference the ATCS ACPI buffer
      drm/amdgpu: set the right AMDGPU sg segment limitation

Qi Han (1):
      f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.

Qianqiang Liu (1):
      KMSAN: uninit-value in inode_go_dump (5)

Qu Wenruo (1):
      btrfs: avoid unnecessary device path update for the same device

Quinn Tran (3):
      scsi: qla2xxx: Fix abort in bsg timeout
      scsi: qla2xxx: Fix NVMe and NPIV connect issue
      scsi: qla2xxx: Fix use after free on unload

Raghavendra K T (1):
      sched/numa: Fix mm numa_scan_seq based unconditional scan

Ralph Boehme (3):
      fs/smb/client: avoid querying SMB2_OP_QUERY_WSL_EA for SMB3 POSIX
      fs/smb/client: Implement new SMB3 POSIX type
      fs/smb/client: cifs_prime_dcache() for SMB3 POSIX reparse points

Randy Dunlap (1):
      scatterlist: fix incorrect func name in kernel-doc

Rasmus Villemoes (1):
      setlocalversion: work around "git describe" performance

Reinette Chatre (1):
      selftests/resctrl: Protect against array overflow when reading strings

Ricardo Neri (1):
      cacheinfo: Allocate memory during CPU hotplug if not done from the primary CPU

Richard Weinberger (1):
      jffs2: Fix rtime decompressor

Rohan Barar (1):
      media: cx231xx: Add support for Dexatek USB Video Grabber 1d19:6108

Roman Gushchin (1):
      mm: page_alloc: move mlocked flag clearance into free_pages_prepare()

Rosen Penev (4):
      mmc: mtk-sd: use devm_mmc_alloc_host
      mmc: mtk-sd: fix devm_clk_get_optional usage
      wifi: ath5k: add PCI ID for SX76X
      wifi: ath5k: add PCI ID for Arcadyan devices

Ryusuke Konishi (1):
      nilfs2: fix potential out-of-bounds memory access in nilfs_find_entry()

Sahas Leelodharry (1):
      ALSA: hda/realtek: Add support for Samsung Galaxy Book3 360 (NP730QFG)

Sarah Maedel (1):
      hwmon: (nct6775) Add 665-ACE/600M-CL to ASUS WMI monitoring list

Saravana Kannan (3):
      driver core: fw_devlink: Improve logs for cycle detection
      driver core: Add FWLINK_FLAG_IGNORE to completely ignore a fwnode link
      driver core: fw_devlink: Stop trying to optimize cycle detection logic

Saurav Kashyap (1):
      scsi: qla2xxx: Remove check req_sg_cnt should be equal to rsp_sg_cnt

Sean Christopherson (1):
      x86/CPU/AMD: WARN when setting EFER.AUTOIBRS if and only if the WRMSR fails

Sergey Senozhatsky (3):
      zram: split memory-tracking and ac-time tracking
      zram: do not mark idle slots that cannot be idle
      zram: clear IDLE flag in mark_idle()

Shengyu Qu (1):
      net: sfp: change quirks for Alcatel Lucent G-010S-P

Simon Horman (2):
      net: fec_mpc52xx_phy: Use %pa to format resource_size_t
      net: ethernet: fs_enet: Use %pa to format resource_size_t

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Adjust type of scldiv

Steve French (1):
      smb3.1.1: fix posix mounts to older servers

Suraj Sonawane (1):
      scsi: sg: Fix slab-use-after-free read in sg_release()

Takashi Iwai (9):
      ALSA: seq: ump: Use automatic cleanup of kfree()
      ALSA: ump: Update substream name from assigned FB names
      ALSA: seq: ump: Fix seq port updates per FB info notify
      ALSA: usb-audio: Notify xrun for low-latency mode
      ALSA: hda: Use own quirk lookup helper
      ALSA: hda/conexant: Use the new codec SSID matching
      ALSA: usb-audio: Make mic volume workarounds globally applicable
      ALSA: hda: Fix build error without CONFIG_SND_DEBUG
      ALSA: usb-audio: Update UMP group attributes for GTB blocks, too

Tao Lyu (1):
      bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots

Tetsuo Handa (1):
      ocfs2: free inode when ocfs2_get_init_inode() fails

Thinh Nguyen (3):
      usb: dwc3: gadget: Rewrite endpoint allocation flow
      usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED
      usb: dwc3: ep0: Don't reset resource alloc flag

Thomas Gleixner (2):
      serial: amba-pl011: Use port lock wrappers
      modpost: Add .irqentry.text to OTHER_SECTIONS

Thomas Richter (1):
      s390/cpum_sf: Handle CPU hotplug remove during sampling

Tomas Glozar (1):
      rtla/timerlat: Make timerlat_top_cpu->*_count unsigned long long

Tvrtko Ursulin (2):
      dma-fence: Fix reference leak on fence merge failure path
      dma-fence: Use kernel's sort for merging fences

Ulf Hansson (1):
      mmc: core: Further prevent card detect during shutdown

Uros Bizjak (1):
      tracing: Use atomic64_inc_return() in trace_clock_counter()

Uwe Kleine-König (2):
      soc/fsl: cpm: qmc: Convert to platform remove callback returning void
      ASoC: amd: yc: Add quirk for microphone on Lenovo Thinkpad T14s Gen 6 21M1CTO1WW

Vadim Fedorenko (1):
      net-timestamp: make sk_tskey more predictable in error path

Victor Lu (1):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for vega20_ih

Victor Zhao (1):
      drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov

Wander Lairson Costa (1):
      sched/deadline: Fix warning in migrate_enable for boosted tasks

WangYuli (1):
      HID: wacom: fix when get product name maybe null pointer

Wei Fang (1):
      net: enetc: Do not configure preemptible TCs if SIs do not support

Wen Gu (11):
      net/smc: rename some 'fce' to 'fce_v2x' for clarity
      net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
      net/smc: unify the structs of accept or confirm message for v1 and v2
      net/smc: define a reserved CHID range for virtual ISM devices
      net/smc: compatible with 128-bits extended GID of virtual ISM device
      net/smc: mark optional smcd_ops and check for support when called
      net/smc: add operations to merge sndbuf with peer DMB
      net/smc: {at|de}tach sndbuf to peer DMB if supported
      net/smc: initialize close_work early to avoid warning
      net/smc: fix LGR and link use-after-free issue
      net/smc: fix incorrect SMC-D link group matching logic

Wengang Wang (1):
      ocfs2: update seq_file index in ocfs2_dlm_seq_next

Xi Ruoyao (1):
      MIPS: Loongson64: DTS: Really fix PCIe port nodes for ls7a

Xiang Liu (1):
      drm/amdgpu/vcn: reset fw_shared when VCPU buffers corrupted on vcn v4.0.3

Xin Long (1):
      net: sched: fix erspan_opt settings in cls_flower

Xu Yang (1):
      usb: chipidea: udc: handle USB Error Interrupt if IOC not set

Xuan Zhuo (1):
      virtio-net: fix overflow inside virtnet_rq_alloc

Yassine Oudjana (1):
      watchdog: mediatek: Make sure system reset gets asserted in mtk_wdt_restart()

Yi Yang (1):
      nvdimm: rectify the illogical code within nd_dax_probe()

Yihang Li (1):
      scsi: hisi_sas: Add cond_resched() for no forced preemption model

Yishai Hadas (1):
      vfio/mlx5: Align the page tracking max message size with the device capability

Yuan Can (1):
      igb: Fix potential invalid memory access in igb_init_module()

Zheng Yejian (1):
      mm/damon/vaddr: fix issue in damon_va_evenly_split_region()

Zhu Jun (1):
      samples/bpf: Fix a resource leak

Zijian Zhang (1):
      tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg

Ziqi Chen (1):
      scsi: ufs: core: Add ufshcd_send_bsg_uic_cmd() for UFS BSG

devi priya (1):
      PCI: qcom: Add support for IPQ9574


