Return-Path: <stable+bounces-94619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4B9D60C7
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0CB1F217F6
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970EA1A0B08;
	Fri, 22 Nov 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2IURVfxB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5143713BC2F;
	Fri, 22 Nov 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286976; cv=none; b=mkAHhCVCjh31ZXtewCjy3zdjl50zRT2vb/NwQyVZqc2QiQ6LAhUw5HTlztHh6/vjZ7aglEOx0wkQjDHHC3Blb8VgT4+FxvgH4DR19++ZVPrHSP3pAeNwmFOL1MIy1HB/5yfus+xAwNQLWElmXEpLv1GPXTihAPHT+pmmCeFByA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286976; c=relaxed/simple;
	bh=f+HsKJSrgFbmji+pxKDfxvylrqcbBrXtDAolgs3z4zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XcYVFpOnC5HnNOwR53obcKL/c4Gr6ixhamFn2gU4pG2+n7Y5SLW5neuwDgTbKQUQk8bZSaLNdJbx2ggXI4re3c3EOFgVbTMTJKWM4rBRtN5YIy80sJSgGRvn6TEiup+gSyoGbalRKMZnSQx+0rYH1PuvMEptldAEjdo/ERaf/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2IURVfxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E527DC4CECF;
	Fri, 22 Nov 2024 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732286976;
	bh=f+HsKJSrgFbmji+pxKDfxvylrqcbBrXtDAolgs3z4zg=;
	h=From:To:Cc:Subject:Date:From;
	b=2IURVfxBVsbx1TR3G31f1Pqh/FQNIw3hYDnTdXoZcl9dTTN+7rwZTA56K4qRj3jXt
	 OauN2SyIflMYO7wbX6L7+mKhrfWn5WdOaoyBFp9Pm9bxAbF5MQa9S2NjxeYvsyOvId
	 kqjLuVRYlprC2WjIspF8SQ6iY8sB1/k60T8kdUKs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.11.10
Date: Fri, 22 Nov 2024 15:49:07 +0100
Message-ID: <2024112208-basics-attention-74f4@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.11.10 kernel.

All users of the 6.11 kernel series must upgrade.

The updated 6.11.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.11.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                     |    2 
 arch/arm/Kconfig                                                             |    3 
 arch/arm/kernel/head.S                                                       |    8 
 arch/arm/kernel/traps.c                                                      |    3 
 arch/arm/mm/mmu.c                                                            |   34 +-
 arch/arm64/Kconfig                                                           |    3 
 arch/arm64/include/asm/mman.h                                                |   10 
 arch/loongarch/Kconfig                                                       |    3 
 arch/loongarch/include/asm/kasan.h                                           |   13 -
 arch/loongarch/kernel/paravirt.c                                             |   15 +
 arch/loongarch/kernel/smp.c                                                  |    2 
 arch/loongarch/mm/kasan_init.c                                               |   46 +++
 arch/mips/Kconfig                                                            |    3 
 arch/parisc/include/asm/mman.h                                               |    5 
 arch/powerpc/Kconfig                                                         |    4 
 arch/riscv/Kconfig                                                           |    3 
 arch/s390/Kconfig                                                            |    3 
 arch/sh/Kconfig                                                              |    3 
 arch/x86/Kconfig                                                             |    3 
 arch/x86/Makefile                                                            |    5 
 arch/x86/entry/entry.S                                                       |   16 +
 arch/x86/include/asm/asm-prototypes.h                                        |    3 
 arch/x86/kernel/cpu/amd.c                                                    |   11 
 arch/x86/kernel/cpu/common.c                                                 |    2 
 arch/x86/kernel/vmlinux.lds.S                                                |    3 
 arch/x86/kvm/lapic.c                                                         |   29 +-
 arch/x86/kvm/vmx/nested.c                                                    |   30 ++
 arch/x86/kvm/vmx/vmx.c                                                       |    6 
 arch/x86/mm/ioremap.c                                                        |    6 
 drivers/bluetooth/btintel.c                                                  |    5 
 drivers/char/tpm/tpm2-sessions.c                                             |    7 
 drivers/firmware/arm_scmi/perf.c                                             |   44 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                                   |    3 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                                        |   13 -
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/nv.c                                              |   12 -
 drivers/gpu/drm/amd/amdgpu/soc15.c                                           |    4 
 drivers/gpu/drm/amd/amdgpu/soc21.c                                           |   12 -
 drivers/gpu/drm/amd/amdgpu/soc24.c                                           |    2 
 drivers/gpu/drm/amd/amdgpu/vi.c                                              |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                            |  117 +++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                            |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                       |   17 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h                 |    2 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                           |    6 
 drivers/gpu/drm/amd/display/dc/core/dc_state.c                               |    3 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c |   11 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                    |   49 +---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h                                |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                            |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c                              |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c                      |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c                             |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c                              |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                         |   20 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                         |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c                         |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c                         |    9 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                                       |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h                                       |    2 
 drivers/gpu/drm/bridge/tc358768.c                                            |   21 +
 drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c                                    |   50 ++--
 drivers/gpu/drm/i915/i915_drv.h                                              |    8 
 drivers/gpu/drm/i915/intel_device_info.c                                     |   24 +-
 drivers/gpu/drm/i915/intel_device_info.h                                     |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c                              |   59 ++---
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c                                     |   11 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c                               |    6 
 drivers/gpu/drm/panthor/panthor_mmu.c                                        |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                                  |    8 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                          |    2 
 drivers/gpu/drm/xe/xe_bo.c                                                   |   43 +--
 drivers/gpu/drm/xe/xe_bo_evict.c                                             |   20 +
 drivers/gpu/drm/xe/xe_oa.c                                                   |    2 
 drivers/infiniband/core/addr.c                                               |    2 
 drivers/mailbox/qcom-cpucp-mbox.c                                            |    2 
 drivers/media/dvb-core/dvbdev.c                                              |   15 -
 drivers/mmc/host/dw_mmc.c                                                    |    4 
 drivers/mmc/host/sunxi-mmc.c                                                 |    6 
 drivers/net/bonding/bond_main.c                                              |   16 +
 drivers/net/bonding/bond_options.c                                           |   82 ++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c                           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c                   |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                            |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c                        |    4 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                            |   15 +
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c                            |   32 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c                       |   25 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c                         |    4 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                                 |   13 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.h                                 |   12 +
 drivers/net/ethernet/vertexcom/mse102x.c                                     |    4 
 drivers/net/phy/phylink.c                                                    |   14 -
 drivers/perf/riscv_pmu_sbi.c                                                 |    4 
 drivers/pmdomain/arm/scmi_perf_domain.c                                      |    3 
 drivers/pmdomain/core.c                                                      |   49 ++--
 drivers/pmdomain/imx/imx93-blk-ctrl.c                                        |    4 
 drivers/vdpa/mlx5/core/mr.c                                                  |    8 
 drivers/vdpa/solidrun/snet_main.c                                            |   14 -
 drivers/vdpa/virtio_pci/vp_vdpa.c                                            |   10 
 fs/btrfs/delayed-ref.c                                                       |    2 
 fs/nilfs2/btnode.c                                                           |    2 
 fs/nilfs2/gcinode.c                                                          |    4 
 fs/nilfs2/mdt.c                                                              |    1 
 fs/nilfs2/page.c                                                             |    2 
 fs/ocfs2/resize.c                                                            |    2 
 fs/ocfs2/super.c                                                             |   13 -
 fs/proc/task_mmu.c                                                           |    4 
 include/drm/intel/i915_pciids.h                                              |   19 +
 include/linux/mman.h                                                         |    7 
 include/linux/pm_domain.h                                                    |    6 
 include/linux/sched/task_stack.h                                             |    2 
 include/linux/sockptr.h                                                      |    4 
 include/net/bond_options.h                                                   |    2 
 kernel/Kconfig.kexec                                                         |    2 
 lib/buildid.c                                                                |    2 
 mm/mmap.c                                                                    |    2 
 mm/mremap.c                                                                  |    2 
 mm/nommu.c                                                                   |    4 
 mm/page_alloc.c                                                              |   18 +
 mm/shmem.c                                                                   |    5 
 mm/swap.c                                                                    |   14 -
 net/bluetooth/hci_core.c                                                     |    2 
 net/dccp/ipv6.c                                                              |    2 
 net/ipv6/tcp_ipv6.c                                                          |    4 
 net/mptcp/pm_netlink.c                                                       |    3 
 net/mptcp/pm_userspace.c                                                     |   15 +
 net/mptcp/protocol.c                                                         |   16 -
 net/netlink/af_netlink.c                                                     |   31 --
 net/netlink/af_netlink.h                                                     |    2 
 net/sched/cls_u32.c                                                          |   18 +
 net/sctp/ipv6.c                                                              |   19 +
 net/vmw_vsock/af_vsock.c                                                     |    3 
 net/vmw_vsock/virtio_transport_common.c                                      |    9 
 samples/pktgen/pktgen_sample01_simple.sh                                     |    2 
 security/integrity/evm/evm_main.c                                            |    3 
 security/integrity/ima/ima_template_lib.c                                    |   14 -
 sound/pci/hda/patch_realtek.c                                                |   13 -
 tools/mm/page-types.c                                                        |    2 
 tools/testing/selftests/kvm/Makefile                                         |    8 
 tools/testing/selftests/mm/hugetlb_dio.c                                     |    7 
 tools/testing/selftests/tc-testing/tc-tests/filters/u32.json                 |   24 ++
 143 files changed, 1076 insertions(+), 533 deletions(-)

Akash Goel (1):
      drm/panthor: Fix handling of partial GPU mapping of BOs

Alex Deucher (2):
      Revert "drm/amd/pm: correct the workload setting"
      Revert "drm/amd/display: parse umc_info or vram_info based on ASIC"

Alexandre Ferrieux (2):
      net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.
      net: sched: u32: Add test case for systematic hnode IDR leaks

Alexandre Ghiti (1):
      drivers: perf: Fix wrong put_cpu() placement

Andre Przywara (1):
      mmc: sunxi-mmc: Fix A100 compatible description

Andrew Morton (1):
      mm: revert "mm: shmem: fix data-race in shmem_getattr()"

Andy Yan (1):
      drm/rockchip: vop: Fix a dereferenced before check warning

Ard Biesheuvel (1):
      x86/stackprotector: Work around strict Clang TLS symbol requirements

Ashutosh Dixit (1):
      drm/xe/oa: Fix "Missing outer runtime PM protection" warning

Aurelien Jarno (1):
      Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"

Baoquan He (1):
      x86/mm: Fix a kdump kernel failure on SME system when CONFIG_IMA_KEXEC=y

Bibo Mao (1):
      LoongArch: Fix AP booting issue in VM mode

Carolina Jubran (1):
      net/mlx5e: Disable loopback self-test on multi-PF netdev

Chen Ridong (1):
      drm/vmwgfx: avoid null_ptr_deref in vmw_framebuffer_surface_create_handle

Christian König (2):
      drm/amdgpu: fix check in gmc_v9_0_get_vm_pte()
      drm/amdgpu: enable GTT fallback handling for dGPUs only

Cristian Marussi (1):
      firmware: arm_scmi: Skip opp duplicates

Dan Carpenter (1):
      fs/proc/task_mmu: prevent integer overflow in pagemap_scan_get_args()

Daniele Ceraolo Spurio (1):
      drm/i915/gsc: ARL-H and ARL-U need a newer GSC FW.

Dave Airlie (3):
      nouveau: fw: sync dma after setup is called.
      nouveau: handle EBUSY and EAGAIN for GSP aux errors.
      nouveau/dp: handle retries for AUX CH transfers with GSP.

Dave Vasilevsky (1):
      crash, powerpc: default to CRASH_DUMP=n on PPC_BOOK3S_32

David Rosca (1):
      drm/amdgpu: Fix video caps for H264 and HEVC encode maximum size

Dillon Varone (1):
      drm/amd/display: Require minimum VBlank size for stutter optimization

Dmitry Antipov (2):
      ocfs2: uncache inode which has failed entering the group
      ocfs2: fix UBSAN warning in ocfs2_verify_volume()

Donet Tom (1):
      selftests: hugetlb_dio: fixup check for initial conditions to skip in the start

Dragos Tatulea (1):
      net/mlx5e: kTLS, Fix incorrect page refcounting

Eric Dumazet (1):
      sctp: fix possible UAF in sctp_v6_available()

Francesco Dolcini (1):
      drm/bridge: tc358768: Fix DSI command tx

Geliang Tang (2):
      mptcp: update local address flags when setting it
      mptcp: hold pm lock when deleting entry

Greg Kroah-Hartman (1):
      Linux 6.11.10

Hajime Tazaki (1):
      nommu: pass NULL argument to vma_iter_prealloc()

Hamish Claxton (1):
      drm/amd/display: Fix failure to read vram info due to static BP_RESULT

Hangbin Liu (1):
      bonding: add ns target multicast address to slave device

Harith G (1):
      ARM: 9419/1: mm: Fix kernel memory mapping for xip kernels

Huacai Chen (3):
      LoongArch: Fix early_numa_add_cpu() usage for FDT systems
      LoongArch: Disable KASAN if PGDIR_SIZE is too large for cpu_vabits
      LoongArch: Make KASAN work with 5-level page-tables

Jack Xiao (1):
      drm/amdgpu/mes12: correct kiq unmap latency

Jakub Kicinski (1):
      netlink: terminate outstanding dump on socket close

Jann Horn (1):
      mm/mremap: fix address wraparound in move_page_tables()

Jarkko Sakkinen (1):
      tpm: Disable TPM on tpm2_create_primary() failure

Jinjiang Tu (1):
      mm: fix NULL pointer dereference in alloc_pages_bulk_noprof

Jiri Olsa (1):
      lib/buildid: Fix build ID parsing logic

Josef Bacik (1):
      btrfs: fix incorrect comparison for delayed refs

Kailang Yang (2):
      ALSA: hda/realtek - Fixed Clevo platform headset Mic issue
      ALSA: hda/realtek - update set GPIO3 to default for Thinkpad with ALC1318

Kanglong Wang (1):
      LoongArch: Add WriteCombine shadow mapping in KASAN

Kiran K (1):
      Bluetooth: btintel: Direct exception event to bluetooth stack

Leo Li (1):
      drm/amd/display: Run idle optimizations at end of vblank handler

Leon Romanovsky (1):
      Revert "RDMA/core: Fix ENODEV error for iWARP test over vlan"

Lorenzo Stoakes (1):
      mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix calling mgmt_device_connected

Maksym Glubokiy (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP EliteBook 645 G10

Mario Limonciello (1):
      x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client

Mark Bloch (1):
      net/mlx5: fs, lock FTE when checking if active

Mateusz Guzik (1):
      evm: stop avoidably reading i_writecount in evm_file_release

Matthew Auld (2):
      drm/xe: handle flat ccs during hibernation on igpu
      drm/xe: improve hibernation on igpu

Matthew Brost (1):
      drm/xe: Restore system memory GGTT mappings

Matthieu Baerts (NGI0) (1):
      mptcp: pm: use _rcu variant under rcu_read_lock

Mauro Carvalho Chehab (1):
      media: dvbdev: fix the logic when DVB_DYNAMIC_MINORS is not set

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix 1 PPS sync

Michal Luczaj (4):
      virtio/vsock: Fix accept_queue memory leak
      vsock: Fix sk_error_queue memory leak
      virtio/vsock: Improve MSG_ZEROCOPY error handling
      net: Make copy_safe_from_sockptr() match documentation

Moshe Shemesh (1):
      net/mlx5e: CT: Fix null-ptr-deref in add rule err flow

Motiejus JakÅ`tys (1):
      tools/mm: fix compile error

Nícolas F. R. A. Prado (1):
      net: stmmac: dwmac-mediatek: Fix inverted handling of mediatek,mac-wol

Paolo Abeni (2):
      mptcp: error out earlier on disconnect
      mptcp: cope racing subflow creation in mptcp_rcv_space_adjust

Parav Pandit (1):
      net/mlx5: Fix msix vectors to respect platform limit

Peng Fan (1):
      pmdomain: imx93-blk-ctrl: correct remove path

Philipp Stanner (1):
      vdpa: solidrun: Fix UB bug with devres

Qun-Wei Lin (1):
      sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers

Rodrigo Siqueira (1):
      drm/amd/display: Adjust VSDB parser for replay feature

Roman Gushchin (1):
      mm: page_alloc: move mlocked flag clearance into free_pages_prepare()

Russell King (Oracle) (2):
      net: phylink: ensure PHY momentary link-fails are handled
      ARM: fix cacheflush with PAN

Ryan Seto (1):
      drm/amd/display: Handle dml allocation failure to avoid crash

Ryusuke Konishi (2):
      nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint
      nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint

Samasth Norway Ananda (1):
      ima: fix buffer overrun in ima_eventdigest_init_common

Sean Christopherson (4):
      KVM: selftests: Disable strict aliasing
      KVM: nVMX: Treat vpid01 as current if L2 is active, but with VPID disabled
      KVM: x86: Unconditionally set irr_pending when updating APICv state
      KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind CONFIG_BROKEN

Si-Wei Liu (1):
      vdpa/mlx5: Fix PA offset with unaligned starting iotlb map

Sibi Sankar (4):
      mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag
      firmware: arm_scmi: Report duplicate opps as firmware bugs
      pmdomain: arm: Use FLAG_DEV_NAME_FW to ensure unique names
      pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag

Stefan Wahren (1):
      net: vertexcom: mse102x: Fix tx_bytes calculation

Tim Huang (1):
      drm/amd/pm: print pp_dpm_mclk in ascending order on SMU v14.0.0

Tom Chung (2):
      drm/amd/display: Change some variable name of psr
      drm/amd/display: Fix Panel Replay not update screen correctly

Vijendar Mukunda (1):
      drm/amd: Fix initialization mistake for NBIO 7.7.0

Vitalii Mordan (1):
      stmmac: dwmac-intel-plat: fix call balance of tx_clk handling routines

Wang Liang (1):
      net: fix data-races around sk->sk_forward_alloc

Wei Fang (1):
      samples: pktgen: correct dev to DEV

William Tu (1):
      net/mlx5e: clear xdp features on non-uplink representors

Xiaoguang Wang (1):
      vp_vdpa: fix id_table array not null terminated error


