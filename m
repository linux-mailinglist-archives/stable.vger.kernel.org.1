Return-Path: <stable+bounces-94618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05FE9D60C4
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C151F22732
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A6A14A4C3;
	Fri, 22 Nov 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtLk81BY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3D2AF04;
	Fri, 22 Nov 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286968; cv=none; b=cZ/U4RMS58cae+MpuHZpqYh2hUzo6HuKOxlKgwzHbNJZDcZxWAjQXP7PASIfbSFk7ZHXxeUVpEsurkPRbxZBI5UmF2mSpmzhbkuKAhFi1Qw4ADjJQkXDRvIHw92UxIF8PP3ooUImqLxU3NFcwSmn/hfQM7+w5ktkpz0KUbuMUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286968; c=relaxed/simple;
	bh=J6qcyeH6/kgD4bNIAsLDoSx8bGMBYK334wUMfnTA7XY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gn4J9saZDT7jLtiu1Iis4shHM2LcMN4twbHjwZXHektn27RZZTKoYVQMy+LeDcIL8tYOMWA/2TYeDH84faDbZnDtYzLKN3GHr4eSQR6AfuDZq589ZzZiZah9HEkUSs0s/apehNmagXqh5K6Iy3fg6p1F1h37BrOv+oKQ9XeeLUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtLk81BY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E510DC4CECE;
	Fri, 22 Nov 2024 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732286968;
	bh=J6qcyeH6/kgD4bNIAsLDoSx8bGMBYK334wUMfnTA7XY=;
	h=From:To:Cc:Subject:Date:From;
	b=gtLk81BYICm0ezhgFAjZg9J5C4w1PFUZ1dmM/8upHnGBn+M5D/vwQDb/Du8JM39ep
	 XVbAbvdPdwyCOy7VBl0OAU2wVD8KFMl+EI03OYMgojbuvigAn3mrqzkPH6PZ+Rd5Tc
	 5LzHWFmAGWiEVej8M/WVLpskhfcjBHJnC0mxdgMY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.63
Date: Fri, 22 Nov 2024 15:48:59 +0100
Message-ID: <2024112200-treble-commodity-66e6@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.63 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/arm/kernel/head.S                                        |    8 
 arch/arm/mm/mmu.c                                             |   34 +-
 arch/arm64/include/asm/mman.h                                 |   10 
 arch/loongarch/include/asm/kasan.h                            |    2 
 arch/loongarch/kernel/smp.c                                   |    2 
 arch/loongarch/mm/kasan_init.c                                |   41 ++-
 arch/parisc/include/asm/mman.h                                |    5 
 arch/x86/kvm/lapic.c                                          |   29 +-
 arch/x86/kvm/vmx/nested.c                                     |   30 +-
 arch/x86/kvm/vmx/vmx.c                                        |    6 
 arch/x86/mm/ioremap.c                                         |    6 
 drivers/bluetooth/btintel.c                                   |    5 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c                        |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c             |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c              |    7 
 drivers/gpu/drm/bridge/tc358768.c                             |   21 +
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c                      |   11 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                   |    8 
 drivers/infiniband/core/addr.c                                |    2 
 drivers/leds/leds-mlxreg.c                                    |   16 -
 drivers/media/dvb-core/dvbdev.c                               |   15 -
 drivers/mmc/host/dw_mmc.c                                     |    4 
 drivers/mmc/host/sunxi-mmc.c                                  |    6 
 drivers/net/bonding/bond_main.c                               |   16 +
 drivers/net/bonding/bond_options.c                            |   82 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c    |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c             |    3 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c             |   15 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c        |   40 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c          |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c          |   18 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c         |   23 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h         |    1 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                  |   13 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.h                  |   12 
 drivers/net/ethernet/vertexcom/mse102x.c                      |    4 
 drivers/pmdomain/imx/imx93-blk-ctrl.c                         |    4 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |   25 -
 drivers/vdpa/mlx5/core/mr.c                                   |    8 
 drivers/vdpa/solidrun/snet_main.c                             |   14 -
 drivers/vdpa/virtio_pci/vp_vdpa.c                             |   10 
 fs/9p/vfs_inode.c                                             |   17 -
 fs/nfsd/netns.h                                               |    1 
 fs/nfsd/nfs4proc.c                                            |   34 +-
 fs/nfsd/nfs4state.c                                           |    1 
 fs/nfsd/xdr4.h                                                |    1 
 fs/nilfs2/btnode.c                                            |    2 
 fs/nilfs2/gcinode.c                                           |    4 
 fs/nilfs2/mdt.c                                               |    1 
 fs/nilfs2/page.c                                              |    2 
 fs/ocfs2/resize.c                                             |    2 
 fs/ocfs2/super.c                                              |   13 -
 include/linux/damon.h                                         |   17 +
 include/linux/mman.h                                          |   28 +-
 include/linux/sockptr.h                                       |    4 
 include/net/bond_options.h                                    |    2 
 lib/buildid.c                                                 |    2 
 mm/damon/core.c                                               |   84 +++++-
 mm/damon/dbgfs.c                                              |    3 
 mm/damon/lru_sort.c                                           |    2 
 mm/damon/reclaim.c                                            |    2 
 mm/damon/sysfs-schemes.c                                      |    2 
 mm/internal.h                                                 |   45 +++
 mm/mmap.c                                                     |  128 +++++-----
 mm/mprotect.c                                                 |    2 
 mm/nommu.c                                                    |   11 
 mm/page_alloc.c                                               |    3 
 mm/shmem.c                                                    |    5 
 net/bluetooth/hci_core.c                                      |    2 
 net/mptcp/pm_netlink.c                                        |   15 -
 net/mptcp/pm_userspace.c                                      |   77 +++---
 net/mptcp/protocol.c                                          |   16 -
 net/netlink/af_netlink.c                                      |   31 --
 net/netlink/af_netlink.h                                      |    2 
 net/sched/cls_u32.c                                           |   54 ++--
 net/sctp/ipv6.c                                               |   19 +
 net/vmw_vsock/virtio_transport_common.c                       |    8 
 samples/pktgen/pktgen_sample01_simple.sh                      |    2 
 security/integrity/ima/ima_template_lib.c                     |   14 -
 sound/pci/hda/patch_realtek.c                                 |    3 
 tools/mm/page-types.c                                         |    2 
 83 files changed, 819 insertions(+), 424 deletions(-)

Alexandre Ferrieux (1):
      net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.

Andre Przywara (1):
      mmc: sunxi-mmc: Fix A100 compatible description

Andrew Morton (1):
      mm: revert "mm: shmem: fix data-race in shmem_getattr()"

Andy Yan (1):
      drm/rockchip: vop: Fix a dereferenced before check warning

Aurelien Jarno (1):
      Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"

Baoquan He (1):
      x86/mm: Fix a kdump kernel failure on SME system when CONFIG_IMA_KEXEC=y

Chuck Lever (4):
      NFSD: Async COPY result needs to return a write verifier
      NFSD: Limit the number of concurrent async COPY operations
      NFSD: Initialize struct nfsd4_copy earlier
      NFSD: Never decrement pending_async_copies on error

Dai Ngo (1):
      NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point

Dave Airlie (1):
      nouveau: fw: sync dma after setup is called.

Dmitry Antipov (2):
      ocfs2: uncache inode which has failed entering the group
      ocfs2: fix UBSAN warning in ocfs2_verify_volume()

Dragos Tatulea (1):
      net/mlx5e: kTLS, Fix incorrect page refcounting

Eric Dumazet (1):
      sctp: fix possible UAF in sctp_v6_available()

Eric Van Hensbergen (1):
      fs/9p: fix uninitialized values during inode evict

Francesco Dolcini (1):
      drm/bridge: tc358768: Fix DSI command tx

Geliang Tang (5):
      mptcp: define more local variables sk
      mptcp: add userspace_pm_lookup_addr_by_id helper
      mptcp: update local address flags when setting it
      mptcp: hold pm lock when deleting entry
      mptcp: drop lookup_by_id in lookup_addr

George Stark (1):
      leds: mlxreg: Use devm_mutex_init() for mutex initialization

Greg Kroah-Hartman (1):
      Linux 6.6.63

Hajime Tazaki (1):
      nommu: pass NULL argument to vma_iter_prealloc()

Hangbin Liu (1):
      bonding: add ns target multicast address to slave device

Harith G (1):
      ARM: 9419/1: mm: Fix kernel memory mapping for xip kernels

Huacai Chen (3):
      LoongArch: Fix early_numa_add_cpu() usage for FDT systems
      LoongArch: Disable KASAN if PGDIR_SIZE is too large for cpu_vabits
      LoongArch: Make KASAN work with 5-level page-tables

Jakub Kicinski (1):
      netlink: terminate outstanding dump on socket close

Jinjiang Tu (1):
      mm: fix NULL pointer dereference in alloc_pages_bulk_noprof

Jiri Olsa (1):
      lib/buildid: Fix build ID parsing logic

Jisheng Zhang (3):
      net: stmmac: dwmac-intel-plat: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-visconti: use devm_stmmac_probe_config_dt()
      net: stmmac: rename stmmac_pltfr_remove_no_dt to stmmac_pltfr_remove

Kailang Yang (1):
      ALSA: hda/realtek - Fixed Clevo platform headset Mic issue

Kiran K (1):
      Bluetooth: btintel: Direct exception event to bluetooth stack

Leon Romanovsky (1):
      Revert "RDMA/core: Fix ENODEV error for iWARP test over vlan"

Lorenzo Stoakes (5):
      mm: avoid unsafe VMA hook invocation when error arises on mmap hook
      mm: unconditionally close VMAs on error
      mm: refactor map_deny_write_exec()
      mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
      mm: resolve faulty mmap_region() error path behaviour

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix calling mgmt_device_connected

Maksym Glubokiy (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP EliteBook 645 G10

Mark Bloch (1):
      net/mlx5: fs, lock FTE when checking if active

Matthieu Baerts (NGI0) (1):
      mptcp: pm: use _rcu variant under rcu_read_lock

Mauro Carvalho Chehab (1):
      media: dvbdev: fix the logic when DVB_DYNAMIC_MINORS is not set

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix 1 PPS sync

Michal Luczaj (2):
      virtio/vsock: Fix accept_queue memory leak
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

Pedro Tammela (1):
      net/sched: cls_u32: replace int refcounts with proper refcounts

Peng Fan (1):
      pmdomain: imx93-blk-ctrl: correct remove path

Philipp Stanner (1):
      vdpa: solidrun: Fix UB bug with devres

Rodrigo Siqueira (1):
      drm/amd/display: Adjust VSDB parser for replay feature

Ryusuke Konishi (2):
      nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint
      nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint

Samasth Norway Ananda (1):
      ima: fix buffer overrun in ima_eventdigest_init_common

Sean Christopherson (3):
      KVM: nVMX: Treat vpid01 as current if L2 is active, but with VPID disabled
      KVM: x86: Unconditionally set irr_pending when updating APICv state
      KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind CONFIG_BROKEN

SeongJae Park (5):
      mm/damon/core: implement scheme-specific apply interval
      mm/damon/core: handle zero {aggregation,ops_update} intervals
      mm/damon/core: check apply interval in damon_do_apply_schemes()
      mm/damon/core: handle zero schemes apply interval
      mm/damon/core: copy nr_accesses when splitting region

Si-Wei Liu (1):
      vdpa/mlx5: Fix PA offset with unaligned starting iotlb map

Stefan Wahren (2):
      net: vertexcom: mse102x: Fix tx_bytes calculation
      staging: vchiq_arm: Get the rid off struct vchiq_2835_state

Tvrtko Ursulin (1):
      drm/amd/pm: Vangogh: Fix kernel memory out of bounds write

Umang Jain (1):
      staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state allocation

Vijendar Mukunda (1):
      drm/amd: Fix initialization mistake for NBIO 7.7.0

Vitalii Mordan (1):
      stmmac: dwmac-intel-plat: fix call balance of tx_clk handling routines

Wei Fang (1):
      samples: pktgen: correct dev to DEV

William Tu (1):
      net/mlx5e: clear xdp features on non-uplink representors

Xiaoguang Wang (1):
      vp_vdpa: fix id_table array not null terminated error


