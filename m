Return-Path: <stable+bounces-200264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4005CAAE02
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 22:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84A0530056AA
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E3F2D7DCF;
	Sat,  6 Dec 2025 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M92fP8BB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08222C0F9C;
	Sat,  6 Dec 2025 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765057158; cv=none; b=AL9sNJ9ej+9Bhy9E6TOUKzLysabF9MfCsIQoRT4vOaZw6LF046BNPch40EX52Il9y8rJtLyI0Ubk3lb3yo+QTmkd4rGsnSrgDlUfo4/i/oEZuJYNjLRUN+oFGBsXrFI8hrL01qBC0blN0XpNrrCZy5fVy1s2ySKZiJkHOt9laFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765057158; c=relaxed/simple;
	bh=wqOAdi8PrX7XdDJFNLIVafSYBJnbqnveT2csdMqFMbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kl3/CpkoyNOBGBhntwntaw5YN43biyq8rCb420s8TStK9uAknRI3sGbssXx0G0Uadnzl4fOM65JipCGWIbLl6Ft0Sg/IOthqNdZs995v48btYXHl+8njSr+9vzx9HFtxF8XOK03J3Kgaf25ECx4HSavdnJhQk0ysfmg42aJG6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M92fP8BB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8EBC4CEF5;
	Sat,  6 Dec 2025 21:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765057158;
	bh=wqOAdi8PrX7XdDJFNLIVafSYBJnbqnveT2csdMqFMbo=;
	h=From:To:Cc:Subject:Date:From;
	b=M92fP8BBBAA8E977L+tRTld8nCwj7qVJEJvgKlI7XhQ/NACVsHaWvsVpckV18VG58
	 PJptgNuj8unBzhZEUyX+NSO7uaLSvCiVnam0Zs0jD4vejOBLtSEZu+HwGCuppB17D9
	 Ew2KsbQXbmSdQyHSLRx8g+9ewRWhgM374PEsfN3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.247
Date: Sun,  7 Dec 2025 06:39:13 +0900
Message-ID: <2025120714-freeness-armless-d986@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.247 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml |   26 +
 Documentation/kbuild/makefiles.rst                                      |   29 +-
 Makefile                                                                |    6 
 arch/arc/include/asm/bitops.h                                           |    2 
 arch/arm/crypto/Kconfig                                                 |    2 
 arch/arm/mach-at91/pm_suspend.S                                         |    8 
 arch/mips/boot/dts/lantiq/danube.dtsi                                   |    6 
 arch/mips/lantiq/xway/sysctrl.c                                         |    2 
 arch/mips/loongson64/Platform                                           |    2 
 arch/mips/mm/tlb-r4k.c                                                  |  100 ++++---
 arch/mips/mti-malta/malta-init.c                                        |   20 -
 arch/parisc/boot/compressed/Makefile                                    |    2 
 arch/powerpc/Makefile                                                   |    4 
 arch/powerpc/kernel/eeh_driver.c                                        |    2 
 arch/riscv/kernel/cpu-hotplug.c                                         |    1 
 arch/riscv/mm/ptdump.c                                                  |    2 
 arch/s390/Makefile                                                      |    6 
 arch/s390/purgatory/Makefile                                            |    2 
 arch/sparc/include/asm/elf_64.h                                         |    1 
 arch/sparc/kernel/module.c                                              |    1 
 arch/um/drivers/ssl.c                                                   |    5 
 arch/x86/Makefile                                                       |    2 
 arch/x86/boot/compressed/Makefile                                       |    2 
 arch/x86/entry/vsyscall/vsyscall_64.c                                   |   17 +
 arch/x86/events/core.c                                                  |   10 
 arch/x86/kernel/cpu/bugs.c                                              |    5 
 arch/x86/kernel/cpu/resctrl/monitor.c                                   |   10 
 arch/x86/kernel/kvm.c                                                   |   20 -
 drivers/acpi/acpi_video.c                                               |    4 
 drivers/acpi/acpica/dsmethod.c                                          |   10 
 drivers/acpi/numa/srat.c                                                |    2 
 drivers/acpi/property.c                                                 |   24 +
 drivers/acpi/video_detect.c                                             |    8 
 drivers/ata/libata-scsi.c                                               |    8 
 drivers/atm/fore200e.c                                                  |    2 
 drivers/base/devcoredump.c                                              |  138 ++++++----
 drivers/base/regmap/regmap-slimbus.c                                    |    6 
 drivers/bluetooth/btusb.c                                               |   13 
 drivers/bluetooth/hci_bcsp.c                                            |    3 
 drivers/char/misc.c                                                     |    8 
 drivers/clocksource/timer-vf-pit.c                                      |   22 -
 drivers/cpufreq/longhaul.c                                              |    3 
 drivers/cpuidle/cpuidle.c                                               |    8 
 drivers/dma/dw-edma/dw-edma-core.c                                      |   22 +
 drivers/dma/mv_xor.c                                                    |    4 
 drivers/dma/sh/shdma-base.c                                             |   25 +
 drivers/dma/sh/shdmac.c                                                 |   17 -
 drivers/edac/altera_edac.c                                              |   22 +
 drivers/extcon/extcon-adc-jack.c                                        |    2 
 drivers/firmware/arm_scmi/scmi_pm_domain.c                              |   13 
 drivers/firmware/efi/libstub/Makefile                                   |    2 
 drivers/firmware/stratix10-svc.c                                        |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c                                |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                   |    9 
 drivers/gpu/drm/amd/display/dc/calcs/Makefile                           |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c                         |   11 
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile                           |    2 
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile                           |    2 
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile                           |    2 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                             |    2 
 drivers/gpu/drm/amd/display/dc/dsc/Makefile                             |    2 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c                   |    2 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c                |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                       |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                                  |    2 
 drivers/gpu/drm/bridge/display-connector.c                              |    3 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                                |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                   |    5 
 drivers/gpu/drm/nouveau/nvkm/core/enum.c                                |    2 
 drivers/gpu/drm/sti/sti_vtg.c                                           |    7 
 drivers/gpu/drm/tegra/dc.c                                              |    1 
 drivers/gpu/drm/tidss/tidss_crtc.c                                      |    2 
 drivers/gpu/drm/tidss/tidss_dispc.c                                     |   16 -
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                                 |    5 
 drivers/hid/hid-ids.h                                                   |    7 
 drivers/hid/hid-ntrig.c                                                 |    7 
 drivers/hid/hid-quirks.c                                                |   14 -
 drivers/hwmon/dell-smm-hwmon.c                                          |    7 
 drivers/iio/adc/spear_adc.c                                             |    9 
 drivers/iio/common/ssp_sensors/ssp_dev.c                                |    4 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                                 |   22 -
 drivers/input/keyboard/cros_ec_keyb.c                                   |    6 
 drivers/input/keyboard/imx_sc_key.c                                     |    2 
 drivers/input/misc/ati_remote2.c                                        |    2 
 drivers/input/misc/cm109.c                                              |    2 
 drivers/input/misc/powermate.c                                          |    2 
 drivers/input/misc/yealink.c                                            |    2 
 drivers/input/tablet/acecad.c                                           |    2 
 drivers/input/tablet/pegasus_notetaker.c                                |   11 
 drivers/iommu/amd/init.c                                                |   28 +-
 drivers/irqchip/irq-gic-v2m.c                                           |   13 
 drivers/isdn/hardware/mISDN/hfcsusb.c                                   |   18 -
 drivers/mailbox/mailbox-test.c                                          |    2 
 drivers/md/dm-verity-fec.c                                              |    6 
 drivers/media/i2c/ir-kbd-i2c.c                                          |    6 
 drivers/media/pci/ivtv/ivtv-alsa-pcm.c                                  |    2 
 drivers/media/pci/ivtv/ivtv-driver.h                                    |    3 
 drivers/media/pci/ivtv/ivtv-fileops.c                                   |   18 -
 drivers/media/pci/ivtv/ivtv-irq.c                                       |    4 
 drivers/media/rc/imon.c                                                 |   61 ++--
 drivers/media/rc/redrat3.c                                              |    2 
 drivers/media/tuners/xc4000.c                                           |    8 
 drivers/media/tuners/xc5000.c                                           |   12 
 drivers/memstick/core/memstick.c                                        |    8 
 drivers/mfd/da9063-i2c.c                                                |   27 +
 drivers/mfd/madera-core.c                                               |    4 
 drivers/mfd/stmpe-i2c.c                                                 |    1 
 drivers/mfd/stmpe.c                                                     |    3 
 drivers/mmc/host/renesas_sdhi_core.c                                    |    6 
 drivers/mmc/host/sdhci-msm.c                                            |   15 +
 drivers/most/most_usb.c                                                 |   14 -
 drivers/mtd/nand/onenand/onenand_samsung.c                              |    2 
 drivers/mtd/nand/raw/cadence-nand-controller.c                          |    3 
 drivers/net/can/sja1000/sja1000.c                                       |    4 
 drivers/net/can/sun4i_can.c                                             |    4 
 drivers/net/can/usb/gs_usb.c                                            |   23 -
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c                        |    4 
 drivers/net/dsa/b53/b53_common.c                                        |   15 -
 drivers/net/dsa/b53/b53_regs.h                                          |    3 
 drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c                    |   22 +
 drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h                    |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                        |    5 
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c               |   19 -
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c                |    2 
 drivers/net/ethernet/cadence/macb_main.c                                |    4 
 drivers/net/ethernet/emulex/benet/be_main.c                             |    7 
 drivers/net/ethernet/freescale/fec_main.c                               |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_common.c                         |    5 
 drivers/net/ethernet/intel/fm10k/fm10k_common.h                         |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c                             |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c                             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                      |   15 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c                   |    6 
 drivers/net/ethernet/qlogic/qede/qede_main.c                            |    2 
 drivers/net/ethernet/realtek/Kconfig                                    |    2 
 drivers/net/ethernet/realtek/r8169_main.c                               |    6 
 drivers/net/ethernet/renesas/ravb_main.c                                |   16 +
 drivers/net/ethernet/renesas/sh_eth.c                                   |    4 
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c                         |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                       |    9 
 drivers/net/ethernet/ti/netcp_core.c                                    |   10 
 drivers/net/phy/dp83867.c                                               |    6 
 drivers/net/phy/marvell.c                                               |   39 ++
 drivers/net/phy/mdio_bus.c                                              |    5 
 drivers/net/usb/asix_devices.c                                          |   12 
 drivers/net/usb/qmi_wwan.c                                              |    6 
 drivers/net/usb/usbnet.c                                                |    2 
 drivers/net/wireless/ath/ath10k/mac.c                                   |   12 
 drivers/net/wireless/ath/ath10k/wmi.c                                   |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c             |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c                  |   28 --
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h                  |    3 
 drivers/nvme/host/fc.c                                                  |   12 
 drivers/pci/controller/cadence/pcie-cadence-host.c                      |    2 
 drivers/pci/controller/cadence/pcie-cadence.c                           |    4 
 drivers/pci/controller/cadence/pcie-cadence.h                           |    6 
 drivers/pci/p2pdma.c                                                    |    2 
 drivers/pci/quirks.c                                                    |    1 
 drivers/phy/cadence/cdns-dphy.c                                         |    4 
 drivers/pinctrl/pinctrl-single.c                                        |    4 
 drivers/regulator/fixed.c                                               |    6 
 drivers/remoteproc/qcom_q6v5.c                                          |    5 
 drivers/s390/net/ctcm_mpc.c                                             |    1 
 drivers/scsi/hosts.c                                                    |    5 
 drivers/scsi/lpfc/lpfc_debugfs.h                                        |    3 
 drivers/scsi/pm8001/pm8001_ctl.c                                        |   24 -
 drivers/scsi/pm8001/pm8001_init.c                                       |    1 
 drivers/scsi/pm8001/pm8001_sas.c                                        |    4 
 drivers/scsi/pm8001/pm8001_sas.h                                        |    4 
 drivers/scsi/sg.c                                                       |   10 
 drivers/slimbus/qcom-ngd-ctrl.c                                         |    1 
 drivers/soc/imx/gpc.c                                                   |    2 
 drivers/soc/qcom/smem.c                                                 |    2 
 drivers/soc/ti/knav_dma.c                                               |   14 -
 drivers/soc/ti/pruss.c                                                  |    2 
 drivers/spi/spi-bcm63xx.c                                               |   14 +
 drivers/spi/spi-loopback-test.c                                         |   12 
 drivers/spi/spi.c                                                       |   10 
 drivers/target/loopback/tcm_loop.c                                      |    3 
 drivers/tee/tee_core.c                                                  |    2 
 drivers/thunderbolt/nhi.c                                               |    2 
 drivers/thunderbolt/nhi.h                                               |    1 
 drivers/tty/serial/8250/8250_dw.c                                       |   67 ++--
 drivers/tty/serial/amba-pl011.c                                         |    2 
 drivers/uio/uio_hv_generic.c                                            |   21 +
 drivers/usb/cdns3/cdns3-pci-wrap.c                                      |    5 
 drivers/usb/dwc3/ep0.c                                                  |    1 
 drivers/usb/dwc3/gadget.c                                               |    7 
 drivers/usb/gadget/function/f_eem.c                                     |    7 
 drivers/usb/gadget/function/f_fs.c                                      |    8 
 drivers/usb/gadget/function/f_hid.c                                     |    4 
 drivers/usb/gadget/function/f_ncm.c                                     |    3 
 drivers/usb/host/xhci-dbgcap.h                                          |    1 
 drivers/usb/host/xhci-dbgtty.c                                          |   17 +
 drivers/usb/host/xhci-plat.c                                            |    1 
 drivers/usb/mon/mon_bin.c                                               |   14 -
 drivers/usb/renesas_usbhs/common.c                                      |   14 -
 drivers/usb/serial/ftdi_sio.c                                           |    1 
 drivers/usb/serial/ftdi_sio_ids.h                                       |    1 
 drivers/usb/serial/option.c                                             |   10 
 drivers/usb/storage/sddr55.c                                            |    6 
 drivers/usb/storage/transport.c                                         |   16 +
 drivers/usb/storage/uas.c                                               |    7 
 drivers/usb/storage/unusual_devs.h                                      |    2 
 drivers/usb/typec/ucsi/psy.c                                            |    5 
 drivers/video/backlight/lp855x_bl.c                                     |    2 
 drivers/video/fbdev/aty/atyfb_base.c                                    |    8 
 drivers/video/fbdev/core/bitblit.c                                      |   33 ++
 drivers/video/fbdev/pvr2fb.c                                            |    2 
 drivers/video/fbdev/valkyriefb.c                                        |    2 
 fs/9p/v9fs.c                                                            |    9 
 fs/btrfs/disk-io.c                                                      |    2 
 fs/btrfs/file.c                                                         |   10 
 fs/btrfs/transaction.c                                                  |    2 
 fs/btrfs/tree-log.c                                                     |    1 
 fs/ceph/locks.c                                                         |    5 
 fs/cifs/connect.c                                                       |    1 
 fs/dax.c                                                                |    2 
 fs/exfat/fatent.c                                                       |   11 
 fs/exfat/super.c                                                        |    5 
 fs/ext4/xattr.c                                                         |    2 
 fs/fs-writeback.c                                                       |    7 
 fs/hpfs/namei.c                                                         |   18 -
 fs/jfs/inode.c                                                          |    8 
 fs/jfs/jfs_txnmgr.c                                                     |    9 
 fs/nfs/inode.c                                                          |    6 
 fs/nfs/nfs4client.c                                                     |    1 
 fs/nfs/nfs4proc.c                                                       |    7 
 fs/nfs/nfs4state.c                                                      |    3 
 fs/nfsd/nfs4proc.c                                                      |    7 
 fs/nfsd/nfs4state.c                                                     |    3 
 fs/open.c                                                               |   10 
 fs/orangefs/xattr.c                                                     |   12 
 fs/overlayfs/copy_up.c                                                  |    2 
 fs/proc/generic.c                                                       |   12 
 fs/xfs/xfs_super.c                                                      |   33 +-
 include/linux/ata.h                                                     |    1 
 include/linux/blk_types.h                                               |   11 
 include/linux/compiler_types.h                                          |    5 
 include/linux/filter.h                                                  |    2 
 include/linux/mm.h                                                      |    2 
 include/linux/shdma-base.h                                              |    2 
 include/linux/usb.h                                                     |   16 -
 include/net/cls_cgroup.h                                                |    2 
 include/net/nfc/nci_core.h                                              |    2 
 include/net/pkt_sched.h                                                 |   25 +
 include/net/sctp/sctp.h                                                 |    3 
 include/net/tls.h                                                       |    6 
 kernel/bpf/ringbuf.c                                                    |    2 
 kernel/events/uprobes.c                                                 |    7 
 kernel/gcov/gcc_4_7.c                                                   |    4 
 kernel/trace/trace_events_hist.c                                        |    6 
 kernel/trace/trace_events_synth.c                                       |    3 
 lib/crypto/Makefile                                                     |    2 
 mm/page_alloc.c                                                         |    2 
 net/8021q/vlan.c                                                        |    2 
 net/bluetooth/6lowpan.c                                                 |   97 ++++---
 net/bluetooth/hci_event.c                                               |   21 +
 net/bluetooth/l2cap_core.c                                              |    1 
 net/bluetooth/sco.c                                                     |    7 
 net/bluetooth/smp.c                                                     |   31 --
 net/bridge/br_forward.c                                                 |    3 
 net/ceph/ceph_common.c                                                  |   53 ++-
 net/ceph/debugfs.c                                                      |   14 -
 net/core/netpoll.c                                                      |    7 
 net/core/page_pool.c                                                    |    6 
 net/core/sock.c                                                         |   15 -
 net/hsr/hsr_device.c                                                    |    3 
 net/ipv4/fib_frontend.c                                                 |    2 
 net/ipv4/inet_diag.c                                                    |    5 
 net/ipv4/nexthop.c                                                      |    6 
 net/ipv4/raw_diag.c                                                     |    7 
 net/ipv4/route.c                                                        |    5 
 net/ipv4/udp_diag.c                                                     |    6 
 net/ipv4/udp_tunnel_nic.c                                               |    2 
 net/ipv6/addrconf.c                                                     |    4 
 net/ipv6/ah6.c                                                          |   50 ++-
 net/ipv6/raw.c                                                          |    2 
 net/ipv6/udp.c                                                          |    2 
 net/mac80211/rx.c                                                       |   10 
 net/mptcp/mptcp_diag.c                                                  |    6 
 net/mptcp/pm.c                                                          |    3 
 net/mptcp/pm_netlink.c                                                  |   20 -
 net/mptcp/protocol.c                                                    |   59 +++-
 net/mptcp/protocol.h                                                    |    1 
 net/netfilter/nf_tables_api.c                                           |   15 +
 net/netfilter/nft_set_pipapo.c                                          |    4 
 net/netfilter/nft_set_pipapo.h                                          |   21 +
 net/netfilter/nft_set_pipapo_avx2.c                                     |   31 +-
 net/netlink/af_netlink.c                                                |    2 
 net/openvswitch/actions.c                                               |   68 ----
 net/openvswitch/flow_netlink.c                                          |   64 ----
 net/openvswitch/flow_netlink.h                                          |    2 
 net/rds/rds.h                                                           |    2 
 net/sched/act_ife.c                                                     |   12 
 net/sched/sch_api.c                                                     |   10 
 net/sched/sch_generic.c                                                 |   17 -
 net/sched/sch_hfsc.c                                                    |   16 -
 net/sched/sch_qfq.c                                                     |    2 
 net/sctp/diag.c                                                         |   69 ++---
 net/sctp/sm_make_chunk.c                                                |    2 
 net/sctp/socket.c                                                       |   24 +
 net/sctp/transport.c                                                    |   13 
 net/smc/smc_clc.c                                                       |    1 
 net/strparser/strparser.c                                               |    2 
 net/tipc/net.c                                                          |    2 
 net/tls/tls_device.c                                                    |    4 
 net/unix/diag.c                                                         |    6 
 net/vmw_vsock/af_vsock.c                                                |   40 ++
 scripts/Kbuild.include                                                  |   10 
 scripts/kconfig/mconf.c                                                 |    3 
 scripts/kconfig/nconf.c                                                 |    3 
 sound/pci/hda/patch_realtek.c                                           |   17 -
 sound/soc/codecs/cs4271.c                                               |   10 
 sound/soc/codecs/max98090.c                                             |    6 
 sound/soc/meson/aiu-encoder-i2s.c                                       |    9 
 sound/soc/qcom/qdsp6/q6asm.c                                            |    2 
 sound/usb/endpoint.c                                                    |    5 
 sound/usb/mixer.c                                                       |   11 
 sound/usb/mixer_s1810c.c                                                |   28 +-
 sound/usb/validate.c                                                    |    9 
 tools/power/cpupower/lib/cpuidle.c                                      |    5 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c         |   30 +-
 tools/testing/selftests/Makefile                                        |    2 
 tools/testing/selftests/bpf/test_lirc_mode2_user.c                      |    2 
 tools/testing/selftests/net/fcnal-test.sh                               |    4 
 tools/testing/selftests/net/psock_tpacket.c                             |    4 
 tools/testing/selftests/net/traceroute.sh                               |   13 
 329 files changed, 2071 insertions(+), 1149 deletions(-)

Abdun Nihaal (1):
      isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Akhil P Oommen (1):
      drm/msm/a6xx: Fix GMU firmware parser

Al Viro (2):
      allow finish_no_open(file, ERR_PTR(-E...))
      nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing

Alan Borzeszkowski (1):
      thunderbolt: Add support for Intel Wildcat Lake

Alan Stern (1):
      USB: storage: Remove subclass and protocol overrides from Novatek quirk

Albin Babu Varghese (1):
      fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds

Aleksander Jan Bajkowski (3):
      mips: lantiq: danube: add missing properties to cpu node
      mips: lantiq: danube: add missing device_type in pci node
      mips: lantiq: xway: sysctrl: rename stp clock

Aleksei Nikiforov (1):
      s390/ctcm: Fix double-kfree

Alex Hung (1):
      drm/amd/display: Check NULL before accessing

Alex Lu (1):
      Bluetooth: Add more enc key size check

Alexander Stein (2):
      mfd: stmpe: Remove IRQ domain upon removal
      mfd: stmpe-i2c: Add missing MODULE_LICENSE

Alexey Dobriyan (1):
      x86/boot: Compile boot code with -std=gnu11 too

Alexey Klimov (1):
      regmap: slimbus: fix bus_context pointer in regmap init calls

Alexey Kodanev (1):
      net: sxgbe: fix potential NULL dereference in sxgbe_rx()

Alok Tiwari (1):
      udp_tunnel: use netdev_warn() instead of netdev_WARN()

Amber Lin (1):
      drm/amdkfd: Tie UNMAP_LATENCY to queue_preemption

Amirreza Zarrabi (1):
      tee: allow a driver to allocate a tee_device without a pool

Andrey Vatoropin (1):
      be2net: pass wrb_params in case of OS2BMC

Andy Shevchenko (1):
      serial: 8250_dw: Use devm_add_action_or_reset()

Anthony Iliopoulos (1):
      NFSv4.1: fix mount hang after CREATE_SESSION failure

Armin Wolf (1):
      hwmon: (dell-smm) Add support for Dell OptiPlex 7040

Arnd Bergmann (1):
      mfd: madera: Work around false-positive -Wininitialized warning

Artem Shimko (1):
      serial: 8250_dw: handle reset control deassert error

Ashish Kalra (1):
      iommu/amd: Skip enabling command/event buffers for kdump

Babu Moger (1):
      x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID

Bart Van Assche (2):
      scsi: sg: Do not sleep in atomic context
      scsi: core: Fix a regression triggered by scsi_host_busy()

Benjamin Berg (1):
      wifi: mac80211: skip rate verification for not captured PSDUs

Biju Das (1):
      mmc: host: renesas_sdhi: Fix the actual clock

Brahmajit Das (1):
      net: intel: fm10k: Fix parameter idx set but not used

Breno Leitao (1):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup

Buday Csaba (1):
      net: mdio: fix resource leak in mdiobus_register_device()

Celeste Liu (1):
      can: gs_usb: increase max interface to U8_MAX

Charalampos Mitrodimas (1):
      net: ipv6: fix field-spanning memcpy warning in AH output

Chelsy Ratnawat (1):
      media: fix uninitialized symbol warnings

Chen Wang (1):
      PCI: cadence: Check for the existence of cdns_pcie::ops before using it

Chi Zhang (1):
      pinctrl: single: fix bias pull up/down handling in pin_config_set

Chi Zhiling (1):
      exfat: limit log print for IO error

Chris Morgan (1):
      regulator: fixed: use dev_err_probe for register

Christian Bruel (1):
      irqchip/gic-v2m: Handle Multiple MSI base IRQ Alignment

Christoph Hellwig (1):
      fsdax: mark the iomap argument to dax_iomap_sector as const

Christoph Paasch (1):
      net: When removing nexthops, don't call synchronize_net if it is not necessary

Christophe JAILLET (1):
      iio:common:ssp_sensors: Fix an error handling path ssp_probe()

Chuang Wang (1):
      ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe

Chuck Lever (1):
      NFSD: Fix crash in nfsd4_read_release()

ChunHao Lin (1):
      r8169: set EEE speed down ratio to 1

Claudiu Beznea (1):
      usb: renesas_usbhs: Fix synchronous external abort on unbind

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for MOONDROP Quark2

D. Wythe (1):
      net/smc: fix mismatch between CLC header and proposal

Damien Le Moal (2):
      block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
      block: make REQ_OP_ZONE_OPEN a write operation

Dan Carpenter (2):
      mtd: onenand: Pass correct pointer to IRQ handler
      Input: imx_sc_key - fix memory corruption on unload

Daniel Lezcano (1):
      clocksource/drivers/vf-pit: Replace raw_readl/writel to readl/writel

Daniel Palmer (2):
      fbdev: atyfb: Check if pll_ops->init_pll failed
      eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP

Daniel Wagner (1):
      nvme-fc: use lock accessing port_state and rport state

Danielle Costantino (1):
      net/mlx5e: Fix validation logic in rate limiting

Danil Skrebenkov (1):
      RISC-V: clear hot-unplugged cores from all task mm_cpumasks to avoid rfence errors

Darrick J. Wong (1):
      xfs: always warn about deprecated mount options

David Ahern (2):
      selftests: Disable dad for ipv6 in fcnal-test.sh
      selftests: Replace sleep with slowwait

David Kaplan (1):
      x86/bugs: Fix reporting of LFENCE retpoline

Dennis Beier (1):
      cpufreq/longhaul: handle NULL policy in longhaul_exit

Desnes Nunes (1):
      usb: storage: Fix memory leak in USB bulk transport

Devendra K Verma (1):
      dmaengine: dw-edma: Set status for callback_result

Dmitry Baryshkov (1):
      drm/bridge: display-connector: don't set OP_DETECT for DisplayPorts

Dragos Tatulea (1):
      page_pool: Clamp pool size to max 16K pages

Emanuele Ghidoli (1):
      net: phy: dp83867: Disable EEE support as not implemented

Eric Biggers (1):
      lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN

Eric Dumazet (6):
      net: call cond_resched() less often in __release_sock()
      ipv6: np->rxpmtu race annotation
      sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
      net_sched: limit try_bulk_dequeue_skb() batches
      mptcp: fix race condition in mptcp_schedule_work()
      mptcp: fix a race in mptcp_pm_del_add_timer()

Ewan D. Milne (1):
      nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

Felix Maurer (1):
      hsr: Fix supervision frame sending on HSRv0

Filipe Manana (2):
      btrfs: always drop log root tree reference in btrfs_replay_log()
      btrfs: use smp_mb__after_atomic() when forcing COW in create_pending_snapshot()

Florian Fuchs (1):
      fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS

Florian Westphal (2):
      netfilter: nf_set_pipapo: fix initial map fill
      netfilter: nf_set_pipapo_avx2: fix initial map fill

Forest Crossman (1):
      usb: mon: Increase BUFF_MAX to 64 MiB to support multi-MB URBs

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: fix array size for st_lsm6dsx_settings fields

Francisco Gutierrez (1):
      scsi: pm80xx: Fix race condition caused by static variables

Gal Pressman (2):
      net/mlx5e: Fix maxrate wraparound in threshold between units
      net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps

Geoffrey McRae (1):
      drm/amdkfd: return -ENOTTY for unsupported IOCTLs

Gokul Sivakumar (1):
      wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode

Greg Kroah-Hartman (1):
      Linux 5.10.247

Gui-Dong Han (1):
      atm/fore200e: Fix possible data race in fore200e_open()

Haein Lee (1):
      ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd

Hamza Mahfooz (1):
      scsi: target: tcm_loop: Fix segfault in tcm_loop_tpg_address_show()

Hang Zhou (1):
      spi: bcm63xx: fix premature CS deassertion on RX-only transactions

Hangbin Liu (1):
      net: vlan: sync VLAN features with lower device

Hans de Goede (2):
      ACPICA: dispatcher: Use acpi_ds_clear_operands() in acpi_ds_call_control_method()
      spi: Try to get ACPI GPIO IRQ earlier

Haotian Zhang (3):
      regulator: fixed: fix GPIO descriptor leak on register failure
      ASoC: cs4271: Fix regulator leak on probe failure
      mailbox: mailbox-test: Fix debugfs_create_dir error checking

Harikrishna Shenoy (1):
      phy: cadence: cdns-dphy: Enable lower resolutions in dphy

Ian Forbes (1):
      drm/vmwgfx: Validate command header size against SVGA_CMD_MAX_DATASIZE

Ido Schimmel (2):
      bridge: Redirect to backup port when port is administratively down
      selftests: traceroute: Use require_command()

Igor Pylypiv (1):
      scsi: pm80xx: Set phy->enable_completion only when we

Ilya Dryomov (1):
      libceph: fix potential use-after-free in have_mon_and_osd_map()

Ilya Maximets (1):
      net: openvswitch: remove never-working support for setting nsh fields

Isaac J. Manjarres (1):
      mm/mm_init: fix hash table order logging in alloc_large_system_hash()

Ivan Pravdin (1):
      Bluetooth: bcsp: receive data only if registered

Jakub Acs (1):
      mm/ksm: fix flag-dropping behavior in ksm_madvise

Jakub Horký (2):
      kconfig/mconf: Initialize the default locale at startup
      kconfig/nconf: Initialize the default locale at startup

Jameson Thies (1):
      usb: typec: ucsi: psy: Set max current to zero when disconnected

Jens Kehne (1):
      mfd: da9063: Split chip variant reading in two bus transactions

Jens Reidel (1):
      soc: qcom: smem: Fix endian-unaware access of num_entries

Jiayi Li (1):
      memstick: Add timeout to prevent indefinite waiting

Jiayuan Chen (1):
      mptcp: Fix proto fallback detection with BPF

Jiefeng Zhang (1):
      net: atlantic: fix fragment overflow handling in RX path

Jiri Olsa (2):
      uprobe: Do not emulate/sstep original instruction when ip is changed
      Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"

Jiufei Xue (1):
      fs: writeback: fix use-after-free in __mark_inode_dirty()

Johan Hovold (2):
      most: usb: fix double free on late probe failure
      drm: sti: fix device leaks at component probe

John Smith (2):
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Fiji
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Iceland

Jonas Gorski (3):
      net: dsa: b53: fix resetting speed and pause on forced link
      net: dsa: b53: fix enabling ip multicast
      net: dsa: b53: stop reading ARL entries if search is done

Josephine Pfeiffer (1):
      riscv: ptdump: use seq_puts() in pt_dump_seq_puts() macro

Joshua Watt (1):
      NFS4: Fix state renewals missing after boot

Junjie Cao (1):
      fbdev: bitblit: bound-check glyph index in bit_putcs*

Juraj Šarinay (1):
      net: nfc: nci: Increase NCI_DATA_TIMEOUT to 3000 ms

Justin Tee (1):
      scsi: lpfc: Define size of debugfs entry for xri rebalancing

Kai-Heng Feng (1):
      net: aquantia: Add missing descriptor cache invalidation on ATL2

Kailang Yang (1):
      ALSA: hda/realtek: Audio disappears on HP 15-fc000 after warm boot again

Kaushlendra Kumar (2):
      tools/cpupower: Fix incorrect size in cpuidle_state_disable()
      tools/power x86_energy_perf_policy: Fix incorrect fopen mode usage

Kees Cook (1):
      arc: Fix __fls() const-foldability via __builtin_clzl()

Khairul Anuar Romli (1):
      firmware: stratix10-svc: fix bug in saving controller data

Kirill A. Shutemov (1):
      x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall

Koakuma (1):
      sparc/module: Add R_SPARC_UA64 relocation handling

Krishna Kurapati (1):
      usb: xhci: plat: Facilitate using autosuspend for xhci plat devices

Krzysztof Kozlowski (3):
      extcon: adc-jack: Fix wakeup source leaks on device unbind
      extcon: adc-jack: Cleanup wakeup source only if it was enabled
      dt-bindings: pinctrl: toshiba,visconti: Fix number of items in groups

Kuen-Han Tsai (1):
      usb: gadget: f_eem: Fix memory leak in eem_unwrap

Kuniyuki Iwashima (2):
      net: Call trace_sock_exceed_buf_limit() for memcg failure with SK_MEM_RECV.
      tipc: Fix use-after-free in tipc_mon_reinit_self().

Lad Prabhakar (1):
      net: ravb: Enforce descriptor type ordering

Laurent Pinchart (1):
      media: pci: ivtv: Don't create fake v4l2_fh

Len Brown (2):
      tools/power x86_energy_perf_policy: Enhance HWP enable
      tools/power x86_energy_perf_policy: Prefer driver HWP limits

Li RongQing (1):
      x86/kvm: Prefer native qspinlock for dedicated vCPUs irrespective of PV_UNHALT

Lijo Lazar (1):
      drm/amd/pm: Use cached metrics data on arcturus

Lizhi Xu (1):
      usbnet: Prevents free active kevent

Loic Poulain (2):
      wifi: ath10k: Fix memory leak on unsupported WMI command
      wifi: ath10k: Fix connection after GTK rekeying

Long Li (1):
      uio_hv_generic: Set event for all channels on the device

Lu Wei (1):
      net: sctp: Fix some typos

Luiz Augusto von Dentz (2):
      Bluetooth: SCO: Fix UAF on sco_conn_free
      Bluetooth: SMP: Fix not generating mackey and ltk when repairing

Ma Ke (1):
      drm/tegra: dc: Fix reference leak in tegra_dc_couple()

Maarten Lankhorst (1):
      devcoredump: Fix circular locking dependency with devcd->mutex.

Maciej W. Rozycki (2):
      MIPS: Malta: Fix !EVA SOC-it PCI MMIO
      MIPS: mm: Prevent a TLB shutdown on initial uniquification

Manish Nagar (1):
      usb: dwc3: Fix race condition between concurrent dwc3_remove_requests() call paths

Marc Kleine-Budde (1):
      can: sun4i_can: sun4i_can_interrupt(): fix max irq loop handling

Marcos Del Sol Vives (1):
      PCI: Disable MSI on RDC PCI to PCIe bridges

Mario Limonciello (AMD) (1):
      ACPI: video: force native for Lenovo 82K8

Masami Ichikawa (1):
      HID: hid-ntrig: Prevent memory leak in ntrig_report_version()

Mathias Nyman (1):
      xhci: dbgtty: Fix data corruption when transmitting data form DbC to host

Matthieu Baerts (NGI0) (2):
      arch: back to -std=gnu89 in < v5.18
      tracing: fix declaration-after-statement warning

Miaoqian Lin (6):
      net: usb: asix_devices: Check return value of usbnet_get_endpoints
      fbdev: valkyriefb: Fix reference count leak in valkyriefb_init
      pmdomain: imx: Fix reference count leak in imx_gpc_remove
      slimbus: ngd: Fix reference count leak in qcom_slim_ngd_notify_slaves
      serial: amba-pl011: prefer dma_mapping_error() over explicit address checking
      usb: cdns3: Fix double resource release in cdns3_pci_probe

Michal Luczaj (1):
      vsock: Ignore signal/timeout on connect() if already established

Mike Marshall (1):
      orangefs: fix xattr related buffer overflow...

Mikulas Patocka (1):
      dm-verity: fix unreliable memory allocation

Nai-Chen Cheng (1):
      selftests/Makefile: include $(INSTALL_DEP_TARGETS) in clean target to clean net/lib dependency

Nate Karstens (1):
      strparser: Fix signed/unsigned mismatch bug

Nathan Chancellor (2):
      lib/crypto: curve25519-hacl64: Fix older clang KASAN workaround for GCC
      net: qede: Initialize qede_ll_ops with designated initializer

Nick Desaulniers (1):
      Makefile.compiler: replace cc-ifversion with compiler-specific macros

Nicolas Ferre (1):
      ARM: at91: pm: save and restore ACR during PLL disable/enable

Niklas Cassel (1):
      ata: libata-scsi: Fix system suspend for a security locked drive

Niklas Schnelle (1):
      powerpc/eeh: Use result of error_detected() in uevent

Niklas Söderlund (1):
      net: sh_eth: Disable WoL if system can not suspend

Niravkumar L Rabara (3):
      EDAC/altera: Handle OCRAM ECC enable after warm reset
      EDAC/altera: Use INTTEST register for Ethernet and USB SBE injection
      mtd: rawnand: cadence: fix DMA device NULL pointer dereference

Nishanth Menon (1):
      net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error

Noorain Eqbal (1):
      bpf: Sync pending IRQ work before freeing ring buffer

Oleksandr Suvorov (1):
      USB: serial: ftdi_sio: add support for u-blox EVK-M101

Olga Kornievskaia (2):
      NFSv4: handle ERR_GRACE on delegation recalls
      NFSD: free copynotify stateid in nfs4_free_ol_stateid()

Owen Gu (2):
      usb: gadget: f_fs: Fix epfile null pointer access after ep enable.
      usb: uas: fix urb unmapping issue when the uas device is remove during ongoing data transfer

Pablo Neira Ayuso (1):
      netfilter: nf_tables: reject duplicate device on updates

Paolo Abeni (2):
      mptcp: introduce mptcp_schedule_work
      mptcp: do not fallback when OoO is present

Pauli Virtanen (4):
      Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
      Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
      Bluetooth: L2CAP: export l2cap_chan_hold for modules

Paulo Alcantara (1):
      smb: client: fix memory leak in cifs_construct_tcon()

Peter Oberparleiter (1):
      gcov: add support for GCC 15

Peter Zijlstra (1):
      compiler_types: Move unused static inline functions warning to W=2

Qendrim Maxhuni (1):
      net: usb: qmi_wwan: initialize MAC header offset in qmimux_rx_fixup

Qianfeng Rong (2):
      scsi: pm8001: Use int instead of u32 to store error codes
      media: redrat3: use int type to store negative error codes

Rafael J. Wysocki (1):
      cpuidle: Fail cpuidle device registration if there is one already

Randall P. Embry (2):
      9p: fix /sys/fs/9p/caches overwriting itself
      9p: sysfs_init: don't hardcode error to ENOMEM

Ranganath V N (1):
      net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

René Rebe (1):
      ALSA: usb-audio: fix uac2 clock source at terminal parser

Ricardo B. Marlière (1):
      selftests/bpf: Fix bpf_prog_detach2 usage in test_lirc_mode2

Rodrigo Gobbi (1):
      iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sample before setting register

Rohan G Thomas (1):
      net: phy: marvell: Fix 88e1510 downshift counter errata

Rosen Penev (1):
      dmaengine: mv_xor: match alloc_wc and free_wc

Roy Vegard Ovesen (2):
      ALSA: usb-audio: fix control pipe direction
      ALSA: usb-audio: add mono main switch to Presonus S1824c

Sakari Ailus (1):
      ACPI: property: Return present device nodes only on fwnode interface

Saket Dumbre (1):
      ACPICA: Update dsmethod.c to get rid of unused variable warning

Sarthak Garg (1):
      mmc: sdhci-msm: Enable tuning for SDR50 mode for SD card

Sathishkumar S (1):
      drm/amdgpu/jpeg: Hold pg_lock before jpeg poweroff

Seungjin Bae (2):
      Input: pegasus-notetaker - fix potential out-of-bounds access
      can: kvaser_usb: leaf: Fix potential infinite loop in command parsers

Seyediman Seyedarab (1):
      drm/nouveau: replace snprintf() with scnprintf() in nvkm_snprintbf()

Shahar Shitrit (1):
      net: tls: Cancel RX async resync request on rcd_delta overflow

Sharique Mohammad (1):
      ASoC: max98090/91: fixed max98091 ALSA widget powering up/down

Shaurya Rane (1):
      jfs: fix uninitialized waitqueue in transaction manager

Shuai Xue (1):
      acpi,srat: Fix incorrect device handle check for Generic Initiator

Srinivas Kandagatla (1):
      ASoC: qdsp6: q6asm: do not sleep while atomic

Stefan Wiehler (3):
      sctp: Hold RCU read lock while iterating over address list
      sctp: Prevent TOCTOU out-of-bounds write
      sctp: Hold sock lock while iterating over address list

Stephan Gerhold (1):
      remoteproc: qcom: q6v5: Avoid handling handover twice

Sudeep Holla (1):
      pmdomain: arm: scmi: Fix genpd leak on provider registration failure

Sungho Kim (1):
      PCI/P2PDMA: Fix incorrect pointer usage in devm_kfree() call

Svyatoslav Ryhel (1):
      video: backlight: lp855x_bl: Set correct EPROM start for LP8556

Takashi Iwai (2):
      ALSA: usb-audio: Add validation of UAC2/UAC3 effect units
      ALSA: usb-audio: Fix potential overflow of PCM transfer buffer

Tetsuo Handa (2):
      media: imon: make send_packet() more robust
      jfs: Verify inode mode when loading from disk

Thomas Andreatta (1):
      dmaengine: sh: setup_xref error handling

Thomas Mühlbacher (1):
      can: sja1000: fix max irq loop handling

Thomas Weißschuh (3):
      spi: loopback-test: Don't use %pK through printk
      soc: ti: pruss: don't use %pK through printk
      bpf: Don't use %pK through printk

Théo Lebrun (1):
      net: macb: avoid dealing with endianness in macb_set_hwaddr()

Tianchu Chen (1):
      usb: storage: sddr55: Reject out-of-bound new_pba

Tiezhu Yang (1):
      net: stmmac: Check stmmac_hw_setup() in stmmac_resume()

Tiwei Bie (1):
      um: Fix help message for ssl-non-raw

Tomeu Vizoso (1):
      drm/etnaviv: fix flush sequence logic

Tomi Valkeinen (1):
      drm/tidss: Use the crtc_* timings when programming the HW

Tristan Lobb (1):
      HID: quirks: avoid Cooler Master MM712 dongle wakeup bug

Trond Myklebust (1):
      Revert "NFS: Don't set NFS_INO_REVAL_PAGECACHE in the inode cache validity"

Tzung-Bi Shih (1):
      Input: cros_ec_keyb - fix an invalid memory access

Ujwal Kundur (1):
      rds: Fix endianness annotation for RDS_MPATH_HASH

Valerio Setti (1):
      ASoC: meson: aiu-encoder-i2s: fix bit clock polarity

Vanillan Wang (1):
      USB: serial: option: add support for Rolling RW101R-GL

Vasiliy Kovalev (1):
      ovl: fix UAF in ovl_dentry_update_reval by moving dput() in ovl_link_up

Viacheslav Dubeyko (1):
      ceph: add checking of wait_for_completion_killable() return value

Vincent Mailhol (2):
      usb: deprecate the third argument of usb_maxpacket()
      Input: remove third argument of usb_maxpacket()

Wake Liu (2):
      selftests/net: Replace non-standard __WORDSIZE with sizeof(long) * 8
      selftests/net: Ensure assert() triggers in psock_tpacket.c

Wei Fang (1):
      net: fec: correct rx_bytes statistic for the case SHIFT16 is set

Wei Yang (1):
      fs/proc: fix uaf in proc_readdir_de()

William Wu (1):
      usb: gadget: f_hid: Fix zero length packet transfer

Xiang Mei (1):
      net/sched: sch_qfq: Fix null-deref in agg_dequeue

Xin Long (1):
      sctp: hold endpoint before calling cb in sctp_transport_lookup_process

Yafang Shao (1):
      net/cls_cgroup: Fix task_get_classid() during qdisc run

Yajun Deng (1):
      net: Use nlmsg_unicast() instead of netlink_unicast()

Yang Wang (1):
      drm/amd/pm: fix smu table id bound check issue in smu_cmn_update_table()

Yikang Yue (1):
      fs/hpfs: Fix error code for new_inode() failure in mkdir/create/mknod/symlink

Yongpeng Yang (1):
      exfat: check return value of sb_min_blocksize in exfat_read_boot_sector

Yue Haibing (1):
      ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled

Yuhao Jiang (1):
      ACPI: video: Fix use-after-free in acpi_video_switch_brightness()

Zhang Heng (1):
      HID: quirks: work around VID/PID conflict for 0x4c4a/0x4155

Zijun Hu (1):
      char: misc: Does not request module for miscdevice with dynamic minor

Zilin Guan (2):
      tracing: Fix memory leaks in create_field_var()
      mlxsw: spectrum: Fix memory leak in mlxsw_sp_flower_stats()

austinchang (1):
      btrfs: mark dirty extent range for out of bound prealloc extents

chuguangqing (1):
      fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock

raub camaioni (1):
      usb: gadget: f_ncm: Fix MAC assignment NCM ethernet


