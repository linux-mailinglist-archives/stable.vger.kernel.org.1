Return-Path: <stable+bounces-136676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90906A9C2DA
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 11:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58614C1943
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FA2367A1;
	Fri, 25 Apr 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qOxOGIGv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9621ABA7;
	Fri, 25 Apr 2025 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571987; cv=none; b=BJDiOJQQ/ivPvXWgqCYPgZ66RNzq6lnA2ZS8KnDcp3DKMQDZs1Xr8+C5b4jeYqw8Ntc0wdBT2iZfXjs8al9+eVNm5Bjv663vxz5DDYOAP/zpHgK1N7sgI35YHHgrSTrYS69dB6yK6sWO2o/lEVHep689AC2LNjfWOeBcs73XcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571987; c=relaxed/simple;
	bh=HnK884sdahM0ZOk3NOEgQEj99VU/es5H51+oG1+mqvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IeW1+Qyspkdtj3M4hFRhinS6ztFx7KZfyLvRGi3K7uG7wCUWBsceLRuEjmnmTFiE0d+QUlzKslrseTg968gzx7vhCbvHUWnPmmSjm2tQOVfAFo6GXong+6Luf6qAosoqk6MLfCpQWgu7TJ10MwTF1NRlqdSGnO9E71vXBjtRl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qOxOGIGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E86C4CEE4;
	Fri, 25 Apr 2025 09:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745571987;
	bh=HnK884sdahM0ZOk3NOEgQEj99VU/es5H51+oG1+mqvI=;
	h=From:To:Cc:Subject:Date:From;
	b=qOxOGIGviuIXe+jWzHXUgS4FnMLgFIEJq1wz5oqgiMfPSb2SGnhSw/lXhgNsgBeRw
	 kqE8XqY/7v7TBsFLWFV7fd9YHxYE5VIxuGsZeNcqbrandrT+kfj1/icN7/zW8eEC92
	 +nZ6skHoMv5y/N9cDWO/s7cu3+27pvjNXYI9IKoY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.135
Date: Fri, 25 Apr 2025 11:06:22 +0200
Message-ID: <2025042523-ranking-polygon-326c@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.135 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 MAINTAINERS                                                       |    1 
 Makefile                                                          |    5 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                          |    6 
 arch/arm64/include/asm/cputype.h                                  |    4 
 arch/arm64/include/asm/fpsimd.h                                   |    4 
 arch/arm64/include/asm/kvm_host.h                                 |   19 
 arch/arm64/include/asm/kvm_hyp.h                                  |    1 
 arch/arm64/include/asm/processor.h                                |    7 
 arch/arm64/include/asm/spectre.h                                  |    1 
 arch/arm64/kernel/fpsimd.c                                        |   69 ++-
 arch/arm64/kernel/process.c                                       |    2 
 arch/arm64/kernel/proton-pack.c                                   |  218 +++++-----
 arch/arm64/kernel/ptrace.c                                        |    3 
 arch/arm64/kernel/signal.c                                        |    7 
 arch/arm64/kvm/arm.c                                              |    7 
 arch/arm64/kvm/fpsimd.c                                           |   92 +---
 arch/arm64/kvm/hyp/entry.S                                        |    5 
 arch/arm64/kvm/hyp/include/hyp/switch.h                           |  106 +++-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                                |    8 
 arch/arm64/kvm/hyp/nvhe/pkvm.c                                    |   17 
 arch/arm64/kvm/hyp/nvhe/switch.c                                  |   91 ++--
 arch/arm64/kvm/hyp/vhe/switch.c                                   |   12 
 arch/arm64/kvm/reset.c                                            |    3 
 arch/arm64/mm/mmu.c                                               |    3 
 arch/loongarch/kernel/acpi.c                                      |   12 
 arch/loongarch/net/bpf_jit.c                                      |    2 
 arch/loongarch/net/bpf_jit.h                                      |    5 
 arch/mips/dec/prom/init.c                                         |    2 
 arch/mips/include/asm/ds1287.h                                    |    2 
 arch/mips/kernel/cevt-ds1287.c                                    |    1 
 arch/powerpc/kernel/rtas.c                                        |    4 
 arch/riscv/include/asm/kgdb.h                                     |    9 
 arch/riscv/include/asm/syscall.h                                  |    7 
 arch/riscv/kernel/kgdb.c                                          |    6 
 arch/riscv/kernel/setup.c                                         |   36 +
 arch/sparc/mm/tlb.c                                               |    5 
 arch/x86/events/intel/ds.c                                        |    8 
 arch/x86/events/intel/uncore_snbep.c                              |  107 ----
 arch/x86/kernel/cpu/amd.c                                         |    2 
 arch/x86/kernel/cpu/intel.c                                       |   20 
 arch/x86/kernel/e820.c                                            |   17 
 arch/x86/kvm/x86.c                                                |    4 
 arch/x86/platform/pvh/head.S                                      |    7 
 block/blk-cgroup.c                                                |   24 -
 block/blk-cgroup.h                                                |    1 
 block/blk-iocost.c                                                |    7 
 certs/Makefile                                                    |    2 
 certs/extract-cert.c                                              |  138 +++---
 drivers/acpi/platform_profile.c                                   |   20 
 drivers/ata/ahci.c                                                |    2 
 drivers/ata/libata-eh.c                                           |   11 
 drivers/ata/pata_pxa.c                                            |    6 
 drivers/ata/sata_sx4.c                                            |   13 
 drivers/base/devres.c                                             |    7 
 drivers/block/loop.c                                              |    7 
 drivers/bluetooth/btqca.c                                         |   13 
 drivers/bluetooth/btrtl.c                                         |    2 
 drivers/bluetooth/hci_ldisc.c                                     |   19 
 drivers/bluetooth/hci_uart.h                                      |    1 
 drivers/bus/mhi/host/main.c                                       |   16 
 drivers/char/tpm/tpm_tis_core.c                                   |   20 
 drivers/char/tpm/tpm_tis_core.h                                   |    1 
 drivers/clk/qcom/gdsc.c                                           |   61 +-
 drivers/clocksource/timer-stm32-lp.c                              |    4 
 drivers/cpufreq/cpufreq.c                                         |    8 
 drivers/crypto/caam/qi.c                                          |    6 
 drivers/crypto/ccp/sp-pci.c                                       |   15 
 drivers/gpio/gpio-tegra186.c                                      |   27 -
 drivers/gpio/gpio-zynq.c                                          |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                           |   44 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                          |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                          |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c            |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |   14 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c         |   22 -
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c                 |    2 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                  |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c             |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c           |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c           |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                 |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c                    |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                    |    2 
 drivers/gpu/drm/drm_atomic_helper.c                               |    2 
 drivers/gpu/drm/drm_panel.c                                       |    5 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                    |   46 ++
 drivers/gpu/drm/i915/gvt/opregion.c                               |    7 
 drivers/gpu/drm/mediatek/mtk_dpi.c                                |   23 -
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                             |   72 +--
 drivers/gpu/drm/nouveau/nouveau_bo.c                              |    3 
 drivers/gpu/drm/nouveau/nouveau_gem.c                             |    3 
 drivers/gpu/drm/sti/Makefile                                      |    2 
 drivers/gpu/drm/tiny/repaper.c                                    |    4 
 drivers/hid/usbhid/hid-pidff.c                                    |   60 +-
 drivers/hsi/clients/ssi_protocol.c                                |    1 
 drivers/i2c/busses/i2c-cros-ec-tunnel.c                           |    3 
 drivers/i3c/master.c                                              |    3 
 drivers/i3c/master/svc-i3c-master.c                               |    2 
 drivers/infiniband/core/cma.c                                     |    4 
 drivers/infiniband/core/umem_odp.c                                |    6 
 drivers/infiniband/hw/hns/hns_roce_main.c                         |    2 
 drivers/infiniband/hw/usnic/usnic_ib_main.c                       |   14 
 drivers/iommu/mtk_iommu.c                                         |   26 -
 drivers/md/dm-ebs-target.c                                        |    7 
 drivers/md/dm-integrity.c                                         |    3 
 drivers/md/dm-verity-target.c                                     |    8 
 drivers/md/md-bitmap.c                                            |    5 
 drivers/md/md.c                                                   |   50 +-
 drivers/md/raid10.c                                               |    1 
 drivers/media/common/siano/smsdvb-main.c                          |    2 
 drivers/media/i2c/adv748x/adv748x.h                               |    2 
 drivers/media/i2c/ccs/ccs-core.c                                  |    6 
 drivers/media/i2c/ov7251.c                                        |    4 
 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c |    3 
 drivers/media/platform/qcom/venus/hfi_parser.c                    |  100 +++-
 drivers/media/platform/qcom/venus/hfi_venus.c                     |   18 
 drivers/media/platform/st/stm32/dma2d/dma2d.c                     |    3 
 drivers/media/rc/streamzap.c                                      |   68 +--
 drivers/media/test-drivers/vim2m.c                                |    6 
 drivers/media/v4l2-core/v4l2-dv-timings.c                         |    4 
 drivers/mfd/ene-kb3930.c                                          |    2 
 drivers/misc/pci_endpoint_test.c                                  |    6 
 drivers/mmc/host/dw_mmc.c                                         |   94 ++++
 drivers/mmc/host/dw_mmc.h                                         |   27 +
 drivers/mtd/inftlcore.c                                           |    9 
 drivers/mtd/mtdpstore.c                                           |   12 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                          |    2 
 drivers/mtd/nand/raw/r852.c                                       |    3 
 drivers/net/dsa/b53/b53_common.c                                  |   10 
 drivers/net/dsa/mv88e6xxx/chip.c                                  |   30 +
 drivers/net/dsa/mv88e6xxx/devlink.c                               |    3 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c                |    1 
 drivers/net/ethernet/google/gve/gve_ethtool.c                     |    4 
 drivers/net/ethernet/intel/igc/igc_defines.h                      |    1 
 drivers/net/ethernet/intel/igc/igc_main.c                         |    1 
 drivers/net/ethernet/intel/igc/igc_ptp.c                          |   93 ++--
 drivers/net/ppp/ppp_synctty.c                                     |    5 
 drivers/net/wireless/atmel/at76c50x-usb.c                         |    2 
 drivers/net/wireless/mediatek/mt76/eeprom.c                       |    4 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                   |    1 
 drivers/net/wireless/ti/wl1251/tx.c                               |    4 
 drivers/ntb/ntb_transport.c                                       |    2 
 drivers/nvme/target/fc.c                                          |   14 
 drivers/nvme/target/fcloop.c                                      |    2 
 drivers/of/irq.c                                                  |   80 ++-
 drivers/pci/controller/pcie-brcmstb.c                             |   13 
 drivers/pci/controller/vmd.c                                      |   12 
 drivers/pci/pci.c                                                 |    4 
 drivers/pci/probe.c                                               |    5 
 drivers/perf/arm_pmu.c                                            |    8 
 drivers/pinctrl/qcom/pinctrl-msm.c                                |   12 
 drivers/platform/x86/asus-laptop.c                                |    9 
 drivers/ptp/ptp_ocp.c                                             |    1 
 drivers/pwm/pwm-fsl-ftm.c                                         |    6 
 drivers/pwm/pwm-mediatek.c                                        |    8 
 drivers/pwm/pwm-rcar.c                                            |   24 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                            |    9 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                            |   14 
 drivers/scsi/megaraid/megaraid_sas_base.c                         |    9 
 drivers/scsi/megaraid/megaraid_sas_fusion.c                       |    5 
 drivers/scsi/scsi_transport_iscsi.c                               |    7 
 drivers/scsi/st.c                                                 |    2 
 drivers/soc/samsung/exynos-chipid.c                               |    2 
 drivers/spi/spi-cadence-quadspi.c                                 |    6 
 drivers/thermal/rockchip_thermal.c                                |    1 
 drivers/ufs/host/ufs-exynos.c                                     |    6 
 drivers/vdpa/mlx5/core/mr.c                                       |    7 
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c                      |    6 
 drivers/xen/swiotlb-xen.c                                         |    2 
 drivers/xen/xenfs/xensyms.c                                       |    4 
 fs/Kconfig                                                        |    1 
 fs/btrfs/disk-io.c                                                |   12 
 fs/btrfs/inode.c                                                  |    6 
 fs/btrfs/super.c                                                  |    3 
 fs/btrfs/zoned.c                                                  |    6 
 fs/ext4/inode.c                                                   |   68 ++-
 fs/ext4/namei.c                                                   |    2 
 fs/ext4/super.c                                                   |   17 
 fs/ext4/xattr.c                                                   |   11 
 fs/f2fs/inode.c                                                   |    4 
 fs/f2fs/node.c                                                    |    9 
 fs/file.c                                                         |   26 -
 fs/fuse/virtio_fs.c                                               |    3 
 fs/hfs/bnode.c                                                    |    6 
 fs/hfsplus/bnode.c                                                |    6 
 fs/isofs/export.c                                                 |    2 
 fs/jbd2/journal.c                                                 |    1 
 fs/jfs/jfs_dmap.c                                                 |   10 
 fs/jfs/jfs_imap.c                                                 |    4 
 fs/namespace.c                                                    |    3 
 fs/nfs/Kconfig                                                    |    2 
 fs/nfs/internal.h                                                 |   22 -
 fs/nfs/nfs4session.h                                              |    4 
 fs/nfsd/Kconfig                                                   |    1 
 fs/nfsd/nfs4state.c                                               |    2 
 fs/nfsd/nfsfh.h                                                   |    7 
 fs/smb/client/cifs_dfs_ref.c                                      |   34 +
 fs/smb/client/cifsproto.h                                         |   23 +
 fs/smb/client/connect.c                                           |    2 
 fs/smb/client/dir.c                                               |   21 
 fs/smb/client/file.c                                              |   28 +
 fs/smb/client/fs_context.c                                        |    5 
 fs/smb/client/smb2misc.c                                          |    9 
 fs/smb/server/oplock.c                                            |    2 
 fs/smb/server/smb2pdu.c                                           |    6 
 fs/smb/server/transport_ipc.c                                     |    7 
 fs/smb/server/vfs.c                                               |    3 
 include/linux/backing-dev.h                                       |    1 
 include/linux/bpf.h                                               |    1 
 include/linux/nfs.h                                               |   13 
 include/linux/rtnetlink.h                                         |   22 +
 include/linux/tpm.h                                               |    1 
 include/net/sctp/structs.h                                        |    3 
 include/uapi/linux/kfd_ioctl.h                                    |    2 
 include/uapi/linux/landlock.h                                     |    2 
 include/xen/interface/xen-mca.h                                   |    2 
 io_uring/kbuf.c                                                   |    2 
 io_uring/net.c                                                    |    2 
 kernel/bpf/core.c                                                 |   19 
 kernel/bpf/syscall.c                                              |   17 
 kernel/locking/lockdep.c                                          |    3 
 kernel/sched/cpufreq_schedutil.c                                  |   18 
 kernel/trace/ftrace.c                                             |    1 
 kernel/trace/trace_events.c                                       |    4 
 kernel/trace/trace_events_filter.c                                |    4 
 lib/sg_split.c                                                    |    2 
 lib/string.c                                                      |   13 
 mm/filemap.c                                                      |    1 
 mm/gup.c                                                          |    6 
 mm/memory-failure.c                                               |   11 
 mm/memory.c                                                       |    4 
 mm/rmap.c                                                         |    2 
 mm/vmscan.c                                                       |    2 
 net/8021q/vlan_dev.c                                              |   31 -
 net/bluetooth/hci_event.c                                         |    5 
 net/bluetooth/l2cap_core.c                                        |    3 
 net/bridge/br_vlan.c                                              |    4 
 net/core/filter.c                                                 |   80 ++-
 net/core/page_pool.c                                              |    8 
 net/dsa/tag_8021q.c                                               |    2 
 net/ethtool/netlink.c                                             |    8 
 net/ipv6/route.c                                                  |    8 
 net/mac80211/iface.c                                              |    3 
 net/mac80211/mesh_hwmp.c                                          |   14 
 net/mctp/af_mctp.c                                                |    3 
 net/mptcp/sockopt.c                                               |   28 +
 net/mptcp/subflow.c                                               |   19 
 net/netfilter/nft_set_pipapo_avx2.c                               |    3 
 net/openvswitch/flow_netlink.c                                    |    3 
 net/sched/cls_api.c                                               |   74 ++-
 net/sched/sch_codel.c                                             |    5 
 net/sched/sch_fq_codel.c                                          |    6 
 net/sched/sch_sfq.c                                               |   66 ++-
 net/sctp/socket.c                                                 |   22 -
 net/sctp/transport.c                                              |    2 
 net/tipc/link.c                                                   |    1 
 net/tls/tls_main.c                                                |    6 
 scripts/sign-file.c                                               |  132 +++---
 scripts/ssl-common.h                                              |   32 +
 security/landlock/errata.h                                        |   87 +++
 security/landlock/setup.c                                         |   30 +
 security/landlock/setup.h                                         |    3 
 security/landlock/syscalls.c                                      |   22 -
 sound/pci/hda/hda_intel.c                                         |   44 +-
 sound/pci/hda/patch_realtek.c                                     |    1 
 sound/soc/amd/yc/acp6x-mach.c                                     |    7 
 sound/soc/codecs/lpass-wsa-macro.c                                |  117 +++--
 sound/soc/fsl/fsl_audmix.c                                        |   16 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                  |    9 
 sound/soc/qcom/qdsp6/q6asm-dai.c                                  |   19 
 sound/usb/midi.c                                                  |   80 +++
 tools/power/cpupower/bench/parse.c                                |    4 
 tools/testing/ktest/ktest.pl                                      |    8 
 tools/testing/radix-tree/linux.c                                  |    4 
 tools/testing/selftests/futex/functional/futex_wait_wouldblock.c  |    2 
 tools/testing/selftests/landlock/base_test.c                      |   46 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.c                 |    7 
 279 files changed, 2897 insertions(+), 1409 deletions(-)

Abdun Nihaal (3):
      wifi: at76c50x: fix use after free access in at76_disconnect
      wifi: wl1251: fix memory leak in wl1251_tx_work
      cxgb4: fix memory leak in cxgb4_init_ethtool_filters() error path

Abhinav Kumar (1):
      drm: allow encoder mode_set even when connectors change for crtc

Akhil P Oommen (1):
      drm/msm/a6xx: Fix stale rpmh votes from GPU

Alex Williamson (2):
      Revert "PCI: Avoid reset when disabled via sysfs"
      mm: Fix is_zero_page() usage in try_grab_page()

Alexandra Diupina (1):
      cifs: avoid NULL pointer dereference in dbg call

Alexandre Torgue (1):
      clocksource/drivers/stm32-lptimer: Use wakeup capable instead of init wakeup

Alexey Klimov (1):
      ASoC: qdsp6: q6asm-dai: fix q6asm_dai_compr_set_params error path

Andreas Gruenbacher (1):
      writeback: fix false warning in inode_to_wb()

Andrew Wyatt (5):
      drm: panel-orientation-quirks: Add support for AYANEO 2S
      drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
      drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
      drm: panel-orientation-quirks: Add new quirk for GPD Win 2
      drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)

Andrii Nakryiko (1):
      bpf: avoid holding freeze_mutex during mmap operation

AngeloGioacchino Del Regno (2):
      drm/mediatek: mtk_dpi: Move the input_2p_en bit to platform data
      drm/mediatek: mtk_dpi: Explicitly manage TVD clock in power on/off

Ard Biesheuvel (1):
      x86/pvh: Call C code via the kernel virtual mapping

Arnaud Lecomte (1):
      net: ppp: Add bound checking for skb data on ppp_sync_txmung

Arnd Bergmann (1):
      media: mediatek: vcodec: mark vdec_vp9_slice_map_counts_eob_coef noinline

Arseniy Krasnov (2):
      Bluetooth: hci_uart: fix race during initialization
      Bluetooth: hci_uart: Fix another race during initialization

Artem Sadovnikov (1):
      ext4: fix off-by-one error in do_split

Ayush Jain (1):
      ktest: Fix Test Failures Due to Missing LOG_FILE Directories

Baoquan He (1):
      mm/gup: fix wrongly calculated returned value in fault_in_safe_writeable()

Bhupesh (1):
      ext4: ignore xattrs past end

Björn Töpel (1):
      riscv: Properly export reserved regions in /proc/iomem

Boqun Feng (1):
      locking/lockdep: Decrease nr_unused_locks if lock unused in zap_class()

Boris Burkov (1):
      btrfs: fix qgroup reserve leaks in cow_file_range

Bryan O'Donoghue (2):
      clk: qcom: gdsc: Release pm subdomains in reverse add order
      clk: qcom: gdsc: Capture pm_genpd_add_subdomain result code

Chandrakanth Patil (1):
      scsi: megaraid_sas: Block zero-length ATA VPD inquiry

Chao Yu (2):
      f2fs: don't retry IO for corrupted data scenario
      f2fs: fix to avoid out-of-bounds access in f2fs_truncate_inode_blocks()

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8173: Fix disp-pwm compatible string

ChenXiaoSong (1):
      smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()

Chengchang Tang (1):
      RDMA/hns: Fix wrong maximum DMA segment size

Chenyuan Yang (2):
      soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()
      mfd: ene-kb3930: Fix a potential NULL pointer dereference

Chris Bainbridge (1):
      drm/nouveau: prime: fix ttm_bo_delayed_delete oops

Christian König (1):
      drm/amdgpu: grab an additional reference on the gang fence v2

Christopher S M Hall (4):
      igc: fix PTM cycle trigger logic
      igc: move ktime snapshot into PTM retry loop
      igc: handle the IGC_PTP_ENABLED flag correctly
      igc: cleanup PTP module if probe fails

Chunjie Zhu (1):
      smb3 client: fix open hardlink on deferred close file error

Cong Wang (1):
      codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()

Dan Carpenter (1):
      Bluetooth: btrtl: Prevent potential NULL dereference

Daniel Kral (1):
      ahci: add PCI ID for Marvell 88SE9215 SATA Controller

Daniel Wagner (1):
      nvmet-fcloop: swap list_add_tail arguments

Dapeng Mi (1):
      perf/x86/intel: Allow to update user space GPRs from PEBS records

David Hildenbrand (1):
      mm/rmap: reject hugetlb folios in folio_make_device_exclusive()

David Yat Sin (1):
      drm/amdkfd: clamp queue size to minimum

Denis Arefev (8):
      asus-laptop: Fix an uninitialized variable
      ksmbd: Prevent integer overflow in calculation of deadtime
      drm/amd/pm: Prevent division by zero
      drm/amd/pm/powerplay: Prevent division by zero
      drm/amd/pm/smu11: Prevent division by zero
      drm/amd/pm/powerplay/hwmgr/smu7_thermal: Prevent division by zero
      drm/amd/pm/swsmu/smu13/smu_v13_0: Prevent division by zero
      drm/amd/pm/powerplay/hwmgr/vega20_thermal: Prevent division by zero

Dmitry Baryshkov (1):
      Bluetooth: qca: simplify WCN399x NVM loading

Douglas Anderson (6):
      arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
      arm64: cputype: Add MIDR_CORTEX_A76AE
      arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list
      arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
      arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre BHB safe list
      arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists

Edward Adam Davis (3):
      jfs: Prevent copying of nlink with value 0 from disk inode
      jfs: add sanity check for agwidth in dbMount
      isofs: Prevent the use of too small fid

Edward Liaw (1):
      selftests/futex: futex_waitv wouldblock test should fail

Eric Biggers (1):
      nfs: add missing selections of CONFIG_CRC32

Fedor Pchelkin (1):
      ntb: use 64-bit arithmetic for the MSI doorbell mask

Filipe Manana (1):
      btrfs: fix non-empty delayed iputs list on unmount due to compressed write workers

Florian Westphal (1):
      nft_set_pipapo: fix incorrect avx2 match of 5th field octet

Frédéric Danis (1):
      Bluetooth: l2cap: Check encryption key size on incoming connection

Fuad Tabba (1):
      KVM: arm64: Calculate cptr_el2 traps on activating traps

Gabriele Paoloni (1):
      tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER

Gang Yan (1):
      mptcp: fix NULL pointer in can_accept_new_subflow

Gavrilov Ilia (1):
      wifi: mac80211: fix integer overflow in hwmp_route_info_get()

Geliang Tang (1):
      selftests: mptcp: close fd_in before returning in main_loop

Greg Kroah-Hartman (3):
      Revert "Xen/swiotlb: mark xen_swiotlb_fixup() __init"
      Revert "LoongArch: BPF: Fix off-by-one error in build_prologue()"
      Linux 6.1.135

Guixin Liu (1):
      gpio: tegra186: fix resource handling in ACPI probe path

Haisu Wang (1):
      btrfs: fix the length of reserved qgroup to free

Haoxiang Li (1):
      wifi: mt76: Add check for devm_kstrdup()

Henry Martin (1):
      ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()

Herbert Xu (1):
      crypto: caam/qi - Fix drv_ctx refcount bug

Hersen Wu (1):
      drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links

Icenowy Zheng (1):
      wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table

Ido Schimmel (1):
      ipv6: Align behavior across nexthops during path selection

Ilya Maximets (1):
      net: openvswitch: fix nested key length validation in the set() action

Jakub Kicinski (1):
      net: tls: explicitly disallow disconnect

Jamal Hadi Salim (1):
      rtnl: add helper to check if rtnl group has listeners

Jan Beulich (1):
      xenfs/xensyms: respect hypervisor's "next" indication

Jan Kara (1):
      jbd2: remove wrong sb->s_sequence check

Jan Stancek (3):
      sign-file,extract-cert: move common SSL helper functions to a header
      sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
      sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3

Jani Nikula (1):
      drm/i915/gvt: fix unterminated-string-initialization warning

Jann Horn (1):
      ext4: don't treat fhandle lookup of ea_inode as FS corruption

Jason Xing (1):
      page_pool: avoid infinite loop to schedule delayed worker

Jeff Hugo (1):
      bus: mhi: host: Fix race between unprepare and queue_buf

Jeff Layton (1):
      nfs: move nfs_fhandle_hash to common include file

Jens Axboe (1):
      io_uring/kbuf: reject zero sized provided buffers

Jiasheng Jiang (3):
      media: platform: stm32: Add check for clk_enable()
      mtd: Add check for devm_kcalloc()
      mtd: Replace kcalloc() with devm_kcalloc()

Johannes Berg (1):
      Revert "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Johannes Kimmel (1):
      btrfs: correctly escape subvol in btrfs_show_options()

Johannes Thumshirn (2):
      btrfs: zoned: fix zone activation with missing devices
      btrfs: zoned: fix zone finishing with missing devices

Jonas Gorski (2):
      net: b53: enable BPDU reception for management port
      net: bridge: switchdev: do not notify new brentries as changed

Jonathan McDowell (2):
      tpm, tpm_tis: Workaround failed command reception on Infineon devices
      tpm, tpm_tis: Fix timeout handling when waiting for TPM status

Josh Poimboeuf (1):
      pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()

Joshua Washington (1):
      gve: handle overflow when reporting TX consumed descriptors

Kai Mäkisara (1):
      scsi: st: Fix array overflow in st_setup()

Kaixin Wang (1):
      HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition

Kamal Dasu (1):
      mtd: rawnand: brcmnand: fix PM resume warning

Kan Liang (3):
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on ICX
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on SPR

Karina Yankevich (1):
      media: v4l2-dv-timings: prevent possible overflow in v4l2_detect_gtf()

Kaustabh Chakraborty (1):
      mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves

Kees Cook (1):
      xen/mcelog: Add __nonstring annotations for unterminated strings

Kirill A. Shutemov (1):
      mm: fix apply_to_existing_page_range()

Krzysztof Kozlowski (1):
      gpio: zynq: Fix wakeup source leaks on device unbind

Kunihiko Hayashi (3):
      misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
      misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
      misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type

Leonid Arapov (1):
      fbdev: omapfb: Add 'plane' value check

Li Lingfeng (1):
      nfsd: decrease sc_count directly if fail to queue dl_recall

Li Nan (1):
      blk-iocost: do not WARN if iocg was already offlined

Louis-Alexis Eyraud (1):
      iommu/mediatek: Fix NULL pointer deference in mtk_iommu_device_group

Luca Ceresoli (1):
      drm/bridge: panel: forbid initializing a panel with unknown connector type

Lucas De Marchi (1):
      drivers: base: devres: Allow to release group on device release

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address

Ma Ke (1):
      PCI: Fix reference leak in pci_alloc_child_bus()

Maksim Davydov (1):
      x86/split_lock: Fix the delayed detection logic

Manjunatha Venkatesh (1):
      i3c: Add NULL pointer check in i3c_master_queue_ibi()

Marek Behún (1):
      net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320 family

Mario Limonciello (1):
      drm/amd: Handle being compiled without SI or CIK support better

Mark Brown (4):
      KVM: arm64: Discard any SVE state when entering KVM guests
      arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE
      arm64/fpsimd: Have KVM explicitly say which FP registers to save
      arm64/fpsimd: Stop using TIF_SVE to manage register saving in KVM

Mark Rutland (8):
      perf: arm_pmu: Don't disable counter in armpmu_add()
      KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
      KVM: arm64: Remove host FPSIMD saving for non-protected KVM
      KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
      KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
      KVM: arm64: Refactor exit handlers
      KVM: arm64: Mark some header functions as inline
      KVM: arm64: Eagerly switch ZCR_EL{1,2}

Mateusz Guzik (1):
      fs: consistently deref the files table with rcu_dereference_raw()

Mathieu Desnoyers (1):
      mm: add missing release barrier on PGDAT_RECLAIM_LOCKED unlock

Matt Johnston (1):
      net: mctp: Set SOCK_RCU_FREE

Matthew Auld (1):
      drm/amdgpu/dma_buf: fix page_link check

Matthew Majewski (1):
      media: vim2m: print device name after registering device

Matthew Wilcox (Oracle) (1):
      test suite: use %zu to print size_t

Matthieu Baerts (NGI0) (3):
      mptcp: sockopt: fix getting IPV6_V6ONLY
      mptcp: only inc MPJoinAckHMacFailure for HMAC failures
      mptcp: sockopt: fix getting freebind & transparent

Max Grobecker (1):
      x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual machine

Maxim Mikityanskiy (2):
      ALSA: hda: intel: Fix Optimus when GPU has no sound
      ALSA: hda: intel: Add Lenovo IdeaPad Z570 to probe denylist

Maxime Chevallier (1):
      net: ethtool: Don't call .cleanup_data when prepare_data fails

Miaoqian Lin (1):
      scsi: iscsi: Fix missing scsi_host_put() in error path

Mickaël Salaün (1):
      landlock: Add the errata interface

Mikulas Patocka (3):
      dm-ebs: fix prefetch-vs-suspend race
      dm-integrity: set ti->error on memory allocation failure
      dm-verity: fix prefetch-vs-suspend race

Miquel Raynal (1):
      spi: cadence-qspi: Fix probe on AM62A LP SK

Murad Masimov (1):
      media: streamzap: prevent processing IR data on URB failure

Myrrh Periwinkle (1):
      x86/e820: Fix handling of subpage regions when calculating nosave ranges in e820__register_nosave_regions()

Namjae Jeon (1):
      ksmbd: fix the warning from __kernel_write_iter

Nathan Chancellor (3):
      ACPI: platform-profile: Fix CFI violation when accessing sysfs files
      riscv: Avoid fortify warning in syscall_get_arguments()
      kbuild: Add '-fno-builtin-wcslen'

Nathan Lynch (1):
      powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()

Nikita Zhandarovich (1):
      drm/repaper: fix integer overflows in repeat functions

Niklas Cassel (1):
      ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode

Niklas Söderlund (1):
      media: i2c: adv748x: Fix test pattern selection mask

Octavian Purdila (2):
      net_sched: sch_sfq: use a temporary work area for validating configuration
      net_sched: sch_sfq: move the limit validation

Ojaswin Mujoo (1):
      ext4: protect ext4_release_dquot against freezing

Paulo Alcantara (1):
      cifs: use origin fullpath for automounts

Pavel Begunkov (1):
      io_uring/net: fix accept multishot handling

Pedro Tammela (1):
      net/sched: cls_api: conditional notification of events

Peter Collingbourne (1):
      string: Add load_unaligned_zeropad() code path to sized_strscpy()

Peter Griffin (1):
      scsi: ufs: exynos: Ensure consistent phy reference counts

Philip Yang (2):
      drm/amdkfd: Fix mode1 reset crash issue
      drm/amdkfd: Fix pqm_destroy_queue race with GPU reset

Rafael J. Wysocki (2):
      cpufreq/sched: Fix the usage of CPUFREQ_NEED_UPDATE_LIMITS
      cpufreq: Reference count policy in cpufreq_update_limits()

Rand Deeb (2):
      fs/jfs: cast inactags to s64 to prevent potential overflow
      fs/jfs: Prevent integer overflow in AG size calculation

Remi Pommarel (2):
      wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
      wifi: mac80211: Purge vif txq in ieee80211_do_stop()

Ricard Wanderlof (1):
      ALSA: usb-audio: Fix CME quirk for UF series keyboards

Ricardo Cañuelo Navarro (1):
      sctp: detect and prevent references to a freed transport in sendmsg

Rolf Eike Beer (1):
      drm/sti: remove duplicate object names

Roman Smirnov (1):
      cifs: fix integer overflow in match_server()

Ryan Roberts (1):
      sparc/mm: disable preemption in lazy mmu mode

Ryo Takakura (1):
      PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type

Sagi Maimon (1):
      ptp: ocp: fix start time alignment in ptp_ocp_signal_set

Sakari Ailus (4):
      media: i2c: ccs: Set the device's runtime PM status correctly in remove
      media: i2c: ccs: Set the device's runtime PM status correctly in probe
      media: i2c: ov7251: Set enable GPIO low in probe
      media: i2c: ov7251: Introduce 1 ms delay between regulators and en GPIO

Sean Christopherson (1):
      KVM: x86: Acquire SRCU in KVM_GET_MP_STATE to protect guest memory accesses

Sean Heelan (1):
      ksmbd: Fix dangling pointer in krb_authenticate

Sharath Srinivasan (1):
      RDMA/cma: Fix workqueue crash in cma_netevent_work_handler

Shay Drory (1):
      RDMA/core: Silence oversized kvmalloc() warning

Shengjiu Wang (1):
      ASoC: fsl_audmix: register card device depends on 'dais' property

Shuai Xue (1):
      mm/hwpoison: do not send SIGBUS to processes with recovered clean pages

Si-Wei Liu (1):
      vdpa/mlx5: Fix oversized null mkey longer than 32bit

Srinivas Kandagatla (4):
      ASoC: qdsp6: q6apm-dai: set 10 ms period and buffer alignment.
      ASoC: qdsp6: q6apm-dai: fix capture pipeline overruns.
      ASoC: codecs:lpass-wsa-macro: Fix vi feedback rate
      ASoC: codecs:lpass-wsa-macro: Fix logic of enabling vi channels

Stanimir Varbanov (1):
      PCI: brcmstb: Fix missing of_node_put() in brcm_pcie_probe()

Stanislav Fomichev (1):
      net: vlan: don't propagate flags on open

Stanley Chu (1):
      i3c: master: svc: Use readsb helper for reading MDB

Stephan Gerhold (1):
      pinctrl: qcom: Clear latched interrupt status when changing IRQ type

Steve French (1):
      smb311 client: fix missing tcon check when mounting with linux/posix extensions

Steven Rostedt (1):
      tracing: Fix filter string testing

T Pratham (1):
      lib: scatterlist: fix sg_split_phys to preserve original scatterlist offsets

Takashi Iwai (1):
      ALSA: hda/realtek: Fix built-in mic on another ASUS VivoBook model

Taniya Das (1):
      clk: qcom: gdsc: Set retain_ff before moving to HW CTRL

Thadeu Lima de Souza Cascardo (1):
      i2c: cros-ec-tunnel: defer probe if parent EC is not present

Thomas Weißschuh (2):
      loop: properly send KOBJ_CHANGED uevent for disk device
      loop: LOOP_SET_FD: send uevents for partitions

Toke Høiland-Jørgensen (1):
      tc: Ensure we have enough buffer space when sending filter netlink notifications

Tom Lendacky (1):
      crypto: ccp - Fix check for the primary ASP device

Tomasz Pakuła (3):
      HID: pidff: Convert infinite length from Linux API to PID standard
      HID: pidff: Do not send effect envelope if it's empty
      HID: pidff: Fix null pointer dereference in pidff_find_fields

Trevor Woerner (1):
      thermal/drivers/rockchip: Add missing rk3328 mapping entry

Trond Myklebust (1):
      umount: Allow superblock owners to force umount

Tung Nguyen (1):
      tipc: fix memory leak in tipc_link_xmit

Uwe Kleine-König (2):
      pwm: rcar: Improve register calculation
      pwm: fsl-ftm: Handle clk_get_rate() returning 0

Vasiliy Kovalev (1):
      hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key

Victor Nogueira (1):
      rtnl: add helper to check if a notification is needed

Vikash Garodia (4):
      media: venus: hfi: add a check to handle OOB in sfr region
      media: venus: hfi: add check to handle incorrect queue size
      media: venus: hfi_parser: add check to avoid out of bound access
      media: venus: hfi_parser: refactor hfi packet parsing logic

Vishal Moola (Oracle) (1):
      mm: fix filemap_get_folios_contig returning batches of identical folios

Vladimir Oltean (3):
      net: dsa: mv88e6xxx: avoid unregistering devlink regions which were never registered
      net: dsa: mv88e6xxx: fix -ENOENT when deleting VLANs and MST is unsupported
      net: dsa: avoid refcount warnings when ds->ops->tag_8021q_vlan_del() fails

WangYuli (6):
      riscv: KGDB: Do not inline arch_kgdb_breakpoint()
      riscv: KGDB: Remove ".option norvc/.option rvc" for kgdb_compiled_break
      nvmet-fc: Remove unused functions
      MIPS: dec: Declare which_prom() as static
      MIPS: cevt-ds1287: Add missing ds1287.h include
      MIPS: ds1287: Match ds1287_set_base_clock() function types

Wentao Liang (4):
      ata: sata_sx4: Add error handling in pdc20621_i2c_read()
      drm/amdgpu: handle amdgpu_cgs_create_device() errors in amd_powerplay_create()
      mtd: inftlcore: Add error check for inftl_read_oob()
      mtd: rawnand: Add status chack in r852_ready()

Will Deacon (1):
      KVM: arm64: Tear down vGIC on failed vCPU creation

Willem de Bruijn (1):
      bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags

Xiangsheng Hou (1):
      virtiofs: add filesystem context source name check

Xingui Yang (1):
      scsi: hisi_sas: Enable force phy when SATA disk directly connected

Xu Kuohai (1):
      bpf: Prevent tail call between progs attached to different hooks

Yu Kuai (4):
      md/raid10: fix missing discard IO accounting
      blk-cgroup: support to track if policy is online
      md: factor out a helper from mddev_put()
      md: fix mddev uaf while iterating all_mddevs list

Yuan Can (1):
      media: siano: Fix error handling in smsdvb_module_init()

Yue Haibing (1):
      RDMA/usnic: Fix passing zero to PTR_ERR in usnic_ib_pci_probe()

Yuli Wang (1):
      LoongArch: Eliminate superfluous get_numa_distances_cnt()

Zheng Qixing (1):
      md/md-bitmap: fix stats collection for external bitmaps

Zhenhua Huang (1):
      arm64: mm: Correct the update of max_pfn

Zhikai Zhai (1):
      drm/amd/display: Update Cursor request mode to the beginning prefetch always

Zhongqiu Han (2):
      pm: cpupower: bench: Prevent NULL dereference on malloc failure
      jfs: Fix uninit-value access of imap allocated in the diMount() function

Zijun Hu (5):
      of/irq: Fix device node refcount leakage in API of_irq_parse_one()
      of/irq: Fix device node refcount leakage in API of_irq_parse_raw()
      of/irq: Fix device node refcount leakages in of_irq_count()
      of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()
      of/irq: Fix device node refcount leakages in of_irq_init()

keenplify (1):
      ASoC: amd: Add DMI quirk for ACP6X mic support

zhoumin (1):
      ftrace: Add cond_resched() to ftrace_graph_set_hash()


