Return-Path: <stable+bounces-214679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGCWCTcZhmktJwQAu9opvQ
	(envelope-from <stable+bounces-214679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:39:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 959DD1006A7
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38316303DADC
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7F329E64;
	Fri,  6 Feb 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbyhgFXK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BEA3242BA;
	Fri,  6 Feb 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395274; cv=none; b=alRViKbhqBGvwzubuaJad5bt6uVZOFUxUADkYd96ZHzhcwEl+t3PaggyUoLmxOH2klN/kTcsNiDrgYpid83eYyaTeUJl5Sj+AXYFyU9nftzWHH15l59aBQ99YqYZosM8dPe737ec3SO8p+vCdthTq5pYwaw4B/+GygFMw1Ozrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395274; c=relaxed/simple;
	bh=64tqZDYwp0a5NMLNIJzMZFdkl3LsBU4ia1Oo67J66+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f3VTVaUuYt7HIsAE+EQW6qRLXjgev7EYgSbm6goAK6JFYZQiDtewb8bwFrkSifpnaWp+Knd0+TV0oPMGoeU1mcrRpOuMFWZyVIx1OO4flC2b8R20Yv7L663wYxB4zCkrvJ2NZLxw/CP7aKkedPuhxmCwh0a1KL1v/MaKK/RZySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbyhgFXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC50C116C6;
	Fri,  6 Feb 2026 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770395274;
	bh=64tqZDYwp0a5NMLNIJzMZFdkl3LsBU4ia1Oo67J66+g=;
	h=From:To:Cc:Subject:Date:From;
	b=WbyhgFXKIDHNGm/xfsnGMGJD0NiNnkuSsI5rOQz4BB7Spk1O9iqAH0BHDz1pYVtJ4
	 2o3nxTQ0CfiJTuF+qvpjytoQEdYGl2VIdkraLs43iQXzvSyF6efX1IicOiBkUTtPWI
	 8oErsvm+ZYCsPdsCY/0pGFE0j64Mnhl86hms6WIA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.162
Date: Fri,  6 Feb 2026 17:27:33 +0100
Message-ID: <2026020634-dander-challenge-0143@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214679-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iloc.bh:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 959DD1006A7
X-Rspamd-Action: no action

I'm announcing the release of the 6.1.162 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                |    3 
 Documentation/netlink/specs/fou.yaml                           |  130 
 Makefile                                                       |    2 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                         |   16 
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts         |    1 
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts             |    1 
 arch/arm64/kernel/hibernate.c                                  |    2 
 arch/arm64/kernel/signal.c                                     |   26 
 arch/loongarch/kernel/perf_event.c                             |   21 
 arch/riscv/include/asm/compat.h                                |    2 
 arch/x86/events/perf_event.h                                   |   13 
 arch/x86/include/asm/kfence.h                                  |   29 
 arch/x86/kernel/cpu/resctrl/core.c                             |   21 
 arch/x86/kernel/cpu/resctrl/internal.h                         |    3 
 arch/x86/kernel/fpu/core.c                                     |   32 
 arch/x86/kvm/x86.c                                             |    9 
 arch/x86/mm/fault.c                                            |   15 
 arch/x86/mm/kaslr.c                                            |   10 
 block/blk-cgroup.c                                             |    4 
 crypto/authencesn.c                                            |    6 
 drivers/ata/libata-core.c                                      |   62 
 drivers/ata/libata-scsi.c                                      |   30 
 drivers/base/regmap/regmap.c                                   |    4 
 drivers/block/xen-blkback/xenbus.c                             |    4 
 drivers/block/xen-blkfront.c                                   |    3 
 drivers/bluetooth/hci_ldisc.c                                  |    4 
 drivers/char/tpm/xen-tpmfront.c                                |    3 
 drivers/clocksource/timer-riscv.c                              |    3 
 drivers/comedi/comedi_fops.c                                   |    2 
 drivers/comedi/drivers/dmm32at.c                               |   32 
 drivers/comedi/range.c                                         |    2 
 drivers/crypto/qat/qat_common/adf_common_drv.h                 |    1 
 drivers/crypto/qat/qat_common/adf_init.c                       |    1 
 drivers/crypto/qat/qat_common/adf_isr.c                        |    5 
 drivers/dma/apple-admac.c                                      |    1 
 drivers/dma/at_hdmac.c                                         |    9 
 drivers/dma/bcm-sba-raid.c                                     |    6 
 drivers/dma/dw/rzn1-dmamux.c                                   |    4 
 drivers/dma/idxd/compat.c                                      |   23 
 drivers/dma/lpc18xx-dmamux.c                                   |   19 
 drivers/dma/qcom/gpi.c                                         |    6 
 drivers/dma/sh/rz-dmac.c                                       |    5 
 drivers/dma/stm32-dmamux.c                                     |   22 
 drivers/dma/tegra210-adma.c                                    |   10 
 drivers/dma/ti/dma-crossbar.c                                  |   18 
 drivers/dma/ti/k3-udma-private.c                               |    2 
 drivers/dma/ti/omap-dma.c                                      |    4 
 drivers/dma/xilinx/xilinx_dma.c                                |    7 
 drivers/edac/i3200_edac.c                                      |   11 
 drivers/edac/x38_edac.c                                        |    9 
 drivers/firmware/efi/cper.c                                    |    2 
 drivers/firmware/imx/imx-scu-irq.c                             |   24 
 drivers/gpio/gpio-rockchip.c                                   |    8 
 drivers/gpio/gpiolib-acpi.c                                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                       |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h                       |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/soc21.c                             |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c          |   18 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c    |    3 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                     |   23 
 drivers/gpu/drm/imx/imx-tve.c                                  |   13 
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c                    |    1 
 drivers/gpu/drm/panel/panel-simple.c                           |    1 
 drivers/gpu/drm/radeon/radeon_fence.c                          |    8 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                         |    4 
 drivers/gpu/drm/xen/xen_drm_front.c                            |    3 
 drivers/hid/usbhid/hid-core.c                                  |   17 
 drivers/hwtracing/intel_th/core.c                              |   19 
 drivers/iio/adc/ad7280a.c                                      |    4 
 drivers/iio/adc/ad9467.c                                       |    2 
 drivers/iio/adc/at91-sama5d2_adc.c                             |    1 
 drivers/iio/adc/exynos_adc.c                                   |   13 
 drivers/iio/chemical/scd4x.c                                   |    6 
 drivers/iio/dac/ad5686.c                                       |    6 
 drivers/input/misc/xen-kbdfront.c                              |    5 
 drivers/input/serio/i8042-acpipnpio.h                          |   18 
 drivers/irqchip/irq-gic-v3-its.c                               |    8 
 drivers/isdn/mISDN/timerdev.c                                  |   13 
 drivers/leds/led-class.c                                       |   10 
 drivers/misc/mei/mei-trace.h                                   |   18 
 drivers/misc/uacce/uacce.c                                     |   42 
 drivers/mmc/host/rtsx_pci_sdmmc.c                              |   41 
 drivers/mmc/host/sdhci-of-dwcmshc.c                            |   20 
 drivers/net/bonding/bond_main.c                                |   29 
 drivers/net/bonding/bond_options.c                             |    8 
 drivers/net/can/ctucanfd/ctucanfd_base.c                       |    2 
 drivers/net/can/usb/ems_usb.c                                  |    8 
 drivers/net/can/usb/esd_usb.c                                  |    9 
 drivers/net/can/usb/etas_es58x/es58x_core.c                    |    2 
 drivers/net/can/usb/gs_usb.c                                   |   11 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c               |    9 
 drivers/net/can/usb/mcba_usb.c                                 |    8 
 drivers/net/can/usb/usb_8dev.c                                 |    8 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                       |    5 
 drivers/net/ethernet/emulex/benet/be_cmds.c                    |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h         |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c        |    2 
 drivers/net/ethernet/intel/ice/ice_main.c                      |    1 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c                 |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                |   86 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c      |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h       |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c              |   22 
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c |    2 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c     |   19 
 drivers/net/ethernet/rocker/rocker_main.c                      |    5 
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c                   |    5 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c            |    5 
 drivers/net/hyperv/hyperv_net.h                                |    5 
 drivers/net/hyperv/netvsc_drv.c                                |   13 
 drivers/net/hyperv/rndis_filter.c                              |   29 
 drivers/net/ipvlan/ipvlan.h                                    |    2 
 drivers/net/ipvlan/ipvlan_core.c                               |   16 
 drivers/net/ipvlan/ipvlan_main.c                               |   49 
 drivers/net/macvlan.c                                          |   20 
 drivers/net/netdevsim/bpf.c                                    |    6 
 drivers/net/netdevsim/dev.c                                    |    2 
 drivers/net/netdevsim/netdevsim.h                              |    1 
 drivers/net/team/team.c                                        |   23 
 drivers/net/usb/dm9601.c                                       |    4 
 drivers/net/usb/usbnet.c                                       |   11 
 drivers/net/wireless/ath/ath10k/ce.c                           |   16 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c           |    6 
 drivers/net/wireless/rsi/rsi_91x_mac80211.c                    |    1 
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c                     |    9 
 drivers/net/xen-netback/xenbus.c                               |    3 
 drivers/net/xen-netfront.c                                     |    4 
 drivers/nfc/virtual_ncidev.c                                   |    4 
 drivers/nvme/host/fabrics.c                                    |   15 
 drivers/nvme/host/fabrics.h                                    |    1 
 drivers/nvme/host/fc.c                                         |    5 
 drivers/nvme/host/nvme.h                                       |   14 
 drivers/nvme/host/pci.c                                        |   41 
 drivers/nvme/host/rdma.c                                       |    1 
 drivers/nvme/host/tcp.c                                        |    1 
 drivers/nvme/target/tcp.c                                      |   28 
 drivers/of/base.c                                              |    8 
 drivers/of/platform.c                                          |    2 
 drivers/pci/Kconfig                                            |    6 
 drivers/pci/xen-pcifront.c                                     |    4 
 drivers/phy/broadcom/phy-bcm-ns-usb3.c                         |    2 
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c                     |    3 
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c                  |   56 
 drivers/phy/st/phy-stm32-usbphyc.c                             |    2 
 drivers/phy/tegra/xusb-tegra186.c                              |    3 
 drivers/pinctrl/meson/pinctrl-meson.c                          |    2 
 drivers/pinctrl/pinctrl-rockchip.c                             |    9 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                       |   17 
 drivers/ptp/ptp_chardev.c                                      |   37 
 drivers/ptp/ptp_private.h                                      |   16 
 drivers/scsi/be2iscsi/be_mgmt.c                                |    1 
 drivers/scsi/qla2xxx/qla_os.c                                  |    2 
 drivers/scsi/scsi_error.c                                      |   35 
 drivers/scsi/scsi_lib.c                                        |    8 
 drivers/scsi/storvsc_drv.c                                     |    3 
 drivers/scsi/xen-scsifront.c                                   |    4 
 drivers/slimbus/core.c                                         |   19 
 drivers/soc/imx/imx8m-blk-ctrl.c                               |   11 
 drivers/spi/spi-sprd-adi.c                                     |   67 
 drivers/target/sbp/sbp_target.c                                |    4 
 drivers/tty/hvc/hvc_xen.c                                      |    4 
 drivers/tty/serial/8250/8250_pci.c                             |    2 
 drivers/usb/core/config.c                                      |    5 
 drivers/usb/core/quirks.c                                      |    3 
 drivers/usb/dwc3/core.c                                        |    2 
 drivers/usb/dwc3/core.h                                        |    1 
 drivers/usb/host/ohci-platform.c                               |    1 
 drivers/usb/host/uhci-platform.c                               |    1 
 drivers/usb/host/xen-hcd.c                                     |    4 
 drivers/usb/serial/ftdi_sio.c                                  |    1 
 drivers/usb/serial/ftdi_sio_ids.h                              |    2 
 drivers/usb/serial/option.c                                    |    1 
 drivers/vhost/scsi.c                                           |   24 
 drivers/video/fbdev/xen-fbfront.c                              |    6 
 drivers/w1/slaves/w1_therm.c                                   |   62 
 drivers/w1/w1.c                                                |    2 
 drivers/xen/pvcalls-back.c                                     |    3 
 drivers/xen/pvcalls-front.c                                    |    3 
 drivers/xen/xen-pciback/xenbus.c                               |    4 
 drivers/xen/xen-scsiback.c                                     |    5 
 fs/btrfs/block-group.c                                         |   60 
 fs/btrfs/ctree.h                                               |   59 
 fs/btrfs/delayed-inode.c                                       |    1 
 fs/btrfs/disk-io.c                                             |    2 
 fs/btrfs/inode-item.c                                          |    1 
 fs/btrfs/props.c                                               |    1 
 fs/btrfs/relocation.c                                          |   14 
 fs/btrfs/space-info.c                                          |   76 
 fs/btrfs/space-info.h                                          |   69 
 fs/btrfs/sysfs.c                                               |   18 
 fs/btrfs/transaction.c                                         |   11 
 fs/efivarfs/vars.c                                             |    2 
 fs/ext4/xattr.c                                                |    1 
 fs/fs-writeback.c                                              |   14 
 fs/gfs2/log.c                                                  |    3 
 fs/gfs2/lops.c                                                 |    2 
 fs/gfs2/super.c                                                |    4 
 fs/iomap/buffered-io.c                                         |    2 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                      |    2 
 fs/nfsd/nfsctl.c                                               |   17 
 fs/ntfs3/inode.c                                               |    7 
 fs/smb/server/mgmt/user_session.c                              |   35 
 fs/smb/server/mgmt/user_session.h                              |    1 
 fs/smb/server/smb2pdu.c                                        |    9 
 fs/smb/server/transport_ipc.c                                  |   12 
 fs/smb/server/transport_rdma.c                                 |   15 
 fs/xfs/libxfs/xfs_ialloc.c                                     |   11 
 include/linux/kfence.h                                         |    1 
 include/linux/libata.h                                         |   36 
 include/linux/nvme.h                                           |    3 
 include/linux/posix-clock.h                                    |   39 
 include/linux/textsearch.h                                     |    1 
 include/linux/usb/quirks.h                                     |    3 
 include/net/bonding.h                                          |   13 
 include/net/nfc/nfc.h                                          |    2 
 include/scsi/scsi_eh.h                                         |    6 
 include/sound/pcm.h                                            |    2 
 include/uapi/linux/comedi.h                                    |    2 
 include/xen/xenbus.h                                           |    2 
 io_uring/io_uring.c                                            |    8 
 kernel/bpf/cgroup.c                                            |    8 
 kernel/dma/pool.c                                              |    7 
 kernel/irq/irq_sim.c                                           |    2 
 kernel/time/hrtimer.c                                          |    2 
 kernel/time/posix-clock.c                                      |   53 
 lib/flex_proportions.c                                         |    5 
 mm/Kconfig                                                     |   12 
 mm/damon/sysfs.c                                               |   15 
 mm/kfence/core.c                                               |   23 
 mm/kmsan/shadow.c                                              |    3 
 mm/migrate.c                                                   |   12 
 mm/mprotect.c                                                  |  101 
 mm/page_alloc.c                                                |   47 
 mm/rmap.c                                                      |   20 
 net/9p/trans_xen.c                                             |    3 
 net/bpf/test_run.c                                             |    5 
 net/bridge/br_input.c                                          |    2 
 net/can/j1939/transport.c                                      |   10 
 net/core/dev.c                                                 |   25 
 net/core/filter.c                                              |   25 
 net/ipv4/Makefile                                              |    1 
 net/ipv4/esp4_offload.c                                        |    4 
 net/ipv4/fou.c                                                 | 1313 ----------
 net/ipv4/fou_core.c                                            | 1283 +++++++++
 net/ipv4/fou_nl.c                                              |   48 
 net/ipv4/fou_nl.h                                              |   25 
 net/ipv4/ip_gre.c                                              |   11 
 net/ipv6/addrconf.c                                            |    4 
 net/ipv6/esp6_offload.c                                        |    4 
 net/ipv6/icmp.c                                                |    4 
 net/ipv6/ip6_tunnel.c                                          |    2 
 net/ipv6/ndisc.c                                               |    4 
 net/l2tp/l2tp_core.c                                           |    4 
 net/mac80211/ibss.c                                            |    8 
 net/mac80211/ieee80211_i.h                                     |    6 
 net/mac80211/iface.c                                           |   10 
 net/mac80211/mesh.c                                            |   10 
 net/mac80211/mesh_hwmp.c                                       |    6 
 net/mac80211/mlme.c                                            |   13 
 net/mac80211/ocb.c                                             |    6 
 net/mac80211/rx.c                                              |    2 
 net/mac80211/scan.c                                            |    2 
 net/mac80211/status.c                                          |    6 
 net/mac80211/tdls.c                                            |   11 
 net/mac80211/util.c                                            |    2 
 net/mptcp/protocol.c                                           |   13 
 net/netrom/nr_route.c                                          |   13 
 net/nfc/core.c                                                 |   27 
 net/nfc/llcp_commands.c                                        |   17 
 net/nfc/llcp_core.c                                            |    4 
 net/nfc/nci/core.c                                             |    4 
 net/sched/act_ife.c                                            |   12 
 net/sched/sch_qfq.c                                            |    8 
 net/sched/sch_teql.c                                           |    5 
 net/sctp/input.c                                               |    2 
 net/sctp/sm_statefuns.c                                        |   10 
 net/vmw_vsock/virtio_transport_common.c                        |   30 
 scripts/generate_rust_analyzer.py                              |    2 
 sound/core/oss/pcm_oss.c                                       |    4 
 sound/core/pcm_native.c                                        |    9 
 sound/pci/ctxfi/ctamixer.c                                     |    2 
 sound/soc/amd/yc/acp6x-mach.c                                  |    8 
 sound/soc/codecs/tlv320adcx140.c                               |    8 
 sound/soc/codecs/wsa881x.c                                     |   54 
 sound/soc/codecs/wsa883x.c                                     |    9 
 sound/soc/fsl/imx-card.c                                       |    1 
 sound/soc/intel/boards/sof_es8336.c                            |    2 
 sound/usb/mixer.c                                              |   22 
 sound/usb/mixer_scarlett2.c                                    |    7 
 sound/xen/xen_snd_front.c                                      |    3 
 tools/testing/selftests/net/amt.sh                             |    7 
 tools/testing/selftests/net/toeplitz.c                         |    4 
 tools/testing/selftests/ptp/testptp.c                          |  194 +
 tools/testing/vsock/util.c                                     |   12 
 297 files changed, 3888 insertions(+), 2423 deletions(-)

Abdun Nihaal (1):
      scsi: xen: scsiback: Fix potential memory leak in scsiback_remove()

Aboorva Devarajan (1):
      mm/page_alloc: make percpu_pagelist_high_fraction reads lock-free

Aditya Garg (1):
      net: hv_netvsc: reject RSS hash key programming without RX indirection table

Alex Deucher (3):
      drm/amdgpu/soc21: fix xclk for APUs
      drm/amdgpu/gfx10: fix wptr reset in KGQ init
      drm/amdgpu/gfx11: fix wptr reset in KGQ init

Alex Hung (1):
      drm/amd/display: Check dce_hwseq before dereferencing it

Alex Maftei (2):
      selftests/ptp: Add -x option for testing PTP_SYS_OFFSET_EXTENDED
      selftests/ptp: Add -X option for testing PTP_SYS_OFFSET_PRECISE

Alexander Usyskin (1):
      mei: trace: treat reg parameter as string

Alexis Lothoré (1):
      net: stmmac: make sure that ptp_rate is not 0 before configuring EST

Alok Tiwari (1):
      octeontx2: cn10k: fix RX flowid TCAM mask handling

Andreas Gruenbacher (2):
      Revert "gfs2: Fix use of bio_chain"
      gfs2: Fix NULL pointer dereference in gfs2_log_flush

Andrew Cooper (1):
      x86/kfence: avoid writing L1TF-vulnerable PTEs

Andrew Davis (1):
      spi: sprd: adi: Use devm_register_restart_handler()

Andrey Vatoropin (1):
      be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list

Arnd Bergmann (1):
      irqchip/gic-v3-its: Avoid truncating memory addresses

Arun Raghavan (1):
      ALSA: usb: Increase volume range that triggers a warning

Bagas Sanjaya (2):
      textsearch: describe @list member in ts_ops search
      mm, kfence: describe @slab parameter in __kfence_obj_info()

Bartlomiej Kubik (1):
      fs/ntfs3: Initialize allocated memory before use

Bartosz Golaszewski (2):
      pinctrl: meson: mark the GPIO controller as sleeping
      pinctrl: lpass-lpi: implement .get_direction() for the GPIO driver

Benjamin Tissoires (1):
      HID: usbhid: paper over wrong bNumDescriptor field

Berk Cem Goksel (1):
      ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_free()

Biju Das (1):
      dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()

Boris Burkov (1):
      btrfs: store fs_info in space_info

Brian Foster (1):
      xfs: set max_agbno to allow sparse alloc of last full inode chunk

Brian Kao (1):
      scsi: core: Fix error handler encryption support

Cedric Xing (1):
      x86: make page fault handling disable interrupts properly

Chen Ni (1):
      net/sched: act_ife: convert comma to semicolon

Cheng-Yu Lee (1):
      regmap: Fix race condition in hwspinlock irqsave routine

Chenghai Huang (1):
      uacce: ensure safe queue release with state management

Damien Le Moal (3):
      ata: libata: Introduce ata_ncq_supported()
      ata: libata: cleanup fua support detection
      ata: libata-core: Introduce ata_dev_config_lpm()

Dan Carpenter (2):
      phy: stm32-usphyc: Fix off by one in probe()
      wifi: mwifiex: Fix a loop in mwifiex_update_ampdu_rxwinsize()

Dan Williams (1):
      x86/kaslr: Recognize all ZONE_DEVICE users as physaddr consumers

Daniel Borkmann (1):
      bpf: Do not let BPF test infra emit invalid GSO types to stack

Daniel Wagner (1):
      nvme-fc: rename free_ctrl callback to match name pattern

David Hildenbrand (Red Hat) (1):
      mm/rmap: fix two comments related to huge_pmd_unshare()

David Jeffery (1):
      scsi: core: Wake up the error handler when final completions race against each other

Dawei Li (1):
      xen: make remove callback of xen driver void returned

Denis Sergeev (1):
      gpiolib: acpi: use BIT_ULL() for u64 mask in address space handler

Dmitry Skorodumov (1):
      ipvlan: Make the addrs_lock be per port

Dragan Simic (1):
      phy: phy-rockchip-inno-usb2: Use dev_err_probe() in the probe path

Emil Svendsen (2):
      ASoC: tlv320adcx140: fix null pointer
      ASoC: tlv320adcx140: fix word length

Eric Dumazet (12):
      ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
      net: update netdev_lock_{type,name}
      macvlan: fix possible UAF in macvlan_forward_source()
      ipv4: ip_gre: make ipgre_header() robust
      net/sched: sch_qfq: do not free existing class in qfq_change_class()
      bonding: limit BOND_MODE_8023AD to Ethernet devices
      l2tp: avoid one data-race in l2tp_tunnel_del_work()
      mISDN: annotate data-race around dev->work
      ipv6: annotate data-race in ndisc_router_discovery()
      bonding: provide a net pointer to __skb_flow_dissect()
      net/sched: act_ife: avoid possible NULL deref
      bonding: annotate data-races around slave->last_rx

Ethan Nelson-Moore (2):
      USB: serial: ftdi_sio: add support for PICAXE AXE027 cable
      net: usb: dm9601: remove broken SR9700 support

Fabio Estevam (1):
      ASoC: fsl: imx-card: Do not force slot width to sample width

Felix Gu (1):
      spi: spi-sprd-adi: Fix double free in probe error path

Fernand Sieber (1):
      perf/x86/intel: Do not enable BTS for guests

Fernando Fernandez Mancera (1):
      ipv6: use the right ifindex when replying to icmpv6 from localhost

Fiona Klute (1):
      iio: chemical: scd4x: fix reported channel endianness

Gal Pressman (2):
      selftests: drv-net: fix RPS mask handling for high CPU numbers
      net/mlx5e: Account for netdev stats in ndo_get_stats64

Gavin Li (1):
      Revert "net/mlx5: Block entering switchdev mode with ns inconsistency"

Geraldo Nascimento (2):
      arm64: dts: rockchip: remove dangerous max-link-speed from helios64
      arm64: dts: rockchip: remove redundant max-link-speed from nanopi-r4s

Giovanni Cabiddu (1):
      crypto: qat - flush misc workqueue during device shutdown

Greg Kroah-Hartman (1):
      Linux 6.1.162

Gyeyoung Baek (1):
      genirq/irq_sim: Initialize work context pointers properly

Han Gao (1):
      riscv: compat: fix COMPAT_UTS_MACHINE definition

Hans de Goede (1):
      leds: led-class: Only Add LED to leds_list when it is fully ready

Haotian Zhang (1):
      dmaengine: omap-dma: fix dma_pool resource leak in error paths

Haoxiang Li (6):
      EDAC/x38: Fix a resource leak in x38_probe1()
      EDAC/i3200: Fix a resource leak in i3200_probe1()
      drm/vmwgfx: Fix an error return check in vmw_compat_shader_add()
      w1: fix redundant counter decrement in w1_attach_slave_device()
      scsi: be2iscsi: Fix a memory leak in beiscsi_boot_get_sinfo()
      drm/amdkfd: fix a memory leak in device_queue_manager_init()

Harry Yoo (1):
      Revert "mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()"

Huacai Chen (1):
      USB: OHCI/UHCI: Add soft dependencies on ehci_platform

Ian Abbott (2):
      comedi: dmm32at: serialize use of paged registers
      comedi: Fix getting range information for subdevices 16 to 255

Ilikara Zheng (1):
      nvme-pci: disable secondary temp for Wodposit WPBSNM8

JP Kobryn (1):
      btrfs: prevent use-after-free on page private data in btrfs_subpage_clear_uptodate()

Jakub Kicinski (3):
      netlink: add a proto specification for FOU
      net: fou: rename the source for linking
      net: fou: use policy and operation tables generated from the spec

Jamal Hadi Salim (2):
      net/sched: Enforce that teql can only be used as root qdisc
      net/sched: qfq: Use cl_is_active to determine whether class is active in qfq_rm_from_ag

Jan Kara (1):
      flex_proportions: make fprop_new_period() hardirq safe

Janne Grunau (1):
      dmaengine: apple-admac: Add "apple,t8103-admac" compatible

Jaroslav Kysela (1):
      ALSA: pcm: Improve the fix for race of buffer access at PCM OSS layer

Jeongjun Park (1):
      netrom: fix double-free in nr_route_frame()

Jesse Brandeburg (1):
      ice: stop counting UDP csum mismatch as rx_errors

Jia-Hong Su (1):
      Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work

Jianbo Liu (1):
      xfrm: Fix inner mode lookup in tunnel mode GSO segmentation

Jiasheng Jiang (1):
      btrfs: fix memory leaks in create_space_info() error paths

Jijie Shao (2):
      net: hns3: fix wrong GENMASK() for HCLGE_FD_AD_COUNTER_NUM_M
      net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue

Johan Hovold (17):
      dmaengine: at_hdmac: fix device leak on of_dma_xlate()
      dmaengine: bcm-sba-raid: fix device leak on probe
      dmaengine: dw: dmamux: fix OF node leak on route allocation failure
      dmaengine: idxd: fix device leaks on compat bind and unbind
      dmaengine: lpc18xx-dmamux: fix device leak on route allocation
      dmaengine: ti: dma-crossbar: fix device leak on dra7x route allocation
      dmaengine: ti: dma-crossbar: fix device leak on am335x route allocation
      dmaengine: ti: k3-udma: fix device leak on udma lookup
      slimbus: core: fix runtime PM imbalance on report present
      slimbus: core: fix device reference leak on report present
      intel_th: fix device leak on output open()
      dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
      dmaengine: stm32: dmamux: fix device leak on route allocation
      iio: adc: exynos_adc: fix OF populate on driver rebind
      ASoC: codecs: wsa881x: fix unnecessary initialisation
      ASoC: codecs: wsa883x: fix unnecessary initialisation
      drm/imx/tve: fix probe device leak

Johannes Berg (2):
      wifi: mac80211: use wiphy work for sdata->work
      wifi: mac80211: move TDLS work to wiphy work

Johannes Brüderl (1):
      usb: core: add USB_QUIRK_NO_BOS for devices that hang on BOS descriptor

Josef Bacik (1):
      btrfs: move flush related definitions to space-info.h

Keith Busch (1):
      nvme-pci: do not directly handle subsys reset fallout

Kery Qi (3):
      net: wwan: t7xx: fix potential skb->frags overflow in RX path
      rocker: fix memory leak in rocker_world_port_post_fini()
      scsi: firewire: sbp-target: Fix overflow in sbp_make_tpg()

Kohei Enju (1):
      efivarfs: fix error propagation in efivar_entry_get()

Konrad Dybcio (1):
      arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links

Krzysztof Kozlowski (4):
      phy: broadcom: ns-usb3: Fix Wvoid-pointer-to-enum-cast warning (again)
      ASoC: codecs: wsa881x: Simplify &pdev->dev in probe
      ASoC: codecs: wsa881x: Use proper shutdown GPIO polarity
      ASoC: codecs: wsa881x: Drop unused version readout

Kuniyuki Iwashima (5):
      ipv6: Fix use-after-free in inet6_addr_del().
      gue: Fix skb memleak with inner IP protocol 0.
      fou: Don't allow 0 for FOU_ATTR_IPPROTO.
      nfc: llcp: Fix memleak in nfc_llcp_send_ui_frame().
      nfc: nci: Fix race between rfkill and nci_unregister_device().

Kübrich, Andreas (1):
      iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl

Laurent Vivier (1):
      usbnet: limit max_mtu based on device's hard_mtu

Laveesh Bansal (1):
      writeback: fix 100% CPU usage when dirtytime_expire_interval is 0

Linus Torvalds (1):
      Fix memory leak in posix_clock_open()

Lisa Robinson (1):
      LoongArch: Fix PMU counter allocation for mixed-type event groups

Long Li (1):
      scsi: storvsc: Process unsupported MODE_SENSE_10

Louis Chauvet (1):
      phy: rockchip: inno-usb2: fix disconnection in gadget mode

Luca Ceresoli (1):
      phy: rockchip: inno-usb2: fix communication disruption in gadget mode

Lyude Paul (1):
      drm/nouveau/disp/nv50-: Set lock_core in curs507a_prepare

Mahesh Bandewar (1):
      selftest/ptp: update ptp selftest to exercise the gettimex options

Maninder Singh (1):
      NFSD: fix race between nfsd registration and exports_proc

Marc Kleine-Budde (8):
      can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak
      can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error
      can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
      can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
      can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
      can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak
      can: gs_usb: gs_usb_receive_bulk_callback(): fix error message
      can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak

Marek Vasut (2):
      drm/panel-simple: fix connector type for DataImage SCF0700C48GGU18 panel
      wifi: rsi: Fix memory corruption due to not set vif driver data size

Marios Makassikis (1):
      ksmbd: fix recursive locking in RPC handle list access

Mark Harmstone (1):
      btrfs: fix missing fields in superblock backup with BLOCK_GROUP_TREE

Mark Rutland (2):
      arm64/fpsimd: signal: Allocate SSVE storage when restoring ZA
      arm64/fpsimd: signal: Fix restoration of SVE context

Marnix Rijnart (1):
      serial: 8250_pci: Fix broken RS485 for F81504/508/512

Martin Kaiser (1):
      net: bridge: fix static key check

Matthew Schwartz (1):
      mmc: rtsx_pci_sdmmc: implement sdmmc_card_busy function

Matthew Wilcox (Oracle) (1):
      migrate: correct lock ordering for hugetlb file folios

Matthieu Baerts (NGI0) (2):
      mptcp: only reset subflow errors when propagated
      mptcp: avoid dup SUB_CLOSED events after disconnect

Maurizio Lombardi (1):
      nvmet-tcp: remove boilerplate code

Melbin K Mathew (2):
      vsock/virtio: fix potential underflow in virtio_transport_get_credit()
      vsock/virtio: cap TX credit to local buffer size

Miaoqian Lin (1):
      dmaengine: qcom: gpi: Fix memory leak in gpi_peripheral_config()

Mike Christie (1):
      vhost-scsi: Fix handling of multiple calls to vhost_scsi_set_endpoint

Ming Lei (1):
      io_uring: move local task_work in exit cancel loop

Ming Qian (1):
      pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu

Morduan Zang (1):
      efi/cper: Fix cper_bits_to_str buffer handling and return value

Namjae Jeon (1):
      ksmbd: fix use-after-free in ksmbd_session_rpc_open

Naohiko Shimizu (1):
      riscv: clocksource: Fix stimecmp update hazard on RV32

Naohiro Aota (3):
      btrfs: factor out init_space_info() from create_space_info()
      btrfs: factor out check_removing_space_info() from btrfs_free_block_groups()
      btrfs: introduce btrfs_space_info sub-group

Niklas Cassel (3):
      ata: libata: Add cpr_log to ata_dev_print_features() early return
      ata: libata: Call ata_dev_config_lpm() for ATAPI devices
      ata: libata: Print features also for ATAPI devices

Nikola Z. Ivanov (1):
      team: Move team device type change at the end of team_port_add

Nilay Shroff (1):
      nvme: fix PCIe subsystem reset controller state transition

Ondrej Ille (1):
      can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.

Paul Chaignon (1):
      bpf: Reject narrower access to pointer ctx fields

Pavel Zhigulin (1):
      iio: adc: ad7280a: handle spi_setup() errors in probe()

Pei Xiao (1):
      iio: adc: at91-sama5d2_adc: Fix potential use-after-free in sama5d2_adc driver

Peng Fan (1):
      firmware: imx: scu-irq: Set mu_resource_id before get handle

Pimyn Girgis (1):
      mm/kfence: randomize the freelist on initialization

Rafael Beims (1):
      phy: freescale: imx8m-pcie: assert phy reset during power on

Rahul Rameshbabu (1):
      testptp: Add support for testing ptp_clock_info .adjphase callback

Raju Rangoju (1):
      amd-xgbe: avoid misleading per-packet error log

Ratheesh Kannoth (1):
      octeontx2-af: Fix error handling

Ritesh Harjani (IBM) (1):
      iomap: Fix possible overflow condition in iomap_write_delalloc_scan

Rob Herring (Arm) (1):
      of: platform: Use default match table for /firmware

Robbie Ko (1):
      btrfs: fix deadlock in wait_current_trans() due to ignored transaction type

Robert McClinton (1):
      drm/radeon: delete radeon_fence_process in is_signaled, no deadlock

Robin Murphy (1):
      gpio: rockchip: Stop calling pinctrl for set_direction

Ryan Roberts (1):
      mm: kmsan: fix poisoning of high-order non-compound pages

Saeed Mahameed (1):
      net/mlx5e: Restore destroying state bit after profile cleanup

Sai Sree Kartheek Adivi (1):
      dma/pool: distinguish between missing and exhausted atomic pools

Samasth Norway Ananda (1):
      ALSA: scarlett2: Fix buffer overflow in config retrieval

Sean Christopherson (1):
      x86/fpu: Clear XSTATE_BV[i] in guest XSAVE state whenever XFD[i]=1

Sebastian Reichel (1):
      phy: phy-rockchip-inno-usb2: simplify phy clock handling

SeongJae Park (3):
      mm/damon/sysfs: cleanup attrs subdirs on context dir setup failure
      mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir setup failure
      mm/damon/sysfs-scheme: cleanup access_pattern subdirs on scheme dir setup failure

Shawn Lin (2):
      mmc: sdhci-of-dwcmshc: Update DLL and pre-change delay for rockchip platform
      mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in HS200/HS400 mode

Sheetal (1):
      dmaengine: tegra-adma: Fix use-after-free

Shivam Kumar (1):
      nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec

Shradha Gupta (1):
      hv_netvsc: Allocate rx indirection table size dynamically

Srinivasan Shanmugam (1):
      drm/amdgpu: Replace Mutex with Spinlock for RLCG register access to avoid Priority Inversion in SRIOV

Stefano Garzarella (1):
      vsock/test: add a final full barrier after run all tests

Suraj Gupta (1):
      dmaengine: xilinx_dma: Fix uninitialized addr_width when "xlnx,addrwidth" property is missing

Szymon Wilczek (1):
      can: etas_es58x: allow partial RX URB allocation to succeed

Taehee Yoo (1):
      selftests: net: amt: wait longer for connection before sending packets

Taeyang Lee (1):
      crypto: authencesn - reject too-short AAD (assoclen<8) to match ESP/ESN spec

Tagir Garaev (1):
      ASoC: Intel: sof_es8336: fix headphone GPIO logic inversion

Takashi Iwai (1):
      ALSA: ctxfi: Fix potential OOB access in audio mixer handling

Tamir Duberstein (1):
      scripts: generate_rust_analyzer: Add compiler_builtins -> core dep

Tetsuo Handa (1):
      net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts

Thadeu Lima de Souza Cascardo (1):
      Revert "nfc/nci: Add the inconsistency check between the input data length and count"

Thinh Nguyen (1):
      usb: dwc3: Check for USB4 IP_NAME

Thomas Fourier (4):
      wifi: ath10k: fix dma_free_coherent() pointer
      octeontx2: Fix otx2_dma_map_page() error return code
      scsi: qla2xxx: edif: Fix dma_free_coherent() size
      ksmbd: smbd: fix dma_unmap_sg() nents

Thomas Weißschuh (1):
      hrtimer: Fix softirq base check in update_needs_ipi()

Thorsten Blum (1):
      w1: therm: Fix off-by-one buffer overflow in alarms_store

Timur Kristóf (2):
      drm/amd/pm: Don't clear SI SMC table when setting power limit
      drm/amd/pm: Workaround SI powertune issue on Radeon 430 (v2)

Tomas Melin (1):
      iio: adc: ad9467: fix ad9434 vref mask

Ulrich Mohr (1):
      USB: serial: option: add Telit LE910 MBIM composition

Uwe Kleine-König (1):
      spi: sprd-adi: Convert to platform remove callback returning void

Vlastimil Babka (1):
      mm/page_alloc: prevent pcp corruption with SMP=n

Waiman Long (1):
      blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()

Wayne Chang (1):
      phy: tegra: xusb: Explicitly configure HS_DISCON_LEVEL to 0x7

Weigang He (1):
      of: fix reference count leak in of_alias_scan()

Wenkai Lin (1):
      uacce: fix cdev handling in the cleanup path

Wentao Liang (1):
      phy: rockchip: inno-usb2: Fix a double free bug in rockchip_usb2phy_probe()

Wojtek Wasko (3):
      posix-clock: Store file pointer in struct posix_clock_context
      ptp: Add PHC file mode checks. Allow RO adjtime() without FMODE_WRITE.
      testptp: Add option to open PHC in readonly mode

Xabier Marquiegui (2):
      posix-clock: introduce posix_clock_context concept
      ptp: add testptp mask test

Xiaochen Shen (2):
      x86/resctrl: Add missing resctrl initialization for Hygon
      x86/resctrl: Fix memory bandwidth counter width for Hygon

Xin Long (2):
      sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT
      sctp: linearize cloned gso packets in sctp_rcv

Yafang Shao (1):
      net/mlx5e: Report rx_discards_phy via rx_dropped

Yang Erkun (1):
      ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref

Yang Li (1):
      spi: sprd-adi: Use devm_platform_get_and_ioremap_resource()

Yang Shen (1):
      uacce: implement mremap in uacce_vm_ops to return -EPERM

Yang Yingliang (1):
      spi: sprd-adi: switch to use spi_alloc_host()

Yun Lu (1):
      netdevsim: fix a race issue related to the operation on bpf_bound_progs list

Yunseong Kim (1):
      ksmbd: Fix race condition in RPC handle list access

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for Acer TravelMate P216-41-TCO

Zhaoyang Huang (1):
      arm64: Set __nocfi on swsusp_arch_resume()

Zilin Guan (3):
      pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_deviceid_node()
      net/mlx5: Fix memory leak in esw_acl_ingress_lgcy_setup()
      net: mvpp2: cls: Fix memory leak in mvpp2_ethtool_cls_rule_ins()

Zqiang (1):
      usbnet: Fix using smp_processor_id() in preemptible code warnings

feng (1):
      Input: i8042 - add quirk for ASUS Zenbook UX425QA_UM425QA

gongqi (1):
      Input: i8042 - add quirks for MECHREVO Wujie 15X Pro


