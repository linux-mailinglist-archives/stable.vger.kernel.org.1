Return-Path: <stable+bounces-212860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNY8HAt/fGk8NgIAu9opvQ
	(envelope-from <stable+bounces-212860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:51:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E14FCB90F7
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4133024A7A
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC21352940;
	Fri, 30 Jan 2026 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RzQ5BrhZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEF32E723;
	Fri, 30 Jan 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769766626; cv=none; b=d6GKiBRHGwx1paKiRzZC3Q/XL6z00MIscdeqh0o6ElOvvlNiRi6WWdbDJjYeiD7ua6F27rPLvfz8lxa1+tq07bdtZakR5MIHXsFaUPPzNRsrLOeVWT4OX0NZQ8UcNe6GbJox2UOApjVRbzFAZKfxmQYoaXOJn4lVm9KTdBQ0uKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769766626; c=relaxed/simple;
	bh=DPgdcFdQEy/NE4hL31KxuaSP6AFKgkZN/8NBV1qz9ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jeHiGEIHF2UmWLv99Dua/rNy3qv18DaVJZbCxAM/IBEojXPj7khzvUbBonczppuvhEEOwabxPlg0MQarHr6Vpt4vbUnsm4ww/3bmG1XTz/2CVRYno4fzZv5UQPfnWc88p5vUfZ7gmozn8pCKUU/+Pz4IuIlU3ZtrUzvY1Sgw/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RzQ5BrhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B171C4CEF7;
	Fri, 30 Jan 2026 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769766626;
	bh=DPgdcFdQEy/NE4hL31KxuaSP6AFKgkZN/8NBV1qz9ZE=;
	h=From:To:Cc:Subject:Date:From;
	b=RzQ5BrhZBxmGKgFUjG7MpimLIM8cyJdRzFvNKjqbUfwVPHQAhdE+KUO0wbTnzAFho
	 3n4se8fkwAvnUlhB5W8WQZQv3Jb3w3ql2Chv1q5cgBvNJooq7Lq1jOPKA8pIYPrREP
	 r+MMQNBtL41P1/a7sOQJdfL8nm2SUxVlWXHytX8I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.8
Date: Fri, 30 Jan 2026 10:50:10 +0100
Message-ID: <2026013010-clicker-greyhound-6185@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212860-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,ynl-regen.sh:url]
X-Rspamd-Queue-Id: E14FCB90F7
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.8 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/netlink/specs/fou.yaml                      |    2 
 Makefile                                                  |    2 
 arch/arm/boot/dts/microchip/sama7d65.dtsi                 |    4 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                    |   16 +-
 arch/arm64/boot/dts/qcom/sm6150.dtsi                      |    4 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                      |    2 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                      |    3 
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts    |    1 
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi       |    1 
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts     |    4 
 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts         |   12 +
 arch/arm64/boot/dts/rockchip/rk3576.dtsi                  |    2 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi             |    4 
 arch/arm64/kernel/hibernate.c                             |    2 
 arch/arm64/kernel/ptrace.c                                |   26 +--
 arch/arm64/kernel/signal.c                                |   26 ++-
 arch/riscv/kernel/suspend.c                               |    3 
 arch/s390/boot/vmlinux.lds.S                              |   17 +-
 arch/x86/events/perf_event.h                              |   13 +
 arch/x86/include/asm/kfence.h                             |   29 +++
 arch/x86/mm/fault.c                                       |   15 --
 crypto/authencesn.c                                       |    6 
 drivers/ata/ahci.c                                        |   10 -
 drivers/ata/libata-core.c                                 |    8 -
 drivers/ata/libata-sata.c                                 |    2 
 drivers/base/regmap/regmap.c                              |    4 
 drivers/block/ublk_drv.c                                  |   39 ++++-
 drivers/bluetooth/btintel_pcie.c                          |   41 +++++
 drivers/bluetooth/btintel_pcie.h                          |    2 
 drivers/clocksource/timer-riscv.c                         |    3 
 drivers/comedi/comedi_fops.c                              |    2 
 drivers/comedi/drivers/dmm32at.c                          |   32 ++++
 drivers/comedi/range.c                                    |    2 
 drivers/dpll/dpll_core.c                                  |   12 -
 drivers/gpio/gpiolib-cdev.c                               |   12 +
 drivers/gpu/drm/Kconfig                                   |    2 
 drivers/gpu/drm/Makefile                                  |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                 |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                    |   12 -
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                |   31 ++--
 drivers/gpu/drm/bridge/synopsys/dw-dp.c                   |   20 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.c                |    8 -
 drivers/gpu/drm/mediatek/mtk_dpi.c                        |   23 +--
 drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/conn.h   |   95 ++++++++++---
 drivers/gpu/drm/nouveau/nouveau_display.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c          |   73 +++++++---
 drivers/gpu/drm/xe/Kconfig                                |    2 
 drivers/gpu/drm/xe/xe_bo.c                                |    9 -
 drivers/gpu/drm/xe/xe_debugfs.c                           |   72 +++++++--
 drivers/gpu/drm/xe/xe_device_types.h                      |   18 ++
 drivers/gpu/drm/xe/xe_exec_queue.c                        |   32 ++++
 drivers/gpu/drm/xe/xe_exec_queue.h                        |    1 
 drivers/gpu/drm/xe/xe_exec_queue_types.h                  |    6 
 drivers/gpu/drm/xe/xe_ggtt.c                              |    2 
 drivers/gpu/drm/xe/xe_guc_ads.c                           |   14 +
 drivers/gpu/drm/xe/xe_guc_ads.h                           |    5 
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h                |    4 
 drivers/gpu/drm/xe/xe_lrc.c                               |    3 
 drivers/gpu/drm/xe/xe_migrate.c                           |    4 
 drivers/gpu/drm/xe/xe_pm.c                                |   21 ++
 drivers/gpu/drm/xe/xe_pm.h                                |   17 ++
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c                      |    2 
 drivers/gpu/drm/xe/xe_vm.c                                |    7 
 drivers/gpu/drm/xe/xe_vm.h                                |    2 
 drivers/hv/hv_common.c                                    |   12 -
 drivers/hwtracing/intel_th/core.c                         |   19 ++
 drivers/i2c/busses/i2c-k1.c                               |    2 
 drivers/iio/accel/adxl380.c                               |    6 
 drivers/iio/accel/st_accel_core.c                         |   72 +++++++++
 drivers/iio/adc/ad7280a.c                                 |    4 
 drivers/iio/adc/ad7606_par.c                              |    3 
 drivers/iio/adc/ad9467.c                                  |    2 
 drivers/iio/adc/at91-sama5d2_adc.c                        |    1 
 drivers/iio/adc/exynos_adc.c                              |   15 --
 drivers/iio/adc/pac1934.c                                 |    6 
 drivers/iio/chemical/scd4x.c                              |    6 
 drivers/iio/dac/ad3552r-hs.c                              |    5 
 drivers/iio/dac/ad5686.c                                  |    6 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              |   15 +-
 drivers/iio/industrialio-core.c                           |    7 
 drivers/input/serio/i8042-acpipnpio.h                     |   18 ++
 drivers/interconnect/debugfs-client.c                     |    5 
 drivers/iommu/amd/iommu.c                                 |    3 
 drivers/iommu/io-pgtable-arm.c                            |    2 
 drivers/irqchip/irq-gic-v3-its.c                          |    8 -
 drivers/irqchip/irq-renesas-rzv2h.c                       |   11 +
 drivers/isdn/mISDN/timerdev.c                             |   13 +
 drivers/leds/led-class.c                                  |   10 -
 drivers/misc/mei/mei-trace.h                              |   18 +-
 drivers/misc/uacce/uacce.c                                |   48 +++++-
 drivers/mmc/host/rtsx_pci_sdmmc.c                         |   41 +++++
 drivers/mmc/host/sdhci-of-dwcmshc.c                       |    7 
 drivers/net/bonding/bond_main.c                           |   11 +
 drivers/net/can/usb/ems_usb.c                             |    8 -
 drivers/net/can/usb/esd_usb.c                             |    9 +
 drivers/net/can/usb/gs_usb.c                              |    7 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c          |    9 +
 drivers/net/can/usb/mcba_usb.c                            |    8 -
 drivers/net/can/usb/usb_8dev.c                            |    8 -
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                  |    5 
 drivers/net/ethernet/broadcom/asp2/bcmasp.c               |    5 
 drivers/net/ethernet/broadcom/asp2/bcmasp.h               |    1 
 drivers/net/ethernet/emulex/benet/be_cmds.c               |    3 
 drivers/net/ethernet/emulex/benet/be_main.c               |    8 -
 drivers/net/ethernet/freescale/fec_main.c                 |   13 -
 drivers/net/ethernet/freescale/ucc_geth.c                 |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           |   69 ++++-----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h    |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |    2 
 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c           |   22 +--
 drivers/net/ethernet/intel/ice/devlink/devlink.c          |    1 
 drivers/net/ethernet/intel/ice/ice.h                      |    1 
 drivers/net/ethernet/intel/ice/ice_common.c               |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c              |    6 
 drivers/net/ethernet/intel/ice/ice_lib.c                  |   29 ++-
 drivers/net/ethernet/intel/ice/ice_main.c                 |   31 +++-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c                |    2 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c               |   16 +-
 drivers/net/ethernet/intel/igc/igc_defines.h              |    5 
 drivers/net/ethernet/intel/igc/igc_ethtool.c              |    4 
 drivers/net/ethernet/intel/igc/igc_main.c                 |    5 
 drivers/net/ethernet/intel/igc/igc_ptp.c                  |   43 +++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c           |   86 ++++++++---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c       |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c       |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h  |    7 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c      |    4 
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c            |    4 
 drivers/net/ipvlan/ipvlan.h                               |    2 
 drivers/net/ipvlan/ipvlan_core.c                          |   16 --
 drivers/net/ipvlan/ipvlan_main.c                          |   49 +++---
 drivers/net/netdevsim/bpf.c                               |    6 
 drivers/net/netdevsim/dev.c                               |    2 
 drivers/net/netdevsim/netdevsim.h                         |    1 
 drivers/net/pcs/pcs-mtk-lynxi.c                           |    4 
 drivers/net/phy/intel-xway.c                              |    7 
 drivers/net/phy/sfp.c                                     |    2 
 drivers/net/usb/dm9601.c                                  |    4 
 drivers/net/usb/usbnet.c                                  |    9 -
 drivers/net/veth.c                                        |    8 -
 drivers/net/wireless/ath/ath10k/ce.c                      |   16 +-
 drivers/net/wireless/ath/ath12k/ce.c                      |   12 -
 drivers/net/wireless/ath/ath12k/mac.c                     |   16 +-
 drivers/net/wireless/ath/ath12k/wmi.c                     |    9 -
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c      |    6 
 drivers/net/wireless/rsi/rsi_91x_mac80211.c               |    1 
 drivers/nfc/virtual_ncidev.c                              |    4 
 drivers/ntb/ntb_transport.c                               |    1 
 drivers/of/base.c                                         |    8 -
 drivers/of/platform.c                                     |    2 
 drivers/platform/mellanox/mlx-platform.c                  |    2 
 drivers/platform/x86/amd/wbrf.c                           |    4 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c              |    8 +
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h              |   12 -
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                     |   11 -
 drivers/pmdomain/qcom/rpmhpd.c                            |    4 
 drivers/pmdomain/rockchip/pm-domains.c                    |   10 +
 drivers/pwm/core.c                                        |   10 -
 drivers/pwm/pwm-max7360.c                                 |    1 
 drivers/s390/crypto/ap_card.c                             |    2 
 drivers/s390/crypto/ap_queue.c                            |    2 
 drivers/scsi/qla2xxx/qla_isr.c                            |    7 
 drivers/scsi/scsi_error.c                                 |   11 +
 drivers/scsi/scsi_lib.c                                   |    8 +
 drivers/scsi/storvsc_drv.c                                |    3 
 drivers/slimbus/core.c                                    |   19 +-
 drivers/spi/spi-sprd-adi.c                                |   33 +---
 drivers/tty/serial/8250/8250_pci.c                        |    2 
 drivers/tty/serial/serial_core.c                          |    6 
 drivers/w1/slaves/w1_therm.c                              |   62 ++------
 drivers/w1/w1.c                                           |    2 
 drivers/xen/xen-scsiback.c                                |    1 
 fs/btrfs/disk-io.c                                        |    2 
 fs/fs-writeback.c                                         |    7 
 fs/fuse/file.c                                            |    4 
 fs/smb/server/transport_rdma.c                            |   15 --
 include/drm/drm_pagemap.h                                 |   19 ++
 include/dt-bindings/power/qcom,rpmhpd.h                   |    1 
 include/linux/hugetlb.h                                   |    2 
 include/linux/iio/iio-opaque.h                            |    2 
 include/linux/pagemap.h                                   |   11 +
 include/trace/events/rxrpc.h                              |    4 
 include/uapi/linux/comedi.h                               |    2 
 io_uring/io-wq.c                                          |    2 
 kernel/events/core.c                                      |    9 +
 kernel/panic.c                                            |    4 
 kernel/sched/fair.c                                       |    6 
 kernel/sched/idle.c                                       |    6 
 kernel/time/clocksource.c                                 |    2 
 kernel/time/timekeeping.c                                 |    2 
 kernel/trace/trace_events_hist.c                          |    9 +
 kernel/trace/trace_events_synth.c                         |    8 -
 mm/damon/sysfs.c                                          |    2 
 mm/gup.c                                                  |    2 
 mm/hugetlb.c                                              |   28 +--
 mm/hugetlb_vmemmap.c                                      |    6 
 mm/internal.h                                             |    8 -
 mm/kmsan/core.c                                           |    2 
 mm/ksm.c                                                  |    2 
 mm/memory-tiers.c                                         |    2 
 mm/memory.c                                               |    4 
 mm/migrate.c                                              |   12 -
 mm/rmap.c                                                 |   20 --
 mm/secretmem.c                                            |    2 
 mm/slab_common.c                                          |    2 
 mm/slub.c                                                 |   10 -
 mm/swapfile.c                                             |    2 
 mm/userfaultfd.c                                          |    2 
 mm/vma.c                                                  |  102 +++++++++-----
 mm/vma.h                                                  |    3 
 mm/vmscan.c                                               |   13 +
 net/dsa/dsa.c                                             |    2 
 net/ipv4/fou_core.c                                       |    3 
 net/ipv4/fou_nl.c                                         |    2 
 net/ipv6/ndisc.c                                          |    4 
 net/l2tp/l2tp_core.c                                      |    8 -
 net/mac80211/scan.c                                       |    9 -
 net/netrom/nr_route.c                                     |   13 +
 net/openvswitch/vport.c                                   |   11 -
 net/rxrpc/ar-internal.h                                   |    9 +
 net/rxrpc/conn_event.c                                    |    2 
 net/rxrpc/output.c                                        |   14 -
 net/rxrpc/peer_event.c                                    |   17 ++
 net/rxrpc/proc.c                                          |    4 
 net/rxrpc/recvmsg.c                                       |   19 ++
 net/rxrpc/rxgk.c                                          |    2 
 net/rxrpc/rxkad.c                                         |    2 
 net/sched/act_ife.c                                       |    6 
 net/sched/sch_qfq.c                                       |    2 
 net/sched/sch_teql.c                                      |    5 
 net/sctp/sm_statefuns.c                                   |   10 -
 net/vmw_vsock/virtio_transport_common.c                   |   36 +++-
 rust/kernel/io.rs                                         |    9 -
 rust/kernel/io/resource.rs                                |    2 
 rust/kernel/irq/flags.rs                                  |    2 
 scripts/kconfig/nconf-cfg.sh                              |   11 -
 security/keys/trusted-keys/trusted_tpm2.c                 |    4 
 sound/hda/codecs/realtek/alc269.c                         |    1 
 sound/pci/ctxfi/ctamixer.c                                |    2 
 sound/usb/mixer.c                                         |   22 ++-
 sound/usb/mixer_scarlett2.c                               |    6 
 tools/net/ynl/ynl-regen.sh                                |    2 
 tools/perf/util/parse-events.c                            |    7 
 tools/testing/selftests/net/amt.sh                        |    7 
 tools/testing/selftests/net/fib-onlink-tests.sh           |   71 ++++-----
 tools/testing/selftests/ublk/kublk.c                      |   11 -
 tools/testing/vsock/util.h                                |    2 
 tools/testing/vsock/vsock_test.c                          |   11 +
 249 files changed, 1889 insertions(+), 875 deletions(-)

Abdun Nihaal (1):
      scsi: xen: scsiback: Fix potential memory leak in scsiback_remove()

Alex Deucher (1):
      drm/amdgpu: fix type for wptr in ring backup

Alex Ramírez (2):
      drm/nouveau: add missing DCB connector types
      drm/nouveau: implement missing DCB connector types; gracefully handle unknown connectors

Alexander Egorenkov (1):
      s390/boot/vmlinux.lds.S: Ensure bzImage ends with SecureBoot trailer

Alexander Usyskin (1):
      mei: trace: treat reg parameter as string

Alexandre Courbot (2):
      rust: io: always inline functions using build_assert with arguments
      rust: irq: always inline functions using build_assert with arguments

Alexey Charkov (2):
      arm64: dts: rockchip: Fix headphones widget name on NanoPi M5
      arm64: dts: rockchip: Configure MCLK for analog sound on NanoPi M5

Alok Tiwari (1):
      octeontx2: cn10k: fix RX flowid TCAM mask handling

Andrew Cooper (1):
      x86/kfence: avoid writing L1TF-vulnerable PTEs

Andrey Vatoropin (1):
      be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list

Andy Shevchenko (1):
      iio: core: Replace lockdep_set_class() + mutex_init() by combined call

Arkadiusz Kozdra (1):
      kconfig: fix static linking of nconf

Arnd Bergmann (1):
      irqchip/gic-v3-its: Avoid truncating memory addresses

Arun Raghavan (1):
      ALSA: usb: Increase volume range that triggers a warning

Baochen Qiang (2):
      wifi: ath12k: don't force radio frequency check in freq_to_idx()
      wifi: ath12k: fix dead lock while flushing management frames

Berk Cem Goksel (1):
      ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_free()

Biju Das (1):
      irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during resume

Brajesh Gupta (1):
      drm/imagination: Wait for FW trace update command completion

Cedric Xing (1):
      x86: make page fault handling disable interrupts properly

Chaitanya Kulkarni (1):
      iommu/io-pgtable-arm: fix size_t signedness bug in unmap path

Chaoyi Chen (1):
      arm64: dts: rockchip: Fix wrong register range of rk3576 gpu

Chen-Yu Tsai (1):
      drm/mediatek: dpi: Find next bridge during probe

Cheng-Yu Lee (1):
      regmap: Fix race condition in hwspinlock irqsave routine

Chenghai Huang (2):
      uacce: fix isolate sysfs check condition
      uacce: ensure safe queue release with state management

Chwee-Lin Choong (2):
      igc: fix race condition in TX timestamp read for register 0
      igc: Reduce TSN TX packet buffer from 7KB to 5KB per queue

Clemens Gruber (1):
      net: fec: account for VLAN header in frame length calculations

Cody Haas (1):
      ice: Fix persistent failure in ice_get_rxfh

Dan Carpenter (1):
      wifi: mwifiex: Fix a loop in mwifiex_update_ampdu_rxwinsize()

Daniel Golle (2):
      net: phy: intel-xway: fix OF node refcount leakage
      net: pcs: pcs-mtk-lynxi: report in-band capability for 2500Base-X

Dave Ertman (1):
      ice: Avoid detrimental cleanup for bond during interface stop

Dave Jiang (1):
      ntb: transport: Fix uninitialized mutex

David Hildenbrand (Red Hat) (3):
      mm/hugetlb: fix hugetlb_pmd_shared()
      mm/rmap: fix two comments related to huge_pmd_unshare()
      mm/hugetlb: fix two comments related to huge_pmd_unshare()

David Howells (2):
      rxrpc: Fix recvmsg() unconditional requeue
      rxrpc: Fix data-race warning and potential load/store tearing

David Jeffery (1):
      scsi: core: Wake up the error handler when final completions race against each other

David Yang (5):
      veth: fix data race in veth_get_ethtool_stats
      net: hns3: fix data race in hns3_fetch_stats
      idpf: Fix data race in idpf_net_dim
      be2net: fix data race in be_get_new_eqd
      net: openvswitch: fix data race in ovs_vport_get_upcall_stats

Ding Hui (1):
      ice: Fix incorrect timeout ice_release_res()

Dmitry Skorodumov (1):
      ipvlan: Make the addrs_lock be per port

Eric Dumazet (6):
      bonding: limit BOND_MODE_8023AD to Ethernet devices
      l2tp: avoid one data-race in l2tp_tunnel_del_work()
      mISDN: annotate data-race around dev->work
      ipv6: annotate data-race in ndisc_router_discovery()
      bonding: provide a net pointer to __skb_flow_dissect()
      net/sched: act_ife: avoid possible NULL deref

Ethan Nelson-Moore (1):
      net: usb: dm9601: remove broken SR9700 support

Faisal Bukhari (1):
      perf parse-events: Fix evsel allocation failure

Fan Gong (1):
      hinic3: Fix netif_queue_set_napi queue_index input parameter error

Felix Gu (1):
      spi: spi-sprd-adi: Fix double free in probe error path

Fernand Sieber (1):
      perf/x86/intel: Do not enable BTS for guests

Fiona Klute (1):
      iio: chemical: scd4x: fix reported channel endianness

Francesco Lavra (2):
      iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors without event detection
      iio: accel: adxl380: fix handling of unavailable "INT1" interrupt

Frank Zhang (1):
      pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON before regulator ready

Gal Pressman (1):
      panic: only warn about deprecated panic_print on write access

Georgi Djakov (1):
      interconnect: debugfs: initialize src_node and dst_node to empty strings

Geraldo Nascimento (2):
      arm64: dts: rockchip: remove redundant max-link-speed from nanopi-r4s
      arm64: dts: rockchip: remove dangerous max-link-speed from helios64

Greg Kroah-Hartman (1):
      Linux 6.18.8

Hamza Mahfooz (1):
      net: sfp: add potron quirk to the H-COM SPP425H-GAB4 SFP+ Stick

Hans de Goede (1):
      leds: led-class: Only Add LED to leds_list when it is fully ready

Haotian Zhang (1):
      iio: adc: ad7606: Fix incorrect type for error return variable

Haoxiang Li (1):
      w1: fix redundant counter decrement in w1_attach_slave_device()

Harald Freudenberger (1):
      s390/ap: Fix wrong APQN fill calculation

Hari Prasath Gujulan Elango (1):
      ARM: dts: microchip: sama7d65: fix the ranges property for flx9

Hariprasad Kelam (2):
      Octeontx2-pf: Update xdp features
      Octeontx2-af: Add proper checks for fwdata

Ian Abbott (2):
      comedi: dmm32at: serialize use of paged registers
      comedi: Fix getting range information for subdevices 16 to 255

Ivan Vecera (1):
      dpll: Prevent duplicate registrations

Jacob Keller (1):
      ice: initialize ring_stats->syncp

Jamal Hadi Salim (2):
      net/sched: Enforce that teql can only be used as root qdisc
      net/sched: qfq: Use cl_is_active to determine whether class is active in qfq_rm_from_ag

Jani Nikula (2):
      drm/xe/xe_late_bind_fw: fix enum xe_late_bind_fw_id kernel-doc
      drm/xe/vm: fix xe_vm_validation_exec() kernel-doc

Jens Axboe (1):
      io_uring/io-wq: check IO_WQ_BIT_EXIT inside work run loop

Jeongjun Park (1):
      netrom: fix double-free in nr_route_frame()

Jiasheng Jiang (1):
      scsi: qla2xxx: Sanitize payload size to prevent member overflow

Jiawen Wu (1):
      net: txgbe: remove the redundant data return in SW-FW mailbox

Jijie Shao (2):
      net: hns3: fix wrong GENMASK() for HCLGE_FD_AD_COUNTER_NUM_M
      net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue

Joanne Koong (1):
      fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()

Johan Hovold (4):
      iio: adc: exynos_adc: fix OF populate on driver rebind
      slimbus: core: fix runtime PM imbalance on report present
      slimbus: core: fix device reference leak on report present
      intel_th: fix device leak on output open()

Justin Chen (1):
      net: bcmasp: Fix network filter wake for asp-3.0

Konrad Dybcio (3):
      arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links
      dt-bindings: power: qcom,rpmpd: Add SC8280XP_MXC_AO
      pmdomain: qcom: rpmhpd: Add MXC to SC8280XP

Krishna Kurapati (2):
      arm64: dts: qcom: sm8550: Fix compile warnings in USB controller node
      arm64: dts: qcom: sm8650: Fix compile warnings in USB controller node

Krzysztof Kozlowski (1):
      serial: Fix not set tty->port race condition

Kuniyuki Iwashima (4):
      l2tp: Fix memleak in l2tp_udp_encap_recv().
      gue: Fix skb memleak with inner IP protocol 0.
      tools: ynl: Specify --no-line-number in ynl-regen.sh.
      fou: Don't allow 0 for FOU_ATTR_IPPROTO.

Kurt Kanzenbach (1):
      igc: Restore default Qbv schedule when changing channels

Kübrich, Andreas (1):
      iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl

Lachlan Hodges (1):
      wifi: mac80211: don't perform DA check on S1G beacon

Laurent Vivier (1):
      usbnet: limit max_mtu based on device's hard_mtu

Likun Gao (1):
      drm/amdgpu: remove frame cntl for gfx v12

Long Li (1):
      scsi: storvsc: Process unsupported MODE_SENSE_10

Lorenzo Stoakes (2):
      mm/vma: fix anon_vma UAF on mremap() faulted, unfaulted merge
      mm/vma: enforce VMA fork limit on unfaulted,faulted mremap merge too

Lukasz Laguna (1):
      drm/xe: Update wedged.mode only after successful reset policy change

Lyude Paul (1):
      drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)

Manish Dharanenthiran (1):
      wifi: ath12k: cancel scan only on active scan vdev

Marc Kleine-Budde (6):
      can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error
      can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
      can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak
      can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
      can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
      can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak

Marco Crivellari (1):
      drm/xe: fix WQ_MEM_RECLAIM passed as max_active to alloc_workqueue()

Marek Vasut (1):
      wifi: rsi: Fix memory corruption due to not set vif driver data size

Mario Limonciello (3):
      platform/x86: hp-bioscfg: Fix kobject warnings for empty attribute names
      platform/x86: hp-bioscfg: Fix kernel panic in GET_INSTANCE_ID macro
      platform/x86: hp-bioscfg: Fix automatic module loading

Mark Harmstone (1):
      btrfs: fix missing fields in superblock backup with BLOCK_GROUP_TREE

Mark Rutland (3):
      arm64/fpsimd: ptrace: Fix SVE writes on !SME systems
      arm64/fpsimd: signal: Allocate SSVE storage when restoring ZA
      arm64/fpsimd: signal: Fix restoration of SVE context

Markus Koeniger (1):
      iio: accel: iis328dq: fix gain values

Marnix Rijnart (1):
      serial: 8250_pci: Fix broken RS485 for F81504/508/512

Matt Roper (1):
      drm/xe/pm: Add scope-based cleanup helper for runtime PM

Matthew Auld (2):
      drm/xe/uapi: disallow bind queue sharing
      drm/xe/migrate: fix job lock assert

Matthew Brost (2):
      drm/xe: Disable timestamp WA on VFs
      drm/xe: Adjust page count tracepoints in shrinker

Matthew Schwartz (1):
      mmc: rtsx_pci_sdmmc: implement sdmmc_card_busy function

Matthew Wilcox (Oracle) (1):
      migrate: correct lock ordering for hugetlb file folios

Maxime Chevallier (1):
      net: freescale: ucc_geth: Return early when TBI PHY can't be found

Melbin K Mathew (2):
      vsock/virtio: fix potential underflow in virtio_transport_get_credit()
      vsock/virtio: cap TX credit to local buffer size

Miaoqian Lin (1):
      iio: dac: ad3552r-hs: fix out-of-bound write in ad3552r_hs_write_data_source

Michael Kelley (1):
      Drivers: hv: Always do Hyper-V panic notification in hv_kmsg_dump()

Michal Luczaj (2):
      vsock/virtio: Coalesce only linear skb
      vsock/test: Do not filter kallsyms by symbol type

Mina Almasry (1):
      idpf: read lower clock bits inside the time sandwich

Ming Lei (3):
      selftests/ublk: fix IO thread idle check
      selftests/ublk: fix error handling for starting device
      selftests/ublk: fix garbage output in foreground mode

Ming Qian (1):
      pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu

Naohiko Shimizu (2):
      riscv: clocksource: Fix stimecmp update hazard on RV32
      riscv: suspend: Fix stimecmp update hazard on RV32

Nicolas Ferre (1):
      ARM: dts: microchip: sama7d65: fix size-cells property for i2c3

Niklas Cassel (6):
      ata: ahci: Do not read the per port area for unimplemented ports
      ata: libata: Call ata_dev_config_lpm() for ATAPI devices
      ata: libata-sata: Improve link_power_management_supported sysfs attribute
      ata: libata: Add cpr_log to ata_dev_print_features() early return
      ata: libata: Add DIPM and HIPM to ata_dev_print_features() early return
      ata: libata: Print features also for ATAPI devices

Oleksandr Shamray (1):
      platform/mellanox: Fix SN5640/SN5610 LED platform data

Ondrej Jirman (1):
      arm64: dts: rockchip: Fix voltage threshold for volume keys for Pinephone Pro

Osama Abdelkader (1):
      drm/bridge: synopsys: dw-dp: fix error paths of dw_dp_bind

Paul Greenwalt (2):
      ice: add missing ice_deinit_hw() in devlink reinit path
      ice: fix devlink reload call trace

Pavel Zhigulin (1):
      iio: adc: ad7280a: handle spi_setup() errors in probe()

Pei Xiao (1):
      iio: adc: at91-sama5d2_adc: Fix potential use-after-free in sama5d2_adc driver

Pradeep P V K (1):
      arm64: dts: qcom: talos: Correct UFS clocks ordering

Quentin Schulz (1):
      arm64: dts: rockchip: fix unit-address for RK3588 NPU's core1 and core2's IOMMU

Raju Rangoju (1):
      amd-xgbe: avoid misleading per-packet error log

Rasmus Villemoes (1):
      iio: core: add separate lockdep class for info_exist_lock

Ratheesh Kannoth (1):
      octeontx2-af: Fix error handling

Ravindra (1):
      Bluetooth: btintel_pcie: Support for S4 (Hibernate)

Ricardo B. Marlière (1):
      selftests: net: fib-onlink-tests: Convert to use namespaces by default

Richard Genoud (1):
      pwm: max7360: Populate missing .sizeof_wfhw in max7360_pwm_ops

Rob Herring (Arm) (1):
      of: platform: Use default match table for /firmware

Samasth Norway Ananda (1):
      ALSA: scarlett2: Fix buffer overflow in config retrieval

Seamus Connor (1):
      ublk: fix ublksrv pid handling for pid namespaces

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in HS200/HS400 mode

Srish Srinivasan (1):
      keys/trusted_keys: fix handle passed to tpm_buf_append_name during unseal

Stefano Garzarella (1):
      vsock/test: fix seqpacket message bounds test

Steven Rostedt (1):
      tracing: Fix crash on synthetic stacktrace field usage

Swaraj Gaikwad (1):
      slab: fix kmalloc_nolock() context check for PREEMPT_RT

Taehee Yoo (1):
      selftests: net: amt: wait longer for connection before sending packets

Taeyang Lee (1):
      crypto: authencesn - reject too-short AAD (assoclen<8) to match ESP/ESN spec

Takashi Iwai (1):
      ALSA: ctxfi: Fix potential OOB access in audio mixer handling

Thadeu Lima de Souza Cascardo (1):
      Revert "nfc/nci: Add the inconsistency check between the input data length and count"

Thomas Fourier (4):
      wifi: ath10k: fix dma_free_coherent() pointer
      wifi: ath12k: fix dma_free_coherent() pointer
      ksmbd: smbd: fix dma_unmap_sg() nents
      octeontx2: Fix otx2_dma_map_page() error return code

Thomas Gleixner (1):
      clocksource: Reduce watchdog readout delay limit to prevent false positives

Thomas Hellström (1):
      drm, drm/xe: Fix xe userptr in the absence of CONFIG_DEVICE_PRIVATE

Thomas Weißschuh (1):
      timekeeping: Adjust the leap state for the correct auxiliary timekeeper

Thorsten Blum (2):
      w1: therm: Fix off-by-one buffer overflow in alarms_store
      iio: adc: pac1934: Fix clamped value in pac1934_reg_snapshot

Timur Kristóf (3):
      drm/amd/pm: Fix si_dpm mmCG_THERMAL_INT setting
      drm/amd/pm: Don't clear SI SMC table when setting power limit
      drm/amd/pm: Workaround SI powertune issue on Radeon 430 (v2)

Tomas Melin (1):
      iio: adc: ad9467: fix ad9434 vref mask

Tzung-Bi Shih (3):
      gpio: cdev: Correct return code on memory allocation failure
      gpio: cdev: Fix resource leaks on errors in lineinfo_changed_notify()
      gpio: cdev: Fix resource leaks on errors in gpiolib_cdev_register()

Uwe Kleine-König (1):
      pwm: Ensure ioctl() returns a negative errno on error

Vasant Hegde (1):
      iommu/amd: Fix error path in amd_iommu_probe_device()

Vincent Guittot (1):
      sched/fair: Fix pelt clock sync when entering idle

Vladimir Oltean (1):
      net: dsa: fix off-by-one in maximum bridge ID determination

Weigang He (1):
      of: fix reference count leak in of_alias_scan()

Wenkai Lin (1):
      uacce: fix cdev handling in the cleanup path

Will Rosenberg (1):
      perf: Fix refcount warning on event->mmap_count increment

Xin Long (1):
      sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT

Yang Shen (1):
      uacce: implement mremap in uacce_vm_ops to return -EPERM

Yingying Tang (2):
      wifi: ath12k: Fix scan state stuck in ABORTING after cancel_remain_on_channel
      wifi: ath12k: Fix wrong P2P device link id issue

Yixun Lan (1):
      i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request

Yosry Ahmed (1):
      mm: restore per-memcg proactive reclaim with !CONFIG_NUMA

Yun Lu (1):
      netdevsim: fix a race issue related to the operation on bpf_bound_progs list

Zhang Heng (1):
      ALSA: hda/realtek: Add quirk for Samsung 730QED to fix headphone

Zhaoyang Huang (1):
      arm64: Set __nocfi on swsusp_arch_resume()

Zilin Guan (1):
      platform/x86/amd: Fix memory leak in wbrf_record()

feng (1):
      Input: i8042 - add quirk for ASUS Zenbook UX425QA_UM425QA

gongqi (1):
      Input: i8042 - add quirks for MECHREVO Wujie 15X Pro

jianyun.gao (1):
      mm: fix some typos in mm module


