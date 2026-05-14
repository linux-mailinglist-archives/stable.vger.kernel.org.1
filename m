Return-Path: <stable+bounces-247212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJGwLNfdBWokcgIAu9opvQ
	(envelope-from <stable+bounces-247212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:36:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A37543369
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 225D3306CF0B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4BF28AAEB;
	Thu, 14 May 2026 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="og8R6QNm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA863DCDAB;
	Thu, 14 May 2026 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768628; cv=none; b=Xxl0bxsieb4OkWg3+aVfcmQSPkGhD33jQK0JY8JLRkEKN2LENfjCk7bro5v9MvRiEEMI9r9GXyyMI2cLEFkNwnxvYh/s7HSIWHL5eXD8nPWT4tyANauvrt5JUIkhYdc9Uq9baPKr4e/SXV2CVtlmf2sAyzcIUZtotI8KQ9NW1eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768628; c=relaxed/simple;
	bh=ZTO8tkfCUr+kxpaNKPZanLii8P9irZ1OUtZirIcqBsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rb6sevYI2vGYAic0I2aWCLtT2LOqFaCI1n9onf8azpbNxvt3nsjR3CRLfdRtssLPYKoZAIEivohQjv/TxbVflOy81PGA1A248DeqUrvvdISXJZw1PlsFKSkGCYd5wYlwC8tWrjgYdIQGYh05FXJw6WOv8nwYP/MFLzAWgKS/QIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=og8R6QNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20F8C2BCB3;
	Thu, 14 May 2026 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778768628;
	bh=ZTO8tkfCUr+kxpaNKPZanLii8P9irZ1OUtZirIcqBsM=;
	h=From:To:Cc:Subject:Date:From;
	b=og8R6QNmqnynbGAkMU81Ojh60knXrgNeQsakRUxlGg8qbGqEdMcsF0C2OZt/Boxg9
	 LqZlEOxGfUiWpbDeNnw9x19NIJrnE3kcCeNrd/JB4PIx3ntrzVia45vCvYNJ/ezzxy
	 yQ+C8N1zDDK3xXd6Pz36P2jZLv5PCdx1hsbEnFn4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.0.7
Date: Thu, 14 May 2026 16:23:50 +0200
Message-ID: <2026051451-frightful-buffalo-8217@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 64A37543369
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247212-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.946];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I'm announcing the release of the 7.0.7 kernel.

All users of the 7.0 kernel series must upgrade.

The updated 7.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/obsolete/sysfs-selinux-user                  |   12 
 Documentation/ABI/removed/sysfs-selinux-user                   |   12 
 Makefile                                                       |    4 
 arch/arm64/include/asm/kvm_host.h                              |    2 
 arch/arm64/kernel/ptrace.c                                     |    4 
 arch/arm64/kernel/signal.c                                     |   54 +
 arch/arm64/kvm/arm.c                                           |    4 
 arch/arm64/kvm/config.c                                        |   17 
 arch/arm64/kvm/hyp/nvhe/pkvm.c                                 |   38 -
 arch/arm64/kvm/hyp/nvhe/setup.c                                |    6 
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                             |    2 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                             |    2 
 arch/loongarch/Kbuild                                          |    2 
 arch/loongarch/include/asm/asm-prototypes.h                    |   20 
 arch/loongarch/include/asm/kvm_host.h                          |    3 
 arch/loongarch/include/asm/linkage.h                           |    2 
 arch/loongarch/kvm/Makefile                                    |    3 
 arch/loongarch/kvm/exit.c                                      |    1 
 arch/loongarch/kvm/interrupt.c                                 |   14 
 arch/loongarch/kvm/main.c                                      |   35 -
 arch/loongarch/kvm/mmu.c                                       |    2 
 arch/loongarch/kvm/switch.S                                    |   22 
 arch/loongarch/kvm/timer.c                                     |   10 
 arch/loongarch/kvm/vm.c                                        |    2 
 arch/loongarch/pci/acpi.c                                      |    5 
 arch/loongarch/pci/pci.c                                       |    3 
 arch/powerpc/kexec/Makefile                                    |    2 
 arch/powerpc/platforms/pseries/papr-hvpipe.c                   |  122 ++--
 arch/powerpc/sysdev/xive/common.c                              |   16 
 arch/riscv/kvm/vcpu_vector.c                                   |    5 
 arch/s390/kernel/debug.c                                       |    8 
 arch/x86/events/core.c                                         |   13 
 arch/x86/events/intel/core.c                                   |   50 +
 arch/x86/events/perf_event.h                                   |   10 
 arch/x86/include/asm/efi.h                                     |    3 
 arch/x86/include/asm/msr-index.h                               |    3 
 arch/x86/kernel/cpu/amd.c                                      |    3 
 arch/x86/kernel/e820.c                                         |    6 
 arch/x86/kvm/hyperv.c                                          |    2 
 arch/x86/kvm/lapic.c                                           |    8 
 arch/x86/kvm/mmu/mmu.c                                         |   35 -
 arch/x86/mm/fault.c                                            |    2 
 arch/x86/platform/efi/quirks.c                                 |   13 
 block/blk-zoned.c                                              |  151 ++---
 block/blk.h                                                    |    2 
 block/ioctl.c                                                  |   24 
 drivers/accel/ivpu/ivpu_drv.c                                  |   21 
 drivers/acpi/arm64/cpuidle.c                                   |   10 
 drivers/acpi/cppc_acpi.c                                       |    6 
 drivers/acpi/power.c                                           |    2 
 drivers/acpi/scan.c                                            |    2 
 drivers/acpi/video_detect.c                                    |   16 
 drivers/android/binder/range_alloc/array.rs                    |    1 
 drivers/bluetooth/btmtk.c                                      |   15 
 drivers/bluetooth/virtio_bt.c                                  |   39 +
 drivers/char/ipmi/ipmi_si_intf.c                               |   70 ++
 drivers/char/ipmi/ipmi_ssif.c                                  |   23 
 drivers/clk/clk-rk808.c                                        |    2 
 drivers/clk/imx/clk-imx8-acm.c                                 |    3 
 drivers/clk/microchip/clk-mpfs-ccc.c                           |    6 
 drivers/cpuidle/cpuidle-powernv.c                              |    5 
 drivers/cpuidle/cpuidle-pseries.c                              |    5 
 drivers/crypto/caam/caamalg_qi2.c                              |    4 
 drivers/crypto/caam/caamhash.c                                 |    4 
 drivers/crypto/intel/qat/qat_common/adf_accel_engine.c         |    7 
 drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h |    1 
 drivers/crypto/intel/qat/qat_common/qat_hal.c                  |   27 
 drivers/extcon/extcon-ptn5150.c                                |   14 
 drivers/gpio/gpiolib-of.c                                      |    9 
 drivers/hv/Kconfig                                             |    2 
 drivers/hwmon/corsair-psu.c                                    |    4 
 drivers/hwmon/ltc2992.c                                        |   43 +
 drivers/infiniband/hw/hns/hns_roce_qp.c                        |    7 
 drivers/infiniband/hw/ionic/ionic_ibdev.c                      |    2 
 drivers/infiniband/hw/mana/cq.c                                |    5 
 drivers/infiniband/hw/mana/qp.c                                |   16 
 drivers/infiniband/hw/mlx4/srq.c                               |    4 
 drivers/infiniband/hw/mlx5/main.c                              |    1 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c                    |    4 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c                |    2 
 drivers/infiniband/sw/rxe/rxe_recv.c                           |   11 
 drivers/infiniband/sw/rxe/rxe_resp.c                           |   14 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                    |    7 
 drivers/iommu/intel/nested.c                                   |    6 
 drivers/iommu/iommufd/eventq.c                                 |    5 
 drivers/iommu/iommufd/io_pagetable.c                           |   10 
 drivers/md/dm-ioctl.c                                          |    6 
 drivers/md/dm-verity-fec.c                                     |  113 +---
 drivers/md/dm-verity-fec.h                                     |    3 
 drivers/md/persistent-data/dm-btree-remove.c                   |    8 
 drivers/md/raid10.c                                            |    2 
 drivers/mmc/core/card.h                                        |   11 
 drivers/mmc/core/mmc.c                                         |   12 
 drivers/mmc/core/queue.c                                       |    9 
 drivers/mmc/core/quirks.h                                      |   12 
 drivers/mtd/spi-nor/debugfs.c                                  |    4 
 drivers/net/ethernet/ibm/ibmveth.c                             |   22 
 drivers/net/ethernet/ibm/ibmveth.h                             |    1 
 drivers/net/ethernet/intel/ice/ice_sf_eth.c                    |    2 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c        |   36 +
 drivers/net/ethernet/mellanox/mlx4/srq.c                       |   13 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/common.h                   |    2 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c              |   41 -
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                     |    7 
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c              |    4 
 drivers/net/wireless/ath/ath5k/base.c                          |    3 
 drivers/net/wireless/broadcom/b43/xmit.c                       |    3 
 drivers/net/wireless/broadcom/b43legacy/xmit.c                 |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c        |    6 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c               |    7 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                |    4 
 drivers/net/wireless/rsi/rsi_common.h                          |    5 
 drivers/net/wwan/t7xx/t7xx_modem_ops.c                         |   20 
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c                     |   18 
 drivers/net/wwan/t7xx/t7xx_port_proxy.h                        |    2 
 drivers/nvme/host/apple.c                                      |    6 
 drivers/nvme/target/core.c                                     |    2 
 drivers/nvme/target/tcp.c                                      |   26 
 drivers/parisc/lasi.c                                          |   12 
 drivers/pci/pci.c                                              |    7 
 drivers/pci/pcie/aer.c                                         |    2 
 drivers/pci/pcie/aspm.c                                        |   17 
 drivers/pci/setup-res.c                                        |    2 
 drivers/platform/chrome/cros_typec_altmode.c                   |    1 
 drivers/pmdomain/core.c                                        |   10 
 drivers/pmdomain/mediatek/mtk-pm-domains.c                     |   10 
 drivers/power/supply/max17042_battery.c                        |    2 
 drivers/remoteproc/imx_rproc.c                                 |    2 
 drivers/remoteproc/ti_k3_common.c                              |    2 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                           |   14 
 drivers/spi/spi-microchip-core-qspi.c                          |  103 +++
 drivers/spi/spi-microchip-core-spi.c                           |    4 
 drivers/spi/spi-rockchip.c                                     |    4 
 drivers/spi/spi-s3c64xx.c                                      |    5 
 drivers/spi/spi-sun4i.c                                        |   10 
 drivers/spi/spi-sun6i.c                                        |    8 
 drivers/spi/spi-synquacer.c                                    |    8 
 drivers/spi/spi-tegra114.c                                     |    8 
 drivers/spi/spi-tegra20-sflash.c                               |    8 
 drivers/spi/spi-ti-qspi.c                                      |   14 
 drivers/spi/spi-topcliff-pch.c                                 |   11 
 drivers/spi/spi-zynq-qspi.c                                    |   15 
 drivers/spi/spi-zynqmp-gqspi.c                                 |    4 
 drivers/staging/rtl8723bs/os_dep/osdep_service.c               |    3 
 drivers/staging/vme_user/vme_fake.c                            |    2 
 drivers/target/target_core_configfs.c                          |    2 
 drivers/thermal/sprd_thermal.c                                 |    4 
 drivers/thermal/thermal_core.c                                 |    6 
 drivers/usb/class/usblp.c                                      |    3 
 drivers/usb/common/ulpi.c                                      |    5 
 drivers/usb/dwc3/core.c                                        |   12 
 drivers/usb/gadget/udc/omap_udc.c                              |    4 
 drivers/usb/serial/option.c                                    |    4 
 drivers/usb/typec/tcpm/tcpm.c                                  |   25 
 drivers/video/fbdev/core/fbcon_rotate.c                        |    5 
 drivers/video/fbdev/udlfb.c                                    |   31 +
 fs/btrfs/inode.c                                               |    8 
 fs/btrfs/ioctl.c                                               |    5 
 fs/btrfs/space-info.c                                          |    6 
 fs/f2fs/data.c                                                 |   28 -
 fs/f2fs/extent_cache.c                                         |   17 
 fs/f2fs/f2fs.h                                                 |    5 
 fs/f2fs/inline.c                                               |   22 
 fs/f2fs/inode.c                                                |    2 
 fs/f2fs/node.c                                                 |   93 +--
 fs/f2fs/super.c                                                |   11 
 fs/f2fs/sysfs.c                                                |   10 
 fs/hfsplus/bfind.c                                             |   51 +
 fs/hfsplus/catalog.c                                           |    4 
 fs/hfsplus/dir.c                                               |    2 
 fs/hfsplus/hfsplus_fs.h                                        |    9 
 fs/hfsplus/super.c                                             |    6 
 fs/isofs/export.c                                              |    2 
 fs/isofs/rock.c                                                |    9 
 fs/notify/fsnotify.c                                           |    2 
 fs/notify/mark.c                                               |   18 
 fs/overlayfs/util.c                                            |    2 
 fs/smb/client/cached_dir.c                                     |    8 
 fs/smb/client/cifsacl.c                                        |   37 +
 fs/smb/client/smb2inode.c                                      |   12 
 fs/smb/client/smb2misc.c                                       |    3 
 fs/smb/client/smb2ops.c                                        |   11 
 fs/smb/client/smbdirect.c                                      |   21 
 fs/smb/server/connection.c                                     |   46 +
 fs/smb/server/connection.h                                     |    1 
 fs/smb/server/smbacl.c                                         |   66 +-
 fs/tracefs/event_inode.c                                       |   14 
 fs/tracefs/inode.c                                             |    6 
 fs/tracefs/internal.h                                          |    3 
 fs/udf/misc.c                                                  |    8 
 include/linux/fsnotify_backend.h                               |    1 
 include/linux/if_vlan.h                                        |   25 
 include/linux/mmc/card.h                                       |    2 
 include/linux/printk.h                                         |   13 
 include/linux/rseq.h                                           |    2 
 include/uapi/linux/io_uring.h                                  |    3 
 include/uapi/linux/rseq.h                                      |    5 
 include/video/udlfb.h                                          |    1 
 io_uring/kbuf.c                                                |    8 
 io_uring/kbuf.h                                                |    7 
 io_uring/tw.c                                                  |   12 
 kernel/bpf/arena.c                                             |   19 
 kernel/exit.c                                                  |    1 
 kernel/rseq.c                                                  |   29 -
 kernel/sched/ext.c                                             |   19 
 kernel/sched/ext_idle.c                                        |   12 
 kernel/trace/fprobe.c                                          |  271 ++++++----
 kernel/trace/trace_probe.c                                     |    6 
 kernel/trace/trace_probe.h                                     |    4 
 kernel/tracepoint.c                                            |    2 
 lib/crc/Kconfig                                                |    7 
 lib/crc/tests/crc_kunit.c                                      |   28 -
 lib/crypto/mpi/mpicoder.c                                      |    2 
 lib/scatterlist.c                                              |    8 
 mm/damon/lru_sort.c                                            |   85 ++-
 mm/damon/reclaim.c                                             |   85 ++-
 mm/damon/stat.c                                                |   30 -
 mm/damon/sysfs-schemes.c                                       |   24 
 mm/hugetlb_cma.c                                               |    1 
 net/8021q/vlan_dev.c                                           |   45 -
 net/8021q/vlan_netlink.c                                       |   10 
 net/8021q/vlanproc.c                                           |   12 
 net/bluetooth/hci_conn.c                                       |   19 
 net/bluetooth/hci_event.c                                      |   27 
 net/bluetooth/l2cap_sock.c                                     |    9 
 net/ceph/auth.c                                                |    2 
 net/ceph/mon_client.c                                          |    2 
 net/core/flow_dissector.c                                      |   13 
 net/core/netpoll.c                                             |   23 
 net/core/rtnetlink.c                                           |    1 
 net/ipv4/ah4.c                                                 |   14 
 net/ipv6/ah6.c                                                 |   14 
 net/ipv6/ip6_gre.c                                             |    5 
 net/ipv6/xfrm6_protocol.c                                      |    4 
 net/mac80211/mlme.c                                            |    9 
 net/mac80211/rx.c                                              |    2 
 net/mac80211/util.c                                            |    4 
 net/mptcp/fastopen.c                                           |    4 
 net/mptcp/pm.c                                                 |   62 +-
 net/mptcp/pm_kernel.c                                          |   14 
 net/mptcp/protocol.c                                           |    3 
 net/mptcp/sockopt.c                                            |   16 
 net/mptcp/subflow.c                                            |    4 
 net/openvswitch/vport-netdev.c                                 |    6 
 net/psp/psp_main.c                                             |   42 +
 net/rds/message.c                                              |   20 
 net/sched/sch_red.c                                            |    2 
 net/unix/af_unix.c                                             |    3 
 net/vmw_vsock/hyperv_transport.c                               |   33 -
 net/xfrm/xfrm_state.c                                          |   12 
 net/xfrm/xfrm_user.c                                           |    1 
 rust/kernel/drm/gem/mod.rs                                     |   13 
 rust/pin-init/internal/src/init.rs                             |  184 +++---
 rust/pin-init/src/__internal.rs                                |   28 -
 security/selinux/hooks.c                                       |   38 -
 security/selinux/include/objsec.h                              |    4 
 security/selinux/include/security.h                            |    2 
 security/selinux/selinuxfs.c                                   |  196 +------
 security/selinux/ss/services.c                                 |  125 ----
 sound/core/misc.c                                              |    8 
 sound/core/oss/pcm_oss.c                                       |   29 -
 sound/core/seq/seq_clientmgr.c                                 |    2 
 sound/core/seq/seq_clientmgr.h                                 |    5 
 sound/core/seq/seq_ump_client.c                                |    2 
 sound/firewire/tascam/tascam-hwdep.c                           |    1 
 sound/hda/codecs/realtek/alc269.c                              |   19 
 sound/hda/codecs/side-codecs/cs35l56_hda.c                     |   19 
 sound/soc/amd/yc/acp6x-mach.c                                  |   14 
 sound/soc/codecs/es8389.c                                      |    2 
 sound/soc/fsl/fsl_easrc.c                                      |    2 
 sound/soc/intel/boards/bytcr_wm5102.c                          |    1 
 sound/soc/qcom/qdsp6/q6apm-dai.c                               |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                        |    2 
 sound/soc/qcom/qdsp6/q6apm.c                                   |    3 
 sound/soc/sof/compress.c                                       |    3 
 sound/usb/midi2.c                                              |    9 
 sound/usb/misc/ua101.c                                         |    7 
 sound/usb/stream.c                                             |    4 
 tools/arch/x86/include/asm/msr-index.h                         |    3 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                 |   16 
 tools/testing/selftests/net/mptcp/pm_netlink.sh                |   20 
 tools/testing/selftests/rseq/Makefile                          |   21 
 tools/testing/selftests/rseq/check_optimized.c                 |   17 
 tools/testing/selftests/rseq/legacy_check.c                    |   65 ++
 tools/testing/selftests/rseq/param_test.c                      |   25 
 tools/testing/selftests/rseq/rseq-abi.h                        |    7 
 tools/testing/selftests/rseq/rseq.c                            |   39 -
 tools/testing/selftests/rseq/rseq.h                            |    8 
 tools/testing/selftests/rseq/run_legacy_check.sh               |    4 
 tools/testing/selftests/rseq/run_param_test.sh                 |   39 +
 tools/testing/selftests/rseq/run_timeslice_test.sh             |   14 
 tools/testing/selftests/rseq/slice_test.c                      |   12 
 296 files changed, 3086 insertions(+), 1633 deletions(-)

Aaro Koskinen (1):
      USB: omap_udc: DMA: Don't enable burst 4 mode

Alexei Starovoitov (1):
      bpf: Fix use-after-free in arena_vm_close on fork

André Draszik (1):
      power: supply: max17042: avoid overflow when determining health

Ard Biesheuvel (1):
      x86/efi: Restore IRQ state in EFI page fault handler

Avri Altman (2):
      mmc: core: Adjust MDT beyond 2025
      mmc: core: Add quirk for incorrect manufacturing date

Bartosz Golaszewski (1):
      gpio: of: clear OF_POPULATED on hog nodes in remove path

Benjamin Berg (1):
      wifi: mac80211: use safe list iteration in radar detect work

Bibo Mao (2):
      LoongArch: KVM: Fix HW timer interrupt lost when inject interrupt by software
      LoongArch: KVM: Move unconditional delay into timer clear scenery

Bjoern Doebel (1):
      smb: client: use kzalloc to zero-initialize security descriptor buffer

Breno Leitao (3):
      ACPI: arm64: cpuidle: Tolerate platforms with no deep PSCI idle states
      netpoll: pass buffer size to egress_dev() to avoid MAC truncation
      arm64/fpsimd: ptrace: zero target's fpsimd_state, not the tracer's

Catherine (1):
      wifi: mac80211: drop stray 'static' from fast-RX rx_result

Cen Zhang (1):
      f2fs: add READ_ONCE() for i_blocks in f2fs_update_inode()

Chaitanya Kulkarni (2):
      nvmet-tcp: fix race between ICReq handling and queue teardown
      nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free

Chao Yu (1):
      f2fs: fix false alarm of lockdep on cp_global_sem lock

Chen Ni (2):
      remoteproc: imx_rproc: Fix NULL vs IS_ERR() bug in imx_rproc_addr_init()
      remoteproc: k3: Fix NULL vs IS_ERR() bug in k3_reserved_mem_init()

Christian A. Ehrhardt (2):
      lib/scatterlist: fix length calculations in extract_kvec_to_sg
      lib/scatterlist: fix temp buffer in extract_user_to_sg()

Colin Walters (1):
      ovl: fix verity lazy-load guard broken by fsverity_active() semantic change

Conor Dooley (3):
      spi: microchip-core-qspi: don't attempt to transmit during emulated read-only dual/quad operations
      spi: microchip-core-qspi: control built-in cs manually
      clk: microchip: mpfs-ccc: fix out of bounds access during output registration

Corey Minyard (3):
      ipmi: Add limits to event and receive message requests
      ipmi: Check event message buffer response for bad data
      ipmi:si: Return state to normal if message allocation fails

Cássio Gabriel (7):
      ALSA: usb-audio: midi2: Restart output URBs on resume
      ALSA: usb-audio: Fix UAC3 cluster descriptor size check
      ALSA: hda: cs35l56: Propagate ASP TX source control errors
      ALSA: firewire-tascam: Do not drop unread control events
      ALSA: core: Serialize deferred fasync state checks
      ALSA: seq: Fix UMP group 16 filtering
      ASoC: Intel: bytcr_wm5102: Fix MCLK leak on platform_clock_control error

DaeMyung Kang (1):
      ksmbd: rewrite stop_sessions() with restartable iteration

Damien Le Moal (1):
      block: fix zone write plug removal

Dapeng Mi (4):
      perf/x86/intel: Improve validation and configuration of ACR masks
      perf/x86/intel: Always reprogram ACR events to prevent stale masks
      perf/x86/intel: Disable PMI for self-reloaded ACR events
      perf/x86/intel: Enable auto counter reload for DMR

David Carlier (7):
      tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()
      Bluetooth: hci_conn: fix potential UAF in create_big_sync
      tracefs: Fix default permissions not being applied on initial mount
      eventfs: Hold eventfs_mutex and SRCU when remount walks events
      psp: strip variable-length PSP header in psp_dev_rcv()
      sched_ext: idle: Recheck prev_cpu after narrowing allowed mask
      octeon_ep_vf: add NULL check for napi_build_skb()

David Gow (1):
      x86/boot/e820: Re-enable BIOS fallback if e820 table is empty

David Windsor (1):
      selinux: don't reserve xattr slot when we won't fill it

David Woodhouse (1):
      KVM: arm64: vgic: Fix IIDR revision field extracted from wrong value

Deepanshu Kartikey (1):
      hfsplus: fix uninit-value by validating catalog record size

Dexuan Cui (2):
      hv_sock: Report EOF instead of -EIO for FIN
      hv_sock: Return -EIO for malformed/short packets

Eliot Courtney (1):
      rust: drm: gem: clean up GEM state in init failure case

Eric Biggers (6):
      dm-verity-fec: correctly reject too-small FEC devices
      dm-verity-fec: correctly reject too-small hash devices
      dm-verity-fec: fix corrected block count stat
      dm-verity-fec: fix reading parity bytes split across blocks (take 3)
      dm-verity-fec: fix the size of dm_verity_fec_io::erasures
      lib/crc: tests: Make crc_kunit test only the enabled CRC variants

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion LE910Cx compositions

Fedor Pchelkin (1):
      nvme-apple: drop invalid put of admin queue reference count

Felix Gu (1):
      usb: ulpi: fix memory leak on ulpi_register() error paths

Filipe Manana (1):
      btrfs: fix missing last_unlink_trans update when removing a directory

Fuad Tabba (4):
      KVM: arm64: Fix kvm_vcpu_initialized() macro parameter
      KVM: arm64: Fix FEAT_SPE_FnE to use PMSIDR_EL1.FnE, not PMSVer
      KVM: arm64: Fix FEAT_Debugv8p9 to check DebugVer, not PMUVer
      KVM: arm64: Fix pin leak and publication ordering in __pkvm_init_vcpu()

Gang Yan (2):
      mptcp: sockopt: set timestamp flags on subflow socket, not msk
      mptcp: fix scheduling with atomic in timestamp sockopt

Gary Guo (2):
      rust: pin-init: internal: move alignment check to `make_field_check`
      rust: pin-init: fix incorrect accessor reference lifetime

Greg Kroah-Hartman (4):
      scsi: target: configfs: Bound snprintf() return in tg_pt_gp_members_show()
      usb: usblp: fix heap leak in IEEE 1284 device ID via short response
      usb: usblp: fix uninitialized heap leak via LPGETSTATUS ioctl
      Linux 7.0.7

Guangshuo Li (5):
      ACPI: scan: Use acpi_dev_put() in object add error paths
      ice: fix double free in ice_sf_eth_activate() error path
      btrfs: fix double free in create_space_info() error path
      btrfs: fix double free in create_space_info_sub_group() error path
      f2fs: fix uninitialized kobject put in f2fs_init_sysfs()

Hamza Mahfooz (1):
      hv_sock: fix ARM64 support

Hongling Zeng (1):
      parisc: Fix IRQ leak in LASI driver

Huacai Chen (2):
      LoongArch: Fix SYM_SIGFUNC_START definition for 32BIT
      LoongArch: Use per-root-bridge PCIH flag to skip mem resource fixup

Ilya Maximets (1):
      openvswitch: vport: fix self-deadlock on release of tunnel ports

Ivan Hu (1):
      x86/efi: Fix graceful fault handling after FPU softirq changes

Jamal Hadi Salim (1):
      net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked

Jan Schär (1):
      ACPI: video: Add backlight=native quirk for Dell OptiPlex 7770 AIO

Jann Horn (1):
      exit: prevent preemption of oopsing TASK_DEAD task

Jason Gunthorpe (10):
      RDMA/hns: Fix unlocked call to hns_roce_qp_remove()
      RDMA/ionic: Fix typo in format string
      RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()
      RDMA/mana: Fix mana_destroy_wq_obj() cleanup in mana_ib_create_qp_rss()
      RDMA/mana: Remove user triggerable WARN_ON() in mana_ib_create_qp_rss()
      RDMA/mana: Validate rx_hash_key_len
      RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()
      RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
      RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
      RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path

Jens Axboe (2):
      io_uring/tw: serialize ctx->retry_llist with ->uring_lock
      block: only read from sqe on initial invocation of blkdev_uring_cmd()

Jeongjun Park (1):
      wifi: rsi: fix kthread lifetime race between self-exit and external-stop

Jiawen Wu (2):
      net: libwx: fix VF illegal register access
      net: libwx: use request_irq for VF misc interrupt

Jiexun Wang (1):
      af_unix: Reject SIOCATMARK on non-stream sockets

Jinjie Ruan (1):
      ACPI: CPPC: Fix related_cpus inconsistency during CPU hotplug

Jiri Slaby (SUSE) (1):
      wifi: ath5k: do not access array OOB

Johan Hovold (16):
      spi: rockchip: fix controller deregistration
      spi: syncuacer: fix controller deregistration
      spi: sun4i: fix controller deregistration
      spi: zynq-qspi: fix controller deregistration
      spi: ti-qspi: fix controller deregistration
      spi: sun6i: fix controller deregistration
      spi: tegra114: fix controller deregistration
      spi: zynqmp-gqspi: fix controller deregistration
      spi: tegra20-sflash: fix controller deregistration
      spi: s3c64xx: fix NULL-deref on driver unbind
      staging: vme_user: fix root device leak on init failure
      clk: rk808: fix OF node reference imbalance
      spi: microchip-core-qspi: fix controller deregistration
      spi: microchip-core-spi: fix controller deregistration
      spi: topcliff-pch: fix controller deregistration
      spi: topcliff-pch: fix use-after-free on unbind

Johannes Berg (1):
      wifi: mac80211: remove station if connection prep fails

Joseph Salisbury (1):
      ASoC: fsl_easrc: fix comment typo

Junrui Luo (2):
      md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
      RDMA/mlx5: Fix error path fall-through in mlx5_ib_dev_res_srq_init()

Kai Zen (2):
      net: rtnetlink: zero ifla_vf_broadcast to avoid stack infoleak in rtnl_fill_vfinfo
      RDMA/ionic: bound node_desc sysfs read with %.64s

Karol Wachowski (1):
      accel/ivpu: Disallow re-exporting imported GEM objects

Kevin Brodsky (1):
      arm64: signal: Preserve POR_EL0 if poe_context is missing

Leon Yen (1):
      wifi: mt76: mt7921: fix a potential clc buffer length underflow

Li Jian (1):
      ASoC: ES8389: convert to devm_clk_get_optional() to get clock

Longxuan Yu (2):
      8021q: use RCU for egress QoS mappings
      8021q: delete cleared egress QoS mappings

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt

Lukas Wunner (4):
      lib/crypto: mpi: Fix integer underflow in mpi_read_raw_from_sgl()
      PCI: Update saved_config_space upon resource assignment
      PCI/AER: Stop ruling out unbound devices as error source
      PCI/ASPM: Fix pci_clear_and_set_config_dword() usage

Luke Wang (1):
      mmc: core: Optimize time for secure erase/trim for some Kingston eMMCs

Maoyi Xie (1):
      ip6_gre: Use cached t->net in ip6erspan_changelink().

Marc Zyngier (1):
      KVM: arm64: Wake-up from WFI when iqrchip is in userspace

Marek Szyprowski (1):
      wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task

Mark Brown (2):
      ASoC: SOF: Don't allow pointer operations on unconfigured streams
      selftests/rseq: Don't run tests with runner scripts outside of the scripts

Martin Michaelis (1):
      io_uring/kbuf: support min length left for incremental buffers

Masami Hiramatsu (Google) (4):
      tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
      tracing/fprobe: Remove fprobe from hash in failure path
      tracing/fprobe: Unregister fprobe even if memory allocation fails
      tracing/fprobe: Check the same type fprobe on table as the unregistered one

Matthieu Baerts (NGI0) (14):
      mptcp: pm: ADD_ADDR rtx: skip inactive subflows
      selftests: mptcp: check output: catch cmd errors
      selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl
      mptcp: fastclose msk when linger time is 0
      mptcp: sockopt: increase seq in mptcp_setsockopt_all_sf
      mptcp: pm: prio: skip closed subflows
      mptcp: pm: kernel: reset fullmesh counter after flush
      mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
      mptcp: pm: ADD_ADDR rtx: allow ID 0
      mptcp: pm: ADD_ADDR rtx: fix potential data-race
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: free sk if last
      mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
      mptcp: pm: ADD_ADDR rtx: return early if no retrans

Michael Bommarito (9):
      xfrm: ah: account for ESN high bits in async callbacks
      Bluetooth: virtio_bt: clamp rx length before skb_put
      Bluetooth: virtio_bt: validate rx pkt_type header length
      udf: reject descriptors with oversized CRC length
      isofs: validate Rock Ridge CE continuation extent against volume size
      isofs: validate block number from NFS file handle in isofs_export_iget
      smb: client: validate dacloffset before building DACL pointers
      RDMA/rxe: Reject non-8-byte ATOMIC_WRITE payloads
      RDMA/rxe: Reject unknown opcodes before ICRC processing

Michal Kosiorek (1):
      xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete

Miguel Ojeda (2):
      rust: allow `clippy::collapsible_match` globally
      rust: allow `clippy::collapsible_if` globally

Miklos Szeredi (1):
      fanotify: fix false positive on permission events

Mikulas Patocka (3):
      dm-thin: fix metadata refcount underflow
      dm: don't report warning when doing deferred remove
      dm: fix a buffer overflow in ioctl processing

Ming Yen Hsieh (1):
      wifi: mt76: mt7925: fix incorrect length field in txpower command

Mingming Cao (1):
      ibmveth: Disable GSO for packets with small MSS

Myeonghun Pak (1):
      hwmon: (corsair-psu) Close HID device on probe errors

Naman Jain (1):
      block: add pgmap check to biovec_phys_mergeable

Nan Li (1):
      net/rds: handle zerocopy send cleanup before the message is queued

Nicolin Chen (1):
      iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update

Nilay Shroff (1):
      powerpc/xive: fix kmemleak caused by incorrect chip_data lookup

Osama Abdelkader (1):
      riscv: kvm: fix vector context allocation leak

Paolo Abeni (1):
      mptcp: fix rx timestamp corruption on fastopen

Paolo Bonzini (2):
      KVM: x86: check for nEPT/nNPT in slow flush hypercalls
      KVM: x86: Do IRR scan in __kvm_apic_update_irr even if PIR is empty

Pavitra Jha (1):
      net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler

Pengpeng Hou (1):
      s390/debug: Reject zero-length input before trimming a newline

Prathyushi Nangia (1):
      x86/CPU/AMD: Prevent improper isolation of shared resources in Zen2's op cache

Qiang Ma (1):
      LoongArch: KVM: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS

Qingfang Deng (1):
      flow_dissector: do not dissect PPPoE PFC frames

Qu Wenruo (1):
      btrfs: do not mark inode incompressible after inline attempt fails

Quan Zhou (3):
      wifi: mt76: mt7925: fix incorrect TLV length in CLC command
      wifi: mt76: mt7925: fix AMPDU state handling in mt7925_tx_check_aggr
      wifi: mt76: mt7921: fix ROC abort flow interruption in mt7921_roc_work

Quentin Perret (1):
      KVM: arm64: Fix initialisation order in __pkvm_init_finalise()

Rafael J. Wysocki (1):
      thermal: core: Free thermal zone ID later during removal

Rajat Gupta (1):
      fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free

Ranjan Kumar (1):
      scsi: mpt3sas: Limit NVMe request size to 2 MiB

Raphael Zimmer (1):
      libceph: Fix slab-out-of-bounds access in auth message processing

Ritesh Harjani (IBM) (5):
      pseries/papr-hvpipe: Fix race with interrupt handler
      pseries/papr-hvpipe: Prevent kernel stack memory leak to userspace
      pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_handle()
      pseries/papr-hvpipe: Fix & simplify error handling in papr_hvpipe_init()
      pseries/papr-hvpipe: Fix the usage of copy_to_user()

Ruijie Li (1):
      xfrm: provide message size for XFRM_MSG_MAPPING

Russell King (Oracle) (1):
      net: stmmac: rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()

Sam Edwards (1):
      net: stmmac: Prevent NULL deref when RX memory exhausted

Sang-Heon Jeon (1):
      mm/hugetlb_cma: round up per_node before logging it

Sanman Pradhan (2):
      hwmon: (ltc2992) Clamp threshold writes to hardware range
      hwmon: (ltc2992) Fix u32 overflow in power read path

Sean Christopherson (1):
      KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Selvarasu Ganesan (1):
      usb: dwc3: Move GUID programming after PHY initialization

SeongJae Park (5):
      mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
      mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
      mm/damon/stat: detect and use fresh enabled value
      mm/damon/sysfs-schemes: protect memcg_path kfree() with damon_sysfs_lock
      mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock

SeungJu Cheon (1):
      sound: ua101: fix division by zero at probe

Shardul Bankar (2):
      mptcp: use MPJoinSynAckHMacFailure for SynAck HMAC failure
      mptcp: use MPTCP_RST_EMPTCP for ACK HMAC validation failure

Shivam Kalra (1):
      ACPI: video: force native backlight on HP OMEN 16 (8A44)

Shota Zaizen (1):
      ksmbd: validate inherited ACE SID length

Shrikanth Hegde (1):
      cpuidle: powerpc: avoid double clear when breaking snooze

Shuai Xue (1):
      PCI/AER: Clear only error bits in PCIe Device Status

Shyam Prasad N (2):
      cifs: abort open_cached_dir if we don't request leases
      cifs: change_conf needs to be called for session setup

Shyam Sunder Reddy Padira (1):
      staging: rtl8723bs: os_dep: avoid NULL pointer dereference in rtw_cbuf_alloc

Sina Hassani (1):
      iommufd: Fix a race with concurrent allocation and unmap

Siwei Zhang (3):
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()

Sourabh Jain (1):
      powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o

Srinivas Kandagatla (3):
      ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
      ASoC: qcom: q6apm-lpass-dai: Fix multiple graph opens
      ASoC: qcom: q6apm: remove child devices when apm is removed

Stefan Eichenberger (1):
      clk: imx: imx8-acm: fix flags for acm clocks

Stephen Smalley (6):
      selinux: fix avdcache auditing
      selinux: shrink critical section in sel_write_load()
      selinux: prune /sys/fs/selinux/checkreqprot
      selinux: prune /sys/fs/selinux/disable
      selinux: prune /sys/fs/selinux/user
      selinux: allow multiple opens of /sys/fs/selinux/policy

Steven Rostedt (1):
      tracing/probes: Limit size of event probe to 3K

Suman Kumar Chakraborty (2):
      crypto: qat - fix indentation of macros in qat_hal.c
      crypto: qat - fix firmware loading failure for GEN6 devices

Takashi Iwai (2):
      ALSA: usb-audio: Avoid potential endless loop in convert_chmap_v3()
      ALSA: pcm: oss: Fix data race at accessing runtime.oss.trigger

Tao Cui (2):
      LoongArch: KVM: Fix missing EMULATE_FAIL in kvm_emu_mmio_read()
      LoongArch: KVM: Use kvm_set_pte() in kvm_flush_pte()

Tejun Heo (2):
      sched_ext: Read scx_root under scx_cgroup_ops_rwsem in cgroup setters
      sched_ext: Use dsq->first_task instead of list_empty() in dispatch_enqueue() FIFO-tail

Thomas Gleixner (7):
      rseq: Set rseq::cpu_id_start to 0 on unregistration
      rseq: Protect rseq_reset() against interrupts
      rseq: Don't advertise time slice extensions if disabled
      selftests/rseq: Make registration flexible for legacy and optimized mode
      selftests/rseq: Skip tests if time slice extensions are not available
      selftests/rseq: Validate legacy behavior
      selftests/rseq: Expand for optimized RSEQ ABI v2

Thomas Zimmermann (2):
      fbcon: Avoid OOB font access if console rotation fails
      hv: Select CONFIG_SYSFB only for CONFIG_HYPERV_VMBUS

Thorsten Blum (4):
      thermal/drivers/sprd: Fix temperature clamping in sprd_thm_temp_to_rawdata
      thermal/drivers/sprd: Fix raw temperature clamping in sprd_thm_rawdata_to_temp
      printk: add print_hex_dump_devel()
      crypto: caam - guard HMAC key hex dumps in hash_digest_key

Tommaso Soncin (1):
      ASoC: amd: yc: Add HP OMEN Gaming Laptop 16-ap0xxx product line in quirk table

Tristan Madani (3):
      wifi: b43legacy: enforce bounds check on firmware key index in RX path
      wifi: b43: enforce bounds check on firmware key index in b43_rx()
      Bluetooth: btmtk: validate WMT event SKB length before struct access

Tudor Ambarus (1):
      mtd: spi-nor: debugfs: fix out-of-bounds read in spi_nor_params_show()

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_typec: Init mutex in Thunderbolt registration

Ulf Hansson (1):
      pmdomain: core: Fix detach procedure for virtual devices in genpd

Vasily Gorbik (1):
      s390/debug: Reject zero-length input in debug_input_flush_fn()

Wentao Guan (1):
      LoongArch: Fix potential ADE in loongson_gpu_fixup_dma_hang()

Wentao Liang (1):
      pmdomain: mediatek: fix use-after-free in scpsys_get_bus_protection_legacy()

Xianglai Li (2):
      LoongArch: KVM: Compile switch.S directly into the kernel
      LoongArch: KVM: Fix "unreliable stack" for kvm_exc_entry

Xu Yang (2):
      usb: typec: tcpm: fix debug accessory mode detection for sink ports
      extcon: ptn5150: handle pending IRQ events during system resume

Yi Kuo (1):
      smb: client/smbdirect: fix MR registration for coalesced SG lists

Yilin Zhu (1):
      ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()

Yochai Eisenrich (1):
      btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak

Yongpeng Yang (8):
      f2fs: fix fiemap boundary handling when read extent cache is incomplete
      f2fs: fix fsck inconsistency caused by incorrect nat_entry flag usage
      f2fs: fix incorrect file address mapping when inline inode is unwritten
      f2fs: fix incorrect multidevice info in trace_f2fs_map_blocks()
      f2fs: fix node_cnt race between extent node destroy and writeback
      f2fs: refactor f2fs_move_node_folio function
      f2fs: fix inline data not being written to disk in writeback path
      f2fs: fix fsck inconsistency caused by FGGC of node block

Yuriy Padlyak (1):
      ALSA: hda/realtek: Fix speaker silence after S3 resume on Xiaomi Mi Laptop Pro 15

Zhenzhong Duan (2):
      iommufd: Fix return value of iommufd_fault_fops_write()
      iommu/vt-d: Block PASID attachment to nested domain with dirty tracking

Zilin Guan (1):
      hfsplus: fix held lock freed on hfsplus_fill_super()

Zisen Ye (2):
      smb/client: fix out-of-bounds read in smb2_compound_op()
      smb/client: fix out-of-bounds read in symlink_data()

Zongyao Chen (1):
      selinux: use sk blob accessor in socket permission helpers


