Return-Path: <stable+bounces-196664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BBC7FB52
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 276094E2AB1
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33422F6187;
	Mon, 24 Nov 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xf96VpW+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBA264A74;
	Mon, 24 Nov 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977673; cv=none; b=AnSBHicskYJyK54GWJEIr0ruQNARpd1wxysXUBcz+kafZ4ZSKNZOm8KukFAsQ22UCtiQZOvIDD5i5VwokB1YFJ0uYOOYbs7dzgsc+0pKW/V2TdoYjWWxGfi3zTuF6ewdp0ZPgysph2PyHyWv4EzVcPTwk0MI4fZm/TeJRS2IlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977673; c=relaxed/simple;
	bh=XUExGmQmyxVgxYipBeju7kJd2EPLe6Bmo/o38bkprkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=srdEJ2S1JmrBkpmOJP3j3GAcaXU6yWBBaT224b4jo1QjWXdMpAH7dNoJLpVTNellbDDxoxatodwLHRY07LgkDNzIale/gWWWygF6LiZtQAlHyiiiaZnj2OkJaVRSg3kxhHWgZavqAgT58Yi0Ph4co4AXgLXEhwEPphOpgENS/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xf96VpW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C51C4CEF1;
	Mon, 24 Nov 2025 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763977673;
	bh=XUExGmQmyxVgxYipBeju7kJd2EPLe6Bmo/o38bkprkU=;
	h=From:To:Cc:Subject:Date:From;
	b=Xf96VpW+FJhBSScegiQ+NaO2wPQ6BkXItyufDeKMC6c80OPi9GS4Hzw2MJJVPfye2
	 Y0hJiERXku/TCCiqHeaHuaJqIuk1uuTeRJrzQisG0vU7PKumiLbGN+W+JCiAPzO0uo
	 Nd/ldFJOY3Ft/eW8RsYD2hs7aoQ8MslYtSA0Gmts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.59
Date: Mon, 24 Nov 2025 10:47:39 +0100
Message-ID: <2025112439-tassel-reproach-c610@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.59 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                              |    2 
 arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dts                |    4 
 arch/arm/boot/dts/nxp/imx/imx51-zii-rdu1.dts                          |    4 
 arch/arm/crypto/Kconfig                                               |    2 
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts                     |    2 
 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi                          |    2 
 arch/arm64/boot/dts/rockchip/rk3588j.dtsi                             |    2 
 arch/arm64/kernel/probes/kprobes.c                                    |    5 
 arch/loongarch/include/asm/hw_breakpoint.h                            |    4 
 arch/loongarch/include/asm/pgtable.h                                  |   11 
 arch/loongarch/kernel/traps.c                                         |    4 
 arch/loongarch/kvm/timer.c                                            |    2 
 arch/loongarch/kvm/vcpu.c                                             |    5 
 arch/riscv/Makefile                                                   |    2 
 arch/riscv/kernel/cpu-hotplug.c                                       |    1 
 arch/riscv/kernel/setup.c                                             |    7 
 arch/x86/kernel/acpi/cppc.c                                           |    2 
 arch/x86/kernel/cpu/microcode/amd.c                                   |    1 
 arch/x86/kvm/svm/svm.c                                                |    4 
 arch/x86/kvm/vmx/common.h                                             |   34 
 arch/x86/kvm/vmx/vmx.c                                                |   25 
 drivers/acpi/cppc_acpi.c                                              |    6 
 drivers/acpi/numa/hmat.c                                              |   46 
 drivers/acpi/numa/srat.c                                              |    2 
 drivers/bluetooth/btusb.c                                             |   13 
 drivers/crypto/hisilicon/qm.c                                         |    2 
 drivers/edac/altera_edac.c                                            |   22 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                           |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                               |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                               |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                              |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                                |   12 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                            |    5 
 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.c                        |    4 
 drivers/gpu/drm/i915/i915_vma.c                                       |   16 
 drivers/gpu/drm/mediatek/mtk_crtc.c                                   |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                               |    5 
 drivers/gpu/drm/xe/xe_device.c                                        |   14 
 drivers/gpu/drm/xe/xe_guc_ct.c                                        |    3 
 drivers/hid/hid-ids.h                                                 |    4 
 drivers/hid/hid-logitech-hidpp.c                                      |   21 
 drivers/hid/hid-nintendo.c                                            |    2 
 drivers/hid/hid-ntrig.c                                               |    7 
 drivers/hid/hid-playstation.c                                         |    2 
 drivers/hid/hid-quirks.c                                              |    2 
 drivers/hid/hid-uclogic-params.c                                      |    4 
 drivers/iommu/iommufd/io_pagetable.c                                  |   12 
 drivers/iommu/iommufd/ioas.c                                          |    4 
 drivers/irqchip/irq-riscv-intc.c                                      |    3 
 drivers/isdn/hardware/mISDN/hfcsusb.c                                 |   18 
 drivers/mmc/host/dw_mmc-rockchip.c                                    |    4 
 drivers/mmc/host/sdhci-of-dwcmshc.c                                   |    2 
 drivers/mtd/nand/onenand/onenand_samsung.c                            |    2 
 drivers/net/dsa/sja1105/sja1105_static_config.c                       |    6 
 drivers/net/ethernet/freescale/fec_main.c                             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                    |   33 
 drivers/net/ethernet/ti/am65-cpsw-qos.c                               |   51 
 drivers/net/phy/mdio_bus.c                                            |    5 
 drivers/net/phy/micrel.c                                              |  515 ++++++----
 drivers/net/virtio_net.c                                              |   16 
 drivers/net/wireless/ath/ath11k/pci.c                                 |    2 
 drivers/net/wireless/ath/ath11k/wmi.c                                 |    3 
 drivers/pmdomain/arm/scmi_pm_domain.c                                 |   13 
 drivers/pmdomain/imx/gpc.c                                            |    2 
 drivers/pmdomain/samsung/exynos-pm-domains.c                          |   11 
 drivers/regulator/fixed.c                                             |    1 
 drivers/spi/spi.c                                                     |   10 
 drivers/uio/uio_hv_generic.c                                          |   32 
 fs/btrfs/inode.c                                                      |    4 
 fs/btrfs/scrub.c                                                      |    2 
 fs/btrfs/tree-log.c                                                   |    2 
 fs/btrfs/zoned.c                                                      |    4 
 fs/erofs/decompressor_zstd.c                                          |   11 
 fs/exfat/namei.c                                                      |    6 
 fs/ext4/inode.c                                                       |    5 
 fs/ext4/xattr.c                                                       |   32 
 fs/ext4/xattr.h                                                       |   10 
 fs/f2fs/compress.c                                                    |    2 
 fs/fuse/virtio_fs.c                                                   |    2 
 fs/hostfs/hostfs_kern.c                                               |   29 
 fs/namespace.c                                                        |   32 
 fs/nfs/dir.c                                                          |   23 
 fs/nfs/inode.c                                                        |   18 
 fs/nfs/nfs3client.c                                                   |   14 
 fs/nfs/nfs4client.c                                                   |   15 
 fs/nfs/nfs4proc.c                                                     |   22 
 fs/nfs/pnfs_nfs.c                                                     |   34 
 fs/nfs/sysfs.c                                                        |    1 
 fs/nfs/write.c                                                        |    3 
 fs/nfsd/nfs4state.c                                                   |    3 
 fs/nfsd/nfs4xdr.c                                                     |    3 
 fs/nfsd/nfsd.h                                                        |    1 
 fs/nfsd/nfsfh.c                                                       |    6 
 fs/nilfs2/segment.c                                                   |    7 
 fs/proc/base.c                                                        |   12 
 fs/proc/generic.c                                                     |   12 
 fs/proc/task_mmu.c                                                    |    8 
 fs/proc/task_nommu.c                                                  |    4 
 fs/smb/client/fs_context.c                                            |    2 
 fs/smb/client/smb2inode.c                                             |    2 
 fs/smb/client/transport.c                                             |    2 
 fs/smb/server/smb2pdu.c                                               |    2 
 fs/smb/server/transport_tcp.c                                         |    5 
 include/linux/compiler_types.h                                        |    5 
 include/linux/filter.h                                                |   20 
 include/linux/huge_mm.h                                               |   21 
 include/linux/kvm_host.h                                              |    7 
 include/linux/map_benchmark.h                                         |    1 
 include/linux/netpoll.h                                               |    1 
 include/linux/nfs_xdr.h                                               |    1 
 include/net/bluetooth/mgmt.h                                          |    2 
 include/net/cfg80211.h                                                |   78 +
 include/net/tc_act/tc_connmark.h                                      |    1 
 include/uapi/linux/mount.h                                            |    2 
 io_uring/napi.c                                                       |   19 
 kernel/bpf/trampoline.c                                               |    5 
 kernel/bpf/verifier.c                                                 |    6 
 kernel/crash_core.c                                                   |    2 
 kernel/gcov/gcc_4_7.c                                                 |    4 
 kernel/power/swap.c                                                   |   17 
 kernel/sched/ext.c                                                    |    4 
 kernel/trace/ftrace.c                                                 |   20 
 mm/filemap.c                                                          |   20 
 mm/huge_memory.c                                                      |   32 
 mm/ksm.c                                                              |  113 ++
 mm/memory.c                                                           |   23 
 mm/mm_init.c                                                          |    2 
 mm/percpu.c                                                           |    8 
 mm/secretmem.c                                                        |    2 
 mm/shmem.c                                                            |    9 
 mm/slub.c                                                             |    6 
 mm/truncate.c                                                         |   27 
 net/bluetooth/6lowpan.c                                               |   97 +
 net/bluetooth/l2cap_core.c                                            |    1 
 net/bluetooth/mgmt.c                                                  |  260 +++--
 net/bluetooth/mgmt_util.c                                             |   46 
 net/bluetooth/mgmt_util.h                                             |    3 
 net/core/netpoll.c                                                    |   56 -
 net/handshake/tlshd.c                                                 |    1 
 net/hsr/hsr_device.c                                                  |    3 
 net/ipv4/route.c                                                      |    5 
 net/mac80211/chan.c                                                   |    2 
 net/mac80211/ieee80211_i.h                                            |    4 
 net/mac80211/iface.c                                                  |   14 
 net/mac80211/link.c                                                   |    4 
 net/mac80211/mlme.c                                                   |   18 
 net/mac80211/rx.c                                                     |   10 
 net/mptcp/protocol.c                                                  |   36 
 net/netfilter/nf_tables_api.c                                         |   66 -
 net/sched/act_bpf.c                                                   |    6 
 net/sched/act_connmark.c                                              |   30 
 net/sched/act_ife.c                                                   |   12 
 net/sched/cls_bpf.c                                                   |    6 
 net/sched/sch_generic.c                                               |   17 
 net/sctp/transport.c                                                  |   13 
 net/smc/smc_clc.c                                                     |    1 
 net/strparser/strparser.c                                             |    2 
 net/tipc/net.c                                                        |    2 
 net/unix/garbage.c                                                    |   14 
 net/wireless/core.c                                                   |   56 +
 net/wireless/trace.h                                                  |   21 
 rust/Makefile                                                         |   16 
 sound/pci/hda/hda_component.c                                         |    4 
 sound/soc/codecs/cs4271.c                                             |   10 
 sound/soc/codecs/lpass-va-macro.c                                     |    2 
 sound/soc/codecs/max98090.c                                           |    6 
 sound/soc/codecs/tas2781-i2c.c                                        |    9 
 sound/usb/endpoint.c                                                  |    5 
 sound/usb/mixer.c                                                     |    2 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc |    4 
 tools/testing/selftests/iommu/iommufd.c                               |    2 
 tools/testing/selftests/net/forwarding/local_termination.sh           |    2 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                     |   18 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                    |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                       |   90 -
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                        |   21 
 tools/testing/selftests/user_events/perf_test.c                       |    2 
 virt/kvm/guest_memfd.c                                                |   89 +
 182 files changed, 2089 insertions(+), 907 deletions(-)

Abdun Nihaal (3):
      HID: playstation: Fix memory leak in dualshock4_get_calibration_data()
      HID: uclogic: Fix potential memory leak in error path
      isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Aksh Garg (2):
      net: ethernet: ti: am65-cpsw-qos: fix IET verify/response timeout
      net: ethernet: ti: am65-cpsw-qos: fix IET verify retry mechanism

Al Viro (1):
      simplify nfs_atomic_open_v23()

Alexander Sverdlin (1):
      selftests: net: local_termination: Wait for interfaces to come up

Alok Tiwari (1):
      virtio-fs: fix incorrect check for fsvq->kobj

Anand Moon (1):
      arm64: dts: rockchip: Set correct pinctrl for I2S1 8ch TX on odroid-m1

Andrei Vagin (1):
      fs/namespace: correctly handle errors returned by grab_requested_mnt_ns

André Draszik (1):
      pmdomain: samsung: plug potential memleak during probe

Ankit Khushwaha (1):
      selftests/user_events: fix type cast for write_index packed member in perf_test

Balasubramani Vivekanandan (1):
      drm/xe/guc: Synchronize Dead CT worker with unbind

Benjamin Berg (3):
      wifi: mac80211: skip rate verification for not captured PSDUs
      wifi: cfg80211: add an hrtimer based delayed work item
      wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work

Bibo Mao (2):
      LoongArch: KVM: Restore guest PMU if it is enabled
      LoongArch: KVM: Add delay until timer interrupt injected

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Add Zen5 model 0x44, stepping 0x1 minrev

Breno Leitao (3):
      net: netpoll: Individualize the skb pool
      net: netpoll: flush skb pool during cleanup
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup

Buday Csaba (1):
      net: mdio: fix resource leak in mdiobus_register_device()

Chao Yu (1):
      f2fs: fix to avoid overflow while left shift operation

Christian König (2):
      drm/amdgpu: remove two invalid BUG_ON()s
      drm/amdgpu: hide VRAM sysfs attributes on GPUs without VRAM

Chuang Wang (1):
      ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe

Chuck Lever (1):
      NFSD: Skip close replay processing if XDR encoding fails

D. Wythe (1):
      net/smc: fix mismatch between CLC header and proposal

Dai Ngo (1):
      NFS: Fix LTP test failures when timestamps are delegated

Dan Carpenter (1):
      mtd: onenand: Pass correct pointer to IRQ handler

Danil Skrebenkov (1):
      RISC-V: clear hot-unplugged cores from all task mm_cpumasks to avoid rfence errors

Dave Jiang (1):
      acpi/hmat: Fix lockdep warning for hmem_register_resource()

Denis Arefev (1):
      ALSA: hda: Fix missing pointer check in hda_component_manager_init function

Dragan Simic (1):
      arm64: dts: rockchip: Make RK3588 GPU OPP table naming less generic

Eduard Zingerman (1):
      bpf: account for current allocated stack depth in widen_imprecise_scalars()

Edward Adam Davis (2):
      nilfs2: avoid having an active sc_timer before freeing sci
      cifs: client: fix memory leak in smb3_fs_context_parse_param

Eric Biggers (1):
      lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN

Eric Dumazet (4):
      sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
      net_sched: act_connmark: use RCU in tcf_connmark_dump()
      net_sched: limit try_bulk_dequeue_skb() batches
      bpf: Add bpf_prog_run_data_pointers()

Felix Maurer (1):
      hsr: Fix supervision frame sending on HSRv0

Feng Jiang (1):
      riscv: Build loader.bin exclusively for Canaan K210

Filipe Manana (1):
      btrfs: do not update last_log_commit when logging inode due to a new name

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

Greg Kroah-Hartman (1):
      Linux 6.12.59

Haein Lee (1):
      ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd

Han Gao (1):
      riscv: acpi: avoid errors caused by probing DT devices when ACPI is used

Hans de Goede (1):
      spi: Try to get ACPI GPIO IRQ earlier

Hao Ge (1):
      codetag: debug: handle existing CODETAG_EMPTY in mark_objexts_empty for slabobj_ext

Haotian Zhang (3):
      regulator: fixed: fix GPIO descriptor leak on register failure
      ASoC: cs4271: Fix regulator leak on probe failure
      ASoC: codecs: va-macro: fix resource leak in probe error path

Henrique Carvalho (1):
      smb: client: fix cifs_pick_channel when channel needs reconnect

Hongbo Li (1):
      hostfs: Fix only passing host root in boot stage with new mount

Horatiu Vultur (4):
      net: phy: micrel: Introduce lanphy_modify_page_reg
      net: phy: micrel: Replace hardcoded pages with defines
      net: phy: micrel: lan8814 fix reset of the QSGMII interface
      net: phy: micrel: Fix lan8814_config_init

Huacai Chen (2):
      LoongArch: Use correct accessor to read FWPC/MWPC
      LoongArch: Use physical addresses for CSR_MERRENTRY/CSR_TLBRENTRY

Ian Forbes (1):
      drm/vmwgfx: Validate command header size against SVGA_CMD_MAX_DATASIZE

Isaac J. Manjarres (1):
      mm/mm_init: fix hash table order logging in alloc_large_system_hash()

Jaehun Gou (1):
      exfat: fix improper check of dentry.stream.valid_size

Janusz Krzysztofik (1):
      drm/i915: Avoid lock inversion when pinning to GGTT on CHV/BXT+VTD

Jason Gunthorpe (1):
      iommufd: Make vfio_compat's unmap succeed if the range is already empty

Jason-JH Lin (1):
      drm/mediatek: Add pm_runtime support for GCE power control

Jesse.Zhang (1):
      drm/amdgpu: Fix NULL pointer dereference in VRAM logic for APU devices

Jialin Wang (1):
      proc: proc_maps_open allow proc_mem_open to return NULL

Jihed Chaibi (1):
      ARM: dts: imx51-zii-rdu1: Fix audmux node names

Johannes Berg (1):
      wifi: mac80211: reject address change while connecting

John Sperbeck (1):
      net: netpoll: ensure skb_pool list is always initialized

Jonathan Kim (1):
      drm/amdkfd: relax checks for over allocation of save area

Joshua Rogers (1):
      ksmbd: close accepted socket when per-IP limit rejects connection

Joshua Watt (2):
      NFS4: Fix state renewals missing after boot
      NFS4: Apply delay_retrans to async operations

Jouni Högander (1):
      drm/xe: Do clean shutdown also when using flr

Kairui Song (1):
      mm/shmem: fix THP allocation and fallback loop

Kiryl Shutsemau (2):
      mm/memory: do not populate page table entries beyond i_size
      mm/truncate: unmap large folio on split failure

Kuniyuki Iwashima (2):
      tipc: Fix use-after-free in tipc_mon_reinit_self().
      af_unix: Initialise scc_index in unix_add_edge().

Lance Yang (1):
      mm/secretmem: fix use-after-free race in fault handler

Long Li (1):
      uio_hv_generic: Set event for all channels on the device

Luiz Augusto von Dentz (1):
      Bluetooth: MGMT: Fix possible UAFs

Manivannan Sadhasivam (1):
      wifi: ath11k: Clear affinity hint before calling ath11k_pcic_free_irq() in error path

Mario Limonciello (1):
      drm/amd: Fix suspend failure with secure display TA

Mario Limonciello (AMD) (2):
      PM: hibernate: Emit an error when image writing fails
      PM: hibernate: Use atomic64_t for compressed_size variable

Masami Ichikawa (1):
      HID: hid-ntrig: Prevent memory leak in ntrig_report_version()

Matthieu Baerts (NGI0) (6):
      selftests: mptcp: connect: fix fallback note due to OoO
      selftests: mptcp: join: rm: set backup flag
      selftests: mptcp: join: endpoints: longer transfer
      selftests: mptcp: connect: trunc: read all recv data
      selftests: mptcp: join: userspace: longer transfer
      selftests: mptcp: join: properly kill background tasks

Miaoqian Lin (2):
      crypto: hisilicon/qm - Fix device reference leak in qm_get_qos_value
      pmdomain: imx: Fix reference count leak in imx_gpc_remove

Michal Hocko (1):
      mm, percpu: do not consider sleepable allocations atomic

Miguel Ojeda (2):
      rust: kbuild: treat `build_error` and `rustdoc` as kernel objects
      rust: kbuild: workaround `rustdoc` doctests modifier bug

Naohiro Aota (1):
      btrfs: zoned: fix conventional zone capacity calculation

Nate Karstens (1):
      strparser: Fix signed/unsigned mismatch bug

NeilBrown (1):
      nfsd: fix refcount leak in nfsd_set_fh_dentry()

Nick Hu (1):
      irqchip/riscv-intc: Add missing free() callback in riscv_intc_domain_ops

Nicolas Escande (1):
      wifi: ath11k: zero init info->status in wmi_process_mgmt_tx_comp()

Niravkumar L Rabara (2):
      EDAC/altera: Handle OCRAM ECC enable after warm reset
      EDAC/altera: Use INTTEST register for Ethernet and USB SBE injection

Oleg Makarenko (1):
      HID: quirks: Add ALWAYS_POLL quirk for VRS R295 steering wheel

Olga Kornievskaia (2):
      nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
      NFSD: free copynotify stateid in nfs4_free_ol_stateid()

Olivier Langlois (1):
      io_uring/napi: fix io_napi_entry RCU accesses

Pablo Neira Ayuso (2):
      Revert "netfilter: nf_tables: Reintroduce shortened deletion notifications"
      netfilter: nf_tables: reject duplicate device on updates

Paolo Abeni (1):
      mptcp: fix MSG_PEEK stream corruption

Pauli Virtanen (6):
      Bluetooth: MGMT: cancel mesh send timer when hdev removed
      Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
      Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
      Bluetooth: L2CAP: export l2cap_chan_hold for modules
      Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete

Pedro Demarchi Gomes (1):
      ksm: use range-walk function to jump over holes in scan_get_next_rmap_item

Penglei Jiang (1):
      proc: fix the issue of proc_mem_open returning NULL

Peter Oberparleiter (1):
      gcov: add support for GCC 15

Peter Zijlstra (1):
      compiler_types: Move unused static inline functions warning to W=2

Qinxin Xia (1):
      dma-mapping: benchmark: Restore padding to ensure uABI remained consistent

Rafał Miłecki (1):
      ARM: dts: BCM53573: Fix address of Luxul XAP-1440's Ethernet PHY

Ranganath V N (2):
      net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
      net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

Scott Mayhew (1):
      NFS: check if suid/sgid was cleared after a write as needed

Sean Christopherson (3):
      KVM: guest_memfd: Pass index, not gfn, to __kvm_gmem_get_pfn()
      KVM: guest_memfd: Remove bindings on memslot deletion when gmem is dying
      KVM: VMX: Split out guts of EPT violation to common/exposed function

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

Steven Rostedt (1):
      selftests/tracing: Run sample events to clear page cache events

Stuart Hayhurst (1):
      HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL

Sudeep Holla (1):
      pmdomain: arm: scmi: Fix genpd leak on provider registration failure

Sukrit Bhatnagar (1):
      KVM: VMX: Fix check for valid GVA on an EPT violation

Takashi Iwai (1):
      ALSA: usb-audio: Fix potential overflow of PCM transfer buffer

Tejas Upadhyay (1):
      drm/xe: Move declarations under conditional branch

Tianyang Zhang (1):
      LoongArch: Let {pte,pmd}_modify() record the status of _PAGE_DIRTY

Timur Kristóf (1):
      drm/amd/pm: Disable MCLK switching on SI at high pixel clocks

Tristan Lobb (1):
      HID: quirks: avoid Cooler Master MM712 dongle wakeup bug

Trond Myklebust (4):
      pnfs: Fix TLS logic in _nfs4_pnfs_v4_ds_connect()
      pnfs: Set transport security policy to RPC_XPRTSEC_NONE unless using TLS
      NFSv2/v3: Fix error handling in nfs_atomic_open_v23()
      NFSv4: Fix an incorrect parameter when calling nfs4_call_sync()

Umesh Nerlige Ramappa (1):
      drm/i915: Fix conversion between clock ticks and nanoseconds

Vicki Pfau (1):
      HID: nintendo: Wait longer for initial probe

Vitaly Prosyak (1):
      drm/amdgpu: disable peer-to-peer access for DCC-enabled GC12 VRAM surfaces

Vladimir Oltean (1):
      net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()

Wei Fang (1):
      net: fec: correct rx_bytes statistic for the case SHIFT16 is set

Wei Yang (1):
      fs/proc: fix uaf in proc_readdir_de()

Xi Ruoyao (1):
      rust: Add -fno-isolate-erroneous-paths-dereference to bindgen_skip_c_flags

Xuan Zhuo (1):
      virtio-net: fix incorrect flags recording in big mode

Yan Zhao (1):
      KVM: guest_memfd: Remove RCU-protected attribute from slot->gmem.file

Yang Shi (1):
      arm64: kprobes: check the return value of set_memory_rox()

Yang Xiuwei (1):
      NFS: sysfs: fix leak when nfs_client kobject add fails

Ye Bin (2):
      ext4: introduce ITAIL helper
      ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

Yosry Ahmed (1):
      KVM: SVM: Mark VMCB_LBR dirty when MSR_IA32_DEBUGCTLMSR is updated

ZhangGuoDong (2):
      smb/server: fix possible memory leak in smb2_read()
      smb/server: fix possible refcount leak in smb2_sess_setup()

Zi Yan (2):
      mm/huge_memory: do not change split_huge_page*() target order silently
      mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split to >0 order

Zilin Guan (3):
      net/handshake: Fix memory leak in tls_handshake_accept()
      btrfs: scrub: put bio after errors in scrub_raid56_parity_stripe()
      btrfs: release root after error in data_reloc_print_warning_inode()

Zqiang (1):
      sched_ext: Fix unsafe locking in the scx_dump_state()


