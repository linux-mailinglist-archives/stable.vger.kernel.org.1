Return-Path: <stable+bounces-142983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B25AB0C95
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86EB1BC20B4
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90972272E61;
	Fri,  9 May 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LoFSM9xo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F50272E57;
	Fri,  9 May 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746777981; cv=none; b=mbsKImmXIj7VAAxaGhV/rCrgjGTI6b1p9i7IhHeSCCawU1NS5aOKkv8Ss/ERH+ASr/nCxXWnLI1jAYR5nn9wNheHaCEKpd3xRNjjRA0gvGiF8nWHEAHrOtfp0Zlh91ozyys1JonQrMJn1jbIUXBkSq3dykW0uQ2BmYRmIYu88JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746777981; c=relaxed/simple;
	bh=eISDtNjbbNZCca9AeXdi1H6dXsu3qtN0vke38JcaY9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fF3OUh51zykUQcBE6FbmRc3qRkhkzuSKYusCwfHH7n8zCIF01Vatuz8GR1++wsc9JXR/ilyXPcuIt2a3z1FmUw5Gg+aQWDcGAw5UNOD2GuQzswtAKcf/dg2/0PIfvt/5x8qVYqHoTQXj1NMco8Ps1nPqsbz8i5NY84F/ndAFVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LoFSM9xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3085DC4CEE9;
	Fri,  9 May 2025 08:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746777980;
	bh=eISDtNjbbNZCca9AeXdi1H6dXsu3qtN0vke38JcaY9Q=;
	h=From:To:Cc:Subject:Date:From;
	b=LoFSM9xoE+xQYOAuVq4J+A1MBltCDT+1AQaFwv4ps9sUvp9iBVWxH5oQ5oDkJE2CH
	 xq0STN49W5MNBVAIg8yiYbYmwgomt9xXQ14pK1vTcLoNynMAt9qAwYEbvSJh3tXTHe
	 wxqtnIBH8ZdbzNsr2MPD9u1/1veHaqInfA9qLPCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.182
Date: Fri,  9 May 2025 10:06:15 +0200
Message-ID: <2025050916-wavy-early-2c0d@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.182 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi              |    3 
 arch/arm64/kernel/proton-pack.c                            |    2 
 arch/parisc/math-emu/driver.c                              |   16 
 arch/x86/include/asm/kvm-x86-ops.h                         |    1 
 arch/x86/include/asm/kvm_host.h                            |    1 
 arch/x86/kvm/svm/svm.c                                     |   13 
 arch/x86/kvm/vmx/vmx.c                                     |   11 
 arch/x86/kvm/x86.c                                         |    3 
 drivers/edac/altera_edac.c                                 |    9 
 drivers/edac/altera_edac.h                                 |    2 
 drivers/firmware/arm_scmi/bus.c                            |    3 
 drivers/gpu/drm/meson/meson_vclk.c                         |    6 
 drivers/gpu/drm/nouveau/nouveau_fence.c                    |    2 
 drivers/i2c/busses/i2c-imx-lpi2c.c                         |    4 
 drivers/iommu/amd/init.c                                   |    8 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                |   79 +--
 drivers/iommu/intel/iommu.c                                |    4 
 drivers/irqchip/irq-gic-v2m.c                              |    8 
 drivers/md/dm-integrity.c                                  |    2 
 drivers/md/dm-table.c                                      |    5 
 drivers/mmc/host/renesas_sdhi_core.c                       |   10 
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c                  |    9 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                   |   24 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                   |   11 
 drivers/net/ethernet/amd/xgbe/xgbe.h                       |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c         |   20 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c          |   38 +
 drivers/net/ethernet/dlink/dl2k.c                          |    2 
 drivers/net/ethernet/dlink/dl2k.h                          |    2 
 drivers/net/ethernet/freescale/fec_main.c                  |    7 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c         |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c            |  119 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h            |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c         |   61 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   26 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c     |   13 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   25 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |    1 
 drivers/net/ethernet/intel/ice/ice_fltr.c                  |   58 ++
 drivers/net/ethernet/intel/ice/ice_fltr.h                  |   12 
 drivers/net/ethernet/intel/ice/ice_main.c                  |   49 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c         |    5 
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c           |  139 ++---
 drivers/net/ethernet/mediatek/mtk_star_emac.c              |  341 +++++++------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |    5 
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c             |   11 
 drivers/net/ethernet/mellanox/mlx5/core/rdma.h             |    4 
 drivers/net/ethernet/microchip/lan743x_main.c              |    8 
 drivers/net/ethernet/microchip/lan743x_main.h              |    1 
 drivers/net/phy/microchip.c                                |   46 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c     |    6 
 drivers/nvme/host/tcp.c                                    |   31 +
 drivers/of/device.c                                        |    7 
 drivers/pci/controller/dwc/pci-imx6.c                      |    5 
 drivers/target/target_core_file.c                          |    3 
 drivers/target/target_core_iblock.c                        |    4 
 drivers/target/target_core_sbc.c                           |    6 
 kernel/trace/trace.c                                       |    5 
 net/ipv4/udp_offload.c                                     |   61 ++
 net/sched/act_mirred.c                                     |   22 
 net/sched/sch_drr.c                                        |    9 
 net/sched/sch_ets.c                                        |    9 
 net/sched/sch_hfsc.c                                       |    2 
 net/sched/sch_qfq.c                                        |   11 
 sound/usb/format.c                                         |    3 
 67 files changed, 933 insertions(+), 493 deletions(-)

Benjamin Marzinski (1):
      dm: always update the array size in realloc_argv on success

Biao Huang (1):
      net: ethernet: mtk-star-emac: separate tx/rx handling with two NAPIs

Brett Creeley (1):
      ice: Refactor promiscuous functions

Chris Mi (1):
      net/mlx5: E-switch, Fix error handling for enabling roce

Christian Hewitt (1):
      Revert "drm/meson: vclk: fix calculation of 59.94 fractional rates"

Clark Wang (1):
      i2c: imx-lpi2c: Fix clock count when probe defers

Cristian Marussi (1):
      firmware: arm_scmi: Balance device refcount when destroying devices

Felix Fietkau (1):
      net: ipv6: fix UDPv6 GSO segmentation with NAT

Fiona Klute (1):
      net: phy: microchip: force IRQ polling mode for lan88xx

Greg Kroah-Hartman (1):
      Linux 5.15.182

Hao Lan (1):
      net: hns3: fixed debugfs tm_qset size

Helge Deller (1):
      parisc: Fix double SIGFPE crash

Jakub Kicinski (1):
      net/sched: act_mirred: don't override retval if we already lost the skb

Jason Gunthorpe (1):
      iommu/arm-smmu-v3: Use the new rb tree helpers

Jeongjun Park (1):
      tracing: Fix oob write in trace_seq_to_buffer()

Jian Shen (2):
      net: hns3: store rx VLAN tag offload state for VF
      net: hns3: defer calling ptp_clock_register()

Joachim Priesner (1):
      ALSA: usb-audio: Add second USB ID for Jabra Evolve 65 headset

Louis-Alexis Eyraud (2):
      net: ethernet: mtk-star-emac: fix spinlock recursion issues on rx/tx poll
      net: ethernet: mtk-star-emac: rearm interrupts in rx_poll only when advised

Maor Gottlieb (1):
      net/mlx5: E-Switch, Initialize MAC Address for Default GID

Mattias Barthel (1):
      net: fec: ERR007885 Workaround for conventional TX

Michael Chan (1):
      bnxt_en: Fix ethtool -d byte order for 32-bit values

Michael Liang (1):
      nvme-tcp: fix premature queue removal and I/O failover

Mike Christie (1):
      scsi: target: Fix WRITE_SAME No Data Buffer crash

Mikulas Patocka (1):
      dm-integrity: fix a warning on invalid table line

Mingcong Bai (1):
      iommu/vt-d: Apply quirk_iommu_igfx for 8086:0044 (QM57/QS57)

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids

Niravkumar L Rabara (2):
      EDAC/altera: Test the correct error reg offset
      EDAC/altera: Set DDR and SDMMC interrupt mask before registration

Pavel Paklov (1):
      iommu/amd: Fix potential buffer overflow in parse_ivrs_acpihid

Philipp Stanner (1):
      drm/nouveau: Fix WARN_ON in nouveau_fence_context_kill()

Richard Zhu (1):
      PCI: imx6: Skip controller_id generation logic for i.MX7D

Ruslan Piasetskyi (1):
      mmc: renesas_sdhi: Fix error handling in renesas_sdhi_probe

Sean Christopherson (1):
      KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop

Sergey Shtylyov (1):
      of: module: add buffer overflow check in of_modalias()

Shruti Parab (2):
      bnxt_en: Fix coredump logic to free allocated buffer
      bnxt_en: Fix out-of-bound memcpy() during ethtool -w

Simon Horman (1):
      net: dlink: Correct endianness handling of led_mode

Suzuki K Poulose (1):
      irqchip/gic-v2m: Prevent use after free of gicv2m_get_fwnode()

Sébastien Szymanski (1):
      ARM: dts: opos6ul: add ksz8081 phy properties

Thangaraj Samynathan (1):
      net: lan743x: Fix memleak issue when GSO enabled

Thomas Gleixner (1):
      irqchip/gic-v2m: Mark a few functions __init

Tudor Ambarus (1):
      dm: fix copying after src array boundaries

Victor Nogueira (4):
      net_sched: drr: Fix double list add in class with netem as child qdisc
      net_sched: hfsc: Fix a UAF vulnerability in class with netem as child qdisc
      net_sched: ets: Fix double list add in class with netem as child qdisc
      net_sched: qfq: Fix double list add in class with netem as child qdisc

Vishal Badole (1):
      amd-xgbe: Fix to ensure dependent features are toggled with RX checksum offload

Wentao Liang (1):
      wifi: brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()

Will Deacon (1):
      arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays

Xiang wangx (1):
      irqchip/gic-v2m: Add const to of_device_id

Xuanqiang Luo (1):
      ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()

Yonglong Liu (3):
      net: hns3: add support for external loopback test
      net: hns3: fix an interrupt residual problem
      net: hns3: fix deadlock issue when externel_lb and reset are executed together


