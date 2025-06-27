Return-Path: <stable+bounces-158770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795F4AEB455
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2B13A48D1
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57B29DB9B;
	Fri, 27 Jun 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xwGwJeeZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30D29824B;
	Fri, 27 Jun 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019513; cv=none; b=pUAOwaMF1HNMkAzw1LPYqPHUlfpHyLpHuGEVmetVUtIhrTomRPz4XTFBVy4UNxr/gmKXagzUs7Bj9R3hrZoK2igQ+KKrv0HZZLj0zX3OVTsVPFGx6r+U+po0uiTQkdnVXU5Q+r+i/Boaw+SuEIIHf/9SMHwdIMbMxE2lXw1WIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019513; c=relaxed/simple;
	bh=B9GD3R6dFd/8GqQDo5pr6S1wWCesogI+RSC1KGia5ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rKFSOwsMIIS8vss3DGqvg5qqGK2dEJdS+jtBPvbDdOoc20X+XZX8VmMH64VaYVMtgdrHmtlyyEtLzQf4/V6mcDhl/2p7ys2R9ZArRPD6F6T67Bwzzu1QrGO0kihDXsDr9+PuK4Xjl3tDqu2xiob7G1n+KmC5gH+aXfCw5HeOR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xwGwJeeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9F3C4CEED;
	Fri, 27 Jun 2025 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751019513;
	bh=B9GD3R6dFd/8GqQDo5pr6S1wWCesogI+RSC1KGia5ac=;
	h=From:To:Cc:Subject:Date:From;
	b=xwGwJeeZLGSVQXKRVMpnlQeiLWad8NNDik5CtgrlvYU+n3sbU21EVyglDhVSgEf7V
	 erLGVfv3Ko95CiDdzjMXIEJBR40k7gwWIJRq+TKxf9U23BzzoxT57vw9jxudknjy+t
	 asNCX/nmpQ/S2aPt+jKvlOtuxzVXiR6l7uC+gJkY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.95
Date: Fri, 27 Jun 2025 11:18:18 +0100
Message-ID: <2025062719-cabdriver-duffel-bb88@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.95 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                              |    2 
 Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml                |   24 -
 Makefile                                                                     |    2 
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi                            |    2 
 arch/arm/mach-omap2/clockdomain.h                                            |    1 
 arch/arm/mach-omap2/clockdomains33xx_data.c                                  |    2 
 arch/arm/mach-omap2/cm33xx.c                                                 |   14 
 arch/arm/mach-omap2/pmic-cpcap.c                                             |    6 
 arch/arm/mm/ioremap.c                                                        |    4 
 arch/arm64/include/asm/tlbflush.h                                            |    9 
 arch/arm64/kernel/ptrace.c                                                   |    2 
 arch/arm64/mm/mmu.c                                                          |    3 
 arch/loongarch/include/asm/irqflags.h                                        |   16 
 arch/loongarch/mm/hugetlbpage.c                                              |    3 
 arch/mips/vdso/Makefile                                                      |    1 
 arch/parisc/boot/compressed/Makefile                                         |    1 
 arch/parisc/kernel/unaligned.c                                               |    2 
 arch/powerpc/include/asm/ppc_asm.h                                           |    2 
 arch/powerpc/kernel/eeh.c                                                    |    2 
 arch/powerpc/kernel/vdso/Makefile                                            |    2 
 arch/powerpc/platforms/pseries/msi.c                                         |    7 
 arch/riscv/kvm/vcpu_sbi_replace.c                                            |    8 
 arch/s390/kvm/gaccess.c                                                      |    8 
 arch/s390/pci/pci_mmio.c                                                     |    2 
 arch/x86/kernel/cpu/bugs.c                                                   |   10 
 arch/x86/kernel/cpu/sgx/main.c                                               |    2 
 arch/x86/kvm/svm/svm.c                                                       |    2 
 arch/x86/kvm/vmx/vmx.c                                                       |    5 
 drivers/acpi/acpica/dsutils.c                                                |    9 
 drivers/acpi/acpica/psobject.c                                               |   52 --
 drivers/acpi/acpica/utprint.c                                                |    7 
 drivers/acpi/battery.c                                                       |   19 
 drivers/acpi/bus.c                                                           |    6 
 drivers/ata/pata_via.c                                                       |    3 
 drivers/atm/atmtcp.c                                                         |    4 
 drivers/base/power/runtime.c                                                 |    2 
 drivers/base/swnode.c                                                        |    2 
 drivers/block/aoe/aoedev.c                                                   |    8 
 drivers/block/ublk_drv.c                                                     |    3 
 drivers/bus/fsl-mc/fsl-mc-uapi.c                                             |    4 
 drivers/bus/fsl-mc/mc-io.c                                                   |   19 
 drivers/bus/fsl-mc/mc-sys.c                                                  |    2 
 drivers/bus/mhi/ep/ring.c                                                    |   16 
 drivers/bus/mhi/host/pm.c                                                    |   18 
 drivers/bus/ti-sysc.c                                                        |   49 --
 drivers/clk/meson/g12a.c                                                     |    1 
 drivers/clk/rockchip/clk-rk3036.c                                            |    1 
 drivers/cpufreq/scmi-cpufreq.c                                               |   36 +
 drivers/cpufreq/tegra186-cpufreq.c                                           |    7 
 drivers/crypto/marvell/cesa/cesa.c                                           |    2 
 drivers/crypto/marvell/cesa/cesa.h                                           |    9 
 drivers/crypto/marvell/cesa/tdma.c                                           |   53 +-
 drivers/dma-buf/udmabuf.c                                                    |    5 
 drivers/edac/altera_edac.c                                                   |    6 
 drivers/edac/amd64_edac.c                                                    |    1 
 drivers/gpio/gpio-mlxbf3.c                                                   |   54 +-
 drivers/gpio/gpiolib-of.c                                                    |    9 
 drivers/gpu/drm/i915/i915_pmu.c                                              |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c                         |   14 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c                                   |    7 
 drivers/gpu/drm/nouveau/nouveau_backlight.c                                  |    2 
 drivers/hv/connection.c                                                      |   23 
 drivers/hwmon/ftsteutates.c                                                  |    9 
 drivers/hwmon/occ/common.c                                                   |  240 ++++------
 drivers/i2c/busses/i2c-designware-slave.c                                    |    2 
 drivers/i2c/busses/i2c-npcm7xx.c                                             |   12 
 drivers/i2c/busses/i2c-tegra.c                                               |    5 
 drivers/iio/accel/fxls8962af-core.c                                          |   15 
 drivers/iio/adc/ad7606_spi.c                                                 |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c                             |    8 
 drivers/infiniband/core/iwcm.c                                               |   29 -
 drivers/input/keyboard/gpio_keys.c                                           |    2 
 drivers/input/misc/ims-pcu.c                                                 |    6 
 drivers/input/misc/sparcspkr.c                                               |   22 
 drivers/iommu/amd/iommu.c                                                    |    8 
 drivers/md/dm-raid1.c                                                        |    5 
 drivers/md/dm-verity-fec.c                                                   |    4 
 drivers/md/dm-verity-target.c                                                |    8 
 drivers/md/dm-verity-verify-sig.c                                            |   17 
 drivers/media/common/videobuf2/videobuf2-dma-sg.c                            |    4 
 drivers/media/i2c/ccs-pll.c                                                  |   11 
 drivers/media/i2c/ds90ub913.c                                                |    4 
 drivers/media/i2c/ov5675.c                                                   |    5 
 drivers/media/i2c/ov8856.c                                                   |    9 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c |    2 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                               |   59 +-
 drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c                           |   14 
 drivers/media/platform/qcom/venus/core.c                                     |   16 
 drivers/media/platform/ti/davinci/vpif.c                                     |    4 
 drivers/media/platform/ti/omap3isp/ispccdc.c                                 |    8 
 drivers/media/platform/ti/omap3isp/ispstat.c                                 |    6 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                             |    2 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                             |    2 
 drivers/media/usb/dvb-usb/cxusb.c                                            |    3 
 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c                               |    7 
 drivers/media/usb/uvc/uvc_ctrl.c                                             |   23 
 drivers/media/usb/uvc/uvc_driver.c                                           |   27 -
 drivers/media/v4l2-core/v4l2-dev.c                                           |   14 
 drivers/mmc/core/card.h                                                      |    6 
 drivers/mmc/core/quirks.h                                                    |   10 
 drivers/mmc/core/sd.c                                                        |   32 +
 drivers/mtd/nand/raw/qcom_nandc.c                                            |    2 
 drivers/mtd/nand/raw/sunxi_nand.c                                            |    2 
 drivers/net/can/m_can/tcan4x5x-core.c                                        |    9 
 drivers/net/ethernet/aquantia/atlantic/aq_main.c                             |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c                              |    2 
 drivers/net/ethernet/cadence/macb_main.c                                     |    6 
 drivers/net/ethernet/cortina/gemini.c                                        |   37 +
 drivers/net/ethernet/dlink/dl2k.c                                            |   14 
 drivers/net/ethernet/dlink/dl2k.h                                            |    2 
 drivers/net/ethernet/emulex/benet/be_cmds.c                                  |    2 
 drivers/net/ethernet/faraday/Kconfig                                         |    1 
 drivers/net/ethernet/intel/e1000e/netdev.c                                   |   14 
 drivers/net/ethernet/intel/e1000e/ptp.c                                      |    8 
 drivers/net/ethernet/intel/i40e/i40e_common.c                                |    7 
 drivers/net/ethernet/intel/ice/ice_arfs.c                                    |   48 ++
 drivers/net/ethernet/intel/ice/ice_switch.c                                  |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c                           |    9 
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c                              |    1 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                              |   18 
 drivers/net/ethernet/microchip/lan743x_ethtool.c                             |   18 
 drivers/net/ethernet/microchip/lan743x_ptp.c                                 |    2 
 drivers/net/ethernet/microchip/lan743x_ptp.h                                 |    5 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                             |    3 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                                     |   24 -
 drivers/net/ethernet/vertexcom/mse102x.c                                     |   15 
 drivers/net/usb/asix.h                                                       |    1 
 drivers/net/usb/asix_common.c                                                |   22 
 drivers/net/usb/asix_devices.c                                               |   17 
 drivers/net/usb/ch9200.c                                                     |    7 
 drivers/net/vxlan/vxlan_core.c                                               |    8 
 drivers/net/wireless/ath/ath11k/ce.c                                         |   11 
 drivers/net/wireless/ath/ath11k/core.c                                       |   55 ++
 drivers/net/wireless/ath/ath11k/core.h                                       |    7 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                      |   25 -
 drivers/net/wireless/ath/ath11k/hal.c                                        |    4 
 drivers/net/wireless/ath/ath11k/qmi.c                                        |    9 
 drivers/net/wireless/ath/ath12k/ce.c                                         |   11 
 drivers/net/wireless/ath/ath12k/ce.h                                         |    6 
 drivers/net/wireless/ath/ath12k/dp_mon.c                                     |    2 
 drivers/net/wireless/ath/ath12k/hal.c                                        |    4 
 drivers/net/wireless/ath/ath12k/hal_desc.h                                   |    2 
 drivers/net/wireless/ath/ath12k/pci.c                                        |    3 
 drivers/net/wireless/ath/ath12k/wmi.c                                        |   20 
 drivers/net/wireless/ath/carl9170/usb.c                                      |   19 
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c                               |    3 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                              |    6 
 drivers/net/wireless/intersil/p54/fwio.c                                     |    2 
 drivers/net/wireless/intersil/p54/p54.h                                      |    1 
 drivers/net/wireless/intersil/p54/txrx.c                                     |   13 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                              |    2 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c                         |   13 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                             |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                              |    8 
 drivers/net/wireless/purelifi/plfxlc/usb.c                                   |    4 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                   |   10 
 drivers/net/wireless/realtek/rtw88/usb.c                                     |    2 
 drivers/net/wireless/realtek/rtw89/cam.c                                     |    3 
 drivers/net/wireless/realtek/rtw89/pci.c                                     |   69 ++
 drivers/net/wireless/realtek/rtw89/pci.h                                     |    1 
 drivers/net/wireless/virtual/mac80211_hwsim.c                                |    5 
 drivers/pci/controller/cadence/pcie-cadence-ep.c                             |    5 
 drivers/pci/controller/dwc/pcie-dw-rockchip.c                                |    2 
 drivers/pci/pci.c                                                            |    3 
 drivers/pci/quirks.c                                                         |   23 
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c                                   |   10 
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                                  |   21 
 drivers/pinctrl/pinctrl-mcp23s08.c                                           |    8 
 drivers/platform/loongarch/loongson-laptop.c                                 |   87 +--
 drivers/platform/x86/amd/pmc/pmc.c                                           |    2 
 drivers/platform/x86/dell/dell_rbu.c                                         |    6 
 drivers/platform/x86/ideapad-laptop.c                                        |    3 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c          |    9 
 drivers/power/supply/bq27xxx_battery.c                                       |    2 
 drivers/power/supply/bq27xxx_battery_i2c.c                                   |   13 
 drivers/power/supply/collie_battery.c                                        |    1 
 drivers/ptp/ptp_clock.c                                                      |    3 
 drivers/ptp/ptp_private.h                                                    |   22 
 drivers/rapidio/rio_cm.c                                                     |    3 
 drivers/regulator/max14577-regulator.c                                       |    5 
 drivers/regulator/max20086-regulator.c                                       |    4 
 drivers/remoteproc/remoteproc_core.c                                         |    6 
 drivers/s390/scsi/zfcp_sysfs.c                                               |    2 
 drivers/scsi/elx/efct/efct_hw.c                                              |    5 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                             |    2 
 drivers/scsi/lpfc/lpfc_sli.c                                                 |    4 
 drivers/scsi/storvsc_drv.c                                                   |   10 
 drivers/staging/iio/impedance-analyzer/ad5933.c                              |    2 
 drivers/tee/tee_core.c                                                       |   11 
 drivers/tty/serial/sh-sci.c                                                  |   16 
 drivers/uio/uio_hv_generic.c                                                 |    4 
 drivers/video/console/vgacon.c                                               |    2 
 drivers/video/fbdev/core/fbcon.c                                             |    7 
 drivers/video/fbdev/core/fbmem.c                                             |   22 
 drivers/video/screen_info_pci.c                                              |   79 ++-
 drivers/watchdog/da9052_wdt.c                                                |    1 
 fs/ceph/super.c                                                              |    1 
 fs/configfs/dir.c                                                            |    2 
 fs/ext4/ext4.h                                                               |    7 
 fs/ext4/extents.c                                                            |   18 
 fs/ext4/file.c                                                               |    7 
 fs/ext4/inline.c                                                             |    2 
 fs/ext4/inode.c                                                              |   10 
 fs/f2fs/compress.c                                                           |   23 
 fs/f2fs/f2fs.h                                                               |    5 
 fs/f2fs/inode.c                                                              |   10 
 fs/f2fs/namei.c                                                              |    9 
 fs/f2fs/segment.c                                                            |    6 
 fs/f2fs/super.c                                                              |   12 
 fs/gfs2/lock_dlm.c                                                           |    3 
 fs/jbd2/transaction.c                                                        |    5 
 fs/jffs2/erase.c                                                             |    4 
 fs/jffs2/scan.c                                                              |    4 
 fs/jffs2/summary.c                                                           |    7 
 fs/nfs/read.c                                                                |    3 
 fs/nfsd/nfs4proc.c                                                           |    3 
 fs/nfsd/nfssvc.c                                                             |    6 
 fs/smb/client/cached_dir.c                                                   |   14 
 fs/smb/client/cached_dir.h                                                   |    8 
 fs/smb/client/cifsglob.h                                                     |    1 
 fs/smb/client/connect.c                                                      |   17 
 fs/smb/client/namespace.c                                                    |    3 
 fs/smb/client/readdir.c                                                      |   28 -
 fs/smb/client/reparse.c                                                      |    1 
 fs/smb/client/sess.c                                                         |    7 
 fs/smb/client/smb2pdu.c                                                      |   33 -
 fs/smb/client/transport.c                                                    |   14 
 fs/smb/server/smb2pdu.c                                                      |   11 
 fs/xattr.c                                                                   |    1 
 include/acpi/actypes.h                                                       |    2 
 include/linux/acpi.h                                                         |    9 
 include/linux/atmdev.h                                                       |    6 
 include/linux/hugetlb.h                                                      |    3 
 include/linux/mmc/card.h                                                     |    1 
 include/linux/netdevice.h                                                    |    3 
 include/net/checksum.h                                                       |    2 
 include/trace/events/erofs.h                                                 |   18 
 include/uapi/linux/bpf.h                                                     |    2 
 io_uring/io-wq.c                                                             |    4 
 io_uring/io_uring.c                                                          |    2 
 io_uring/kbuf.c                                                              |    2 
 ipc/shm.c                                                                    |    5 
 kernel/bpf/helpers.c                                                         |    3 
 kernel/cgroup/legacy_freezer.c                                               |    3 
 kernel/events/core.c                                                         |   80 ++-
 kernel/exit.c                                                                |   17 
 kernel/time/clocksource.c                                                    |    2 
 kernel/trace/ftrace.c                                                        |   10 
 kernel/watchdog.c                                                            |   41 +
 lib/Kconfig                                                                  |    1 
 mm/huge_memory.c                                                             |   11 
 mm/hugetlb.c                                                                 |   67 ++
 mm/mmap.c                                                                    |    6 
 mm/page-writeback.c                                                          |    2 
 net/atm/common.c                                                             |    1 
 net/atm/lec.c                                                                |   12 
 net/atm/raw.c                                                                |    2 
 net/bridge/br_mst.c                                                          |    4 
 net/bridge/br_multicast.c                                                    |  103 +++-
 net/bridge/br_private.h                                                      |   11 
 net/core/filter.c                                                            |   24 -
 net/core/skmsg.c                                                             |    3 
 net/core/sock.c                                                              |    4 
 net/core/utils.c                                                             |    4 
 net/ipv4/route.c                                                             |    4 
 net/ipv4/tcp_fastopen.c                                                      |    3 
 net/ipv4/tcp_input.c                                                         |   63 +-
 net/ipv6/calipso.c                                                           |    8 
 net/ipv6/ila/ila_common.c                                                    |    6 
 net/mac80211/mesh_hwmp.c                                                     |    6 
 net/mac80211/tx.c                                                            |    6 
 net/mpls/af_mpls.c                                                           |    4 
 net/nfc/nci/uart.c                                                           |    8 
 net/sched/sch_sfq.c                                                          |   10 
 net/sched/sch_taprio.c                                                       |    6 
 net/sctp/socket.c                                                            |    3 
 net/sunrpc/svc.c                                                             |   11 
 net/sunrpc/xprtsock.c                                                        |    5 
 net/tipc/crypto.c                                                            |    2 
 net/tipc/udp_media.c                                                         |    4 
 net/wireless/core.c                                                          |    6 
 security/selinux/xfrm.c                                                      |    2 
 sound/pci/hda/hda_intel.c                                                    |    2 
 sound/pci/hda/patch_realtek.c                                                |    1 
 sound/soc/amd/yc/acp6x-mach.c                                                |    9 
 sound/soc/codecs/tas2770.c                                                   |   30 +
 sound/soc/meson/meson-card-utils.c                                           |    2 
 sound/soc/qcom/sdm845.c                                                      |    4 
 sound/soc/tegra/tegra210_ahub.c                                              |    2 
 sound/usb/mixer_maps.c                                                       |   12 
 tools/include/uapi/linux/bpf.h                                               |    2 
 tools/lib/bpf/btf.c                                                          |   16 
 tools/perf/util/print-events.c                                               |    1 
 tools/testing/selftests/x86/Makefile                                         |    2 
 tools/testing/selftests/x86/sigtrap_loop.c                                   |  101 ++++
 295 files changed, 2321 insertions(+), 1077 deletions(-)

Aditya Kumar Singh (1):
      wifi: ath12k: fix failed to set mhi state error during reboot with hardware grouping

Ahmed Salem (1):
      ACPICA: Avoid sequence overread in call to strncmp()

Akhil R (2):
      i2c: tegra: check msg length in SMBUS block read
      dt-bindings: i2c: nvidia,tegra20-i2c: Specify the required properties

Alan Maguire (1):
      libbpf: Add identical pointer detection to btf_dedup_is_equiv()

Alexander Aring (1):
      gfs2: move msleep to sleepable context

Alexander Sverdlin (1):
      Revert "bus: ti-sysc: Probe for l4_wkup and l4_cfg interconnect devices first"

Alexey Kodanev (1):
      net: lan743x: fix potential out-of-bounds write in lan743x_ptp_io_event_clock_get()

Alok Tiwari (1):
      emulex/benet: correct command version selection in be_cmd_get_stats()

Andreas Kemnade (1):
      ARM: omap: pmic-cpcap: do not mess around without CPCAP or OMAP4

Andrew Morton (1):
      drivers/rapidio/rio_cm.c: prevent possible heap overwrite

Andrew Zaborowski (1):
      x86/sgx: Prevent attempts to reclaim poisoned pages

Anup Patel (2):
      RISC-V: KVM: Fix the size parameter check in SBI SFENCE calls
      RISC-V: KVM: Don't treat SBI HFENCE calls as NOPs

Armin Wolf (1):
      ACPI: bus: Bail out if acpi_kobj registration fails

Arnd Bergmann (3):
      parisc: fix building with gcc-15
      hwmon: (occ) Rework attribute registration for stack usage
      hwmon: (occ) fix unaligned accesses

Artem Sadovnikov (1):
      jffs2: check that raw node were preallocated before writing summary

Avadhut Naik (1):
      EDAC/amd64: Correct number of UMCs for family 19h models 70h-7fh

Balamurugan S (1):
      wifi: ath12k: fix incorrect CE addresses

Baochen Qiang (2):
      wifi: ath12k: fix a possible dead lock caused by ab->base_lock
      wifi: ath11k: determine PM policy based on machine model

Benjamin Berg (1):
      wifi: mac80211: do not offer a mesh path if forwarding is disabled

Benjamin Lin (1):
      wifi: mt76: mt7996: drop fragments with multicast or broadcast RA

Bharath SM (2):
      smb: improve directory cache reuse for readdir operations
      smb: fix secondary channel creation issue with kerberos by populating hostname when adding channels

Bitterblue Smith (1):
      wifi: rtw88: usb: Reduce control message timeout to 500 ms

Breno Leitao (1):
      Revert "x86/bugs: Make spectre user default depend on MITIGATION_SPECTRE_V2" on v6.6 and older

Brett Creeley (1):
      ionic: Prevent driver/fw getting out of sync on devcmd(s)

Brett Werling (1):
      can: tcan4x5x: fix power regulator retrieval during probe

Brian Foster (1):
      ext4: only dirty folios when data journaling regular files

Chao Gao (1):
      KVM: VMX: Flush shadow VMCS on emergency reboot

Chao Yu (4):
      f2fs: fix to do sanity check on ino and xnid
      f2fs: fix to do sanity check on sit_bitmap_size
      f2fs: use vmalloc instead of kvmalloc in .init_{,de}compress_ctx
      f2fs: fix to set atomic write status more clear

Charan Teja Kalla (1):
      PM: runtime: fix denying of auto suspend in pm_suspend_timer_fn()

Chen Ridong (1):
      cgroup,freezer: fix incomplete freezing when attaching tasks

Chin-Yen Lee (1):
      wifi: rtw89: pci: use DBI function for 8852AE/8852BE/8851BE

Christian Lamparter (1):
      wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()

Christophe Leroy (1):
      powerpc/vdso: Fix build of VDSO32 with pcrel

Chuck Lever (1):
      SUNRPC: Prevent hang on NFS mount with xprtsec=[m]tls

Claudiu Beznea (1):
      serial: sh-sci: Increment the runtime usage counter for the earlycon device

Colin Foster (1):
      ARM: dts: am335x-bone-common: Increase MDIO reset deassert time

Da Xue (1):
      clk: meson-g12a: add missing fclk_div2 to spicc

Dan Carpenter (1):
      Input: ims-pcu - check record size in ims_pcu_flash_firmware()

Daniel Wagner (1):
      scsi: lpfc: Use memcpy() for BIOS version

David Lechner (1):
      iio: adc: ad7606_spi: fix reg write value mask

David Thompson (1):
      gpio: mlxbf3: only get IRQ for device instance 0

David Wei (1):
      tcp: fix passive TFO socket having invalid NAPI ID

Denis Arefev (1):
      media: vivid: Change the siize of the composing

Dennis Marttinen (1):
      ceph: set superblock s_magic for IMA fsmagic matching

Dev Jain (1):
      arm64: Restrict pagetable teardown to avoid false warning

Dexuan Cui (1):
      scsi: storvsc: Increase the timeouts to storvsc_timeout

Dian-Syuan Yang (1):
      wifi: rtw89: leave idle mode when setting WEP encryption for AP mode

Diederik de Haas (1):
      PCI: dw-rockchip: Fix PHY function call sequence in rockchip_pcie_phy_deinit()

Dmitry Antipov (1):
      wifi: carl9170: do not ping device which has failed to load firmware

Dmitry Nikiforov (1):
      media: davinci: vpif: Fix memory leak in probe error path

Edward Adam Davis (4):
      media: cxusb: no longer judge rbuf when the write fails
      media: vidtv: Terminating the subsequent process of initialization failure
      wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled
      wifi: cfg80211: init wiphy_work before allocating rfkill fails

Eric Dumazet (5):
      tcp: always seek for minimal rtt in tcp_rcv_rtt_update()
      tcp: fix initial tp->rcvq_space.space value for passive TS enabled flows
      net_sched: sch_sfq: reject invalid perturb period
      net: atm: add lec_mutex
      net: atm: fix /proc/net/atm/lec handling

Erick Shepherd (1):
      mmc: Add quirk to disable DDR50 tuning

Fedor Pchelkin (1):
      jffs2: check jffs2_prealloc_raw_node_refs() result in few other places

Fei Shao (1):
      media: mediatek: vcodec: Correct vsi_core framebuffer size

GONG Ruiqi (1):
      vgacon: Add check for vc_origin address range in vgacon_scroll()

Gabor Juhos (4):
      pinctrl: armada-37xx: propagate error from armada_37xx_pmx_set_by_name()
      pinctrl: armada-37xx: propagate error from armada_37xx_gpio_get_direction()
      pinctrl: armada-37xx: propagate error from armada_37xx_pmx_gpio_set_direction()
      pinctrl: armada-37xx: propagate error from armada_37xx_gpio_get()

Gabriel Shahrouzi (1):
      staging: iio: ad5933: Correct settling cycles encoding per datasheet

Gao Xiang (1):
      erofs: remove unused trace event erofs_destroy_inode

Gatien Chevallier (1):
      Input: gpio-keys - fix possible concurrent access in gpio_keys_irq_timer()

Gautam Menghani (1):
      powerpc/pseries/msi: Avoid reading PCI device registers in reduced power states

Gavin Guo (1):
      mm/huge_memory: fix dereferencing invalid pmd migration entry

Geert Uytterhoeven (1):
      ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms

Greg Kroah-Hartman (1):
      Linux 6.6.95

Gui-Dong Han (1):
      hwmon: (ftsteutates) Fix TOCTOU race in fts_read()

Guilherme G. Piccoli (1):
      clocksource: Fix the CPUs' choice in the watchdog per CPU verification

Haixia Qu (1):
      tipc: fix null-ptr-deref when acquiring remote ip of ethernet bearer

Hari Chandrakanthan (1):
      wifi: ath12k: fix link valid field initialization in the monitor Rx

Hector Martin (1):
      ASoC: tas2770: Power cycle amp on ISENSE/VSENSE change

Heiko Carstens (1):
      s390/pci: Fix __pcilg_mio_inuser() inline assembly

Heiko Stuebner (1):
      clk: rockchip: rk3036: mark ddrphy as critical

Heiner Kallweit (1):
      net: ftgmac100: select FIXED_PHY

Helge Deller (1):
      parisc/unaligned: Fix hex output to show 8 hex chars

Henk Vergonet (1):
      wifi: mt76: mt76x2: Add support for LiteOn WN4516R,WN4519R

Herbert Xu (1):
      crypto: marvell/cesa - Do not chain submitted requests

Hou Tao (1):
      bpf: Check rcu_read_lock_trace_held() in bpf_map_lookup_percpu_elem()

Huacai Chen (2):
      PCI: Add ACS quirk for Loongson PCIe
      LoongArch: Avoid using $r0/$r1 as "mask" for csrxchg

Hyunwoo Kim (1):
      net/sched: fix use-after-free in taprio_dev_notifier

Ian Rogers (1):
      perf evsel: Missed close() when probing hybrid core PMUs

Ido Schimmel (1):
      vxlan: Do not treat dst cache initialization errors as fatal

Ilpo Järvinen (1):
      PCI: Fix lock symmetry in pci_slot_unlock()

Ioana Ciornei (1):
      bus: fsl-mc: do not add a device-link for the UAPI used DPMCP device

Jacob Keller (1):
      drm/nouveau/bl: increase buffer size to avoid truncate warning

Jaegeuk Kim (1):
      f2fs: prevent kernel warning due to negative i_nlink from corrupted image

Jakub Kicinski (2):
      net: clear the dst when changing skb protocol
      net: make for_each_netdev_dump() a little more bug-proof

James A. MacInnes (1):
      drm/msm/disp: Correct porch timing for SDM845

Jan Kara (1):
      ext4: fix calculation of credits for extent tree modification

Jann Horn (3):
      mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race
      tee: Prevent size calculation wraparound on 32-bit kernels
      mm/hugetlb: unshare page tables during VMA split, not before

Jason Xing (2):
      net: atlantic: generate software timestamp just before the doorbell
      net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag when getting ts info

Jeff Hugo (1):
      bus: mhi: host: Fix conflict between power_up and SYSERR

Jeff Layton (1):
      sunrpc: handle SVC_GARBAGE during svc auth processing as auth error

Jeongjun Park (2):
      jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
      ipc: fix to protect IPCS lookups using RCU

Jerry Lv (1):
      power: supply: bq27xxx: Retrieve again when busy

Jiayuan Chen (1):
      bpf, sockmap: Fix data lost during EAGAIN retries

Jinliang Zheng (1):
      mm: fix ratelimit_pages update error in dirty_ratio_handler()

Johan Hovold (5):
      wifi: ath11k: fix rx completion meta data corruption
      wifi: ath11k: fix ring-buffer corruption
      wifi: ath12k: fix ring-buffer corruption
      media: ov8856: suppress probe deferral errors
      media: ov5675: suppress probe deferral errors

Jon Hunter (1):
      Revert "cpufreq: tegra186: Share policy per cluster"

Jonathan Lane (1):
      ALSA: hda/realtek: enable headset mic on Latitude 5420 Rugged

João Paulo Gonçalves (2):
      regulator: max20086: Fix MAX200086 chip id
      regulator: max20086: Change enable gpio to optional

Justin Sanders (1):
      aoe: clean device rq_list in aoedev_downdev()

Justin Tee (1):
      scsi: lpfc: Fix lpfc_check_sli_ndlp() handling for GEN_REQUEST64 commands

Kang Yang (1):
      wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET

Kees Cook (1):
      fbcon: Make sure modelist not set on unregistered console

Khem Raj (1):
      mips: Add -std= flag specified in KBUILD_CFLAGS to vdso CFLAGS

Krishna Kumar (1):
      net: ice: Perform accurate aRFS flow match

Krzysztof Hałasa (1):
      usbnet: asix AX88772: leave the carrier control to phylink

Krzysztof Kozlowski (3):
      NFC: nci: uart: Set tty->disc_data only in success path
      power: supply: collie: Fix wakeup source leaks on device unbind
      drm/msm/dsi/dsi_phy_10nm: Fix missing initial VCO rate

Kuniyuki Iwashima (4):
      atm: Revert atm_account_tx() if copy_from_iter_full() fails.
      mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
      atm: atmtcp: Free invalid length skb in atmtcp_c_send().
      calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().

Kyungwook Boo (1):
      i40e: fix MMIO write access to an invalid page in i40e_clear_hw

Laurentiu Palcu (1):
      media: nxp: imx8-isi: better handle the m2m usage_count

Laurentiu Tudor (1):
      bus: fsl-mc: increase MC_CMD_COMPLETION_TIMEOUT_MS value

Li Lingfeng (1):
      nfsd: Initialize ssc before laundromat_work to prevent NULL dereference

Linus Walleij (1):
      net: ethernet: cortina: Use TOE/TSO on all TCP

Loic Poulain (1):
      media: venus: Fix probe error handling

Long Li (2):
      Drivers: hv: Allocate interrupt and monitor pages aligned to system page boundary
      uio_hv_generic: Use correct size for interrupt and monitor pages

Lorenzo Stoakes (1):
      KVM: s390: rename PROT_NONE to PROT_TYPE_DUMMY

Luo Gengkun (2):
      watchdog: fix watchdog may detect false positive of softlockup
      perf/core: Fix WARN in perf_cgroup_switch()

Ma Ke (1):
      media: v4l2-dev: fix error handling in __video_register_device()

Marcus Folkesson (1):
      watchdog: da9052_wdt: respect TWDMIN

Marek Szyprowski (3):
      media: omap3isp: use sgtable-based scatterlist wrappers
      media: videobuf2: use sgtable-based scatterlist wrappers
      udmabuf: use sgtable-based scatterlist wrappers

Mario Limonciello (2):
      ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
      platform/x86/amd: pmc: Clear metrics table at start of cycle

Martin Blumenstingl (1):
      ASoC: meson: meson-card-utils: use of_property_present() for DT parsing

Mateusz Pacuszka (1):
      ice: fix check for existing switch rule

Max Kellermann (1):
      fs/nfs/read: fix double-unlock bug in nfs_return_empty_folio()

Md Sadre Alam (1):
      mtd: rawnand: qcom: Fix read len for onfi param page

Michael Walle (1):
      net: ethernet: ti: am65-cpsw: handle -EPROBE_DEFER

Mike Looijmans (1):
      pinctrl: mcp23s08: Reset all pins to input at probe

Mike Tipton (1):
      cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs

Mikulas Patocka (2):
      dm-mirror: fix a tiny race condition
      dm-verity: fix a memory leak if some arguments are specified multiple times

Ming Qian (4):
      media: imx-jpeg: Drop the first error frames
      media: imx-jpeg: Move mxc_jpeg_free_slot_data() ahead
      media: imx-jpeg: Reset slot data pointers when freed
      media: imx-jpeg: Cleanup after an allocation error

Mingcong Bai (1):
      wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723

Miri Korenblit (1):
      wifi: iwlwifi: pcie: make sure to lock rxq->read

Moon Yeounsu (1):
      net: dlink: add synchronization for stats update

Muhammad Usama Anjum (1):
      wifi: ath11k: Fix QMI memory reuse logic

Muna Sinada (1):
      wifi: mac80211: VLAN traffic in multicast path

Murad Masimov (2):
      fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var
      fbdev: Fix fb_set_var to prevent null-ptr-deref in fb_videomode_to_var

Namjae Jeon (1):
      ksmbd: fix null pointer dereference in destroy_previous_session

Narayana Murty N (1):
      powerpc/eeh: Fix missing PE bridge reconfiguration during VFIO EEH recovery

Neal Cardwell (1):
      tcp: fix tcp_packet_delayed() for tcp_is_non_sack_preventing_reopen() behavior

NeilBrown (1):
      nfsd: nfsd4_spo_must_allow() must check this is a v4 compound request

Niklas Cassel (1):
      PCI: cadence-ep: Correct PBA offset in .set_msix() callback

Niravkumar L Rabara (1):
      EDAC/altera: Use correct write width with the INTTEST register

Pali Rohár (1):
      cifs: Remove duplicate fattr->cf_dtype assignment from wsl_to_fattr() function

Paul Aurich (1):
      smb: Log an error when close_all_cached_dirs fails

Paul Chaignon (2):
      net: Fix checksum update for ILA adj-transport
      bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE

Pavel Begunkov (2):
      io_uring: account drain memory to cgroup
      io_uring/kbuf: account ring io_buffer_list memory

Peng Fan (1):
      gpiolib: of: Add polarity quirk for s5m8767

Penglei Jiang (1):
      io_uring: fix task leak issue in io_wq_create()

Peter Marheine (1):
      ACPI: battery: negate current when discharging

Peter Oberparleiter (1):
      scsi: s390: zfcp: Ensure synchronous unit_add

Peter Zijlstra (2):
      perf: Fix sample vs do_exit()
      perf: Fix cgroup state vs ERROR

Petr Malat (1):
      sctp: Do not wake readers in __sctp_write_space()

Qasim Ijaz (1):
      net: ch9200: fix uninitialised access during mii_nway_restart

Renato Caldas (1):
      platform/x86: ideapad-laptop: add missing Ideapad Pro 5 fn keys

Rengarajan S (2):
      net: lan743x: Modify the EEPROM and OTP size for PCI1xxxx devices
      net: microchip: lan743x: Reduce PTP timeout on HW failure

Ricardo Ribalda (3):
      media: uvcvideo: Return the number of processed controls
      media: uvcvideo: Send control events for partial succeeds
      media: uvcvideo: Fix deferred probing error

Ronnie Sahlberg (1):
      ublk: santizize the arguments from userspace when adding a device

Ross Stutterheim (1):
      ARM: 9447/1: arm/memremap: fix arch_memremap_can_ram_remap()

Ruben Devos (1):
      smb: client: add NULL check in automount_fullpath

Ryan Roberts (1):
      arm64/mm: Close theoretical race where stale TLB entry remains valid

Sakari Ailus (4):
      media: ccs-pll: Start VT pre-PLL multiplier search from correct value
      media: ccs-pll: Start OP pre-PLL multiplier search from correct value
      media: ccs-pll: Correct the upper limit of maximum op_pre_pll_clk_div
      media: ccs-pll: Check for too high VT PLL multiplier in dual PLL case

Salah Triki (1):
      wireless: purelifi: plfxlc: fix memory leak in plfxlc_usb_wreq_asyn()

Samuel Williams (1):
      wifi: mt76: mt7921: add 160 MHz AP for mt7922 device

Sean Christopherson (1):
      iommu/amd: Ensure GA log notifier callbacks finish running before module unload

Sean Nyekjaer (3):
      iio: accel: fxls8962af: Fix temperature scan element sign
      iio: imu: inv_icm42600: Fix temperature calculation
      iio: accel: fxls8962af: Fix temperature calculation

Sebastian Andrzej Siewior (1):
      ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT

Sergio Perez Gonzalez (1):
      net: macb: Check return value of dma_set_mask_and_coherent()

Seunghun Han (2):
      ACPICA: fix acpi operand cache leak in dswstate.c
      ACPICA: fix acpi parse and parseext cache leaks

Shin'ichiro Kawasaki (1):
      RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction

Shyam Prasad N (6):
      cifs: reset connections for all channels when reconnect requested
      cifs: update dstaddr whenever channel iface is updated
      cifs: dns resolution is needed only for primary channel
      cifs: deal with the channel loading lag while picking channels
      cifs: serialize other channels when query server interfaces is pending
      cifs: do not disable interface polling on failure

Simon Horman (1):
      pldmfw: Select CRC32 when PLDMFW is selected

Srinivas Pandruvada (1):
      platform/x86/intel-uncore-freq: Fail module load when plat_info is NULL

Stefan Wahren (1):
      net: vertexcom: mse102x: Return code for mse102x_rx_pkt_spi

Stephen Smalley (2):
      fs/xattr.c: fix simple_xattr_list()
      selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len

Stuart Hayes (2):
      platform/x86: dell_rbu: Fix list usage
      platform/x86: dell_rbu: Stop overwriting data buffer

Sukrut Bellary (1):
      ARM: OMAP2+: Fix l4ls clk domain handling in STANDBY

Sumit Kumar (1):
      bus: mhi: ep: Update read pointer only after buffer is written

Suraj P Kizhakkethil (1):
      wifi: ath12k: Pass correct values of center freq1 and center freq2 for 160 MHz

Takashi Iwai (1):
      ALSA: hda/intel: Add Thinkpad E15 to PM deny list

Talhah Peerbhai (1):
      ASoC: amd: yc: Add quirk for Lenovo Yoga Pro 7 14ASP9

Tali Perry (1):
      i2c: npcm: Add clock toggle recovery

Tan En De (1):
      i2c: designware: Invoke runtime suspend on quick slave re-registration

Tasos Sahanidis (1):
      ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330

Tengda Wu (1):
      arm64/ptrace: Fix stack-out-of-bounds read in regs_get_kernel_stack_nth()

Thadeu Lima de Souza Cascardo (1):
      ext4: inline: fix len overflow in ext4_prepare_inline_data

Thomas Zimmermann (1):
      video: screen_info: Relocate framebuffers behind PCI bridges

Tianyang Zhang (1):
      LoongArch: Fix panic caused by NULL-PMD in huge_pte_offset()

Tomi Valkeinen (1):
      media: i2c: ds90ub913: Fix returned fmt from .set_fmt()

Tzung-Bi Shih (1):
      drm/i915/pmu: Fix build error with GCOV and AutoFDO enabled

Vitaliy Shevtsov (1):
      scsi: elx: efct: Fix memory leak in efct_hw_parse_filter()

Vitaly Lifshits (1):
      e1000e: set fixed clock frequency indication for Nahum 11 and Nahum 13

Vladimir Oltean (2):
      ptp: fix breakage after ptp_vclock_in_use() rework
      ptp: allow reading of currently dialed frequency to succeed on free-running clocks

Víctor Gonzalo (1):
      wifi: iwlwifi: Add missing MODULE_FIRMWARE for Qu-c0-jf-b0

Wan Junjie (1):
      bus: fsl-mc: fix GET/SET_TAILDROP command ids

WangYuli (1):
      Input: sparcspkr - avoid unannotated fall-through

Wentao Liang (8):
      ASoC: qcom: sdm845: Add error handling in sdm845_slim_snd_hw_params()
      net/mlx5_core: Add error handling inmlx5_query_nic_vport_qkey_viol_cntr()
      net/mlx5: Add error handling in mlx5_query_nic_vport_node_guid()
      media: gspca: Add error handling for stv06xx_read_sensor()
      mtd: rawnand: sunxi: Add randomizer configuration in sunxi_nfc_hw_ecc_write_chunk
      mtd: nand: sunxi: Add randomizer configuration before randomizer enable
      regulator: max14577: Add error check for max14577_read_reg()
      octeontx2-pf: Add error log forcn10k_map_unmap_rq_policer()

Xiaolei Wang (2):
      remoteproc: core: Cleanup acquired resources when rproc_handle_resources() fails in rproc_attach()
      remoteproc: core: Release rproc->clean_table after rproc_attach() fails

Xin Li (Intel) (1):
      selftests/x86: Add a test to detect infinite SIGTRAP handler loop

Xu Yang (1):
      phy: fsl-imx8mq-usb: fix phy_tx_vboost_level_from_property()

Yao Zi (3):
      platform/loongarch: laptop: Get brightness setting from EC on probe
      platform/loongarch: laptop: Unregister generic_sub_drivers on exit
      platform/loongarch: laptop: Add backlight power control support

Ye Bin (1):
      ftrace: Fix UAF when lookup kallsym after ftrace disabled

Yong Wang (2):
      net: bridge: mcast: update multicast contex when vlan state is changed
      net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions

Yosry Ahmed (1):
      KVM: SVM: Clear current_vmcb during vCPU free for all *possible* CPUs

Yuanjun Gong (1):
      ASoC: tegra210_ahub: Add check to of_device_get_match_data()

Zhang Yi (2):
      ext4: factor out ext4_get_maxbytes()
      ext4: ensure i_size is smaller than maxbytes

Zijun Hu (3):
      configfs: Do not override creating attribute file failure in populate_attrs()
      software node: Correct a OOB check in software_node_get_reference_args()
      sock: Correct error checking condition for (assign|release)_proto_idx()

Zilin Guan (1):
      tipc: use kfree_sensitive() for aead cleanup

gldrk (1):
      ACPICA: utilities: Fix overflow check in vsnprintf()

wangdicheng (1):
      ALSA: usb-audio: Rename ALSA kcontrol PCM and PCM1 for the KTMicro sound card

zhangjian (1):
      smb: client: fix first command failure during re-negotiation


