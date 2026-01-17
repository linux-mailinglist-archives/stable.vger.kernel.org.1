Return-Path: <stable+bounces-210171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634ED38F92
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 16:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CB9E300F242
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E821523BCFF;
	Sat, 17 Jan 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wpWevKoK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F51236A8B;
	Sat, 17 Jan 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768664865; cv=none; b=Jh5jRqntQuxi9ZxvyjnDSfymbK5liMCYs+nkoKQQ9ECBhNv7395l6HXGp4XFwFLjucrU5Skiitab6/1YzXBfq9NKrP4tfEQm78ZhrVy13DKEJikJKTRkS2xuq2zliPZpua6xUZbSwkuOZDKKqWjXRZgC9KEIdF/fnFXvx2ENYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768664865; c=relaxed/simple;
	bh=zARmk6vI5xogA0nHcwmn8Oyga8EcezVEvwn+2C8PdOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SY07GLSQsh8/SHT7O/mkkpfRrt1wdjzW0gKsgLLDNuLf1IU7aLOWclysGuSyBf+hjci/WNIPIqeArVGXdn2ubLzB5DUwVQIKLH4uSf2i7BRh4O1u8pmznCDlL6UtY8zDyx/Q41IoHmVnBlJAEgJoOZZmxADlDLLiepIxrG6THW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wpWevKoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1721C4CEF7;
	Sat, 17 Jan 2026 15:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768664865;
	bh=zARmk6vI5xogA0nHcwmn8Oyga8EcezVEvwn+2C8PdOA=;
	h=From:To:Cc:Subject:Date:From;
	b=wpWevKoK+uhEo6W4NaL9NLl3TMgdE7WZgsu4XCfmp+HS1ns0YFPFLIqC8iLxB9bDC
	 3A5hD4NeKM1zAD4k3Aby8xxx+hPITzfrWQd/KI1HzFif9YmY3McDJVRUz80rYPEiAc
	 pzhbbjujUpIs3OG6AAngp4ADMFpD39XIpDbTDjmk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.66
Date: Sat, 17 Jan 2026 16:47:37 +0100
Message-ID: <2026011738-dance-cradle-5e98@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.66 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/alpha/include/uapi/asm/ioctls.h                          |    8 
 arch/arm/Kconfig                                              |    2 
 arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi                     |    2 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi           |    1 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                  |    1 
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi              |    8 
 arch/arm64/boot/dts/freescale/mba8mx.dtsi                     |    2 
 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso                |    2 
 arch/arm64/include/asm/suspend.h                              |    2 
 arch/arm64/mm/proc.S                                          |    8 
 arch/csky/mm/fault.c                                          |    4 
 arch/riscv/include/asm/pgtable.h                              |    4 
 drivers/ata/libata-core.c                                     |    3 
 drivers/atm/he.c                                              |    3 
 drivers/char/tpm/tpm2-cmd.c                                   |   23 +
 drivers/char/tpm/tpm2-sessions.c                              |  114 +++++---
 drivers/counter/104-quad-8.c                                  |   20 +
 drivers/counter/interrupt-cnt.c                               |    3 
 drivers/crypto/intel/qat/qat_common/adf_aer.c                 |    2 
 drivers/gpio/gpio-pca953x.c                                   |   55 +++-
 drivers/gpio/gpio-rockchip.c                                  |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                       |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c                   |    2 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                   |   18 +
 drivers/gpu/drm/amd/display/dc/dml2/Makefile                  |   22 +
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c     |   11 
 drivers/gpu/drm/amd/display/include/audio_types.h             |   12 
 drivers/gpu/drm/pl111/pl111_drv.c                             |    2 
 drivers/gpu/drm/radeon/pptable.h                              |    2 
 drivers/gpu/drm/xe/xe_gt_idle.c                               |   20 +
 drivers/gpu/drm/xe/xe_gt_idle.h                               |    2 
 drivers/gpu/drm/xe/xe_guc_pc.c                                |   10 
 drivers/gpu/drm/xe/xe_pm.c                                    |    8 
 drivers/hid/hid-quirks.c                                      |    9 
 drivers/md/dm-exception-store.h                               |    2 
 drivers/md/dm-snap.c                                          |   73 ++---
 drivers/misc/mei/hw-me-regs.h                                 |    2 
 drivers/misc/mei/pci-me.c                                     |    2 
 drivers/net/ethernet/3com/3c59x.c                             |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                     |   15 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                     |    4 
 drivers/net/ethernet/freescale/enetc/enetc.h                  |    4 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                    |   19 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                   |    8 
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                   |    1 
 drivers/net/ethernet/marvell/prestera/prestera_devlink.c      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/port.c                |    3 
 drivers/net/ethernet/mscc/ocelot.c                            |    6 
 drivers/net/netdevsim/bus.c                                   |    8 
 drivers/net/phy/sfp.c                                         |    2 
 drivers/net/usb/pegasus.c                                     |    2 
 drivers/net/wwan/iosm/iosm_ipc_mux.c                          |    6 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                      |    2 
 drivers/powercap/powercap_sys.c                               |   22 +
 drivers/scsi/ipr.c                                            |   28 ++
 drivers/scsi/libsas/sas_internal.h                            |   14 -
 drivers/scsi/sg.c                                             |   20 +
 drivers/spi/spi-cadence-quadspi.c                             |   10 
 drivers/spi/spi-mt65xx.c                                      |    2 
 drivers/ufs/core/ufshcd.c                                     |   36 ++
 fs/btrfs/disk-io.c                                            |    1 
 fs/btrfs/extent_io.c                                          |   68 ++++-
 fs/btrfs/fs.h                                                 |    7 
 fs/btrfs/inode.c                                              |   29 +-
 fs/btrfs/ordered-data.c                                       |    5 
 fs/btrfs/qgroup.c                                             |   21 +
 fs/btrfs/subpage.c                                            |  129 ++++++----
 fs/btrfs/super.c                                              |   12 
 fs/btrfs/tree-log.c                                           |    6 
 fs/erofs/super.c                                              |   19 +
 fs/nfs/namespace.c                                            |    5 
 fs/nfs/nfs4proc.c                                             |   13 -
 fs/nfs/nfs4trace.h                                            |    1 
 fs/nfs_common/common.c                                        |    1 
 fs/nfsd/netns.h                                               |    2 
 fs/nfsd/nfs4proc.c                                            |    2 
 fs/nfsd/nfs4state.c                                           |   49 +++
 fs/nfsd/nfsctl.c                                              |   12 
 fs/nfsd/nfsd.h                                                |    1 
 fs/nfsd/nfssvc.c                                              |   30 +-
 fs/nfsd/state.h                                               |    6 
 fs/nfsd/vfs.c                                                 |    4 
 fs/smb/client/nterr.h                                         |    6 
 include/linux/netdevice.h                                     |    3 
 include/linux/tpm.h                                           |   13 -
 include/net/netfilter/nf_tables.h                             |   34 ++
 include/trace/events/btrfs.h                                  |   51 +--
 include/trace/misc/nfs.h                                      |    2 
 include/uapi/linux/nfs.h                                      |    1 
 lib/crypto/aes.c                                              |    4 
 net/bpf/test_run.c                                            |   60 +++-
 net/bridge/br_vlan_tunnel.c                                   |   11 
 net/can/j1939/transport.c                                     |    2 
 net/ceph/messenger_v2.c                                       |    2 
 net/ceph/mon_client.c                                         |    2 
 net/ceph/osd_client.c                                         |   14 -
 net/ceph/osdmap.c                                             |   24 +
 net/core/skbuff.c                                             |    8 
 net/core/sock.c                                               |    7 
 net/ipv4/arp.c                                                |    7 
 net/ipv4/ping.c                                               |    4 
 net/mac80211/tx.c                                             |    2 
 net/netfilter/nf_conncount.c                                  |    2 
 net/netfilter/nf_tables_api.c                                 |   72 +++++
 net/netfilter/nft_set_pipapo.c                                |    4 
 net/netfilter/nft_synproxy.c                                  |    6 
 net/sched/sch_qfq.c                                           |    2 
 net/tls/tls_device.c                                          |   18 -
 net/vmw_vsock/af_vsock.c                                      |    4 
 net/wireless/wext-core.c                                      |    4 
 net/wireless/wext-priv.c                                      |    4 
 security/keys/trusted-keys/trusted_tpm2.c                     |   29 +-
 sound/ac97/bus.c                                              |   32 +-
 sound/hda/intel-dsp-config.c                                  |    3 
 sound/pci/hda/patch_realtek.c                                 |    1 
 sound/soc/amd/yc/acp6x-mach.c                                 |    7 
 sound/soc/fsl/fsl_sai.c                                       |    3 
 sound/soc/rockchip/rockchip_pdm.c                             |    2 
 sound/usb/quirks.c                                            |   10 
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c      |   96 ++++++-
 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c |    4 
 tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c |    8 
 123 files changed, 1161 insertions(+), 519 deletions(-)

Alan Liu (1):
      drm/amdgpu: Fix query for VPE block_type and ip_count

Alex Deucher (1):
      drm/radeon: Remove __counted_by from ClockInfoArray.clockInfo[]

Alexander Stein (2):
      arm64: dts: mba8mx: Fix Ethernet PHY IRQ support
      ASoC: fsl_sai: Add missing registers to cache default

Alexander Sverdlin (1):
      counter: interrupt-cnt: Drop IRQF_NO_THREAD flag

Alexander Usyskin (1):
      mei: me: add nova lake point S DID

Alexandre Knecht (1):
      bridge: fix C-VLAN preservation in 802.1ad vlan_tunnel egress

Alok Tiwari (1):
      net: marvell: prestera: fix NULL dereference on devlink_alloc() failure

Amery Hung (2):
      bpf: Make variables in bpf_prog_test_run_xdp less confusing
      bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN

Andrew Elantsev (1):
      ASoC: amd: yc: Add quirk for Honor MagicBook X16 2025

Bartosz Golaszewski (2):
      gpio: rockchip: mark the GPIO controller as sleeping
      pinctrl: qcom: lpass-lpi: mark the GPIO controller as sleeping

Boris Burkov (1):
      btrfs: fix qgroup_snapshot_quick_inherit() squota bug

Brian Kao (1):
      scsi: ufs: core: Fix EH failure after W-LUN resume error

Brian Kocoloski (1):
      drm/amdkfd: Fix improper NULL termination of queue restore SMI event string

Charlene Liu (1):
      drm/amd/display: Fix DP no audio issue

ChenXiaoSong (3):
      smb/client: fix NT_STATUS_UNABLE_TO_FREE_VM value
      smb/client: fix NT_STATUS_DEVICE_DOOR_OPEN value
      smb/client: fix NT_STATUS_NO_DATA_DETECTED value

Chuck Lever (1):
      NFSD: Remove NFSERR_EAGAIN

Di Zhu (1):
      netdev: preserve NETIF_F_ALL_FOR_ALL across TSO updates

Edward Adam Davis (1):
      NFSD: net ref data still needs to be freed even if net hasn't startup

Emil Tantilov (2):
      idpf: keep the netdev when a reset fails
      idpf: fix memory leak in idpf_vport_rel()

Eric Biggers (1):
      lib/crypto: aes: Fix missing MMU protection for AES S-box

Eric Dumazet (2):
      wifi: avoid kernel-infoleak from struct iw_point
      arp: do not assume dev_hard_header() does not change skb->head

Ernest Van Hoecke (1):
      gpio: pca953x: handle short interrupt pulses on PCAL devices

Fei Shao (1):
      spi: mt65xx: Use IRQF_ONESHOT with threaded IRQ

Fernando Fernandez Mancera (2):
      netfilter: nft_synproxy: avoid possible data-race on update operation
      netfilter: nf_conncount: update last_gc only when GC has been performed

Filipe Manana (4):
      btrfs: always detect conflicting inodes when logging inode refs
      btrfs: tracepoints: use btrfs_root_id() to get the id of a root
      btrfs: truncate ordered extent when skipping writeback past i_size
      btrfs: use variable for end offset in extent_writepage_io()

Florian Westphal (2):
      netfilter: nft_set_pipapo: fix range overlap detection
      netfilter: nf_tables: avoid chain re-validation if possible

Gal Pressman (1):
      net/mlx5e: Don't print error message due to invalid module

Gao Xiang (2):
      erofs: don't bother with s_stack_depth increasing for now
      erofs: fix file-backed mounts no longer working on EROFS partitions

Greg Kroah-Hartman (1):
      Linux 6.12.66

Guo Ren (Alibaba DAMO Academy) (1):
      riscv: pgtable: Cleanup useless VA_USER_XXX definitions

Haibo Chen (1):
      arm64: dts: add off-on-delay-us for usdhc2 regulator

Haotian Zhang (1):
      counter: 104-quad-8: Fix incorrect return value in IRQ handler

Haoxiang Li (1):
      ALSA: ac97: fix a double free in snd_ac97_controller_register()

Harshita Bhilwaria (1):
      crypto: qat - fix duplicate restarting msg during AER error

Ian Ray (1):
      ARM: dts: imx6q-ba16: fix RTC interrupt level

Ilya Dryomov (3):
      libceph: replace overzealous BUG_ON in osdmap_apply_incremental()
      libceph: return the handler error from mon_handle_auth_done()
      libceph: make calc_target() set t->paused, not just clear it

Jarkko Sakkinen (1):
      tpm2-sessions: Fix out of range indexing in name_size

Jerry Wu (1):
      net: mscc: ocelot: Fix crash when adding interface under a lag

Johannes Berg (1):
      wifi: mac80211: restore non-chanctx injection behaviour

Joshua Hay (1):
      idpf: cap maximum Rx buffer size

Jussi Laako (1):
      ALSA: usb-audio: Update for native DSD support quirks

Kai Vehmanen (1):
      ALSA: hda/realtek: enable woofer speakers on Medion NM14LNL

Krzysztof Kozlowski (1):
      ASoC: rockchip: Fix Wvoid-pointer-to-enum-cast warning (again)

Kuniyuki Iwashima (1):
      tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Marcus Hughes (1):
      net: sfp: extend Potron XGSPON quirk to cover additional EEPROM variant

Marek Vasut (1):
      arm64: dts: imx8mp: Fix LAN8740Ai PHY reference clock on DH electronics i.MX8M Plus DHCOM

Mateusz Litwin (1):
      spi: cadence-quadspi: Prevent lost complete() call during indirect read

Miaoqian Lin (1):
      drm/pl111: Fix error handling in pl111_amba_probe

Michal Luczaj (1):
      vsock: Make accept()ed sockets use custom setsockopt()

Michal Rábek (1):
      scsi: sg: Fix occasional bogus elapsed time that exceeds timeout

Mikulas Patocka (1):
      dm-snapshot: fix 'scheduling while atomic' on real-time kernels

Miquel Sabaté Solà (1):
      btrfs: fix NULL dereference on root when tracing inode eviction

Mohammad Heib (1):
      net: fix memory leak in skb_segment_list for GRO packets

Nathan Chancellor (2):
      drm/amd/display: Respect user's CONFIG_FRAME_WARN more for dml files
      drm/amd/display: Apply e4479aecf658 to dml

NeilBrown (2):
      nfsd: provide locking for v4_end_grace
      nfsd: use correct loop termination in nfsd4_revoke_states()

Niklas Cassel (1):
      ata: libata-core: Disable LPM on ST2000DM008-2FR102

Olga Kornievskaia (1):
      nfsd: check that server is running in unlock_filesystem

Petko Manolov (1):
      net: usb: pegasus: fix memory leak in update_eth_regs_async()

Potin Lai (1):
      gpio: pca953x: Add support for level-triggered interrupts

Qu Wenruo (7):
      btrfs: qgroup: update all parent qgroups when doing quick inherit
      btrfs: only enforce free space tree if v1 cache is required for bs < ps cases
      btrfs: fix error handling of submit_uncompressed_range()
      btrfs: subpage: dump the involved bitmap when ASSERT() failed
      btrfs: add extra error messages for delalloc range related errors
      btrfs: remove btrfs_fs_info::sectors_per_page
      btrfs: fix beyond-EOF write handling

René Rebe (1):
      HID: quirks: work around VID/PID conflict for appledisplay

Rosen Penev (1):
      drm/amd/display: shrink struct members

Sam Edwards (1):
      libceph: reset sparse-read state in osd_fault()

Sam James (1):
      alpha: don't reference obsolete termio struct for TC* constants

Scott Mayhew (2):
      NFSD: Fix permission check for read access to executable-only files
      NFSv4: ensure the open stateid seqid doesn't go backwards

Sebastian Andrzej Siewior (1):
      ARM: 9461/1: Disable HIGHPTE on PREEMPT_RT kernels

Shardul Bankar (1):
      bpf: test_run: Fix ctx leak in bpf_prog_test_run_xdp error path

Sherry Sun (1):
      arm64: dts: imx8qm-ss-dma: correct the dma channels of lpuart

Srijit Bose (1):
      bnxt_en: Fix potential data corruption with HW GRO/LRO

Sumeet Pawnikar (2):
      powercap: fix race condition in register_control_type()
      powercap: fix sscanf() error return value handling

Takashi Iwai (2):
      ALSA: ac97bus: Use guard() for mutex locks
      ALSA: hda: intel-dsp-config: Prefer legacy driver as fallback

Tetsuo Handa (2):
      bpf: Fix reference count leak in bpf_prog_test_run_xdp()
      can: j1939: make j1939_session_activate() fail if device is no longer registered

Thomas Fourier (2):
      atm: Fix dma_free_coherent() size
      net: 3com: 3c59x: fix possible null dereference in vortex_probe1()

Toke Høiland-Jørgensen (1):
      bpf, test_run: Subtract size of xdp_frame from allowed metadata size

Trond Myklebust (1):
      NFS: Fix up the automount fs_context to use the correct cred

Tuo Li (1):
      libceph: make free_choose_arg_map() resilient to partial allocation

Wadim Egorov (1):
      arm64: dts: ti: k3-am62-lp-sk-nand: Rename pinctrls to fix schema warnings

Wei Fang (1):
      net: enetc: fix build warning when PAGE_SIZE is greater than 128K

Weiming Shi (1):
      net: sock: fix hardened usercopy panic in sock_recv_errqueue

Wen Xiong (1):
      scsi: ipr: Enable/disable IRQD_NO_BALANCING during reset

Xiang Mei (1):
      net/sched: sch_qfq: Fix NULL deref when deactivating inactive aggregate in qfq_reset

Xin Wang (2):
      drm/xe: make xe_gt_idle_disable_c6() handle the forcewake internally
      drm/xe: Ensure GT is in C0 during resumes

Xingui Yang (1):
      scsi: Revert "scsi: libsas: Fix exp-attached device scan after probe failure scanned in again after probe failed"

Yang Li (1):
      csky: fix csky_cmpxchg_fixup not working

Yeoreum Yun (1):
      arm64: Fix cleared E0POE bit after cpu_suspend()/resume()

Yohei Kojima (1):
      net: netdevsim: fix inconsistent carrier state after link/unlink

Yonghong Song (1):
      bpf: Fix an issue in bpf_prog_test_run_xdp when page size greater than 4K

Zilin Guan (2):
      netfilter: nf_tables: fix memory leak in nf_tables_newrule()
      net: wwan: iosm: Fix memory leak in ipc_mux_deinit()

yuan.gao (1):
      inet: ping: Fix icmp out counting

ziming zhang (1):
      libceph: prevent potential out-of-bounds reads in handle_auth_done()


