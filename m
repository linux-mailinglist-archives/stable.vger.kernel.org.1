Return-Path: <stable+bounces-196666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF7C7FB59
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A373A1393
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7502F6187;
	Mon, 24 Nov 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PADBjAk/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA12F7AB3;
	Mon, 24 Nov 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977681; cv=none; b=SQHkHQ8corvGg1h84cb5GnoMjLqSOcvW6iAGwSGKYzWBLdN4IfhMpb/uyk6fsxfylmyJQpvYGrBTeqpN2JjGix+ShWMa56guBy40w7HPTiUJZGX6vQKBdB+nh+hZoRVfe13e0PUTHlzl0s4497CsGe/gnyLBXZ2Otc7vzwQxcFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977681; c=relaxed/simple;
	bh=TZnklwcfF69i1OHpBnwjD8NlrHyipiy974UdNnSPPK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iXjqgiveD+WwPAno43UtrOnymoldMHX3SUiJG2M8kFkkiQFGWT2HUpybd4bsadNnjvMDDpRkXSCsnG09oOJYfwmpNXRY8D+JJOD49UmaKNDxh3veO4PSlHHu4WQfKA/iCQd0jpbqcR3S848VJPInmFgwSob1ySHnS0AeLqkkkG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PADBjAk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF980C4CEF1;
	Mon, 24 Nov 2025 09:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763977681;
	bh=TZnklwcfF69i1OHpBnwjD8NlrHyipiy974UdNnSPPK4=;
	h=From:To:Cc:Subject:Date:From;
	b=PADBjAk/+ShTAhto+f/+W2ETfxf88NJPsPdKBs9MHa5yaTcfJerPBAUBe69WJLRrP
	 /W4agpKaBir06DnI22BPygTZg3gpHKyqSSaECKN9rmIA1JueblhfZ9vqNsMKiNIZL9
	 Ru5R8yp2j8nxBiYhd4qOWBd2+wwk8B+3swJ455fk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.9
Date: Mon, 24 Nov 2025 10:47:53 +0100
Message-ID: <2025112453-outfit-barista-8c68@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.9 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                              |    2 
 arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dts                |    4 
 arch/arm/boot/dts/nxp/imx/imx51-zii-rdu1.dts                          |    4 
 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts            |    2 
 arch/arm/crypto/Kconfig                                               |    2 
 arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi                        |    2 
 arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts             |   24 
 arch/arm64/boot/dts/rockchip/rk3566-bigtreetech-cb2.dtsi              |    6 
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts                     |    2 
 arch/arm64/boot/dts/rockchip/rk3576.dtsi                              |    2 
 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi                          |    2 
 arch/arm64/boot/dts/rockchip/rk3588j.dtsi                             |    2 
 arch/arm64/kernel/probes/kprobes.c                                    |    5 
 arch/arm64/kvm/sys_regs.c                                             |   59 -
 arch/loongarch/include/asm/hw_breakpoint.h                            |    4 
 arch/loongarch/include/asm/io.h                                       |    5 
 arch/loongarch/include/asm/pgtable.h                                  |   11 
 arch/loongarch/kernel/mem.c                                           |    7 
 arch/loongarch/kernel/numa.c                                          |   23 
 arch/loongarch/kernel/setup.c                                         |    5 
 arch/loongarch/kernel/traps.c                                         |    4 
 arch/loongarch/kvm/intc/eiointc.c                                     |    2 
 arch/loongarch/kvm/timer.c                                            |    2 
 arch/loongarch/kvm/vcpu.c                                             |    5 
 arch/loongarch/mm/init.c                                              |    2 
 arch/loongarch/mm/ioremap.c                                           |    2 
 arch/riscv/Makefile                                                   |    2 
 arch/riscv/kernel/cpu-hotplug.c                                       |    1 
 arch/riscv/kernel/setup.c                                             |    7 
 arch/x86/include/asm/kvm_host.h                                       |    3 
 arch/x86/include/uapi/asm/vmx.h                                       |    7 
 arch/x86/kernel/acpi/cppc.c                                           |    2 
 arch/x86/kernel/cpu/amd.c                                             |    7 
 arch/x86/kernel/cpu/microcode/amd.c                                   |    1 
 arch/x86/kvm/svm/nested.c                                             |   20 
 arch/x86/kvm/svm/svm.c                                                |   71 -
 arch/x86/kvm/vmx/common.h                                             |    2 
 arch/x86/kvm/vmx/nested.c                                             |   21 
 arch/x86/kvm/vmx/vmx.c                                                |   29 
 arch/x86/kvm/vmx/vmx.h                                                |    5 
 arch/x86/kvm/x86.c                                                    |   75 +
 drivers/acpi/cppc_acpi.c                                              |    6 
 drivers/acpi/numa/hmat.c                                              |   46 
 drivers/acpi/numa/srat.c                                              |    2 
 drivers/bluetooth/btusb.c                                             |   13 
 drivers/cpufreq/intel_pstate.c                                        |    9 
 drivers/crypto/hisilicon/qm.c                                         |    2 
 drivers/edac/altera_edac.c                                            |   22 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                            |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                           |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                               |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                               |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c                       |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                              |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                                 |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                 |   73 -
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                                |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                     |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c              |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c        |    2 
 drivers/gpu/drm/amd/display/dc/dm_services_types.h                    |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c             |    6 
 drivers/gpu/drm/amd/include/dm_pp_interface.h                         |    1 
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c                          |   67 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h                      |    2 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c                            |    4 
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c                        |    6 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                            |   70 -
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                      |   11 
 drivers/gpu/drm/clients/drm_client_setup.c                            |    4 
 drivers/gpu/drm/i915/display/intel_psr.c                              |    3 
 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.c                        |    4 
 drivers/gpu/drm/i915/i915_vma.c                                       |   16 
 drivers/gpu/drm/mediatek/mtk_crtc.c                                   |    7 
 drivers/gpu/drm/panthor/panthor_gem.c                                 |   18 
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c                          |   16 
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h                          |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                               |    5 
 drivers/gpu/drm/xe/regs/xe_gt_regs.h                                  |    1 
 drivers/gpu/drm/xe/xe_device.c                                        |   14 
 drivers/gpu/drm/xe/xe_guc_ct.c                                        |    3 
 drivers/gpu/drm/xe/xe_wa.c                                            |   11 
 drivers/hid/hid-ids.h                                                 |    4 
 drivers/hid/hid-logitech-hidpp.c                                      |   21 
 drivers/hid/hid-nintendo.c                                            |    2 
 drivers/hid/hid-ntrig.c                                               |    7 
 drivers/hid/hid-playstation.c                                         |    2 
 drivers/hid/hid-quirks.c                                              |    2 
 drivers/hid/hid-uclogic-params.c                                      |    4 
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c               |    6 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h               |    2 
 drivers/infiniband/hw/mlx5/cq.c                                       |   15 
 drivers/iommu/iommufd/io_pagetable.c                                  |   12 
 drivers/iommu/iommufd/ioas.c                                          |    4 
 drivers/irqchip/irq-riscv-intc.c                                      |    3 
 drivers/isdn/hardware/mISDN/hfcsusb.c                                 |   18 
 drivers/mmc/host/dw_mmc-rockchip.c                                    |    4 
 drivers/mmc/host/pxamci.c                                             |   56 -
 drivers/mmc/host/sdhci-of-dwcmshc.c                                   |    2 
 drivers/mtd/nand/onenand/onenand_samsung.c                            |    2 
 drivers/net/ethernet/freescale/fec_main.c                             |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h                          |   15 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                        |   79 +
 drivers/net/ethernet/mellanox/mlx5/core/cq.c                          |   24 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h                     |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c              |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c                   |   11 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                    |   33 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                     |   19 
 drivers/net/ethernet/mellanox/mlx5/core/eq.c                          |    8 
 drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c                   |   16 
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c                     |    8 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                        |   11 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c           |   15 
 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c        |   29 
 drivers/net/ethernet/mellanox/mlx5/core/wc.c                          |    4 
 drivers/net/ethernet/ti/am65-cpsw-qos.c                               |   51 
 drivers/net/phy/mdio_bus.c                                            |    5 
 drivers/net/phy/micrel.c                                              |  515 ++++++----
 drivers/net/virtio_net.c                                              |   16 
 drivers/net/wireless/ath/ath11k/wmi.c                                 |    3 
 drivers/net/wireless/intel/iwlwifi/mld/link.c                         |    7 
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c                     |   13 
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c                        |   12 
 drivers/pmdomain/arm/scmi_pm_domain.c                                 |   13 
 drivers/pmdomain/imx/gpc.c                                            |    2 
 drivers/pmdomain/samsung/exynos-pm-domains.c                          |   29 
 drivers/pwm/pwm-adp5585.c                                             |    4 
 drivers/regulator/fixed.c                                             |    1 
 drivers/spi/spi.c                                                     |   10 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                     |    6 
 fs/afs/cell.c                                                         |   78 +
 fs/afs/dynroot.c                                                      |    3 
 fs/afs/internal.h                                                     |   12 
 fs/afs/mntpt.c                                                        |    3 
 fs/afs/proc.c                                                         |    3 
 fs/afs/super.c                                                        |    2 
 fs/afs/vl_alias.c                                                     |    3 
 fs/binfmt_misc.c                                                      |    4 
 fs/btrfs/inode.c                                                      |    4 
 fs/btrfs/scrub.c                                                      |    2 
 fs/btrfs/tree-log.c                                                   |    2 
 fs/btrfs/zoned.c                                                      |   60 -
 fs/erofs/decompressor_zstd.c                                          |   11 
 fs/exfat/namei.c                                                      |    6 
 fs/file_attr.c                                                        |    4 
 fs/fuse/virtio_fs.c                                                   |    2 
 fs/hostfs/hostfs_kern.c                                               |   29 
 fs/namespace.c                                                        |   32 
 fs/nfs/client.c                                                       |    8 
 fs/nfs/dir.c                                                          |   23 
 fs/nfs/inode.c                                                        |   18 
 fs/nfs/nfs3client.c                                                   |   14 
 fs/nfs/nfs4client.c                                                   |   15 
 fs/nfs/nfs4proc.c                                                     |   22 
 fs/nfs/pnfs_nfs.c                                                     |   66 -
 fs/nfs/sysfs.c                                                        |    1 
 fs/nfs/write.c                                                        |    3 
 fs/nfsd/nfs4state.c                                                   |    3 
 fs/nfsd/nfs4xdr.c                                                     |    3 
 fs/nfsd/nfsd.h                                                        |    1 
 fs/nfsd/nfsfh.c                                                       |    6 
 fs/nilfs2/segment.c                                                   |    7 
 fs/proc/generic.c                                                     |   12 
 fs/smb/client/fs_context.c                                            |    2 
 fs/smb/client/smb2inode.c                                             |    2 
 fs/smb/client/transport.c                                             |    2 
 fs/smb/server/smb2pdu.c                                               |    2 
 fs/smb/server/transport_tcp.c                                         |    5 
 include/linux/compiler_types.h                                        |    5 
 include/linux/filter.h                                                |   20 
 include/linux/huge_mm.h                                               |   55 -
 include/linux/map_benchmark.h                                         |    1 
 include/linux/mlx5/cq.h                                               |    2 
 include/linux/mlx5/driver.h                                           |    3 
 include/linux/nfs_xdr.h                                               |    1 
 include/net/bluetooth/hci.h                                           |    5 
 include/uapi/linux/mount.h                                            |    2 
 io_uring/register.c                                                   |    7 
 io_uring/rsrc.c                                                       |   16 
 io_uring/rw.c                                                         |    3 
 kernel/bpf/trampoline.c                                               |    5 
 kernel/bpf/verifier.c                                                 |    6 
 kernel/crash_core.c                                                   |    2 
 kernel/futex/core.c                                                   |   12 
 kernel/gcov/gcc_4_7.c                                                 |    4 
 kernel/kexec_handover.c                                               |    8 
 kernel/power/swap.c                                                   |   17 
 kernel/sched/ext.c                                                    |    4 
 kernel/time/posix-timers.c                                            |   12 
 kernel/trace/ftrace.c                                                 |   20 
 lib/maple_tree.c                                                      |   30 
 mm/damon/stat.c                                                       |    9 
 mm/damon/sysfs.c                                                      |   10 
 mm/filemap.c                                                          |   20 
 mm/huge_memory.c                                                      |   38 
 mm/kmsan/core.c                                                       |    3 
 mm/kmsan/hooks.c                                                      |    6 
 mm/kmsan/shadow.c                                                     |    2 
 mm/ksm.c                                                              |  113 ++
 mm/memory.c                                                           |   20 
 mm/mm_init.c                                                          |    2 
 mm/mremap.c                                                           |    2 
 mm/secretmem.c                                                        |    2 
 mm/shmem.c                                                            |    9 
 mm/slub.c                                                             |    6 
 mm/swap_state.c                                                       |   13 
 mm/truncate.c                                                         |    6 
 net/bluetooth/6lowpan.c                                               |   97 +
 net/bluetooth/hci_conn.c                                              |   33 
 net/bluetooth/hci_event.c                                             |   56 -
 net/bluetooth/hci_sync.c                                              |    2 
 net/bluetooth/l2cap_core.c                                            |    1 
 net/bluetooth/mgmt.c                                                  |    1 
 net/core/netpoll.c                                                    |    7 
 net/dsa/tag_brcm.c                                                    |    6 
 net/handshake/tlshd.c                                                 |    1 
 net/hsr/hsr_device.c                                                  |    5 
 net/hsr/hsr_forward.c                                                 |   22 
 net/ipv4/route.c                                                      |    5 
 net/mac80211/iface.c                                                  |   14 
 net/mac80211/rx.c                                                     |   10 
 net/netfilter/nft_ct.c                                                |    5 
 net/sched/act_bpf.c                                                   |    6 
 net/sched/act_connmark.c                                              |   12 
 net/sched/act_ife.c                                                   |   12 
 net/sched/cls_bpf.c                                                   |    6 
 net/sched/sch_generic.c                                               |   17 
 net/sctp/transport.c                                                  |   13 
 net/smc/smc_clc.c                                                     |    1 
 net/strparser/strparser.c                                             |    2 
 net/tipc/net.c                                                        |    2 
 net/unix/garbage.c                                                    |   14 
 rust/Makefile                                                         |    2 
 scripts/decode_stacktrace.sh                                          |   43 
 scripts/gendwarfksyms/gendwarfksyms.c                                 |    3 
 scripts/gendwarfksyms/gendwarfksyms.h                                 |    2 
 scripts/gendwarfksyms/symbols.c                                       |    4 
 sound/hda/codecs/hdmi/nvhdmi-mcp.c                                    |    4 
 sound/hda/codecs/realtek/alc269.c                                     |    1 
 sound/soc/codecs/cs4271.c                                             |   10 
 sound/soc/codecs/da7213.c                                             |   65 -
 sound/soc/codecs/da7213.h                                             |    1 
 sound/soc/codecs/lpass-va-macro.c                                     |    2 
 sound/soc/codecs/max98090.c                                           |    6 
 sound/soc/codecs/nau8821.c                                            |   22 
 sound/soc/codecs/nau8821.h                                            |    2 
 sound/soc/codecs/tas2781-i2c.c                                        |    9 
 sound/soc/renesas/rcar/ssiu.c                                         |    3 
 sound/soc/sdw_utils/soc_sdw_utils.c                                   |   20 
 sound/usb/endpoint.c                                                  |    5 
 sound/usb/mixer.c                                                     |    2 
 tools/build/feature/Makefile                                          |    4 
 tools/perf/Makefile.config                                            |    5 
 tools/perf/builtin-lock.c                                             |    2 
 tools/perf/tests/shell/lock_contention.sh                             |   21 
 tools/perf/util/header.c                                              |   10 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc |    4 
 tools/testing/selftests/iommu/iommufd.c                               |    2 
 tools/testing/selftests/iommu/iommufd_utils.h                         |    4 
 tools/testing/selftests/net/forwarding/local_termination.sh           |    2 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                     |   18 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                    |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                       |   90 -
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                        |   21 
 tools/testing/selftests/user_events/perf_test.c                       |    2 
 virt/kvm/guest_memfd.c                                                |   45 
 277 files changed, 2494 insertions(+), 1381 deletions(-)

Abdun Nihaal (3):
      HID: playstation: Fix memory leak in dualshock4_get_calibration_data()
      HID: uclogic: Fix potential memory leak in error path
      isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Abhishek Tamboli (1):
      HID: intel-thc-hid: intel-quickspi: Add ARL PCI Device Id's

Akiva Goldberger (1):
      mlx5: Fix default values in create CQ

Aksh Garg (2):
      net: ethernet: ti: am65-cpsw-qos: fix IET verify/response timeout
      net: ethernet: ti: am65-cpsw-qos: fix IET verify retry mechanism

Al Viro (1):
      simplify nfs_atomic_open_v23()

Aleksei Nikiforov (1):
      mm/kmsan: fix kmsan kmalloc hook when no stack depots are allocated yet

Alex Deucher (1):
      drm/amdgpu: set default gfx reset masks for gfx6-8

Alexander Sverdlin (1):
      selftests: net: local_termination: Wait for interfaces to come up

Alok Tiwari (1):
      virtio-fs: fix incorrect check for fsvq->kobj

Anand Moon (1):
      arm64: dts: rockchip: Set correct pinctrl for I2S1 8ch TX on odroid-m1

Andrei Vagin (1):
      fs/namespace: correctly handle errors returned by grab_requested_mnt_ns

Andrey Albershteyn (1):
      fs: return EOPNOTSUPP from file_setattr/file_getattr syscalls

Andrey Leonchikov (2):
      arm64: dts: rockchip: Fix PCIe power enable pin for BigTreeTech CB2 and Pi2
      arm64: dts: rockchip: Fix USB power enable pin for BTT CB2 and Pi2

Andrii Melnychenko (1):
      netfilter: nft_ct: add seqadj extension for natted connections

André Draszik (1):
      pmdomain: samsung: plug potential memleak during probe

Ankit Khushwaha (1):
      selftests/user_events: fix type cast for write_index packed member in perf_test

Arnaldo Carvalho de Melo (1):
      perf build: Don't fail fast path feature detection when binutils-devel is not available

Balasubramani Vivekanandan (1):
      drm/xe/guc: Synchronize Dead CT worker with unbind

Benjamin Berg (1):
      wifi: mac80211: skip rate verification for not captured PSDUs

Bibo Mao (3):
      LoongArch: KVM: Restore guest PMU if it is enabled
      LoongArch: KVM: Add delay until timer interrupt injected
      LoongArch: KVM: Fix max supported vCPUs set with EIOINTC

Boris Brezillon (1):
      drm/panthor: Flush shmem writes before mapping buffers CPU-uncached

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Add Zen5 model 0x44, stepping 0x1 minrev

Breno Leitao (1):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup

Buday Csaba (1):
      net: mdio: fix resource leak in mdiobus_register_device()

Caleb Sander Mateos (1):
      io_uring/rsrc: don't use blk_rq_nr_phys_segments() as number of bvecs

Carlos Llamas (1):
      scripts/decode_stacktrace.sh: fix build ID and PC source parsing

Carolina Jubran (1):
      net/mlx5e: Fix missing error assignment in mlx5e_xfrm_add_state()

Christian König (2):
      drm/amdgpu: remove two invalid BUG_ON()s
      drm/amdgpu: hide VRAM sysfs attributes on GPUs without VRAM

Chuang Wang (1):
      ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe

Chuck Lever (1):
      NFSD: Skip close replay processing if XDR encoding fails

Chukun Pan (1):
      arm64: dts: rockchip: drop reset from rk3576 i2c9 node

Claudiu Beznea (1):
      ASoC: da7213: Use component driver suspend/resume

Cosmin Ratiu (3):
      net/mlx5: Fix typo of MLX5_EQ_DOORBEL_OFFSET
      net/mlx5: Store the global doorbell in mlx5_priv
      net/mlx5e: Prepare for using different CQ doorbells

Cristian Ciocaltea (1):
      ASoC: nau8821: Avoid unnecessary blocking in IRQ handler

D. Wythe (1):
      net/smc: fix mismatch between CLC header and proposal

Dai Ngo (1):
      NFS: Fix LTP test failures when timestamps are delegated

Dan Carpenter (1):
      mtd: onenand: Pass correct pointer to IRQ handler

Danil Skrebenkov (1):
      RISC-V: clear hot-unplugged cores from all task mm_cpumasks to avoid rfence errors

Dario Binacchi (1):
      ARM: dts: imx6ull-engicam-microgea-rmm: fix report-rate-hz value

Dave Jiang (1):
      acpi/hmat: Fix lockdep warning for hmem_register_resource()

David Howells (1):
      afs: Fix dynamic lookup to fail on cell lookup failure

Dawn Gardner (1):
      ALSA: hda/realtek: Fix mute led for HP Omen 17-cb0xxx

Dev Jain (1):
      mm/mremap: honour writable bit in mremap pte batching

Dragan Simic (1):
      arm64: dts: rockchip: Make RK3588 GPU OPP table naming less generic

Eduard Zingerman (1):
      bpf: account for current allocated stack depth in widen_imprecise_scalars()

Edward Adam Davis (2):
      nilfs2: avoid having an active sc_timer before freeing sci
      cifs: client: fix memory leak in smb3_fs_context_parse_param

Eric Biggers (1):
      lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN

Eric Dumazet (3):
      sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
      net_sched: limit try_bulk_dequeue_skb() batches
      bpf: Add bpf_prog_run_data_pointers()

Eslam Khafagy (1):
      posix-timers: Plug potential memory leak in do_timer_create()

Felix Maurer (2):
      hsr: Fix supervision frame sending on HSRv0
      hsr: Follow standard for HSRv0 supervision frames

Feng Jiang (1):
      riscv: Build loader.bin exclusively for Canaan K210

Filipe Manana (1):
      btrfs: do not update last_log_commit when logging inode due to a new name

Frieder Schrempf (1):
      arm64: dts: imx8mp-kontron: Fix USB OTG role switching

Gal Pressman (3):
      net/mlx5e: Fix maxrate wraparound in threshold between units
      net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps
      net/mlx5e: Fix potentially misleading debug message

Gao Xiang (1):
      erofs: avoid infinite loop due to incomplete zstd-compressed data

Gautham R. Shenoy (4):
      ACPI: CPPC: Detect preferred core availability on online CPUs
      ACPI: CPPC: Check _CPC validity for only the online CPUs
      ACPI: CPPC: Perform fast check switch only for online CPUs
      ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs

Geert Uytterhoeven (1):
      ASoC: da7213: Convert to DEFINE_RUNTIME_DEV_PM_OPS()

Greg Kroah-Hartman (1):
      Linux 6.17.9

Haein Lee (1):
      ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd

Han Gao (1):
      riscv: acpi: avoid errors caused by probing DT devices when ACPI is used

Hans de Goede (1):
      spi: Try to get ACPI GPIO IRQ earlier

Hao Ge (1):
      codetag: debug: handle existing CODETAG_EMPTY in mark_objexts_empty for slabobj_ext

Haotian Zhang (4):
      regulator: fixed: fix GPIO descriptor leak on register failure
      ASoC: cs4271: Fix regulator leak on probe failure
      ASoC: codecs: va-macro: fix resource leak in probe error path
      ASoC: rsnd: fix OF node reference leak in rsnd_ssiu_probe()

Henrique Carvalho (1):
      smb: client: fix cifs_pick_channel when channel needs reconnect

Hongbo Li (1):
      hostfs: Fix only passing host root in boot stage with new mount

Horatiu Vultur (4):
      net: phy: micrel: Introduce lanphy_modify_page_reg
      net: phy: micrel: Replace hardcoded pages with defines
      net: phy: micrel: lan8814 fix reset of the QSGMII interface
      net: phy: micrel: Fix lan8814_config_init

Huacai Chen (4):
      LoongArch: Consolidate early_ioremap()/ioremap_prot()
      LoongArch: Use correct accessor to read FWPC/MWPC
      LoongArch: Consolidate max_pfn & max_low_pfn calculation
      LoongArch: Use physical addresses for CSR_MERRENTRY/CSR_TLBRENTRY

Ian Forbes (2):
      drm/vmwgfx: Validate command header size against SVGA_CMD_MAX_DATASIZE
      drm/vmwgfx: Restore Guest-Backed only cursor plane support

Ian Rogers (1):
      perf test shell lock_contention: Extra debug diagnostics

Isaac J. Manjarres (1):
      mm/mm_init: fix hash table order logging in alloc_large_system_hash()

Jaehun Gou (1):
      exfat: fix improper check of dentry.stream.valid_size

Jani Nikula (1):
      drm/i915/psr: fix pipe to vblank conversion

Janusz Krzysztofik (1):
      drm/i915: Avoid lock inversion when pinning to GGTT on CHV/BXT+VTD

Jason Gunthorpe (1):
      iommufd: Make vfio_compat's unmap succeed if the range is already empty

Jason-JH Lin (1):
      drm/mediatek: Add pm_runtime support for GCE power control

Jedrzej Jagielski (2):
      ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE mailbox operation
      ixgbe: handle IXGBE_VF_FEATURES_NEGOTIATE mbox cmd

Jens Axboe (1):
      io_uring/rw: ensure allocated iovec gets cleared for early failure

Jesse.Zhang (2):
      drm/amdgpu: Fix NULL pointer dereference in VRAM logic for APU devices
      drm/amdgpu: fix lock warning in amdgpu_userq_fence_driver_process

Jihed Chaibi (1):
      ARM: dts: imx51-zii-rdu1: Fix audmux node names

Johannes Berg (2):
      wifi: iwlwifi: mvm: fix beacon template/fixed rate
      wifi: mac80211: reject address change while connecting

Jonas Gorski (1):
      net: dsa: tag_brcm: do not mark link local traffic as offloaded

Jonathan Kim (2):
      drm/amdkfd: fix suspend/resume all calls in mes based eviction path
      drm/amdkfd: relax checks for over allocation of save area

Joshua Rogers (1):
      ksmbd: close accepted socket when per-IP limit rejects connection

Joshua Watt (2):
      NFS4: Fix state renewals missing after boot
      NFS4: Apply delay_retrans to async operations

Jouni Högander (1):
      drm/xe: Do clean shutdown also when using flr

João Paulo Gonçalves (1):
      arm64: dts: imx8-ss-img: Avoid gpio0_mipi_csi GPIOs being deferred

Kairui Song (2):
      mm/shmem: fix THP allocation and fallback loop
      mm, swap: fix potential UAF issue for VMA readahead

Kiryl Shutsemau (1):
      mm/memory: do not populate page table entries beyond i_size

Kuniyuki Iwashima (2):
      tipc: Fix use-after-free in tipc_mon_reinit_self().
      af_unix: Initialise scc_index in unix_add_edge().

Lance Yang (1):
      mm/secretmem: fix use-after-free race in fault handler

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections
      Bluetooth: hci_event: Fix not handling PA Sync Lost event

Luke Wang (1):
      pwm: adp5585: Correct mismatched pwm chip info

Marc Zyngier (1):
      KVM: arm64: Make all 32bit ID registers fully writable

Marek Szyprowski (1):
      pmdomain: samsung: Rework legacy splash-screen handover workaround

Mario Limonciello (2):
      drm/amd: Fix suspend failure with secure display TA
      x86/CPU/AMD: Add additional fixed RDSEED microcode revisions

Mario Limonciello (AMD) (3):
      drm/amd/display: Don't stretch non-native images by default in eDP
      PM: hibernate: Emit an error when image writing fails
      PM: hibernate: Use atomic64_t for compressed_size variable

Martin Kaiser (1):
      maple_tree: fix tracepoint string pointers

Masami Ichikawa (1):
      HID: hid-ntrig: Prevent memory leak in ntrig_report_version()

Matthieu Baerts (NGI0) (8):
      selftests: mptcp: connect: fix fallback note due to OoO
      selftests: mptcp: join: rm: set backup flag
      selftests: mptcp: join: endpoints: longer transfer
      selftests: mptcp: connect: trunc: read all recv data
      selftests: mptcp: join: userspace: longer transfer
      selftests: mptcp: join: properly kill background tasks
      scripts/decode_stacktrace.sh: symbol: avoid trailing whitespaces
      scripts/decode_stacktrace.sh: symbol: preserve alignment

Miaoqian Lin (3):
      ASoC: sdw_utils: fix device reference leak in is_sdca_endpoint_present()
      crypto: hisilicon/qm - Fix device reference leak in qm_get_qos_value
      pmdomain: imx: Fix reference count leak in imx_gpc_remove

Miri Korenblit (1):
      wifi: iwlwifi: mld: always take beacon ies in link grading

Naohiro Aota (2):
      btrfs: zoned: fix conventional zone capacity calculation
      btrfs: zoned: fix stripe width calculation

Nate Karstens (1):
      strparser: Fix signed/unsigned mismatch bug

NeilBrown (1):
      nfsd: fix refcount leak in nfsd_set_fh_dentry()

Nick Hu (1):
      irqchip/riscv-intc: Add missing free() callback in riscv_intc_domain_ops

Nicolas Escande (1):
      wifi: ath11k: zero init info->status in wmi_process_mgmt_tx_comp()

Nicolin Chen (1):
      iommufd/selftest: Fix ioctl return value in _test_cmd_trigger_vevents()

Niravkumar L Rabara (2):
      EDAC/altera: Handle OCRAM ECC enable after warm reset
      EDAC/altera: Use INTTEST register for Ethernet and USB SBE injection

Nitin Gote (2):
      drm/xe/xe3lpg: Extend Wa_15016589081 for xe3lpg
      drm/xe/xe3: Add WA_14024681466 for Xe3_LPG

Oleg Makarenko (1):
      HID: quirks: Add ALWAYS_POLL quirk for VRS R295 steering wheel

Olga Kornievskaia (2):
      nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
      NFSD: free copynotify stateid in nfs4_free_ol_stateid()

Pauli Virtanen (5):
      Bluetooth: MGMT: cancel mesh send timer when hdev removed
      Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
      Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
      Bluetooth: L2CAP: export l2cap_chan_hold for modules

Pavel Begunkov (1):
      io_uring: fix unexpected placement on same size resizing

Pedro Demarchi Gomes (1):
      ksm: use range-walk function to jump over holes in scan_get_next_rmap_item

Peter Oberparleiter (1):
      gcov: add support for GCC 15

Peter Zijlstra (2):
      futex: Optimize per-cpu reference counting
      compiler_types: Move unused static inline functions warning to W=2

Pratyush Yadav (1):
      kho: warn and exit when unpreserved page wasn't preserved

Qinxin Xia (1):
      dma-mapping: benchmark: Restore padding to ensure uABI remained consistent

Quanmin Yan (2):
      mm/damon/sysfs: change next_update_jiffies to a global variable
      mm/damon/stat: change last_refresh_jiffies to a global variable

Rafał Miłecki (1):
      ARM: dts: BCM53573: Fix address of Luxul XAP-1440's Ethernet PHY

Rakuram Eswaran (1):
      mmc: pxamci: Simplify pxamci_probe() error handling using devm APIs

Randy Dunlap (1):
      drm/client: fix MODULE_PARM_DESC string for "active"

Ranganath V N (2):
      net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
      net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

Ravi Bangoria (2):
      perf lock: Fix segfault due to missing kernel map
      perf test: Fix lock contention test

Sami Tolvanen (1):
      gendwarfksyms: Skip files with no exports

Scott Mayhew (1):
      NFS: check if suid/sgid was cleared after a write as needed

Sean Christopherson (3):
      KVM: guest_memfd: Remove bindings on memslot deletion when gmem is dying
      KVM: x86: Rename local "ecx" variables to "msr" and "pmc" as appropriate
      KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or TDCALL

Sharique Mohammad (1):
      ASoC: max98090/91: fixed max98091 ALSA widget powering up/down

Shawn Lin (2):
      mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT to 0x4
      mmc: dw_mmc-rockchip: Fix wrong internal phase calculate

Shenghao Ding (1):
      ASoC: tas2781: fix getting the wrong device number

Shuai Xue (1):
      acpi,srat: Fix incorrect device handle check for Generic Initiator

Shuhao Fu (1):
      smb: client: fix refcount leak in smb2_set_path_attr

Song Liu (1):
      ftrace: Fix BPF fexit with livepatch

Sourabh Jain (1):
      crash: fix crashkernel resource shrink

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Check IDA only before MSR_IA32_PERF_CTL writes

Steven Rostedt (1):
      selftests/tracing: Run sample events to clear page cache events

Stuart Hayhurst (1):
      HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL

Sudeep Holla (1):
      pmdomain: arm: scmi: Fix genpd leak on provider registration failure

Sukrit Bhatnagar (1):
      KVM: VMX: Fix check for valid GVA on an EPT violation

Sultan Alsawaf (1):
      drm/amd/amdgpu: Ensure isp_kernel_buffer_alloc() creates a new BO

Takashi Iwai (2):
      ALSA: hda/hdmi: Fix breakage at probing nvhdmi-mcp driver
      ALSA: usb-audio: Fix potential overflow of PCM transfer buffer

Tangudu Tilak Tirumalesh (1):
      drm/xe/xe3: Extend wa_14023061436

Tejas Upadhyay (1):
      drm/xe: Move declarations under conditional branch

Thomas Falcon (1):
      perf header: Write bpf_prog (infos|btfs)_cnt to data file

Tianyang Zhang (1):
      LoongArch: Let {pte,pmd}_modify() record the status of _PAGE_DIRTY

Timur Kristóf (5):
      drm/amd/display: Add pixel_clock to amd_pp_display_configuration
      drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)
      drm/amd/display: Disable fastboot on DCE 6 too
      drm/amd/pm: Disable MCLK switching on SI at high pixel clocks
      drm/amd: Disable ASPM on SI

Tristan Lobb (1):
      HID: quirks: avoid Cooler Master MM712 dongle wakeup bug

Trond Myklebust (6):
      pnfs: Fix TLS logic in _nfs4_pnfs_v3_ds_connect()
      pnfs: Fix TLS logic in _nfs4_pnfs_v4_ds_connect()
      pnfs: Set transport security policy to RPC_XPRTSEC_NONE unless using TLS
      NFS: Check the TLS certificate fields in nfs_match_client()
      NFSv2/v3: Fix error handling in nfs_atomic_open_v23()
      NFSv4: Fix an incorrect parameter when calling nfs4_call_sync()

Umesh Nerlige Ramappa (1):
      drm/i915: Fix conversion between clock ticks and nanoseconds

Vicki Pfau (1):
      HID: nintendo: Wait longer for initial probe

Vitaly Prosyak (1):
      drm/amdgpu: disable peer-to-peer access for DCC-enabled GC12 VRAM surfaces

Wei Fang (1):
      net: fec: correct rx_bytes statistic for the case SHIFT16 is set

Wei Yang (1):
      fs/proc: fix uaf in proc_readdir_de()

Xi Ruoyao (1):
      rust: Add -fno-isolate-erroneous-paths-dereference to bindgen_skip_c_flags

Xin Li (1):
      KVM: x86: Add support for RDMSR/WRMSRNS w/ immediate on Intel

Xuan Zhuo (1):
      virtio-net: fix incorrect flags recording in big mode

Yang Shi (1):
      arm64: kprobes: check the return value of set_memory_rox()

Yang Xiuwei (1):
      NFS: sysfs: fix leak when nfs_client kobject add fails

Yosry Ahmed (3):
      KVM: SVM: Mark VMCB_LBR dirty when MSR_IA32_DEBUGCTLMSR is updated
      KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()
      KVM: nSVM: Fix and simplify LBR virtualization handling with nested

ZhangGuoDong (2):
      smb/server: fix possible memory leak in smb2_read()
      smb/server: fix possible refcount leak in smb2_sess_setup()

Zi Yan (3):
      mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split to >0 order
      mm/huge_memory: fix folio split check for anon folios in swapcache
      mm/huge_memory: do not change split_huge_page*() target order silently

Zilin Guan (4):
      net/handshake: Fix memory leak in tls_handshake_accept()
      binfmt_misc: restore write access before closing files opened by open_exec()
      btrfs: scrub: put bio after errors in scrub_raid56_parity_stripe()
      btrfs: release root after error in data_reloc_print_warning_inode()

Zqiang (1):
      sched_ext: Fix unsafe locking in the scx_dump_state()


