Return-Path: <stable+bounces-142991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8500DAB0CB0
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2767B8C4E
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF4927464B;
	Fri,  9 May 2025 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ljJgZPq9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB0274654;
	Fri,  9 May 2025 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778042; cv=none; b=eXipH80j8k9GPZ7uEBBJAg8HyrDE0ecXiec4aaiC6lbqYTPuf8HvrAmrYUEma4/iKEQrzhcL0A/ESgXOfHl5VbIWpTP9yKVXj8s44aZUFdNnJpSubgcOjDXVmG3nXG5sZfUdoXueMlYlp8I/b38pxNgz9RPKV7MDr3pmWjY0aZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778042; c=relaxed/simple;
	bh=pl3Kaomp6aJNVnb0CJTHG0WZOm4/HiVQDgCrfMkjmLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C9DDnOA5k0JVpxDtffCCLGRimObUT6rHwOgdZpQqHKv0aR+nHth5D3MsP6ttWGeka/bR+5ZewVBUUHoPaP9842iEEsChicbMPOdckMGN2vBEaR604LCwfo/A3W/TqVPsqRaxeuwJDEj6wWPCaQd2q9EBBoiBXQQLGqTVVqssLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ljJgZPq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A532C4CEE4;
	Fri,  9 May 2025 08:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746778042;
	bh=pl3Kaomp6aJNVnb0CJTHG0WZOm4/HiVQDgCrfMkjmLg=;
	h=From:To:Cc:Subject:Date:From;
	b=ljJgZPq9xHuYLvoVtd5Nz+mji+YN7FS2ISHia8SVaZ59OnTLvILQYVfCOQBmFesXh
	 SuG9hNb7LSJAJcaNCc+/emh1d2fHbfAzcrvn277gnpB6NBoUJVWPQAiHqW3hUW1XAK
	 o82zKjI3iHUvjAumxzmbKkjdn9oQVW2oR0WUqdkc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.14.6
Date: Fri,  9 May 2025 10:07:12 +0200
Message-ID: <2025050913-hazy-pyromania-f458@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.14.6 kernel.

All users of the 6.14 kernel series must upgrade.

The updated 6.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi          |    3 
 arch/arm64/boot/dts/freescale/imx95.dtsi                       |    8 
 arch/arm64/boot/dts/st/stm32mp251.dtsi                         |    9 
 arch/arm64/kernel/proton-pack.c                                |    2 
 arch/parisc/math-emu/driver.c                                  |   16 
 arch/powerpc/boot/wrapper                                      |    6 
 arch/powerpc/kernel/module_64.c                                |    4 
 arch/powerpc/mm/book3s64/radix_pgtable.c                       |   17 
 arch/x86/boot/compressed/mem.c                                 |    5 
 arch/x86/boot/compressed/sev.c                                 |   40 
 arch/x86/boot/compressed/sev.h                                 |    2 
 arch/x86/events/core.c                                         |    2 
 arch/x86/events/intel/core.c                                   |    2 
 arch/x86/events/perf_event.h                                   |    9 
 drivers/accel/ivpu/ivpu_drv.c                                  |   32 
 drivers/accel/ivpu/ivpu_drv.h                                  |    2 
 drivers/accel/ivpu/ivpu_hw_btrs.h                              |    2 
 drivers/accel/ivpu/ivpu_job.c                                  |  111 +-
 drivers/accel/ivpu/ivpu_job.h                                  |    1 
 drivers/accel/ivpu/ivpu_mmu.c                                  |    3 
 drivers/accel/ivpu/ivpu_pm.c                                   |   18 
 drivers/accel/ivpu/ivpu_sysfs.c                                |    5 
 drivers/base/module.c                                          |   13 
 drivers/block/ublk_drv.c                                       |  550 +++++-----
 drivers/bluetooth/btintel_pcie.c                               |   57 -
 drivers/bluetooth/btusb.c                                      |  101 +
 drivers/cpufreq/acpi-cpufreq.c                                 |   14 
 drivers/cpufreq/cpufreq.c                                      |   42 
 drivers/cpufreq/cpufreq_ondemand.c                             |    3 
 drivers/cpufreq/freq_table.c                                   |   10 
 drivers/cpufreq/intel_pstate.c                                 |    3 
 drivers/edac/altera_edac.c                                     |    9 
 drivers/edac/altera_edac.h                                     |    2 
 drivers/firmware/arm_ffa/driver.c                              |    3 
 drivers/firmware/arm_scmi/bus.c                                |    3 
 drivers/firmware/cirrus/Kconfig                                |    5 
 drivers/gpu/drm/Kconfig                                        |    2 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c                        |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |   20 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c         |   56 -
 drivers/gpu/drm/drm_file.c                                     |    6 
 drivers/gpu/drm/drm_mipi_dbi.c                                 |    6 
 drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.h                     |    8 
 drivers/gpu/drm/nouveau/nouveau_fence.c                        |    2 
 drivers/gpu/drm/tests/drm_gem_shmem_test.c                     |    3 
 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h              |    1 
 drivers/gpu/drm/xe/xe_guc_capture.c                            |    2 
 drivers/gpu/drm/xe/xe_ring_ops.c                               |   13 
 drivers/i2c/busses/i2c-imx-lpi2c.c                             |    4 
 drivers/iommu/amd/init.c                                       |    8 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c                |    6 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                    |   21 
 drivers/iommu/intel/iommu.c                                    |    4 
 drivers/irqchip/irq-qcom-mpm.c                                 |    3 
 drivers/md/dm-bufio.c                                          |    9 
 drivers/md/dm-integrity.c                                      |    2 
 drivers/md/dm-table.c                                          |    5 
 drivers/mmc/host/renesas_sdhi_core.c                           |   10 
 drivers/net/dsa/ocelot/felix_vsc9959.c                         |    5 
 drivers/net/ethernet/amd/pds_core/auxbus.c                     |   39 
 drivers/net/ethernet/amd/pds_core/core.h                       |    7 
 drivers/net/ethernet/amd/pds_core/devlink.c                    |    7 
 drivers/net/ethernet/amd/pds_core/main.c                       |   11 
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c                      |    9 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                       |   24 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                       |   11 
 drivers/net/ethernet/amd/xgbe/xgbe.h                           |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                      |   18 
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c             |   20 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c              |   40 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                  |   29 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h                  |    1 
 drivers/net/ethernet/dlink/dl2k.c                              |    2 
 drivers/net/ethernet/dlink/dl2k.h                              |    2 
 drivers/net/ethernet/freescale/fec_main.c                      |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c             |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                |   82 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c         |   13 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c      |   25 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h      |    1 
 drivers/net/ethernet/intel/ice/ice.h                           |    5 
 drivers/net/ethernet/intel/ice/ice_common.c                    |  208 +--
 drivers/net/ethernet/intel/ice/ice_common.h                    |    7 
 drivers/net/ethernet/intel/ice/ice_ddp.c                       |   10 
 drivers/net/ethernet/intel/ice/ice_gnss.c                      |   29 
 drivers/net/ethernet/intel/ice/ice_gnss.h                      |    4 
 drivers/net/ethernet/intel/ice/ice_lib.c                       |    2 
 drivers/net/ethernet/intel/ice/ice_ptp.c                       |  133 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c                    |  235 +---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h                    |   11 
 drivers/net/ethernet/intel/ice/ice_type.h                      |    9 
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c             |    5 
 drivers/net/ethernet/intel/idpf/idpf.h                         |   18 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                     |   76 -
 drivers/net/ethernet/intel/idpf/idpf_main.c                    |    1 
 drivers/net/ethernet/intel/igc/igc_ptp.c                       |    6 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c            |    2 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c      |    4 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                    |   18 
 drivers/net/ethernet/mediatek/mtk_star_emac.c                  |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c       |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c      |   32 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                |    5 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c     |    5 
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c                 |   11 
 drivers/net/ethernet/mellanox/mlx5/core/rdma.h                 |    4 
 drivers/net/ethernet/microchip/lan743x_main.c                  |    8 
 drivers/net/ethernet/microchip/lan743x_main.h                  |    1 
 drivers/net/ethernet/mscc/ocelot.c                             |    6 
 drivers/net/ethernet/realtek/rtase/rtase_main.c                |    4 
 drivers/net/ethernet/vertexcom/mse102x.c                       |   36 
 drivers/net/mdio/mdio-mux-meson-gxl.c                          |    3 
 drivers/net/usb/rndis_host.c                                   |   16 
 drivers/net/vxlan/vxlan_vnifilter.c                            |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c         |    6 
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h                   |    1 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c                 |   28 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h                 |    7 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                  |   24 
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h             |    9 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                |   16 
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c                   |    2 
 drivers/net/wireless/purelifi/plfxlc/mac.c                     |    1 
 drivers/nvme/host/Kconfig                                      |    1 
 drivers/nvme/host/pci.c                                        |    2 
 drivers/nvme/host/tcp.c                                        |   31 
 drivers/nvme/target/Kconfig                                    |    1 
 drivers/pinctrl/freescale/pinctrl-imx.c                        |    6 
 drivers/pinctrl/mediatek/pinctrl-airoha.c                      |  159 +-
 drivers/pinctrl/qcom/pinctrl-sm8750.c                          |    4 
 drivers/platform/x86/amd/pmc/pmc.c                             |    7 
 drivers/platform/x86/dell/alienware-wmi.c                      |    9 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c |   13 
 drivers/ptp/ptp_ocp.c                                          |   52 
 drivers/spi/spi-mem.c                                          |    6 
 drivers/spi/spi-tegra114.c                                     |    6 
 drivers/ufs/core/ufshcd.c                                      |    2 
 fs/bcachefs/btree_update_interior.c                            |   17 
 fs/bcachefs/error.c                                            |    8 
 fs/bcachefs/error.h                                            |    2 
 fs/bcachefs/xattr_format.h                                     |    8 
 fs/btrfs/btrfs_inode.h                                         |    8 
 fs/btrfs/extent_io.c                                           |    2 
 fs/btrfs/file.c                                                |    1 
 fs/btrfs/inode.c                                               |  154 +-
 fs/btrfs/ioctl.c                                               |    1 
 fs/btrfs/zoned.c                                               |   18 
 fs/smb/client/smb2pdu.c                                        |    1 
 fs/smb/server/auth.c                                           |   14 
 fs/smb/server/mgmt/user_session.c                              |   20 
 fs/smb/server/mgmt/user_session.h                              |    1 
 fs/smb/server/smb2pdu.c                                        |    9 
 include/linux/blkdev.h                                         |   67 -
 include/linux/cpufreq.h                                        |   86 +
 include/linux/iommu.h                                          |    8 
 include/linux/module.h                                         |    2 
 include/net/bluetooth/hci.h                                    |    4 
 include/net/bluetooth/hci_core.h                               |   20 
 include/net/bluetooth/hci_sync.h                               |    3 
 include/net/xdp_sock.h                                         |    3 
 include/net/xsk_buff_pool.h                                    |    4 
 include/sound/ump_convert.h                                    |    2 
 kernel/params.c                                                |    6 
 kernel/trace/trace.c                                           |    5 
 kernel/trace/trace_output.c                                    |    4 
 mm/memblock.c                                                  |   12 
 mm/slub.c                                                      |   27 
 net/bluetooth/hci_conn.c                                       |  181 ---
 net/bluetooth/hci_event.c                                      |   15 
 net/bluetooth/hci_sync.c                                       |  150 ++
 net/bluetooth/iso.c                                            |   26 
 net/bluetooth/l2cap_core.c                                     |    3 
 net/ipv4/tcp_offload.c                                         |    2 
 net/ipv4/udp_offload.c                                         |   61 +
 net/ipv6/tcpv6_offload.c                                       |    2 
 net/sched/sch_drr.c                                            |   16 
 net/sched/sch_ets.c                                            |   17 
 net/sched/sch_hfsc.c                                           |   10 
 net/sched/sch_htb.c                                            |    2 
 net/sched/sch_qfq.c                                            |   18 
 net/xdp/xsk.c                                                  |    6 
 net/xdp/xsk_buff_pool.c                                        |    1 
 sound/pci/hda/patch_realtek.c                                  |   23 
 sound/soc/amd/acp/acp-i2s.c                                    |    2 
 sound/soc/codecs/Kconfig                                       |    5 
 sound/soc/generic/simple-card-utils.c                          |    4 
 sound/soc/renesas/rz-ssi.c                                     |    2 
 sound/soc/sdw_utils/soc_sdw_rt_dmic.c                          |    2 
 sound/soc/soc-core.c                                           |   32 
 sound/soc/soc-pcm.c                                            |    5 
 sound/soc/stm/stm32_sai_sub.c                                  |   16 
 sound/usb/endpoint.c                                           |    7 
 sound/usb/format.c                                             |    3 
 194 files changed, 2365 insertions(+), 1765 deletions(-)

Aaron Kling (1):
      spi: tegra114: Don't fail set_cs_timing when delays are zero

Alan Huang (1):
      bcachefs: Remove incorrect __counted_by annotation

Alexander Stein (1):
      ASoC: simple-card-utils: Fix pointer check in graph_util_parse_link_direction

Alistair Francis (2):
      nvme-tcp: select CONFIG_TLS from CONFIG_NVME_TCP_TLS
      nvmet-tcp: select CONFIG_TLS from CONFIG_NVME_TARGET_TCP_TLS

Aneesh Kumar K.V (Arm) (1):
      iommu/arm-smmu-v3: Add missing S2FWB feature detection

Anthony Iliopoulos (1):
      powerpc64/ftrace: fix module loading without patchable function entries

Ard Biesheuvel (1):
      x86/boot/sev: Support memory acceptance in the EFI stub under SVSM

Balbir Singh (1):
      iommu/arm-smmu-v3: Fix pgsize_bit for sva domains

Benjamin Marzinski (1):
      dm: always update the array size in realloc_argv on success

Chad Monroe (1):
      net: ethernet: mtk_eth_soc: fix SER panic with 4GB+ RAM

Chen Linxuan (1):
      drm/i915/pxp: fix undefined reference to `intel_pxp_gsccs_is_ready_for_sessions'

Chenyuan Yang (1):
      ASoC: Intel: sof_sdw: Add NULL check in asoc_sdw_rt_dmic_rtd_init()

Chris Bainbridge (1):
      drm/amd/display: Fix slab-use-after-free in hdcp

Chris Chiu (1):
      ALSA: hda/realtek - Add more HP laptops which need mute led fixup

Chris Mi (1):
      net/mlx5: E-switch, Fix error handling for enabling roce

Christian Bruel (2):
      arm64: dts: st: Adjust interrupt-controller for stm32mp25 SoCs
      arm64: dts: st: Use 128kB size for aliased GIC400 register access on stm32mp25 SoCs

Christian Heusel (1):
      Revert "rndis_host: Flag RNDIS modems as WWAN devices"

Christian Marangi (1):
      pinctrl: airoha: fix wrong PHY LED mapping and PHY2 LED defines

Clark Wang (1):
      i2c: imx-lpi2c: Fix clock count when probe defers

Claudiu Beznea (1):
      ASoC: renesas: rz-ssi: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()

Cong Wang (5):
      sch_htb: make htb_qlen_notify() idempotent
      sch_drr: make drr_qlen_notify() idempotent
      sch_hfsc: make hfsc_qlen_notify() idempotent
      sch_qfq: make qfq_qlen_notify() idempotent
      sch_ets: make est_qlen_notify() idempotent

Cosmin Ratiu (1):
      net/mlx5e: Fix lock order in mlx5e_tx_reporter_ptpsq_unhealthy_recover

Cristian Marussi (1):
      firmware: arm_scmi: Balance device refcount when destroying devices

Da Xue (1):
      net: mdio: mux-meson-gxl: set reversed bit when using internal phy

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: sync mtk_clks_source_name array

Dave Chen (1):
      btrfs: fix COW handling in run_delalloc_nocow()

David Sterba (2):
      btrfs: pass struct btrfs_inode to btrfs_read_locked_inode()
      btrfs: pass struct btrfs_inode to btrfs_iget_locked()

Donet Tom (1):
      book3s64/radix : Align section vmemmap start address to PAGE_SIZE

Emmanuel Grumbach (2):
      wifi: iwlwifi: don't warn if the NIC is gone in resume
      wifi: iwlwifi: fix the check for the SCRATCH register upon resume

En-Wei Wu (1):
      Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()

Felix Fietkau (1):
      net: ipv6: fix UDPv6 GSO segmentation with NAT

Geert Uytterhoeven (1):
      ASoC: soc-core: Stop using of_property_read_bool() for non-boolean properties

Geoffrey D. Bennett (1):
      ALSA: usb-audio: Add retry on -EPROTO from usb_set_interface()

Greg Kroah-Hartman (1):
      Linux 6.14.6

Hao Lan (1):
      net: hns3: fixed debugfs tm_qset size

Helge Deller (1):
      parisc: Fix double SIGFPE crash

Hui Wang (1):
      pinctrl: imx: Return NULL if no group is matched and found

Ido Schimmel (1):
      vxlan: vnifilter: Fix unlocked deletion of default FDB entry

Jacob Keller (1):
      igc: fix lock order in igc_ptp_reset

Janne Grunau (1):
      drm: Select DRM_KMS_HELPER from DRM_DEBUG_DP_MST_TOPOLOGY_REFS

Jeongjun Park (1):
      tracing: Fix oob write in trace_seq_to_buffer()

Jethro Donaldson (1):
      smb: client: fix zero length for mkdir POSIX create context

Jian Shen (2):
      net: hns3: store rx VLAN tag offload state for VF
      net: hns3: defer calling ptp_clock_register()

Jianbo Liu (1):
      net/mlx5e: TC, Continue the attr process even if encap entry is invalid

Jibin Zhang (1):
      net: use sock_gen_put() when sk_state is TCP_TIME_WAIT

Joachim Priesner (1):
      ALSA: usb-audio: Add second USB ID for Jabra Evolve 65 headset

Johannes Berg (1):
      wifi: iwlwifi: back off on continuous errors

John Harrison (1):
      drm/xe/guc: Fix capture of steering registers

Josef Bacik (1):
      btrfs: adjust subpage bit start based on sectorsize

Justin Lai (1):
      rtase: Modify the condition used to detect overflow in rtase_calc_time_mitigation

Kailang Yang (1):
      ALSA: hda/realtek - Enable speaker for HP platform

Kalesh AP (1):
      bnxt_en: Fix ethtool selftest output in one of the failure cases

Kan Liang (1):
      perf/x86/intel: Only check the group flag for X86 leader

Karol Kolacinski (2):
      ice: Don't check device type when checking GNSS presence
      ice: Remove unnecessary ice_is_e8xx() functions

Karol Wachowski (4):
      accel/ivpu: Correct DCT interrupt handling
      accel/ivpu: Abort all jobs after command queue unregister
      accel/ivpu: Fix locking order in ivpu_job_submit
      accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW

Kashyap Desai (1):
      bnxt_en: call pci_alloc_irq_vectors() after bnxt_reserve_rings()

Keith Busch (1):
      nvme-pci: fix queue unquiesce check on slot_reset

Kenneth Graunke (1):
      drm/xe: Invalidate L3 read-only cachelines for geometry streams too

Kent Overstreet (1):
      bcachefs: Change btree_insert_node() assertion to error

Keoseong Park (1):
      scsi: ufs: core: Remove redundant query_complete trace

Kiran K (2):
      Bluetooth: btintel_pcie: Avoid redundant buffer allocation
      Bluetooth: btintel_pcie: Add additional to checks to clear TX/RX paths

Kurt Borja (1):
      platform/x86: alienware-wmi-wmax: Add support for Alienware m15 R7

Larysa Zaremba (1):
      idpf: protect shutdown from reset

Leo Li (1):
      drm/amd/display: Default IPS to RCG_IN_ACTIVE_IPS2_IN_OFF

Lijo Lazar (1):
      drm/amdgpu: Fix offset for HDP remap in nbio v7.11

LongPing Wei (1):
      dm-bufio: don't schedule in atomic context

Louis-Alexis Eyraud (2):
      net: ethernet: mtk-star-emac: fix spinlock recursion issues on rx/tx poll
      net: ethernet: mtk-star-emac: rearm interrupts in rx_poll only when advised

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
      Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync

Madhavan Srinivasan (2):
      powerpc/boot: Check for ld-option support
      powerpc/boot: Fix dash warning

Madhu Chittim (1):
      idpf: fix offloads support for encapsulated packets

Maor Gottlieb (1):
      net/mlx5: E-Switch, Initialize MAC Address for Default GID

Mario Limonciello (2):
      platform/x86/amd: pmc: Require at least 2.5 seconds between HW sleep cycles
      drm/amd/display: Add scoped mutexes for amdgpu_dm_dhcp

Mattias Barthel (1):
      net: fec: ERR007885 Workaround for conventional TX

Maulik Shah (1):
      pinctrl: qcom: Fix PINGROUP definition for sm8750

Maxime Ripard (1):
      drm/tests: shmem: Fix memleak

Michael Chan (1):
      bnxt_en: Fix ethtool -d byte order for 32-bit values

Michael Liang (1):
      nvme-tcp: fix premature queue removal and I/O failover

Michal Swiatkowski (1):
      idpf: fix potential memory leak on kcalloc() failure

Mikulas Patocka (1):
      dm-integrity: fix a warning on invalid table line

Ming Lei (5):
      ublk: add helper of ublk_need_map_io()
      ublk: move device reset into ublk_ch_release()
      ublk: remove __ublk_quiesce_dev()
      ublk: simplify aborting ublk request
      ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd

Mingcong Bai (1):
      iommu/vt-d: Apply quirk_iommu_igfx for 8086:0044 (QM57/QS57)

Murad Masimov (1):
      wifi: plfxlc: Remove erroneous assert in plfxlc_mac_release

Namjae Jeon (1):
      ksmbd: fix use-after-free in ksmbd_session_rpc_open

Naohiro Aota (2):
      block: introduce zone capacity helper
      btrfs: zoned: skip reporting zone for new block group

Nico Pache (1):
      firmware: cs_dsp: tests: Depend on FW_CS_DSP rather then enabling it

Nicolin Chen (2):
      iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids
      iommu: Fix two issues in iommu_copy_struct_from_user()

Niravkumar L Rabara (2):
      EDAC/altera: Test the correct error reg offset
      EDAC/altera: Set DDR and SDMMC interrupt mask before registration

Olivier Moysan (2):
      ASoC: stm32: sai: skip useless iterations on kernel rate loop
      ASoC: stm32: sai: add a check on minimal kernel frequency

Paul Greenwalt (1):
      ice: fix Get Tx Topology AQ command error on E830

Pauli Virtanen (1):
      Bluetooth: L2CAP: copy RX timestamp to new fragments

Pavel Paklov (1):
      iommu/amd: Fix potential buffer overflow in parse_ivrs_acpihid

Penglei Jiang (1):
      btrfs: fix the inode leak in btrfs_iget()

Philipp Stanner (1):
      drm/nouveau: Fix WARN_ON in nouveau_fence_context_kill()

Qu Wenruo (1):
      btrfs: expose per-inode stable writes flag

Rafael J. Wysocki (2):
      cpufreq: Avoid using inconsistent policy->min and policy->max
      cpufreq: Fix setting policy limits when frequency tables are used

Raju Rangoju (1):
      spi: spi-mem: Add fix to avoid divide error

Richard Fitzgerald (1):
      ASoC: cs-amp-lib-test: Don't select SND_SOC_CS_AMP_LIB

Richard Zhu (1):
      arm64: dts: imx95: Correct the range of PCIe app-reg region

Ruslan Piasetskyi (1):
      mmc: renesas_sdhi: Fix error handling in renesas_sdhi_probe

Russell Cloran (1):
      drm/mipi-dbi: Fix blanking for non-16 bit formats

Sagi Maimon (1):
      ptp: ocp: Fix NULL dereference in Adva board SMA sysfs operations

Sathesh B Edara (2):
      octeon_ep_vf: Resolve netdevice usage count issue
      octeon_ep: Fix host hang issue during device reboot

Sean Christopherson (1):
      perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest with vCPU's value.

Sean Heelan (2):
      ksmbd: fix use-after-free in kerberos authentication
      ksmbd: fix use-after-free in session logoff

Shannon Nelson (3):
      pds_core: make pdsc_auxbus_dev_del() void
      pds_core: specify auxiliary_device to be created
      pds_core: remove write-after-free of client_id

Sheetal (1):
      ASoC: soc-pcm: Fix hw_params() and DAPM widget sequence

Shouye Liu (1):
      platform/x86/intel-uncore-freq: Fix missing uncore sysfs during CPU hotplug

Shravya KN (1):
      bnxt_en: Fix error handling path in bnxt_init_chip()

Shruti Parab (2):
      bnxt_en: Fix coredump logic to free allocated buffer
      bnxt_en: Fix out-of-bound memcpy() during ethtool -w

Shyam Saini (3):
      kernel: param: rename locate_module_kobject
      kernel: globalize lookup_or_create_module_kobject()
      drivers: base: handle module_kobject creation

Simon Horman (1):
      net: dlink: Correct endianness handling of led_mode

Somnath Kotur (1):
      bnxt_en: Add missing skb_mark_for_recycle() in bnxt_rx_vlan()

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode

Stefan Wahren (4):
      net: vertexcom: mse102x: Fix possible stuck of SPI interrupt
      net: vertexcom: mse102x: Fix LEN_MASK
      net: vertexcom: mse102x: Add range check for CMD_RTS
      net: vertexcom: mse102x: Fix RX error handling

Stephan Gerhold (1):
      irqchip/qcom-mpm: Prevent crash when trying to handle non-wake GPIOs

Steven Rostedt (1):
      tracing: Do not take trace_event_sem in print_event_fields()

Sudeep Holla (1):
      firmware: arm_ffa: Skip Rx buffer ownership release if not acquired

Sébastien Szymanski (1):
      ARM: dts: opos6ul: add ksz8081 phy properties

Takashi Iwai (2):
      ALSA: ump: Fix buffer overflow at UMP SysEx message conversion
      ALSA: hda/realtek: Fix built-mic regression on other ASUS models

Thangaraj Samynathan (1):
      net: lan743x: Fix memleak issue when GSO enabled

Tudor Ambarus (1):
      dm: fix copying after src array boundaries

Tvrtko Ursulin (1):
      drm/fdinfo: Protect against driver unbind

Uday Shankar (2):
      ublk: properly serialize all FETCH_REQs
      ublk: improve detection and handling of ublk server exit

Vadim Fedorenko (2):
      bnxt_en: improve TX timestamping FIFO configuration
      bnxt_en: fix module unload sequence

Venkata Prasad Potturu (1):
      ASoC: amd: acp: Fix NULL pointer deref in acp_i2s_set_tdm_slot

Victor Nogueira (4):
      net_sched: drr: Fix double list add in class with netem as child qdisc
      net_sched: hfsc: Fix a UAF vulnerability in class with netem as child qdisc
      net_sched: ets: Fix double list add in class with netem as child qdisc
      net_sched: qfq: Fix double list add in class with netem as child qdisc

Viresh Kumar (3):
      cpufreq: Introduce policy->boost_supported flag
      cpufreq: acpi: Set policy->boost_supported
      cpufreq: ACPI: Re-sync CPU boost state on system resume

Vishal Badole (1):
      amd-xgbe: Fix to ensure dependent features are toggled with RX checksum offload

Vlad Dogaru (1):
      net/mlx5e: Use custom tunnel header for vxlan gbp

Vladimir Oltean (2):
      net: mscc: ocelot: delete PVID VLAN when readding it as non-PVID
      net: dsa: felix: fix broken taprio gate states after clock jump

Wei Yang (2):
      mm/memblock: pass size instead of end to memblock_set_node()
      mm/memblock: repeat setting reserved region nid if array is doubled

Wentao Liang (1):
      wifi: brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()

Will Deacon (1):
      arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays

Xuanqiang Luo (1):
      ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()

Yonglong Liu (1):
      net: hns3: fix an interrupt residual problem

Zhenhua Huang (1):
      mm, slab: clean up slab->obj_exts always

e.kubanski (2):
      xsk: Fix race condition in AF_XDP generic RX path
      xsk: Fix offset calculation in unaligned mode


