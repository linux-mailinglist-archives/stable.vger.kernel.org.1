Return-Path: <stable+bounces-136682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BCEA9C2EB
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3A816B271
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9AE23D297;
	Fri, 25 Apr 2025 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XA3dL3Ux"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1E23D291;
	Fri, 25 Apr 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572017; cv=none; b=p1um0DFbkxZdzDwV/rh/5L/i6T3rk2p9s8G3CCh9hjzZDCYQUhKnuH7BqqAPGoMB4cJqRG9NQZTlznNMGkFJG9/3wxQk1mZxKXwZ1t7F7KoYmI07JcYoByIQqVBgjosypREHGBqdVhiZdf4rhzdVp/ZE3IOuRKzpS5N2pRiK7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572017; c=relaxed/simple;
	bh=HvvSKO9327fm3IAa/n9eOERpcXOrhNsv8cdhA+0+g0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L+73mk529RaZ15ZXb9GblCczGPI1y6MuGWt2paxc1M/sdys20/KNCTOdVQHUK9oY5DIKi9/PM3ptjJQzq7jkfIRZdY2eB4Xv6H9jnSeeZNAIvq/6OCh2P49nNJeBJHDcjkWl/0lxn/z0ZGeBPtyZcgABJka3y9bDFZGEKRfXF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XA3dL3Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A3EC4CEE4;
	Fri, 25 Apr 2025 09:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745572015;
	bh=HvvSKO9327fm3IAa/n9eOERpcXOrhNsv8cdhA+0+g0o=;
	h=From:To:Cc:Subject:Date:From;
	b=XA3dL3UxIbD0WOLBmIl4qMe+wE1Ebm4+9GEzIoEAtSAgp9IjIUqpH6MvM2rCxMNey
	 jm9AAXaJQYUS2EyBvsfc6DADTj+IjFa8K78UYVmIWtqCuem/ss3c+uSsWGeaqyz/Q+
	 ZFPJLadQhahZHFmEl8Pwz29bfJJHdqFA15EPqScQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.14.4
Date: Fri, 25 Apr 2025 11:06:45 +0200
Message-ID: <2025042546-shuffling-gush-aafb@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.14.4 kernel.

All users of the 6.14 kernel series must upgrade.

The updated 6.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/booting.rst                             |   22 +
 Documentation/devicetree/bindings/soc/fsl/fsl,ls1028a-reset.yaml |    2 
 Documentation/netlink/specs/ovs_vport.yaml                       |    4 
 Documentation/netlink/specs/rt_link.yaml                         |   20 -
 Documentation/netlink/specs/rt_neigh.yaml                        |   14 
 Documentation/wmi/devices/msi-wmi-platform.rst                   |    4 
 Makefile                                                         |    3 
 arch/arm64/include/asm/el2_setup.h                               |   25 +
 arch/arm64/tools/sysreg                                          |  103 ++++++
 arch/mips/dec/prom/init.c                                        |    2 
 arch/mips/include/asm/ds1287.h                                   |    2 
 arch/mips/kernel/cevt-ds1287.c                                   |    1 
 arch/riscv/include/asm/kgdb.h                                    |    9 
 arch/riscv/include/asm/syscall.h                                 |    7 
 arch/riscv/kernel/kgdb.c                                         |    6 
 arch/riscv/kernel/module-sections.c                              |   13 
 arch/riscv/kernel/module.c                                       |   11 
 arch/riscv/kernel/setup.c                                        |   36 ++
 arch/x86/boot/compressed/mem.c                                   |    5 
 arch/x86/boot/compressed/sev.c                                   |   67 ----
 arch/x86/boot/compressed/sev.h                                   |    2 
 arch/x86/events/intel/ds.c                                       |    8 
 arch/x86/events/intel/uncore_snbep.c                             |  107 ------
 arch/x86/kernel/cpu/amd.c                                        |   19 -
 arch/x86/kernel/cpu/microcode/amd.c                              |    9 
 arch/x86/xen/multicalls.c                                        |   26 -
 arch/x86/xen/smp_pv.c                                            |    1 
 arch/x86/xen/xen-ops.h                                           |    3 
 block/bio-integrity.c                                            |   17 -
 block/blk-sysfs.c                                                |    2 
 drivers/accel/ivpu/ivpu_drv.c                                    |    4 
 drivers/accel/ivpu/ivpu_fw.c                                     |    3 
 drivers/accel/ivpu/ivpu_hw.h                                     |   11 
 drivers/accel/ivpu/ivpu_hw_btrs.c                                |  126 +++-----
 drivers/accel/ivpu/ivpu_hw_btrs.h                                |    6 
 drivers/ata/libata-sata.c                                        |   15 
 drivers/block/loop.c                                             |  121 +------
 drivers/bluetooth/btqca.c                                        |    2 
 drivers/bluetooth/btrtl.c                                        |    2 
 drivers/bluetooth/hci_vhci.c                                     |   10 
 drivers/cpufreq/cpufreq.c                                        |    8 
 drivers/crypto/caam/qi.c                                         |    6 
 drivers/crypto/tegra/tegra-se-aes.c                              |    5 
 drivers/dma-buf/sw_sync.c                                        |   19 -
 drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c              |   30 -
 drivers/firmware/cirrus/test/cs_dsp_test_bin.c                   |    2 
 drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c             |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                         |   34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                          |   44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                       |    4 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                           |    4 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                           |   21 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                |   64 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c           |    6 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c        |   28 +
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c               |   15 
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c          |    6 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c        |    7 
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c   |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c            |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c          |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c          |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c                   |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                   |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c             |   55 +++
 drivers/gpu/drm/ast/ast_dp.c                                     |    6 
 drivers/gpu/drm/i915/display/intel_bw.c                          |   14 
 drivers/gpu/drm/i915/display/intel_display.c                     |    4 
 drivers/gpu/drm/i915/display/intel_display_device.h              |    1 
 drivers/gpu/drm/i915/display/intel_dp.c                          |   56 ++-
 drivers/gpu/drm/i915/display/intel_vblank.c                      |    4 
 drivers/gpu/drm/i915/gvt/opregion.c                              |    7 
 drivers/gpu/drm/i915/i915_drv.h                                  |    1 
 drivers/gpu/drm/i915/soc/intel_dram.c                            |    4 
 drivers/gpu/drm/imagination/pvr_fw.c                             |   27 +
 drivers/gpu/drm/imagination/pvr_job.c                            |    7 
 drivers/gpu/drm/imagination/pvr_queue.c                          |    4 
 drivers/gpu/drm/mgag200/mgag200_mode.c                           |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                            |   72 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                            |    8 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h         |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h         |    1 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h         |    3 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h          |    4 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h           |    3 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h           |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                        |    3 
 drivers/gpu/drm/msm/dsi/dsi_host.c                               |    9 
 drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml              |    7 
 drivers/gpu/drm/nouveau/nouveau_bo.c                             |    3 
 drivers/gpu/drm/nouveau/nouveau_gem.c                            |    3 
 drivers/gpu/drm/sti/Makefile                                     |    2 
 drivers/gpu/drm/tiny/repaper.c                                   |    4 
 drivers/gpu/drm/v3d/v3d_sched.c                                  |   16 -
 drivers/gpu/drm/virtio/virtgpu_gem.c                             |   11 
 drivers/gpu/drm/virtio/virtgpu_plane.c                           |   20 -
 drivers/gpu/drm/xe/xe_device_types.h                             |    1 
 drivers/gpu/drm/xe/xe_dma_buf.c                                  |    5 
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c                      |   12 
 drivers/gpu/drm/xe/xe_guc_ads.c                                  |   75 ++--
 drivers/gpu/drm/xe/xe_hmm.c                                      |   24 -
 drivers/gpu/drm/xe/xe_migrate.c                                  |    2 
 drivers/i2c/busses/i2c-cros-ec-tunnel.c                          |    3 
 drivers/i2c/i2c-atr.c                                            |    2 
 drivers/infiniband/core/cma.c                                    |    4 
 drivers/infiniband/core/umem_odp.c                               |    6 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                         |   10 
 drivers/infiniband/hw/hns/hns_roce_main.c                        |    2 
 drivers/infiniband/hw/usnic/usnic_ib_main.c                      |   14 
 drivers/md/md-bitmap.c                                           |    5 
 drivers/md/raid10.c                                              |    1 
 drivers/net/can/rockchip/rockchip_canfd-core.c                   |    7 
 drivers/net/dsa/b53/b53_common.c                                 |   10 
 drivers/net/dsa/mv88e6xxx/chip.c                                 |   13 
 drivers/net/dsa/mv88e6xxx/devlink.c                              |    3 
 drivers/net/ethernet/amd/pds_core/debugfs.c                      |    5 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                        |    4 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c               |    1 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c                 |    3 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c                  |    7 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c                |    6 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h                 |    3 
 drivers/net/ethernet/intel/igc/igc.h                             |    1 
 drivers/net/ethernet/intel/igc/igc_defines.h                     |    6 
 drivers/net/ethernet/intel/igc/igc_main.c                        |    1 
 drivers/net/ethernet/intel/igc/igc_ptp.c                         |  113 ++++---
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c                 |    2 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                      |   49 +--
 drivers/net/ethernet/mediatek/mtk_eth_soc.h                      |    1 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                         |   15 
 drivers/net/ethernet/ti/icssg/icss_iep.c                         |  154 ++++++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c                    |    3 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                  |    3 
 drivers/net/wireless/ath/ath12k/dp_mon.c                         |    4 
 drivers/net/wireless/atmel/at76c50x-usb.c                        |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c        |    4 
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c             |    8 
 drivers/net/wireless/ti/wl1251/tx.c                              |    4 
 drivers/nvme/target/fc.c                                         |   14 
 drivers/nvme/target/pci-epf.c                                    |   74 +++-
 drivers/pci/pci.c                                                |    4 
 drivers/platform/mellanox/mlxbf-bootctl.c                        |    4 
 drivers/platform/x86/amd/pmf/auto-mode.c                         |    4 
 drivers/platform/x86/amd/pmf/cnqf.c                              |    8 
 drivers/platform/x86/amd/pmf/core.c                              |   14 
 drivers/platform/x86/amd/pmf/pmf.h                               |    1 
 drivers/platform/x86/amd/pmf/sps.c                               |   12 
 drivers/platform/x86/amd/pmf/tee-if.c                            |    6 
 drivers/platform/x86/asus-laptop.c                               |    9 
 drivers/platform/x86/dell/alienware-wmi.c                        |   56 +++
 drivers/platform/x86/msi-wmi-platform.c                          |   99 ++++--
 drivers/ptp/ptp_ocp.c                                            |    1 
 drivers/ras/amd/atl/internal.h                                   |    3 
 drivers/ras/amd/atl/umc.c                                        |   19 +
 drivers/ras/amd/fmpm.c                                           |    9 
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                           |    9 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                           |   14 
 drivers/scsi/megaraid/megaraid_sas_base.c                        |    9 
 drivers/scsi/megaraid/megaraid_sas_fusion.c                      |    5 
 drivers/scsi/scsi_transport_iscsi.c                              |    7 
 drivers/scsi/smartpqi/smartpqi_init.c                            |   13 
 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c   |   33 +-
 drivers/ufs/host/ufs-exynos.c                                    |   41 ++
 drivers/ufs/host/ufs-exynos.h                                    |    5 
 fs/Kconfig                                                       |    1 
 fs/btrfs/ioctl.c                                                 |    2 
 fs/btrfs/super.c                                                 |    3 
 fs/eventpoll.c                                                   |   38 +-
 fs/fuse/virtio_fs.c                                              |    3 
 fs/hfs/bnode.c                                                   |    6 
 fs/hfsplus/bnode.c                                               |    6 
 fs/isofs/export.c                                                |    2 
 fs/nfs/Kconfig                                                   |    2 
 fs/nfs/internal.h                                                |    7 
 fs/nfs/nfs4session.h                                             |    4 
 fs/nfsd/Kconfig                                                  |    1 
 fs/nfsd/nfs4state.c                                              |    2 
 fs/nfsd/nfsfh.h                                                  |    7 
 fs/overlayfs/overlayfs.h                                         |    2 
 fs/overlayfs/super.c                                             |    5 
 fs/smb/client/cifsproto.h                                        |    2 
 fs/smb/client/connect.c                                          |   34 --
 fs/smb/client/file.c                                             |   28 +
 fs/smb/server/connection.c                                       |    4 
 fs/smb/server/oplock.c                                           |   29 -
 fs/smb/server/oplock.h                                           |    1 
 fs/smb/server/smb2pdu.c                                          |    4 
 fs/smb/server/transport_ipc.c                                    |    7 
 fs/smb/server/transport_tcp.c                                    |   14 
 fs/smb/server/transport_tcp.h                                    |    1 
 fs/smb/server/vfs.c                                              |    3 
 include/drm/intel/pciids.h                                       |    1 
 include/linux/backing-dev.h                                      |    1 
 include/linux/firmware/cirrus/cs_dsp_test_utils.h                |    1 
 include/linux/nfs.h                                              |    7 
 include/uapi/drm/ivpu_accel.h                                    |    4 
 io_uring/rsrc.c                                                  |   17 +
 kernel/sched/cpufreq_schedutil.c                                 |   46 ++
 kernel/trace/ftrace.c                                            |    7 
 kernel/trace/trace_events_filter.c                               |    4 
 lib/alloc_tag.c                                                  |   15 
 lib/iov_iter.c                                                   |    2 
 lib/string.c                                                     |   13 
 mm/compaction.c                                                  |    6 
 mm/filemap.c                                                     |    1 
 mm/gup.c                                                         |    4 
 mm/memory.c                                                      |    4 
 mm/slub.c                                                        |   10 
 mm/userfaultfd.c                                                 |   13 
 mm/vma.c                                                         |   38 ++
 mm/vma.h                                                         |    9 
 net/bluetooth/hci_event.c                                        |    5 
 net/bluetooth/l2cap_core.c                                       |   21 +
 net/bridge/br_vlan.c                                             |    4 
 net/dsa/dsa.c                                                    |   59 +++
 net/dsa/tag_8021q.c                                              |    2 
 net/ethtool/cmis_cdb.c                                           |    2 
 net/ipv6/route.c                                                 |    1 
 net/mac80211/iface.c                                             |    3 
 net/mctp/af_mctp.c                                               |    3 
 net/netfilter/nf_flow_table_core.c                               |   10 
 net/openvswitch/flow_netlink.c                                   |    3 
 net/smc/af_smc.c                                                 |    5 
 rust/Makefile                                                    |    2 
 rust/helpers/io.c                                                |   34 +-
 scripts/Makefile.compiler                                        |    4 
 scripts/generate_rust_analyzer.py                                |   12 
 sound/pci/hda/Kconfig                                            |    4 
 sound/pci/hda/patch_realtek.c                                    |   23 -
 sound/soc/codecs/cs42l43-jack.c                                  |    3 
 sound/soc/codecs/lpass-wsa-macro.c                               |  117 +++++--
 sound/soc/dwc/dwc-i2s.c                                          |   13 
 sound/soc/fsl/fsl_qmc_audio.c                                    |    3 
 sound/soc/intel/avs/pcm.c                                        |    3 
 sound/soc/intel/boards/sof_sdw.c                                 |    1 
 sound/soc/qcom/lpass.h                                           |    3 
 tools/objtool/check.c                                            |    1 
 tools/perf/util/evsel.c                                          |   22 -
 tools/testing/kunit/qemu_configs/sh.py                           |    4 
 tools/testing/selftests/mincore/mincore_selftest.c               |   16 -
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh            |    4 
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh           |    2 
 tools/testing/shared/linux.c                                     |    4 
 246 files changed, 2157 insertions(+), 1271 deletions(-)

Abdun Nihaal (7):
      wifi: at76c50x: fix use after free access in at76_disconnect
      wifi: brcmfmac: fix memory leak in brcmf_get_module_param
      wifi: wl1251: fix memory leak in wl1251_tx_work
      pds_core: fix memory leak in pdsc_debugfs_add_qcq()
      net: ngbe: fix memory leak in ngbe_probe() error path
      cxgb4: fix memory leak in cxgb4_init_ethtool_filters() error path
      net: txgbe: fix memory leak in txgbe_probe() error path

Akhil P Oommen (1):
      drm/msm/a6xx: Fix stale rpmh votes from GPU

Akhil R (1):
      crypto: tegra - Fix IV usage for AES ECB

Alex Deucher (3):
      drm/amdgpu/mes12: optimize MES pipe FW version fetching
      drm/amdgpu/mes11: optimize MES pipe FW version fetching
      drm/amd/display/dml2: use vzalloc rather than kzalloc

Alex Williamson (1):
      Revert "PCI: Avoid reset when disabled via sysfs"

Alexander Tsoy (1):
      Revert "wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process"

Andreas Gruenbacher (1):
      writeback: fix false warning in inode_to_wb()

Andrzej Kacprowski (1):
      accel/ivpu: Fix the NPU's DPU frequency calculation

Andy Shevchenko (1):
      i2c: atr: Fix wrong include

Ankit Nautiyal (3):
      drm/i915/vrr: Add vrr.vsync_{start, end} in vrr_params_changed
      drm/i915/display: Add macro for checking 3 DSC engines
      drm/i915/dp: Check for HAS_DSC_3ENGINES while configuring DSC slices

Anshuman Khandual (7):
      arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
      arm64/sysreg: Add register fields for HDFGRTR2_EL2
      arm64/sysreg: Add register fields for HDFGWTR2_EL2
      arm64/sysreg: Add register fields for HFGITR2_EL2
      arm64/sysreg: Add register fields for HFGRTR2_EL2
      arm64/sysreg: Add register fields for HFGWTR2_EL2
      arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9

Ard Biesheuvel (1):
      x86/boot/sev: Avoid shared GHCB page for early memory acceptance

Armin Wolf (2):
      platform/x86: msi-wmi-platform: Rename "data" variable
      platform/x86: msi-wmi-platform: Workaround a ACPI firmware bug

Aurabindo Pillai (1):
      drm/amd/display: Temporarily disable hostvm on DCN31

Baolin Wang (1):
      selftests: mincore: fix tmpfs mincore test failure

Baoquan He (1):
      mm/gup: fix wrongly calculated returned value in fault_in_safe_writeable()

Björn Töpel (1):
      riscv: Properly export reserved regions in /proc/iomem

Bo-Cun Chen (3):
      net: ethernet: mtk_eth_soc: reapply mdc divider on reset
      net: ethernet: mtk_eth_soc: correct the max weight of the queue limit for 100Mbps
      net: ethernet: mtk_eth_soc: revise QDMA packet scheduler settings

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Extend the SHA check to Zen5, block loading of any unreleased standalone Zen5 microcode patches

Brady Norander (1):
      ASoC: dwc: always enable/disable i2s irqs

Brendan King (2):
      drm/imagination: fix firmware memory leaks
      drm/imagination: take paired job reference

Brendan Tam (1):
      drm/amd/display: prevent hang on link training fail

Chandrakanth Patil (1):
      scsi: megaraid_sas: Block zero-length ATA VPD inquiry

Charles Keepax (1):
      ASoC: cs42l43: Reset clamp override on jack removal

Chengchang Tang (1):
      RDMA/hns: Fix wrong maximum DMA segment size

Chenyuan Yang (2):
      octeontx2-pf: handle otx2_mbox_get_rsp errors
      drm/msm/dpu: Fix error pointers in dpu_plane_virtual_atomic_check

Chris Bainbridge (1):
      drm/nouveau: prime: fix ttm_bo_delayed_delete oops

Christian König (1):
      drm/amdgpu: immediately use GTT for new allocations

Christoph Hellwig (1):
      loop: stop using vfs_iter_{read,write} for buffered I/O

Christopher S M Hall (6):
      igc: fix PTM cycle trigger logic
      igc: increase wait time before retrying PTM
      igc: move ktime snapshot into PTM retry loop
      igc: handle the IGC_PTP_ENABLED flag correctly
      igc: cleanup PTP module if probe fails
      igc: add lock preventing multiple simultaneous PTM transactions

Chunjie Zhu (1):
      smb3 client: fix open hardlink on deferred close file error

Damien Le Moal (2):
      nvmet: pci-epf: always fully initialize completion entries
      nvmet: pci-epf: clear CC and CSTS when disabling the controller

Damodharam Ammepalli (1):
      ethtool: cmis_cdb: use correct rpl size in ethtool_cmis_module_poll()

Dan Carpenter (2):
      Bluetooth: btrtl: Prevent potential NULL dereference
      dma-buf/sw_sync: Decrement refcount on error in sw_sync_ioctl_get_deadline()

Dapeng Mi (1):
      perf/x86/intel: Allow to update user space GPRs from PEBS records

David Thompson (1):
      mlxbf-bootctl: use sysfs_emit_at() in secure_boot_fuse_state_show()

Denis Arefev (8):
      asus-laptop: Fix an uninitialized variable
      ksmbd: Prevent integer overflow in calculation of deadtime
      drm/amd/pm: Prevent division by zero
      drm/amd/pm/powerplay: Prevent division by zero
      drm/amd/pm/smu11: Prevent division by zero
      drm/amd/pm/powerplay/hwmgr/smu7_thermal: Prevent division by zero
      drm/amd/pm/swsmu/smu13/smu_v13_0: Prevent division by zero
      drm/amd/pm/powerplay/hwmgr/vega20_thermal: Prevent division by zero

Dmitry Baryshkov (2):
      Bluetooth: qca: fix NV variant for one of WCN3950 SoCs
      drm/msm/dpu: drop rogue intr_tear_rd_ptr values

Dmitry Osipenko (2):
      drm/virtio: Don't attach GEM to a non-created context in gem_object_open()
      drm/virtio: Fix missed dmabuf unpinning in error path of prepare_fb()

Edward Adam Davis (1):
      isofs: Prevent the use of too small fid

Eric Biggers (1):
      nfs: add missing selections of CONFIG_CRC32

Evgeny Pimenov (1):
      ASoC: qcom: Fix sc7280 lpass potential buffer overflow

FUJITA Tomonori (1):
      rust: helpers: Remove volatile qualifier from io helpers

Florian Westphal (1):
      netfilter: conntrack: fix erronous removal of offload bit

Frédéric Danis (2):
      Bluetooth: l2cap: Check encryption key size on incoming connection
      Bluetooth: l2cap: Process valid commands in too long frame

Geert Uytterhoeven (1):
      dt-bindings: soc: fsl: fsl,ls1028a-reset: Fix maintainer entry

Giuseppe Scrivano (1):
      ovl: remove unused forward declaration

Greg Kroah-Hartman (1):
      Linux 6.14.4

Haoxiang Li (1):
      drm/msm/dsi: Add check for devm_kstrdup()

Henry Martin (1):
      ASoC: Intel: avs: Fix null-ptr-deref in avs_component_probe()

Herbert Xu (1):
      crypto: caam/qi - Fix drv_ctx refcount bug

Herve Codina (1):
      ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on TRIGGER_START event

Huacai Chen (3):
      drm/amd/display: Protect FPU in dml2_validate()/dml21_validate()
      drm/amd/display: Protect FPU in dml21_copy()
      drm/amd/display: Protect FPU in dml2_init()/dml21_init()

Ilya Maximets (1):
      net: openvswitch: fix nested key length validation in the set() action

Jakub Kicinski (6):
      netlink: specs: ovs_vport: align with C codegen capabilities
      eth: bnxt: fix missing ring index trim on error path
      netlink: specs: rt-link: add an attr layer around alt-ifname
      netlink: specs: rtnetlink: attribute naming corrections
      netlink: specs: rt-link: adjust mctp attribute naming
      netlink: specs: rt-neigh: prefix struct nfmsg members with ndm

Jani Nikula (1):
      drm/i915/gvt: fix unterminated-string-initialization warning

Jens Axboe (1):
      eventpoll: abstract out ep_try_send_events() helper

Jijie Shao (4):
      net: hibmcge: fix incorrect pause frame statistics issue
      net: hibmcge: fix incorrect multicast filtering issue
      net: hibmcge: fix wrong mtu log issue
      net: hibmcge: fix not restore rx pause mac addr after reset issue

Jocelyn Falempe (1):
      drm/ast: Fix ast_dp connection status

Joe Damato (1):
      eventpoll: Set epoll timeout if it's in the future

Johannes Berg (2):
      wifi: iwlwifi: pcie: set state to no-FW before reset handshake
      Revert "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Johannes Kimmel (1):
      btrfs: correctly escape subvol in btrfs_show_options()

Jonas Gorski (2):
      net: b53: enable BPDU reception for management port
      net: bridge: switchdev: do not notify new brentries as changed

Juergen Gross (1):
      xen: fix multicall debug feature

Kailang Yang (1):
      ALSA: hda/realtek - Fixed ASUS platform headset Mic issue

Kan Liang (3):
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on ICX
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on SPR

Kashyap Desai (1):
      RDMA/bnxt_re: Fix budget handling of notification queue

Kees Cook (1):
      Bluetooth: vhci: Avoid needless snprintf() calls

Kirill A. Shutemov (1):
      mm: fix apply_to_existing_page_range()

Kuniyuki Iwashima (3):
      smc: Fix lockdep false-positive for IPPROTO_SMC.
      Revert "smb: client: Fix netns refcount imbalance causing leaks and use-after-free"
      Revert "smb: client: fix TCP timers deadlock after rmmod"

Kurt Borja (2):
      platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1
      platform/x86: alienware-wmi-wmax: Extend support to more laptops

Leo Li (2):
      drm/amd/display: Actually do immediate vblank disable
      drm/amd/display: Increase vblank offdelay for PSR panels

Leon Romanovsky (1):
      RDMA/bnxt_re: Remove unusable nq variable

Li Lingfeng (1):
      nfsd: decrease sc_count directly if fail to queue dl_recall

Lijo Lazar (1):
      drm/amdgpu: Prefer shadow rom when available

Lorenzo Stoakes (1):
      mm/vma: add give_up_on_oom option on modify/merge, use in uffd release

Lucas De Marchi (1):
      drm/xe: Set LRC addresses before guc load

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address

Lukas Fischer (1):
      scripts: generate_rust_analyzer: Add ffi crate

Mario Limonciello (4):
      platform/x86: amd: pmf: Fix STT limits
      drm/amd: Handle being compiled without SI or CIK support better
      drm/amd/display: Add HP Elitebook 645 to the quirk list for eDP on DP1
      drm/amd/display: Add HP Probook 445 and 465 to the quirk list for eDP on DP1

Mark Brown (1):
      selftests/mm: generate a temporary mountpoint for cgroup filesystem

Martin K. Petersen (1):
      block: integrity: Do not call set_page_dirty_lock()

Martin Wilck (1):
      scsi: smartpqi: Use is_kdump_kernel() to check for kdump

Matt Johnston (1):
      net: mctp: Set SOCK_RCU_FREE

Matt Roper (1):
      drm/xe/bmg: Add one additional PCI ID

Matthew Auld (3):
      drm/amdgpu/dma_buf: fix page_link check
      drm/xe/dma_buf: stop relying on placement in unmap
      drm/xe/userptr: fix notifier vs folio deadlock

Matthew Brost (1):
      drm/xe: Use local fence in error path of xe_migrate_clear

Matthew Wilcox (Oracle) (1):
      test suite: use %zu to print size_t

Maíra Canal (1):
      drm/v3d: Fix Indirect Dispatch configuration for V3D 7.1.6 and later

Meghana Malladi (3):
      net: ti: icss-iep: Add pwidth configuration for perout signal
      net: ti: icss-iep: Add phase offset configuration for perout signal
      net: ti: icss-iep: Fix possible NULL pointer dereference for perout request

Menglong Dong (1):
      ftrace: fix incorrect hash size in register_ftrace_direct()

Miaoqian Lin (1):
      scsi: iscsi: Fix missing scsi_host_put() in error path

Michael Walle (1):
      net: ethernet: ti: am65-cpsw: fix port_np reference counting

Miguel Ojeda (4):
      objtool/rust: add one more `noreturn` Rust function for Rust 1.86.0
      rust: kasan/kbuild: fix missing flags on first build
      rust: disable `clippy::needless_continue`
      rust: kbuild: use `pound` to support GNU Make < 4.3

Miklos Szeredi (1):
      ovl: don't allow datadir only

Namhyung Kim (1):
      perf tools: Remove evsel__handle_error_quirks()

Namjae Jeon (3):
      ksmbd: fix use-after-free in __smb2_lease_break_noti()
      ksmbd: fix use-after-free in smb_break_all_levII_oplock()
      ksmbd: fix the warning from __kernel_write_iter

Nathan Chancellor (1):
      riscv: Avoid fortify warning in syscall_get_arguments()

Nikita Zhandarovich (1):
      drm/repaper: fix integer overflows in repeat functions

Niklas Cassel (1):
      ata: libata-sata: Save all fields from sense data descriptor

P Praneesh (1):
      wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process

Pavel Begunkov (1):
      io_uring: don't post tag CQEs on file/buffer registration failure

Peter Collingbourne (1):
      string: Add load_unaligned_zeropad() code path to sized_strscpy()

Peter Griffin (3):
      scsi: ufs: exynos: Move UFS shareability value to drvdata
      scsi: ufs: exynos: Disable iocc if dma-coherent property isn't set
      scsi: ufs: exynos: Ensure consistent phy reference counts

Peter Ujfalusi (1):
      ASoC: Intel: sof_sdw: Add quirk for Asus Zenbook S16

Rafael J. Wysocki (3):
      cpufreq/sched: Fix the usage of CPUFREQ_NEED_UPDATE_LIMITS
      cpufreq/sched: Explicitly synchronize limits_changed flag handling
      cpufreq: Reference count policy in cpufreq_update_limits()

Remi Pommarel (2):
      wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
      wifi: mac80211: Purge vif txq in ieee80211_do_stop()

Richard Fitzgerald (2):
      ALSA: hda/cirrus_scodec_test: Don't select dependencies
      firmware: cs_dsp: test_bin_error: Fix uninitialized data used as fw version

Rob Clark (1):
      drm/msm/a6xx+: Don't let IB_SIZE overflow

Rolf Eike Beer (1):
      drm/sti: remove duplicate object names

Sagi Maimon (1):
      ptp: ocp: fix start time alignment in ptp_ocp_signal_set

Sami Tolvanen (1):
      rust: kbuild: Don't export __pfx symbols

Samuel Holland (2):
      riscv: module: Fix out-of-bounds relocation access
      riscv: module: Allocate PLT entries for R_RISCV_PLT32

Sandipan Das (1):
      x86/cpu/amd: Fix workaround for erratum 1054

Sean Heelan (1):
      ksmbd: Fix dangling pointer in krb_authenticate

Sharath Srinivasan (1):
      RDMA/cma: Fix workqueue crash in cma_netevent_work_handler

Shay Drory (1):
      RDMA/core: Silence oversized kvmalloc() warning

Sheng Yong (1):
      lib/iov_iter: fix to increase non slab folio refcount

Sidong Yang (1):
      btrfs: ioctl: don't free iov when btrfs_encoded_read() returns -EAGAIN

Srinivas Kandagatla (2):
      ASoC: codecs:lpass-wsa-macro: Fix vi feedback rate
      ASoC: codecs:lpass-wsa-macro: Fix logic of enabling vi channels

Srinivas Pandruvada (1):
      thermal: intel: int340x: Fix Panther Lake DLVR support

Steven Rostedt (1):
      tracing: Fix filter string testing

Suren Baghdasaryan (1):
      slab: ensure slab->obj_exts is clear in a newly allocated slab page

T.J. Mercier (1):
      alloc_tag: handle incomplete bulk allocations in vm_module_tags_populate

Thadeu Lima de Souza Cascardo (1):
      i2c: cros-ec-tunnel: defer probe if parent EC is not present

Thomas Hellström (1):
      drm/xe: Fix an out-of-bounds shift when invalidating TLB

Thomas Weißschuh (3):
      kunit: qemu_configs: SH: Respect kunit cmdline
      loop: properly send KOBJ_CHANGED uevent for disk device
      loop: LOOP_SET_FD: send uevents for partitions

Thomas Zimmermann (1):
      drm/mgag200: Fix value in <VBLKSTR> register

Tom Chung (1):
      drm/amd/display: Do not enable Replay and PSR while VRR is on in amdgpu_dm_commit_planes()

Tomasz Pakuła (1):
      drm/amd/pm: Add zero RPM enabled OD setting support for SMU14.0.2

Vasiliy Kovalev (1):
      hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key

Ville Syrjälä (2):
      drm/i915: Fix scanline_offset for LNL+ and BMG+
      drm/i915/dp: Reject HBR3 when sink doesn't support TPS4

Vishal Moola (Oracle) (2):
      mm/compaction: fix bug in hugetlb handling pathway
      mm: fix filemap_get_folios_contig returning batches of identical folios

Vivek Kasireddy (1):
      drm/i915/xe2hpd: Identify the memory type for SKUs with GDDR + ECC

Vladimir Oltean (5):
      net: dsa: mv88e6xxx: avoid unregistering devlink regions which were never registered
      net: dsa: mv88e6xxx: fix -ENOENT when deleting VLANs and MST is unsupported
      net: dsa: clean up FDB, MDB, VLAN entries on unbind
      net: dsa: free routing table on probe failure
      net: dsa: avoid refcount warnings when ds->ops->tag_8021q_vlan_del() fails

WangYuli (6):
      riscv: KGDB: Do not inline arch_kgdb_breakpoint()
      riscv: KGDB: Remove ".option norvc/.option rvc" for kgdb_compiled_break
      nvmet-fc: Remove unused functions
      MIPS: dec: Declare which_prom() as static
      MIPS: cevt-ds1287: Add missing ds1287.h include
      MIPS: ds1287: Match ds1287_set_base_clock() function types

Weizhao Ouyang (1):
      can: rockchip_canfd: fix broken quirks checks

Will Pierce (1):
      riscv: Use kvmalloc_array on relocation_hashtable

Xiangsheng Hou (1):
      virtiofs: add filesystem context source name check

Xin Long (1):
      ipv6: add exception routes to GC list in rt6_insert_exception

Xingui Yang (1):
      scsi: hisi_sas: Enable force phy when SATA disk directly connected

Yazen Ghannam (2):
      RAS/AMD/ATL: Include row[13] bit in row retirement
      RAS/AMD/FMPM: Get masked address

Yu Kuai (1):
      md/raid10: fix missing discard IO accounting

Yue Haibing (1):
      RDMA/usnic: Fix passing zero to PTR_ERR in usnic_ib_pci_probe()

Yunlong Xing (1):
      loop: aio inherit the ioprio of original request

ZhenGuo Yin (1):
      drm/amdgpu: fix warning of drm_mm_clean

Zheng Qixing (2):
      md/md-bitmap: fix stats collection for external bitmaps
      block: fix resource leak in blk_register_queue() error path


