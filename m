Return-Path: <stable+bounces-55960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06C691A616
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24686B28AA3
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431C15217A;
	Thu, 27 Jun 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n6vV1wFb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79A1514DD;
	Thu, 27 Jun 2024 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489736; cv=none; b=J0dCUauA+LvZgYzAtunlmEPXLiSIiN8X/1RBn1d+KN8JZHbK46J51ah8lYLDxqkSjDVGPgskyIXNO1lwTmZa+2HKMAghBzGoWAbttIJyYkBRvltW2pRxPR3Tpovtu3uZh3dx3qkAVhMf90uCwBqYIVOgLknrs6i7dqM8M7OmEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489736; c=relaxed/simple;
	bh=GK/INzWNM+MwA9HHGyic16msjJye7oWULvgU3TcA4jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tOGmf7UaEPiDwTJDbNh9/44fClg6si8rGqiWBx+LVKWqSJiQH0dcnPs8MNU96A5i7fGg1WRHf+HIRtiDdSSlJyNPcCcM3Z5p9MEUNn5qE4KwaIo19vg1aEfke6OenF2Ov1z3XiNxaxTyeU3EU4ab2oJRXIJlNGfu+G5MgGrVDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n6vV1wFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E378C32786;
	Thu, 27 Jun 2024 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719489736;
	bh=GK/INzWNM+MwA9HHGyic16msjJye7oWULvgU3TcA4jw=;
	h=From:To:Cc:Subject:Date:From;
	b=n6vV1wFb/8HW/MkiAaxROzjimGu0E5A/+xHmXQxUyRXuSXxmsxmOSGdTLbKRVY5Wz
	 sJh4QGD5TYqv022x7m7Ivm6k38z7Ay+XWzP7av6QzeHqoDCBsVb4YT23ofLJ0kVUd+
	 CF2G4iE7qWtXTgA3fVFopseRwsWu9punwl8LEaV8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.9.7
Date: Thu, 27 Jun 2024 14:01:57 +0200
Message-ID: <2024062757-armband-happiest-339b@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.9.7 kernel.

All users of the 6.9 kernel series must upgrade.

The updated 6.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.9.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/dma/fsl,edma.yaml                  |    4 
 Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml         |    2 
 Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml |    2 
 Makefile                                                             |    2 
 arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi                      |    2 
 arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso                        |    6 
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi                     |    3 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi                  |    2 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi              |    2 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                         |    2 
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts                    |    1 
 arch/arm64/configs/defconfig                                         |    1 
 arch/arm64/include/asm/sysreg.h                                      |   24 -
 arch/arm64/kvm/vgic/vgic-init.c                                      |    2 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                   |   15 
 arch/arm64/kvm/vgic/vgic.h                                           |    2 
 arch/csky/kernel/probes/ftrace.c                                     |    3 
 arch/loongarch/Kconfig                                               |    5 
 arch/loongarch/Kconfig.debug                                         |    1 
 arch/loongarch/include/asm/hw_breakpoint.h                           |    4 
 arch/loongarch/kernel/ftrace_dyn.c                                   |    3 
 arch/loongarch/kernel/hw_breakpoint.c                                |   96 ++--
 arch/loongarch/kernel/ptrace.c                                       |   47 +-
 arch/mips/bmips/setup.c                                              |    3 
 arch/mips/include/asm/mipsmtregs.h                                   |    2 
 arch/mips/pci/ops-rc32434.c                                          |    4 
 arch/mips/pci/pcie-octeon.c                                          |    6 
 arch/parisc/kernel/ftrace.c                                          |    3 
 arch/powerpc/crypto/.gitignore                                       |    2 
 arch/powerpc/include/asm/hvcall.h                                    |    8 
 arch/powerpc/include/asm/io.h                                        |   24 -
 arch/powerpc/kernel/kprobes-ftrace.c                                 |    3 
 arch/riscv/kernel/probes/ftrace.c                                    |    3 
 arch/s390/kernel/ftrace.c                                            |    3 
 arch/x86/include/asm/cpu_device_id.h                                 |   98 ++++
 arch/x86/include/asm/efi.h                                           |    1 
 arch/x86/kernel/cpu/match.c                                          |    4 
 arch/x86/kernel/cpu/resctrl/monitor.c                                |    3 
 arch/x86/kernel/kprobes/ftrace.c                                     |    3 
 arch/x86/kvm/x86.c                                                   |    9 
 arch/x86/platform/efi/memmap.c                                       |   12 
 block/ioctl.c                                                        |    2 
 drivers/acpi/acpica/acevents.h                                       |    4 
 drivers/acpi/acpica/evregion.c                                       |    6 
 drivers/acpi/acpica/evxfregn.c                                       |   54 ++
 drivers/acpi/acpica/exregion.c                                       |   23 -
 drivers/acpi/ec.c                                                    |   28 -
 drivers/acpi/internal.h                                              |    5 
 drivers/acpi/mipi-disco-img.c                                        |   28 -
 drivers/acpi/resource.c                                              |   13 
 drivers/acpi/video_detect.c                                          |    8 
 drivers/acpi/x86/utils.c                                             |   20 
 drivers/ata/ahci.c                                                   |    8 
 drivers/block/nbd.c                                                  |   34 -
 drivers/bluetooth/ath3k.c                                            |   25 -
 drivers/cpufreq/amd-pstate.c                                         |    7 
 drivers/crypto/hisilicon/qm.c                                        |    5 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                           |    4 
 drivers/cxl/core/pci.c                                               |   29 +
 drivers/cxl/cxl.h                                                    |    2 
 drivers/cxl/pci.c                                                    |   22 +
 drivers/dma/Kconfig                                                  |    2 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                       |    6 
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h                                |    1 
 drivers/dma/idxd/irq.c                                               |    4 
 drivers/dma/ioat/init.c                                              |   55 +-
 drivers/dma/ti/k3-udma-glue.c                                        |    5 
 drivers/dma/xilinx/xdma.c                                            |    4 
 drivers/firmware/efi/memmap.c                                        |    9 
 drivers/firmware/psci/psci.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                              |   66 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                    |    3 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                         |   23 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c              |   72 +++
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h              |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c               |    2 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c                           |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                              |    4 
 drivers/gpu/drm/lima/lima_bcast.c                                    |   12 
 drivers/gpu/drm/lima/lima_bcast.h                                    |    3 
 drivers/gpu/drm/lima/lima_gp.c                                       |    8 
 drivers/gpu/drm/lima/lima_pp.c                                       |   18 
 drivers/gpu/drm/lima/lima_sched.c                                    |    9 
 drivers/gpu/drm/lima/lima_sched.h                                    |    1 
 drivers/gpu/drm/radeon/sumo_dpm.c                                    |    2 
 drivers/gpu/drm/xe/xe_guc.c                                          |    4 
 drivers/hid/hid-asus.c                                               |   51 +-
 drivers/hid/hid-ids.h                                                |    1 
 drivers/hid/hid-multitouch.c                                         |    6 
 drivers/i2c/busses/i2c-imx-lpi2c.c                                   |   19 
 drivers/i2c/busses/i2c-ocores.c                                      |    2 
 drivers/infiniband/hw/bnxt_re/bnxt_re.h                              |    4 
 drivers/infiniband/hw/mana/mr.c                                      |    1 
 drivers/infiniband/hw/mlx5/main.c                                    |    4 
 drivers/infiniband/hw/mlx5/mr.c                                      |    8 
 drivers/infiniband/hw/mlx5/srq.c                                     |   13 
 drivers/infiniband/sw/rxe/rxe_resp.c                                 |   13 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                |    2 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                          |    2 
 drivers/media/pci/intel/ipu-bridge.c                                 |   66 ++-
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c    |    2 
 drivers/net/dsa/realtek/rtl8366rb.c                                  |   87 ----
 drivers/net/dsa/realtek/rtl83xx.c                                    |    7 
 drivers/net/ethernet/amazon/ena/ena_eth_com.c                        |   37 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c                         |    2 
 drivers/net/ethernet/amazon/ena/ena_regs_defs.h                      |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                            |    5 
 drivers/net/ethernet/intel/ice/ice_ddp.c                             |   23 -
 drivers/net/ethernet/intel/ice/ice_main.c                            |   10 
 drivers/net/ethernet/intel/ice/ice_switch.c                          |    6 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                      |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/Makefile                  |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c              |    7 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c            |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c               |    5 
 drivers/net/ethernet/microchip/lan743x_ethtool.c                     |   44 +-
 drivers/net/ethernet/microchip/lan743x_main.c                        |   48 +-
 drivers/net/ethernet/microchip/lan743x_main.h                        |   28 +
 drivers/net/ethernet/qualcomm/qca_debug.c                            |    6 
 drivers/net/ethernet/qualcomm/qca_spi.c                              |   16 
 drivers/net/ethernet/qualcomm/qca_spi.h                              |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c                |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                      |   40 +
 drivers/net/phy/dp83tg720.c                                          |   38 +
 drivers/net/phy/mxl-gpy.c                                            |   58 +-
 drivers/net/phy/sfp.c                                                |   21 
 drivers/net/usb/ax88179_178a.c                                       |   18 
 drivers/net/usb/rtl8150.c                                            |    3 
 drivers/net/virtio_net.c                                             |   32 +
 drivers/net/wireless/ath/ath.h                                       |    6 
 drivers/net/wireless/ath/ath12k/core.c                               |    1 
 drivers/net/wireless/ath/ath12k/mac.c                                |   16 
 drivers/net/wireless/ath/ath12k/qmi.c                                |   61 +-
 drivers/net/wireless/ath/ath12k/qmi.h                                |    2 
 drivers/net/wireless/ath/ath9k/main.c                                |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                    |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                      |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c                 |    2 
 drivers/net/wireless/mediatek/mt76/sdio.c                            |    3 
 drivers/net/wireless/realtek/rtw89/core.c                            |   18 
 drivers/net/wireless/realtek/rtw89/core.h                            |   10 
 drivers/net/wireless/realtek/rtw89/pci.c                             |   19 
 drivers/net/wireless/realtek/rtw89/pci.h                             |    5 
 drivers/net/wireless/realtek/rtw89/rtw8851be.c                       |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c                       |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852be.c                       |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c                       |   23 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c                       |    1 
 drivers/opp/core.c                                                   |   31 +
 drivers/pci/pci.c                                                    |   17 
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c                            |  189 +++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6-n4.h                        |   32 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h               |   13 
 drivers/phy/qualcomm/phy-qcom-qmp.h                                  |    2 
 drivers/platform/chrome/cros_usbpd_logger.c                          |    9 
 drivers/platform/chrome/cros_usbpd_notify.c                          |    9 
 drivers/platform/x86/p2sb.c                                          |   29 -
 drivers/platform/x86/toshiba_acpi.c                                  |   36 +
 drivers/platform/x86/x86-android-tablets/core.c                      |    8 
 drivers/platform/x86/x86-android-tablets/dmi.c                       |   18 
 drivers/platform/x86/x86-android-tablets/lenovo.c                    |  216 ++++++++++
 drivers/platform/x86/x86-android-tablets/x86-android-tablets.h       |    1 
 drivers/pmdomain/core.c                                              |   10 
 drivers/power/supply/cros_usbpd-charger.c                            |   11 
 drivers/ptp/ptp_sysfs.c                                              |    3 
 drivers/regulator/bd71815-regulator.c                                |    2 
 drivers/regulator/core.c                                             |    1 
 drivers/scsi/qedi/qedi_debugfs.c                                     |   12 
 drivers/scsi/sd.c                                                    |    4 
 drivers/spi/spi-cs42l43.c                                            |    2 
 drivers/spi/spi-imx.c                                                |   14 
 drivers/spi/spi-stm32-qspi.c                                         |   12 
 drivers/spi/spi.c                                                    |   10 
 drivers/ssb/main.c                                                   |    4 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c |    3 
 drivers/thermal/mediatek/lvts_thermal.c                              |    6 
 drivers/thermal/thermal_core.c                                       |    6 
 drivers/tty/serial/8250/8250_dw.c                                    |   27 +
 drivers/tty/serial/8250/8250_dwlib.h                                 |   32 -
 drivers/tty/serial/8250/8250_exar.c                                  |   42 +
 drivers/tty/serial/imx.c                                             |    7 
 drivers/tty/tty_ldisc.c                                              |    6 
 drivers/tty/vt/vt.c                                                  |   10 
 drivers/ufs/core/ufshcd.c                                            |    1 
 drivers/usb/dwc3/dwc3-pci.c                                          |    8 
 drivers/usb/gadget/function/f_hid.c                                  |    6 
 drivers/usb/gadget/function/f_printer.c                              |    6 
 drivers/usb/gadget/function/rndis.c                                  |    4 
 drivers/usb/gadget/function/uvc_configfs.c                           |   14 
 drivers/usb/host/xhci-pci.c                                          |   15 
 drivers/usb/host/xhci-rcar.c                                         |    6 
 drivers/usb/host/xhci-ring.c                                         |   15 
 drivers/usb/host/xhci.h                                              |    4 
 drivers/usb/misc/uss720.c                                            |   20 
 drivers/usb/storage/scsiglue.c                                       |    6 
 drivers/usb/storage/uas.c                                            |    7 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c                        |   10 
 drivers/usb/typec/ucsi/ucsi_glink.c                                  |   22 -
 drivers/vfio/pci/vfio_pci_core.c                                     |   78 ++-
 fs/btrfs/bio.c                                                       |    4 
 fs/btrfs/block-group.c                                               |   11 
 fs/ext4/mballoc.c                                                    |    4 
 fs/ext4/super.c                                                      |   22 -
 fs/ext4/sysfs.c                                                      |   24 -
 fs/ext4/xattr.c                                                      |  113 ++---
 fs/f2fs/node.c                                                       |   12 
 fs/f2fs/super.c                                                      |   12 
 fs/fs-writeback.c                                                    |    7 
 fs/ocfs2/journal.c                                                   |  192 ++++----
 fs/ocfs2/ocfs2.h                                                     |   27 +
 fs/ocfs2/super.c                                                     |    4 
 fs/overlayfs/export.c                                                |    6 
 fs/smb/client/cifsfs.c                                               |    2 
 fs/udf/udftime.c                                                     |   11 
 include/acpi/acpixf.h                                                |    4 
 include/linux/bpf_verifier.h                                         |    2 
 include/linux/cpuset.h                                               |    3 
 include/linux/kcov.h                                                 |    2 
 include/linux/kprobes.h                                              |    7 
 include/linux/lsm_hook_defs.h                                        |    2 
 include/linux/mod_devicetable.h                                      |    2 
 include/linux/pagemap.h                                              |    4 
 include/linux/pci.h                                                  |    7 
 include/linux/pm_domain.h                                            |    6 
 include/linux/security.h                                             |    5 
 include/linux/tty_driver.h                                           |    8 
 include/net/netns/netfilter.h                                        |    3 
 include/net/sch_generic.h                                            |    1 
 include/scsi/scsi_devinfo.h                                          |    4 
 io_uring/rsrc.c                                                      |    1 
 io_uring/sqpoll.c                                                    |    8 
 kernel/auditfilter.c                                                 |    5 
 kernel/bpf/lpm_trie.c                                                |   13 
 kernel/bpf/verifier.c                                                |   14 
 kernel/cgroup/cpuset.c                                               |  141 ++----
 kernel/cpu.c                                                         |   48 --
 kernel/gcov/gcc_4_7.c                                                |    4 
 kernel/kcov.c                                                        |    1 
 kernel/kprobes.c                                                     |    6 
 kernel/padata.c                                                      |    8 
 kernel/power/process.c                                               |    2 
 kernel/rcu/rcutorture.c                                              |   16 
 kernel/time/clocksource.c                                            |   42 -
 kernel/trace/Kconfig                                                 |    4 
 kernel/trace/ftrace.c                                                |    1 
 kernel/trace/preemptirq_delay_test.c                                 |    1 
 lib/ubsan.h                                                          |   41 +
 mm/huge_memory.c                                                     |   28 -
 mm/memcontrol.c                                                      |    3 
 mm/page_table_check.c                                                |   11 
 mm/shmem.c                                                           |    2 
 net/batman-adv/originator.c                                          |    2 
 net/core/drop_monitor.c                                              |   20 
 net/core/filter.c                                                    |    5 
 net/core/net_namespace.c                                             |    9 
 net/core/netdev-genl.c                                               |   16 
 net/core/netpoll.c                                                   |    2 
 net/core/sock.c                                                      |    3 
 net/devlink/core.c                                                   |    6 
 net/ipv4/cipso_ipv4.c                                                |   12 
 net/ipv4/tcp_ao.c                                                    |    6 
 net/ipv4/tcp_input.c                                                 |    1 
 net/ipv6/route.c                                                     |    4 
 net/ipv6/seg6_local.c                                                |    8 
 net/ipv6/xfrm6_policy.c                                              |    8 
 net/mac80211/driver-ops.c                                            |   17 
 net/mac80211/iface.c                                                 |   22 -
 net/mac80211/util.c                                                  |    2 
 net/netfilter/core.c                                                 |   13 
 net/netfilter/ipset/ip_set_core.c                                    |   11 
 net/netfilter/nf_conntrack_standalone.c                              |   15 
 net/netfilter/nf_hooks_lwtunnel.c                                    |   67 +++
 net/netfilter/nf_internals.h                                         |    6 
 net/netrom/nr_timer.c                                                |    3 
 net/packet/af_packet.c                                               |   26 -
 net/sched/act_api.c                                                  |    3 
 net/sched/act_ct.c                                                   |   16 
 net/sched/sch_api.c                                                  |    1 
 net/sched/sch_generic.c                                              |    4 
 net/sched/sch_htb.c                                                  |   22 -
 net/tipc/node.c                                                      |    1 
 security/apparmor/audit.c                                            |    6 
 security/apparmor/include/audit.h                                    |    2 
 security/integrity/ima/ima.h                                         |    2 
 security/integrity/ima/ima_policy.c                                  |   15 
 security/security.c                                                  |    6 
 security/selinux/include/audit.h                                     |    4 
 security/selinux/ss/services.c                                       |    5 
 security/smack/smack_lsm.c                                           |    4 
 sound/core/seq/seq_ump_convert.c                                     |    2 
 sound/hda/intel-dsp-config.c                                         |    2 
 sound/pci/hda/cs35l41_hda.c                                          |    6 
 sound/pci/hda/cs35l56_hda.c                                          |    4 
 sound/pci/hda/patch_realtek.c                                        |   15 
 sound/pci/hda/tas2781_hda_i2c.c                                      |    4 
 sound/soc/intel/boards/sof_sdw.c                                     |   18 
 tools/arch/arm64/include/asm/sysreg.h                                |   24 -
 tools/testing/selftests/arm64/tags/tags_test.c                       |    4 
 tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c              |   26 -
 tools/testing/selftests/bpf/progs/verifier_global_subprogs.c         |    7 
 tools/testing/selftests/bpf/test_tc_tunnel.sh                        |   13 
 tools/testing/selftests/net/cmsg_sender.c                            |   20 
 tools/testing/selftests/net/mptcp/userspace_pm.sh                    |   46 +-
 tools/testing/selftests/net/openvswitch/openvswitch.sh               |    2 
 virt/kvm/guest_memfd.c                                               |    5 
 virt/kvm/kvm_main.c                                                  |    5 
 307 files changed, 3153 insertions(+), 1396 deletions(-)

Abel Vesa (3):
      phy: qcom-qmp: qserdes-txrx: Add missing registers offsets
      phy: qcom-qmp: pcs: Add missing v6 N4 register offsets
      phy: qcom: qmp-combo: Switch from V6 to V6 N4 register offsets

Adrian Hunter (1):
      clocksource: Make watchdog and suspend-timing multiplication overflow safe

Ajrat Makhmutov (1):
      ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM

Aleksandr Aprelkov (1):
      iommu/arm-smmu-v3: Free MSIs in case of ENOMEM

Aleksandr Nogikh (1):
      kcov: don't lose track of remote references during softirqs

Alessandro Carminati (Red Hat) (1):
      selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh

Alex Deucher (2):
      drm/radeon: fix UBSAN warning in kv_dpm.c
      drm/amdgpu: fix UBSAN warning in kv_dpm.c

Alex Henrie (1):
      usb: misc: uss720: check for incompatible versions of the Belkin F5U002

Alex Williamson (1):
      vfio/pci: Collect hot-reset devices to local buffer

Alexander Stein (1):
      i2c: lpi2c: Avoid calling clk_get_rate during transfer

Alexei Starovoitov (1):
      bpf: Avoid kfree_rcu() under lock in bpf_lpm_trie.

Amit Kumar Mahapatra (1):
      spi: Fix SPI slave probe failure

Andrew Ballance (1):
      hid: asus: asus_report_fixup: fix potential read out of bounds

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 445/465 G11.

Andy Shevchenko (1):
      serial: 8250_dw: Revert "Move definitions to the shared header"

Ard Biesheuvel (1):
      efi/x86: Free EFI memory map only when installing a new one.

Arnd Bergmann (2):
      wifi: ath9k: work around memset overflow warning
      dmaengine: fsl-edma: avoid linking both modules

Arvid Norlander (1):
      platform/x86: toshiba_acpi: Add quirk for buttons on Z830

Aryan Srivastava (1):
      net: mvpp2: use slab_build_skb for oversized frames

Baochen Qiang (2):
      wifi: ath12k: fix kernel crash during resume
      wifi: ath12k: check M3 buffer size as well whey trying to reuse it

Baokun Li (3):
      ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
      ext4: avoid overflow when setting values via sysfs
      ext4: fix slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists()

Baolin Wang (1):
      mm: shmem: fix getting incorrect lruvec when replacing a shmem folio

Bart Van Assche (4):
      scsi: core: Introduce the BLIST_SKIP_IO_HINTS flag
      scsi: usb: uas: Do not query the IO Advice Hints Grouping mode page for USB/UAS devices
      nbd: Improve the documentation of the locking assumptions
      nbd: Fix signal handling

Ben Fradella (1):
      platform/x86: p2sb: Don't init until unassigned resources have been assigned

Biju Das (1):
      regulator: core: Fix modpost error "regulator_get_regmap" undefined

Boris Burkov (1):
      btrfs: retry block group reclaim without infinite loop

Breno Leitao (2):
      netpoll: Fix race condition in netpoll_owner_active
      KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()

Chao Yu (1):
      f2fs: fix to detect inconsistent nat entry during truncation

Charles Keepax (1):
      spi: cs42l43: Correct SPI root clock speed

Chenghai Huang (2):
      crypto: hisilicon/sec - Fix memory leak for sec resource release
      crypto: hisilicon/qm - Add the err memory release process to qm uninit

Chenliang Li (1):
      io_uring/rsrc: fix incorrect assignment of iter->nr_segs in io_import_fixed

Christian Marangi (1):
      mips: bmips: BCM6358: make sure CBR is correctly set

Christophe JAILLET (1):
      usb: gadget: function: Remove usage of the deprecated ida_simple_xx() API

Dan Carpenter (1):
      ptp: fix integer overflow in max_vclocks_store

Daniel Borkmann (1):
      bpf: Fix reg_set_min_max corruption of fake_reg

Daniel Golle (1):
      net: sfp: add quirk for ATS SFP-GE-T 1000Base-TX module

Dave Jiang (1):
      cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders

Dave Martin (1):
      x86/resctrl: Don't try to free nonexistent RMIDs

David Arinzon (1):
      net: ena: Add validation for completion descriptors consistency

David Ruth (1):
      net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()

Davide Caratti (2):
      net/sched: fix false lockdep warning on qdisc root lock
      net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc error path

Dmitry Baryshkov (4):
      arm64: defconfig: select INTERCONNECT_QCOM_SM6115 as built-in
      usb: typec: ucsi_glink: rework quirks implementation
      usb: typec: ucsi_glink: drop special handling for CCI_BUSY
      usb: typec: qcom-pmic-typec: split HPD bridge alloc and registration

Dmitry Safonov (1):
      net/tcp_ao: Don't leak ao_info on error-path

Dustin L. Howett (1):
      ALSA: hda/realtek: Remove Framework Laptop 16 from quirks

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on N14AP7

En-Wei Wu (1):
      ice: avoid IRQ collision to fix init failure on ACPI S3 resume

Eric Dumazet (6):
      batman-adv: bypass empty buckets in batadv_purge_orig_ref()
      af_packet: avoid a false positive warning in packet_setsockopt()
      ipv6: prevent possible NULL deref in fib6_nh_init()
      ipv6: prevent possible NULL dereference in rt6_probe()
      xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()
      tcp: clear tp->retrans_stamp in tcp_rcv_fastopen_synack()

Erico Nunes (3):
      drm/lima: add mask irq callback to gp and pp
      drm/lima: include pp bcast irq in timeout handler check
      drm/lima: mask irqs in timeout path before hard reset

Esben Haabendal (1):
      serial: imx: Introduce timeout when waiting on transmitter empty

Fabio Estevam (1):
      arm64: dts: imx93-11x11-evk: Remove the 'no-sdio' property

Florian Westphal (1):
      bpf: Avoid splat in pskb_pull_reason

Frank Li (1):
      arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc

Fullway Wang (1):
      media: mtk-vcodec: potential null pointer deference in SCP

GUO Zihua (1):
      ima: Avoid blocking in RCU read-side critical section

Gavrilov Ilia (1):
      netrom: Fix a memory leak in nr_heartbeat_expiry()

Geetha sowjanya (1):
      octeontx2-pf: Fix linking objects into multiple modules

Greg Kroah-Hartman (1):
      Linux 6.9.7

Grygorii Tertychnyi (1):
      i2c: ocores: set IACK bit after core is enabled

Guenter Schafranek (1):
      ACPI: resource: Do IRQ override on GMxBGxx (XMG APEX 17 M23)

Hans de Goede (5):
      ACPI: x86: Add PNP_UART1_SKIP quirk for Lenovo Blade2 tablets
      platform/x86: x86-android-tablets: Unregister devices in reverse order
      platform/x86: x86-android-tablets: Add Lenovo Yoga Tablet 2 Pro 1380F/L data
      usb: dwc3: pci: Don't set "linux,phy_charger_detect" property on Lenovo Yoga Tab2 1380
      ACPI: scan: Ignore camera graph port nodes on all Dell Tiger, Alder and Raptor Lake models

Heng Qi (2):
      virtio_net: checksum offloading handling fix
      virtio_net: fixing XDP for fully checksummed packets handling

Herbert Xu (1):
      padata: Disable BH when taking works lock on MT path

Honggang LI (2):
      RDMA/rxe: Fix responder length checking for UD request packets
      RDMA/rxe: Fix data copy for IB_SEND_INLINE

Hui Li (3):
      LoongArch: Fix watchpoint setting error
      LoongArch: Trigger user-space watchpoints correctly
      LoongArch: Fix multiple hardware watchpoint issues

Ignat Korchagin (1):
      net: do not leave a dangling sk pointer, when socket creation fails

Ilpo Järvinen (2):
      PCI: Do not wait for disconnected devices when resuming
      MIPS: Routerboard 532: Fix vendor retry check code

Jaegeuk Kim (1):
      f2fs: don't set RO when shutting down f2fs

Jakub Kicinski (2):
      selftests: net: fix timestamp not arriving in cmsg_time.sh
      netdev-genl: fix error codes when outputting XDP features

Jan Kara (1):
      ext4: do not create EA inode under buffer lock

Jani Nikula (1):
      drm/i915/mso: using joiner is not possible with eDP MSO

Jason Gunthorpe (3):
      RDMA/mlx5: Remove extra unlock on error path
      RDMA/mlx5: Follow rb_key.ats when creating new mkeys
      RDMA/mlx5: Ensure created mkeys always have a populated rb_key

Jeff Johnson (1):
      tracing: Add MODULE_DESCRIPTION() to preemptirq_delay_test

Jens Axboe (1):
      io_uring/sqpoll: work around a potential audit memory leak

Jian Wen (1):
      devlink: use kvzalloc() to allocate devlink instance resources

Jianguo Wu (2):
      seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and End.DX6 behaviors
      netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core

Jiaxun Yang (1):
      MIPS: mipsmtregs: Fix target register for MFTC0

Joao Paulo Goncalves (1):
      arm64: dts: freescale: imx8mm-verdin: Fix GPU speed

Joao Pinto (1):
      Avoid hw_desc array overrun in dw-axi-dmac

Joel Slebodnick (1):
      scsi: ufs: core: Free memory allocated for model before reinit

Johannes Berg (1):
      wifi: mac80211: fix monitor channel with chanctx emulation

Johannes Thumshirn (1):
      btrfs: zoned: allocate dummy checksums for zoned NODATASUM writes

Jose E. Marchesi (1):
      bpf: avoid uninitialized warnings in verifier_global_subprogs.c

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve reset check

Joseph Qi (2):
      ocfs2: fix NULL pointer dereference in ocfs2_journal_dirty()
      ocfs2: fix NULL pointer dereference in ocfs2_abort_trigger()

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix suspicious rcu_dereference_protected()

Julien Panis (1):
      thermal/drivers/mediatek/lvts_thermal: Return error in case of invalid efuse data

Justin Stitt (1):
      block/ioctl: prefer different overflow check

Kalle Niemi (1):
      regulator: bd71815: fix ramp values

Kees Cook (1):
      ubsan: Avoid i386 UBSAN handler crashes with Clang

Kemeng Shi (1):
      fs/writeback: bail out if there is no more inodes for IO and queued once

Konstantin Taranov (1):
      RDMA/mana_ib: Ignore optional access flags for MRs

Krzysztof Kozlowski (3):
      dt-bindings: dma: fsl-edma: fix dma-channels constraints
      dt-bindings: i2c: atmel,at91sam: correct path to i2c-controller schema
      dt-bindings: i2c: google,cros-ec-i2c-tunnel: correct path to i2c-controller schema

Kunwu Chan (1):
      kselftest: arm64: Add a null pointer check

Leon Yen (1):
      wifi: mt76: mt7921s: fix potential hung tasks during chip recovery

Li RongQing (1):
      dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list

Lingbo Kong (1):
      wifi: ath12k: fix the problem that down grade phy mode operation

Linus Torvalds (3):
      tty: add the option to have a tty reject a new ldisc
      kprobe/ftrace: fix build error due to bad function definition
      Revert "mm: mmap: allow for the maximum number of bits for randomizing mmap_base by default"

Liu Ying (1):
      arm: dts: imx53-qsb-hdmi: Disable panel instead of deleting node

Louis Chauvet (1):
      dmaengine: xilinx: xdma: Fix data synchronisation in xdma_channel_isr()

Luiz Angelo Daros de Luca (2):
      net: dsa: realtek: keep default LED state in rtl8366rb
      net: dsa: realtek: do not assert reset on remove

Luke D. Jones (1):
      HID: asus: fix more n-key report descriptors if n-key quirked

Manish Rangankar (1):
      scsi: qedi: Fix crash while reading debugfs attribute

Marc Kleine-Budde (1):
      spi: spi-imx: imx51: revert burst length calculation back to bits_per_word

Marc Zyngier (1):
      KVM: arm64: Disassociate vcpus from redistributor region on teardown

Marcin Szycik (1):
      ice: Fix VSI list rule with ICE_SW_LKUP_LAST type

Marek Behún (1):
      net: sfp: enhance quirk for Fibrestore 2.5G copper SFP module

Marek Vasut (1):
      arm64: dts: imx8mp: Fix TC9595 input clock on DH i.MX8M Plus DHCOM SoM

Mario Limonciello (1):
      PCI/PM: Avoid D3cold for HP Pavilion 17 PC/1972 PCIe Ports

Martin Leung (1):
      drm/amd/display: revert Exit idle optimizations before HDCP execution

Masami Hiramatsu (Google) (1):
      tracing: Build event generation tests only as modules

Mathias Nyman (1):
      xhci: remove XHCI_TRUST_TX_LENGTH quirk

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: userspace_pm: fixed subtest names

Max Krummenacher (1):
      arm64: dts: freescale: imx8mm-verdin: enable hysteresis on slow input pin

Michael Ellerman (1):
      powerpc/io: Avoid clang null pointer arithmetic warnings

Michael Grzeschik (1):
      usb: gadget: uvc: configfs: ensure guid to be valid before set

Michael Strauss (1):
      drm/amd/display: Attempt to avoid empty TUs when endpoint is DPIA

Michal Wajdeczko (1):
      drm/xe/vf: Don't touch GuC irq registers if using memory irqs

Miklos Szeredi (1):
      ovl: fix encoding fid for lower only root

Nathan Lynch (2):
      powerpc/pseries: Enforce hcall result buffer validity and size
      powerpc/crypto: Add generated P8 asm to .gitignore

Nicholas Kazlauskas (2):
      drm/amd/display: Exit idle optimizations before HDCP execution
      drm/amd/display: Workaround register access in idle race with cursor

Nikita Shubin (4):
      dmaengine: ioatdma: Fix leaking on version mismatch
      dmaengine: ioatdma: Fix error path in ioat3_dma_probe()
      dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
      dmaengine: ioatdma: Fix missing kmem_cache_destroy()

Niklas Cassel (1):
      ata: ahci: Do not enable LPM if no LPM states are supported by the HBA

Oleksij Rempel (3):
      net: phy: dp83tg720: wake up PHYs in managed mode
      net: stmmac: Assign configured channel value to EXTTS event
      net: phy: dp83tg720: get master/slave configuration in link down state

Oliver Neukum (1):
      net: usb: rtl8150 fix unintiatilzed variables in rtl8150_get_link_ksettings

Ondrej Mosnacek (1):
      cipso: fix total option length computation

Pablo Caño (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14AHP9

Paolo Bonzini (1):
      virt: guest_memfd: fix reference leak on hwpoisoned page

Parker Newman (1):
      serial: exar: adding missing CTI and Exar PCI ids

Patrice Chotard (2):
      spi: stm32: qspi: Fix dual flash mode sanity test in stm32_qspi_setup()
      spi: stm32: qspi: Clamp stm32_qspi_get_mode() output to CCR_BUSWIDTH_4

Patrisious Haddad (1):
      RDMA/mlx5: Add check for srq max_sge attribute

Paul E. McKenney (1):
      rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment

Paul Greenwalt (1):
      ice: fix 200G link speed message log

Pavan Chebbi (1):
      bnxt_en: Restore PTP tx_avail count in case of skb_pad() error

Peng Ma (1):
      cpufreq: amd-pstate: fix memory leak on CPU EPP exit

Peter Oberparleiter (1):
      gcov: add support for GCC 14

Peter Ujfalusi (1):
      ALSA/hda: intel-dsp-config: Document AVS as dsp_driver option

Peter Xu (1):
      mm/page_table_check: fix crash on ZONE_DEVICE

Pierre-Louis Bossart (3):
      ASoC: Intel: sof_sdw: add JD2 quirk for HP Omen 14
      ASoC: Intel: sof_sdw: add quirk for Dell SKU 0C0F
      ASoC: Intel: sof-sdw: really remove FOUR_SPEAKER quirk

Ping-Ke Shih (1):
      wifi: rtw89: 8852c: add quirk to set PCI BER for certain platforms

Rafael Aquini (1):
      mm: mmap: allow for the maximum number of bits for randomizing mmap_base by default

Rafael J. Wysocki (3):
      ACPI: EC: Install address space handler at the namespace root
      ACPI: EC: Evaluate orphan _REG under EC device
      thermal: core: Change PM notifier priority to the minimum

Raju Lakkaraju (3):
      net: lan743x: disable WOL upon resume to restore full data path operation
      net: lan743x: Support WOL at both the PHY and MAC appropriately
      net: phy: mxl-gpy: Remove interrupt mask clearing from config_init

Raju Rangoju (1):
      ACPICA: Revert "ACPICA: avoid Info: mapping multiple BARs. Your kernel is fine."

Ran Xiaokai (1):
      mm: huge_memory: fix misused mapping_large_folio_support() for anon folios

Rand Deeb (1):
      ssb: Fix potential NULL pointer dereference in ssb_device_uevent()

Remi Pommarel (1):
      wifi: mac80211: Recalc offload when monitor stop

Ricardo Ribalda (1):
      media: intel/ipu6: Fix build with !ACPI

Roman Li (1):
      drm/amd/display: Remove redundant idle optimization check

Roman Smirnov (1):
      udf: udftime: prevent overflow in udf_disk_stamp_to_time()

Sean Christopherson (1):
      KVM: x86: Always sync PIR to IRR prior to scanning I/O APIC routes

Sean O'Brien (1):
      HID: Add quirk for Logitech Casa touchpad

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the max msix vectors macro

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: fix ROC version check

Shiqi Liu (1):
      arm64/sysreg: Update PIE permission encodings

Siddharth Vadapalli (1):
      dmaengine: ti: k3-udma-glue: Fix of_k3_udma_glue_parse_chn_by_id()

Simon Horman (2):
      selftests: openvswitch: Use bash as interpreter
      octeontx2-pf: Add error handling to VLAN unoffload handling

Simon Trimmer (4):
      ALSA: hda: cs35l41: Possible null pointer dereference in cs35l41_hda_unbind()
      ALSA: hda: cs35l56: Component should be unbound before deconstruction
      ALSA: hda: cs35l41: Component should be unbound before deconstruction
      ALSA: hda: tas2781: Component should be unbound before deconstruction

Songyang Li (1):
      MIPS: Octeon: Add PCIe link status check

Srinivas Pandruvada (1):
      thermal: int340x: processor_thermal: Support shared interrupts

Stefan Binding (2):
      ALSA: hda/realtek: Add quirks for HP Omen models using CS35L41
      ALSA: hda/realtek: Add quirks for Lenovo 13X

Stefan Wahren (1):
      qca_spi: Make interrupt remembering atomic

Stephen Brennan (1):
      kprobe/ftrace: bail out if ftrace was killed

Steve French (1):
      cifs: fix typo in module parameter enable_gcm_256

Sudeep Holla (1):
      firmware: psci: Fix return value from psci_system_suspend()

Takashi Iwai (2):
      ACPI: video: Add backlight=native quirk for Lenovo Slim 7 16ARH7
      ALSA: seq: ump: Fix missing System Reset message handling

Tamim Khan (1):
      ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MV

Tim Harvey (1):
      arm64: dts: freescale: imx8mp-venice-gw73xx-2x: fix BT shutdown GPIO

Tony Luck (2):
      x86/cpu/vfm: Add new macros to work with (vendor/family/model) values
      x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL

Tzung-Bi Shih (3):
      platform/chrome: cros_usbpd_logger: provide ID table for avoiding fallback match
      platform/chrome: cros_usbpd_notify: provide ID table for avoiding fallback match
      power: supply: cros_usbpd: provide ID table for avoiding fallback match

Uri Arev (1):
      Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl

Viresh Kumar (1):
      OPP: Fix required_opp_tables for multiple genpds using same table

Waiman Long (1):
      cgroup/cpuset: Make cpuset hotplug processing synchronous

Wander Lairson Costa (1):
      drop_monitor: replace spin_lock by raw_spin_lock

Wojciech Drewek (1):
      ice: implement AQ download pkg retry

Xi Ruoyao (1):
      LoongArch: Only allow OBJTOOL & ORC unwinder if toolchain supports -mthin-add-sub

Xiaolei Wang (1):
      net: stmmac: No need to calculate speed divider when offload is disabled

Xin Long (2):
      tipc: force a dst refcount before doing decryption
      sched: act_ct: add netns into the key of tcf_ct_flow_table

Yishai Hadas (1):
      RDMA/mlx5: Fix unwind flow as part of mlx5_ib_stage_init_init

Yonghong Song (1):
      selftests/bpf: Fix flaky test btf_map_in_map/lookup_update

Yue Haibing (1):
      netns: Make get_net_ns() handle zero refcount net

Yunlei He (1):
      f2fs: remove clear SB_INLINECRYPT flag in default_options

Yunxiang Li (1):
      drm/amdgpu: fix locking scope when flushing tlb

Zqiang (2):
      rcutorture: Make stall-tasks directly exit when rcutorture tests end
      rcutorture: Fix invalid context warning when enable srcu barrier testing


