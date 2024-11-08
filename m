Return-Path: <stable+bounces-91953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762629C2164
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 17:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04F8B226EA
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA8322315;
	Fri,  8 Nov 2024 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eM4tv7T2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B817BA2;
	Fri,  8 Nov 2024 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081609; cv=none; b=VLkUoin8MMWtxqEwpEbP6Uj8qFNNg1SK9CQyxMHGTotyTJLz9+g1075/C9zFJ/+UHmrkX+ZRAm4/2RkH/ZhtWSNybxIQFXfSlEmZCsrYPA00Y7KI+qvfqT4Ngf293a40RMqJizmOAvJIClYm/xHKqxvhEvrkGQZxinzdsZ0cAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081609; c=relaxed/simple;
	bh=dsUmwMU2jGr61l4ZH73vumwQ+uE1YrPKiPOy4ugPPoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cta7HQmX2pAfMkqcOrtoTTyxwV2oO7eROjwWFR8ODXEaEd2oF0YU9aM1h419rSm6Kyv3L7SxX8autKT33MSOJ5qzh+66IuJhYALxCBlyBEynIYxoTCV/obrZoNfGVbl3M63VOSjgYfBG0IMm8gbE20iSkwzxYWshHE+AaEKHkgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eM4tv7T2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92254C4CED0;
	Fri,  8 Nov 2024 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081609;
	bh=dsUmwMU2jGr61l4ZH73vumwQ+uE1YrPKiPOy4ugPPoU=;
	h=From:To:Cc:Subject:Date:From;
	b=eM4tv7T2gZ+1h/15hDMklyAaiRfBhkHWd9Zny0DwS6amFaq4V/8r/pYesA20fT6kZ
	 3Ys4RGQgSpqU6EBuq7X7dZEFQc4IlIJIieB9gBkeroH8uckE+T+Iwwc3qW/hoULbfQ
	 z034x8uA06f19sTOtH08m30FyHdfdEM47Yt63aIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.116
Date: Fri,  8 Nov 2024 16:59:38 +0100
Message-ID: <2024110839-untainted-affecting-65a7@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.116 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                              |    2 
 arch/alpha/include/asm/pgtable.h                      |    2 
 arch/arc/include/asm/pgtable-bits-arcv2.h             |    2 
 arch/arm/include/asm/pgtable-nommu.h                  |    2 
 arch/arm/include/asm/pgtable.h                        |    4 
 arch/arm64/include/asm/pgtable.h                      |    2 
 arch/arm64/mm/mmu.c                                   |   47 -
 arch/arm64/mm/pageattr.c                              |    3 
 arch/csky/include/asm/pgtable.h                       |    3 
 arch/hexagon/include/asm/page.h                       |    7 
 arch/ia64/include/asm/pgtable.h                       |   16 
 arch/loongarch/include/asm/pgtable.h                  |    2 
 arch/loongarch/kernel/vdso.c                          |   28 
 arch/m68k/include/asm/pgtable_mm.h                    |    2 
 arch/m68k/include/asm/pgtable_no.h                    |    1 
 arch/microblaze/include/asm/pgtable.h                 |    3 
 arch/mips/include/asm/pgtable.h                       |    2 
 arch/nios2/include/asm/pgtable.h                      |    2 
 arch/openrisc/include/asm/pgtable.h                   |    2 
 arch/parisc/include/asm/pgtable.h                     |   15 
 arch/powerpc/include/asm/pgtable.h                    |    7 
 arch/riscv/include/asm/pgtable.h                      |    2 
 arch/riscv/kernel/asm-offsets.c                       |    2 
 arch/riscv/kernel/cpu-hotplug.c                       |    2 
 arch/riscv/kernel/efi-header.S                        |    2 
 arch/riscv/kernel/traps_misaligned.c                  |    2 
 arch/riscv/kernel/vdso/Makefile                       |    1 
 arch/s390/include/asm/io.h                            |    2 
 arch/s390/include/asm/pgtable.h                       |    2 
 arch/sh/include/asm/pgtable.h                         |    2 
 arch/sparc/include/asm/pgtable_32.h                   |    6 
 arch/sparc/mm/init_32.c                               |    3 
 arch/sparc/mm/init_64.c                               |    1 
 arch/um/include/asm/pgtable.h                         |    2 
 arch/x86/include/asm/nospec-branch.h                  |   11 
 arch/x86/include/asm/pgtable_32.h                     |    9 
 arch/x86/include/asm/pgtable_64.h                     |    1 
 arch/x86/mm/init_64.c                                 |   41 -
 arch/xtensa/include/asm/pgtable.h                     |    2 
 block/blk-map.c                                       |    4 
 drivers/acpi/cppc_acpi.c                              |    9 
 drivers/base/core.c                                   |   13 
 drivers/base/module.c                                 |    4 
 drivers/cpufreq/mediatek-cpufreq-hw.c                 |   14 
 drivers/cxl/acpi.c                                    |   17 
 drivers/cxl/core/port.c                               |   26 
 drivers/cxl/cxl.h                                     |    3 
 drivers/firmware/arm_sdei.c                           |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     |   10 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c    |    3 
 drivers/iio/adc/ad7124.c                              |    2 
 drivers/iio/light/veml6030.c                          |    2 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c              |    4 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c            |   13 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h            |    2 
 drivers/infiniband/hw/cxgb4/provider.c                |    1 
 drivers/infiniband/hw/mlx5/qp.c                       |    4 
 drivers/misc/sgi-gru/grukservices.c                   |    2 
 drivers/misc/sgi-gru/grumain.c                        |    4 
 drivers/misc/sgi-gru/grutlbpurge.c                    |    2 
 drivers/mtd/spi-nor/winbond.c                         |    7 
 drivers/net/ethernet/amd/mvme147.c                    |    7 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c   |  119 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.h   |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c    |    7 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     |   22 
 drivers/net/gtp.c                                     |   22 
 drivers/net/macsec.c                                  |    3 
 drivers/net/mctp/mctp-i2c.c                           |    3 
 drivers/net/netdevsim/fib.c                           |    4 
 drivers/net/wireless/ath/ath10k/wmi-tlv.c             |    7 
 drivers/net/wireless/ath/ath10k/wmi.c                 |    2 
 drivers/net/wireless/ath/ath11k/dp_rx.c               |    7 
 drivers/net/wireless/broadcom/brcm80211/Kconfig       |    1 
 drivers/net/wireless/intel/iwlegacy/common.c          |   15 
 drivers/net/wireless/intel/iwlegacy/common.h          |   12 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c           |   22 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c         |    3 
 drivers/nvme/target/auth.c                            |    1 
 drivers/scsi/scsi_transport_fc.c                      |    4 
 drivers/staging/iio/frequency/ad9832.c                |    7 
 drivers/tty/vt/vt.c                                   |    2 
 drivers/usb/gadget/udc/dummy_hcd.c                    |   57 +
 drivers/usb/host/xhci-pci.c                           |    6 
 drivers/usb/host/xhci-ring.c                          |   16 
 drivers/usb/phy/phy.c                                 |    2 
 drivers/usb/typec/class.c                             |    1 
 fs/afs/dir.c                                          |   25 
 fs/afs/dir_edit.c                                     |   91 ++
 fs/afs/internal.h                                     |    2 
 fs/dax.c                                              |   45 -
 fs/iomap/buffered-io.c                                |   31 
 fs/nfs/delegation.c                                   |    5 
 fs/nilfs2/namei.c                                     |    3 
 fs/nilfs2/page.c                                      |    1 
 fs/ntfs3/frecord.c                                    |    4 
 fs/ntfs3/inode.c                                      |   10 
 fs/ntfs3/lznt.c                                       |    3 
 fs/ntfs3/namei.c                                      |    2 
 fs/ntfs3/ntfs_fs.h                                    |    2 
 fs/ocfs2/file.c                                       |    8 
 fs/proc/kcore.c                                       |   94 +-
 include/acpi/cppc_acpi.h                              |    2 
 include/linux/compiler-gcc.h                          |   12 
 include/linux/cpufreq.h                               |   34 
 include/linux/fs.h                                    |   36 +
 include/linux/iomap.h                                 |   19 
 include/linux/migrate.h                               |    1 
 include/net/ip_tunnels.h                              |    2 
 include/trace/events/afs.h                            |  240 ------
 io_uring/io_uring.c                                   |   11 
 io_uring/rw.c                                         |   52 -
 kernel/bpf/cgroup.c                                   |   19 
 kernel/bpf/lpm_trie.c                                 |    2 
 kernel/cgroup/cgroup.c                                |    4 
 mm/huge_memory.c                                      |    4 
 mm/internal.h                                         |   13 
 mm/kasan/kasan_test.c                                 |   27 
 mm/migrate.c                                          |  636 ++++++++++++------
 mm/page_alloc.c                                       |   93 +-
 mm/shmem.c                                            |    2 
 net/bluetooth/hci_sync.c                              |   18 
 net/core/dev.c                                        |    4 
 net/ipv6/netfilter/nf_reject_ipv6.c                   |   15 
 net/mac80211/Kconfig                                  |    2 
 net/mac80211/agg-tx.c                                 |    4 
 net/mac80211/cfg.c                                    |    3 
 net/mac80211/key.c                                    |   42 -
 net/netfilter/nft_payload.c                           |    3 
 net/netfilter/x_tables.c                              |    2 
 net/sched/sch_api.c                                   |    2 
 net/wireless/core.c                                   |    1 
 sound/pci/hda/patch_realtek.c                         |   22 
 sound/soc/codecs/cs42l51.c                            |    7 
 sound/usb/mixer_quirks.c                              |    3 
 tools/testing/selftests/vm/hmm-tests.c                |    2 
 tools/usb/usbip/src/usbip_detach.c                    |    1 
 138 files changed, 1421 insertions(+), 995 deletions(-)

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix "task hung" problem

Alex Hung (1):
      drm/amd/display: Skip on writeback when it's not applicable

Alexander Gordeev (1):
      fs/proc/kcore.c: allow translation of physical memory addresses

Alexandre Ghiti (1):
      riscv: vdso: Prevent the compiler from inserting calls to memset()

Amir Goldstein (3):
      io_uring: rename kiocb_end_write() local helper
      fs: create kiocb_{start,end}_write() helpers
      io_uring: use kiocb_{start,end}_write() helpers

Amit Cohen (1):
      mlxsw: spectrum_ptp: Add missing verification before pushing Tx header

Andrew Ballance (1):
      fs/ntfs3: Check if more than chunk-size bytes are written

Andrey Konovalov (2):
      usb: gadget: dummy_hcd: execute hrtimer callback in softirq context
      kasan: remove vmalloc_percpu test

Baolin Wang (1):
      mm: migrate: try again if THP split is failed due to page refcnt

Basavaraj Natikar (1):
      xhci: Use pm_runtime_get to prevent RPM on unsupported systems

Ben Hutchings (1):
      wifi: iwlegacy: Fix "field-spanning write" warning in il_enqueue_hcmd()

Benjamin Marzinski (1):
      scsi: scsi_transport_fc: Allow setting rport state to current state

Benoît Monin (1):
      net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension

Byeonguk Jeong (1):
      bpf: Fix out-of-bounds write in trie_get_next_key()

Chen Ridong (1):
      cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction

Christoffer Sandberg (1):
      ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16 Gen6 mb1

Christoph Hellwig (2):
      iomap: improve shared block detection in iomap_unshare_iter
      iomap: turn iomap_want_unshare_iter into an inline function

Christophe JAILLET (1):
      ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()

Chunyan Zhang (2):
      riscv: Remove unused GENERATING_ASM_OFFSETS
      riscv: Remove duplicated GET_RM

Dai Ngo (1):
      NFS: remove revoked delegation from server's delegation list

Dan Williams (2):
      cxl/acpi: Move rescan to the workqueue
      cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()

Daniel Gabay (1):
      wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()

Daniel Palmer (1):
      net: amd: mvme147: Fix probe banner message

Darrick J. Wong (5):
      iomap: convert iomap_unshare_iter to use large folios
      iomap: don't bother unsharing delalloc extents
      iomap: share iomap_unshare_iter predicate code with fsdax
      fsdax: remove zeroing code from dax_unshare_iter
      fsdax: dax_unshare_iter needs to copy entire blocks

David Howells (2):
      afs: Automatically generate trace tag enums
      afs: Fix missing subdir edit when renamed between parent dirs

Dimitri Sivanich (1):
      misc: sgi-gru: Don't disable preemption in GRU driver

Donet Tom (1):
      selftests/mm: fix incorrect buffer->mirror size in hmm2 double_map test

Dong Chenchen (1):
      netfilter: Fix use-after-free in get_info()

Edward Adam Davis (1):
      ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: disconnect station vifs if recovery failed

Eric Dumazet (1):
      netfilter: nf_reject_ipv6: fix potential crash in nf_send_reset6()

Faisal Hassan (1):
      xhci: Fix Link TRB DMA in command ring stopped completion event

Felix Fietkau (2):
      wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys
      wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower

Furong Xu (1):
      net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data

Geert Uytterhoeven (2):
      mac80211: MAC80211_MESSAGE_TRACING should depend on TRACING
      wifi: brcm80211: BRCM_TRACING should depend on TRACING

Greg Kroah-Hartman (2):
      Revert "driver core: Fix uevent_show() vs driver detach race"
      Linux 6.1.116

Gregory Price (1):
      vmscan,migrate: fix page count imbalance on node stats when demoting pages

Hector Martin (1):
      cpufreq: Generalize of_perf_domain_get_sharing_cpumask phandle format

Heinrich Schuchardt (1):
      riscv: efi: Set NX compat flag in PE/COFF header

Huacai Chen (1):
      LoongArch: Fix build errors due to backported TIMENS

Huang Ying (7):
      migrate: convert unmap_and_move() to use folios
      migrate: convert migrate_pages() to use folios
      migrate_pages: organize stats with struct migrate_pages_stats
      migrate_pages: separate hugetlb folios migration
      migrate_pages: restrict number of pages to migrate in batch
      migrate_pages: split unmap_and_move() to _unmap() and _move()
      migrate_pages_batch: fix statistics for longterm pin retry

Ido Schimmel (4):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_init_flow()
      mlxsw: spectrum_router: Add support for double entry RIFs
      mlxsw: spectrum_ipip: Rename Spectrum-2 ip6gre operations
      mlxsw: spectrum_ipip: Fix memory leak when changing remote IPv6 address

Jan Schär (1):
      ALSA: usb-audio: Add quirks for Dell WD19 dock

Javier Carrasco (2):
      usb: typec: fix unreleased fwnode_handle in typec_port_register_altmodes()
      iio: light: veml6030: fix microlux value calculation

Jens Axboe (1):
      io_uring/rw: fix missing NOWAIT check for O_DIRECT start write

Jeongjun Park (2):
      mm: shmem: fix data-race in shmem_getattr()
      vt: prevent kernel-infoleak in con_font_get()

Jianbo Liu (1):
      macsec: Fix use-after-free while sending the offloading packet

Johannes Berg (2):
      wifi: cfg80211: clear wdev->cqm_config pointer on free
      wifi: iwlwifi: mvm: fix 6 GHz scan construction

Kailang Yang (1):
      ALSA: hda/realtek: Limit internal Mic boost on Dell platform

Kefeng Wang (1):
      mm: remove kern_addr_valid() completely

Konstantin Komarov (4):
      fs/ntfs3: Fix warning possible deadlock in ntfs_set_state
      fs/ntfs3: Stale inode instead of bad
      fs/ntfs3: Fix possible deadlock in mi_read
      fs/ntfs3: Additional check in ni_clear()

Leon Romanovsky (1):
      RDMA/cxgb4: Dump vendor specific QP details

Linus Torvalds (1):
      mm: avoid gcc complaint about pointer casting

Lorenzo Stoakes (3):
      fs/proc/kcore: avoid bounce buffer for ktext data
      fs/proc/kcore: convert read_kcore() to read_kcore_iter()
      fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT regions

Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Marcello Sylvester Bauer (2):
      usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler
      usb: gadget: dummy_hcd: Set transfer interval to 1 microframe

Marco Elver (1):
      kasan: Fix Software Tag-Based KASAN with GCC

Matt Fleming (1):
      mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves

Matt Johnston (1):
      mctp i2c: handle NULL header address

Mel Gorman (5):
      mm/page_alloc: rename ALLOC_HIGH to ALLOC_MIN_RESERVE
      mm/page_alloc: treat RT tasks similar to __GFP_HIGH
      mm/page_alloc: explicitly record high-order atomic allocations in alloc_flags
      mm/page_alloc: explicitly define what alloc flags deplete min reserves
      mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocations accesses reserves

Michael Walle (1):
      mtd: spi-nor: winbond: fix w25q128 regression

Miguel Ojeda (2):
      compiler-gcc: be consistent with underscores use for `no_sanitize`
      compiler-gcc: remove attribute support check for `__no_sanitize_address__`

Miquel Sabaté Solà (1):
      cpufreq: Avoid a bad reference count on CPU node

Pablo Neira Ayuso (2):
      gtp: allow -1 to be specified as file description from userspace
      netfilter: nft_payload: sanitize offset and length before calling skb_checksum()

Patrisious Haddad (1):
      RDMA/mlx5: Round max_rd_atomic/max_dest_rd_atomic up instead of down

Pavel Begunkov (1):
      io_uring: always lock __io_cqring_overflow_flush

Pawan Gupta (1):
      x86/bugs: Use code segment selector for VERW operand

Pedro Tammela (1):
      net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Pierre Gondois (1):
      ACPI: CPPC: Make rmw_lock a raw_spin_lock

Remi Pommarel (1):
      wifi: ath11k: Fix invalid ring usage in full monitor mode

Ryusuke Konishi (2):
      nilfs2: fix potential deadlock with newly created symlinks
      nilfs2: fix kernel bug due to missing clearing of checked flag

Selvin Xavier (1):
      RDMA/bnxt_re: synchronize the qp-handle table array

Srinivasan Shanmugam (1):
      drm/amd/display: Add null checks for 'stream' and 'plane' before dereferencing

Sungwoo Kim (1):
      Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

Ville Syrjälä (1):
      wifi: iwlegacy: Clear stale interrupts before resuming device

Vitaliy Shevtsov (1):
      nvmet-auth: assign dh_key to NULL after kfree_sensitive

WangYuli (1):
      riscv: Use '%u' to format the output of 'cpu'

Xinyu Zhang (1):
      block: fix sanity checks in blk_rq_map_user_bvec

Xiongfeng Wang (1):
      firmware: arm_sdei: Fix the input parameter of cpuhp_remove_state()

Xiu Jianfeng (1):
      cgroup: Fix potential overflow issue when checking max_depth

Yang Li (1):
      mm/migrate.c: stop using 0 as NULL pointer

Zichen Xie (1):
      netdevsim: Add trailing zero to terminate the string in nsim_nexthop_bucket_activity_write()

Zicheng Qu (2):
      staging: iio: frequency: ad9832: fix division by zero in ad9832_calc_freqreg()
      iio: adc: ad7124: fix division by zero in ad7124_set_channel_odr()

Zijun Hu (1):
      usb: phy: Fix API devm_usb_put_phy() can not release the phy

Zong-Zhe Yang (1):
      wifi: mac80211: fix NULL dereference at band check in starting tx ba session

Zongmin Zhou (1):
      usbip: tools: Fix detach_port() invalid port error path


