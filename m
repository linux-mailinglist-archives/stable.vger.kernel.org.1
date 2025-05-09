Return-Path: <stable+bounces-142985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E5AB0C9E
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85A4A021FA
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439442741CE;
	Fri,  9 May 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2b+ysTa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE32741BF;
	Fri,  9 May 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746777993; cv=none; b=SwR10KgC7tZqjRUPU7Jwf+aaM3FBTinXbv5xTfjYWecA/iBoMvAeZ8y8i5Fbk32uao0gL7Mz6S0puXdtPi/jfpeLESWtRALfMVsSwhz93IWjTDkfxASuCW1qIQNdT1R/I5nXwhYnNirSy1B6Q+pekWdTvTFio0z+wfTttN1fu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746777993; c=relaxed/simple;
	bh=qIrVEycUFMVzTWLkHbgLjQbjq/S4Bq2BF/z0rOaw3qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uWlAetnfvaR2prad1wIPk6ptTOsEkz0IOfcCK0hNdoLJgtIeUS/5o4i/a3g9dLarObNG4jDw3bVuc0SU+JRTShqrU0OLq6fnRgLrMUCr5W9ZBQ5m5UcquF9StG6G1ya1y/MY8HgMy1u69mXJAMb7/7Dvc5cnJFcJOBrn3B13+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2b+ysTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9120C4CEE4;
	Fri,  9 May 2025 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746777991;
	bh=qIrVEycUFMVzTWLkHbgLjQbjq/S4Bq2BF/z0rOaw3qw=;
	h=From:To:Cc:Subject:Date:From;
	b=R2b+ysTagScgg7iqxFxuquJ+qGdCtXykh722FqI4gy6Oz+Ezt0/ayPWjrooSN8fDr
	 2DG0Uqvoc+u7hbKfmLTaGFDLR7vRitV/HVvOm0Bfbw8dQCJZWZMPK0khKG3BEbsi2s
	 AsCY8PKKViS+4i0wnD9B0W5k3bhf6S8PgmS2WGBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.138
Date: Fri,  9 May 2025 10:06:22 +0200
Message-ID: <2025050923-zigzagged-hardcore-0182@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.138 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi                  |    3 
 arch/arm64/kernel/proton-pack.c                                |    2 
 arch/parisc/math-emu/driver.c                                  |   16 
 arch/x86/events/intel/core.c                                   |    2 
 arch/x86/include/asm/kexec.h                                   |   18 
 arch/x86/include/asm/kvm-x86-ops.h                             |    1 
 arch/x86/include/asm/kvm_host.h                                |    1 
 arch/x86/kernel/machine_kexec_64.c                             |   45 -
 arch/x86/kvm/svm/svm.c                                         |   13 
 arch/x86/kvm/vmx/vmx.c                                         |   11 
 arch/x86/kvm/x86.c                                             |    3 
 drivers/cpufreq/cpufreq.c                                      |   42 
 drivers/cpufreq/cpufreq_ondemand.c                             |    3 
 drivers/cpufreq/freq_table.c                                   |    6 
 drivers/edac/altera_edac.c                                     |    9 
 drivers/edac/altera_edac.h                                     |    2 
 drivers/firmware/arm_ffa/driver.c                              |    3 
 drivers/firmware/arm_scmi/bus.c                                |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c         |  429 +++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h         |    5 
 drivers/gpu/drm/meson/meson_vclk.c                             |    6 
 drivers/gpu/drm/nouveau/nouveau_fence.c                        |    2 
 drivers/i2c/busses/i2c-imx-lpi2c.c                             |    4 
 drivers/iommu/amd/init.c                                       |    8 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                    |   79 -
 drivers/iommu/intel/iommu.c                                    |    4 
 drivers/irqchip/irq-gic-v2m.c                                  |    8 
 drivers/irqchip/irq-qcom-mpm.c                                 |    3 
 drivers/md/dm-bufio.c                                          |    3 
 drivers/md/dm-integrity.c                                      |    2 
 drivers/md/dm-table.c                                          |    5 
 drivers/md/md.c                                                |   27 
 drivers/md/md.h                                                |    2 
 drivers/md/raid0.c                                             |   16 
 drivers/md/raid5.c                                             |   41 
 drivers/mmc/host/renesas_sdhi_core.c                           |   10 
 drivers/net/dsa/ocelot/felix_vsc9959.c                         |    5 
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c                      |    9 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                       |   24 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                       |   11 
 drivers/net/ethernet/amd/xgbe/xgbe.h                           |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c             |   20 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c              |   38 
 drivers/net/ethernet/dlink/dl2k.c                              |    2 
 drivers/net/ethernet/dlink/dl2k.h                              |    2 
 drivers/net/ethernet/freescale/fec_main.c                      |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c             |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                |   82 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c         |   13 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c      |   25 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h      |    1 
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c             |    5 
 drivers/net/ethernet/mediatek/mtk_star_emac.c                  |   13 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c     |    5 
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c                 |   11 
 drivers/net/ethernet/mellanox/mlx5/core/rdma.h                 |    4 
 drivers/net/ethernet/microchip/lan743x_main.c                  |    8 
 drivers/net/ethernet/microchip/lan743x_main.h                  |    1 
 drivers/net/ethernet/mscc/ocelot.c                             |  194 ++++
 drivers/net/ethernet/mscc/ocelot_vcap.c                        |    1 
 drivers/net/ethernet/vertexcom/mse102x.c                       |   36 
 drivers/net/phy/microchip.c                                    |   46 -
 drivers/net/usb/rndis_host.c                                   |   16 
 drivers/net/vxlan/vxlan_vnifilter.c                            |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c         |    6 
 drivers/net/wireless/purelifi/plfxlc/mac.c                     |    1 
 drivers/nvme/host/tcp.c                                        |   31 
 drivers/pci/controller/dwc/pci-imx6.c                          |    5 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c |   13 
 fs/smb/server/auth.c                                           |   14 
 fs/smb/server/smb2pdu.c                                        |    5 
 fs/xfs/libxfs/xfs_attr_remote.c                                |    1 
 fs/xfs/libxfs/xfs_bmap.c                                       |  130 ++-
 fs/xfs/libxfs/xfs_da_btree.c                                   |   20 
 fs/xfs/libxfs/xfs_inode_buf.c                                  |   47 -
 fs/xfs/libxfs/xfs_sb.c                                         |    7 
 fs/xfs/scrub/attr.c                                            |    5 
 fs/xfs/xfs_aops.c                                              |   54 -
 fs/xfs/xfs_attr_item.c                                         |   88 +-
 fs/xfs/xfs_bmap_util.c                                         |   61 -
 fs/xfs/xfs_bmap_util.h                                         |    2 
 fs/xfs/xfs_dquot.c                                             |    1 
 fs/xfs/xfs_icache.c                                            |    2 
 fs/xfs/xfs_inode.c                                             |   14 
 fs/xfs/xfs_iomap.c                                             |   81 +
 fs/xfs/xfs_reflink.c                                           |   20 
 fs/xfs/xfs_rtalloc.c                                           |    2 
 include/linux/cpufreq.h                                        |   83 +
 include/soc/mscc/ocelot_vcap.h                                 |    2 
 kernel/trace/trace.c                                           |    5 
 net/ipv4/udp_offload.c                                         |   61 +
 net/sched/sch_drr.c                                            |   16 
 net/sched/sch_ets.c                                            |   17 
 net/sched/sch_hfsc.c                                           |   10 
 net/sched/sch_htb.c                                            |    2 
 net/sched/sch_qfq.c                                            |   18 
 sound/soc/codecs/ak4613.c                                      |    4 
 sound/soc/soc-core.c                                           |   36 
 sound/soc/soc-pcm.c                                            |    5 
 sound/usb/format.c                                             |    3 
 101 files changed, 1467 insertions(+), 837 deletions(-)

Benjamin Marzinski (1):
      dm: always update the array size in realloc_argv on success

Bhawanpreet Lakha (1):
      drm/amd/display: Change HDCP update sequence for DM

Chris Bainbridge (1):
      drm/amd/display: Fix slab-use-after-free in hdcp

Chris Mi (1):
      net/mlx5: E-switch, Fix error handling for enabling roce

Christian Heusel (1):
      Revert "rndis_host: Flag RNDIS modems as WWAN devices"

Christian Hewitt (1):
      Revert "drm/meson: vclk: fix calculation of 59.94 fractional rates"

Christoph Hellwig (4):
      xfs: fix error returns from xfs_bmapi_write
      xfs: fix xfs_bmap_add_extent_delay_real for partial conversions
      xfs: remove a racy if_bytes check in xfs_reflink_end_cow_extent
      xfs: fix freeing speculative preallocations for preallocated files

Clark Wang (1):
      i2c: imx-lpi2c: Fix clock count when probe defers

Cong Wang (5):
      sch_htb: make htb_qlen_notify() idempotent
      sch_drr: make drr_qlen_notify() idempotent
      sch_hfsc: make hfsc_qlen_notify() idempotent
      sch_qfq: make qfq_qlen_notify() idempotent
      sch_ets: make est_qlen_notify() idempotent

Cristian Marussi (1):
      firmware: arm_scmi: Balance device refcount when destroying devices

Darrick J. Wong (7):
      xfs: require XFS_SB_FEAT_INCOMPAT_LOG_XATTRS for attr log intent item recovery
      xfs: check opcode and iovec count match in xlog_recover_attri_commit_pass2
      xfs: validate recovered name buffers when recovering xattr items
      xfs: revert commit 44af6c7e59b12
      xfs: allow symlinks with short remote targets
      xfs: allow unlinked symlinks and dirs with zero size
      xfs: restrict when we try to align cow fork delalloc to cowextsz hints

Felix Fietkau (1):
      net: ipv6: fix UDPv6 GSO segmentation with NAT

Fiona Klute (1):
      net: phy: microchip: force IRQ polling mode for lan88xx

Geert Uytterhoeven (1):
      ASoC: soc-core: Stop using of_property_read_bool() for non-boolean properties

Greg Kroah-Hartman (2):
      Revert "x86/kexec: Allocate PGD for x86_64 transition page tables separately"
      Linux 6.1.138

Hao Lan (1):
      net: hns3: fixed debugfs tm_qset size

Helge Deller (1):
      parisc: Fix double SIGFPE crash

Ido Schimmel (1):
      vxlan: vnifilter: Fix unlocked deletion of default FDB entry

Jason Gunthorpe (1):
      iommu/arm-smmu-v3: Use the new rb tree helpers

Jeongjun Park (1):
      tracing: Fix oob write in trace_seq_to_buffer()

Jian Shen (2):
      net: hns3: store rx VLAN tag offload state for VF
      net: hns3: defer calling ptp_clock_register()

Joachim Priesner (1):
      ALSA: usb-audio: Add second USB ID for Jabra Evolve 65 headset

LongPing Wei (1):
      dm-bufio: don't schedule in atomic context

Louis-Alexis Eyraud (2):
      net: ethernet: mtk-star-emac: fix spinlock recursion issues on rx/tx poll
      net: ethernet: mtk-star-emac: rearm interrupts in rx_poll only when advised

Maor Gottlieb (1):
      net/mlx5: E-Switch, Initialize MAC Address for Default GID

Mario Limonciello (1):
      drm/amd/display: Add scoped mutexes for amdgpu_dm_dhcp

Mattias Barthel (1):
      net: fec: ERR007885 Workaround for conventional TX

Michael Chan (1):
      bnxt_en: Fix ethtool -d byte order for 32-bit values

Michael Liang (1):
      nvme-tcp: fix premature queue removal and I/O failover

Mikulas Patocka (1):
      dm-integrity: fix a warning on invalid table line

Mingcong Bai (1):
      iommu/vt-d: Apply quirk_iommu_igfx for 8086:0044 (QM57/QS57)

Murad Masimov (1):
      wifi: plfxlc: Remove erroneous assert in plfxlc_mac_release

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids

Niravkumar L Rabara (2):
      EDAC/altera: Test the correct error reg offset
      EDAC/altera: Set DDR and SDMMC interrupt mask before registration

Pavel Paklov (1):
      iommu/amd: Fix potential buffer overflow in parse_ivrs_acpihid

Philipp Stanner (1):
      drm/nouveau: Fix WARN_ON in nouveau_fence_context_kill()

Rafael J. Wysocki (2):
      cpufreq: Avoid using inconsistent policy->min and policy->max
      cpufreq: Fix setting policy limits when frequency tables are used

Richard Zhu (1):
      PCI: imx6: Skip controller_id generation logic for i.MX7D

Rob Herring (Arm) (1):
      ASoC: Use of_property_read_bool()

Ruslan Piasetskyi (1):
      mmc: renesas_sdhi: Fix error handling in renesas_sdhi_probe

Sean Christopherson (2):
      perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest with vCPU's value.
      KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop

Sean Heelan (1):
      ksmbd: fix use-after-free in kerberos authentication

Sheetal (1):
      ASoC: soc-pcm: Fix hw_params() and DAPM widget sequence

Shouye Liu (1):
      platform/x86/intel-uncore-freq: Fix missing uncore sysfs during CPU hotplug

Shruti Parab (2):
      bnxt_en: Fix coredump logic to free allocated buffer
      bnxt_en: Fix out-of-bound memcpy() during ethtool -w

Simon Horman (1):
      net: dlink: Correct endianness handling of led_mode

Srinivasan Shanmugam (1):
      drm/amd/display: Clean up style problems in amdgpu_dm_hdcp.c

Stefan Wahren (4):
      net: vertexcom: mse102x: Fix possible stuck of SPI interrupt
      net: vertexcom: mse102x: Fix LEN_MASK
      net: vertexcom: mse102x: Add range check for CMD_RTS
      net: vertexcom: mse102x: Fix RX error handling

Stephan Gerhold (1):
      irqchip/qcom-mpm: Prevent crash when trying to handle non-wake GPIOs

Sudeep Holla (1):
      firmware: arm_ffa: Skip Rx buffer ownership release if not acquired

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

Vladimir Oltean (3):
      net: mscc: ocelot: treat 802.1ad tagged traffic as 802.1Q-untagged
      net: mscc: ocelot: delete PVID VLAN when readding it as non-PVID
      net: dsa: felix: fix broken taprio gate states after clock jump

Wengang Wang (1):
      xfs: make sure sb_fdblocks is non-negative

Wentao Liang (1):
      wifi: brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()

Will Deacon (1):
      arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays

Xuanqiang Luo (1):
      ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()

Yonglong Liu (1):
      net: hns3: fix an interrupt residual problem

Yu Kuai (1):
      md: move initialization and destruction of 'io_acct_set' to md.c

Zhang Yi (4):
      xfs: match lock mode in xfs_buffered_write_iomap_begin()
      xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
      xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
      xfs: convert delayed extents to unwritten when zeroing post eof blocks

hersen wu (1):
      drm/amd/display: phase2 enable mst hdcp multiple displays


