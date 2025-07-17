Return-Path: <stable+bounces-163288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0A0B092AE
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E13188ABC5
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63F22FF481;
	Thu, 17 Jul 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nb/P8N+C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7A2FD89E;
	Thu, 17 Jul 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771869; cv=none; b=tB77oxqTPHCy9/UuTNmispOB0DHmME84kCMlV0usF3stQk3nN4SXmMlwtIEiODWYgoh4auVv4H6bzw9YwiE1vATBgJolv8VOqHzaWWBd41aO18OBSydhzK13oU29IJuBSRfAt10EVNTDDKDNhX6Nbyxqrk+YccQnMlJaiO2ete8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771869; c=relaxed/simple;
	bh=kc0JAnZ8F9h8n1K/UGNHOkV3kerLQLU4qXPspnHWKyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sOpu8j0GjRiE5oGU5ENrmeLwcYUq7u2AH1BFkZH9ynNswtYm/JH1YxEkJWGkrjSQ7wgRiGQAdkubrEAwwn6hwp0DTT7Fyu3JjLdwfSSKQec8QtE/dSMIu7iBgON84v6oTV9eVE70+XbwT1IaTAXhzrgPSnxG3hMx3V5AEoI5Olg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nb/P8N+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9440AC4CEE3;
	Thu, 17 Jul 2025 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771869;
	bh=kc0JAnZ8F9h8n1K/UGNHOkV3kerLQLU4qXPspnHWKyM=;
	h=From:To:Cc:Subject:Date:From;
	b=nb/P8N+Cbh3Ckoh5KKvw++L1OX4HsAJ6NgGKLERUMlyUY/kJW4L7ZJO9q9yUlrcB6
	 8noa0yTCnCLh5+XqKAZff6S7WCner4M9zkFhrhqE370AB7BsQ8fbEwSzK0wwHqajtL
	 lyN8jYhFnOq9BYDoAvyq6fSiYz944i7F57j8vook=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.39
Date: Thu, 17 Jul 2025 19:04:15 +0200
Message-ID: <2025071716-try-static-9924@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.39 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/bpf/map_hash.rst                       |    8 
 Documentation/bpf/map_lru_hash_update.dot            |    6 
 Makefile                                             |    2 
 arch/arm64/kernel/cpufeature.c                       |   45 +--
 arch/arm64/kernel/process.c                          |    5 
 arch/arm64/mm/fault.c                                |   30 +-
 arch/riscv/kernel/vdso/vdso.lds.S                    |    2 
 arch/s390/crypto/sha1_s390.c                         |    2 
 arch/s390/crypto/sha256_s390.c                       |    3 
 arch/s390/crypto/sha512_s390.c                       |    3 
 arch/um/drivers/vector_kern.c                        |   42 ---
 arch/x86/Kconfig                                     |    2 
 arch/x86/include/asm/msr-index.h                     |    1 
 arch/x86/kernel/cpu/amd.c                            |    7 
 arch/x86/kernel/cpu/mce/amd.c                        |   28 +-
 arch/x86/kernel/cpu/mce/core.c                       |   24 -
 arch/x86/kernel/cpu/mce/intel.c                      |    1 
 arch/x86/kvm/cpuid.c                                 |    4 
 arch/x86/kvm/svm/sev.c                               |    4 
 arch/x86/kvm/xen.c                                   |   15 -
 crypto/ecc.c                                         |    2 
 drivers/acpi/battery.c                               |   19 -
 drivers/atm/idt77252.c                               |    5 
 drivers/block/nbd.c                                  |    6 
 drivers/block/ublk_drv.c                             |    3 
 drivers/bluetooth/hci_qca.c                          |   13 
 drivers/char/ipmi/ipmi_msghandler.c                  |    3 
 drivers/clk/clk-scmi.c                               |   18 -
 drivers/clk/imx/clk-imx95-blk-ctl.c                  |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c        |   30 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c             |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h             |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                 |   43 +--
 drivers/gpu/drm/drm_framebuffer.c                    |   31 ++
 drivers/gpu/drm/drm_gem.c                            |   74 ++++-
 drivers/gpu/drm/drm_internal.h                       |    2 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c           |    4 
 drivers/gpu/drm/imagination/pvr_power.c              |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c       |   20 +
 drivers/gpu/drm/tegra/nvdec.c                        |    6 
 drivers/gpu/drm/ttm/ttm_bo_util.c                    |   13 
 drivers/gpu/drm/xe/xe_gt_pagefault.c                 |    1 
 drivers/gpu/drm/xe/xe_lmtt.c                         |   11 
 drivers/gpu/drm/xe/xe_migrate.c                      |    2 
 drivers/gpu/drm/xe/xe_pci.c                          |    1 
 drivers/gpu/drm/xe/xe_pm.c                           |    8 
 drivers/hid/hid-ids.h                                |    6 
 drivers/hid/hid-lenovo.c                             |    8 
 drivers/hid/hid-multitouch.c                         |    8 
 drivers/hid/hid-nintendo.c                           |   38 ++
 drivers/hid/hid-quirks.c                             |    3 
 drivers/irqchip/Kconfig                              |    1 
 drivers/md/md-bitmap.c                               |    3 
 drivers/md/raid1.c                                   |    1 
 drivers/md/raid10.c                                  |   10 
 drivers/net/can/m_can/m_can.c                        |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c            |   10 
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c        |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c        |    2 
 drivers/net/ethernet/ibm/ibmvnic.h                   |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h      |    9 
 drivers/net/ethernet/mellanox/mlx5/core/en_dim.c     |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c    |   13 
 drivers/net/ethernet/microsoft/mana/gdma_main.c      |    3 
 drivers/net/ethernet/renesas/rtsn.c                  |    5 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c   |   24 -
 drivers/net/ethernet/ti/am65-cpsw-nuss.c             |    4 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c          |   16 -
 drivers/net/ethernet/wangxun/libwx/wx_type.h         |    2 
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c        |    2 
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h        |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c       |    4 
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h      |    4 
 drivers/net/ethernet/xilinx/ll_temac_main.c          |    2 
 drivers/net/phy/microchip.c                          |    3 
 drivers/net/phy/qcom/at803x.c                        |   27 --
 drivers/net/phy/qcom/qca808x.c                       |    2 
 drivers/net/phy/qcom/qcom-phy-lib.c                  |   25 +
 drivers/net/phy/qcom/qcom.h                          |    5 
 drivers/net/phy/smsc.c                               |   57 +++-
 drivers/net/usb/qmi_wwan.c                           |    1 
 drivers/net/wireless/marvell/mwifiex/util.c          |    4 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/init.c     |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c     |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h     |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c       |    4 
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h       |    2 
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c         |    6 
 drivers/pci/pci-acpi.c                               |   23 -
 drivers/pinctrl/pinctrl-amd.c                        |   11 
 drivers/pinctrl/qcom/pinctrl-msm.c                   |   20 +
 drivers/pwm/core.c                                   |    2 
 drivers/pwm/pwm-mediatek.c                           |   13 
 drivers/tty/vt/vt.c                                  |    1 
 drivers/usb/gadget/function/u_serial.c               |   12 
 fs/btrfs/free-space-tree.c                           |   16 -
 fs/erofs/data.c                                      |   21 +
 fs/erofs/decompressor.c                              |   12 
 fs/erofs/fileio.c                                    |    6 
 fs/erofs/internal.h                                  |    2 
 fs/erofs/zdata.c                                     |  251 ++++++++----------
 fs/erofs/zutil.c                                     |    7 
 fs/eventpoll.c                                       |   12 
 fs/netfs/write_collect.c                             |    2 
 fs/proc/inode.c                                      |    2 
 fs/proc/proc_sysctl.c                                |   18 -
 fs/proc/task_mmu.c                                   |   14 -
 fs/smb/server/smb2pdu.c                              |   29 --
 fs/smb/server/transport_rdma.c                       |    5 
 fs/smb/server/vfs.c                                  |    1 
 include/drm/drm_file.h                               |    3 
 include/drm/drm_framebuffer.h                        |    7 
 include/drm/spsc_queue.h                             |    4 
 include/linux/ieee80211.h                            |   45 ++-
 include/linux/math.h                                 |   12 
 include/linux/mm.h                                   |    5 
 include/linux/psp-sev.h                              |    2 
 include/net/af_vsock.h                               |    2 
 include/net/netfilter/nf_flow_table.h                |    2 
 include/sound/soc-acpi.h                             |   13 
 include/trace/events/erofs.h                         |    2 
 io_uring/opdef.c                                     |    1 
 kernel/bpf/bpf_lru_list.c                            |    9 
 kernel/bpf/bpf_lru_list.h                            |    1 
 kernel/events/core.c                                 |    6 
 kernel/rseq.c                                        |   60 +++-
 kernel/sched/core.c                                  |    5 
 kernel/sched/deadline.c                              |   10 
 kernel/stop_machine.c                                |   20 -
 lib/alloc_tag.c                                      |    3 
 lib/maple_tree.c                                     |    1 
 mm/kasan/report.c                                    |   13 
 mm/vmalloc.c                                         |   22 +
 net/appletalk/ddp.c                                  |    1 
 net/atm/clip.c                                       |   64 +++-
 net/bluetooth/hci_event.c                            |    3 
 net/bluetooth/hci_sync.c                             |    2 
 net/ipv4/tcp.c                                       |    2 
 net/ipv6/addrconf.c                                  |    9 
 net/mac80211/mlme.c                                  |    7 
 net/mac80211/parse.c                                 |    6 
 net/netlink/af_netlink.c                             |   82 +++---
 net/rxrpc/call_accept.c                              |    4 
 net/sched/sch_api.c                                  |   23 +
 net/tipc/topsrv.c                                    |    2 
 net/vmw_vsock/af_vsock.c                             |   57 +++-
 net/wireless/nl80211.c                               |    7 
 net/wireless/util.c                                  |   52 +++
 rust/kernel/init/macros.rs                           |    2 
 scripts/gdb/linux/constants.py.in                    |    7 
 scripts/gdb/linux/interrupts.py                      |   16 -
 scripts/gdb/linux/mapletree.py                       |  252 +++++++++++++++++++
 scripts/gdb/linux/xarray.py                          |   28 ++
 sound/isa/ad1816a/ad1816a.c                          |    2 
 sound/pci/hda/patch_realtek.c                        |    7 
 sound/soc/amd/yc/acp6x-mach.c                        |    7 
 sound/soc/codecs/cs35l56-shared.c                    |    2 
 sound/soc/fsl/fsl_asrc.c                             |    3 
 sound/soc/fsl/fsl_sai.c                              |   14 -
 sound/soc/intel/boards/Kconfig                       |    1 
 sound/soc/intel/common/Makefile                      |    2 
 sound/soc/intel/common/soc-acpi-intel-arl-match.c    |   66 ++++
 sound/soc/intel/common/sof-function-topology-lib.c   |  136 ++++++++++
 sound/soc/intel/common/sof-function-topology-lib.h   |   15 +
 sound/soc/sof/intel/hda.c                            |    6 
 tools/arch/x86/include/asm/msr-index.h               |    1 
 tools/include/linux/kallsyms.h                       |    4 
 tools/testing/selftests/bpf/test_lru_map.c           |  105 +++----
 tools/testing/selftests/net/forwarding/lib.sh        |  113 --------
 tools/testing/selftests/net/lib.sh                   |  115 ++++++++
 virt/kvm/kvm_main.c                                  |    3 
 176 files changed, 2012 insertions(+), 874 deletions(-)

Achill Gilgenast (1):
      kallsyms: fix build without execinfo

Akira Inoue (1):
      HID: lenovo: Add support for ThinkPad X1 Tablet Thin Keyboard Gen2

Al Viro (2):
      fix proc_sys_compare() handling of in-lookup dentries
      ksmbd: fix a mount write count leak in ksmbd_vfs_kern_path_locked()

Alessio Belle (1):
      drm/imagination: Fix kernel crash when hard resetting the GPU

Alexander Gordeev (1):
      mm/vmalloc: leave lazy MMU mode on PTE mapping error

Alok Tiwari (1):
      net: ll_temac: Fix missing tx_pending check in ethtools_set_ringparam()

Arun Raghavan (1):
      ASoC: fsl_sai: Force a software reset when starting in consumer mode

Baolin Wang (1):
      mm: fix the inaccurate memory statistics issue for users

Bard Liao (4):
      ASoC: Intel: SND_SOC_INTEL_SOF_BOARD_HELPERS select SND_SOC_ACPI_INTEL_MATCH
      ASoC: soc-acpi: add get_function_tplg_files ops
      ASoC: Intel: add sof_sdw_get_tplg_files ops
      ASoC: Intel: soc-acpi-intel-arl-match: set get_function_tplg_files ops

Bartosz Golaszewski (1):
      pinctrl: qcom: msm: mark certain pins as invalid for interrupts

Ben Skeggs (1):
      drm/nouveau/gsp: fix potential leak of memory used during acpi init

Borislav Petkov (AMD) (1):
      KVM: SVM: Set synthesized TSA CPUID flags

Carolina Jubran (1):
      net/mlx5e: Fix race between DIM disable and net_dim()

Chao Yu (2):
      erofs: fix to add missing tracepoint in erofs_read_folio()
      erofs: fix to add missing tracepoint in erofs_readahead()

Charles Keepax (1):
      ASoC: Intel: soc-acpi: arl: Correct order of cs42l43 matches

Chia-Lin Kao (AceLan) (1):
      HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras

Chintan Vankar (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix skb size by accounting for skb_shared_info

Christian König (1):
      drm/ttm: fix error handling in ttm_buffer_object_transfer

Chunhai Guo (1):
      erofs: free pclusters if no cached folio is attached

Dan Carpenter (1):
      ipmi:msghandler: Fix potential memory corruption in ipmi_create_user()

Daniel J. Ogorchock (1):
      HID: nintendo: avoid bluetooth suspend/resume stalls

Daniil Dulov (1):
      wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()

David Howells (3):
      rxrpc: Fix bug due to prealloc collision
      rxrpc: Fix oops due to non-existence of prealloc backlog struct
      netfs: Fix ref leak on inserted extra subreq in write retry

David Woodhouse (1):
      KVM: x86/xen: Allow 'out of range' event channel ports in IRQ routing table.

Deren Wu (2):
      wifi: mt76: mt7921: prevent decap offload config before STA initialization
      wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_sta_set_decap_offload()

Eric Biggers (1):
      crypto: s390/sha - Fix uninitialized variable in SHA-1 and SHA-2

Eric Dumazet (1):
      netfilter: flowtable: account for Ethernet header in nf_flow_pppoe_proto()

EricChan (1):
      net: stmmac: Fix interrupt handling for level-triggered mode in DWC_XGMAC2

Fangrui Song (1):
      riscv: vdso: Exclude .rodata from the PT_DYNAMIC segment

Felix Fietkau (1):
      wifi: rt2x00: fix remove callback type mismatch

Fengnan Chang (1):
      io_uring: make fallocate be hashed work

Filipe Manana (1):
      btrfs: fix assertion when building free space tree

Flora Cui (2):
      drm/amdgpu/discovery: use specific ip_discovery.bin for legacy asics
      drm/amdgpu/ip_discovery: add missing ip_discovery fw

Florian Fainelli (3):
      scripts/gdb: fix interrupts display after MCP on x86
      scripts/gdb: de-reference per-CPU MCE interrupts
      scripts/gdb: fix interrupts.py after maple tree conversion

Gao Xiang (5):
      erofs: address D-cache aliasing
      erofs: get rid of `z_erofs_next_pcluster_t`
      erofs: tidy up zdata.c
      erofs: refine readahead tracepoint
      erofs: fix rare pcluster memory leak after unmounting

Greg Kroah-Hartman (1):
      Linux 6.12.39

Guillaume Nault (1):
      gre: Fix IPv6 multicast route creation.

Hangbin Liu (1):
      selftests: net: lib: fix shift count out of range

Haoxiang Li (1):
      net: ethernet: rtsn: Fix a null pointer dereference in rtsn_probe()

Harry Yoo (1):
      lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()

Henry Martin (1):
      wifi: mt76: mt7925: Fix null-ptr-deref in mt7925_thermal_init()

Håkon Bugge (1):
      md/md-bitmap: fix GPF in bitmap_get_stats()

JP Kobryn (1):
      x86/mce: Make sure CMCI banks are cleared during shutdown on Intel

Jakub Kicinski (1):
      netlink: make sure we allow at least one dump skb

Jann Horn (1):
      x86/mm: Disable hugetlb page table sharing on 32-bit

Jason Xing (1):
      bnxt_en: eliminate the compile warning in bnxt_request_irq due to CONFIG_RFS_ACCEL

Jianbo Liu (1):
      net/mlx5e: Add new prio for promiscuous mode

Jiawen Wu (1):
      net: wangxun: revert the adjustment of the IRQ vector sequence

Jiayuan Chen (1):
      tcp: Correct signedness in skb remaining space calculation

Johannes Berg (1):
      wifi: mac80211: fix non-transmitted BSSID profile search

Kaustabh Chakraborty (1):
      drm/exynos: exynos7_drm_decon: add vblank check in IRQ handling

Kevin Brodsky (1):
      arm64: poe: Handle spurious Overlay faults

Kito Xu (1):
      net: appletalk: Fix device refcount leak in atrtr_create()

Kuen-Han Tsai (2):
      usb: gadget: u_serial: Fix race condition in TTY wakeup
      Revert "usb: gadget: u_serial: Add null pointer check in gs_start_io"

Kuniyuki Iwashima (6):
      netlink: Fix wraparounds of sk->sk_rmem_alloc.
      tipc: Fix use-after-free in tipc_conn_close().
      atm: clip: Fix potential null-ptr-deref in to_atmarpd().
      atm: clip: Fix memory leak of struct clip_vcc.
      atm: clip: Fix infinite recursive call of clip_push().
      netlink: Fix rmem check in netlink_broadcast_deliver().

Lachlan Hodges (2):
      wifi: cfg80211: fix S1G beacon head validation in nl80211
      wifi: mac80211: correctly identify S1G short beacon

Liam Merwick (1):
      KVM: Allow CPU to reschedule while setting per-page memory attributes

Linus Torvalds (1):
      eventpoll: don't decrement ep refcount while still holding the ep mutex

Long Li (1):
      net: mana: Record doorbell physical address in PF mode

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix not disabling advertising instance
      Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected

Lukas Wunner (1):
      crypto: ecdsa - Harden against integer overflows in DIV_ROUND_UP()

Luo Gengkun (1):
      perf/core: Fix the WARN_ON_ONCE is out of lock protected region

Luo Jie (2):
      net: phy: qcom: move the WoL function to shared library
      net: phy: qcom: qca808x: Fix WoL issue by utilizing at8031_set_wol()

Mario Limonciello (1):
      pinctrl: amd: Clear GPIO debounce for suspend

Mark Brown (1):
      arm64: Filter out SME hwcaps when FEAT_SME isn't implemented

Mathy Vanhoef (1):
      wifi: prevent A-MSDU attacks in mesh networks

Matthew Auld (1):
      drm/xe/bmg: fix compressed VRAM handling

Matthew Brost (3):
      drm/sched: Increment job count before swapping tail spsc queue
      Revert "drm/xe/xe2: Enable Indirect Ring State support for Xe2"
      drm/xe: Allocate PF queue size on pow2 boundary

Michael Jeanson (1):
      rseq: Fix segfault on registration when rseq_cs is non-zero

Michael Lo (1):
      wifi: mt76: mt7925: fix invalid array index in ssid assignment during hw scan

Michal Luczaj (3):
      vsock: Fix transport_{g2h,h2g} TOCTOU
      vsock: Fix transport_* TOCTOU
      vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`

Michal Wajdeczko (1):
      drm/xe/pf: Clear all LMTT pages on alloc

Miguel Ojeda (1):
      rust: init: allow `dead_code` warnings for Rust >= 1.89.0

Mikhail Paulyshka (1):
      x86/rdrand: Disable RDSEED on AMD Cyan Skillfish

Mikko Perttunen (1):
      drm/tegra: nvdec: Fix dma_alloc_coherent error check

Ming Yen Hsieh (1):
      wifi: mt76: mt7925: fix the wrong config for tx interrupt

Mingming Cao (1):
      ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof

Nam Cao (1):
      irqchip/irq-msi-lib: Select CONFIG_GENERIC_MSI_IRQ

Namjae Jeon (1):
      ksmbd: fix potential use-after-free in oplock/lease break ack

Nicolas Pitre (1):
      vt: add missing notification when switching back to text mode

Nigel Croxon (1):
      raid10: cleanup memleak at raid10_make_request

Nikunj A Dadhania (1):
      KVM: SVM: Add missing member in SNP_LAUNCH_START command structure

Oleksij Rempel (5):
      net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
      net: phy: smsc: Force predictable MDI-X state on LAN87xx
      net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
      net: phy: microchip: Use genphy_soft_reset() to purge stale LPA bits
      net: phy: microchip: limit 100M workaround to link-down events on LAN88xx

Peter Ujfalusi (1):
      ASoC: Intel: sof-function-topology-lib: Print out the unsupported dmic count

Peter Zijlstra (2):
      sched/core: Fix migrate_swap() vs. hotplug
      perf: Revert to requiring CAP_SYS_ADMIN for uprobes

Petr Machata (1):
      selftests: net: lib: Move logging from forwarding/lib.sh here

Philip Yang (1):
      drm/amdkfd: Don't call mmput from MMU notifier callback

Rafael J. Wysocki (1):
      Revert "ACPI: battery: negate current when discharging"

Richard Fitzgerald (1):
      ASoC: cs35l56: probe() should fail if the device ID is not recognized

Ronnie Sahlberg (1):
      ublk: sanity check add_dev input for underflow

Sascha Hauer (1):
      clk: scmi: Handle case where child clocks are initialized before their parents

Sean Christopherson (1):
      KVM: SVM: Reject SEV{-ES} intra host migration if vCPU creation is in-flight

Sean Nyekjaer (1):
      can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level

Shengjiu Wang (1):
      ASoC: fsl_asrc: use internal measured ratio for non-ideal ratio mode

Shravya KN (1):
      bnxt_en: Fix DCB ETS validation

Shuai Zhang (1):
      driver: bluetooth: hci_qca:fix unable to load the BT driver

Shuicheng Lin (1):
      drm/xe/pm: Correct comment of xe_pm_set_vram_threshold()

Simon Trimmer (2):
      ASoC: Intel: soc-acpi: arl: Correct naming of a cs35l56 address struct
      ASoC: Intel: soc-acpi: arl: Add match entries for new cs42l43 laptops

Simona Vetter (1):
      drm/gem: Fix race in drm_gem_handle_create_tail()

Somnath Kotur (1):
      bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT

Srinivasan Shanmugam (1):
      drm/amdgpu: Replace Mutex with Spinlock for RLCG register access to avoid Priority Inversion in SRIOV

Stefan Metzmacher (1):
      smb: server: make use of rdma_destroy_qp()

Stefano Garzarella (1):
      vsock: fix `vsock_proto` declaration

Takashi Iwai (1):
      ALSA: hda/realtek: Add mic-mute LED setup for ASUS UM5606

Tamura Dai (1):
      ASoC: SOF: Intel: hda: Use devm_kstrdup() to avoid memleak.

Thomas Fourier (1):
      atm: idt77252: Add missing `dma_map_error()`

Thomas Zimmermann (2):
      drm/gem: Acquire references on GEM handles for framebuffers
      drm/framebuffer: Acquire internal references on GEM handles

Thorsten Blum (1):
      ALSA: ad1816a: Fix potential NULL pointer deref in snd_card_ad1816a_pnp()

Tim Crawford (1):
      ALSA: hda/realtek: Add quirks for some Clevo laptops

Tiwei Bie (1):
      um: vector: Reduce stack usage in vector_eth_configure()

Uwe Kleine-König (2):
      pwm: Fix invalid state detection
      pwm: mediatek: Ensure to disable clocks in error path

Victor Nogueira (1):
      net/sched: Abort __tc_modify_qdisc if parent class does not exist

Vitor Soares (1):
      wifi: mwifiex: discard erroneous disassoc frames on STA interface

Wang Jinchao (1):
      md/raid1: Fix stack memory use after return in raid1_reshape

Wei Yang (1):
      maple_tree: fix mt_destroy_walk() on root leaf node

Willem de Bruijn (2):
      bpf: Adjust free target to avoid global starvation of LRU map
      selftests/bpf: adapt one more case in test_lru_map to the new target_free

Xiaolei Wang (1):
      clk: imx: Fix an out-of-bounds access in dispmix_csr_clk_dev_data

Xiaowei Li (1):
      net: usb: qmi_wwan: add SIMCom 8230C composition

Yasmin Fitzgerald (1):
      ALSA: hda/realtek - Enable mute LED on HP Pavilion Laptop 15-eg100

Yazen Ghannam (4):
      x86/mce/amd: Add default names for MCA banks and blocks
      x86/mce/amd: Fix threshold limit reset
      x86/mce: Don't remove sysfs if thresholding sysfs init fails
      x86/mce: Ensure user polling settings are honored when restarting timer

Yeoreum Yun (1):
      kasan: remove kasan_find_vm_area() to prevent possible deadlock

Yue Haibing (1):
      atm: clip: Fix NULL pointer dereference in vcc_sendmsg()

Yuzuru10 (1):
      ASoC: amd: yc: add quirk for Acer Nitro ANV15-41 internal mic

Zhang Heng (1):
      HID: Add IGNORE quirk for SMARTLINKTECHNOLOGY

Zhe Qiao (1):
      Revert "PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()"

Zheng Qixing (1):
      nbd: fix uaf in nbd_genl_connect() error path

kuyo chang (1):
      sched/deadline: Fix dl_server runtime calculation formula


