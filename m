Return-Path: <stable+bounces-211371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCBHO/FRc2kDuwAAu9opvQ
	(envelope-from <stable+bounces-211371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 11:48:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAA47490D
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 11:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F5543058BB4
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 10:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE79374738;
	Fri, 23 Jan 2026 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JsaMJRPd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8D371074;
	Fri, 23 Jan 2026 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164964; cv=none; b=R5tDqqJLQs5MKBY5oFwEb6LXTLP21nH04DQh+3XsCdIzzsHZJMNdqMfR6eEixtSd+qTlLiXEul0nuB3KwtOUKXQI0Er9SQAsBsrbIoUn3EfN/711XQyNJ+EWudpiaKX4gSxGy0sBy3pg29JcdNhVvhAr6XCTzcfKFa+TjpxHYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164964; c=relaxed/simple;
	bh=7iCgdiA2QTM3/xnU/fYA3rA7gVHEb8C3UE0FGKsg9VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cxyij4xvk1zPlP3E2FMQ/QifaT8prCUBRNBSwEyldMp6ng+/L/deIvxAnRx0vywqho5EBOTItlqJQ45/PYcaWuY3JjvCkPXJAvETCzgX/vU3OZn/UaRF7V9tNHK7iTA8kIwGy6bIcZd9tdFeRdPWh6IU49c47GtJKCS+Rd2aDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JsaMJRPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B083DC4CEF1;
	Fri, 23 Jan 2026 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769164964;
	bh=7iCgdiA2QTM3/xnU/fYA3rA7gVHEb8C3UE0FGKsg9VQ=;
	h=From:To:Cc:Subject:Date:From;
	b=JsaMJRPd6uXB83m0zq446Bu0ESUVvi3IS3mMGb6hQciqeR9L/Sa7hlnqSyP4qucf3
	 8pOITWgvCugLHeh6uaD5sXcwkguTjfDHF5jKz4haj7TFsJa/KOktb+7D013IioolrT
	 2aIwryYOQ2ul4CgEAygv4WAn/GYOxpMCsLPslZsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.7
Date: Fri, 23 Jan 2026 11:42:26 +0100
Message-ID: <2026012326-wife-escapist-2b3f@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211371-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iloc.bh:url,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EAA47490D
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.7 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/loongarch/boot/dts/loongson-2k0500.dtsi              |    3 
 arch/loongarch/boot/dts/loongson-2k1000.dtsi              |   31 -
 arch/loongarch/boot/dts/loongson-2k2000.dtsi              |   35 -
 arch/loongarch/kernel/perf_event.c                        |   21 
 arch/loongarch/kvm/intc/eiointc.c                         |    1 
 arch/loongarch/kvm/intc/ipi.c                             |    1 
 arch/loongarch/kvm/intc/pch_pic.c                         |    1 
 arch/mips/mm/init.c                                       |   23 
 arch/x86/Kconfig                                          |    1 
 arch/x86/kernel/cpu/resctrl/core.c                        |   21 
 arch/x86/kernel/cpu/resctrl/internal.h                    |    3 
 arch/x86/kernel/fpu/core.c                                |   32 +
 arch/x86/kvm/x86.c                                        |    9 
 arch/x86/mm/init_64.c                                     |    2 
 arch/x86/mm/kaslr.c                                       |   10 
 arch/x86/mm/pat/set_memory.c                              |    2 
 arch/x86/mm/pgtable.c                                     |   12 
 block/bio-integrity-auto.c                                |    2 
 drivers/block/null_blk/main.c                             |   12 
 drivers/cxl/core/hdm.c                                    |    2 
 drivers/cxl/core/port.c                                   |    2 
 drivers/dax/dax-private.h                                 |   10 
 drivers/dma/apple-admac.c                                 |    1 
 drivers/dma/at_hdmac.c                                    |    9 
 drivers/dma/bcm-sba-raid.c                                |    6 
 drivers/dma/cv1800b-dmamux.c                              |   17 
 drivers/dma/dw/rzn1-dmamux.c                              |    4 
 drivers/dma/fsl-edma-common.c                             |    1 
 drivers/dma/idxd/compat.c                                 |   23 
 drivers/dma/lpc18xx-dmamux.c                              |   19 
 drivers/dma/lpc32xx-dmamux.c                              |   19 
 drivers/dma/mmp_pdma.c                                    |   20 
 drivers/dma/qcom/gpi.c                                    |    6 
 drivers/dma/sh/rz-dmac.c                                  |   18 
 drivers/dma/stm32/stm32-dmamux.c                          |   22 
 drivers/dma/tegra210-adma.c                               |   10 
 drivers/dma/ti/dma-crossbar.c                             |   18 
 drivers/dma/ti/k3-udma-private.c                          |    2 
 drivers/dma/ti/omap-dma.c                                 |    4 
 drivers/dma/xilinx/xdma-regs.h                            |    1 
 drivers/dma/xilinx/xdma.c                                 |    2 
 drivers/dma/xilinx/xilinx_dma.c                           |    7 
 drivers/edac/i3200_edac.c                                 |   11 
 drivers/edac/x38_edac.c                                   |    9 
 drivers/firmware/efi/cper.c                               |    2 
 drivers/firmware/imx/imx-scu-irq.c                        |   24 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c               |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                 |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c           |    8 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                     |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c     |   31 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         |   21 
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h            |    2 
 drivers/gpu/drm/amd/display/dc/link/link_detection.c      |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c      |    3 
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c              |    9 
 drivers/gpu/drm/gud/gud_pipe.c                            |   20 
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c               |    1 
 drivers/gpu/drm/panel/panel-simple.c                      |   90 +--
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c            |   12 
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c              |   17 
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h                  |    9 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                        |   22 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                       |   14 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                    |    4 
 drivers/hid/intel-ish-hid/ipc/ipc.c                       |   25 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                   |    2 
 drivers/hid/intel-ish-hid/ishtp-hid-client.c              |    4 
 drivers/hid/intel-ish-hid/ishtp/bus.c                     |   18 
 drivers/hid/intel-ish-hid/ishtp/hbm.c                     |    4 
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h               |    3 
 drivers/hid/usbhid/hid-core.c                             |   17 
 drivers/i2c/busses/i2c-imx-lpi2c.c                        |    7 
 drivers/i2c/busses/i2c-qcom-geni.c                        |   11 
 drivers/i2c/busses/i2c-riic.c                             |   46 +
 drivers/iommu/iommu-sva.c                                 |   33 +
 drivers/net/can/ctucanfd/ctucanfd_base.c                  |    2 
 drivers/net/can/usb/etas_es58x/es58x_core.c               |    2 
 drivers/net/can/usb/gs_usb.c                              |    2 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en.h              |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c         |   86 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c          |   15 
 drivers/net/hyperv/netvsc_drv.c                           |    3 
 drivers/net/macvlan.c                                     |   20 
 drivers/net/phy/motorcomm.c                               |    4 
 drivers/net/virtio_net.c                                  |   59 +-
 drivers/nvme/host/apple.c                                 |    1 
 drivers/nvme/host/pci.c                                   |    7 
 drivers/nvme/target/tcp.c                                 |   12 
 drivers/pci/Kconfig                                       |    6 
 drivers/phy/broadcom/phy-bcm-ns-usb3.c                    |    2 
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c                |    3 
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c                |   15 
 drivers/phy/qualcomm/phy-qcom-qusb2.c                     |   16 
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c             |   14 
 drivers/phy/st/phy-stm32-usbphyc.c                        |    2 
 drivers/phy/tegra/xusb-tegra186.c                         |    3 
 drivers/phy/ti/phy-da8xx-usb.c                            |    7 
 drivers/phy/ti/phy-gmii-sel.c                             |    2 
 drivers/scsi/scsi_error.c                                 |   24 
 drivers/soundwire/bus_type.c                              |    2 
 drivers/usb/core/config.c                                 |    5 
 drivers/usb/core/quirks.c                                 |    3 
 drivers/usb/dwc3/core.c                                   |    2 
 drivers/usb/dwc3/core.h                                   |    1 
 drivers/usb/gadget/function/f_fs.c                        |   53 -
 drivers/usb/gadget/function/f_uvc.c                       |    4 
 drivers/usb/gadget/function/uvc.h                         |    3 
 drivers/usb/gadget/function/uvc_queue.c                   |   15 
 drivers/usb/gadget/function/uvc_video.c                   |   11 
 drivers/usb/host/ohci-platform.c                          |    1 
 drivers/usb/host/uhci-platform.c                          |    1 
 drivers/usb/host/xhci-sideband.c                          |    1 
 drivers/usb/host/xhci-tegra.c                             |    2 
 drivers/usb/host/xhci.c                                   |   15 
 drivers/usb/serial/ftdi_sio.c                             |    1 
 drivers/usb/serial/ftdi_sio_ids.h                         |    2 
 drivers/usb/serial/option.c                               |    1 
 drivers/usb/typec/tcpm/tcpm.c                             |    2 
 fs/btrfs/inode.c                                          |    9 
 fs/btrfs/send.c                                           |    2 
 fs/btrfs/space-info.c                                     |    8 
 fs/btrfs/transaction.c                                    |   11 
 fs/ext4/xattr.c                                           |    1 
 fs/gfs2/lops.c                                            |    2 
 fs/nfs/blocklayout/dev.c                                  |    6 
 fs/nfs/file.c                                             |    3 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                 |    2 
 fs/nfs/inode.c                                            |   10 
 fs/nfs/io.c                                               |    2 
 fs/nfs/localio.c                                          |    2 
 fs/nfs/nfs42proc.c                                        |   29 -
 fs/nfs/nfs4proc.c                                         |    6 
 fs/nfs/nfstrace.h                                         |    3 
 fs/nfs/pnfs.c                                             |   58 +-
 fs/nfs/pnfs.h                                             |   17 
 fs/nfs/write.c                                            |   33 +
 fs/xfs/libxfs/xfs_ialloc.c                                |   11 
 fs/xfs/xfs_rtalloc.c                                      |    2 
 include/asm-generic/pgalloc.h                             |   18 
 include/drm/bridge/dw_hdmi_qp.h                           |    1 
 include/linux/energy_model.h                              |    2 
 include/linux/gfp.h                                       |    2 
 include/linux/intel-ish-client-if.h                       |    2 
 include/linux/iommu.h                                     |    4 
 include/linux/kfence.h                                    |    1 
 include/linux/mm.h                                        |   65 ++
 include/linux/nfs_fs.h                                    |    1 
 include/linux/sched/mm.h                                  |    1 
 include/linux/soc/airoha/airoha_offload.h                 |    4 
 include/linux/textsearch.h                                |    1 
 include/linux/usb/quirks.h                                |    3 
 include/net/ip_tunnels.h                                  |   13 
 include/scsi/scsi_eh.h                                    |    6 
 include/sound/pcm.h                                       |    2 
 include/uapi/linux/ext4.h                                 |    2 
 io_uring/io_uring.c                                       |    8 
 kernel/sched/core.c                                       |    2 
 kernel/sched/deadline.c                                   |    3 
 kernel/sched/syscalls.c                                   |    2 
 kernel/time/hrtimer.c                                     |    2 
 kernel/trace/ftrace.c                                     |   29 -
 lib/buildid.c                                             |   32 -
 mm/Kconfig                                                |   15 
 mm/damon/core.c                                           |   33 +
 mm/damon/sysfs-schemes.c                                  |   10 
 mm/damon/sysfs.c                                          |    9 
 mm/kmsan/shadow.c                                         |    2 
 mm/numa_memblks.c                                         |    2 
 mm/page_alloc.c                                           |   74 ++
 mm/pgtable-generic.c                                      |   39 +
 mm/vmstat.c                                               |   28 -
 mm/zswap.c                                                |    2 
 net/bluetooth/hci_sync.c                                  |    1 
 net/bridge/br_fdb.c                                       |   28 -
 net/bridge/br_input.c                                     |    4 
 net/can/j1939/transport.c                                 |   10 
 net/core/dev.c                                            |   25 
 net/core/dst.c                                            |    1 
 net/ipv4/esp4_offload.c                                   |    4 
 net/ipv4/ip_gre.c                                         |   11 
 net/ipv4/ip_tunnel.c                                      |    5 
 net/ipv4/route.c                                          |    4 
 net/ipv6/addrconf.c                                       |    4 
 net/ipv6/esp6_offload.c                                   |    4 
 net/ipv6/ip6_tunnel.c                                     |    2 
 net/ipv6/route.c                                          |    4 
 net/sched/sch_qfq.c                                       |    6 
 net/xfrm/xfrm_state.c                                     |    1 
 rust/helpers/bitops.c                                     |   42 +
 security/landlock/audit.c                                 |    2 
 security/landlock/net.c                                   |  118 ++--
 sound/core/oss/pcm_oss.c                                  |    4 
 sound/core/pcm_native.c                                   |    9 
 sound/hda/codecs/realtek/alc269.c                         |    1 
 sound/hda/codecs/side-codecs/cirrus_scodec_test.c         |    3 
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c            |   13 
 sound/soc/codecs/tlv320adcx140.c                          |    8 
 sound/soc/codecs/wsa881x.c                                |    9 
 sound/soc/codecs/wsa883x.c                                |    9 
 sound/soc/codecs/wsa884x.c                                |    3 
 sound/soc/sdw_utils/soc_sdw_cs42l43.c                     |    2 
 tools/testing/selftests/bpf/progs/strobemeta.h            |    6 
 tools/testing/selftests/kvm/x86/amx_test.c                |  118 ++--
 tools/testing/selftests/landlock/common.h                 |    1 
 tools/testing/selftests/landlock/fs_test.c                |    6 
 tools/testing/selftests/landlock/net_test.c               |   16 
 tools/testing/selftests/mm/gup_longterm.c                 |    2 
 tools/testing/selftests/mm/merge.c                        |  384 +++++++++++++-
 tools/testing/selftests/net/toeplitz.c                    |    4 
 tools/testing/vsock/util.c                                |   12 
 215 files changed, 2122 insertions(+), 818 deletions(-)

Aboorva Devarajan (1):
      mm/page_alloc: make percpu_pagelist_high_fraction reads lock-free

Aditya Garg (1):
      net: hv_netvsc: reject RSS hash key programming without RX indirection table

Alex Deucher (1):
      drm/amdgpu: make sure userqs are enabled in userq IOCTLs

Alice Ryhl (1):
      rust: bitops: fix missing _find_* functions on 32-bit ARM

Andreas Gruenbacher (1):
      Revert "gfs2: Fix use of bio_chain"

Andy Yan (2):
      drm/rockchip: vop2: Add delay between poll registers
      drm/rockchip: vop2: Only wait for changed layer cfg done when there is pending cfgdone bits

Anthony Brandon (1):
      dmaengine: xilinx: xdma: Fix regmap max_register

Antony Antony (1):
      xfrm: set ipv4 no_pmtu_disc flag only on output sa when direction is set

Arnaud Ferraris (1):
      tcpm: allow looking for role_sw device in the main node

Arnd Bergmann (1):
      ext4: fix ext4_tune_sb_params padding

Bagas Sanjaya (3):
      mm: describe @flags parameter in memalloc_flags_save()
      textsearch: describe @list member in ts_ops search
      mm, kfence: describe @slab parameter in __kfence_obj_info()

Ben Dooks (1):
      mm: numa,memblock: include <asm/numa.h> for 'numa_nodes_parsed'

Benjamin Tissoires (1):
      HID: usbhid: paper over wrong bNumDescriptor field

Biju Das (1):
      dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()

Binbin Zhou (4):
      LoongArch: dts: loongson-2k0500: Add default interrupt controller address cells
      LoongArch: dts: loongson-2k1000: Add default interrupt controller address cells
      LoongArch: dts: loongson-2k1000: Fix i2c-gpio node names
      LoongArch: dts: loongson-2k2000: Add default interrupt controller address cells

Brian Foster (1):
      xfs: set max_agbno to allow sparse alloc of last full inode chunk

Brian Kao (1):
      scsi: core: Fix error handler encryption support

Bui Quang Minh (1):
      virtio-net: don't schedule delayed refill worker

Caleb Sander Mateos (1):
      block: zero non-PI portion of auto integrity buffer

Carlos Llamas (1):
      iommu/sva: include mmu_notifier.h header

Carlos Song (1):
      i2c: imx-lpi2c: change to PIO mode in system-wide suspend/resume progress

Cole Leavitt (1):
      ASoC: sdw_utils: cs42l43: Enable Headphone pin for LINEOUT jack type

Dan Carpenter (1):
      phy: stm32-usphyc: Fix off by one in probe()

Dan Williams (1):
      x86/kaslr: Recognize all ZONE_DEVICE users as physaddr consumers

Dave Hansen (5):
      mm: add a ptdesc flag to mark kernel page tables
      mm: actually mark kernel page table pages
      x86/mm: use 'ptdesc' when freeing PMD pages
      mm: introduce pure page table freeing function
      mm: introduce deferred freeing for kernel page tables

Emil Svendsen (2):
      ASoC: tlv320adcx140: fix null pointer
      ASoC: tlv320adcx140: fix word length

Eric Dumazet (8):
      ipv4: ip_tunnel: spread netdev_lockdep_set_classes()
      net: bridge: annotate data-races around fdb->{updated,used}
      ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
      net: update netdev_lock_{type,name}
      macvlan: fix possible UAF in macvlan_forward_source()
      ipv4: ip_gre: make ipgre_header() robust
      dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()
      net/sched: sch_qfq: do not free existing class in qfq_change_class()

Ethan Nelson-Moore (1):
      USB: serial: ftdi_sio: add support for PICAXE AXE027 cable

Filipe Manana (1):
      btrfs: release path before iget_failed() in btrfs_read_locked_inode()

Franz Schnyder (1):
      phy: fsl-imx8mq-usb: fix typec orientation switch when built as module

Gal Pressman (1):
      selftests: drv-net: fix RPS mask handling for high CPU numbers

Greg Kroah-Hartman (2):
      Revert "functionfs: fix the open/removal races"
      Linux 6.18.7

Guenter Roeck (1):
      ftrace: Do not over-allocate ftrace memory

Guodong Xu (1):
      dmaengine: mmp_pdma: fix DMA mask handling

Gustavo A. R. Silva (1):
      virtio_net: Fix misalignment bug in struct virtnet_info

Günther Noack (1):
      selftests/landlock: Properly close a file descriptor

Haotian Zhang (2):
      phy: ti: da8xx-usb: Handle devm_pm_runtime_enable() errors
      dmaengine: omap-dma: fix dma_pool resource leak in error paths

Haoxiang Li (4):
      EDAC/x38: Fix a resource leak in x38_probe1()
      EDAC/i3200: Fix a resource leak in i3200_probe1()
      drm/amdkfd: fix a memory leak in device_queue_manager_init()
      drm/vmwgfx: Fix an error return check in vmw_compat_shader_add()

Harish Kasiviswanathan (1):
      drm/amdkfd: No need to suspend whole MES to evict process

Harshit Mogalapalli (1):
      soundwire: bus: fix off-by-one when allocating slave IDs

Huacai Chen (1):
      USB: OHCI/UHCI: Add soft dependencies on ehci_platform

Ian Forbes (2):
      drm/vmwgfx: Fix KMS with 3D on HW version 10
      drm/vmwgfx: Merge vmw_bo_release and vmw_bo_free functions

Ilikara Zheng (1):
      nvme-pci: disable secondary temp for Wodposit WPBSNM8

Janne Grunau (2):
      nvme-apple: add "apple,t8103-nvme-ans2" as compatible
      dmaengine: apple-admac: Add "apple,t8103-admac" compatible

Jaroslav Kysela (1):
      ALSA: pcm: Improve the fix for race of buffer access at PCM OSS layer

Jianbo Liu (1):
      xfrm: Fix inner mode lookup in tunnel mode GSO segmentation

Jiasheng Jiang (1):
      btrfs: fix memory leaks in create_space_info() error paths

Jijie Shao (1):
      net: phy: motorcomm: fix duplex setting error for phy leds

Johan Hovold (17):
      ASoC: codecs: wsa884x: fix codec initialisation
      ASoC: codecs: wsa883x: fix unnecessary initialisation
      phy: ti: gmii-sel: fix regmap leak on probe failure
      ASoC: codecs: wsa881x: fix unnecessary initialisation
      dmaengine: at_hdmac: fix device leak on of_dma_xlate()
      dmaengine: bcm-sba-raid: fix device leak on probe
      dmaengine: cv1800b-dmamux: fix device leak on route allocation
      dmaengine: dw: dmamux: fix OF node leak on route allocation failure
      dmaengine: idxd: fix device leaks on compat bind and unbind
      dmaengine: lpc18xx-dmamux: fix device leak on route allocation
      dmaengine: lpc32xx-dmamux: fix device leak on route allocation
      dmaengine: sh: rz-dmac: fix device leak on probe failure
      dmaengine: stm32: dmamux: fix device leak on route allocation
      dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
      dmaengine: ti: dma-crossbar: fix device leak on dra7x route allocation
      dmaengine: ti: dma-crossbar: fix device leak on am335x route allocation
      dmaengine: ti: k3-udma: fix device leak on udma lookup

Johannes Brüderl (1):
      usb: core: add USB_QUIRK_NO_BOS for devices that hang on BOS descriptor

John Groves (1):
      drivers/dax: add some missing kerneldoc comment fields for struct dev_dax

Joshua Hahn (2):
      mm/page_alloc/vmstat: simplify refresh_cpu_vm_stats change detection
      mm/page_alloc: batch page freeing in decay_pcp_high

Kery Qi (1):
      net: octeon_ep_vf: fix free_irq dev_id mismatch in IRQ rollback

Krzysztof Kozlowski (1):
      phy: broadcom: ns-usb3: Fix Wvoid-pointer-to-enum-cast warning (again)

Kuniyuki Iwashima (1):
      ipv6: Fix use-after-free in inet6_addr_del().

Li Ming (1):
      cxl/hdm: Fix potential infinite loop in __cxl_dpa_reserve()

Lisa Robinson (1):
      LoongArch: Fix PMU counter allocation for mixed-type event groups

Loic Poulain (1):
      phy: qcom-qusb2: Fix NULL pointer dereference on early suspend

Lorenzo Bianconi (1):
      net: airoha: Fix typo in airoha_ppe_setup_tc_block_cb definition

Lorenzo Stoakes (3):
      tools/testing/selftests: add tests for !tgt, src mremap() merges
      tools/testing/selftests: add forked (un)/faulted VMA merge tests
      tools/testing/selftests: fix gup_longterm for unknown fs

Louis Chauvet (1):
      phy: rockchip: inno-usb2: fix disconnection in gadget mode

Lu Baolu (2):
      x86/mm: use pagetable_free()
      iommu/sva: invalidate stale IOTLB entries for kernel address space

Lu Yao (1):
      drm/amdgpu: fix drm panic null pointer when driver not support atomic

Luca Ceresoli (1):
      phy: rockchip: inno-usb2: fix communication disruption in gadget mode

Ludovic Desroches (1):
      drm/panel: simple: restore connector_type fallback

Lyude Paul (1):
      drm/nouveau/disp/nv50-: Set lock_core in curs507a_prepare

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak

Marek Vasut (1):
      drm/panel-simple: fix connector type for DataImage SCF0700C48GGU18 panel

Mario Limonciello (1):
      drm/amd/display: Bump the HDMI clock to 340MHz

Mario Limonciello (AMD) (2):
      drm/amd/display: Show link name in PSR status message
      drm/amd: Clean up kfd node on surprise disconnect

Mathias Nyman (1):
      xhci: sideband: don't dereference freed ring when removing sideband endpoint

Matthew Schwartz (1):
      ALSA: hda/tas2781: Skip UEFI calibration on ASUS ROG Xbox Ally X

Matthieu Buffet (3):
      landlock: Fix TCP handling of short AF_UNSPEC addresses
      selftests/landlock: Fix TCP bind(AF_UNSPEC) test case
      selftests/landlock: Remove invalid unix socket bind()

Miaoqian Lin (1):
      dmaengine: qcom: gpi: Fix memory leak in gpi_peripheral_config()

Mike Rapoport (Microsoft) (1):
      mips: fix HIGHMEM initialization

Ming Lei (1):
      io_uring: move local task_work in exit cancel loop

Morduan Zang (1):
      efi/cper: Fix cper_bits_to_str buffer handling and return value

Nathan Chancellor (1):
      HID: intel-ish-hid: Fix -Wcast-function-type-strict in devm_ishtp_alloc_workqueue()

Neil Armstrong (1):
      i2c: qcom-geni: make sure I2C hub controllers can't use SE DMA

Nilay Shroff (2):
      null_blk: fix kmemleak by releasing references to fault configfs items
      nvme: fix PCIe subsystem reset controller state transition

Nirjhar Roy (IBM) (1):
      xfs: Fix the return value of xfs_rtcopy_summary()

Ondrej Ille (1):
      can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.

Paolo Bonzini (2):
      selftests: kvm: replace numbered sync points with actions
      selftests: kvm: try getting XFD and XSAVE state out of sync

Pavel Butsykin (1):
      mm/zswap: fix error pointer free in zswap_cpu_comp_prepare()

Peng Fan (1):
      firmware: imx: scu-irq: Set mu_resource_id before get handle

Peter Zijlstra (2):
      sched/deadline: Avoid double update_rq_clock()
      sched: Deadline has dynamic priority

Philip Yang (1):
      drm/amdgpu: Fix gfx9 update PTE mtype flag

Qiang Ma (3):
      LoongArch: KVM: Fix kvm_device leak in kvm_eiointc_destroy()
      LoongArch: KVM: Fix kvm_device leak in kvm_ipi_destroy()
      LoongArch: KVM: Fix kvm_device leak in kvm_pch_pic_destroy()

Qu Wenruo (1):
      btrfs: send: check for inline extents in range_is_hole_in_parent()

Rafael Beims (1):
      phy: freescale: imx8m-pcie: assert phy reset during power on

Richard Fitzgerald (2):
      ALSA: hda/cirrus_scodec_test: Fix incorrect setup of gpiochip
      ALSA: hda/cirrus_scodec_test: Fix test suite name

Robbie Ko (1):
      btrfs: fix deadlock in wait_current_trans() due to ignored transaction type

Robert Richter (1):
      cxl/port: Fix target list setup for multiple decoders sharing the same dport

Ryan Roberts (1):
      mm: kmsan: fix poisoning of high-order non-compound pages

Saeed Mahameed (4):
      net/mlx5e: Fix crash on profile change rollback failure
      net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlink priv
      net/mlx5e: Pass netdev to mlx5e_destroy_netdev instead of priv
      net/mlx5e: Restore destroying state bit after profile cleanup

Sean Christopherson (1):
      x86/fpu: Clear XSTATE_BV[i] in guest XSAVE state whenever XFD[i]=1

Sebastian Reichel (1):
      drm/bridge: dw-hdmi-qp: Fix spurious IRQ on resume

SeongJae Park (5):
      mm/damon/core: remove call_control in inactive contexts
      mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir setup failure
      mm/damon/sysfs-scheme: cleanup access_pattern subdirs on scheme dir setup failure
      mm/damon/sysfs: cleanup intervals subdirs on attrs dir setup failure
      mm/damon/sysfs: cleanup attrs subdirs on context dir setup failure

Shakeel Butt (1):
      lib/buildid: use __kernel_read() for sleepable context

Sheetal (1):
      dmaengine: tegra-adma: Fix use-after-free

Shenghao Yang (1):
      drm/gud: fix NULL fb and crtc dereferences on USB disconnect

Shivam Kumar (1):
      nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec

Srinivasan Shanmugam (1):
      drm/amdgpu/userq: Fix fence reference leak on queue teardown v2

Stefano Garzarella (1):
      vsock/test: add a final full barrier after run all tests

Stefano Radaelli (1):
      phy: fsl-imx8mq-usb: Clear the PCS_TX_SWING_FULL field before using it

Suraj Gupta (1):
      dmaengine: xilinx_dma: Fix uninitialized addr_width when "xlnx,addrwidth" property is missing

Szymon Wilczek (1):
      can: etas_es58x: allow partial RX URB allocation to succeed

Tetsuo Handa (1):
      net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts

Thinh Nguyen (1):
      usb: dwc3: Check for USB4 IP_NAME

Thomas Weißschuh (1):
      hrtimer: Fix softirq base check in update_needs_ipi()

Thomas Zimmermann (1):
      drm/sysfb: Remove duplicate declarations

Tingmao Wang (1):
      landlock: Fix wrong type usage

Tommaso Merciai (1):
      i2c: riic: Move suspend handling to NOIRQ phase

Trond Myklebust (4):
      pNFS: Fix a deadlock when returning a delegation during open()
      NFS: Fix a deadlock involving nfs_release_folio()
      NFS/localio: Deal with page bases that are > PAGE_SIZE
      NFS: Fix size read races in truncate, fallocate and copy offload

Ulrich Mohr (1):
      USB: serial: option: add Telit LE910 MBIM composition

Vivek Das Mohapatra (1):
      drm/amd/display: Initialise backlight level values from hw

Vlastimil Babka (1):
      mm/page_alloc: prevent pcp corruption with SMP=n

Wayne Chang (2):
      phy: tegra: xusb: Explicitly configure HS_DISCON_LEVEL to 0x7
      usb: host: xhci-tegra: Use platform_get_irq_optional() for wake IRQs

Wentao Liang (1):
      phy: rockchip: inno-usb2: Fix a double free bug in rockchip_usb2phy_probe()

Xiaochen Shen (2):
      x86/resctrl: Add missing resctrl initialization for Hygon
      x86/resctrl: Fix memory bandwidth counter width for Hygon

Xu Yang (2):
      usb: gadget: uvc: fix interval_duration calculation
      usb: gadget: uvc: fix req_payload_size calculation

Yang Erkun (1):
      ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref

Yang Li (1):
      Bluetooth: hci_sync: enable PA Sync Lost event

Yang Wang (1):
      drm/amd/pm: fix smu overdrive data type wrong issue on smu 14.0.2

Yao Zi (1):
      LoongArch: dts: Describe PCI sideband IRQ through interrupt-extended

Yaxiong Tian (1):
      PM: EM: Fix incorrect description of the cost field in struct em_perf_state

Yonghong Song (1):
      selftests/bpf: Fix selftest verif_scale_strobemeta failure with llvm22

Zhang Heng (1):
      ALSA: hda/realtek: Add quirk for HP Pavilion x360 to enable mute LED

Zhang Lixu (1):
      HID: intel-ish-hid: Use dedicated unbound workqueues to prevent resume blocking

Zhen Ni (1):
      dmaengine: fsl-edma: Fix clk leak on alloc_chan_resources failure

Zilin Guan (2):
      pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_deviceid_node()
      pnfs/blocklayout: Fix memory leak in bl_parse_scsi()


