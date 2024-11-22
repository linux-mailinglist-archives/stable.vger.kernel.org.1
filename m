Return-Path: <stable+bounces-94616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFC19D60C0
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB992B20FCC
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2F2AF04;
	Fri, 22 Nov 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4w9yxzb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB67580C;
	Fri, 22 Nov 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286957; cv=none; b=NV/Dt7QzGvquWaT6JUQ8krl7kA80bo4eOCZNSvqeZHh6l6rsdjUfr+MdeDsaMdzjHA8M+K2nul6fjYTYTLtUcNoJWSd7QYgjlW0s0zxXx8MPEB24ro34hu+z1szFUcEhVAo2KyPyz7x8paFzIG78v4IepgHBn87BLK5f1/6Q54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286957; c=relaxed/simple;
	bh=MINB20Xz5XXO/Euq10IW5x9cXrD0fkbffYKT5UJ3WMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hhUbpdLlyLoeSMdvf5PhSp3LrvBI2jlmfuooBdCLjn2x1CJuQseevrRzOCbKiYE+e3apf3dZAvd8NCBn7LlMupOZ0GphYiUKY5lCbob6uDuMtRvdyo5ISx4nJlVpNp/TeL0EQhVub0XW32SH+iYFZoj+stZkox6SSpUU0fSQp9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4w9yxzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249CAC4CECE;
	Fri, 22 Nov 2024 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732286957;
	bh=MINB20Xz5XXO/Euq10IW5x9cXrD0fkbffYKT5UJ3WMc=;
	h=From:To:Cc:Subject:Date:From;
	b=f4w9yxzbPnrQLYy7GGci/HcN3HFEKmJg2ZcEtfHoeeyId3YQte6sqowEaR3R3ur1o
	 UHeCCJsvoiCNnhO2plHKMDMQhfqop1evWxKEy7XJusw3HRe55fJVDXq4NfeUwS4Lpy
	 Ozh7mL0/WEVbZD1b+H3e7mxnaI2KWcex4h8MrXMA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.119
Date: Fri, 22 Nov 2024 15:48:49 +0100
Message-ID: <2024112249-ashes-coronary-334a@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.119 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm/kernel/head.S                                         |    8 
 arch/arm/mm/mmu.c                                              |   34 +-
 arch/arm64/include/asm/mman.h                                  |   10 
 arch/parisc/Kconfig                                            |    1 
 arch/parisc/include/asm/cache.h                                |   11 
 arch/x86/kvm/lapic.c                                           |   29 +
 arch/x86/kvm/vmx/nested.c                                      |   30 +
 arch/x86/kvm/vmx/vmx.c                                         |    6 
 arch/x86/mm/ioremap.c                                          |    6 
 drivers/block/null_blk/main.c                                  |   45 +-
 drivers/char/xillybus/xillybus_class.c                         |    7 
 drivers/char/xillybus/xillyusb.c                               |   22 +
 drivers/cxl/core/pci.c                                         |    2 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c                         |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                 |    3 
 drivers/gpu/drm/bridge/tc358768.c                              |   21 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                    |    8 
 drivers/media/dvb-core/dvbdev.c                                |   15 
 drivers/mmc/host/dw_mmc.c                                      |    4 
 drivers/mmc/host/sunxi-mmc.c                                   |    6 
 drivers/net/bonding/bond_main.c                                |   16 
 drivers/net/bonding/bond_options.c                             |   82 ++++-
 drivers/net/ethernet/freescale/fec_main.c                      |   26 -
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c     |    8 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c              |   15 
 drivers/net/ethernet/vertexcom/mse102x.c                       |    4 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  |   25 -
 drivers/vdpa/mlx5/core/mr.c                                    |    8 
 drivers/vdpa/virtio_pci/vp_vdpa.c                              |   10 
 fs/9p/vfs_inode.c                                              |   23 -
 fs/nfsd/netns.h                                                |    1 
 fs/nfsd/nfs4proc.c                                             |   34 --
 fs/nfsd/nfs4state.c                                            |    1 
 fs/nfsd/xdr4.h                                                 |    1 
 fs/nilfs2/btnode.c                                             |    2 
 fs/nilfs2/gcinode.c                                            |    4 
 fs/nilfs2/mdt.c                                                |    1 
 fs/nilfs2/page.c                                               |    2 
 fs/ntfs3/file.c                                                |   12 
 fs/ocfs2/resize.c                                              |    2 
 fs/ocfs2/super.c                                               |   13 
 fs/smb/server/smb2misc.c                                       |   26 +
 fs/smb/server/smb2pdu.c                                        |   48 +-
 include/linux/mman.h                                           |    7 
 include/linux/sockptr.h                                        |   27 +
 include/net/bond_options.h                                     |    2 
 lib/buildid.c                                                  |    2 
 mm/internal.h                                                  |   19 +
 mm/mmap.c                                                      |  120 +++----
 mm/nommu.c                                                     |    9 
 mm/page_alloc.c                                                |    3 
 mm/shmem.c                                                     |    5 
 mm/util.c                                                      |   33 ++
 net/bluetooth/hci_core.c                                       |    2 
 net/bluetooth/hci_event.c                                      |  163 ----------
 net/bluetooth/iso.c                                            |   32 -
 net/mptcp/pm_netlink.c                                         |   15 
 net/mptcp/pm_userspace.c                                       |   77 +++-
 net/mptcp/protocol.c                                           |   16 
 net/netfilter/ipvs/ip_vs_ctl.c                                 |   10 
 net/netlink/af_netlink.c                                       |   31 -
 net/netlink/af_netlink.h                                       |    2 
 net/nfc/llcp_sock.c                                            |   12 
 net/sched/cls_u32.c                                            |   54 +--
 net/sched/sch_taprio.c                                         |   10 
 net/vmw_vsock/virtio_transport_common.c                        |    8 
 samples/pktgen/pktgen_sample01_simple.sh                       |    2 
 security/integrity/ima/ima_template_lib.c                      |   14 
 sound/pci/hda/patch_realtek.c                                  |    3 
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json |   22 +
 72 files changed, 759 insertions(+), 583 deletions(-)

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

Chen Hanxiao (1):
      ipvs: properly dereference pe in ip_vs_add_service

Christophe JAILLET (1):
      null_blk: Remove usage of the deprecated ida_simple_xx() API

Chuck Lever (4):
      NFSD: Async COPY result needs to return a write verifier
      NFSD: Limit the number of concurrent async COPY operations
      NFSD: Initialize struct nfsd4_copy earlier
      NFSD: Never decrement pending_async_copies on error

Dai Ngo (1):
      NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point

Damien Le Moal (1):
      null_blk: Fix return value of nullb_device_power_store()

Dan Carpenter (1):
      cxl/pci: fix error code in __cxl_hdm_decode_init()

Dmitry Antipov (2):
      ocfs2: uncache inode which has failed entering the group
      ocfs2: fix UBSAN warning in ocfs2_verify_volume()

Dragos Tatulea (1):
      net/mlx5e: kTLS, Fix incorrect page refcounting

Eli Billauer (2):
      char: xillybus: Prevent use-after-free due to race condition
      char: xillybus: Fix trivial bug with mutex

Eric Dumazet (2):
      net: add copy_safe_from_sockptr() helper
      nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies

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

Greg Kroah-Hartman (1):
      Linux 6.1.119

Hangbin Liu (1):
      bonding: add ns target multicast address to slave device

Harith G (1):
      ARM: 9419/1: mm: Fix kernel memory mapping for xip kernels

Jakub Kicinski (1):
      netlink: terminate outstanding dump on socket close

Jinjiang Tu (1):
      mm: fix NULL pointer dereference in alloc_pages_bulk_noprof

Jiri Olsa (1):
      lib/buildid: Fix build ID parsing logic

Kailang Yang (1):
      ALSA: hda/realtek - Fixed Clevo platform headset Mic issue

Konstantin Komarov (1):
      fs/ntfs3: Additional check in ntfs_file_release

Lin.Cao (1):
      drm/amd: check num of link levels when update pcie param

Lorenzo Stoakes (4):
      mm: avoid unsafe VMA hook invocation when error arises on mmap hook
      mm: unconditionally close VMAs on error
      mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
      mm: resolve faulty mmap_region() error path behaviour

Luiz Augusto von Dentz (2):
      Bluetooth: hci_core: Fix calling mgmt_device_connected
      Bluetooth: ISO: Fix not validating setsockopt user input

Lukas Bulwahn (1):
      Bluetooth: hci_event: Remove code to removed CONFIG_BT_HS

Maksym Glubokiy (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP EliteBook 645 G10

Mark Bloch (1):
      net/mlx5: fs, lock FTE when checking if active

Matthieu Baerts (NGI0) (1):
      mptcp: pm: use _rcu variant under rcu_read_lock

Mauro Carvalho Chehab (1):
      media: dvbdev: fix the logic when DVB_DYNAMIC_MINORS is not set

Michal Luczaj (2):
      virtio/vsock: Fix accept_queue memory leak
      net: Make copy_safe_from_sockptr() match documentation

Mikulas Patocka (1):
      parisc: fix a possible DMA corruption

Moshe Shemesh (1):
      net/mlx5e: CT: Fix null-ptr-deref in add rule err flow

Namjae Jeon (2):
      ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()
      ksmbd: fix potencial out-of-bounds when buffer offset is invalid

Paolo Abeni (2):
      mptcp: error out earlier on disconnect
      mptcp: cope racing subflow creation in mptcp_rcv_space_adjust

Pedro Tammela (1):
      net/sched: cls_u32: replace int refcounts with proper refcounts

Ryusuke Konishi (2):
      nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint
      nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint

Samasth Norway Ananda (1):
      ima: fix buffer overrun in ima_eventdigest_init_common

Sean Christopherson (3):
      KVM: nVMX: Treat vpid01 as current if L2 is active, but with VPID disabled
      KVM: x86: Unconditionally set irr_pending when updating APICv state
      KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind CONFIG_BROKEN

Si-Wei Liu (1):
      vdpa/mlx5: Fix PA offset with unaligned starting iotlb map

Stefan Wahren (2):
      net: vertexcom: mse102x: Fix tx_bytes calculation
      staging: vchiq_arm: Get the rid off struct vchiq_2835_state

Umang Jain (1):
      staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state allocation

Vijendar Mukunda (1):
      drm/amd: Fix initialization mistake for NBIO 7.7.0

Vladimir Oltean (1):
      net/sched: taprio: extend minimum interval restriction to entire cycle too

Wei Fang (2):
      samples: pktgen: correct dev to DEV
      net: fec: remove .ndo_poll_controller to avoid deadlocks

Xiaoguang Wang (1):
      vp_vdpa: fix id_table array not null terminated error

Yu Kuai (1):
      null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'


