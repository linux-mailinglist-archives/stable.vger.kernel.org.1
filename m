Return-Path: <stable+bounces-91951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14599C215F
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F081F220A3
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D6421F4B5;
	Fri,  8 Nov 2024 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VcxM377v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59A21B456;
	Fri,  8 Nov 2024 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081601; cv=none; b=DFmgydnH+jBzDgPaKDEmXA55g8zh7zKX3ZWnwzktgbJWKrVdfprNzknBJY4MBpDt0suAbiiMrSu/0ox+HRVyIzSr/frfosd0eqkvQ3kqfyi98dVsiakZoqtA/q71KoOg2gz4IoFXVsjT7VJS4c9MvahLWPPstAAm8fF+bTYf4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081601; c=relaxed/simple;
	bh=PJpISRgI1ip7kwmpC70u88YBF9cuUKs77DEXwoiRGno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+LzrOmYJpSkl53cY560aAtgQ9cdFXsdqVsRSUHaPG4N2/v/jPi861yQGNVxNTL75P1zc6FNlJ+vPlDY0vOYtCsP9vYlkVWV4KBhq7iJIFRmZJ61KgZNSyioK3yUzfocNtvUjhhSrn1xPEJ6TFOdBjpcP2qqfznYZOft7wK7Zcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VcxM377v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA95C4CECF;
	Fri,  8 Nov 2024 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081600;
	bh=PJpISRgI1ip7kwmpC70u88YBF9cuUKs77DEXwoiRGno=;
	h=From:To:Cc:Subject:Date:From;
	b=VcxM377vh3AeCou9zhpJ2oQrMaUXSolT6Xof2SqbjfOsnurLRDD5oIEHDRBptbg42
	 l8a01rtBK6HPFDJUHZCUbjepIfCsWK0ydNDr0kKVmnNpw2wq8l/5LP9Yh/wENDFldQ
	 sHtRikLxuktzOUkhbwvZX3YDOYqr/cZAk7H4m4Eo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.171
Date: Fri,  8 Nov 2024 16:59:28 +0100
Message-ID: <2024110829-sibling-charter-755e@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.171 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/riscv/kernel/asm-offsets.c                   |    2 
 arch/riscv/kernel/cpu-hotplug.c                   |    2 
 arch/riscv/kernel/efi-header.S                    |    2 
 arch/riscv/kernel/traps_misaligned.c              |    2 
 arch/riscv/kernel/vdso/Makefile                   |    1 
 arch/x86/include/asm/nospec-branch.h              |   11 +
 drivers/acpi/cppc_acpi.c                          |    9 -
 drivers/acpi/prmt.c                               |   33 ++-
 drivers/base/core.c                               |   13 -
 drivers/base/module.c                             |    4 
 drivers/firmware/arm_sdei.c                       |    2 
 drivers/gpu/drm/drm_mipi_dsi.c                    |    2 
 drivers/gpu/drm/i915/gem/i915_gem_context.c       |   24 ++
 drivers/iio/adc/ad7124.c                          |    2 
 drivers/iio/light/veml6030.c                      |    2 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c          |    4 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c        |   13 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h        |    2 
 drivers/infiniband/hw/cxgb4/provider.c            |    1 
 drivers/infiniband/hw/mlx5/qp.c                   |    4 
 drivers/misc/sgi-gru/grukservices.c               |    2 
 drivers/misc/sgi-gru/grumain.c                    |    4 
 drivers/misc/sgi-gru/grutlbpurge.c                |    2 
 drivers/net/ethernet/amd/mvme147.c                |    7 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   22 ++
 drivers/net/gtp.c                                 |   22 +-
 drivers/net/netdevsim/fib.c                       |    4 
 drivers/net/wireless/ath/ath10k/wmi-tlv.c         |    7 
 drivers/net/wireless/ath/ath10k/wmi.c             |    2 
 drivers/net/wireless/broadcom/brcm80211/Kconfig   |    1 
 drivers/net/wireless/intel/iwlegacy/common.c      |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c       |   22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c     |    3 
 drivers/scsi/scsi_transport_fc.c                  |    4 
 drivers/staging/iio/frequency/ad9832.c            |    7 
 drivers/tty/vt/vt.c                               |    2 
 drivers/usb/host/xhci-pci.c                       |    6 
 drivers/usb/host/xhci-ring.c                      |   16 -
 drivers/usb/phy/phy.c                             |    2 
 drivers/usb/typec/class.c                         |    1 
 fs/ksmbd/mgmt/user_session.c                      |   26 ++-
 fs/ksmbd/mgmt/user_session.h                      |    4 
 fs/ksmbd/server.c                                 |    2 
 fs/ksmbd/smb2pdu.c                                |    8 
 fs/nfs/delegation.c                               |    5 
 fs/nilfs2/namei.c                                 |    3 
 fs/nilfs2/page.c                                  |    1 
 fs/ntfs3/frecord.c                                |    4 
 fs/ntfs3/lznt.c                                   |    3 
 fs/ntfs3/namei.c                                  |    2 
 fs/ntfs3/ntfs_fs.h                                |    2 
 fs/ocfs2/file.c                                   |    8 
 include/acpi/cppc_acpi.h                          |    2 
 include/net/ip_tunnels.h                          |    2 
 include/net/mac80211.h                            |   10 +
 include/trace/events/kmem.h                       |   14 +
 kernel/bpf/lpm_trie.c                             |    2 
 kernel/cgroup/cgroup.c                            |    4 
 mm/internal.h                                     |   13 +
 mm/page_alloc.c                                   |  183 +++++++++++++---------
 mm/shmem.c                                        |    2 
 net/core/dev.c                                    |    4 
 net/mac80211/Kconfig                              |    2 
 net/mac80211/cfg.c                                |    3 
 net/mac80211/ieee80211_i.h                        |    3 
 net/mac80211/key.c                                |   42 +++--
 net/mac80211/mlme.c                               |   14 +
 net/mac80211/util.c                               |   45 ++++-
 net/netfilter/nft_payload.c                       |    3 
 net/netfilter/x_tables.c                          |    2 
 net/sched/sch_api.c                               |    2 
 sound/soc/codecs/cs42l51.c                        |    7 
 tools/testing/selftests/vm/hmm-tests.c            |    2 
 tools/usb/usbip/src/usbip_detach.c                |    1 
 75 files changed, 478 insertions(+), 227 deletions(-)

Alexandre Ghiti (1):
      riscv: vdso: Prevent the compiler from inserting calls to memset()

Andrew Ballance (1):
      fs/ntfs3: Check if more than chunk-size bytes are written

Aubrey Li (1):
      ACPI: PRM: Remove unnecessary blank lines

Basavaraj Natikar (1):
      xhci: Use pm_runtime_get to prevent RPM on unsupported systems

Benjamin Marzinski (1):
      scsi: scsi_transport_fc: Allow setting rport state to current state

Benoît Monin (1):
      net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension

Byeonguk Jeong (1):
      bpf: Fix out-of-bounds write in trie_get_next_key()

Christophe JAILLET (1):
      ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()

Chunyan Zhang (2):
      riscv: Remove unused GENERATING_ASM_OFFSETS
      riscv: Remove duplicated GET_RM

Dai Ngo (1):
      NFS: remove revoked delegation from server's delegation list

Daniel Gabay (1):
      wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()

Daniel Palmer (1):
      net: amd: mvme147: Fix probe banner message

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
      mm/page_alloc: call check_new_pages() while zone spinlock is not held

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
      Linux 5.15.171

Heinrich Schuchardt (1):
      riscv: efi: Set NX compat flag in PE/COFF header

Ido Schimmel (1):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_init_flow()

Jason-JH.Lin (1):
      Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"

Javier Carrasco (2):
      usb: typec: fix unreleased fwnode_handle in typec_port_register_altmodes()
      iio: light: veml6030: fix microlux value calculation

Jeongjun Park (2):
      mm: shmem: fix data-race in shmem_getattr()
      vt: prevent kernel-infoleak in con_font_get()

Johannes Berg (3):
      mac80211: do drv_reconfig_complete() before restarting all
      wifi: iwlwifi: mvm: fix 6 GHz scan construction
      mac80211: always have ieee80211_sta_restart()

Koba Ko (1):
      ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context

Konstantin Komarov (3):
      fs/ntfs3: Fix warning possible deadlock in ntfs_set_state
      fs/ntfs3: Fix possible deadlock in mi_read
      fs/ntfs3: Additional check in ni_clear()

Leon Romanovsky (1):
      RDMA/cxgb4: Dump vendor specific QP details

Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Matt Fleming (1):
      mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves

Mel Gorman (6):
      mm/page_alloc: split out buddy removal code from rmqueue into separate helper
      mm/page_alloc: rename ALLOC_HIGH to ALLOC_MIN_RESERVE
      mm/page_alloc: treat RT tasks similar to __GFP_HIGH
      mm/page_alloc: explicitly record high-order atomic allocations in alloc_flags
      mm/page_alloc: explicitly define what alloc flags deplete min reserves
      mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocations accesses reserves

Namjae Jeon (1):
      ksmbd: fix user-after-free from session log off

Pablo Neira Ayuso (2):
      gtp: allow -1 to be specified as file description from userspace
      netfilter: nft_payload: sanitize offset and length before calling skb_checksum()

Patrisious Haddad (1):
      RDMA/mlx5: Round max_rd_atomic/max_dest_rd_atomic up instead of down

Pawan Gupta (1):
      x86/bugs: Use code segment selector for VERW operand

Pedro Tammela (1):
      net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Pierre Gondois (1):
      ACPI: CPPC: Make rmw_lock a raw_spin_lock

Rob Clark (1):
      drm/i915: Fix potential context UAFs

Ryusuke Konishi (2):
      nilfs2: fix potential deadlock with newly created symlinks
      nilfs2: fix kernel bug due to missing clearing of checked flag

Selvin Xavier (1):
      RDMA/bnxt_re: synchronize the qp-handle table array

Sudeep Holla (1):
      ACPI: PRM: Change handler_addr type to void pointer

Ville Syrjälä (1):
      wifi: iwlegacy: Clear stale interrupts before resuming device

WangYuli (1):
      riscv: Use '%u' to format the output of 'cpu'

Wonhyuk Yang (1):
      mm/page_alloc: fix tracepoint mm_page_alloc_zone_locked()

Xiongfeng Wang (1):
      firmware: arm_sdei: Fix the input parameter of cpuhp_remove_state()

Xiu Jianfeng (1):
      cgroup: Fix potential overflow issue when checking max_depth

Youghandhar Chintala (1):
      mac80211: Add support to trigger sta disconnect on hardware restart

Zichen Xie (1):
      netdevsim: Add trailing zero to terminate the string in nsim_nexthop_bucket_activity_write()

Zicheng Qu (2):
      staging: iio: frequency: ad9832: fix division by zero in ad9832_calc_freqreg()
      iio: adc: ad7124: fix division by zero in ad7124_set_channel_odr()

Zijun Hu (1):
      usb: phy: Fix API devm_usb_put_phy() can not release the phy

Zongmin Zhou (1):
      usbip: tools: Fix detach_port() invalid port error path


