Return-Path: <stable+bounces-212855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDj3L89+fGk8NgIAu9opvQ
	(envelope-from <stable+bounces-212855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:50:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE207B90AB
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D6A930097FF
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1829130EF66;
	Fri, 30 Jan 2026 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XMVwvEcX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2032DEA94;
	Fri, 30 Jan 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769766599; cv=none; b=b8DPGXXMHueO31CAW64jaRNk5QibuwRVTIiMTjqhXV3w2SDtTZGfGXV6zm32QYrZw/E4Uzyi96irSHtbENQr+VgyCzrj2kYiZ/Ftube24zlf8i0rEBt0Cd3ZDAnomaD1zw0goxGyBkVSrIZ/1HKAEuTpLJRM0hoAxsJibN5PBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769766599; c=relaxed/simple;
	bh=BXmNRBfWnORGDhonwiVDuEi9XTacdOG1YOq7IawISM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ayyJa2fanXq7MXK/njAepTviDiv/iB6dXdphf71+i45RNk7z9jiWiFFEC0Fx4fshipBBZWaD1ufLSe2CkyOQYwcPNY/ERw20FJx6tMtzoN7tMxnpW/F5T5x7jeUV0KXLdMrNB1C3v0xak9AJIkCv6WM8PbKyh46fmzj5OEYpP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XMVwvEcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB001C4CEF7;
	Fri, 30 Jan 2026 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769766599;
	bh=BXmNRBfWnORGDhonwiVDuEi9XTacdOG1YOq7IawISM0=;
	h=From:To:Cc:Subject:Date:From;
	b=XMVwvEcXQgrR41+2hxODK+zJsrlVvovkvauPCvXeu+h/t058pOfRCfIMG75t5cNkG
	 Nm94rW/OjI4HW5CLTCZoqaPoc8CZJDorVBULfIwai1gFA9jpLUpHqO1lQ9mwcJSgnt
	 O0ZEnwB5+wpRDORLDI2i9gsnLv3aVZl3YHBlbnp0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.122
Date: Fri, 30 Jan 2026 10:49:54 +0100
Message-ID: <2026013054-mannish-peddling-dcfd@gregkh>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212855-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: DE207B90AB
X-Rspamd-Action: no action

I'm announcing the release of the 6.6.122 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml     |   83 ++-
 Documentation/netlink/specs/fou.yaml                        |    2 
 Makefile                                                    |    2 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                      |   16 
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts      |    1 
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts          |    1 
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts       |    4 
 arch/arm64/include/asm/hyperv-tlfs.h                        |   45 --
 arch/arm64/include/asm/mshyperv.h                           |    4 
 arch/arm64/kernel/hibernate.c                               |    2 
 arch/arm64/kernel/signal.c                                  |    4 
 arch/loongarch/kernel/perf_event.c                          |   21 
 arch/x86/events/perf_event.h                                |   13 
 arch/x86/hyperv/hv_init.c                                   |    8 
 arch/x86/include/asm/hyperv-tlfs.h                          |  145 +++---
 arch/x86/include/asm/kfence.h                               |   29 +
 arch/x86/include/asm/mshyperv.h                             |   30 -
 arch/x86/kernel/cpu/mshyperv.c                              |   56 +-
 arch/x86/kernel/cpu/resctrl/core.c                          |   21 
 arch/x86/kernel/cpu/resctrl/internal.h                      |    3 
 arch/x86/kernel/fpu/core.c                                  |   32 +
 arch/x86/kvm/x86.c                                          |    9 
 arch/x86/mm/fault.c                                         |   15 
 arch/x86/mm/kaslr.c                                         |   10 
 crypto/authencesn.c                                         |    6 
 drivers/ata/libata-core.c                                   |   32 +
 drivers/base/regmap/regmap.c                                |    4 
 drivers/block/null_blk/main.c                               |   12 
 drivers/clocksource/hyperv_timer.c                          |   26 -
 drivers/clocksource/timer-riscv.c                           |    3 
 drivers/comedi/comedi_fops.c                                |    2 
 drivers/comedi/drivers/dmm32at.c                            |   32 +
 drivers/comedi/range.c                                      |    2 
 drivers/dma/apple-admac.c                                   |    1 
 drivers/dma/at_hdmac.c                                      |    9 
 drivers/dma/bcm-sba-raid.c                                  |    6 
 drivers/dma/dw/rzn1-dmamux.c                                |    4 
 drivers/dma/idxd/compat.c                                   |   23 -
 drivers/dma/lpc18xx-dmamux.c                                |   19 
 drivers/dma/qcom/gpi.c                                      |    6 
 drivers/dma/sh/rz-dmac.c                                    |    5 
 drivers/dma/stm32-dmamux.c                                  |   22 -
 drivers/dma/tegra210-adma.c                                 |   10 
 drivers/dma/ti/dma-crossbar.c                               |   18 
 drivers/dma/ti/k3-udma-private.c                            |    2 
 drivers/dma/ti/omap-dma.c                                   |    4 
 drivers/dma/xilinx/xdma-regs.h                              |    1 
 drivers/dma/xilinx/xdma.c                                   |    2 
 drivers/dma/xilinx/xilinx_dma.c                             |    7 
 drivers/edac/i3200_edac.c                                   |   11 
 drivers/edac/x38_edac.c                                     |    9 
 drivers/firmware/efi/cper.c                                 |    2 
 drivers/firmware/imx/imx-scu-irq.c                          |   24 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                  |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c       |   19 
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h              |    2 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c |    2 
 drivers/gpu/drm/amd/display/dc/link/link_detection.c        |    4 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                  |   23 -
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c                 |    1 
 drivers/gpu/drm/panel/panel-simple.c                        |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                      |    4 
 drivers/hid/usbhid/hid-core.c                               |   17 
 drivers/hv/hv.c                                             |   36 -
 drivers/hv/hv_common.c                                      |   32 -
 drivers/hwtracing/intel_th/core.c                           |   19 
 drivers/i2c/busses/i2c-qcom-geni.c                          |   11 
 drivers/iio/accel/st_accel_core.c                           |   72 +++
 drivers/iio/adc/ad7280a.c                                   |    4 
 drivers/iio/adc/ad9467.c                                    |    2 
 drivers/iio/adc/at91-sama5d2_adc.c                          |    1 
 drivers/iio/adc/exynos_adc.c                                |   13 
 drivers/iio/chemical/scd4x.c                                |    6 
 drivers/iio/dac/ad5686.c                                    |    6 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c                |   15 
 drivers/iio/industrialio-core.c                             |   12 
 drivers/input/serio/i8042-acpipnpio.h                       |   18 
 drivers/interconnect/debugfs-client.c                       |    5 
 drivers/irqchip/irq-gic-v3-its.c                            |    8 
 drivers/isdn/mISDN/timerdev.c                               |   13 
 drivers/leds/led-class.c                                    |   10 
 drivers/misc/uacce/uacce.c                                  |   48 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                           |   41 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                         |    7 
 drivers/net/bonding/bond_main.c                             |   11 
 drivers/net/can/ctucanfd/ctucanfd_base.c                    |    2 
 drivers/net/can/usb/ems_usb.c                               |    8 
 drivers/net/can/usb/esd_usb.c                               |    9 
 drivers/net/can/usb/etas_es58x/es58x_core.c                 |    2 
 drivers/net/can/usb/gs_usb.c                                |    9 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c            |    9 
 drivers/net/can/usb/mcba_usb.c                              |    8 
 drivers/net/can/usb/usb_8dev.c                              |    8 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                    |    5 
 drivers/net/ethernet/emulex/benet/be_cmds.c                 |    3 
 drivers/net/ethernet/emulex/benet/be_main.c                 |    8 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c             |   69 +--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h      |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c     |    2 
 drivers/net/ethernet/intel/ice/ice_lib.c                    |   29 -
 drivers/net/ethernet/intel/igc/igc_ptp.c                    |   43 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c             |   86 +++-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c   |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h    |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c           |    3 
 drivers/net/hyperv/netvsc_drv.c                             |    3 
 drivers/net/ipvlan/ipvlan.h                                 |    2 
 drivers/net/ipvlan/ipvlan_core.c                            |   16 
 drivers/net/ipvlan/ipvlan_main.c                            |   49 +-
 drivers/net/macvlan.c                                       |   20 
 drivers/net/netdevsim/bpf.c                                 |    6 
 drivers/net/netdevsim/dev.c                                 |    2 
 drivers/net/netdevsim/netdevsim.h                           |    1 
 drivers/net/phy/phy_device.c                                |   58 ++
 drivers/net/usb/dm9601.c                                    |    4 
 drivers/net/usb/usbnet.c                                    |   11 
 drivers/net/veth.c                                          |    8 
 drivers/net/wireless/ath/ath10k/ce.c                        |   16 
 drivers/net/wireless/ath/ath11k/dp_rx.c                     |    4 
 drivers/net/wireless/ath/ath12k/ce.c                        |   12 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c        |    6 
 drivers/net/wireless/rsi/rsi_91x_mac80211.c                 |    1 
 drivers/nfc/virtual_ncidev.c                                |    4 
 drivers/nvme/host/fabrics.c                                 |   15 
 drivers/nvme/host/fabrics.h                                 |    1 
 drivers/nvme/host/fc.c                                      |    5 
 drivers/nvme/host/nvme.h                                    |   14 
 drivers/nvme/host/pci.c                                     |   41 +
 drivers/nvme/host/rdma.c                                    |    1 
 drivers/nvme/host/tcp.c                                     |    1 
 drivers/nvme/target/tcp.c                                   |   28 -
 drivers/of/base.c                                           |    8 
 drivers/of/platform.c                                       |    2 
 drivers/pci/Kconfig                                         |    6 
 drivers/phy/broadcom/phy-bcm-ns-usb3.c                      |    2 
 drivers/phy/broadcom/phy-bcm-ns2-pcie.c                     |    2 
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c                   |    1 
 drivers/phy/broadcom/phy-bcm-sr-pcie.c                      |    2 
 drivers/phy/broadcom/phy-brcm-sata.c                        |    2 
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c                  |    3 
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c                  |    1 
 drivers/phy/marvell/phy-pxa-usb.c                           |    1 
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c              |    2 
 drivers/phy/qualcomm/phy-qcom-m31.c                         |    2 
 drivers/phy/qualcomm/phy-qcom-qusb2.c                       |   18 
 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c                  |  256 +++++-------
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c               |   41 -
 drivers/phy/st/phy-stih407-usb.c                            |    2 
 drivers/phy/st/phy-stm32-usbphyc.c                          |    6 
 drivers/phy/tegra/xusb-tegra186.c                           |    3 
 drivers/phy/ti/phy-twl4030-usb.c                            |    1 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                |    8 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h                |   12 
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                       |   11 
 drivers/pmdomain/qcom/rpmhpd.c                              |    4 
 drivers/ptp/ptp_chardev.c                                   |   37 +
 drivers/ptp/ptp_private.h                                   |   16 
 drivers/scsi/qla2xxx/qla_isr.c                              |    7 
 drivers/scsi/scsi_error.c                                   |   35 +
 drivers/scsi/scsi_lib.c                                     |    8 
 drivers/scsi/storvsc_drv.c                                  |    3 
 drivers/slimbus/core.c                                      |   19 
 drivers/spi/spi-sprd-adi.c                                  |   63 --
 drivers/tty/serial/8250/8250_pci.c                          |    2 
 drivers/usb/core/config.c                                   |    5 
 drivers/usb/core/quirks.c                                   |    3 
 drivers/usb/dwc3/core.c                                     |    2 
 drivers/usb/dwc3/core.h                                     |    1 
 drivers/usb/host/ohci-platform.c                            |    1 
 drivers/usb/host/uhci-platform.c                            |    1 
 drivers/usb/serial/ftdi_sio.c                               |    1 
 drivers/usb/serial/ftdi_sio_ids.h                           |    2 
 drivers/usb/serial/option.c                                 |    1 
 drivers/usb/typec/tcpm/tcpm.c                               |    2 
 drivers/w1/slaves/w1_therm.c                                |   62 --
 drivers/w1/w1.c                                             |    2 
 drivers/xen/xen-scsiback.c                                  |    1 
 fs/btrfs/block-group.c                                      |   60 +-
 fs/btrfs/disk-io.c                                          |    2 
 fs/btrfs/send.c                                             |    2 
 fs/btrfs/space-info.c                                       |   76 ++-
 fs/btrfs/space-info.h                                       |   10 
 fs/btrfs/sysfs.c                                            |   18 
 fs/btrfs/transaction.c                                      |   11 
 fs/ext4/xattr.c                                             |    1 
 fs/gfs2/lops.c                                              |    2 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                   |    2 
 fs/nfsd/nfsctl.c                                            |   17 
 fs/ntfs3/inode.c                                            |    7 
 fs/smb/server/mgmt/user_session.c                           |   20 
 fs/smb/server/mgmt/user_session.h                           |    1 
 include/asm-generic/hyperv-tlfs.h                           |   32 +
 include/asm-generic/mshyperv.h                              |    2 
 include/dt-bindings/power/qcom,rpmhpd.h                     |  235 +++++++++++
 include/dt-bindings/power/qcom-rpmpd.h                      |  246 +----------
 include/linux/iio/iio-opaque.h                              |    2 
 include/linux/kfence.h                                      |    1 
 include/linux/nvme.h                                        |    3 
 include/linux/posix-clock.h                                 |   39 +
 include/linux/textsearch.h                                  |    1 
 include/linux/usb/quirks.h                                  |    3 
 include/scsi/scsi_eh.h                                      |    6 
 include/sound/pcm.h                                         |    2 
 include/uapi/linux/comedi.h                                 |    2 
 io_uring/io-wq.c                                            |    2 
 io_uring/io_uring.c                                         |    8 
 kernel/time/hrtimer.c                                       |    2 
 kernel/time/posix-clock.c                                   |   53 +-
 kernel/trace/trace_events_hist.c                            |    9 
 kernel/trace/trace_events_synth.c                           |    8 
 mm/Kconfig                                                  |   12 
 mm/damon/sysfs-schemes.c                                    |   11 
 mm/damon/sysfs.c                                            |    5 
 mm/kmsan/shadow.c                                           |    2 
 mm/migrate.c                                                |   12 
 mm/page_alloc.c                                             |   47 +-
 mm/rmap.c                                                   |   20 
 net/bpf/test_run.c                                          |    5 
 net/bridge/br_fdb.c                                         |   35 -
 net/bridge/br_input.c                                       |    4 
 net/bridge/br_multicast.c                                   |    9 
 net/can/j1939/transport.c                                   |   10 
 net/core/dev.c                                              |   25 -
 net/core/filter.c                                           |    7 
 net/dsa/dsa.c                                               |    2 
 net/ipv4/esp4_offload.c                                     |    4 
 net/ipv4/fou_core.c                                         |    3 
 net/ipv4/fou_nl.c                                           |    2 
 net/ipv4/ip_gre.c                                           |   11 
 net/ipv6/addrconf.c                                         |    4 
 net/ipv6/esp6_offload.c                                     |    4 
 net/ipv6/ip6_tunnel.c                                       |    2 
 net/ipv6/ndisc.c                                            |    4 
 net/l2tp/l2tp_core.c                                        |    4 
 net/netrom/nr_route.c                                       |   13 
 net/openvswitch/vport.c                                     |   11 
 net/sched/act_ife.c                                         |    6 
 net/sched/sch_qfq.c                                         |    8 
 net/sched/sch_teql.c                                        |    5 
 net/sctp/sm_statefuns.c                                     |   10 
 net/vmw_vsock/virtio_transport_common.c                     |   30 -
 scripts/kconfig/nconf-cfg.sh                                |   11 
 sound/core/oss/pcm_oss.c                                    |    4 
 sound/core/pcm_native.c                                     |    9 
 sound/pci/ctxfi/ctamixer.c                                  |    2 
 sound/soc/codecs/tlv320adcx140.c                            |    8 
 sound/soc/codecs/wsa881x.c                                  |   11 
 sound/soc/codecs/wsa883x.c                                  |    9 
 sound/soc/codecs/wsa884x.c                                  |    3 
 sound/usb/mixer.c                                           |   22 -
 sound/usb/mixer_scarlett2.c                                 |    7 
 tools/net/ynl/ynl-regen.sh                                  |    2 
 tools/testing/selftests/bpf/prog_tests/perf_link.c          |   15 
 tools/testing/selftests/net/amt.sh                          |    7 
 tools/testing/selftests/net/fib-onlink-tests.sh             |   76 +--
 tools/testing/selftests/net/toeplitz.c                      |    4 
 tools/testing/selftests/ptp/testptp.c                       |  114 ++++-
 tools/testing/vsock/util.c                                  |   12 
 tools/testing/vsock/vsock_test.c                            |   11 
 260 files changed, 2727 insertions(+), 1458 deletions(-)

Abdun Nihaal (1):
      scsi: xen: scsiback: Fix potential memory leak in scsiback_remove()

Aboorva Devarajan (1):
      mm/page_alloc: make percpu_pagelist_high_fraction reads lock-free

Aditya Garg (1):
      net: hv_netvsc: reject RSS hash key programming without RX indirection table

Akhil P Oommen (1):
      dt-bindings: power: qcom,rpmpd: add Turbo L5 corner

Alex Hung (1):
      drm/amd/display: Check dce_hwseq before dereferencing it

Alok Tiwari (1):
      octeontx2: cn10k: fix RX flowid TCAM mask handling

Andreas Gruenbacher (1):
      Revert "gfs2: Fix use of bio_chain"

Andrew Cooper (1):
      x86/kfence: avoid writing L1TF-vulnerable PTEs

Andrew Davis (1):
      spi: sprd: adi: Use devm_register_restart_handler()

Andrey Vatoropin (1):
      be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list

Andy Shevchenko (1):
      iio: core: add missing mutex_destroy in iio_dev_release()

Anthony Brandon (1):
      dmaengine: xilinx: xdma: Fix regmap max_register

Arkadiusz Kozdra (1):
      kconfig: fix static linking of nconf

Arnaud Ferraris (1):
      tcpm: allow looking for role_sw device in the main node

Arnd Bergmann (1):
      irqchip/gic-v3-its: Avoid truncating memory addresses

Arun Raghavan (1):
      ALSA: usb: Increase volume range that triggers a warning

Bagas Sanjaya (2):
      textsearch: describe @list member in ts_ops search
      mm, kfence: describe @slab parameter in __kfence_obj_info()

Bartlomiej Kubik (1):
      fs/ntfs3: Initialize allocated memory before use

Benjamin Tissoires (1):
      HID: usbhid: paper over wrong bNumDescriptor field

Berk Cem Goksel (1):
      ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_free()

Biju Das (1):
      dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()

Boris Burkov (1):
      btrfs: store fs_info in space_info

Brian Kao (1):
      scsi: core: Fix error handler encryption support

Cedric Xing (1):
      x86: make page fault handling disable interrupts properly

Cheng-Yu Lee (1):
      regmap: Fix race condition in hwspinlock irqsave routine

Chenghai Huang (2):
      uacce: fix isolate sysfs check condition
      uacce: ensure safe queue release with state management

Chwee-Lin Choong (1):
      igc: fix race condition in TX timestamp read for register 0

Damien Le Moal (1):
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

Danila Tikhonov (1):
      dt-bindings: power: qcom,rpmpd: Add SM7150

Dave Ertman (1):
      ice: Avoid detrimental cleanup for bond during interface stop

David Hildenbrand (Red Hat) (1):
      mm/rmap: fix two comments related to huge_pmd_unshare()

David Jeffery (1):
      scsi: core: Wake up the error handler when final completions race against each other

David Yang (4):
      veth: fix data race in veth_get_ethtool_stats
      net: hns3: fix data race in hns3_fetch_stats
      be2net: fix data race in be_get_new_eqd
      net: openvswitch: fix data race in ovs_vport_get_upcall_stats

Dmitry Baryshkov (1):
      dt-bindings: power: qcom-rpmpd: split RPMh domains definitions

Dmitry Skorodumov (1):
      ipvlan: Make the addrs_lock be per port

Dragan Simic (1):
      phy: phy-rockchip-inno-usb2: Use dev_err_probe() in the probe path

Emil Svendsen (2):
      ASoC: tlv320adcx140: fix null pointer
      ASoC: tlv320adcx140: fix word length

Eric Dumazet (12):
      net: bridge: annotate data-races around fdb->{updated,used}
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

Ethan Nelson-Moore (2):
      USB: serial: ftdi_sio: add support for PICAXE AXE027 cable
      net: usb: dm9601: remove broken SR9700 support

Felix Gu (1):
      spi: spi-sprd-adi: Fix double free in probe error path

Fernand Sieber (1):
      perf/x86/intel: Do not enable BTS for guests

Fiona Klute (1):
      iio: chemical: scd4x: fix reported channel endianness

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors without event detection

Gal Pressman (1):
      selftests: drv-net: fix RPS mask handling for high CPU numbers

Georgi Djakov (1):
      interconnect: debugfs: initialize src_node and dst_node to empty strings

Geraldo Nascimento (2):
      arm64: dts: rockchip: remove dangerous max-link-speed from helios64
      arm64: dts: rockchip: remove redundant max-link-speed from nanopi-r4s

Greg Kroah-Hartman (1):
      Linux 6.6.122

Hangbin Liu (1):
      selftests/net: convert fib-onlink-tests.sh to run it in unique namespace

Hans de Goede (1):
      leds: led-class: Only Add LED to leds_list when it is fully ready

Haotian Zhang (1):
      dmaengine: omap-dma: fix dma_pool resource leak in error paths

Haoxiang Li (5):
      EDAC/x38: Fix a resource leak in x38_probe1()
      EDAC/i3200: Fix a resource leak in i3200_probe1()
      drm/amdkfd: fix a memory leak in device_queue_manager_init()
      drm/vmwgfx: Fix an error return check in vmw_compat_shader_add()
      w1: fix redundant counter decrement in w1_attach_slave_device()

Huacai Chen (1):
      USB: OHCI/UHCI: Add soft dependencies on ehci_platform

Ian Abbott (2):
      comedi: dmm32at: serialize use of paged registers
      comedi: Fix getting range information for subdevices 16 to 255

Ido Schimmel (1):
      bridge: mcast: Fix use-after-free during router port configuration

Ihor Solodrai (1):
      selftests/bpf: Check for timeout in perf_link test

Ilikara Zheng (1):
      nvme-pci: disable secondary temp for Wodposit WPBSNM8

Ivaylo Ivanov (1):
      phy: phy-snps-eusb2: refactor constructs names

Jacob Keller (1):
      ice: initialize ring_stats->syncp

Jamal Hadi Salim (2):
      net/sched: Enforce that teql can only be used as root qdisc
      net/sched: qfq: Use cl_is_active to determine whether class is active in qfq_rm_from_ag

Janne Grunau (1):
      dmaengine: apple-admac: Add "apple,t8103-admac" compatible

Jaroslav Kysela (1):
      ALSA: pcm: Improve the fix for race of buffer access at PCM OSS layer

Jens Axboe (1):
      io_uring/io-wq: check IO_WQ_BIT_EXIT inside work run loop

Jeongjun Park (1):
      netrom: fix double-free in nr_route_frame()

Jianbo Liu (1):
      xfrm: Fix inner mode lookup in tunnel mode GSO segmentation

Jiasheng Jiang (2):
      btrfs: fix memory leaks in create_space_info() error paths
      scsi: qla2xxx: Sanitize payload size to prevent member overflow

Jijie Shao (2):
      net: hns3: fix wrong GENMASK() for HCLGE_FD_AD_COUNTER_NUM_M
      net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue

Johan Hovold (18):
      ASoC: codecs: wsa884x: fix codec initialisation
      phy: drop probe registration printks
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
      iio: adc: exynos_adc: fix OF populate on driver rebind
      dmaengine: stm32: dmamux: fix device leak on route allocation
      dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
      ASoC: codecs: wsa881x: fix unnecessary initialisation
      ASoC: codecs: wsa883x: fix unnecessary initialisation

Johannes Brüderl (1):
      usb: core: add USB_QUIRK_NO_BOS for devices that hang on BOS descriptor

Johannes Nixdorf (1):
      net: bridge: Set BR_FDB_ADDED_BY_USER early in fdb_add_entry

Keith Busch (1):
      nvme-pci: do not directly handle subsys reset fallout

Konrad Dybcio (3):
      arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links
      dt-bindings: power: qcom,rpmpd: Add SC8280XP_MXC_AO
      pmdomain: qcom: rpmhpd: Add MXC to SC8280XP

Krzysztof Kozlowski (2):
      phy: broadcom: ns-usb3: Fix Wvoid-pointer-to-enum-cast warning (again)
      ASoC: codecs: wsa881x: Drop unused version readout

Kuniyuki Iwashima (4):
      ipv6: Fix use-after-free in inet6_addr_del().
      gue: Fix skb memleak with inner IP protocol 0.
      tools: ynl: Specify --no-line-number in ynl-regen.sh.
      fou: Don't allow 0 for FOU_ATTR_IPPROTO.

Kübrich, Andreas (1):
      iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl

Laurent Vivier (1):
      usbnet: limit max_mtu based on device's hard_mtu

Linus Torvalds (1):
      Fix memory leak in posix_clock_open()

Lisa Robinson (1):
      LoongArch: Fix PMU counter allocation for mixed-type event groups

Loic Poulain (1):
      phy: qcom-qusb2: Fix NULL pointer dereference on early suspend

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

Marc Kleine-Budde (7):
      can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak
      can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error
      can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
      can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
      can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
      can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak
      can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak

Marek Vasut (2):
      drm/panel-simple: fix connector type for DataImage SCF0700C48GGU18 panel
      wifi: rsi: Fix memory corruption due to not set vif driver data size

Mario Limonciello (4):
      drm/amd/display: Bump the HDMI clock to 340MHz
      platform/x86: hp-bioscfg: Fix kobject warnings for empty attribute names
      platform/x86: hp-bioscfg: Fix kernel panic in GET_INSTANCE_ID macro
      platform/x86: hp-bioscfg: Fix automatic module loading

Mario Limonciello (AMD) (1):
      drm/amd: Clean up kfd node on surprise disconnect

Mark Harmstone (1):
      btrfs: fix missing fields in superblock backup with BLOCK_GROUP_TREE

Mark Rutland (1):
      arm64/fpsimd: signal: Allocate SSVE storage when restoring ZA

Markus Koeniger (1):
      iio: accel: iis328dq: fix gain values

Marnix Rijnart (1):
      serial: 8250_pci: Fix broken RS485 for F81504/508/512

Matthew Schwartz (1):
      mmc: rtsx_pci_sdmmc: implement sdmmc_card_busy function

Matthew Wilcox (Oracle) (1):
      migrate: correct lock ordering for hugetlb file folios

Maurizio Lombardi (1):
      nvmet-tcp: remove boilerplate code

Melbin K Mathew (2):
      vsock/virtio: fix potential underflow in virtio_transport_get_credit()
      vsock/virtio: cap TX credit to local buffer size

Miaoqian Lin (1):
      dmaengine: qcom: gpi: Fix memory leak in gpi_peripheral_config()

Michael Kelley (1):
      Drivers: hv: Always do Hyper-V panic notification in hv_kmsg_dump()

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

Neil Armstrong (2):
      i2c: qcom-geni: make sure I2C hub controllers can't use SE DMA
      dt-bindings: power: qcom,rpmpd: document the SM8650 RPMh Power Domains

Niklas Cassel (3):
      ata: libata: Add cpr_log to ata_dev_print_features() early return
      ata: libata: Call ata_dev_config_lpm() for ATAPI devices
      ata: libata: Print features also for ATAPI devices

Nilay Shroff (2):
      null_blk: fix kmemleak by releasing references to fault configfs items
      nvme: fix PCIe subsystem reset controller state transition

Nuno Das Neves (1):
      hyperv-tlfs: Change prefix of generic HV_REGISTER_* MSRs to HV_MSR_*

Ondrej Ille (1):
      can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.

Ondrej Jirman (1):
      arm64: dts: rockchip: Fix voltage threshold for volume keys for Pinephone Pro

Otto Pflüger (1):
      dt-bindings: power: rpmpd: Add MSM8917, MSM8937 and QM215

P Praneesh (1):
      wifi: ath11k: fix RCU stall while reaping monitor destination ring

Pavel Zhigulin (1):
      iio: adc: ad7280a: handle spi_setup() errors in probe()

Pei Xiao (1):
      iio: adc: at91-sama5d2_adc: Fix potential use-after-free in sama5d2_adc driver

Peng Fan (1):
      firmware: imx: scu-irq: Set mu_resource_id before get handle

Philip Yang (1):
      drm/amdgpu: csa unmap use uninterruptible lock

Qu Wenruo (1):
      btrfs: send: check for inline extents in range_is_hole_in_parent()

Rafael Beims (1):
      phy: freescale: imx8m-pcie: assert phy reset during power on

Raju Rangoju (1):
      amd-xgbe: avoid misleading per-packet error log

Rasmus Villemoes (1):
      iio: core: add separate lockdep class for info_exist_lock

Ratheesh Kannoth (1):
      octeontx2-af: Fix error handling

Ricardo B. Marlière (1):
      selftests: net: fib-onlink-tests: Convert to use namespaces by default

Rob Herring (Arm) (1):
      of: platform: Use default match table for /firmware

Robbie Ko (1):
      btrfs: fix deadlock in wait_current_trans() due to ignored transaction type

Russell King (Oracle) (1):
      net: phy: fix phy_uses_state_machine()

Ryan Roberts (1):
      mm: kmsan: fix poisoning of high-order non-compound pages

Saeed Mahameed (1):
      net/mlx5e: Restore destroying state bit after profile cleanup

Samasth Norway Ananda (1):
      ALSA: scarlett2: Fix buffer overflow in config retrieval

Sean Christopherson (1):
      x86/fpu: Clear XSTATE_BV[i] in guest XSAVE state whenever XFD[i]=1

SeongJae Park (3):
      mm/damon/sysfs: cleanup attrs subdirs on context dir setup failure
      mm/damon/sysfs-scheme: cleanup access_pattern subdirs on scheme dir setup failure
      mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir setup failure

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in HS200/HS400 mode

Sheetal (1):
      dmaengine: tegra-adma: Fix use-after-free

Shivam Kumar (1):
      nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec

Sibi Sankar (1):
      dt-bindings: power: rpmpd: Update part number to X1E80100

Stefano Garzarella (2):
      vsock/test: add a final full barrier after run all tests
      vsock/test: fix seqpacket message bounds test

Stefano Radaelli (1):
      phy: fsl-imx8mq-usb: Clear the PCS_TX_SWING_FULL field before using it

Steven Rostedt (1):
      tracing: Fix crash on synthetic stacktrace field usage

Suraj Gupta (1):
      dmaengine: xilinx_dma: Fix uninitialized addr_width when "xlnx,addrwidth" property is missing

Szymon Wilczek (1):
      can: etas_es58x: allow partial RX URB allocation to succeed

Taehee Yoo (1):
      selftests: net: amt: wait longer for connection before sending packets

Taeyang Lee (1):
      crypto: authencesn - reject too-short AAD (assoclen<8) to match ESP/ESN spec

Takashi Iwai (1):
      ALSA: ctxfi: Fix potential OOB access in audio mixer handling

Taniya Das (1):
      dt-bindings: power: qcom,rpmpd: document the SM8750 RPMh Power Domains

Tetsuo Handa (1):
      net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts

Thadeu Lima de Souza Cascardo (1):
      Revert "nfc/nci: Add the inconsistency check between the input data length and count"

Thinh Nguyen (1):
      usb: dwc3: Check for USB4 IP_NAME

Thomas Fourier (3):
      wifi: ath10k: fix dma_free_coherent() pointer
      wifi: ath12k: fix dma_free_coherent() pointer
      octeontx2: Fix otx2_dma_map_page() error return code

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

Vladimir Oltean (3):
      net: dsa: fix off-by-one in maximum bridge ID determination
      net: phy: move phy_link_change() prior to mdio_bus_phy_may_suspend()
      net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY

Vlastimil Babka (1):
      mm/page_alloc: prevent pcp corruption with SMP=n

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

Xin Long (1):
      sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT

Yang Erkun (1):
      ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref

Yang Shen (1):
      uacce: implement mremap in uacce_vm_ops to return -EPERM

Yang Yingliang (1):
      spi: sprd-adi: switch to use spi_alloc_host()

Yun Lu (1):
      netdevsim: fix a race issue related to the operation on bpf_bound_progs list

Zhaoyang Huang (1):
      arm64: Set __nocfi on swsusp_arch_resume()

Zilin Guan (1):
      pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_deviceid_node()

Zqiang (1):
      usbnet: Fix using smp_processor_id() in preemptible code warnings

feng (1):
      Input: i8042 - add quirk for ASUS Zenbook UX425QA_UM425QA

gongqi (1):
      Input: i8042 - add quirks for MECHREVO Wujie 15X Pro


